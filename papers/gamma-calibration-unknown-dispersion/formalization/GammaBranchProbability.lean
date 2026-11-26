import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace GammaCalibrationUnknownDispersionResearchProof1

/-- From the two-branch Jacobian formula, with the lower root `l < 1` and the
upper root `1 < u`, the upper-branch probability `p = (1-l)/(u-l)` is strictly
interior and the conditional mean `(1-p)*l + p*u` equals `1`. -/
theorem gamma_branch_mean (l u : ℝ) (hl : l < 1) (hu : 1 < u) :
    let p := (1 - l) / (u - l); 0 < p ∧ p < 1 ∧ (1 - p) * l + p * u = 1 := by
  have hden : 0 < u - l := by linarith
  have hnum : 0 < 1 - l := by linarith
  have hu' : 1 - l < u - l := by linarith
  refine ⟨?_, ?_, ?_⟩
  · exact div_pos hnum hden
  · rw [div_lt_one hden]
    exact hu'
  · field_simp
    ring

end GammaCalibrationUnknownDispersionResearchProof1
