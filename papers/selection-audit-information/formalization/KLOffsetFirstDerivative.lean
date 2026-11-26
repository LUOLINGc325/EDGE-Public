import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace SelectionAuditInformationResearchProof1

/-- First moving-mass summand of the genuine `Φ` in (18):
`y ↦ (y+d) * log ((y+d)/y)`, differentiated at `x > 0`. -/
theorem kl_offset_first_derivative (d x : ℝ) (hd : 0 < d) (hx : 0 < x) :
    HasDerivAt (fun y : ℝ => (y + d) * Real.log ((y + d) / y))
      (Real.log ((x + d) / x) - d / x) x := by
  have hx' : x ≠ 0 := ne_of_gt hx
  have hxd : x + d ≠ 0 := ne_of_gt (by linarith)
  -- derivative of the quotient `(y + d) / y`
  have hquot : HasDerivAt (fun y : ℝ => (y + d) / y) ((1 * x - (x + d) * 1) / x ^ 2) x := by
    have : HasDerivAt (fun y : ℝ => (y + d) / y) (((1 : ℝ) * x - (x + d) * 1) / x ^ 2) x := by
      apply HasDerivAt.div
      · simpa using (hasDerivAt_id x).add_const d
      · exact hasDerivAt_id x
      · exact hx'
    exact this
  have hquot' : HasDerivAt (fun y : ℝ => (y + d) / y) (-(d / x ^ 2)) x := by
    convert hquot using 1
    field_simp
  have hpos : (0 : ℝ) < (x + d) / x := div_pos (by linarith) hx
  have hlog : HasDerivAt (fun y : ℝ => Real.log ((y + d) / y))
      (-(d / x ^ 2) / ((x + d) / x)) x :=
    HasDerivAt.log hquot' hpos.ne'
  have hsum : HasDerivAt (fun y : ℝ => (y + d) * Real.log ((y + d) / y))
      (1 * Real.log ((x + d) / x) + (x + d) * (-(d / x ^ 2) / ((x + d) / x))) x :=
    (HasDerivAt.add_const d (hasDerivAt_id x)).mul hlog
  convert hsum using 1
  field_simp
  ring

end SelectionAuditInformationResearchProof1
