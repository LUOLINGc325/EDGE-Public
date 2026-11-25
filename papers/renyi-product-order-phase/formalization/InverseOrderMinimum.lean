import InteriorPriorScale

/-! Excluding sublinear priors and taking the exact inverse Rényi minimum. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def exponentialPriorCost (p q : FiniteMass κ) (r : ℝ) (n : ℕ) (U : ℝ) : ℝ :=
  negativeLogProductMoment p q n (orderAtRate r n) (priorFromTime U) / U

theorem exponential_prior_exact_scale (p q : FiniteMass κ) (r : ℝ) (n : ℕ) {U : ℝ}
    (hU : 0 < U) :
    exponentialPriorCost p q r n U = orderAtRate r n *
      productScalarDeficit p q n (orderAtRate r n) (priorFromTime U) := by
  unfold exponentialPriorCost negativeLogProductMoment productScalarDeficit
  rw [prior_time_exact]
  have hB : 0 < orderAtRate r n := Real.exp_pos _
  field_simp [hU.ne', hB.ne']
  ring

theorem small_inverse_order_negative (p q : FiniteMass κ) (r : ℝ)
    (hD : -tiltedMean p q 0 < r) :
    ∃ t > 0, inverseOrderObjective p q r t < 0 := by
  let F := inverseOrderObjective p q r
  let G := inverseOrderSlope p q r
  have h0 : G 0 < 0 := by unfold G inverseOrderSlope; rw [neg_zero]; exact sub_neg.mpr hD
  obtain ⟨δ, hδ, hBall⟩ := Metric.isOpen_iff.mp
    (isOpen_Iio.preimage (inverse_order_slope_continuous p q r)) 0 h0
  let t := δ / 2
  have ht : 0 < t := div_pos hδ (by norm_num)
  have hC : Continuous F :=
    continuous_iff_continuousAt.2 (fun x => (inverse_order_derivative p q r x).continuousAt)
  have hAnti : StrictAntiOn F (Icc 0 t) := by
    apply strictAntiOn_of_deriv_neg (convex_Icc 0 t) hC.continuousOn
    intro x hx
    rw [interior_Icc] at hx
    rw [(inverse_order_derivative p q r x).deriv]
    apply hBall
    rw [Metric.mem_ball, Real.dist_eq, sub_zero, abs_of_pos hx.1]
    exact hx.2.trans (by unfold t; linarith only [hδ])
  have hZ : F 0 = 0 := by simp only [F, inverseOrderObjective, neg_zero, log_cumulant_zero, mul_zero, sub_zero]
  refine ⟨t, ht, ?_⟩
  rw [← hZ]
  exact hAnti ⟨le_rfl, ht.le⟩ ⟨ht.le, le_rfl⟩ ht

theorem inverse_order_one_prior_linear (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) {r : ℝ}
    (hr : 0 < r) (hD : -tiltedMean p q 0 < r) :
    ∃ c > 0, ∀ᶠ n : ℕ in atTop, c * ((n + 1 : ℕ) : ℝ) ≤
      negativeLogProductMoment p q (n + 1) (orderAtRate r (n + 1)) 1 := by
  obtain ⟨t, ht, hNeg⟩ := small_inverse_order_negative p q r hD
  let c := -inverseOrderObjective p q r t / 2
  have hc : 0 < c := div_pos (neg_pos.mpr hNeg) (by norm_num)
  refine ⟨c, hc, ?_⟩
  filter_upwards [(order_at_rate_tendsto hr).eventually (eventually_ge_atTop t),
    successor_real_tendsto.eventually (eventually_ge_atTop (t * Real.log t / c))] with n hB hn
  have h := product_negative_log_power_lower p q hp hq (n + 1) zero_lt_one ht hB
  unfold orderAtRate at h
  rw [Real.log_exp, Real.log_one, add_zero] at h
  have hLarge := (div_le_iff₀ hc).1 hn
  unfold c inverseOrderObjective at *
  unfold negativeLogProductMoment orderAtRate
  nlinarith only [h, hLarge]

theorem inverse_order_candidate_cost (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {r β : ℝ} (hr : 0 < r) (hβ : 0 < β)
    (hRoot : logCumulant p q (-β) = r * β)
    (hu : 0 < inverseOrderSlope p q r β) :
    let u := inverseOrderSlope p q r β
    Tendsto (fun n : ℕ => exponentialPriorCost p q r (n + 1) (((n + 1 : ℕ) : ℝ) * u))
      atTop (𝓝 β) := by
  let u := inverseOrderSlope p q r β
  have hRate : likelihoodRate p q (tiltedMean p q (-β)) = β * u := by
    rw [likelihood_rate_at_tilt p q hp hq hne, hRoot]
    unfold u inverseOrderSlope
    ring
  have h := negative_log_prior_at_tilt_scale p q hp hq hne hr (neg_lt_zero.mpr hβ) hu
  change Tendsto (fun n : ℕ => negativeLogProductMoment p q (n + 1) (orderAtRate r (n + 1))
    (priorFromTime (((n + 1 : ℕ) : ℝ) * u)) / ((n + 1 : ℕ) : ℝ)) atTop
    (𝓝 (likelihoodRate p q (tiltedMean p q (-β)))) at h
  rw [hRate] at h
  have hU : 0 < u := hu
  have he := h.div_const u
  rw [mul_div_cancel_right₀ _ hU.ne'] at he
  simpa only [exponentialPriorCost, div_div] using he

theorem inverse_order_approximate_values (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {r β : ℝ} (hr : 0 < r) (hD : -tiltedMean p q 0 < r) (hβ : 0 < β)
    (hRoot : logCumulant p q (-β) = r * β) (hu : 0 < inverseOrderSlope p q r β)
    (U e : ℕ → ℝ) (hU : ∀ᶠ n in atTop, 0 < U n) (he : Tendsto e atTop (𝓝 0))
    (hOpt : ∀ᶠ n in atTop, ∀ t > 0, exponentialPriorCost p q r (n + 1) (U n) ≤
      exponentialPriorCost p q r (n + 1) t + e n) :
    Tendsto (fun n => exponentialPriorCost p q r (n + 1) (U n)) atTop (𝓝 β) ∧
      (∃ d > 0, ∀ᶠ n : ℕ in atTop, d * ((n + 1 : ℕ) : ℝ) ≤ U n) := by
  let u := inverseOrderSlope p q r β
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  let H (n : ℕ) := exponentialPriorCost p q r (n + 1) (N n * u) + e n
  let V (n : ℕ) := exponentialPriorCost p q r (n + 1) (U n)
  have hN (n : ℕ) : 0 < N n := by unfold N; exact_mod_cast Nat.succ_pos n
  have hH : Tendsto H atTop (𝓝 β) := by
    simpa only [H, add_zero] using (inverse_order_candidate_cost p q hp hq hne hr hβ hRoot hu).add he
  have hHigh : ∀ᶠ n in atTop, V n ≤ H n :=
    hOpt.mono (fun n hn => hn _ (mul_pos (hN n) hu))
  obtain ⟨c, hc, hOne⟩ := inverse_order_one_prior_linear p q hp hq hr hD
  let d := c / (β + 1)
  have hB' : 0 < β + 1 := add_pos hβ zero_lt_one
  have hd : 0 < d := div_pos hc hB'
  have hTime : ∀ᶠ n : ℕ in atTop, Real.log 2 ≤ U n ∧ d * N n ≤ U n := by
    have hLarge := (successor_real_tendsto.const_mul_atTop hc).eventually (eventually_gt_atTop (β + 1))
    filter_upwards [hU, hHigh, hH.eventually (gt_mem_nhds (lt_add_of_pos_right β zero_lt_one)), hOne, hLarge]
      with n hn hV hHn hKn hBig
    let a := priorFromTime (U n)
    let b := orderAtRate r (n + 1)
    let K := negativeLogProductMoment p q (n + 1) b
    have ha : 0 < a := prior_from_time_pos hn
    have hb : 0 < b := Real.exp_pos _
    have hBound : V n ≤ β + 1 := hV.trans hHn.le
    have hBeta : K a ≤ (β + 1) * U n := (div_le_iff₀ hn).1 hBound
    have hLog : Real.log 2 ≤ U n := by
      by_contra! hS
      have hA : a ≤ 1 := by
        have h := Real.exp_le_exp.mpr hS.le
        rw [Real.exp_log (by norm_num : (0 : ℝ) < 2)] at h
        unfold a priorFromTime
        linarith only [h]
      have hA' : U n ≤ a := by
        rw [← prior_time_exact (U n)]
        exact (log_one_add_bounds ha.le).2
      have h := negative_log_product_moment_small_prior p q hp hq (n + 1) hb ha.le hA
      have hb₀ : 0 ≤ K 1 := (mul_pos hc (hN n)).le.trans hKn
      have hK := mul_le_mul_of_nonneg_right hA' hb₀
      have hBig' : (β + 1) * U n < K 1 * U n :=
        mul_lt_mul_of_pos_right (hBig.trans_le hKn) hn
      have hFinal : U n * K 1 ≤ (β + 1) * U n := hK.trans (h.trans hBeta)
      rw [mul_comm (U n) (K 1)] at hFinal
      exact (not_lt_of_ge hFinal) hBig'
    have hA : 1 ≤ a := by
      have h := Real.exp_le_exp.mpr hLog
      rw [Real.exp_log (by norm_num : (0 : ℝ) < 2)] at h
      unfold a priorFromTime
      linarith only [h]
    have hK := negative_log_product_moment_mono p q hp hq (n + 1) hb
      (show (1 : ℝ) ∈ Ici 0 from mem_Ici.mpr zero_le_one) (mem_Ici.mpr ha.le) hA
    refine ⟨hLog, ?_⟩
    have hh := hKn.trans (hK.trans hBeta)
    have hdM : d * N n = (c * N n) / (β + 1) := by unfold d; rw [div_mul_eq_mul_div]
    rw [hdM]
    exact (div_le_iff₀ hB').2 (by simpa only [mul_comm (β + 1)] using hh)
  refine ⟨?_, d, hd, hTime.mono (fun _ h => h.2)⟩
  have hUT : Tendsto U atTop atTop := by
    apply tendsto_atTop.2
    intro M
    filter_upwards [hTime, (successor_real_tendsto.const_mul_atTop hd).eventually (eventually_ge_atTop M)]
      with n hn hM
    exact hM.trans hn.2
  let C := β * (Real.log 2 + Real.log β)
  let L (n : ℕ) := β - C / U n
  have hCU : Tendsto (fun n => C / U n) atTop (𝓝 0) := by
    apply Metric.tendsto_nhds.2
    intro ε hε
    filter_upwards [hUT.eventually (eventually_gt_atTop (|C| / ε + 1)), hU] with n hn hn₀
    rw [Real.dist_eq, sub_zero, abs_div, abs_of_pos hn₀]
    exact (div_lt_iff₀ hn₀).2 (by
      have he := (div_lt_iff₀ hε).1 ((lt_add_of_pos_right (|C| / ε) zero_lt_one).trans hn)
      simpa only [mul_comm] using he)
  have hL : Tendsto L atTop (𝓝 β) := by
    simpa only [L, sub_zero] using (tendsto_const_nhds.sub hCU)
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' hL hH _ hHigh
  filter_upwards [hTime, hU, (order_at_rate_tendsto hr).eventually (eventually_ge_atTop β)]
    with n hn hn₀ hB
  have h := inverse_order_prior_linear_bound p q hp hq r (n + 1) hn.1 hβ hB
  have hZero : inverseOrderObjective p q r β = 0 := sub_eq_zero.mpr hRoot
  rw [hZero, mul_zero, sub_zero] at h
  change L n ≤ _ / U n
  apply (le_div_iff₀ hn₀).2
  unfold L
  rw [sub_mul, div_mul_cancel₀ _ hn₀.ne']
  exact h

end RenyiProductOrderPhase
