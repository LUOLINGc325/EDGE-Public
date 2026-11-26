import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace ExactConvexProfileCapitalResearchProof1

theorem capital_slack_bound (a b d B D : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hb1 : b ≤ 1) (hd : 0 ≤ d) (hd1 : d ≤ 1) (hB : B ≤ a*(1-b)) (hD : D ≤ a*(1-d)) : b*D+d*B ≤ a := by
  have h1 := mul_le_mul_of_nonneg_left hD hb
  have h2 := mul_le_mul_of_nonneg_left hB hd
  have hkey : b*(1-d)+d*(1-b) ≤ 1 := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hb1) (sub_nonneg.mpr hd1), mul_nonneg hb hd]
  have hmul := mul_le_mul_of_nonneg_left hkey ha
  nlinarith only [h1,h2,hmul]

end ExactConvexProfileCapitalResearchProof1
