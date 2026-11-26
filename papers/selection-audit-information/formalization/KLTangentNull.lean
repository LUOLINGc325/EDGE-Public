import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace SelectionAuditInformationResearchProof1

/-- For a strictly positive null probability `P`, the derivative in the null probability
of one summand `Q * log (Q / t)` of the three-category relative entropy, evaluated at `P`,
equals `-Q/P`. This is the null-coordinate tangent used in the reference-point
linearization (equation (15)). -/
theorem null_coordinate_derivative (P Q : ℝ) (hP : 0 < P) (hQ : 0 < Q) :
    HasDerivAt (fun t : ℝ => Q * Real.log (Q / t)) (-Q/P) P := by
  have hPne : P ≠ 0 := ne_of_gt hP
  have hpos : Q / P ≠ 0 := (div_pos hQ hP).ne'
  -- derivative of the inner function `t ↦ Q / t` at `P`
  have hinner : HasDerivAt (fun t : ℝ => Q / t) (-Q / P^2) P := by
    have h := (hasDerivAt_const P Q).div (hasDerivAt_id P) hPne
    simpa using h
  -- chain rule with logarithmic derivative
  have hcomp : HasDerivAt (fun t : ℝ => Real.log (Q / t)) ((-Q / P^2) / (Q / P)) P :=
    hinner.log hpos
  have hmul : HasDerivAt (fun t : ℝ => Q * Real.log (Q / t))
      (Q * ((-Q / P^2) / (Q / P))) P :=
    hcomp.const_mul Q
  have hval : Q * ((-Q / P^2) / (Q / P)) = -Q / P := by
    field_simp
    ring
  rw [← hval]
  exact hmul

end SelectionAuditInformationResearchProof1
