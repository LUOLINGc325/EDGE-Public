import Mathlib.Data.Real.Basic
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace UnknownGapAdaptationBoundaryResearchProof2

/-- Successive dyadic terms of the exponential tail: with `x_{k+1} = 2 x_k` and
`x_k ≥ 1`, the ratio of consecutive terms `x ↦ x * exp(-x)` is at most `2/e`,
i.e. `(2 x) e^{-2x} ≤ (2/e) (x e^{-x})`. This is the ratio bound used in the
dyadic tail-sum estimate (20). -/
theorem dyadic_exponential_ratio (x : ℝ) (hx : 1 ≤ x) :
    (2 * x) * Real.exp (-(2 * x)) ≤ (2 / Real.exp 1) * (x * Real.exp (-x)) := by
  have hxpos : 0 < x := lt_of_lt_of_le one_pos hx
  have hexp : 0 < Real.exp (-x) := Real.exp_pos _
  rw [show (-(2 * x) : ℝ) = -x + -x by ring]
  rw [Real.exp_add]
  set y : ℝ := x * Real.exp (-x) with hy
  have hypos : 0 < y := mul_pos hxpos hexp
  have hexp1 : Real.exp (-x) ≤ 1 / Real.exp 1 := by
    rw [le_div_iff₀ (Real.exp_pos 1)]
    calc Real.exp (-x) * Real.exp 1 = Real.exp (1 - x) := by
          rw [← Real.exp_add]; ring_nf
      _ ≤ Real.exp 0 := by
          apply Real.exp_le_exp.mpr
          linarith
      _ = 1 := Real.exp_zero
  calc (2 * x) * (Real.exp (-x) * Real.exp (-x))
        = 2 * y * Real.exp (-x) := by rw [hy]; ring
    _ ≤ 2 * y * (1 / Real.exp 1) := by
        apply mul_le_mul_of_nonneg_left hexp1 (by positivity)
    _ = (2 / Real.exp 1) * (x * Real.exp (-x)) := by rw [hy]; ring

end UnknownGapAdaptationBoundaryResearchProof2
