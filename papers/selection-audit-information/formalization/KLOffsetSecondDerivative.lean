import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace SelectionAuditInformationResearchProof1

/-- Differentiating the explicit slope of the first moving-mass summand
`y ↦ log ((y+d)/y) - d/y` yields the first rational term `d^2/(x^2*(x+d))`
of the manuscript curvature (20). -/
theorem kl_offset_second_derivative (d x : ℝ) (hd : 0 < d) (hx : 0 < x) :
    HasDerivAt (fun y : ℝ => Real.log ((y + d) / y) - d / y)
      (d ^ 2 / (x ^ 2 * (x + d))) x := by
  have hx0 : x ≠ 0 := ne_of_gt hx
  have hxd : x + d ≠ 0 := ne_of_gt (by linarith)
  -- Derivative of `y ↦ log ((y+d)/y)`.
  have hlog : HasDerivAt (fun y : ℝ => Real.log ((y + d) / y))
      (1 / (x + d) - 1 / x) x := by
    have h1 : HasDerivAt (fun y : ℝ => y + d) 1 x := by
      simpa using (hasDerivAt_id x).add_const d
    have h2 : HasDerivAt (fun y : ℝ => (y + d) / y)
        ((1 * x - (x + d) * 1) / x ^ 2) x :=
      h1.div (hasDerivAt_id x) hx0
    have hpos : (x + d) / x ≠ 0 := div_ne_zero hxd hx0
    have := h2.log hpos
    convert this using 1
    field_simp
    ring
  -- Derivative of `y ↦ d/y`.
  have hinv : HasDerivAt (fun y : ℝ => d / y) (-(d / x ^ 2)) x := by
    have h3 : HasDerivAt (fun y : ℝ => y⁻¹) (-(x ^ 2)⁻¹) x := hasDerivAt_inv hx0
    simpa only [div_eq_mul_inv, mul_neg] using h3.const_mul d
  have hsub := hlog.sub hinv
  convert hsub using 1
  field_simp
  ring

end SelectionAuditInformationResearchProof1
