import OccupancySensitivity

open scoped BigOperators

namespace TwoColorNullity.Occupancy

variable {Item Label : Type*} [Fintype Item] [Fintype Label] [DecidableEq Item] [DecidableEq Label]

def usedItems (pairs : Finset (Finset Item)) : Finset Item := pairs.biUnion id

def unusedItemsWithLabels (bins : Item → Label) (pairs : Finset (Finset Item))
    (labels : Finset Label) : Finset Item :=
  Finset.univ.filter fun item => item ∉ usedItems pairs ∧ bins item ∈ labels

omit [Fintype Label] in
theorem odd_bin_has_unused (bins : Item → Label) (pairs : Finset (Finset Item))
    (packing : PairPacking bins Finset.univ pairs) (label : Label)
    (hodd : binOccupancy bins label % 2 = 1) :
    ∃ item, bins item = label ∧ item ∉ usedItems pairs := by
  classical
  by_contra! hused
  let fiber : Finset Item := Finset.univ.filter fun item => bins item = label
  let selected := pairs.filter fun pair => ∀ item ∈ pair, bins item = label
  have heq : fiber = selected.biUnion id := by
    ext item
    constructor
    · intro hf
      have hlabel := (Finset.mem_filter.mp hf).2
      obtain ⟨pair, hp, hitem⟩ := Finset.mem_biUnion.mp (hused item hlabel)
      refine Finset.mem_biUnion.mpr ⟨pair, Finset.mem_filter.mpr ⟨hp, ?_⟩, hitem⟩
      intro other ho
      exact (packing.homogeneous pair hp other ho item hitem).trans hlabel
    · rintro h
      obtain ⟨pair, hp, hitem⟩ := Finset.mem_biUnion.mp h
      exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, (Finset.mem_filter.mp hp).2 item hitem⟩
  have hcard : (selected.biUnion id).card = 2 * selected.card := by
    rw [Finset.card_biUnion]
    · calc
        (∑ pair ∈ selected, (id pair).card) = ∑ _pair ∈ selected, (2 : ℕ) := by
          apply Finset.sum_congr rfl
          intro pair hp
          exact packing.two pair (Finset.mem_filter.mp hp).1
        _ = _ := by simp [Nat.mul_comm]
    · intro a ha b hb hab
      exact packing.disjoint a (Finset.mem_filter.mp ha).1 b (Finset.mem_filter.mp hb).1 hab
  change fiber.card % 2 = 1 at hodd
  rw [heq, hcard] at hodd
  omega

omit [Fintype Label] [DecidableEq Item] in
private theorem restrictedOddCount_eq_card (targets : Finset Label) (bins : Item → Label) :
    restrictedOddCount targets bins = (targets.filter fun label => binOccupancy bins label % 2 = 1).card := by
  unfold restrictedOddCount
  calc
    _ = ∑ label ∈ targets, (if binOccupancy bins label % 2 = 1 then 1 else 0 : ℕ) := by
      apply Finset.sum_congr rfl
      intro label _
      split <;> omega
    _ = _ := by
      exact_mod_cast (Finset.sum_boole (R := ℕ) (fun label => binOccupancy bins label % 2 = 1) targets)

omit [Fintype Label] in
/-- Odd bins give distinct unused representatives, for every chosen collection of labels. -/
theorem odd_representatives_card_le (bins : Item → Label) (pairs : Finset (Finset Item))
    (packing : PairPacking bins Finset.univ pairs) (targets : Finset Label) :
    restrictedOddCount targets bins ≤ (unusedItemsWithLabels bins pairs targets).card := by
  classical
  rw [restrictedOddCount_eq_card]
  let odd := targets.filter fun label => binOccupancy bins label % 2 = 1
  let candidates := unusedItemsWithLabels bins pairs targets
  have hrep (label : ↥odd) :
      ∃ item, bins item = label.val ∧ item ∉ usedItems pairs :=
    odd_bin_has_unused bins pairs packing label (Finset.mem_filter.mp label.property).2
  let rep (label : ↥odd) : ↥candidates := ⟨(hrep label).choose, by
    apply Finset.mem_filter.mpr
    refine ⟨Finset.mem_univ _, (hrep label).choose_spec.2, ?_⟩
    rw [(hrep label).choose_spec.1]
    exact (Finset.mem_filter.mp label.property).1⟩
  have hi : Function.Injective rep := by
    intro a b he
    apply Subtype.ext
    have hv := congrArg (fun g : ↥candidates => bins g.val) he
    change bins (hrep a).choose = bins (hrep b).choose at hv
    rwa [(hrep a).choose_spec.1, (hrep b).choose_spec.1] at hv
  simpa only [Fintype.card_coe] using Fintype.card_le_of_injective rep hi

theorem enough_same_color_items (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n))
    (pairs : Finset (Finset (Fin m))) (packing : PairPacking (signature tag owners) Finset.univ pairs)
    (owner : ↥owners) (color : Bool) :
    restrictedOddCount (Finset.univ.filter fun label : ↥owners → Bool => label owner = color)
        (signature tag owners) ≤
      (Finset.univ.filter fun item => item ∉ usedItems pairs ∧ tag owner.val item = color).card := by
  classical
  simpa [unusedItemsWithLabels, signature] using odd_representatives_card_le (signature tag owners) pairs packing
    (Finset.univ.filter fun label : ↥owners → Bool => label owner = color)

end TwoColorNullity.Occupancy
