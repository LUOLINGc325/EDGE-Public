import Mathlib.Data.Real.Basic
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith

namespace UnknownGapAdaptationBoundaryResearchProof2

/-- The ratio `2 / e` appearing in the dyadic tail sum after (20) is strictly
between `0` and `1`.  The upper bound is exactly the statement that successive
terms `x_k e^{-x_k}` with `x_{k+1}/x_k = 2` have ratio `2/e < 1`, so the
geometric series converges; the strictness relies on `2 < exp 1`. -/
theorem dyadic_ratio_below_one : 0 < (2:ℝ)/Real.exp 1 ∧ (2:ℝ)/Real.exp 1 < 1 := by
  have hexp_pos := Real.exp_pos 1
  refine ⟨div_pos (by norm_num) hexp_pos, (div_lt_one hexp_pos).mpr ?_⟩
  linarith [Real.add_one_lt_exp (one_ne_zero : (1 : ℝ) ≠ 0)]

end UnknownGapAdaptationBoundaryResearchProof2
