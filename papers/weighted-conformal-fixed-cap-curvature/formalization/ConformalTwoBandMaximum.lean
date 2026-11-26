import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace WeightedConformalFixedCapCurvatureResearchProof2

/-- For `1 ≤ B`, `q ∈ (0,1)`, the map `p ↦ 2(1-q)p(1-γp)` with `γ = 1-1/B`
is increasing on `[0, q/2]`, because `γ p ≤ γ q/2 < 1/2`, so its derivative
`2(1-q)(1-2γp)` is positive. This yields the endpoint bound at `p = q/2`. -/
theorem two_band_parabolic_max (q B p : ℝ) (hq : 0 < q) (hq1 : q < 1) (hB : 1 ≤ B)
    (hp : 0 ≤ p) (hpq : p ≤ q/2) :
    let γ := 1 - 1/B
    (B - 1) * 2 * (1 - q) * p * (1 - γ * p) ≤ (B - 1) * (1 - q) * q * (1 - γ * q/2) := by
  intro γ
  have hpos : 0 < B := lt_of_lt_of_le zero_lt_one hB
  have hγ0 : 0 ≤ γ := sub_nonneg.mpr ((div_le_one hpos).2 hB)
  have hγ1 : γ ≤ 1 := sub_le_self _ (div_nonneg zero_le_one hpos.le)
  have hy : 0 ≤ p+q/2 := add_nonneg hp (by linarith)
  have hγy := mul_le_mul_of_nonneg_right hγ1 hy
  have hc : 0 ≤ 1-γ*(p+q/2) := by linarith
  have hm := mul_nonneg (sub_nonneg.mpr hpq) hc
  have hbase : p*(1-γ*p) ≤ (q/2)*(1-γ*(q/2)) := by nlinarith only [hm]
  have hcoef : 0 ≤ (B-1)*2*(1-q) :=
    mul_nonneg (mul_nonneg (sub_nonneg.mpr hB) (by norm_num)) (sub_nonneg.mpr hq1.le)
  have hfinal := mul_le_mul_of_nonneg_left hbase hcoef
  nlinarith only [hfinal]

end WeightedConformalFixedCapCurvatureResearchProof2
