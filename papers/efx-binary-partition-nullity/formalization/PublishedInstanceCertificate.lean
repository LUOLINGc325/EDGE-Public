import BitMaskProjection
import PublishedInstanceSearchReplay
import PublishedInstanceSearchSound

namespace TwoColorNullity.PublishedInstance

/-- An attaining coordinate mask for each size from one through seventeen. -/
def attainingMask : Fin 17 → ℕ :=
  ![1, 3, 19, 156, 9253, 4817, 8989, 50794, 50922, 27447, 54895, 54911,
    55039, 16383, 32767, 65535, 131071]

set_option maxRecDepth 16384 in
set_option maxHeartbeats 4000000 in
private theorem attainingMask_checked (index : Fin 17) :
    let owners := maskCoordinates 18 (attainingMask index)
    owners.card = index.val + 1 ∧
      bucketScore (refineAlong (selectedCoordinates owners) [searchedWords]) = sizeBound (index.val + 1) := by
  fin_cases index <;> decide +kernel

theorem exact_maximum_by_size (s : ℕ) (hpos : 1 ≤ s) (hlt : s ≤ 17) :
    (∀ owners : Finset (Fin 18), owners.card = s → pairCapacity tags owners ≤ sizeBound s) ∧
      ∃ owners : Finset (Fin 18), owners.card = s ∧ pairCapacity tags owners = sizeBound s := by
  refine ⟨fun owners hcard => ?_, ?_⟩
  · rw [← hcard]
    exact search_bound_for_every_owner_set owners checked_search
  · let index : Fin 17 := ⟨s - 1, by omega⟩
    let owners := maskCoordinates 18 (attainingMask index)
    have checks := attainingMask_checked index
    change owners.card = index.val + 1 ∧
      bucketScore (refineAlong (selectedCoordinates owners) [searchedWords]) = sizeBound (index.val + 1) at checks
    have hindex : index.val + 1 = s := by dsimp [index]; omega
    rw [hindex] at checks
    exact ⟨owners, checks.1, (pairCapacity_from_refinement owners).trans checks.2⟩

theorem maximum_feasible_owners : maximumFeasibleOwners tags = 8 := by
  apply le_antisymm
  · obtain ⟨owners, feasible, heq⟩ := maximumFeasibleOwners_attained tags (by decide)
    rw [heq]
    have hlt := feasible.2.1
    by_contra htooMany
    have impossible : ∀ s : Fin 18, 9 ≤ s.val → sizeBound s.val < 18 - s.val := by decide +kernel
    have upper := search_bound_for_every_owner_set owners checked_search
    have atLeastNine : 9 ≤ owners.card := by omega
    have hstrict := upper.trans_lt (impossible ⟨owners.card, hlt⟩ atLeastNine)
    exact (not_lt_of_ge feasible.2.2) hstrict
  · obtain ⟨_, owners, hcard, hcap⟩ := exact_maximum_by_size 8 (by decide) (by decide)
    have feasible : FeasibleOwners tags owners := by
      unfold FeasibleOwners
      rw [hcard, hcap]
      decide +kernel
    simpa only [hcard] using feasible.le_maximum

theorem exact_optimal_factor : optimalFactor tags = 2 := by
  apply le_antisymm optimum_at_most_two
  have lower := (optimalFactor_within_one tags (by decide)).1
  rw [maximum_feasible_owners] at lower
  norm_num [Nat.ceilDiv_eq_add_pred_div] at lower
  exact lower

end TwoColorNullity.PublishedInstance
