import EndpointLambertVariational
import InteriorPriorScale

/-! The scale of the Lambert endpoint prior, derived from its exact equation. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

noncomputable def endpointBlockTime (ell : ℝ) (n : ℕ) : ℝ :=
  lambertEndpointTime ((n : ℝ) * ell)

theorem endpoint_lambert_block_time_tendsto {ell : ℝ} (he : 0 < ell) :
    Tendsto (fun n : ℕ => endpointBlockTime ell (n + 1)) atTop atTop := by
  let L (n : ℕ) := ((n + 1 : ℕ) : ℝ) * ell
  let T (n : ℕ) := endpointBlockTime ell (n + 1)
  have hL : Tendsto L atTop atTop := successor_real_tendsto.atTop_mul_const he
  apply tendsto_atTop.2
  intro A
  let B := max A 2
  have hL' := hL.eventually (eventually_gt_atTop (Real.exp B * (B - 1) + 1))
  filter_upwards [hL.eventually (eventually_ge_atTop 1), hL'] with n hn hn'
  have hEq : Real.exp (T n) * (T n - 1) = L n - 1 := (lambert_endpoint_time_spec hn).2
  have hPos : 0 ≤ T n - 1 :=
    nonneg_of_mul_nonneg_right (by rw [hEq]; exact sub_nonneg.mpr hn) (Real.exp_pos _)
  apply (le_max_left A 2).trans
  apply le_of_not_ge
  intro hT
  have h := mul_le_mul (Real.exp_le_exp.mpr hT) (sub_le_sub_right hT 1) hPos (Real.exp_nonneg _)
  rw [hEq] at h
  linarith only [h, hn']

theorem log_block_level_ratio {ell : ℝ} (he : 0 < ell) :
    Tendsto (fun n : ℕ => Real.log (((n + 1 : ℕ) : ℝ) * ell - 1) /
      Real.log ((n + 1 : ℕ) : ℝ)) atTop (𝓝 1) := by
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  have hN : Tendsto N atTop atTop := successor_real_tendsto
  have hP (n : ℕ) : 0 < N n := by unfold N; exact_mod_cast Nat.succ_pos n
  have hInv : Tendsto (fun n => (N n)⁻¹) atTop (𝓝 0) := tendsto_inv_atTop_zero.comp hN
  have hInner : Tendsto (fun n => ell - (N n)⁻¹) atTop (𝓝 ell) := by
    simpa only [sub_zero] using tendsto_const_nhds.sub hInv
  have hLogN : Tendsto (fun n => Real.log (N n)) atTop atTop := Real.tendsto_log_atTop.comp hN
  have hLog : Tendsto (fun n => Real.log (ell - (N n)⁻¹)) atTop (𝓝 (Real.log ell)) :=
    (Real.continuousAt_log he.ne').tendsto.comp hInner
  have hInvLog := tendsto_inv_atTop_zero.comp hLogN
  have hRatio : Tendsto (fun n => 1 + Real.log (ell - (N n)⁻¹) * (Real.log (N n))⁻¹)
      atTop (𝓝 1) := by
    simpa only [mul_zero, add_zero] using tendsto_const_nhds.add (hLog.mul hInvLog)
  apply hRatio.congr'
  filter_upwards [hInner.eventually (lt_mem_nhds he), hN.eventually (eventually_gt_atTop 1)]
    with n hn hNn
  have hE : N n * ell - 1 = N n * (ell - (N n)⁻¹) := by
    rw [mul_sub, mul_inv_cancel₀ (hP n).ne']
  change _ = Real.log (N n * ell - 1) / Real.log (N n)
  rw [hE, Real.log_mul (hP n).ne' (show 0 < ell - (N n)⁻¹ from hn).ne',
    add_div, div_self (Real.log_pos hNn).ne', div_eq_mul_inv]

theorem endpoint_lambert_block_ratios {ell : ℝ} (he : 0 < ell) :
    Tendsto (fun n : ℕ => endpointBlockTime ell (n + 1) / Real.log ((n + 1 : ℕ) : ℝ))
      atTop (𝓝 1) ∧
    Tendsto (fun n : ℕ => Real.exp (endpointBlockTime ell (n + 1)) /
      (((n + 1 : ℕ) : ℝ) * ell / Real.log ((n + 1 : ℕ) : ℝ))) atTop (𝓝 1) := by
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  let T (n : ℕ) := endpointBlockTime ell (n + 1)
  let L (n : ℕ) := N n * ell
  have hN : Tendsto N atTop atTop := successor_real_tendsto
  have hL : Tendsto L atTop atTop := hN.atTop_mul_const he
  have hT : Tendsto T atTop atTop := endpoint_lambert_block_time_tendsto he
  have hLogN : Tendsto (fun n => Real.log (N n)) atTop atTop := Real.tendsto_log_atTop.comp hN
  have hLogR : Tendsto (fun t : ℝ => Real.log t / t) atTop (𝓝 0) := by
    simpa only [Real.rpow_one] using
      (isLittleO_log_rpow_atTop (r := 1) zero_lt_one).tendsto_div_nhds_zero
  have hInner : Tendsto (fun n => Real.log (T n - 1) / T n) atTop (𝓝 0) := by
    apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds (hLogR.comp hT)
    · filter_upwards [hT.eventually (eventually_ge_atTop 2)] with n hn
      have hlog : 0 ≤ Real.log (T n - 1) := Real.log_nonneg (by linarith only [hn])
      exact div_nonneg hlog (by linarith only [hn])
    · filter_upwards [hT.eventually (eventually_ge_atTop 2)] with n hn
      apply div_le_div_of_nonneg_right _ (by linarith only [hn])
      exact Real.log_le_log (by linarith only [hn]) (sub_le_self _ zero_le_one)
  have hRatio : Tendsto (fun n => Real.log (L n - 1) / T n) atTop (𝓝 1) := by
    have h := (show Tendsto (fun _ : ℕ => (1 : ℝ)) atTop (𝓝 1) from tendsto_const_nhds).add hInner
    rw [show (1 : ℝ) + 0 = 1 from add_zero 1] at h
    apply h.congr'
    filter_upwards [hL.eventually (eventually_ge_atTop 1),
      hT.eventually (eventually_ge_atTop 2)] with n hn hTn
    have hT₀ : 0 < T n := by linarith only [hTn]
    have hEq : Real.exp (T n) * (T n - 1) = L n - 1 := (lambert_endpoint_time_spec hn).2
    rw [← hEq, Real.log_mul (Real.exp_pos _).ne' (by linarith only [hTn] : 0 < T n - 1).ne',
      Real.log_exp, add_div, div_self hT₀.ne']
  have hMain : Tendsto (fun n => T n / Real.log (N n)) atTop (𝓝 1) := by
    have heq := (log_block_level_ratio he).div hRatio one_ne_zero
    rw [div_self one_ne_zero] at heq
    apply heq.congr'
    filter_upwards [hL.eventually (eventually_gt_atTop 2),
      hT.eventually (eventually_gt_atTop 1),
      hN.eventually (eventually_gt_atTop 1)] with n hn hTn hNn
    have hA : 0 < Real.log (L n - 1) := Real.log_pos (by linarith only [hn] : 1 < L n - 1)
    have hB : 0 < Real.log (N n) := Real.log_pos hNn
    have hC : 0 < T n := zero_lt_one.trans hTn
    change (Real.log (L n - 1) / Real.log (N n)) / (Real.log (L n - 1) / T n) =
      T n / Real.log (N n)
    field_simp [hA.ne', hB.ne', hC.ne']
    ring
  refine ⟨hMain, ?_⟩
  have hInvN : Tendsto (fun n => (Real.log (N n))⁻¹) atTop (𝓝 0) := tendsto_inv_atTop_zero.comp hLogN
  have hTime : Tendsto (fun n => (T n - 1) / Real.log (N n)) atTop (𝓝 1) := by
    simpa only [sub_div, one_div, sub_zero] using hMain.sub hInvN
  have hInvL : Tendsto (fun n => (L n)⁻¹) atTop (𝓝 0) := tendsto_inv_atTop_zero.comp hL
  have hNum : Tendsto (fun n => 1 - (L n)⁻¹) atTop (𝓝 1) := by
    simpa only [sub_zero] using tendsto_const_nhds.sub hInvL
  have h := hNum.div hTime one_ne_zero
  rw [div_self one_ne_zero] at h
  apply h.congr'
  filter_upwards [hL.eventually (eventually_gt_atTop 2),
    hT.eventually (eventually_gt_atTop 1),
    hN.eventually (eventually_gt_atTop 1)] with n hn hTn hNn
  have hB : 0 < Real.log (N n) := Real.log_pos hNn
  have hL₀ : 0 < L n := (by norm_num : (0 : ℝ) < 2).trans hn
  have hT₀ : 0 < T n - 1 := sub_pos.mpr hTn
  have hEq : Real.exp (T n) * (T n - 1) = L n - 1 :=
    (lambert_endpoint_time_spec ((by norm_num : (1 : ℝ) ≤ 2).trans hn.le)).2
  change (1 - (L n)⁻¹) / ((T n - 1) / Real.log (N n)) = Real.exp (T n) / (L n / Real.log (N n))
  have hLam : Real.exp (T n) = (L n - 1) / (T n - 1) := (eq_div_iff hT₀.ne').2 hEq
  rw [hLam]
  field_simp [hB.ne', hL₀.ne', hT₀.ne']
  exact Or.inl (mul_comm _ _)

end RenyiProductOrderPhase
