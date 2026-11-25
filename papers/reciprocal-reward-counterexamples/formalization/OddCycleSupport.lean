import FractionalMatchingStructure
import Mathlib.Combinatorics.SimpleGraph.Matching

/-! Every nontrivial residual component is an odd cycle. An even closed
trail would produce a nonzero feasible alternating perturbation. -/

set_option autoImplicit false
open Finset
open scoped Sym2

namespace ReciprocalSearch.SimpleEdges
noncomputable section
open Classical
variable {E V : Type*}

def edgePair (g : SimpleEdges E V) (e : E) : Sym2 V :=
  let h := card_eq_two.mp (g.card_ends e)
  s(h.choose, h.choose_spec.choose)

lemma mem_edgePair (g : SimpleEdges E V) (e : E) (v : V) :
    v ∈ g.edgePair e ↔ v ∈ g.ends e := by
  let h := card_eq_two.mp (g.card_ends e)
  change v ∈ s(h.choose, h.choose_spec.choose) ↔ v ∈ g.ends e
  calc
    _ ↔ v ∈ ({h.choose, h.choose_spec.choose} : Finset V) := by
      rw [Sym2.mem_iff, mem_insert, mem_singleton]
    _ ↔ _ := Iff.of_eq (congrArg (fun F : Finset V => v ∈ F) h.choose_spec.choose_spec.2.symm)

lemma edgePair_notDiag (g : SimpleEdges E V) (e : E) : ¬(g.edgePair e).IsDiag := by
  let h := card_eq_two.mp (g.card_ends e)
  change ¬(s(h.choose, h.choose_spec.choose)).IsDiag
  exact fun hdiag => h.choose_spec.choose_spec.1 (Sym2.mk_isDiag_iff.mp hdiag)

lemma edgePair_injective (g : SimpleEdges E V) : Function.Injective g.edgePair := by
  intro a b hab
  apply g.ends_injective
  ext v
  rw [← g.mem_edgePair a v, ← g.mem_edgePair b v, hab]

noncomputable def supportGraph (g : SimpleEdges E V) (r : Finset E) : SimpleGraph V :=
  SimpleGraph.fromEdgeSet (g.edgePair '' (r : Set E))

lemma support_graph_edges (g : SimpleEdges E V) (r : Finset E) :
    (g.supportGraph r).edgeSet = g.edgePair '' (r : Set E) := by
  rw [supportGraph, SimpleGraph.edgeSet_fromEdgeSet]
  ext z
  constructor
  · exact And.left
  · rintro ⟨a, ha, rfl⟩
    exact ⟨⟨a, ha, rfl⟩, g.edgePair_notDiag a⟩

def edgeOfAdj (g : SimpleEdges E V) (r : Finset E) {u v : V}
    (h : (g.supportGraph r).Adj u v) : E :=
  (((SimpleGraph.fromEdgeSet_adj (g.edgePair '' (r : Set E))).mp h).1).choose

lemma edge_of_adj_pair (g : SimpleEdges E V) (r : Finset E) {u v : V}
    (h : (g.supportGraph r).Adj u v) : g.edgePair (g.edgeOfAdj r h) = s(u, v) :=
  (((SimpleGraph.fromEdgeSet_adj (g.edgePair '' (r : Set E))).mp h).1).choose_spec.2

lemma edge_of_adj_mem (g : SimpleEdges E V) (r : Finset E) {u v : V}
    (h : (g.supportGraph r).Adj u v) : g.edgeOfAdj r h ∈ r :=
  (((SimpleGraph.fromEdgeSet_adj (g.edgePair '' (r : Set E))).mp h).1).choose_spec.1

variable [Fintype E] [Fintype V]

omit [Fintype E] in
lemma support_incidence_card (g : SimpleEdges E V) (r : Finset E) (v : V) :
    (g.supportGraph r).degree v = g.degree r v := by
  let H := g.supportGraph r
  haveI : Fintype H.edgeSet := Fintype.ofFinite _
  have ht : H.incidenceFinset v =
      (r.filter fun a => v ∈ g.ends a).map ⟨g.edgePair, g.edgePair_injective⟩ := by
    ext z
    rw [SimpleGraph.incidenceFinset_eq_filter, mem_filter, SimpleGraph.mem_edgeFinset,
      g.support_graph_edges r, mem_map]
    constructor
    · rintro ⟨⟨a, ha, rfl⟩, hz⟩
      exact ⟨a, mem_filter.mpr ⟨ha, (g.mem_edgePair a v).mp hz⟩, rfl⟩
    · rintro ⟨a, ha, rfl⟩
      exact ⟨⟨a, (mem_filter.mp ha).1, rfl⟩, (g.mem_edgePair a v).mpr (mem_filter.mp ha).2⟩
  change H.degree v = _
  rw [← H.card_incidenceFinset_eq_degree, ht, card_map, degree]

def edgeBasis (e : E) : E → ℝ := fun a => if a = e then 1 else 0

omit [Fintype V] in
lemma load_basis (g : SimpleEdges E V) (e : E) (v : V) :
    g.load (edgeBasis e) v = g.incidence v e := by
  unfold load Active.row edgeBasis
  rw [sum_eq_single e]
  · simp
  · intro a _ ha
    simp [ha]
  · simp

omit [Fintype E] [Fintype V] in
noncomputable def alternatingWalk (g : SimpleEdges E V) (r : Finset E) :
    {u v : V} → (g.supportGraph r).Walk u v → E → ℝ
  | _, _, .nil => 0
  | _, _, .cons h p => edgeBasis (g.edgeOfAdj r h) - g.alternatingWalk r p

omit [Fintype V] in
lemma adjacent_basis_load (g : SimpleEdges E V) (r : Finset E) {u v : V}
    (h : (g.supportGraph r).Adj u v) (z : V) :
    g.load (edgeBasis (g.edgeOfAdj r h)) z =
      (if z = u then 1 else 0) + (if z = v then 1 else 0) := by
  rw [g.load_basis]
  have huv := ((SimpleGraph.fromEdgeSet_adj (g.edgePair '' (r : Set E))).mp h).2
  have hmem : z ∈ g.ends (g.edgeOfAdj r h) ↔ z = u ∨ z = v := by
    rw [← g.mem_edgePair, g.edge_of_adj_pair r h, Sym2.mem_iff]
  by_cases hu : z = u
  · have hv : z ≠ v := hu ▸ huv
    rw [incidence, if_pos (hmem.mpr (Or.inl hu)), if_pos hu, if_neg hv, add_zero]
  · by_cases hv : z = v
    · rw [incidence, if_pos (hmem.mpr (Or.inr hv)), if_neg hu, if_pos hv, zero_add]
    · have hn : z ∉ g.ends (g.edgeOfAdj r h) := fun he => (hmem.mp he).elim hu hv
      simp [incidence, hn, hu, hv]

omit [Fintype V] in
lemma alternating_walk_load (g : SimpleEdges E V) (r : Finset E) {u v : V}
    (p : (g.supportGraph r).Walk u v) (z : V) :
    g.load (g.alternatingWalk r p) z =
      (if z = u then 1 else 0) - (-1 : ℝ) ^ p.length * (if z = v then 1 else 0) := by
  have hsub (x y : E → ℝ) : g.load (x-y) z = g.load x z - g.load y z := by
    simp [load, Active.row, Pi.sub_apply, mul_sub, sum_sub_distrib]
  induction p with
  | nil => simp [alternatingWalk, load, Active.row]
  | cons h p ih =>
    rw [alternatingWalk, hsub, g.adjacent_basis_load r h z, ih,
      SimpleGraph.Walk.length_cons, pow_succ]
    ring

omit [Fintype E] [Fintype V] in
lemma alternating_walk_off_edges (g : SimpleEdges E V) (r : Finset E) {u v : V}
    (p : (g.supportGraph r).Walk u v) (a : E) (ha : g.edgePair a ∉ p.edges) :
    g.alternatingWalk r p a = 0 := by
  induction p with
  | nil => rfl
  | cons h p ih =>
    simp only [SimpleGraph.Walk.edges_cons, List.mem_cons, not_or] at ha
    have hne : a ≠ g.edgeOfAdj r h := fun he => ha.1 (he ▸ g.edge_of_adj_pair r h)
    simp [alternatingWalk, edgeBasis, hne, ih ha.2]

lemma residual_cycle_odd (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ (g.matchingFeasible).extremePoints ℝ) {u : V}
    (p : (g.supportGraph (residualEdges x)).Walk u u) (hp : p.IsCycle) :
    Odd p.length := by
  let R := residualEdges x
  have hnot : ¬Even p.length := by
    intro he
    have hsign : (-1 : ℝ) ^ p.length = 1 := by
      obtain ⟨k, hk⟩ := he
      rw [hk, ← two_mul, pow_mul]
      norm_num
    have hzero := Active.extreme_direction_zero hx (g.alternatingWalk R p)
      (fun a ha => by
        apply g.alternating_walk_off_edges
        intro hmem
        have he := p.edges_subset_edgeSet hmem
        rw [g.support_graph_edges] at he
        obtain ⟨b, hb, heb⟩ := he
        have hba := g.edgePair_injective heb
        subst b
        have hpos : 0 < x a := (mem_filter.mp hb).2.1
        linarith)
      (fun v _ => by
        change g.load (g.alternatingWalk R p) v = 0
        rw [g.alternating_walk_load, hsign, one_mul, sub_self])
    cases p with
    | nil =>
      have hh := hp.three_le_length
      simp at hh
    | cons h p =>
      have hf := (SimpleGraph.Walk.cons_isTrail_iff h p).mp hp.isTrail
      have hmem : g.edgePair (g.edgeOfAdj R h) ∉ p.edges := by
        rw [g.edge_of_adj_pair R h]
        exact hf.2
      have hh := congrFun hzero (g.edgeOfAdj R h)
      simp [alternatingWalk, edgeBasis, g.alternating_walk_off_edges R p _ hmem] at hh
  exact Nat.not_even_iff_odd.mp hnot

theorem extreme_residual_components_odd_cycles (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible.extremePoints ℝ)
    (c : (g.supportGraph (residualEdges x)).ConnectedComponent) {v : V}
    (hv : v ∈ c.supp) (hn : ((g.supportGraph (residualEdges x)).neighborSet v).Nonempty) :
    ∃ p : (g.supportGraph (residualEdges x)).Walk v v,
      p.IsCycle ∧ Odd p.length ∧ p.toSubgraph.verts = c.supp := by
  let R := residualEdges x
  let H := g.supportGraph R
  have hc : H.IsCycles := by
    intro w ⟨z, hz⟩
    have hp : 0 < H.degree w := (H.degree_pos_iff_exists_adj w).mpr ⟨z, hz⟩
    have hd := g.support_incidence_card R w
    have hp' : 0 < g.degree R w := by rw [← hd]; exact hp
    have hneq : g.degree R w ≠ 0 := Nat.ne_of_gt hp'
    have he := (g.extreme_residual_degrees x hx w).resolve_left hneq
    have hn : (H.neighborSet w).ncard = H.degree w := by
      rw [Set.ncard_eq_toFinset_card']
      exact H.card_neighborFinset_eq_degree w
    rw [hn, hd, he.1]
  obtain ⟨p, hp, he⟩ := hc.exists_cycle_toSubgraph_verts_eq_connectedComponentSupp hv hn
  exact ⟨p, hp, g.residual_cycle_odd x hx p hp, he⟩

end
end ReciprocalSearch.SimpleEdges

#print axioms ReciprocalSearch.SimpleEdges.extreme_residual_weight_half
#print axioms ReciprocalSearch.SimpleEdges.extreme_residual_components_odd_cycles
