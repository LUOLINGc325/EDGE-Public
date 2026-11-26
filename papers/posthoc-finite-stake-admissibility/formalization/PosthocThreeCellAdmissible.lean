import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

namespace PosthocFiniteStakeAdmissibilityResearchProof1

/-- Null budget on the exact three-cell law in Section 3. -/
noncomputable def budgetThree (a b c : ℝ) : ℝ := a / 4 + 3*b / 8 + 3*c / 8

/-- The capped alternative moment on the same three cells. -/
noncomputable def qCapThree (t a b c : ℝ) : ℝ :=
  min a t / 8 + 7 * min b t / 16 + 7 * min c t / 16

theorem q_cap_le_budget (a b c t : ℝ) (ha : 0 ≤ a) :
    qCapThree t a b c ≤ (7 / 6 : ℝ) * budgetThree a b c := by
  unfold qCapThree budgetThree
  linarith only [min_le_left a t, min_le_left b t, min_le_left c t, ha]

theorem tied_witness_sharp :
    budgetThree 0 2 (2/3) = 1 ∧
    qCapThree 2 0 2 (2/3) = 7/6 ∧ qCapThree 3 0 2 (2/3) = 7/6 := by
  norm_num [budgetThree, qCapThree, min_def]

/-- No budget-one competitor with nonnegative scores can strictly improve
either allowed cap in the first example. -/
theorem tied_witness_no_strict_improvement (a b c : ℝ) (ha : 0 ≤ a)
    (h : budgetThree a b c ≤ 1) :
    qCapThree 2 a b c ≤ qCapThree 2 0 2 (2/3) ∧
    qCapThree 3 a b c ≤ qCapThree 3 0 2 (2/3) := by
  rw [tied_witness_sharp.2.1, tied_witness_sharp.2.2]
  exact ⟨by linarith [q_cap_le_budget a b c 2 ha],
    by linarith [q_cap_le_budget a b c 3 ha]⟩

/-- Equalizing the tied scores raises the cap-one moment by 7/16 and
preserves the cap-three moment in Section 3's second example. -/
theorem equalize_tie_changes_cap_one :
    budgetThree 0 0 (8/3) = 1 ∧ budgetThree 0 (4/3) (4/3) = 1 ∧
    qCapThree 1 0 (4/3) (4/3) - qCapThree 1 0 0 (8/3) = 7/16 ∧
    qCapThree 3 0 (4/3) (4/3) = qCapThree 3 0 0 (8/3) := by
  norm_num [budgetThree, qCapThree, min_def]

/-- The lower-ratio allocation has moment 5/6 at both caps, while the
reallocated evidence with the same budget has moment 7/6. -/
theorem lower_ratio_allocation_comparison :
    budgetThree 2 (2/3) (2/3) = 1 ∧
    qCapThree 2 2 (2/3) (2/3) = 5/6 ∧ qCapThree 3 2 (2/3) (2/3) = 5/6 ∧
    qCapThree 2 0 (4/3) (4/3) = 7/6 ∧ qCapThree 3 0 (4/3) (4/3) = 7/6 := by
  norm_num [budgetThree, qCapThree, min_def]

end PosthocFiniteStakeAdmissibilityResearchProof1
