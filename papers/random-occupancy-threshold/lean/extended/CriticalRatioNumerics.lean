import OccupancyCurve
import Mathlib.Analysis.Complex.Exponential

open scoped BigOperators

namespace TwoColorNullity.Occupancy

private noncomputable def expSeries12 (x : ℝ) : ℝ :=
  ∑ k ∈ Finset.range 12, x ^ k / k.factorial

private noncomputable def expError12 (x : ℝ) : ℝ :=
  |x| ^ 12 * (13 / ((Nat.factorial 12 : ℝ) * 12))

private theorem expSeries12_enclosure (x : ℝ) (hx : |x| ≤ 1) :
    expSeries12 x - expError12 x ≤ Real.exp x ∧
      Real.exp x ≤ expSeries12 x + expError12 x := by
  have h : |Real.exp x - expSeries12 x| ≤ expError12 x := by
    simpa [expSeries12, expError12] using Real.exp_bound (n := 12) hx (by decide)
  obtain ⟨hl, hu⟩ := abs_le.mp h
  exact ⟨by linarith, by linarith⟩

private theorem exp_split_four (u : ℝ) (hu : u ≠ 0) :
    Real.exp (-(6 : ℝ) / u) = Real.exp (-(6 : ℝ) / (4 * u)) ^ 4 := by
  rw [← Real.exp_nat_mul]
  congr 1
  field_simp [hu]
  ring

private noncomputable def lowerRational : ℝ := 21265735 / 10000000
private noncomputable def upperRational : ℝ := 21265746 / 10000000

set_option maxHeartbeats 1000000 in
private theorem curve_lower_rational : occupancyCurve lowerRational < 1 := by
  let x := -(6 : ℝ) / (4 * lowerRational)
  have hu : 0 < lowerRational := by norm_num [lowerRational]
  have hx0 : x ≤ 0 := by norm_num [x, lowerRational]
  have hx : |x| ≤ 1 := by rw [abs_of_nonpos hx0]; norm_num [x, lowerRational]
  have hpos : 0 ≤ expSeries12 x - expError12 x := by
    rw [expError12, abs_of_nonpos hx0]
    norm_num [x, lowerRational, expSeries12, Finset.sum_range_succ, Nat.factorial]
  have hp := pow_le_pow_left₀ hpos (expSeries12_enclosure x hx).1 4
  have hc : lowerRational * (1 - (expSeries12 x - expError12 x) ^ 4) / 2 < 1 := by
    rw [expError12, abs_of_nonpos hx0]
    norm_num [x, lowerRational, expSeries12, Finset.sum_range_succ, Nat.factorial]
  unfold occupancyCurve
  rw [exp_split_four _ hu.ne']
  exact (div_le_div_of_nonneg_right
    (mul_le_mul_of_nonneg_left (sub_le_sub_left hp 1) hu.le) (by norm_num)).trans_lt hc

set_option maxHeartbeats 1000000 in
private theorem curve_upper_rational : 1 < occupancyCurve upperRational := by
  let x := -(6 : ℝ) / (4 * upperRational)
  have hu : 0 < upperRational := by norm_num [upperRational]
  have hx0 : x ≤ 0 := by norm_num [x, upperRational]
  have hx : |x| ≤ 1 := by rw [abs_of_nonpos hx0]; norm_num [x, upperRational]
  have hp := pow_le_pow_left₀ (Real.exp_pos x).le (expSeries12_enclosure x hx).2 4
  have hc : 1 < upperRational * (1 - (expSeries12 x + expError12 x) ^ 4) / 2 := by
    rw [expError12, abs_of_nonpos hx0]
    norm_num [x, upperRational, expSeries12, Finset.sum_range_succ, Nat.factorial]
  unfold occupancyCurve
  rw [exp_split_four _ hu.ne']
  exact hc.trans_le (div_le_div_of_nonneg_right
    (mul_le_mul_of_nonneg_left (sub_le_sub_left hp 1) hu.le) (by norm_num))

theorem criticalRatio_rational_enclosure :
    (21265735 : ℝ) / 10000000 < criticalRatio ∧ criticalRatio < (21265746 : ℝ) / 10000000 := by
  have hp : 0 < criticalRatio := by linarith [criticalRatio_mem_Ioo.1]
  have hlo : 0 < lowerRational := by norm_num [lowerRational]
  have hhi : 0 < upperRational := by norm_num [upperRational]
  change lowerRational < criticalRatio ∧ criticalRatio < upperRational
  constructor
  · by_contra! h
    have hmon := occupancyCurve_strictMono.monotoneOn hp hlo h
    linarith [occupancyCurve_criticalRatio, curve_lower_rational]
  · by_contra! h
    have hmon := occupancyCurve_strictMono.monotoneOn hhi hp h
    linarith [occupancyCurve_criticalRatio, curve_upper_rational]

end TwoColorNullity.Occupancy
