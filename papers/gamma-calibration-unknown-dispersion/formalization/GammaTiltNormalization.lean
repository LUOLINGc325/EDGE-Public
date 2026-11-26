import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

namespace GammaCalibrationUnknownDispersionResearchProof1

/-- The normalizer `Z = 1 - p + p * exp η` is positive for `0 ≤ p ≤ 1`
and any real tilt `η`. -/
theorem gamma_tilt_normalizer_pos (p η : ℝ) (hp : 0 ≤ p) (hp1 : p ≤ 1) :
    0 < 1 - p + p * Real.exp η := by
  have h : 0 < p * Real.exp η + (1 - p) := by
    rcases eq_or_lt_of_le hp with h0 | hpos
    · rw [← h0]; simp
    · have he : 0 < Real.exp η := Real.exp_pos η
      have : 0 ≤ 1 - p := by linarith
      nlinarith [mul_pos hpos he]
  linarith

/-- Equation (5): the conditional Bernoulli factor
`E = exp(η S) / Z` with `Z = 1 - p + p exp η` has null expectation exactly one,
where the null sign is Bernoulli with success probability `p`.
Equivalently `(1-p)/Z + p exp η / Z = 1`. -/
theorem gamma_tilt_normalization (p η : ℝ) (hp : 0 ≤ p) (hp1 : p ≤ 1) :
    let Z := 1 - p + p * Real.exp η
    (1 - p) * (1 / Z) + p * (Real.exp η / Z) = 1 := by
  intro Z
  have hZ : Z ≠ 0 := ne_of_gt (gamma_tilt_normalizer_pos p η hp hp1)
  have hnum : (1 - p) * (1 / Z) + p * (Real.exp η / Z) = Z / Z := by
    field_simp
    ring
  rw [hnum, div_self hZ]

end GammaCalibrationUnknownDispersionResearchProof1
