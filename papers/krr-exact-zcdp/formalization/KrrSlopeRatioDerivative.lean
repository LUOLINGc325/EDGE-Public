import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace KrrExactZcdpResearchProof1

/-- Derivative of the weighting ratio `h(t) = 2 sinh t / t`.
This is the quotient-rule computation used in the strict monotonicity
proof of the curvature threshold `C`: with `B(t) = t cosh t - sinh t`,
we have `h'(t) = 2 B(t) / t^2`. -/
theorem slope_ratio_derivative (t : ℝ) (ht : 0 < t) :
    HasDerivAt (fun z : ℝ => 2 * Real.sinh z / z)
      (2 * (t * Real.cosh t - Real.sinh t) / t ^ 2) t := by
  have ht0 : t ≠ 0 := ne_of_gt ht
  -- Derivative of the numerator `2 sinh z` is `2 cosh t`.
  have hnum : HasDerivAt (fun z : ℝ => 2 * Real.sinh z)
      (2 * Real.cosh t) t := by
    have := (Real.hasDerivAt_sinh t).const_mul 2
    simpa using this
  -- Derivative of the denominator `z` is `1`.
  have hden : HasDerivAt (fun z : ℝ => z) 1 t := hasDerivAt_id t
  -- Quotient rule.
  have hq := hnum.div hden ht0
  -- The derivative value produced by the quotient rule.
  have hval : (2 * Real.cosh t * t - 2 * Real.sinh t * 1) / t ^ 2
      = 2 * (t * Real.cosh t - Real.sinh t) / t ^ 2 := by
    field_simp
    ring
  rw [← hval]
  exact hq

end KrrExactZcdpResearchProof1
