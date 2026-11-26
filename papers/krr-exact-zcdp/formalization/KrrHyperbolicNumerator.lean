import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace KrrExactZcdpResearchProof1

theorem curvature_numerator_derivative (t : ℝ) :
    HasDerivAt (fun z : ℝ => Real.sinh z * Real.cosh z - z)
      (2 * (Real.sinh t)^2) t := by
  have h1 : HasDerivAt Real.sinh (Real.cosh t) t := Real.hasDerivAt_sinh t
  have h2 : HasDerivAt Real.cosh (Real.sinh t) t := Real.hasDerivAt_cosh t
  have hprod : HasDerivAt (fun z : ℝ => Real.sinh z * Real.cosh z)
      (Real.cosh t * Real.cosh t + Real.sinh t * Real.sinh t) t := h1.mul h2
  have hsub : HasDerivAt (fun z : ℝ => Real.sinh z * Real.cosh z - z)
      ((Real.cosh t * Real.cosh t + Real.sinh t * Real.sinh t) - 1) t :=
    hprod.sub (hasDerivAt_id t)
  have hc : Real.cosh t ^ 2 - Real.sinh t ^ 2 = 1 := Real.cosh_sq_sub_sinh_sq t
  have hsimpl : (Real.cosh t * Real.cosh t + Real.sinh t * Real.sinh t) - 1
      = 2 * (Real.sinh t)^2 := by
    have hsq : Real.cosh t ^ 2 = Real.sinh t ^ 2 + 1 := by linarith
    nlinarith [hsq]
  rw [hsimpl] at hsub
  exact hsub

end KrrExactZcdpResearchProof1
