import DeficitScaleRates
import ArithmeticOptimizedLimits

/-! The manuscript's fixed-order and exponential-order logarithmic exponents. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem finite_positive_likelihood_nonconstant (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) :
    ∃ i j, logLikelihood p q i ≠ logLikelihood p q j := by
  obtain ⟨i, j, h⟩ := ratio_nonconstant p q hp hne
  refine ⟨i, j, fun hL => h ?_⟩
  have he := congrArg Real.exp hL
  unfold logLikelihood at he
  rwa [Real.exp_log (div_pos (hq i) (hp i)), Real.exp_log (div_pos (hq j) (hp j))] at he

theorem fixed_order_normalized_channel_exponent (w : BinarySymmetricChannel κ)
    {b : ℝ} (hb : 1 ≤ b) :
    Tendsto (fun n : ℕ => -Real.log (channelProductDeficit w (n + 1) b) / ((n + 1 : ℕ) : ℝ))
      atTop (𝓝 (-logCumulant (w.channel false) (w.channel true) (1 / 2))) := by
  let p := w.channel false
  let q := w.channel true
  let θ : ℝ := 1 / 2
  let I := -logCumulant p q θ
  let found (n : ℕ) := sInf (productDeficitValues p q (n + 1) b)
  let S (n : ℕ) := b * blockScale I (n + 1)
  have hθ : 0 < θ := by unfold θ; norm_num
  have hθ₁ : θ < 1 := by unfold θ; norm_num
  have hm : tiltedMean p q θ = 0 := w.halfway_tilt_centered
  have hp := w.positive false
  have hq := w.positive true
  have hb₀ := zero_lt_one.trans_le hb
  have hS : ∀ᶠ n in atTop, 0 < S n := Filter.Eventually.of_forall
    (fun n => mul_pos hb₀ (positive_block_scale I n))
  have hL : Tendsto (fun n => Real.log (S n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 I) := by
    simpa only [zero_add] using log_product_scale_rate
      (Filter.Eventually.of_forall (fun _ => hb₀))
      (Filter.Eventually.of_forall (positive_block_scale I))
      (log_real_const_over_block_tendsto (Real.log b)) (log_block_scale_rate I)
  have hCore : Tendsto (fun n => -Real.log (found n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 I) := by
    by_cases hA : ArithmeticSupport (logLikelihood p q)
    · obtain ⟨L⟩ := maximal_lattice_exists (finite_positive_likelihood_nonconstant p q hp hq w.informative) hA
      obtain ⟨hLim, _, c, hc, C, _, hBound⟩ :=
        arithmetic_fixed_optimized_limit p q hp hq w.informative L hb hθ hθ₁ hm
      exact phase_bounded_scaled_rate hS hL hc hBound hLim
    · obtain ⟨a, ha, _, hLim⟩ :=
        nonarithmetic_fixed_exact_limit p q hp hq w.informative hA hb hθ hθ₁ hm
      have hv := tilted_variance_pos p q hp hq w.informative θ
      have hc : 0 < fixedTiltConstant (tiltedVariance p q θ) b θ := mul_pos (gaussian_height_pos hv)
        (div_pos (mul_pos (Real.Gamma_pos_of_pos (sub_pos.mpr hθ₁))
          (Real.Gamma_pos_of_pos (add_pos hb₀ hθ))) (mul_pos hθ (Real.Gamma_pos_of_pos hb₀)))
      exact normalized_deficit_rate_of_positive_limit hS hL (mul_pos hc (prior_cost_positive ha)) hLim
  apply hCore.congr
  intro n
  unfold found channelProductDeficit
  rw [product_contraction_deficit w (Nat.succ_pos n) b hb]

theorem below_kl_normalized_channel_exponent (w : BinarySymmetricChannel κ) {r : ℝ}
    (hr : 0 < r) (hD : r < klMean (w.channel false) (w.channel true)) :
    Tendsto (fun n : ℕ => -Real.log (channelProductDeficit w (n + 1) (orderAtRate r (n + 1))) /
      ((n + 1 : ℕ) : ℝ)) atTop (𝓝 (r + likelihoodRate (w.channel false) (w.channel true) (-r))) := by
  let p := w.channel false
  let q := w.channel true
  have hp := w.positive false
  have hq := w.positive true
  obtain ⟨θ, hθ, _⟩ := w.unique_tilt_saddle hr hD
  have θ₀ : 0 < θ := hθ.1.1
  have θ₁ : θ < 1 := hθ.1.2.trans (by norm_num)
  have hm : tiltedMean p q θ = -r := hθ.2
  let I := -(logCumulant p q θ + θ * r)
  have hI : likelihoodRate p q (-r) = I := by
    have h := likelihood_rate_at_tilt p q hp hq w.informative θ
    rw [hm] at h
    rw [h]
    unfold I
    ring
  let B (n : ℕ) := orderAtRate r (n + 1)
  let S (n : ℕ) := B n * blockScale I (n + 1)
  let found (n : ℕ) := sInf (productDeficitValues p q (n + 1) (B n))
  have hS : ∀ᶠ n in atTop, 0 < S n := Filter.Eventually.of_forall
    (fun n => mul_pos (Real.exp_pos _) (positive_block_scale I n))
  have hR : Tendsto (fun n => Real.log (S n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 (r + I)) :=
    log_order_block_scale_rate r I
  have hCore : Tendsto (fun n => -Real.log (found n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 (r + I)) := by
    by_cases hA : ArithmeticSupport (logLikelihood p q)
    · obtain ⟨L⟩ := maximal_lattice_exists (finite_positive_likelihood_nonconstant p q hp hq w.informative) hA
      obtain ⟨hLim, _, c, hc, C, _, hBound⟩ :=
        arithmetic_growing_optimized_limit p q hp hq w.informative L hr θ₀ θ₁ hm
      exact phase_bounded_scaled_rate hS hR hc hBound hLim
    · obtain ⟨a, ha, _, hLim⟩ :=
        nonarithmetic_growing_exact_limit p q hp hq w.informative hA hr θ₀ θ₁ hm
      have hv := tilted_variance_pos p q hp hq w.informative θ
      have hc : 0 < growingTiltConstant (tiltedVariance p q θ) θ := mul_pos (gaussian_height_pos hv)
        (div_pos (Real.Gamma_pos_of_pos (sub_pos.mpr θ₁)) θ₀)
      exact normalized_deficit_rate_of_positive_limit hS hR (mul_pos hc (prior_cost_positive ha)) hLim
  change Tendsto _ atTop (𝓝 (r + likelihoodRate p q (-r)))
  rw [hI]
  apply hCore.congr
  intro n
  have hB : 1 ≤ B n := by
    unfold B orderAtRate
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr (mul_nonneg (Nat.cast_nonneg _) hr.le)
  unfold found channelProductDeficit
  rw [product_contraction_deficit w (Nat.succ_pos n) (B n) hB]

theorem normalized_channel_exponent_critical (w : BinarySymmetricChannel κ) :
    let D := klMean (w.channel false) (w.channel true)
    Tendsto (fun n : ℕ => -Real.log (channelProductDeficit w (n + 1) (orderAtRate D (n + 1))) /
      ((n + 1 : ℕ) : ℝ)) atTop (𝓝 D) := by
  let p := w.channel false
  let q := w.channel true
  let D := klMean p q
  let σ := klSigma p q
  have hp := w.positive false
  have hq := w.positive true
  have hD : 0 < D := kl_mean_pos p q hp hq w.informative
  have hσ : 0 < σ := kl_sigma_pos p q hp hq w.informative
  let B (n : ℕ) := orderAtRate D (n + 1)
  let S (n : ℕ) := B n * (σ * Real.sqrt ((n + 1 : ℕ) : ℝ))
  let found (n : ℕ) := sInf (productDeficitValues p q (n + 1) (B n))
  have hB (n : ℕ) : criticalOrder p q 0 (n + 1) = B n := by
    simp only [B, criticalOrder, orderAtRate, zero_mul, add_zero, D]
  have hS : ∀ᶠ n : ℕ in atTop, 0 < S n := Filter.Eventually.of_forall (fun n =>
    mul_pos (Real.exp_pos _) (mul_pos hσ (Real.sqrt_pos.2 (by exact_mod_cast Nat.succ_pos n))))
  obtain ⟨a, ha, _, hLim, _⟩ := critical_exact_coefficient_limit p q hp hq w.informative 0
  have hA : 0 < criticalGaussianCost 0 a := by
    unfold criticalGaussianCost normalLogTail
    exact div_pos (neg_pos.mpr (Real.log_neg (standard_normal_tail_bounds _).1
      (standard_normal_tail_bounds _).2)) ha
  have hL : Tendsto (fun n => S n * found n) atTop (𝓝 (criticalGaussianCost 0 a)) := by
    apply hLim.congr
    intro n
    rw [hB n]
    rfl
  have h := normalized_deficit_rate_of_positive_limit hS (log_const_sqrt_times_order_rate hσ D) hA hL
  apply h.congr
  intro n
  have hb : 1 ≤ B n := by
    unfold B orderAtRate
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr (mul_nonneg (Nat.cast_nonneg _) hD.le)
  unfold found channelProductDeficit
  rw [product_contraction_deficit w (Nat.succ_pos n) (B n) hb]

theorem endpoint_likelihood_has_nonminimal_atom (p q : FiniteMass κ) {M : ℝ}
    (hM : ∀ i, -M ≤ logLikelihood p q i) (hAtom : endpointAtomMass p q M < 1) :
    ∃ i, -M < logLikelihood p q i := by
  classical
  by_contra! h
  have hEqual (i : κ) : logLikelihood p q i = -M := (h i).antisymm (hM i)
  simp only [endpointAtomMass, hEqual, if_pos rfl, if_true, FiniteMass.expect_const, lt_irrefl] at hAtom

theorem normalized_channel_exponent_inverse (w : BinarySymmetricChannel κ) {r M : ℝ}
    (hD : klMean (w.channel false) (w.channel true) < r) (hrM : r < M)
    (hM : ∀ i, -M ≤ logLikelihood (w.channel false) (w.channel true) i)
    (hAtom : ∃ i, logLikelihood (w.channel false) (w.channel true) i = -M)
    (hAtom' : endpointAtomMass (w.channel false) (w.channel true) M < 1) :
    Tendsto (fun n : ℕ => -Real.log (channelProductDeficit w (n + 1) (orderAtRate r (n + 1))) /
      ((n + 1 : ℕ) : ℝ)) atTop (𝓝 r) := by
  let p := w.channel false
  let q := w.channel true
  have hp := w.positive false
  have hq := w.positive true
  have hr := (kl_mean_pos p q hp hq w.informative).trans hD
  let B (n : ℕ) := orderAtRate r (n + 1)
  let found (n : ℕ) := sInf (productDeficitValues p q (n + 1) (B n))
  have hS : ∀ᶠ n in atTop, 0 < B n := Filter.Eventually.of_forall (fun _ => Real.exp_pos _)
  obtain ⟨β, hβ, _, _, _, hLim, _⟩ := inverse_order_exact_coefficient_limit p q hp hq w.informative
    hD hrM hM hAtom (endpoint_likelihood_has_nonminimal_atom p q hM hAtom')
  have h := normalized_deficit_rate_of_positive_limit (d := found) hS (log_pure_order_rate r) hβ hLim
  apply h.congr
  intro n
  have hb : 1 ≤ B n := by
    unfold B orderAtRate
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr (mul_nonneg (Nat.cast_nonneg _) hr.le)
  unfold found channelProductDeficit
  rw [product_contraction_deficit w (Nat.succ_pos n) (B n) hb]

theorem normalized_channel_exponent_at_maximum (w : BinarySymmetricChannel κ) {M : ℝ}
    (hM₀ : 0 < M) (hM : ∀ i, -M ≤ logLikelihood (w.channel false) (w.channel true) i)
    (hm : 0 < endpointAtomMass (w.channel false) (w.channel true) M)
    (hm' : endpointAtomMass (w.channel false) (w.channel true) M < 1) :
    Tendsto (fun n : ℕ => -Real.log (channelProductDeficit w (n + 1) (orderAtRate M (n + 1))) /
      ((n + 1 : ℕ) : ℝ)) atTop (𝓝 M) := by
  let p := w.channel false
  let q := w.channel true
  let ell := endpointLogRate p q M
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  let B (n : ℕ) := orderAtRate M (n + 1)
  let S (n : ℕ) := B n * (Real.log (N n) / (N n * ell))
  let found (n : ℕ) := sInf (productDeficitValues p q (n + 1) (B n))
  have hEll : 0 < ell := neg_pos.mpr (Real.log_neg hm hm')
  have hS : ∀ᶠ n in atTop, 0 < S n := by
    filter_upwards [successor_real_tendsto.eventually (eventually_gt_atTop 1)] with n hn
    exact mul_pos (Real.exp_pos _) (div_pos (Real.log_pos hn) (mul_pos (zero_lt_one.trans hn) hEll))
  have h := (endpoint_exact_coefficient_limits p q (w.positive false) (w.positive true)
    w.informative hM₀ hM hm hm').2
  have hLim : Tendsto (fun n => S n * found n) atTop (𝓝 1) := by
    apply h.congr
    intro n
    change (B n * found n) / ((N n * ell) / Real.log (N n)) = S n * found n
    unfold S
    rw [div_eq_mul_inv, inv_div]
    ring
  have hE := normalized_deficit_rate_of_positive_limit hS (log_endpoint_scale_rate hEll M) zero_lt_one hLim
  apply hE.congr
  intro n
  have hb : 1 ≤ B n := by
    unfold B orderAtRate
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr (mul_nonneg (Nat.cast_nonneg _) hM₀.le)
  unfold found channelProductDeficit
  rw [product_contraction_deficit w (Nat.succ_pos n) (B n) hb]

theorem normalized_channel_exponent_above_maximum (w : BinarySymmetricChannel κ) {M r : ℝ}
    (hM₀ : 0 ≤ M) (hM : ∀ i, -M ≤ logLikelihood (w.channel false) (w.channel true) i)
    (hm : 0 < endpointAtomMass (w.channel false) (w.channel true) M)
    (hm' : endpointAtomMass (w.channel false) (w.channel true) M < 1) (hr : M < r) :
    Tendsto (fun n : ℕ => -Real.log (channelProductDeficit w (n + 1) (orderAtRate r (n + 1))) /
      ((n + 1 : ℕ) : ℝ)) atTop (𝓝 M) := by
  let p := w.channel false
  let q := w.channel true
  let B (n : ℕ) := orderAtRate r (n + 1)
  let S (n : ℕ) := orderAtRate M (n + 1)
  let found (n : ℕ) := sInf (productDeficitValues p q (n + 1) (B n))
  have hS : ∀ᶠ n in atTop, 0 < S n := Filter.Eventually.of_forall (fun _ => Real.exp_pos _)
  have hL := super_endpoint_optimized_saturation p q (w.positive false) (w.positive true)
    w.informative hM₀ hM hm hm' hr
  have hLim : Tendsto (fun n => S n * found n) atTop (𝓝 1) := by
    apply hL.congr
    intro n
    change found n / endpointEpsilon M (n + 1) = S n * found n
    unfold S orderAtRate endpointEpsilon
    rw [div_eq_mul_inv, ← Real.exp_neg]
    rw [show -(-((n + 1 : ℕ) : ℝ) * M) = ((n + 1 : ℕ) : ℝ) * M by ring, mul_comm]
  have hE := normalized_deficit_rate_of_positive_limit hS (log_pure_order_rate M) zero_lt_one hLim
  apply hE.congr
  intro n
  have hb : 1 ≤ B n := by
    unfold B orderAtRate
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr
      (mul_nonneg (Nat.cast_nonneg _) (hM₀.trans hr.le))
  unfold found channelProductDeficit
  rw [product_contraction_deficit w (Nat.succ_pos n) (B n) hb]

theorem normalized_channel_exponent_all_rates (w : BinarySymmetricChannel κ) {r M : ℝ}
    (hr : 0 < r) (hDM : klMean (w.channel false) (w.channel true) < M)
    (hM : ∀ i, -M ≤ logLikelihood (w.channel false) (w.channel true) i)
    (hAtom : ∃ i, logLikelihood (w.channel false) (w.channel true) i = -M)
    (hm : 0 < endpointAtomMass (w.channel false) (w.channel true) M)
    (hm' : endpointAtomMass (w.channel false) (w.channel true) M < 1) :
    let p := w.channel false
    let q := w.channel true
    let D := klMean p q
    Tendsto (fun n : ℕ => -Real.log (channelProductDeficit w (n + 1) (orderAtRate r (n + 1))) /
      ((n + 1 : ℕ) : ℝ))
      atTop (𝓝 (if r < D then r + likelihoodRate p q (-r) else min r M)) := by
  let D := klMean (w.channel false) (w.channel true)
  have hM₀ : 0 < M := (kl_mean_pos _ _ (w.positive false) (w.positive true) w.informative).trans hDM
  change Tendsto _ atTop (𝓝 (if r < D then _ else _))
  rcases lt_trichotomy r D with h | h | h
  · rw [if_pos h]
    exact below_kl_normalized_channel_exponent w hr h
  · rw [if_neg h.not_lt, min_eq_left (h.trans_le hDM.le), h]
    exact normalized_channel_exponent_critical w
  · rw [if_neg (not_lt_of_ge h.le)]
    rcases lt_trichotomy r M with hrM | hrM | hrM
    · rw [min_eq_left hrM.le]
      exact normalized_channel_exponent_inverse w h hrM hM hAtom hm'
    · rw [min_eq_right hrM.ge, hrM]
      exact normalized_channel_exponent_at_maximum w hM₀ hM hm hm'
    · rw [min_eq_right hrM.le]
      exact normalized_channel_exponent_above_maximum w hM₀.le hM hm hm' hrM

theorem order_first_channel_exponent (w : BinarySymmetricChannel κ) (n : ℕ) (hn : 0 < n)
    {M : ℝ} (hM₀ : 0 ≤ M) (hM : ∀ i, -M ≤ logLikelihood (w.channel false) (w.channel true) i)
    (hm : 0 < endpointAtomMass (w.channel false) (w.channel true) M) :
    Tendsto (fun b : ℝ => -Real.log (channelProductDeficit w n b) / (n : ℝ)) atTop (𝓝 M) := by
  let e := endpointEpsilon M n
  have he : 0 < e := Real.exp_pos _
  have h := fixed_block_order_first_saturation _ _ (w.positive false) (w.positive true) w.informative
    n hn hM₀ hM hm
  have hD : Tendsto (channelProductDeficit w n) atTop (𝓝 e) := by
    apply h.congr'
    filter_upwards [eventually_ge_atTop (1 : ℝ)] with b hb
    exact (product_contraction_deficit w hn b hb).symm
  have hT := (((Real.continuousAt_log he.ne').tendsto.comp hD).neg).div_const (n : ℝ)
  have hn₀ : 0 < (n : ℝ) := by exact_mod_cast hn
  unfold e endpointEpsilon at hT
  rw [Real.log_exp, neg_mul, neg_neg, mul_div_cancel_left₀ _ hn₀.ne'] at hT
  exact hT

theorem fixed_chernoff_below_maximum (w : BinarySymmetricChannel κ) {M : ℝ}
    (hM₀ : 0 < M) (hM : ∀ i, -M ≤ logLikelihood (w.channel false) (w.channel true) i) :
    -logCumulant (w.channel false) (w.channel true) (1 / 2) < M := by
  let p := w.channel false
  let q := w.channel true
  let a := Real.exp (-(M / 2))
  have hp : 0 < a := Real.exp_pos _
  have h := p.expect_mono (f := fun _ => a)
    (g := fun i => Real.exp ((1 / 2) * logLikelihood p q i))
    (fun i => Real.exp_le_exp.2 (by linarith only [hM i]))
  rw [p.expect_const] at h
  have hLog := Real.log_le_log hp h
  change Real.log a ≤ logCumulant p q (1 / 2) at hLog
  unfold a at hLog
  rw [Real.log_exp] at hLog
  linarith only [hLog, hM₀]

end RenyiProductOrderPhase
