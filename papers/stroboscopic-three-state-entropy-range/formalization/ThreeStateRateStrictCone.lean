import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Data.Real.Sqrt

universe u
namespace StroboscopicThreeStateEntropyRangeResearchProof1

theorem strict_rate_cone (x y z c b : ℝ)
         (hx : |c| < x) (hy : |c| < y) (hz : |c| < z) (hb : 0 < b)
         (hdisc : 3*c^2-(x^2+y^2+z^2-x*y-y*z-z*x)=b^2) :
         Real.sqrt 3*b < x+y+z := by
  have hΔ : 0 ≤ x^2+y^2+z^2-x*y-y*z-z*x := by
    nlinarith only [sq_nonneg (x-y), sq_nonneg (y-z), sq_nonneg (z-x)]
  have hsq3 : (Real.sqrt (3:ℝ))^2 = 3 := Real.sq_sqrt (by norm_num)
  have hb_sq : b^2 ≤ (Real.sqrt 3*|c|)^2 := by
    rw [mul_pow, hsq3, sq_abs]
    linarith only [hdisc, hΔ]
  have hle : b ≤ Real.sqrt 3*|c| := by
    nlinarith only [hb_sq, hb, Real.sqrt_nonneg (3:ℝ), abs_nonneg c,
      mul_nonneg (Real.sqrt_nonneg (3:ℝ)) (abs_nonneg c)]
  have hle' := mul_le_mul_of_nonneg_left hle (Real.sqrt_nonneg (3:ℝ))
  have hnorm : Real.sqrt 3*(Real.sqrt 3*|c|) = 3*|c| := by
    calc
      _ = (Real.sqrt (3:ℝ))^2*|c| := by ring
      _ = _ := by rw [hsq3]
  rw [hnorm] at hle'
  linarith only [hle', hx, hy, hz]

end StroboscopicThreeStateEntropyRangeResearchProof1
