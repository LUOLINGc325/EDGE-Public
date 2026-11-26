import Mathlib.Data.Real.Basic
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith

namespace UnknownGapAdaptationBoundaryResearchProof2

/-- The initial-term bound `1/e` for the dyadic tail sum after (20).

The proof uses the exponential tangent bound at `x - 1`. -/
theorem first_dyadic_term (x : ℝ) (hx : 1 ≤ x) :
    x * Real.exp (-x) ≤ (Real.exp 1)⁻¹ := by
  have hxpos : 0 < x := lt_of_lt_of_le zero_lt_one hx
  have hexp1 : 0 < Real.exp 1 := Real.exp_pos 1
  -- Reduce to `x ≤ exp (x - 1)`, then multiply by `exp (-x)`.
  have key : x * Real.exp (-x) ≤ 1 * Real.exp (-1) := by
    have h : x ≤ Real.exp (x - 1) := by
      have hsub : 0 ≤ x - 1 := by linarith
      have := Real.add_one_le_exp (x - 1)
      linarith
    have h' : x * Real.exp (-x) ≤ Real.exp (x - 1) * Real.exp (-x) := by
      exact mul_le_mul_of_nonneg_right h (Real.exp_pos (-x)).le
    have h'' : Real.exp (x - 1) * Real.exp (-x) = Real.exp (-1) := by
      rw [← Real.exp_add]
      ring_nf
    linarith [h'']
  have hval : (1 : ℝ) * Real.exp (-1) = (Real.exp 1)⁻¹ := by
    rw [one_mul, Real.exp_neg]
  linarith [hval]

end UnknownGapAdaptationBoundaryResearchProof2
