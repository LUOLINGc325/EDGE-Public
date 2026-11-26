import GreedyColorReservations
import OptimalFactor

namespace TwoColorNullity.Occupancy


/-- At factors at least one, comparisons with one's own bundle add no condition. -/
theorem approxEFX_iff_distinct_owners (tag : Fin n → Fin m → Bool) (assign : Fin m → Fin n)
    (factor : ℝ) (hfactor : 1 ≤ factor) :
    ApproxEFX tag assign factor ↔ ∀ i j : Fin n, i ≠ j → ∀ g ∈ bundle assign i,
      (cost tag i ((bundle assign i).erase g) : ℝ) ≤ factor * cost tag i (bundle assign j) := by
  constructor
  · exact fun h i j _ g hg => h i j g hg
  · intro h i j g hg
    by_cases he : i = j
    · subst j
      have hc : cost tag i ((bundle assign i).erase g) ≤ cost tag i (bundle assign i) :=
        cost_monotone tag i (Finset.erase_subset _ _)
      have hcast : (cost tag i ((bundle assign i).erase g) : ℝ) ≤ cost tag i (bundle assign i) := by
        exact_mod_cast hc
      refine hcast.trans ?_
      simpa only [one_mul] using mul_le_mul_of_nonneg_right hfactor (Nat.cast_nonneg (cost tag i (bundle assign i)))
    · exact h i j he g hg

/-- An owner has two distinct chores of each of its colors. -/
def HasTwoOfEachColor (tag : Fin n → Fin m → Bool) (assign : Fin m → Fin n) (owner : Fin n) : Prop :=
  ∀ color : Bool, ∃ a ∈ bundle assign owner, ∃ b ∈ bundle assign owner,
    a ≠ b ∧ tag owner a = color ∧ tag owner b = color

theorem HasTwoOfEachColor.preserves_color_after_deletion
    {tag : Fin n → Fin m → Bool} {assign : Fin m → Fin n} {owner : Fin n}
    (h : HasTwoOfEachColor tag assign owner) (deleted : Fin m) (color : Bool) :
    color ∈ ((bundle assign owner).erase deleted).image (tag owner) := by
  obtain ⟨a, ha, b, hb, hab, hca, hcb⟩ := h color
  apply Finset.mem_image.mpr
  by_cases hd : a = deleted
  · exact ⟨b, Finset.mem_erase.mpr ⟨fun he => hab (hd.trans he.symm), hb⟩, hcb⟩
  · exact ⟨a, Finset.mem_erase.mpr ⟨hd, ha⟩, hca⟩

theorem HasTwoOfEachColor.trimmed_cost
    {tag : Fin n → Fin m → Bool} {assign : Fin m → Fin n} {owner : Fin n}
    (h : HasTwoOfEachColor tag assign owner) {deleted : Fin m} (hd : deleted ∈ bundle assign owner) :
    cost tag owner ((bundle assign owner).erase deleted) = (bundle assign owner).card - 3 := by
  have hcolors : ((bundle assign owner).erase deleted).image (tag owner) = Finset.univ := by
    ext color
    exact iff_of_true (h.preserves_color_after_deletion deleted color) (Finset.mem_univ _)
  unfold cost
  rw [hcolors, Finset.card_erase_of_mem hd]
  simp only [Finset.card_univ, Fintype.card_bool]
  omega

theorem approxEFX_of_protected_pairs (tag : Fin n → Fin m → Bool) (assign : Fin m → Fin n)
    (factor : ℕ)
    (hmin : ∀ i, 2 ≤ (bundle assign i).card)
    (hmax : ∀ i, (bundle assign i).card ≤ factor + 3)
    (hprotected : ∀ i, 3 ≤ (bundle assign i).card → HasTwoOfEachColor tag assign i)
    (hagrees : ∀ i j, 3 ≤ (bundle assign i).card → (bundle assign j).card = 2 →
      ∀ a ∈ bundle assign j, ∀ b ∈ bundle assign j, tag i a = tag i b) :
    ApproxEFX tag assign factor := by
  intro i j deleted hd
  have hi := hmin i
  have hj := hmin j
  by_cases hs : (bundle assign i).card = 2
  · rw [cost_eq_zero_of_small tag i _ (by have := Finset.card_erase_of_mem hd; omega)]
    exact_mod_cast (Nat.zero_le (factor * cost tag i (bundle assign j)))
  · have hilarge : 3 ≤ (bundle assign i).card := by omega
    have hc : 0 < cost tag i (bundle assign j) := by
      by_cases hp : (bundle assign j).card = 2
      · rw [(pair_cost_one_iff tag i _ hp).mpr (hagrees i j hilarge hp)]
        decide
      · have hcolors := image_card_le_two tag i (bundle assign j)
        unfold cost
        omega
    have hown : cost tag i ((bundle assign i).erase deleted) ≤ factor := by
      rw [(hprotected i hilarge).trimmed_cost hd]
      have h := hmax i
      omega
    exact_mod_cast hown.trans (by simpa using Nat.mul_le_mul_left factor hc)

end TwoColorNullity.Occupancy
