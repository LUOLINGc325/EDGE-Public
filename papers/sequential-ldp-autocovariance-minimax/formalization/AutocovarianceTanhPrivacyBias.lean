import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Analysis.SpecialFunctions.Exp

universe u
namespace SequentialLdpAutocovarianceMinimaxResearchProof2

theorem tanh_privacy_bias_bound (a : ℝ) (ha : 0 < a) :
         min a 1 / 8 ≤ Real.tanh (a/4) := by
  let p := Real.exp (a/4)
  have hp : 0 < p := Real.exp_pos _
  have hden : 0 < p^2+1 := by positivity
  have hform : Real.tanh (a/4) = (p^2-1)/(p^2+1) := by
    rw [Real.tanh_eq_sinh_div_cosh, Real.sinh_eq, Real.cosh_eq, Real.exp_neg]
    change ((p - p⁻¹)/2) / ((p + p⁻¹)/2) = (p^2-1)/(p^2+1)
    have hsum : 0 < p+p⁻¹ := add_pos hp (inv_pos.mpr hp)
    field_simp [ne_of_gt hp, ne_of_gt hsum, ne_of_gt hden]
    ring
  have hp2 : p^2 = Real.exp (a/2) := by
    dsimp [p]
    rw [pow_two, ← Real.exp_add]
    congr 1
    ring
  have hgrowth : a/2 ≤ p^2-1 := by
    rw [hp2]
    linarith only [Real.add_one_le_exp (a/2)]
  have hgrowth0 : 0 ≤ p^2-1 := by linarith only [hgrowth, ha]
  have hmin := min_le_left a 1
  have hmin1 := min_le_right a 1
  have hprod := mul_le_mul_of_nonneg_right hmin1 hgrowth0
  rw [hform]
  apply (le_div_iff₀ hden).2
  nlinarith only [hgrowth, hgrowth0, hmin, hprod]

end SequentialLdpAutocovarianceMinimaxResearchProof2
