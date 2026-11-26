import OddBinIdentity
import Mathlib.Algebra.Order.BigOperators.Ring.Finset

open scoped BigOperators

namespace TwoColorNullity.Occupancy

variable {Item Label : Type*} [Fintype Item] [Fintype Label] [DecidableEq Label]

/-- Odd occupancies counted within a fixed subset of labels. -/
def restrictedOddCount (targets : Finset Label) (bins : Item → Label) : ℕ :=
  ∑ label ∈ targets, binOccupancy bins label % 2

theorem restrictedOddCount_univ (bins : Item → Label) :
    restrictedOddCount Finset.univ bins = oddBinCount bins := rfl

omit [Fintype Label] in
private theorem binOccupancy_eq_of_agreement_except (a b : Item → Label) (changed : Item)
    (h : ∀ item, item ≠ changed → a item = b item) (label : Label)
    (ha : label ≠ a changed) (hb : label ≠ b changed) :
    binOccupancy a label = binOccupancy b label := by
  classical
  unfold binOccupancy
  congr 1
  ext item
  by_cases hi : item = changed
  · subst item
    simp [Ne.symm ha, Ne.symm hb]
  · simp [h item hi]

omit [Fintype Label] in
theorem restrictedOddCount_bounded_difference (targets : Finset Label) (a b : Item → Label)
    (changed : Item) (h : ∀ item, item ≠ changed → a item = b item) :
    |(restrictedOddCount targets a : ℝ) - (restrictedOddCount targets b : ℝ)| ≤ 2 := by
  classical
  let labels : Finset Label := {a changed, b changed}
  have size : labels.card ≤ 2 := by
    by_cases he : a changed = b changed <;> simp [labels, he]
  have bound (label : Label) :
      |((binOccupancy a label % 2 : ℕ) : ℝ) - ((binOccupancy b label % 2 : ℕ) : ℝ)| ≤
        if label ∈ labels then 1 else 0 := by
    by_cases hl : label ∈ labels
    · rw [if_pos hl, abs_le]
      have ha : ((binOccupancy a label % 2 : ℕ) : ℝ) ≤ 1 := by exact_mod_cast (show binOccupancy a label % 2 ≤ 1 by omega)
      have hb : ((binOccupancy b label % 2 : ℕ) : ℝ) ≤ 1 := by exact_mod_cast (show binOccupancy b label % 2 ≤ 1 by omega)
      have ha0 : 0 ≤ ((binOccupancy a label % 2 : ℕ) : ℝ) := by positivity
      have hb0 : 0 ≤ ((binOccupancy b label % 2 : ℕ) : ℝ) := by positivity
      exact ⟨by linarith, by linarith⟩
    · rw [if_neg hl]
      have hneq : label ≠ a changed ∧ label ≠ b changed := by
        simpa [labels] using hl
      rw [binOccupancy_eq_of_agreement_except a b changed h label hneq.1 hneq.2, sub_self, abs_zero]
  have hcard : (targets.filter fun label => label ∈ labels).card ≤ labels.card :=
    Finset.card_le_card fun _ hl => (Finset.mem_filter.mp hl).2
  unfold restrictedOddCount
  rw [Nat.cast_sum, Nat.cast_sum, ← Finset.sum_sub_distrib]
  calc
    _ ≤ ∑ label ∈ targets, |((binOccupancy a label % 2 : ℕ) : ℝ) -
        ((binOccupancy b label % 2 : ℕ) : ℝ)| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ label ∈ targets, (if label ∈ labels then 1 else 0 : ℝ) := Finset.sum_le_sum fun _ _ => bound _
    _ = ((targets.filter fun label => label ∈ labels).card : ℝ) := Finset.sum_boole _ _
    _ ≤ 2 := by exact_mod_cast hcard.trans size

theorem oddBinCount_bounded_difference (a b : Item → Label) (changed : Item)
    (h : ∀ item, item ≠ changed → a item = b item) :
    |(oddBinCount a : ℝ) - (oddBinCount b : ℝ)| ≤ 2 :=
  restrictedOddCount_bounded_difference Finset.univ a b changed h

end TwoColorNullity.Occupancy
