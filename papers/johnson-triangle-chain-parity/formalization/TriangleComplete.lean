import TriangleEven
import TriangleOdd

namespace Review15Johnson
open Finset
variable {α : Type*} [DecidableEq α]

/-- Every representation in the model uses a finite ground set, even though
    the ambient type is unrestricted. No infinite-ground relaxation is used. -/
noncomputable def representationGround {n : ℕ} (R : ClosedChainRep n α) : Finset α :=
  R.extra ∪ (range n).biUnion R.chain

theorem chain_subset_ground {n : ℕ} (R : ClosedChainRep n α) {j : ℕ} (hj : j < n) :
    R.chain j ⊆ representationGround R := by
  intro x hx
  apply mem_union.mpr
  right
  exact mem_biUnion.mpr ⟨j,mem_range.mpr hj,hx⟩

theorem extra_subset_ground {n : ℕ} (R : ClosedChainRep n α) :
    R.extra ⊆ representationGround R := by
  exact subset_union_left

theorem rank_le_ground_card {n : ℕ} (R : ClosedChainRep n α) :
    R.k ≤ (representationGround R).card := by
  rw [← R.card_extra]
  exact card_le_card (extra_subset_ground R)

theorem ground_subset_of_labels {n : ℕ} (R : ClosedChainRep n α) (U : Finset α)
    (he : R.extra ⊆ U) (hc : ∀ j, j < n → R.chain j ⊆ U) :
    representationGround R ⊆ U := by
  intro x hx
  rcases mem_union.mp hx with hx | hx
  · exact he hx
  · obtain ⟨j,hj,hx⟩ := mem_biUnion.mp hx
    exact hc j (mem_range.mp hj) hx

theorem bigRep_ground_bound (m : ℕ) (hm : 3 ≤ m) :
    (representationGround (bigRep m hm)).card ≤ m+3 := by
  have hsub : representationGround (bigRep m hm) ⊆ range (m+3) := by
    apply ground_subset_of_labels
    · intro x hx
      change x ∈ bigExtra m at hx
      simp only [bigExtra, mem_insert, mem_singleton] at hx
      simp only [mem_range]
      omega
    · intro j hj x hx
      change x ∈ bigChain m j at hx
      unfold bigChain bigO bigE at hx
      split_ifs at hx
      all_goals simp only [mem_insert, mem_singleton] at hx
      all_goals simp only [mem_range]
      all_goals omega
  simpa only [card_range] using card_le_card hsub

theorem oneRep_ground_bound : (representationGround oneRep).card ≤ 4 := by
  have hsub : representationGround oneRep ⊆ range 4 := by
    apply ground_subset_of_labels
    · decide
    · intro j hj
      have h : j=0 ∨ j=1 ∨ j=2 := by omega
      rcases h with rfl | rfl | rfl <;> decide
  simpa only [card_range] using card_le_card hsub

theorem twoRep_ground_bound : (representationGround twoRep).card ≤ 5 := by
  have hsub : representationGround twoRep ⊆ range 5 := by
    apply ground_subset_of_labels
    · decide
    · intro j hj
      have h : j=0 ∨ j=1 ∨ j=2 ∨ j=3 ∨ j=4 := by omega
      rcases h with rfl | rfl | rfl | rfl | rfl <;> decide
  simpa only [card_range] using card_le_card hsub

/-- The explicit constructions use at most m+2 cyclic coordinates and one
    exterior coordinate, including both exceptional rank-two cases. -/
theorem odd_rep_ground_bound (m : ℕ) (hm : 1 ≤ m) :
    ∃ R : ClosedChainRep (2*m+1) ℕ,
      R.k = (if m ≤ 2 then 2 else 3) ∧ (representationGround R).card ≤ m+3 := by
  by_cases h : m ≤ 2
  · have hh : m=1 ∨ m=2 := by omega
    rcases hh with rfl | rfl
    · exact ⟨oneRep, rfl, oneRep_ground_bound⟩
    · exact ⟨twoRep, rfl, twoRep_ground_bound⟩
  · exact ⟨bigRep m (by omega), by simp [bigRep,h], bigRep_ground_bound m (by omega)⟩

/-- Delta_i is the graph in the manuscript: i+2 chain vertices and the extra
    endpoint-joining vertex. An explicit finite Nat-labelled ground set is enough
    for the existence direction; nonexistence below covers every ambient type. -/
def DeltaRepresentable (i : ℕ) : Prop := Nonempty (ClosedChainRep (i+2) ℕ)

theorem delta_even_excluded (i : ℕ) (hi : 0 < i) (he : i % 2 = 0)
    (R : ClosedChainRep (i+2) α) : False := by
  exact even_chain_not_representable (by omega) (by omega) R

theorem delta_rank_achieved (i : ℕ) (hi : 0 < i) (ho : i % 2 = 1) :
    ∃ R : ClosedChainRep (i+2) ℕ, R.k = (if i = 1 ∨ i = 3 then 2 else 3) := by
  let m := (i+1)/2
  have hm : 1 ≤ m := by dsimp [m]; omega
  have hn : 2*m+1 = i+2 := by dsimp [m]; omega
  have hs : (m ≤ 2) ↔ (i = 1 ∨ i = 3) := by dsimp [m]; omega
  have hrep : ∃ R : ClosedChainRep (i+2) ℕ,
      R.k = (if m ≤ 2 then 2 else 3) := by
    rw [← hn]
    exact odd_rep m hm
  simpa only [hs] using hrep

/-- Full positive-integer classification, not a bounded enumeration. -/
theorem delta_classification (i : ℕ) (hi : 0 < i) :
    DeltaRepresentable i ↔ i % 2 = 1 := by
  constructor
  · rintro ⟨R⟩
    by_contra hn
    have he : i%2 = 0 := by omega
    exact delta_even_excluded i hi he R
  · intro ho
    obtain ⟨R,_⟩ := delta_rank_achieved i hi ho
    exact ⟨R⟩

/-- Universal rank lower bound over every ground type and every representation. -/
theorem delta_rank_lower_bound (i : ℕ) (hi : 0 < i) (ho : i % 2 = 1)
    (R : ClosedChainRep (i+2) α) :
    (if i = 1 ∨ i = 3 then 2 else 3) ≤ R.k := by
  by_cases hs : i = 1 ∨ i = 3
  · simp only [if_pos hs]
    exact closed_chain_rank_ge_two R (by omega)
  · simp only [if_neg hs]
    exact closed_chain_rank_ge_three R (by omega)

/-- Achievability plus a lower bound for every uniform finite-set representation
    is the exact-minimum assertion, without assuming a minimizer exists. -/
theorem delta_exact_minimum_rank (i : ℕ) (hi : 0 < i) (ho : i % 2 = 1) :
    (∃ R : ClosedChainRep (i+2) ℕ, R.k = (if i = 1 ∨ i = 3 then 2 else 3)) ∧
    (∀ R : ClosedChainRep (i+2) α, (if i = 1 ∨ i = 3 then 2 else 3) ≤ R.k) := by
  exact ⟨delta_rank_achieved i hi ho, fun R => delta_rank_lower_bound i hi ho R⟩

#print axioms delta_even_excluded
#print axioms delta_classification
#print axioms delta_rank_achieved
#print axioms delta_rank_lower_bound
#print axioms delta_exact_minimum_rank
#print axioms rank_le_ground_card
#print axioms odd_rep_ground_bound
end Review15Johnson
