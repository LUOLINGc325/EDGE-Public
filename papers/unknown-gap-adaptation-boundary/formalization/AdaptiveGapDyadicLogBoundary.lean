import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum
import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace UnknownGapAdaptationBoundaryResearchProof2

theorem dyadic_log_boundary (A k : ℝ) (hA : 1 ≤ A) (hk : 1 ≤ k) :
         Real.log (A*(k+2)^2) ≤ 2*Real.log (A*(k+1)^2) := by
  have hp : 0 < A := lt_of_lt_of_le zero_lt_one hA
  have hk2 : 0 < k + 2 := by linarith
  have hk1 : 0 < k + 1 := by linarith
  have hkk : k + 2 ≤ (k + 1)^2 := by nlinarith only [sq_nonneg k, hk]
  have hAA : A ≤ A^2 := by nlinarith only [mul_nonneg hp.le (sub_nonneg.mpr hA)]
  have hpow : A * (k + 2)^2 ≤ (A * (k + 1)^2)^2 := by
    calc
      _ ≤ A * ((k + 1)^2)^2 := mul_le_mul_of_nonneg_left (pow_le_pow_left₀ hk2.le hkk 2) hp.le
      _ ≤ _ := by
        rw [mul_pow]
        exact mul_le_mul_of_nonneg_right hAA (sq_nonneg _)
  calc
    _ ≤ Real.log ((A * (k + 1)^2)^2) := Real.log_le_log (mul_pos hp (pow_pos hk2 2)) hpow
    _ = _ := by simp [Real.log_pow]

end UnknownGapAdaptationBoundaryResearchProof2
