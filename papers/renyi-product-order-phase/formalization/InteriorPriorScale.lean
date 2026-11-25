import TiltedLikelihoodWindow
import CriticalLargePrior
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics

/-! On the interior exponential prior scale, the log cost converges to the finite-law rate. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

noncomputable def priorFromTime (U : ℝ) : ℝ := Real.exp U - 1

theorem prior_from_time_pos {U : ℝ} (hU : 0 < U) : 0 < priorFromTime U := by
  unfold priorFromTime
  exact sub_pos.mpr (by simpa only [Real.exp_zero] using Real.exp_lt_exp.mpr hU)

theorem prior_time_exact (U : ℝ) : Real.log (1 + priorFromTime U) = U := by
  rw [show 1 + priorFromTime U = Real.exp U from by unfold priorFromTime; ring, Real.log_exp]

theorem time_from_positive_prior {a : ℝ} (ha : 0 < a) :
    0 < Real.log (1 + a) ∧ priorFromTime (Real.log (1 + a)) = a := by
  have h : 1 < 1 + a := lt_add_of_pos_right 1 ha
  refine ⟨Real.log_pos h, ?_⟩
  unfold priorFromTime
  rw [Real.exp_log (zero_lt_one.trans h), add_sub_cancel_left]

theorem successor_real_tendsto : Tendsto (fun n : ℕ => ((n + 1 : ℕ) : ℝ)) atTop atTop := by
  exact tendsto_natCast_atTop_atTop.comp
    (tendsto_atTop.2 fun m => (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n)))

theorem successor_real_log_div_tendsto :
    Tendsto (fun n : ℕ => Real.log ((n + 1 : ℕ) : ℝ) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 0) := by
  have h : Tendsto (fun t : ℝ => Real.log t / t) atTop (𝓝 0) := by
    simpa only [Real.rpow_one] using
      (isLittleO_log_rpow_atTop (r := 1) zero_lt_one).tendsto_div_nhds_zero
  exact h.comp successor_real_tendsto

noncomputable def orderAtRate (r : ℝ) (n : ℕ) : ℝ := Real.exp ((n : ℝ) * r)

theorem order_at_rate_tendsto {r : ℝ} (hr : 0 < r) :
    Tendsto (fun n : ℕ => orderAtRate r (n + 1)) atTop atTop :=
  Real.tendsto_exp_atTop.comp (successor_real_tendsto.atTop_mul_const hr)

variable {κ : Type*} [Fintype κ]

theorem inverse_order_prior_linear_bound (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i)
    (r : ℝ) (n : ℕ) {U t : ℝ} (hU : Real.log 2 ≤ U) (ht : 0 < t)
    (hB : t ≤ orderAtRate r n) :
    t * U - (n : ℝ) * inverseOrderObjective p q r t - t * (Real.log 2 + Real.log t) ≤
      negativeLogProductMoment p q n (orderAtRate r n) (priorFromTime U) := by
  have hU' : 0 < U := (Real.log_pos (by norm_num : (1 : ℝ) < 2)).trans_le hU
  have h := product_negative_log_power_lower p q hp hq n (prior_from_time_pos hU') ht hB
  have hA : U - Real.log 2 ≤ Real.log (priorFromTime U) := log_exp_sub_one_lower hU
  have hA' := mul_le_mul_of_nonneg_left hA ht.le
  unfold inverseOrderObjective orderAtRate negativeLogProductMoment
  unfold orderAtRate at h
  rw [Real.log_exp] at h
  nlinarith only [h, hA']

theorem negative_log_prior_at_tilt_scale (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {r s : ℝ} (hr : 0 < r) (hs : s < 0) (hu : 0 < -tiltedMean p q s - r) :
    let x := tiltedMean p q s
    let u := -x - r
    Tendsto (fun n : ℕ => negativeLogProductMoment p q (n + 1) (orderAtRate r (n + 1))
      (priorFromTime (((n + 1 : ℕ) : ℝ) * u)) / ((n + 1 : ℕ) : ℝ)) atTop
      (𝓝 (likelihoodRate p q x)) := by
  let x := tiltedMean p q s
  let u := -x - r
  let I := s * x - logCumulant p q s
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  let K (n : ℕ) :=
    negativeLogProductMoment p q (n + 1) (orderAtRate r (n + 1)) (priorFromTime (N n * u))
  let Cₗ := (-s) * (Real.log 2 + Real.log (-s))
  have hN (n : ℕ) : 0 < N n := by unfold N; exact_mod_cast Nat.succ_pos n
  have hN' : Tendsto N atTop atTop := successor_real_tendsto
  obtain ⟨C, hC, hUpper⟩ := product_moment_at_tilt_scale_lower p q hp hq hne hs hu
  let L (n : ℕ) := I - Cₗ / N n
  let H (n : ℕ) := I + ((1 / 2 : ℝ) * Real.log (N n) - Real.log C) / N n
  have hDiv (c : ℝ) : Tendsto (fun n => c / N n) atTop (𝓝 0) :=
    tendsto_const_div_atTop_nhds_zero_nat c |>.comp
      (tendsto_atTop.2 fun m => (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n)))
  have hL : Tendsto L atTop (𝓝 I) := by
    simpa only [L, sub_zero] using (tendsto_const_nhds.sub (hDiv Cₗ))
  have hH : Tendsto H atTop (𝓝 I) := by
    have hLog := successor_real_log_div_tendsto.const_mul (1 / 2 : ℝ)
    simpa only [H, sub_div, mul_div_assoc, mul_zero, sub_zero, add_zero] using
      (tendsto_const_nhds.add (hLog.sub (hDiv (Real.log C))))
  change Tendsto (fun n => K n / N n) atTop (𝓝 (likelihoodRate p q (tiltedMean p q s)))
  rw [likelihood_rate_at_tilt p q hp hq hne s]
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' hL hH
  · have hU := (hN'.atTop_mul_const hu).eventually (eventually_ge_atTop (Real.log 2))
    have hb := (order_at_rate_tendsto hr).eventually (eventually_ge_atTop (-s))
    filter_upwards [hU, hb] with n hn hB
    apply (le_div_iff₀ (hN n)).2
    have h := inverse_order_prior_linear_bound p q hp hq r (n + 1) hn (neg_pos.mpr hs) hB
    have he : (-s) * (N n * u) - N n * inverseOrderObjective p q r (-s) - Cₗ = N n * I - Cₗ := by
      unfold u inverseOrderObjective I
      rw [neg_neg]
      ring
    change (-s) * (N n * u) - N n * inverseOrderObjective p q r (-s) - Cₗ ≤ K n at h
    rw [he] at h
    unfold L
    rw [sub_mul, div_mul_cancel₀ _ (hN n).ne']
    simpa only [mul_comm I (N n)] using h
  · filter_upwards [hUpper] with n hn
    have hS : 0 < Real.sqrt (N n) := Real.sqrt_pos.2 (hN n)
    have h := Real.log_le_log (div_pos (mul_pos hC (Real.exp_pos _)) hS) hn
    rw [Real.log_div (mul_pos hC (Real.exp_pos _)).ne' hS.ne',
      Real.log_mul hC.ne' (Real.exp_pos _).ne', Real.log_exp, Real.log_sqrt (hN n).le] at h
    change Real.log C + -(N n * I) - Real.log (N n) / 2 ≤
      Real.log (productScalarMoment p q (n + 1) (orderAtRate r (n + 1)) (priorFromTime (N n * u))) at h
    apply (div_le_iff₀ (hN n)).2
    unfold H
    rw [add_mul, div_mul_cancel₀ _ (hN n).ne']
    unfold K negativeLogProductMoment
    linarith only [h]

end RenyiProductOrderPhase
