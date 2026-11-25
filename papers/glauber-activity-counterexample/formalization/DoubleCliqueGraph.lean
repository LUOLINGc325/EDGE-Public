import RegularGlauber
import Mathlib.Combinatorics.SimpleGraph.Operations

open scoped BigOperators

namespace GlauberAnnealing
namespace DoubleClique

abbrev Vertex (d : ℕ) := Bool × Fin (d + 1)

noncomputable def first (d : ℕ) (high : Bool) : Fin (d + 1) :=
  if high then 0 else ⟨d - 1, by omega⟩

noncomputable def second (d : ℕ) (high : Bool) : Fin (d + 1) :=
  if high then ⟨min 1 d, by omega⟩ else ⟨d, by omega⟩

@[simp] theorem first_low_val (d : ℕ) : (first d false).val = d - 1 := rfl
@[simp] theorem second_low_val (d : ℕ) : (second d false).val = d := rfl
@[simp] theorem first_high_val (d : ℕ) : (first d true).val = 0 := rfl
@[simp] theorem second_high_val (d : ℕ) : (second d true).val = min 1 d := rfl

theorem endpoints_ne {d : ℕ} (hd : 3 ≤ d) (b : Bool) : first d b ≠ second d b := by
  intro he
  have h := congrArg Fin.val he
  cases b <;> simp at h <;> omega

def removed {d : ℕ} (b : Bool) (i j : Fin (d + 1)) : Prop :=
  (i = first d b ∧ j = second d b) ∨ (i = second d b ∧ j = first d b)

theorem removed_comm {d : ℕ} (b : Bool) (i j : Fin (d + 1)) :
    removed b i j ↔ removed b j i := by
  unfold removed
  aesop

def matching {d : ℕ} (u v : Vertex d) : Prop :=
  (u.2 = first d u.1 ∧ v.2 = first d v.1) ∨
  (u.2 = second d u.1 ∧ v.2 = second d v.1)

theorem matching_comm {d : ℕ} (u v : Vertex d) :
    matching u v ↔ matching v u := by
  unfold matching
  simp only [and_comm]

open Classical in
def adjacent {d : ℕ} (u v : Vertex d) : Prop :=
  if u.1 = v.1 then u.2 ≠ v.2 ∧ ¬removed u.1 u.2 v.2 else matching u v

noncomputable def graph (d : ℕ) : SimpleGraph (Vertex d) where
  Adj := adjacent
  symm := by
    rintro ⟨s, i⟩ ⟨t, j⟩ h
    by_cases hst : s = t
    · subst t
      have h' : i ≠ j ∧ ¬removed s i j := by simpa only [adjacent, if_pos rfl] using h
      simpa only [adjacent, if_pos rfl] using
        (show j ≠ i ∧ ¬removed s j i from ⟨Ne.symm h'.1, fun hr => h'.2 ((removed_comm s j i).1 hr)⟩)
    · simpa only [adjacent, if_neg (Ne.symm hst)] using
        (matching_comm (s, i) (t, j)).1 (by simpa only [adjacent, if_neg hst] using h)
  loopless := by
    intro u
    simp [adjacent]

noncomputable def atSide {d : ℕ} (b : Bool) : Fin (d+1) ↪ Vertex d where
  toFun i := (b, i)
  inj' := fun _ _ h => congrArg Prod.snd h

@[simp] theorem atSide_apply {d : ℕ} (b : Bool) (i : Fin (d + 1)) :
    atSide b i = (b, i) := rfl

theorem mem_side_map {d : ℕ} (b c : Bool) (i : Fin (d + 1)) (A : Finset (Fin (d + 1))) :
    (c, i) ∈ A.map (atSide b) ↔ c = b ∧ i ∈ A := by
  rw [Finset.mem_map]
  constructor
  · rintro ⟨j, hj, h⟩
    have hji : j = i := congrArg Prod.snd h
    exact ⟨(congrArg Prod.fst h).symm, hji ▸ hj⟩
  · rintro ⟨h, hi⟩
    subst c
    exact ⟨i, hi, rfl⟩

theorem not_side (b : Bool) : (!b) ≠ b := by
  cases b <;> decide

theorem other_side_of_ne {a b : Bool} (h : a ≠ b) : a = !b := by
  cases a <;> cases b <;> simp_all

theorem neighbors_first {d : ℕ} (hd : 3 ≤ d) (b : Bool) :
    neighbors (graph d) (b, first d b) =
      ((Finset.univ.erase (first d b)).erase (second d b)).map (atSide b) ∪
        {( !b, first d (!b))} := by
  classical
  ext p
  rcases p with ⟨s, j⟩
  by_cases hsb : s = b
  · subst s
    simp [mem_neighbors, graph, adjacent, removed, mem_side_map,
      endpoints_ne hd b, ne_comm, and_comm, Ne.symm (not_side b)]
  · have hs : s = !b := other_side_of_ne hsb
    subst s
    simp [mem_neighbors, graph, adjacent, matching, mem_side_map, hsb, Ne.symm hsb,
      endpoints_ne hd b]

theorem neighbors_second {d : ℕ} (hd : 3 ≤ d) (b : Bool) :
    neighbors (graph d) (b, second d b) =
      ((Finset.univ.erase (second d b)).erase (first d b)).map (atSide b) ∪
        {(!b, second d (!b))} := by
  classical
  ext p
  rcases p with ⟨s, j⟩
  by_cases hsb : s = b
  · subst s
    simp [mem_neighbors, graph, adjacent, removed, mem_side_map,
      Ne.symm (endpoints_ne hd b), ne_comm, and_comm, Ne.symm (not_side b)]
  · have hs : s = !b := other_side_of_ne hsb
    subst s
    simp [mem_neighbors, graph, adjacent, matching, mem_side_map, hsb, Ne.symm hsb,
      Ne.symm (endpoints_ne hd b)]

theorem neighbors_away {d : ℕ} (b : Bool) (i : Fin (d + 1))
    (h₁ : i ≠ first d b) (h₂ : i ≠ second d b) :
    neighbors (graph d) (b, i) = (Finset.univ.erase i).map (atSide b) := by
  classical
  ext p
  rcases p with ⟨s, j⟩
  by_cases hsb : s = b
  · subst s
    simp [mem_neighbors, graph, adjacent, removed, mem_side_map, h₁, h₂, ne_comm]
  · simp [mem_neighbors, graph, adjacent, matching, mem_side_map, hsb, Ne.symm hsb, h₁, h₂]

theorem replaced_edge_count {d : ℕ} (b : Bool) (i j k : Fin (d + 1)) (hij : i ≠ j) :
    (((Finset.univ.erase i).erase j).map (atSide b) ∪ {(!b, k)}).card = d := by
  classical
  have hdis : Disjoint (((Finset.univ.erase i).erase j).map (atSide b)) {(!b, k)} := by
    rw [Finset.disjoint_singleton_right]
    simp [mem_side_map, not_side b]
  rw [Finset.card_union_of_disjoint hdis, Finset.card_singleton, Finset.card_map]
  rw [Finset.card_erase_add_one (by simp [Ne.symm hij]), Finset.card_erase_of_mem (Finset.mem_univ _)]
  simp

theorem graph_regular {d : ℕ} (hd : 3 ≤ d) (v : Vertex d) :
    (neighbors (graph d) v).card = d := by
  obtain ⟨b, i⟩ := v
  by_cases h₁ : i = first d b
  · subst i
    rw [neighbors_first hd]
    exact replaced_edge_count b _ _ _ (endpoints_ne hd b)
  by_cases h₂ : i = second d b
  · subst i
    rw [neighbors_second hd]
    exact replaced_edge_count b _ _ _ (Ne.symm (endpoints_ne hd b))
  rw [neighbors_away b i h₁ h₂, Finset.card_map, Finset.card_erase_of_mem (Finset.mem_univ _)]
  simp

noncomputable def model (d : ℕ) (hd : 3 ≤ d) : RegularGraph (Vertex d) where
  graph := graph d
  degree := d
  degree_pos := by omega
  card_neighbors := graph_regular hd

noncomputable def anchor (d : ℕ) (b : Bool) : Fin (d + 1) :=
  ⟨if b then min 2 d else 0, by split_ifs <;> omega⟩

theorem anchor_ne_first {d : ℕ} (hd : 3 ≤ d) (b : Bool) : anchor d b ≠ first d b := by
  intro he
  have h := congrArg Fin.val he
  cases b <;> simp [anchor] at h <;> omega

theorem anchor_ne_second {d : ℕ} (hd : 3 ≤ d) (b : Bool) : anchor d b ≠ second d b := by
  intro he
  have h := congrArg Fin.val he
  cases b <;> simp [anchor] at h <;> omega

theorem reachable_in_side {d : ℕ} (hd : 3 ≤ d) (b : Bool) (i j : Fin (d+1)) :
    (graph d).Reachable (b, i) (b, j) := by
  have hor (k : Fin (d + 1)) : (graph d).Reachable (b, k) (b, anchor d b) := by
    by_cases hk : k = anchor d b
    · subst k
      exact SimpleGraph.Reachable.refl _
    have hAdj : (graph d).Adj (b, k) (b, anchor d b) := by
      simp [graph, adjacent, removed, hk, anchor_ne_first hd, anchor_ne_second hd]
    exact hAdj.reachable
  exact (hor i).trans (hor j).symm

theorem actual_graph_connected {d : ℕ} (hd : 3 ≤ d) : (graph d).Connected := by
  classical
  have hc : (graph d).Adj (false, first d false) (true, first d true) := by
    simp [graph, adjacent, matching]
  refine ⟨?_⟩
  rintro ⟨a, i⟩ ⟨b, j⟩
  by_cases h : a = b
  · subst b
    exact reachable_in_side hd a i j
  have hbridge : (graph d).Reachable (a, first d a) (b, first d b) := by
    cases a <;> cases b
    · exact (h rfl).elim
    · exact hc.reachable
    · exact hc.symm.reachable
    · exact (h rfl).elim
  exact ((reachable_in_side hd a i (first d a)).trans hbridge).trans
    (reachable_in_side hd b (first d b) j)

theorem vertex_count (d : ℕ) : Fintype.card (Vertex d) = 2 * (d + 1) := by
  simp [Vertex]

end DoubleClique
end GlauberAnnealing
