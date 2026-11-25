import Lean
import Mathlib.Data.Fintype.Powerset
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Set.Finite.Basic
import Mathlib.Tactic.Tauto

/-!
# A finite clique-dually-conformal induced extension of every finite graph

This file proves the complete general construction, not only a list of finite
instances.  `Graph` is the standard undirected loopless relational graph model.
`MaxClique`, `Transversal`, and `MinTransversal` use inclusion, not cardinality.
`CDC` is conformality of the family of all minimal clique transversals, and its
relation to maximal cliques in the co-occurrence graph is proved below.
-/

set_option autoImplicit false

namespace CDCInduced

universe u

structure Graph (V : Type u) where
  Adj : V → V → Prop
  symm : ∀ {x y}, Adj x y → Adj y x
  loopless : ∀ x, ¬ Adj x x

variable {V : Type u}

def Clique (G : Graph V) (S : Set V) : Prop :=
  ∀ ⦃x⦄, x ∈ S → ∀ ⦃y⦄, y ∈ S → x ≠ y → G.Adj x y

def MaxClique (G : Graph V) (S : Set V) : Prop :=
  Clique G S ∧ ∀ T, Clique G T → S ⊆ T → T ⊆ S

def Transversal (G : Graph V) (S : Set V) : Prop :=
  ∀ C, MaxClique G C → ∃ x, x ∈ S ∧ x ∈ C

def MinTransversal (G : Graph V) (S : Set V) : Prop :=
  Transversal G S ∧ ∀ T, Transversal G T → T ⊆ S → S ⊆ T

def Cooccur (G : Graph V) (x y : V) : Prop :=
  ∃ T, MinTransversal G T ∧ x ∈ T ∧ y ∈ T

noncomputable def Dual (G : Graph V) : Graph V where
  Adj x y := x ≠ y ∧ Cooccur G x y
  symm := by
    rintro x y ⟨hxy, T, hT, hx, hy⟩
    exact ⟨Ne.symm hxy, T, hT, hy, hx⟩
  loopless := by intro x h; exact h.1 rfl

/-- Standard hypergraph conformality, applied to the minimal clique transversals. -/
def CDC (G : Graph V) : Prop :=
  ∀ S, Clique (Dual G) S → ∃ T, MinTransversal G T ∧ S ⊆ T

lemma clique_mono {G : Graph V} {S T : Set V}
    (hT : Clique G T) (hST : S ⊆ T) : Clique G S := by
  intro x hx y hy hxy
  exact hT (hST hx) (hST hy) hxy

lemma clique_singleton (G : Graph V) (x : V) : Clique G {x} := by
  intro a ha b hb hab
  have ha' : a = x := ha
  have hb' : b = x := hb
  exact (hab (ha'.trans hb'.symm)).elim

lemma exists_maxClique [Fintype V] (G : Graph V) (S : Set V)
    (hS : Clique G S) : ∃ C, MaxClique G C ∧ S ⊆ C := by
  classical
  let A : Set (Set V) := {T | Clique G T ∧ S ⊆ T}
  obtain ⟨C, hC, hmax⟩ := Set.Finite.exists_maximal_wrt id A
    (Set.toFinite A) ⟨S, hS, Set.Subset.refl S⟩
  refine ⟨C, ⟨hC.1, ?_⟩, hC.2⟩
  intro T hT hCT
  have heq : C = T := hmax T ⟨hT, hC.2.trans hCT⟩ hCT
  exact heq ▸ Set.Subset.refl T

lemma minTransversal_is_dual_clique {G : Graph V} {T : Set V}
    (hT : MinTransversal G T) : Clique (Dual G) T := by
  intro x hx y hy hxy
  exact ⟨hxy, T, hT, hx, hy⟩

lemma cdc_iff_dual_maxClique [Fintype V] (G : Graph V) :
    CDC G ↔ ∀ S, MaxClique (Dual G) S ↔ MinTransversal G S := by
  constructor
  · intro h S
    constructor
    · intro hS
      obtain ⟨T, hT, hST⟩ := h S hS.1
      have hTS := hS.2 T (minTransversal_is_dual_clique hT) hST
      have heq : S = T := Set.Subset.antisymm hST hTS
      exact heq ▸ hT
    · intro hS
      refine ⟨minTransversal_is_dual_clique hS, ?_⟩
      intro T hT hST
      obtain ⟨U, hU, hTU⟩ := h T hT
      exact hTU.trans (hU.2 S hS.1 (hST.trans hTU))
  · intro h S hS
    obtain ⟨C, hC, hSC⟩ := exists_maxClique (Dual G) S hS
    exact ⟨C, (h C).mp hC, hSC⟩

abbrev MC (G : Graph V) := {C : Set V // MaxClique G C}

noncomputable instance mcFintype [Fintype V] (G : Graph V) : Fintype (MC G) :=
  Fintype.ofFinite _

abbrev Vertex (G : Graph V) := V ⊕ (V ⊕ MC G)

def old (G : Graph V) (v : V) : Vertex G := Sum.inl v

def leaf (G : Graph V) (v : V) : Vertex G := Sum.inr (Sum.inl v)

def tip (G : Graph V) (C : MC G) : Vertex G := Sum.inr (Sum.inr C)

noncomputable def extAdj (G : Graph V) (x y : Vertex G) : Prop :=
  Sum.elim
    (fun a => Sum.elim (G.Adj a)
      (Sum.elim (fun b => a = b) (fun C : MC G => a ∈ C.val)) y)
    (Sum.elim
      (fun a => Sum.elim (fun b => a = b) (fun _ => False) y)
      (fun C : MC G => Sum.elim (fun b => b ∈ C.val) (fun _ => False) y)) x

noncomputable def Extension (G : Graph V) : Graph (Vertex G) where
  Adj := extAdj G
  symm := by
    intro x y h
    rcases x with x | (x | C) <;> rcases y with y | (y | D) <;>
      simp only [extAdj, Sum.elim] at h ⊢
    · exact G.symm h
    · exact h.symm
    · exact h
    · exact h.symm
    · exact h
  loopless := by
    intro x
    rcases x with x | (x | C) <;> simp only [extAdj, Sum.elim]
    · exact G.loopless x
    · exact not_false
    · exact not_false

lemma old_injective (G : Graph V) : Function.Injective (old G) := by
  intro a b h
  exact Sum.inl_injective h

@[simp] lemma old_adj_iff (G : Graph V) (a b : V) :
    (Extension G).Adj (old G a) (old G b) ↔ G.Adj a b := Iff.rfl

lemma extension_symmetric (G : Graph V) {x y : Vertex G}
    (h : (Extension G).Adj x y) : (Extension G).Adj y x :=
  (Extension G).symm h

lemma extension_loopless (G : Graph V) (x : Vertex G) :
    ¬ (Extension G).Adj x x := (Extension G).loopless x

lemma extension_card [Fintype V] (G : Graph V) :
    Fintype.card (Vertex G) = 2 * Fintype.card V + Fintype.card (MC G) := by
  simp only [Vertex, Fintype.card_sum]
  omega


/-- The private edge at the original vertex `v`. -/
def pairSet (G : Graph V) (v : V) : Set (Vertex G) := {old G v, leaf G v}

/-- The original maximal clique together with its own simplicial vertex. -/
def cellSet (G : Graph V) (C : MC G) : Set (Vertex G) :=
  insert (tip G C) (old G '' C.val)

@[simp] lemma leaf_adj_iff (G : Graph V) (v : V) (z : Vertex G) :
    (Extension G).Adj (leaf G v) z ↔ z = old G v := by
  rcases z with z | (z | C) <;>
    simp [Extension, extAdj, old, leaf, eq_comm]

@[simp] lemma tip_adj_iff (G : Graph V) (C : MC G) (z : Vertex G) :
    (Extension G).Adj (tip G C) z ↔ z ∈ old G '' C.val := by
  rcases z with z | (z | D) <;>
    simp [Extension, extAdj, old, tip]

lemma old_mem_pair (G : Graph V) (v : V) : old G v ∈ pairSet G v := by
  exact Set.mem_insert _ _

lemma leaf_mem_pair (G : Graph V) (v : V) : leaf G v ∈ pairSet G v := by
  exact Set.mem_insert_of_mem _ (Set.mem_singleton _)

lemma tip_mem_cell (G : Graph V) (C : MC G) : tip G C ∈ cellSet G C := by
  exact Set.mem_insert _ _

lemma pairSet_clique (G : Graph V) (v : V) : Clique (Extension G) (pairSet G v) := by
  intro x hx y hy hxy
  change x = old G v ∨ x = leaf G v at hx
  change y = old G v ∨ y = leaf G v at hy
  rcases hx with rfl | rfl <;> rcases hy with rfl | rfl
  · exact (hxy rfl).elim
  · exact rfl
  · exact rfl
  · exact (hxy rfl).elim

lemma clique_subset_pair {G : Graph V} {S : Set (Vertex G)}
    (hS : Clique (Extension G) S) {v : V} (hv : leaf G v ∈ S) :
    S ⊆ pairSet G v := by
  intro z hz
  by_cases heq : z = leaf G v
  · exact heq ▸ leaf_mem_pair G v
  · have ha := hS hv hz (Ne.symm heq)
    have hzold := (leaf_adj_iff G v z).mp ha
    exact hzold ▸ old_mem_pair G v

lemma pairSet_maxClique (G : Graph V) (v : V) :
    MaxClique (Extension G) (pairSet G v) := by
  refine ⟨pairSet_clique G v, ?_⟩
  intro S hS hsub
  exact clique_subset_pair hS (hsub (leaf_mem_pair G v))

lemma cellSet_clique (G : Graph V) (C : MC G) :
    Clique (Extension G) (cellSet G C) := by
  intro x hx y hy hxy
  rcases hx with rfl | hx <;> rcases hy with rfl | hy
  · exact (hxy rfl).elim
  · exact (tip_adj_iff G C y).mpr hy
  · exact (Extension G).symm ((tip_adj_iff G C x).mpr hx)
  · obtain ⟨a, ha, rfl⟩ := hx
    obtain ⟨b, hb, rfl⟩ := hy
    apply C.property.1 ha hb
    intro hab
    exact hxy (congrArg (old G) hab)

lemma clique_subset_cell {G : Graph V} {S : Set (Vertex G)}
    (hS : Clique (Extension G) S) {C : MC G} (hC : tip G C ∈ S) :
    S ⊆ cellSet G C := by
  intro z hz
  by_cases heq : z = tip G C
  · exact heq ▸ tip_mem_cell G C
  · have ha := hS hC hz (Ne.symm heq)
    exact Set.mem_insert_of_mem _ ((tip_adj_iff G C z).mp ha)

lemma cellSet_maxClique (G : Graph V) (C : MC G) :
    MaxClique (Extension G) (cellSet G C) := by
  refine ⟨cellSet_clique G C, ?_⟩
  intro S hS hsub
  exact clique_subset_cell hS (hsub (tip_mem_cell G C))

lemma clique_has_container [Fintype V] (G : Graph V)
    (S : Set (Vertex G)) (hS : Clique (Extension G) S) :
    (∃ v, S ⊆ pairSet G v) ∨ (∃ C, S ⊆ cellSet G C) := by
  classical
  by_cases hl : ∃ v, leaf G v ∈ S
  · obtain ⟨v, hv⟩ := hl
    exact Or.inl ⟨v, clique_subset_pair hS hv⟩
  · by_cases ht : ∃ C, tip G C ∈ S
    · obtain ⟨C, hC⟩ := ht
      exact Or.inr ⟨C, clique_subset_cell hS hC⟩
    · let X : Set V := {v | old G v ∈ S}
      have hX : Clique G X := by
        intro x hx y hy hxy
        exact hS hx hy (fun heq => hxy (old_injective G heq))
      obtain ⟨C, hC, hXC⟩ := exists_maxClique G X hX
      refine Or.inr ⟨⟨C, hC⟩, ?_⟩
      intro z hz
      rcases z with v | (v | D)
      · exact Set.mem_insert_of_mem _ ⟨v, hXC hz, rfl⟩
      · exact (hl ⟨v, hz⟩).elim
      · exact (ht ⟨D, hz⟩).elim

/-- Complete classification of the maximal cliques in the constructed graph. -/
theorem extension_maxClique_iff [Fintype V] (G : Graph V) (S : Set (Vertex G)) :
    MaxClique (Extension G) S ↔
      (∃ v, S = pairSet G v) ∨ (∃ C, S = cellSet G C) := by
  constructor
  · intro hS
    rcases clique_has_container G S hS.1 with ⟨v, hv⟩ | ⟨C, hC⟩
    · exact Or.inl ⟨v, Set.Subset.antisymm hv (hS.2 _ (pairSet_clique G v) hv)⟩
    · exact Or.inr ⟨C, Set.Subset.antisymm hC (hS.2 _ (cellSet_clique G C) hC)⟩
  · rintro (⟨v, rfl⟩ | ⟨C, rfl⟩)
    · exact pairSet_maxClique G v
    · exact cellSet_maxClique G C


lemma transversal_iff [Fintype V] (G : Graph V) (S : Set (Vertex G)) :
    Transversal (Extension G) S ↔
      (∀ v, old G v ∈ S ∨ leaf G v ∈ S) ∧
      (∀ C : MC G, tip G C ∈ S ∨ ∃ v, v ∈ C.val ∧ old G v ∈ S) := by
  constructor
  · intro hS
    constructor
    · intro v
      obtain ⟨z, hz, hp⟩ := hS (pairSet G v) (pairSet_maxClique G v)
      change z = old G v ∨ z = leaf G v at hp
      rcases hp with rfl | rfl
      · exact Or.inl hz
      · exact Or.inr hz
    · intro C
      obtain ⟨z, hz, hc⟩ := hS (cellSet G C) (cellSet_maxClique G C)
      rcases hc with rfl | hc
      · exact Or.inl hz
      · obtain ⟨v, hv, rfl⟩ := hc
        exact Or.inr ⟨v, hv, hz⟩
  · rintro ⟨hp, hc⟩ K hK
    rcases (extension_maxClique_iff G K).mp hK with ⟨v, rfl⟩ | ⟨C, rfl⟩
    · rcases hp v with hv | hv
      · exact ⟨old G v, hv, old_mem_pair G v⟩
      · exact ⟨leaf G v, hv, leaf_mem_pair G v⟩
    · rcases hc C with hC | ⟨v, hv, hvs⟩
      · exact ⟨tip G C, hC, tip_mem_cell G C⟩
      · exact ⟨old G v, hvs, Set.mem_insert_of_mem _ ⟨v, hv, rfl⟩⟩

/-- The canonical minimal transversal indexed by a subset of the original vertices. -/
def selected (G : Graph V) (X : Set V) : Set (Vertex G)
  | Sum.inl v => v ∈ X
  | Sum.inr (Sum.inl v) => v ∉ X
  | Sum.inr (Sum.inr C) => ∀ v ∈ C.val, v ∉ X

@[simp] lemma old_mem_selected (G : Graph V) (X : Set V) (v : V) :
    old G v ∈ selected G X ↔ v ∈ X := Iff.rfl

@[simp] lemma leaf_mem_selected (G : Graph V) (X : Set V) (v : V) :
    leaf G v ∈ selected G X ↔ v ∉ X := Iff.rfl

@[simp] lemma tip_mem_selected (G : Graph V) (X : Set V) (C : MC G) :
    tip G C ∈ selected G X ↔ ∀ v ∈ C.val, v ∉ X := Iff.rfl

lemma selected_transversal [Fintype V] (G : Graph V) (X : Set V) :
    Transversal (Extension G) (selected G X) := by
  classical
  apply (transversal_iff G _).mpr
  constructor
  · intro v
    exact em (v ∈ X)
  · intro C
    by_cases h : ∃ v, v ∈ C.val ∧ v ∈ X
    · exact Or.inr h
    · left
      intro v hv hx
      exact h ⟨v, hv, hx⟩

/-- Minimality is proved for every subset `X`, with no constraint on the original graph. -/
theorem selected_minTransversal [Fintype V] (G : Graph V) (X : Set V) :
    MinTransversal (Extension G) (selected G X) := by
  refine ⟨selected_transversal G X, ?_⟩
  intro S hS hsub z hz
  obtain ⟨hp, hc⟩ := (transversal_iff G S).mp hS
  rcases z with v | (v | C)
  · rcases hp v with h | h
    · exact h
    · exact ((hsub h) hz).elim
  · rcases hp v with h | h
    · exact (hz (hsub h)).elim
    · exact h
  · rcases hc C with h | ⟨v, hv, hvs⟩
    · exact h
    · exact (hz v hv (hsub hvs)).elim

/-- Every transversal contains the canonical transversal determined by its old vertices. -/
lemma selected_trace_subset [Fintype V] (G : Graph V) (S : Set (Vertex G))
    (hS : Transversal (Extension G) S) :
    selected G {v | old G v ∈ S} ⊆ S := by
  intro z hz
  obtain ⟨hp, hc⟩ := (transversal_iff G S).mp hS
  rcases z with v | (v | C)
  · exact hz
  · rcases hp v with h | h
    · exact (hz h).elim
    · exact h
  · rcases hc C with h | ⟨v, hv, hvs⟩
    · exact h
    · exact (hz v hv hvs).elim

lemma minTransversal_eq_selected [Fintype V] (G : Graph V) (S : Set (Vertex G))
    (hS : MinTransversal (Extension G) S) :
    S = selected G {v | old G v ∈ S} := by
  have hsub := selected_trace_subset G S hS.1
  exact Set.Subset.antisymm (hS.2 _ (selected_transversal G _) hsub) hsub

lemma selected_injective (G : Graph V) : Function.Injective (selected G) := by
  intro X Y hXY
  apply Set.ext
  intro v
  change old G v ∈ selected G X ↔ old G v ∈ selected G Y
  rw [hXY]

/-- Exhaustiveness of the closed-form description of all minimal transversals. -/
theorem extension_minTransversal_iff [Fintype V] (G : Graph V) (S : Set (Vertex G)) :
    MinTransversal (Extension G) S ↔ ∃ X : Set V, S = selected G X := by
  constructor
  · intro hS
    exact ⟨{v | old G v ∈ S}, minTransversal_eq_selected G S hS⟩
  · rintro ⟨X, rfl⟩
    exact selected_minTransversal G X

/-- The indexing subset is unique, as required in the manuscript's Lemma 3. -/
theorem extension_minTransversal_unique [Fintype V] (G : Graph V) (S : Set (Vertex G)) :
    MinTransversal (Extension G) S ↔ ∃! X : Set V, S = selected G X := by
  constructor
  · intro hS
    obtain ⟨X, hX⟩ := (extension_minTransversal_iff G S).mp hS
    refine ⟨X, hX, ?_⟩
    intro Y hY
    exact selected_injective G (hY.symm.trans hX)
  · rintro ⟨X, hX, _⟩
    exact (extension_minTransversal_iff G S).mpr ⟨X, hX⟩


lemma not_cooccur_old_leaf [Fintype V] (G : Graph V) (v : V) :
    ¬ Cooccur (Extension G) (old G v) (leaf G v) := by
  rintro ⟨T, hT, ho, hl⟩
  obtain ⟨X, rfl⟩ := (extension_minTransversal_iff G T).mp hT
  exact hl ho

lemma not_cooccur_old_tip [Fintype V] (G : Graph V) (v : V)
    (C : MC G) (hv : v ∈ C.val) :
    ¬ Cooccur (Extension G) (old G v) (tip G C) := by
  rintro ⟨T, hT, ho, ht⟩
  obtain ⟨X, rfl⟩ := (extension_minTransversal_iff G T).mp hT
  exact ht v hv ho

/-- A clique in the co-occurrence graph extends to the transversal indexed by its old vertices. -/
theorem dual_clique_subset_selected [Fintype V] (G : Graph V)
    (S : Set (Vertex G)) (hS : Clique (Dual (Extension G)) S) :
    S ⊆ selected G {v | old G v ∈ S} := by
  intro z hz
  rcases z with v | (v | C)
  · exact hz
  · intro hv
    have hne : old G v ≠ leaf G v := by
      intro h; cases h
    exact not_cooccur_old_leaf G v (hS hv hz hne).2
  · intro v hv hvs
    have hne : old G v ≠ tip G C := by
      intro h; cases h
    exact not_cooccur_old_tip G v C hv (hS hvs hz hne).2

/-- The complete CDC assertion for the constructed graph. -/
theorem extension_cdc [Fintype V] (G : Graph V) : CDC (Extension G) := by
  intro S hS
  exact ⟨selected G {v | old G v ∈ S}, selected_minTransversal G _,
    dual_clique_subset_selected G S hS⟩

/-- The maximal cliques of the clique-dual are exactly the sets `T_X`. -/
theorem extension_dual_maxClique_iff [Fintype V] (G : Graph V)
    (S : Set (Vertex G)) :
    MaxClique (Dual (Extension G)) S ↔ ∃ X : Set V, S = selected G X := by
  exact ((cdc_iff_dual_maxClique (Extension G)).mp (extension_cdc G) S).trans
    (extension_minTransversal_iff G S)

/-- Explicit equality of the two families in the original paper's definition of CDC. -/
theorem extension_dual_maxClique_iff_minTransversal [Fintype V] (G : Graph V)
    (S : Set (Vertex G)) :
    MaxClique (Dual (Extension G)) S ↔ MinTransversal (Extension G) S :=
  (cdc_iff_dual_maxClique (Extension G)).mp (extension_cdc G) S

/-- An injective map preserving both adjacency and nonadjacency. -/
def InducedEmbedding {W : Type u} (G : Graph V) (H : Graph W) (f : V → W) : Prop :=
  Function.Injective f ∧ ∀ x y, H.Adj (f x) (f y) ↔ G.Adj x y

theorem old_inducedEmbedding (G : Graph V) :
    InducedEmbedding G (Extension G) (old G) :=
  ⟨old_injective G, old_adj_iff G⟩

theorem extension_nonempty [Nonempty V] (G : Graph V) : Nonempty (Vertex G) := by
  obtain ⟨v⟩ := ‹Nonempty V›
  exact ⟨old G v⟩

/-- Theorem 1: a concrete finite CDC induced extension, including its exact vertex count. -/
theorem every_finite_graph_has_cdc_induced_extension [Fintype V] (G : Graph V) :
    ∃ H : Graph (Vertex G), CDC H ∧ InducedEmbedding G H (old G) ∧
      Fintype.card (Vertex G) = 2 * Fintype.card V + Fintype.card (MC G) := by
  exact ⟨Extension G, extension_cdc G, old_inducedEmbedding G, extension_card G⟩

abbrev MinimalTransversals (G : Graph V) :=
  {T : Set (Vertex G) // MinTransversal (Extension G) T}

noncomputable instance minimalTransversalsFintype [Fintype V] (G : Graph V) :
    Fintype (MinimalTransversals G) := Fintype.ofFinite _

/-- A bijection with all subsets of the original vertex set. -/
noncomputable def minimalTransversalsEquiv [Fintype V] (G : Graph V) :
    Set V ≃ MinimalTransversals G where
  toFun X := ⟨selected G X, selected_minTransversal G X⟩
  invFun T := {v | old G v ∈ T.val}
  left_inv X := rfl
  right_inv T := by
    apply Subtype.ext
    exact (minTransversal_eq_selected G T.val T.property).symm

theorem minimalTransversals_card [Fintype V] (G : Graph V) :
    Fintype.card (MinimalTransversals G) = 2 ^ Fintype.card V := by
  rw [← Fintype.card_congr (minimalTransversalsEquiv G)]
  exact Fintype.card_set

/-- The complete graph, used only for an explicit non-triangle-free test instance. -/
noncomputable def completeGraph (V : Type u) : Graph V where
  Adj x y := x ≠ y
  symm := Ne.symm
  loopless := fun _ h => h rfl

lemma complete_univ_clique (V : Type u) : Clique (completeGraph V) Set.univ := by
  intro x hx y hy hxy
  exact hxy

lemma complete_univ_maxClique (V : Type u) : MaxClique (completeGraph V) Set.univ := by
  exact ⟨complete_univ_clique V, fun _ _ _ => Set.subset_univ _⟩

lemma complete_maxClique_iff (S : Set V) :
    MaxClique (completeGraph V) S ↔ S = Set.univ := by
  constructor
  · intro hS
    exact Set.Subset.antisymm (Set.subset_univ S)
      (hS.2 Set.univ (complete_univ_clique V) (Set.subset_univ S))
  · rintro rfl
    exact complete_univ_maxClique V

noncomputable instance completeMCUnique : Unique (MC (completeGraph V)) where
  default := ⟨Set.univ, complete_univ_maxClique V⟩
  uniq C := by
    apply Subtype.ext
    exact (complete_maxClique_iff C.val).mp C.property

lemma complete_maxClique_card [Fintype V] : Fintype.card (MC (completeGraph V)) = 1 :=
  Fintype.card_unique

/-- A seven-vertex extension of the triangle; this is outside the prior triangle-free scope. -/
theorem triangle_extension_card : Fintype.card (Vertex (completeGraph (Fin 3))) = 7 := by
  rw [extension_card, complete_maxClique_card]
  decide

theorem triangle_extension_cdc : CDC (Extension (completeGraph (Fin 3))) :=
  extension_cdc _

theorem triangle_original_edges :
    (Extension (completeGraph (Fin 3))).Adj
      (old (completeGraph (Fin 3)) 0) (old (completeGraph (Fin 3)) 1) ∧
    (Extension (completeGraph (Fin 3))).Adj
      (old (completeGraph (Fin 3)) 1) (old (completeGraph (Fin 3)) 2) ∧
    (Extension (completeGraph (Fin 3))).Adj
      (old (completeGraph (Fin 3)) 0) (old (completeGraph (Fin 3)) 2) := by
  change (0 : Fin 3) ≠ 1 ∧ (1 : Fin 3) ≠ 2 ∧ (0 : Fin 3) ≠ 2
  decide

end CDCInduced


-- Collect dependencies of all declarations created in this module, including compiler auxiliaries.
open Lean in
run_cmd do
  let env ← getEnv
  let mut entries : Array (String × Array String) := #[]
  for (name, _) in env.constants.map₂.toList do
    let axioms ← Lean.collectAxioms name
    entries := entries.push (name.toString, axioms.map Name.toString)
  logInfo m!"EDEG_KERNEL_AXIOMS: {(toJson entries).compress}"
