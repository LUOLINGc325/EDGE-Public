import InverseOrderMinimum
import EndpointPriorBounds

/-! Interior soft-threshold rates for arbitrary asymptotically linear priors. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem moving_log_prior_at_tilt_scale (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {r s : ℝ} (hr : 0 < r) (hs : s < 0) (hu : 0 < -tiltedMean p q s - r)
    (U : ℕ → ℝ)
    (hU : Tendsto (fun n => U n / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 (-tiltedMean p q s - r))) :
    Tendsto (fun n => negativeLogProductMoment p q (n + 1) (orderAtRate r (n + 1))
      (priorFromTime (U n)) / ((n + 1 : ℕ) : ℝ))
      atTop (𝓝 (likelihoodRate p q (tiltedMean p q s))) := by
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  let u (t : ℝ) := -tiltedMean p q t - r
  let I (t : ℝ) := t * tiltedMean p q t - logCumulant p q t
  let V (n : ℕ) (t : ℝ) := negativeLogProductMoment p q (n + 1) (orderAtRate r (n + 1)) (priorFromTime t) / N n
  have hN (n : ℕ) : 0 < N n := by unfold N; exact_mod_cast Nat.succ_pos n
  have hUC : Continuous u := by
    have h : Continuous (tiltedMean p q) := continuous_iff_continuousAt.2 fun t =>
      (hasDerivAt_tilted_mean p q t).continuousAt
    exact h.neg.sub continuous_const
  have hIC : Continuous I := by
    have h : Continuous (tiltedMean p q) := continuous_iff_continuousAt.2 fun t =>
      (hasDerivAt_tilted_mean p q t).continuousAt
    have hψ : Continuous (logCumulant p q) := continuous_iff_continuousAt.2 fun t =>
      (hasDerivAt_log_cumulant p q t).continuousAt
    exact (continuous_id.mul h).sub hψ
  have hAnti : StrictAnti u := fun a b hab =>
    sub_lt_sub_right (neg_lt_neg (tilted_mean_strict_mono p q hp hq hne hab)) r
  have hFixed (t : ℝ) (ht : t < 0) (ht' : 0 < u t) :
      Tendsto (fun n => V n (N n * u t)) atTop (𝓝 (I t)) := by
    have h := negative_log_prior_at_tilt_scale p q hp hq hne hr ht ht'
    change Tendsto (fun n => V n (N n * u t)) atTop (𝓝 (likelihoodRate p q (tiltedMean p q t))) at h
    rw [likelihood_rate_at_tilt p q hp hq hne t] at h
    exact h
  have hMono (n : ℕ) : MonotoneOn (V n) (Ioi 0) := by
    intro t ht v hv htv
    have hb : 0 < orderAtRate r (n + 1) := Real.exp_pos _
    have hP : priorFromTime t ≤ priorFromTime v := by
      unfold priorFromTime
      exact sub_le_sub_right (Real.exp_le_exp.mpr htv) 1
    have h := negative_log_product_moment_mono p q hp hq (n + 1) hb
      (mem_Ici.mpr (prior_from_time_pos (mem_Ioi.mp ht)).le)
      (mem_Ici.mpr (prior_from_time_pos (mem_Ioi.mp hv)).le) hP
    exact div_le_div_of_nonneg_right h (hN n).le
  rw [likelihood_rate_at_tilt p q hp hq hne s]
  change Tendsto (fun n => V n (U n)) atTop (𝓝 (I s))
  apply Metric.tendsto_nhds.2
  intro ε hε
  have he : 0 < ε / 2 := div_pos hε (by norm_num)
  have hI : ∀ᶠ t in 𝓝 s, |I t - I s| < ε / 2 := by
    have h := Metric.tendsto_nhds.1 (hIC.tendsto s) (ε / 2) he
    exact h.mono (fun _ ht => by simpa only [Real.dist_eq] using ht)
  have hOpen : ∀ᶠ t in 𝓝 s, t < 0 ∧ 0 < u t ∧ |I t - I s| < ε / 2 :=
    (show ∀ᶠ t in 𝓝 s, t < 0 from Iio_mem_nhds hs).and
      (((hUC.tendsto s).eventually (lt_mem_nhds (show 0 < u s from hu))).and hI)
  obtain ⟨δ, hδ, hBall⟩ := Metric.mem_nhds_iff.mp hOpen
  let d := δ / 2
  let t₁ := s - d
  let t₂ := s + d
  have hd : 0 < d := div_pos hδ (by norm_num)
  have hd' : d < δ := by unfold d; linarith only [hδ]
  have ht₁ : t₁ < s := sub_lt_self _ hd
  have ht₂ : s < t₂ := lt_add_of_pos_right _ hd
  have h₁ := hBall (show t₁ ∈ Metric.ball s δ from by
    rw [Metric.mem_ball, Real.dist_eq, show t₁ - s = -d by unfold t₁; ring, abs_neg, abs_of_pos hd]
    exact hd')
  have h₂ := hBall (show t₂ ∈ Metric.ball s δ from by
    rw [Metric.mem_ball, Real.dist_eq, show t₂ - s = d by unfold t₂; ring, abs_of_pos hd]
    exact hd')
  change t₁ < 0 ∧ 0 < u t₁ ∧ |I t₁ - I s| < ε / 2 at h₁
  change t₂ < 0 ∧ 0 < u t₂ ∧ |I t₂ - I s| < ε / 2 at h₂
  have hA := Metric.tendsto_nhds.1 (hFixed t₁ h₁.1 h₁.2.1) (ε / 2) he
  have hB := Metric.tendsto_nhds.1 (hFixed t₂ h₂.1 h₂.2.1) (ε / 2) he
  have hLo := hU.eventually (lt_mem_nhds (hAnti ht₂))
  have hHi := hU.eventually (gt_mem_nhds (hAnti ht₁))
  filter_upwards [hA, hB, hLo, hHi] with n hn₁ hn₂ hLower hUpper
  have hL : N n * u t₂ ≤ U n := by
    have h := (lt_div_iff₀ (hN n)).1 hLower
    simpa only [mul_comm] using h.le
  have hR : U n ≤ N n * u t₁ := by
    have h := (div_lt_iff₀ (hN n)).1 hUpper
    simpa only [mul_comm] using h.le
  have hU₀ : 0 < U n := (mul_pos (hN n) h₂.2.1).trans_le hL
  have hLow := hMono n (mem_Ioi.mpr (mul_pos (hN n) h₂.2.1)) (mem_Ioi.mpr hU₀) hL
  have hUp := hMono n (mem_Ioi.mpr hU₀) (mem_Ioi.mpr (mul_pos (hN n) h₁.2.1)) hR
  rw [Real.dist_eq] at hn₁ hn₂ ⊢
  apply abs_lt.mpr
  constructor
  · calc
      -ε = -(ε / 2) + -(ε / 2) := by ring
      _ < (V n (N n * u t₂) - I t₂) + (I t₂ - I s) :=
        add_lt_add (abs_lt.mp hn₂).1 (abs_lt.mp h₂.2.2).1
      _ = V n (N n * u t₂) - I s := by ring
      _ ≤ _ := sub_le_sub_right hLow _
  · calc
      _ ≤ V n (N n * u t₁) - I s := sub_le_sub_right hUp _
      _ = (V n (N n * u t₁) - I t₁) + (I t₁ - I s) := by ring
      _ < ε / 2 + ε / 2 := add_lt_add (abs_lt.mp hn₁).2 (abs_lt.mp h₁.2.2).2
      _ = ε := by ring

theorem interior_moving_soft_threshold_rate (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) {r M u : ℝ}
    (hr : 0 < r) (hD : -tiltedMean p q 0 < r)
    (hM : ∀ i, -M ≤ logLikelihood p q i) (hAtom : 0 < endpointAtomMass p q M)
    (hu : 0 < u) (huM : u < M - r) (U : ℕ → ℝ)
    (hU : Tendsto (fun n => U n / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 u)) :
    Tendsto (fun n => negativeLogProductMoment p q (n + 1) (orderAtRate r (n + 1))
      (priorFromTime (U n)) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 (likelihoodRate p q (-r - u))) := by
  have hLo : -M < -r - u := by linarith only [huM]
  have hHi : -r - u < tiltedMean p q 0 := by linarith only [hD, hu]
  obtain ⟨s, ⟨hs, hx⟩, _⟩ := negative_tilt_at_target p q hp hq hne hM hAtom hLo hHi
  have he : -tiltedMean p q s - r = u := by rw [hx]; ring
  have h := moving_log_prior_at_tilt_scale p q hp hq hne hr hs (he.symm ▸ hu) U (he.symm ▸ hU)
  rwa [hx] at h

theorem endpoint_moving_soft_threshold_lower (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) {r M c : ℝ}
    (hr : 0 < r) (hrM : r < M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hAtom : 0 < endpointAtomMass p q M) (hc : c < endpointLogRate p q M)
    (U : ℕ → ℝ) (hU : Tendsto (fun n => U n / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 (M - r))) :
    ∀ᶠ n in atTop, c ≤ negativeLogProductMoment p q (n + 1) (orderAtRate r (n + 1))
      (priorFromTime (U n)) / ((n + 1 : ℕ) : ℝ) := by
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  have hN (n : ℕ) : 0 < N n := by unfold N; exact_mod_cast Nat.succ_pos n
  let ell := endpointLogRate p q M
  have hQ := (minimum_tilt_cumulant_limit p q hM hAtom).neg
  have h' : ∀ᶠ t : ℝ in atTop, c < -(logCumulant p q (-t) - t * M) :=
    hQ.eventually (lt_mem_nhds hc)
  obtain ⟨t, ht, hT⟩ := ((eventually_gt_atTop (0 : ℝ)).and h').exists
  let F := inverseOrderObjective p q r t
  let C := t * (Real.log 2 + Real.log t)
  let d := (M - r) / 2
  have hd : 0 < d := div_pos (sub_pos.mpr hrM) (by norm_num)
  have hd' : d < M - r := by unfold d; linarith only [hrM]
  have hDiv : Tendsto (fun n => C / N n) atTop (𝓝 0) :=
    (tendsto_const_div_atTop_nhds_zero_nat C).comp
      (tendsto_atTop.2 fun m => (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n)))
  have hLin : Tendsto (fun n => t * (U n / N n) - F - C / N n) atTop
      (𝓝 (-(logCumulant p q (-t) - t * M))) := by
    have h := (((hU.const_mul t).sub_const F).sub hDiv)
    rw [sub_zero, show t * (M - r) - F = -(logCumulant p q (-t) - t * M) by
      unfold F inverseOrderObjective; ring] at h
    exact h
  have hD := hU.eventually (lt_mem_nhds hd')
  have hN' := (successor_real_tendsto.const_mul_atTop hd).eventually
    (eventually_ge_atTop (Real.log 2))
  filter_upwards [hLin.eventually (lt_mem_nhds hT), hD, hN',
    (order_at_rate_tendsto hr).eventually (eventually_ge_atTop t)] with n hLn hDn hNn hb
  have hU' : Real.log 2 ≤ U n := hNn.trans ((lt_div_iff₀ (hN n)).1 hDn).le
  have hRaw := inverse_order_prior_linear_bound p q hp hq r (n + 1) hU' ht hb
  apply hLn.le.trans
  apply (le_div_iff₀ (hN n)).2
  change (t * (U n / N n) - F - C / N n) * N n ≤ _
  rw [sub_mul, sub_mul, mul_assoc t, div_mul_cancel₀ _ (hN n).ne', div_mul_cancel₀ _ (hN n).ne']
  change t * U n - F * N n - C ≤ _
  simpa only [mul_comm (F : ℝ) (N n)] using hRaw

theorem inverse_tangent_strict_at_likelihood_endpoint (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) {r M β : ℝ}
    (hAtom : 0 < endpointAtomMass p q M)
    (hOther : ∃ i, logLikelihood p q i ≠ -M)
    (hRoot : logCumulant p q (-β) = r * β) :
    β * (M - r) < endpointLogRate p q M := by
  classical
  let f (i : κ) : ℝ := if logLikelihood p q i = -M then 1 else 0
  let g (i : κ) := Real.exp (-β * (logLikelihood p q i + M))
  have hNon (i : κ) : f i ≤ g i := by
    by_cases hi : logLikelihood p q i = -M
    · simp only [f, g, hi, if_pos rfl, if_true, neg_add_cancel, mul_zero, Real.exp_zero, le_refl]
    · simp only [f, hi, if_false]
      exact Real.exp_nonneg _
  obtain ⟨i, hi⟩ := hOther
  have hStrict : f i < g i := by
    simp only [f, hi, if_false]
    exact Real.exp_pos _
  have h := p.expect_strict hNon (hp i) hStrict
  change endpointAtomMass p q M < p.expect g at h
  have hLog := Real.log_lt_log hAtom h
  have hEq : logCumulant p q (-β) = β * M + Real.log (p.expect g) := by
    unfold logCumulant
    rw [minimum_tilt_normalizer_factorization p q M β]
    change Real.log (Real.exp (β * M) * p.expect g) = _
    rw [Real.log_mul (Real.exp_pos _).ne' (hAtom.trans h).ne', Real.log_exp]
  unfold endpointLogRate
  nlinarith only [hRoot, hEq, hLog]

theorem prior_times_beyond_likelihood_support_excluded (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i)
    {r M δ : ℝ} (hr : 0 < r) (hrM : r < M) (hδ : 0 < δ)
    (hM : ∀ i, -M ≤ logLikelihood p q i) (A : ℝ) :
    ∀ᶠ n : ℕ in atTop, ∀ U, ((n + 1 : ℕ) : ℝ) * (M - r + δ) ≤ U →
      A < exponentialPriorCost p q r (n + 1) U := by
  let d := min δ (r / 2)
  have hd : 0 < d := lt_min hδ (div_pos hr (by norm_num))
  have hdR : d < r := (min_le_right _ _).trans_lt (by linarith only [hr])
  let x := M - r + d
  have hx : 0 < x := add_pos (sub_pos.mpr hrM) hd
  have hxM : x < M := by unfold x; linarith only [hdR]
  have hxδ : x ≤ M - r + δ := add_le_add_left (min_le_left _ _) _
  have hM₀ := hr.trans hrM
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  have hN (n : ℕ) : 0 < N n := by unfold N; exact_mod_cast Nat.succ_pos n
  have hL : Tendsto (fun n => Real.exp (N n * d) / (4 * x * N n)) atTop atTop := by
    have h := ((tendsto_exp_mul_div_rpow_atTop 1 d hd).comp successor_real_tendsto).const_mul_atTop
      (show 0 < 1 / (4 * x) from one_div_pos.mpr (mul_pos (by norm_num) hx))
    apply h.congr
    intro n
    change 1 / (4 * x) * (Real.exp (d * N n) / (N n) ^ (1 : ℝ)) = _
    rw [Real.rpow_one, mul_comm d]
    ring
  filter_upwards [hL.eventually (eventually_gt_atTop A),
    (order_at_rate_tendsto hx).eventually (eventually_ge_atTop 2)] with n hn he
  intro U hU
  let t := N n * x
  let b := orderAtRate r (n + 1)
  let B := orderAtRate M (n + 1)
  let a := priorFromTime U
  let a₀ := priorFromTime t
  have ht : 0 < t := mul_pos (hN n) hx
  have hTU : t ≤ U := (mul_le_mul_of_nonneg_left hxδ (hN n).le).trans hU
  have hU₀ := ht.trans_le hTU
  have hb : 0 < b := Real.exp_pos _
  have hB : 0 < B := Real.exp_pos _
  have hB₁ : 1 ≤ B := by
    unfold B orderAtRate
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr (mul_nonneg (hN n).le hM₀.le)
  have ha₀ := prior_from_time_pos ht
  have ha := prior_from_time_pos hU₀
  have hA : a₀ ≤ a := sub_le_sub_right (Real.exp_le_exp.mpr hTU) 1
  have haB : a₀ ≤ B := (sub_le_self (Real.exp t) zero_le_one).trans
    (Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left hxM.le (hN n).le))
  have he₀ : Real.exp t / 2 ≤ a₀ := by
    have h : 2 ≤ Real.exp t := he
    unfold a₀ priorFromTime
    linarith only [h]
  have hSupport := product_deficit_finite_support_lower p q hp hq (n + 1) hM hb ha
  have hi : Real.exp (-(N n) * M) = B⁻¹ := by
    unfold B orderAtRate
    rw [← Real.exp_neg, neg_mul]
  change Real.log (1 + a * Real.exp (-(N n) * M)) / Real.log (1 + a) ≤ _ at hSupport
  rw [hi, ← div_eq_mul_inv] at hSupport
  have hRatio (z : ℝ) :
      (b / B) * (B * Real.log (1 + z / B) / Real.log (1 + z)) =
        b * (Real.log (1 + z / B) / Real.log (1 + z)) := by
    rw [mul_div_assoc B, ← mul_assoc, div_mul_cancel₀ _ hB.ne']
  have hMono := endpoint_support_lower_monotone hB₁ (mem_Ioi.mpr ha₀) (mem_Ioi.mpr ha) hA
  have hMono' := mul_le_mul_of_nonneg_left hMono (div_nonneg hb.le hB.le)
  change (b / B) * (B * Real.log (1 + a₀ / B) / Real.log (1 + a₀)) ≤
    (b / B) * (B * Real.log (1 + a / B) / Real.log (1 + a)) at hMono'
  rw [hRatio, hRatio, prior_time_exact] at hMono'
  have hBound : b * (Real.log (1 + a₀ / B) / t) ≤ exponentialPriorCost p q r (n + 1) U := by
    rw [exponential_prior_exact_scale p q r (n + 1) hU₀]
    exact hMono'.trans (mul_le_mul_of_nonneg_left hSupport hb.le)
  have hSmall : 0 ≤ a₀ / B := div_nonneg ha₀.le hB.le
  have hOne : a₀ / B ≤ 1 := (div_le_iff₀ hB).2 (by simpa only [one_mul] using haB)
  have hLn : (a₀ / B) / 2 ≤ Real.log (1 + a₀ / B) := by
    apply le_trans _ (log_one_add_bounds hSmall).1
    exact div_le_div_of_nonneg_left hSmall (by linarith only [hSmall]) (by linarith only [hOne])
  have hExp : Real.exp (N n * d) = b * Real.exp t / B := by
    unfold b B orderAtRate t x
    rw [← Real.exp_add, ← Real.exp_sub]
    congr 1
    ring
  have hKey : Real.exp (N n * d) / (4 * x * N n) ≤ b * (Real.log (1 + a₀ / B) / t) := by
    calc
      _ = b * (((Real.exp t / 2) / B / 2) / t) := by
        rw [hExp]
        unfold t
        ring
      _ ≤ _ := by
        apply mul_le_mul_of_nonneg_left _ hb.le
        apply div_le_div_of_nonneg_right _ ht.le
        exact (div_le_div_of_nonneg_right (div_le_div_of_nonneg_right he₀ hB.le) zero_le_two).trans hLn
  exact hn.trans_le (hKey.trans hBound)

end RenyiProductOrderPhase
