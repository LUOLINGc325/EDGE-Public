import DeficitRateConsequences
import CriticalExactCoefficient

/-! Extracting exponential rates from the five different normalizations. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

theorem log_product_scale_rate {f g : ℕ → ℝ} {x y : ℝ}
    (hf : ∀ᶠ n in atTop, 0 < f n) (hg : ∀ᶠ n in atTop, 0 < g n)
    (hF : Tendsto (fun n => Real.log (f n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 x))
    (hG : Tendsto (fun n => Real.log (g n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 y)) :
    Tendsto (fun n => Real.log (f n * g n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 (x + y)) := by
  apply (hF.add hG).congr'
  filter_upwards [hf, hg] with n hn hgn
  rw [Real.log_mul hn.ne' hgn.ne', add_div]

theorem positive_block_scale (r : ℝ) (n : ℕ) : 0 < blockScale r (n + 1) := by
  unfold blockScale
  exact mul_pos (Real.sqrt_pos.2 (by exact_mod_cast Nat.succ_pos n)) (Real.exp_pos _)

theorem log_order_block_scale_rate (r I : ℝ) :
    Tendsto (fun n : ℕ => Real.log (orderAtRate r (n + 1) * blockScale I (n + 1)) /
      ((n + 1 : ℕ) : ℝ)) atTop (𝓝 (r + I)) :=
  log_product_scale_rate (Filter.Eventually.of_forall fun _ => Real.exp_pos _)
    (Filter.Eventually.of_forall (positive_block_scale I))
    (log_pure_order_rate r) (log_block_scale_rate I)

theorem log_real_const_over_block_tendsto (x : ℝ) :
    Tendsto (fun n : ℕ => x / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 0) :=
  (tendsto_const_div_atTop_nhds_zero_nat x).comp
    (tendsto_atTop.2 fun m => (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n)))

theorem log_const_sqrt_times_order_rate {σ : ℝ} (hσ : 0 < σ) (r : ℝ) :
    Tendsto (fun n : ℕ => Real.log (orderAtRate r (n + 1) * (σ * Real.sqrt ((n + 1 : ℕ) : ℝ))) /
      ((n + 1 : ℕ) : ℝ)) atTop (𝓝 r) := by
  have hRoot : Tendsto (fun n : ℕ => Real.log (σ * Real.sqrt ((n + 1 : ℕ) : ℝ)) /
      ((n + 1 : ℕ) : ℝ)) atTop (𝓝 0) := by
    have h := (log_real_const_over_block_tendsto (Real.log σ)).add
      (successor_real_log_div_tendsto.const_mul (1 / 2 : ℝ))
    simp only [mul_zero, zero_add] at h
    apply h.congr
    intro n
    have hn : 0 < ((n + 1 : ℕ) : ℝ) := by exact_mod_cast Nat.succ_pos n
    rw [Real.log_mul hσ.ne' (Real.sqrt_pos.2 hn).ne', Real.log_sqrt hn.le, add_div]
    ring
  have h := log_product_scale_rate (Filter.Eventually.of_forall fun n : ℕ =>
    show 0 < orderAtRate r (n + 1) from Real.exp_pos _)
    (Filter.Eventually.of_forall fun n : ℕ => mul_pos hσ
      (Real.sqrt_pos.2 (by exact_mod_cast Nat.succ_pos n)))
    (log_pure_order_rate r) hRoot
  simpa only [add_zero] using h

theorem log_block_log_over_block_tendsto :
    Tendsto (fun n : ℕ => Real.log (Real.log ((n + 1 : ℕ) : ℝ)) /
      ((n + 1 : ℕ) : ℝ)) atTop (𝓝 0) := by
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds successor_real_log_div_tendsto
  · filter_upwards [(Real.tendsto_log_atTop.comp successor_real_tendsto).eventually
      (eventually_ge_atTop 1)] with n hn
    exact div_nonneg (Real.log_nonneg hn) (Nat.cast_nonneg _)
  · filter_upwards [(Real.tendsto_log_atTop.comp successor_real_tendsto).eventually
      (eventually_ge_atTop 1)] with n hn
    have hP : 0 < Real.log ((n + 1 : ℕ) : ℝ) := zero_lt_one.trans_le hn
    have h := Real.log_le_sub_one_of_pos hP
    exact div_le_div_of_nonneg_right (h.trans (sub_le_self _ zero_le_one)) (Nat.cast_nonneg _)

theorem log_endpoint_scale_rate {ell : ℝ} (he : 0 < ell) (M : ℝ) :
    Tendsto (fun n : ℕ => Real.log (orderAtRate M (n + 1) *
      (Real.log ((n + 1 : ℕ) : ℝ) / (((n + 1 : ℕ) : ℝ) * ell))) /
      ((n + 1 : ℕ) : ℝ)) atTop (𝓝 M) := by
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  have hP : ∀ᶠ n in atTop, 0 < Real.log (N n) / (N n * ell) := by
    filter_upwards [successor_real_tendsto.eventually (eventually_gt_atTop 1)] with n hn
    exact div_pos (Real.log_pos hn) (mul_pos (zero_lt_one.trans hn) he)
  have hL := log_block_log_over_block_tendsto.sub
    (successor_real_log_div_tendsto.add (log_real_const_over_block_tendsto (Real.log ell)))
  simp only [zero_add, sub_zero] at hL
  have hR : Tendsto (fun n => Real.log (Real.log (N n) / (N n * ell)) / N n) atTop (𝓝 0) := by
    apply hL.congr'
    filter_upwards [successor_real_tendsto.eventually (eventually_gt_atTop 1)] with n hn
    have hN : 0 < N n := zero_lt_one.trans hn
    rw [Real.log_div (Real.log_pos hn).ne' (mul_pos hN he).ne',
      Real.log_mul hN.ne' he.ne', sub_div, add_div]
  simpa only [add_zero] using log_product_scale_rate
    (Filter.Eventually.of_forall fun n : ℕ => show 0 < orderAtRate M (n + 1) from Real.exp_pos _)
    hP (log_pure_order_rate M) hR

theorem phase_bounded_scaled_rate {d S G : ℕ → ℝ} {r c C : ℝ}
    (hS : ∀ᶠ n in atTop, 0 < S n)
    (hRate : Tendsto (fun n => Real.log (S n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 r))
    (hc : 0 < c) (hG : ∀ n, c ≤ G n ∧ G n ≤ C)
    (hLim : Tendsto (fun n => S n * d n - G n) atTop (𝓝 0)) :
    Tendsto (fun n => -Real.log (d n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 r) := by
  have hc' : 0 < c / 2 := div_pos hc (by norm_num)
  apply normalized_deficit_rate_of_scale hS hRate hc' (C := C + c / 2)
  have h := Metric.tendsto_nhds.1 hLim (c / 2) hc'
  filter_upwards [h] with n hn
  rw [Real.dist_eq, sub_zero, abs_lt] at hn
  exact ⟨by linarith only [(hG n).1, hn.1], by linarith only [(hG n).2, hn.2]⟩

end RenyiProductOrderPhase
