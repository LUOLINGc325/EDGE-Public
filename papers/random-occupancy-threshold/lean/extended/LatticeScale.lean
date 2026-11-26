import CriticalRatioNumerics
import NormalizedFixedFactor

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

noncomputable def transitionLog (n : ℕ) : ℝ := binaryLog (criticalRatio * (n : ℝ))

noncomputable def transitionFloor (n : ℕ) : ℕ := ⌊transitionLog n⌋₊

noncomputable def boundaryWidth (c : ℝ) (n : ℕ) : ℝ :=
  c * (Real.log (n : ℝ) / Real.sqrt (n : ℝ))

theorem criticalRatio_pos : 0 < criticalRatio := by linarith [criticalRatio_mem_Ioo.1]

theorem two_nat_pow_le_iff_binaryLog (s : ℕ) {x : ℝ} (hx : 0 < x) :
    (2 : ℝ) ^ s ≤ x ↔ (s : ℝ) ≤ binaryLog x := by
  calc
    _ ↔ Real.log ((2 : ℝ) ^ s) ≤ Real.log x := (Real.log_le_log_iff (by positivity) hx).symm
    _ ↔ _ := by rw [Real.log_pow, binaryLog, le_div_iff₀ log_two_pos]

theorem lt_two_nat_pow_iff_binaryLog (s : ℕ) {x : ℝ} (hx : 0 < x) :
    x < (2 : ℝ) ^ s ↔ binaryLog x < (s : ℝ) := by
  calc
    _ ↔ Real.log x < Real.log ((2 : ℝ) ^ s) := (Real.log_lt_log_iff hx (by positivity)).symm
    _ ↔ _ := by rw [Real.log_pow, binaryLog, div_lt_iff₀ log_two_pos]

theorem transitionLog_shift (n : ℕ) (hn : 1 ≤ n) :
    transitionLog n = binaryLog criticalRatio + binaryLog n := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  unfold transitionLog binaryLog
  rw [Real.log_mul criticalRatio_pos.ne' hnR.ne', add_div]

theorem transitionLog_nonnegative (n : ℕ) (hn : 1 ≤ n) : 0 ≤ transitionLog n := by
  have hnR : (1 : ℝ) ≤ n := by exact_mod_cast hn
  have hx : (1 : ℝ) ≤ criticalRatio * (n : ℝ) := by
    have hh := mul_le_mul_of_nonneg_left hnR criticalRatio_pos.le
    nlinarith only [hh, criticalRatio_mem_Ioo.1]
  exact div_nonneg (Real.log_nonneg hx) log_two_pos.le

theorem transitionFloor_bounds (n : ℕ) (hn : 1 ≤ n) :
    (transitionFloor n : ℝ) ≤ transitionLog n ∧ transitionLog n < (transitionFloor n : ℝ) + 1 :=
  ⟨Nat.floor_le (transitionLog_nonnegative n hn), Nat.lt_floor_add_one _⟩

theorem transition_power_bounds (n : ℕ) (hn : 1 ≤ n) :
    (2 : ℝ) ^ transitionFloor n ≤ criticalRatio * (n : ℝ) ∧
      criticalRatio * (n : ℝ) < (2 : ℝ) ^ (transitionFloor n + 1) := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hx := mul_pos criticalRatio_pos hnR
  refine ⟨(two_nat_pow_le_iff_binaryLog _ hx).mpr (transitionFloor_bounds n hn).1, ?_⟩
  apply (lt_two_nat_pow_iff_binaryLog _ hx).mpr
  push_cast
  exact (transitionFloor_bounds n hn).2

theorem transitionFloor_at_least_log2 (n : ℕ) (hn : 1 ≤ n) : n.log2 ≤ transitionFloor n := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hp : (2 : ℝ) ^ n.log2 ≤ n := by
    exact_mod_cast (Nat.le_log2 (by omega : n ≠ 0)).mp (le_refl n.log2)
  have hmult : (n : ℝ) ≤ criticalRatio * (n : ℝ) := by
    simpa only [one_mul] using mul_le_mul_of_nonneg_right
      (show (1 : ℝ) ≤ criticalRatio by linarith [criticalRatio_mem_Ioo.1]) hnR.le
  have hl := (two_nat_pow_le_iff_binaryLog (n.log2) (mul_pos criticalRatio_pos hnR)).mp (hp.trans hmult)
  exact (Nat.le_floor_iff (transitionLog_nonnegative n hn)).mpr hl

theorem transitionFloor_bin_range (n : ℕ) (hn : 1 ≤ n) :
    (n : ℝ) ≤ (2 : ℝ) ^ transitionFloor n ∧ (2 : ℝ) ^ transitionFloor n ≤ 3 * (n : ℝ) := by
  obtain ⟨hlo, hhi⟩ := transition_power_bounds n hn
  have hnR : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  rw [pow_succ] at hhi
  have hlower := mul_le_mul_of_nonneg_right criticalRatio_mem_Ioo.1.le hnR.le
  have hupper := mul_le_mul_of_nonneg_right criticalRatio_mem_Ioo.2.le hnR.le
  exact ⟨by linarith only [hhi, hlower], hlo.trans hupper⟩

theorem transitionLog_over_n_zero :
    Tendsto (fun n : ℕ => transitionLog n / (n : ℝ)) atTop (𝓝 0) := by
  have hinv : Tendsto (fun n : ℕ => ((n : ℝ))⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_zero.comp tendsto_natCast_atTop_atTop
  have h := (hinv.const_mul (binaryLog criticalRatio)).add binaryLog_over_n_zero
  rw [mul_zero, zero_add] at h
  refine h.congr' ?_
  filter_upwards [eventually_ge_atTop (1 : ℕ)] with n hn
  rw [transitionLog_shift n hn, add_div, div_eq_mul_inv (binaryLog criticalRatio)]

theorem transitionFloor_eventually_small {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n : ℕ in atTop, (transitionFloor n : ℝ) ≤ ε * (n : ℝ) := by
  filter_upwards [eventually_ge_atTop (1 : ℕ), transitionLog_over_n_zero.eventually (gt_mem_nhds hε)] with n hn h
  have hnR : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  exact (transitionFloor_bounds n hn).1.trans ((div_lt_iff₀ hnR).mp h).le

theorem transitionFloor_eventually_admissible :
    ∀ᶠ n : ℕ in atTop, 0 < transitionFloor n ∧ transitionFloor n < n ∧ 2 * transitionFloor n ≤ n - 1 := by
  filter_upwards [eventually_ge_atTop (4 : ℕ), transitionFloor_eventually_small (show (0 : ℝ) < 1 / 4 by norm_num)]
    with n hn h
  have hlog : 1 ≤ n.log2 := (Nat.le_log2 (by omega)).mpr (by omega)
  have hsize := hlog.trans (transitionFloor_at_least_log2 n (by omega))
  have hfour : 4 * transitionFloor n ≤ n := by
    exact_mod_cast (show 4 * (transitionFloor n : ℝ) ≤ (n : ℝ) by linarith)
  omega

theorem transition_group_count_atTop :
    Tendsto (fun n : ℕ => n / transitionFloor n) atTop atTop := by
  apply tendsto_atTop.2
  intro bound
  have hden : 0 < ((bound + 1 : ℕ) : ℝ) := by positivity
  filter_upwards [transitionFloor_eventually_admissible, transitionFloor_eventually_small (one_div_pos.mpr hden)] with n hpos h
  have hn : (transitionFloor n : ℝ) ≤ (n : ℝ) / ((bound + 1 : ℕ) : ℝ) := by
    simpa only [one_div, div_eq_mul_inv, mul_comm, mul_one] using h
  have hmul : transitionFloor n * (bound + 1) ≤ n := by
    exact_mod_cast (le_div_iff₀ hden).mp hn
  apply (Nat.le_div_iff_mul_le hpos.1).mpr
  exact (Nat.mul_le_mul_right _ (Nat.le_succ bound)).trans (by simpa only [Nat.mul_comm] using hmul)

theorem log_over_sqrt_zero :
    Tendsto (fun n : ℕ => Real.log (n : ℝ) / Real.sqrt (n : ℝ)) atTop (𝓝 0) := by
  have h := (isLittleO_log_rpow_rpow_atTop 1 (show (0 : ℝ) < 1 / 2 by norm_num)).tendsto_div_nhds_zero
  simpa only [Function.comp_apply, Real.rpow_one, Real.sqrt_eq_rpow] using
    h.comp (tendsto_natCast_atTop_atTop : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop)

theorem boundaryWidth_zero (c : ℝ) : Tendsto (boundaryWidth c) atTop (𝓝 0) := by
  simpa only [boundaryWidth, mul_zero] using log_over_sqrt_zero.const_mul c

end TwoColorNullity.Occupancy
