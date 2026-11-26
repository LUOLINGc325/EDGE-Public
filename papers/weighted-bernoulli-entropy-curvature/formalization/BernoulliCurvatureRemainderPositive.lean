import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

universe u
namespace WeightedBernoulliEntropyCurvatureResearchProof1

theorem nonnegative_collision_remainder (m d c L A delta : ℝ)
         (hm : 2 ≤ m) (hd : 0 ≤ d) (hc : 0 ≤ c) (hL : 0 ≤ L)
         (hA : 0 ≤ A) (hAupper : A ≤ L*(d*c)^2) (hdelta : 0 ≤ delta) :
         0 ≤ A*(d^2-m)+L*c^2*m*(m-1)+2*c*delta*d*(m-1) := by
  have hm1 : 0 ≤ m-1 := by linarith only [hm]
  have hm0 : 0 ≤ m := by linarith only [hm]
  have hLcc : 0 ≤ L*c^2 := mul_nonneg hL (sq_nonneg c)
  have hmid : 0 ≤ L*c^2*m*(m-1) := mul_nonneg (mul_nonneg hLcc hm0) hm1
  have htail : 0 ≤ 2*c*delta*d*(m-1) := by positivity
  by_cases hlarge : m ≤ d^2
  · exact add_nonneg (add_nonneg (mul_nonneg hA (sub_nonneg.mpr hlarge)) hmid) htail
  · have hnonpos : d^2-m ≤ 0 := sub_nonpos.mpr (le_of_lt (lt_of_not_ge hlarge))
    have hmul := mul_le_mul_of_nonpos_right hAupper hnonpos
    have hgap : 0 ≤ m*(m-1)-d^2*(m-d^2) := by
      have htail2 : 0 ≤ m*((3:ℝ)*m/4-1) := mul_nonneg hm0 (by linarith only [hm])
      nlinarith only [sq_nonneg (d^2-m/2), htail2]
    have hmul2 := mul_nonneg hLcc hgap
    nlinarith only [hmul, hmul2, htail]

end WeightedBernoulliEntropyCurvatureResearchProof1
