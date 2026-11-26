import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace SelectionAuditInformationResearchProof1

/-- Differentiating one summand of the three-category relative entropy
`t ↦ t * log (t / P)` in its alternative probability `t` gives
`log (Q / P) + 1` at `t = Q`. This is the tangent computation feeding
the linear term of equation (15) of the manuscript. -/
theorem alternative_coordinate_derivative (P Q : ℝ) (hP : 0 < P) (hQ : 0 < Q) :
    HasDerivAt (fun t : ℝ => t * Real.log (t / P)) (Real.log (Q / P) + 1) Q := by
  have hPne : P ≠ 0 := ne_of_gt hP
  have hQne : Q ≠ 0 := ne_of_gt hQ
  -- derivative of the inner quotient t ↦ t / P
  have hinner : HasDerivAt (fun t : ℝ => t / P) (1 / P) Q := by
    have h := (hasDerivAt_id Q).div_const P
    simpa using h
  -- derivative of the logarithm of the inner quotient
  have hlog : HasDerivAt (fun t : ℝ => Real.log (t / P)) ((1 / P) / (Q / P)) Q :=
    hinner.log (div_pos hQ hP).ne'
  -- combine with the product rule
  have hprod : HasDerivAt (fun t : ℝ => t * Real.log (t / P))
      ((1 : ℝ) * Real.log (Q / P) + Q * ((1 / P) / (Q / P))) Q :=
    (hasDerivAt_id Q).mul hlog
  have hval : (1:ℝ) * Real.log (Q / P) + Q * ((1 / P) / (Q / P))
      = Real.log (Q / P) + 1 := by
    field_simp
  rw [hval] at hprod
  exact hprod

end SelectionAuditInformationResearchProof1
