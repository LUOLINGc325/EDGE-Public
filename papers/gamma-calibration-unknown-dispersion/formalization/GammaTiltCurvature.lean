import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

namespace GammaCalibrationUnknownDispersionResearchProof2

/-- Curvature (variance) bound for the tilted Bernoulli normalizer:
the quantity `a * b / (a + b)^2`, where `a = p * exp η` and `b = 1 - p`, lies in `[0, 1/4]`.
This is the second-derivative bound underlying Equation (6): the variance of a Bernoulli
with parameter `a/(a+b)` is at most `1/4`. -/
theorem tilted_bernoulli_curvature (p η : ℝ) (hp : 0 ≤ p) (hp1 : p ≤ 1) :
    let a := p * Real.exp η; let b := 1 - p
    0 ≤ a * b / (a + b) ^ 2 ∧ a * b / (a + b) ^ 2 ≤ 1 / 4 := by
  dsimp only
  have ha : 0 ≤ p*Real.exp η := mul_nonneg hp (Real.exp_pos _).le
  have hb : 0 ≤ 1-p := sub_nonneg.mpr hp1
  have hsum : 0 < p*Real.exp η+(1-p) := by
    rcases lt_or_eq_of_le hp1 with h | rfl
    · exact add_pos_of_nonneg_of_pos ha (sub_pos.mpr h)
    · simpa using Real.exp_pos η
  refine ⟨div_nonneg (mul_nonneg ha hb) (sq_nonneg _), ?_⟩
  rw [div_le_iff₀ (pow_pos hsum 2)]
  nlinarith only [sq_nonneg (p*Real.exp η-(1-p))]

end GammaCalibrationUnknownDispersionResearchProof2
