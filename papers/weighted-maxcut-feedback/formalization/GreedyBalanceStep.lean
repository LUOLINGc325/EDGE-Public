import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace WeightedMaxcutFeedbackResearchProof1

/-- Frozen source: cases/weighted-maxcut-feedback/paper.md, supporting lines 339–343,
parent 引理 6. Narrow child scope: one greedy two-bin insertion step keeps the
difference of the two bin sums bounded by the maximum coefficient. -/
theorem greedy_balance_step (a b m : ℝ) (ha : 0 ≤ a) (ham : a ≤ m) (hb : 0 ≤ b) (hbm : b ≤ m) :
    |b - a| ≤ m := by
  rw [abs_le]
  constructor <;> linarith

end WeightedMaxcutFeedbackResearchProof1
