import EndpointLambertScale
import EndpointPriorBounds
import InverseOrderMinimum

/-! Global localization of relatively near-optimal endpoint priors. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem endpoint_cost_sandwich (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) {M U : ℝ}
    (hM₀ : 0 ≤ M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hAtom : 0 < endpointAtomMass p q M) (n : ℕ) (hU : 0 < U) :
    let b := orderAtRate M n
    let a := priorFromTime U
    b * Real.log (1 + a / b) / Real.log (1 + a) ≤ exponentialPriorCost p q M n U ∧
      exponentialPriorCost p q M n U ≤ endpointSurrogate ((n : ℝ) * endpointLogRate p q M) U := by
  let a := priorFromTime U
  let b := orderAtRate M n
  have ha : 0 < a := prior_from_time_pos hU
  have hb : 0 < b := Real.exp_pos _
  have hInv : endpointEpsilon M n = b⁻¹ := by
    unfold endpointEpsilon b orderAtRate
    rw [← Real.exp_neg]
    congr 1
    ring
  have hK := product_deficit_finite_support_lower p q hp hq n hM hb ha
  change Real.log (1 + a * endpointEpsilon M n) / Real.log (1 + a) ≤ _ at hK
  rw [hInv, ← div_eq_mul_inv] at hK
  change b * Real.log (1 + a / b) / Real.log (1 + a) ≤ exponentialPriorCost p q M n U ∧ _
  rw [exponential_prior_exact_scale p q M n hU]
  constructor
  · rw [mul_div_assoc]
    exact mul_le_mul_of_nonneg_left hK hb.le
  · have h := (product_deficit_endpoint_sandwich p q hp hq hM₀ hM hAtom ha hb n).2
    rw [hInv, ← div_eq_mul_inv, prior_time_exact] at h
    apply (mul_le_mul_of_nonneg_left h hb.le).trans
    rw [← mul_div_assoc, mul_div_mul_left _ _ hb.ne']
    unfold endpointSurrogate
    apply div_le_div_of_nonneg_right _ hU.le
    have hL := mul_le_mul_of_nonneg_left (log_one_add_bounds (div_nonneg ha.le hb.le)).2 hb.le
    rw [mul_div_cancel₀ _ hb.ne'] at hL
    change b * Real.log (1 + a / b) ≤ Real.exp U - 1 at hL
    linarith only [hL]

theorem eventual_polynomial_below_exponential {M : ℝ} (hM : 0 < M) (t : ℝ) :
    ∀ᶠ n : ℕ in atTop, (((n + 1 : ℕ) : ℝ) ^ t) ≤ orderAtRate M (n + 1) := by
  have h := (tendsto_exp_mul_div_rpow_atTop t M hM).comp successor_real_tendsto
  filter_upwards [h.eventually (eventually_ge_atTop 1)] with n hn
  have hN : 0 < ((n + 1 : ℕ) : ℝ) := by exact_mod_cast Nat.succ_pos n
  have he := (le_div_iff₀ (Real.rpow_pos_of_pos hN t)).1 hn
  simpa only [Function.comp_apply, one_mul, orderAtRate, mul_comm M] using he

theorem endpoint_large_log_time_excluded (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i)
    {M c : ℝ} (hM₀ : 0 < M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hAtom : 0 < endpointAtomMass p q M) (hAtom' : endpointAtomMass p q M < 1)
    (hc : 1 < c) (D : ℝ) :
    ∀ᶠ n : ℕ in atTop, ∀ U > 0, c * Real.log ((n + 1 : ℕ) : ℝ) ≤ U →
      D < exponentialPriorCost p q M (n + 1) U /
        (((n + 1 : ℕ) : ℝ) * endpointLogRate p q M / Real.log ((n + 1 : ℕ) : ℝ)) := by
  let ell := endpointLogRate p q M
  have hEll : 0 < ell := neg_pos.mpr (Real.log_neg hAtom hAtom')
  have hc₀ : 0 < c := zero_lt_one.trans hc
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  have hN (n : ℕ) : 0 < N n := by unfold N; exact_mod_cast Nat.succ_pos n
  have hPower := (tendsto_rpow_atTop (sub_pos.mpr hc)).comp successor_real_tendsto
  have hTo := hPower.eventually (eventually_gt_atTop (2 * c * ell * D + 1))
  filter_upwards [eventual_polynomial_below_exponential hM₀ c,
    successor_real_tendsto.eventually (eventually_gt_atTop 1), hTo] with n hn hNn hNpow
  intro U hU hLarge
  let b := orderAtRate M (n + 1)
  let a := priorFromTime U
  let V := exponentialPriorCost p q M (n + 1) U
  let t := c * Real.log (N n)
  let a₀ := priorFromTime t
  have hLogN : 0 < Real.log (N n) := Real.log_pos hNn
  have ht : 0 < t := mul_pos hc₀ hLogN
  have ha₀ : 0 < a₀ := prior_from_time_pos ht
  have ha : 0 < a := prior_from_time_pos hU
  have hb : 0 < b := Real.exp_pos _
  have hB : 1 ≤ b := by
    unfold b orderAtRate
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr (mul_nonneg (hN n).le hM₀.le)
  have hR : a₀ = N n ^ c - 1 := by
    unfold a₀ priorFromTime t
    rw [Real.rpow_def_of_pos (hN n), mul_comm c]
  have haB : a₀ ≤ b := by rw [hR]; exact (sub_le_self _ zero_le_one).trans hn
  have hAa : a₀ ≤ a := by unfold a₀ a priorFromTime; exact sub_le_sub_right (Real.exp_le_exp.mpr hLarge) 1
  have hSUP := (endpoint_cost_sandwich p q hp hq hM₀.le hM hAtom (n + 1) hU).1
  have hMono := endpoint_support_lower_monotone hB (mem_Ioi.mpr ha₀) (mem_Ioi.mpr ha) hAa
  have hV : b * Real.log (1 + a₀ / b) / t ≤ V := by
    have h := hMono.trans hSUP
    change b * Real.log (1 + a₀ / b) / Real.log (1 + a₀) ≤ V at h
    rwa [prior_time_exact] at h
  have hSmall : a₀ / 2 ≤ b * Real.log (1 + a₀ / b) := by
    have hd : 0 ≤ a₀ / b := div_nonneg ha₀.le hb.le
    have h₁ : a₀ / b ≤ 1 := (div_le_iff₀ hb).2 (by simpa only [one_mul] using haB)
    have h₂ : (a₀ / b) / 2 ≤ (a₀ / b) / (1 + a₀ / b) :=
      div_le_div_of_nonneg_left hd (by linarith only [hd]) (by linarith only [h₁])
    have h := mul_le_mul_of_nonneg_left (h₂.trans (log_one_add_bounds hd).1) hb.le
    rwa [← mul_div_assoc, mul_div_cancel₀ _ hb.ne'] at h
  have hPos : 0 < N n * ell / Real.log (N n) := div_pos (mul_pos (hN n) hEll) hLogN
  change D < V / (N n * ell / Real.log (N n))
  apply (lt_div_iff₀ hPos).2
  apply lt_of_lt_of_le _ ((div_le_div_of_nonneg_right hSmall ht.le).trans hV)
  have hOld : 2 * c * ell * D + 1 < N n ^ (c - 1) := hNpow
  have hTrans := mul_lt_mul_of_pos_right hOld (hN n)
  have hEq : N n ^ (c - 1) * N n = N n ^ c := by
    calc
      _ = N n ^ (c - 1) * N n ^ (1 : ℝ) := by rw [Real.rpow_one]
      _ = _ := by rw [← Real.rpow_add (hN n), sub_add_cancel]
  rw [hEq] at hTrans
  have hN₁ : (1 : ℝ) ≤ N n := hNn.le
  have hStrict : 2 * c * (N n * ell) * D < a₀ := by rw [hR]; nlinarith only [hTrans, hN₁]
  unfold t
  apply (lt_div_iff₀ ht).2
  have hAlg : D * (N n * ell / Real.log (N n)) * (c * Real.log (N n)) =
      D * N n * ell * c := by field_simp [hLogN.ne']; ring
  rw [hAlg]
  linarith only [hStrict]

theorem endpoint_small_log_time_excluded (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i)
    {M c D : ℝ} (hM₀ : 0 < M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hAtom : 0 < endpointAtomMass p q M) (hAtom' : endpointAtomMass p q M < 1)
    (hc : 0 < c) (hD : 0 < D) (hDc : D * c < 1) :
    ∀ᶠ n : ℕ in atTop, ∀ U > 0, U ≤ c * Real.log ((n + 1 : ℕ) : ℝ) →
      D < exponentialPriorCost p q M (n + 1) U /
        (((n + 1 : ℕ) : ℝ) * endpointLogRate p q M / Real.log ((n + 1 : ℕ) : ℝ)) := by
  let ell := endpointLogRate p q M
  let δ := (D * c * ell + ell) / 2
  have hEll : 0 < ell := neg_pos.mpr (Real.log_neg hAtom hAtom')
  have hC : D * c * ell < ell := by
    simpa only [one_mul] using mul_lt_mul_of_pos_right hDc hEll
  have hδ : D * c * ell < δ := by unfold δ; linarith only [hC]
  have hδ₀ : 0 < δ := (mul_pos (mul_pos hD hc) hEll).trans hδ
  have hδ₁ : δ < ell := by unfold δ; linarith only [hC]
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  have hN (n : ℕ) : 0 < N n := by unfold N; exact_mod_cast Nat.succ_pos n
  have hLog := Real.tendsto_log_atTop.comp successor_real_tendsto
  filter_upwards [endpoint_negative_log_one_eventually_lower p q hp hq hM₀ hM hAtom hδ₁,
    hLog.eventually (eventually_gt_atTop (D * ell / δ))] with n hn hLogN
  intro U hU hTime
  let b := orderAtRate M (n + 1)
  let a := priorFromTime U
  let K := negativeLogProductMoment p q (n + 1) b
  let J := N n * ell / Real.log (N n)
  change D * ell / δ < Real.log (N n) at hLogN
  have hb : 0 < b := Real.exp_pos _
  have ha := prior_from_time_pos hU
  have hP : 0 < Real.log (N n) := (div_pos (mul_pos hD hEll) hδ₀).trans hLogN
  have hJ := div_pos (mul_pos (hN n) hEll) hP
  change N n * δ ≤ K 1 at hn
  change D < (K a / U) / J
  apply (lt_div_iff₀ hJ).2
  rcases le_or_gt a 1 with ha₁ | ha₁
  · have hLogA : U ≤ a := by
      rw [← prior_time_exact U]
      exact (log_one_add_bounds ha.le).2
    have h₁ := negative_log_product_moment_small_prior p q hp hq (n + 1) hb ha.le ha₁
    have h₂ := mul_le_mul_of_nonneg_right hLogA ((mul_pos (hN n) hδ₀).le.trans hn)
    have hV : K 1 ≤ K a / U := (le_div_iff₀ hU).2 (by
      rw [mul_comm (K 1) U]
      exact h₂.trans h₁)
    apply lt_of_lt_of_le _ (hn.trans hV)
    change D * (N n * ell / Real.log (N n)) < N n * δ
    rw [← mul_div_assoc]
    apply (div_lt_iff₀ hP).2
    have h := mul_lt_mul_of_pos_right ((div_lt_iff₀ hδ₀).1 hLogN) (hN n)
    linarith only [h]
  · have hK := negative_log_product_moment_mono p q hp hq (n + 1) hb
      (mem_Ici.mpr zero_le_one) (mem_Ici.mpr ha.le) ha₁.le
    apply (lt_div_iff₀ hU).2
    have h := mul_le_mul_of_nonneg_left hTime (mul_pos hD hJ).le
    have he : D * J * (c * Real.log (N n)) = N n * (D * c * ell) := by
      unfold J
      field_simp [hP.ne']
      ring
    rw [he] at h
    exact h.trans_lt ((mul_lt_mul_of_pos_left hδ (hN n)).trans_le (hn.trans hK))

theorem endpoint_relative_time_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i)
    {M : ℝ} (hM₀ : 0 < M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hAtom : 0 < endpointAtomMass p q M) (hAtom' : endpointAtomMass p q M < 1)
    (U : ℕ → ℝ) (hU : ∀ᶠ n in atTop, 0 < U n)
    (hOpt : ∀ ε > 0, ∀ᶠ n in atTop, exponentialPriorCost p q M (n + 1) (U n) /
      (((n + 1 : ℕ) : ℝ) * endpointLogRate p q M / Real.log ((n + 1 : ℕ) : ℝ)) ≤ 1 + ε) :
    Tendsto (fun n => U n / Real.log ((n + 1 : ℕ) : ℝ)) atTop (𝓝 1) := by
  apply Metric.tendsto_nhds.2
  intro ε hε
  let d := min (ε / 2) (1 / 2)
  have hd : 0 < d := lt_min (div_pos hε (by norm_num)) (by norm_num)
  have hd' : d < ε := (min_le_left _ _).trans_lt (by linarith only [hε])
  have hd₁ : d ≤ 1 / 2 := min_le_right _ _
  let c := 1 - d
  have hc : 0 < c := by unfold c; linarith only [hd₁]
  have hc₁ : c < 1 := sub_lt_self _ hd
  let D := (1 + c⁻¹) / 2
  have hD : 1 < D := by
    have h := (one_lt_inv₀ hc).2 hc₁
    unfold D
    linarith only [h]
  have hDc : D * c < 1 := by
    unfold D
    rw [div_mul_eq_mul_div, add_mul, one_mul, inv_mul_cancel₀ hc.ne']
    exact (div_lt_iff₀ (by norm_num : (0 : ℝ) < 2)).2
      (by simpa only [one_mul, one_add_one_eq_two] using add_lt_add_right hc₁ 1)
  have hSmall := endpoint_small_log_time_excluded p q hp hq hM₀ hM hAtom hAtom' hc
    (zero_lt_one.trans hD) hDc
  have hLarge := endpoint_large_log_time_excluded p q hp hq hM₀ hM hAtom hAtom'
    (c := 1 + d) (lt_add_of_pos_right _ hd) 2
  have hUpper := hOpt (D - 1) (sub_pos.mpr hD)
  have hUpper' := hOpt 1 zero_lt_one
  filter_upwards [hSmall, hLarge, hUpper, hUpper', hU,
    successor_real_tendsto.eventually (eventually_gt_atTop 1)]
    with n hs hl hu hu' hUn hN
  have hP := Real.log_pos hN
  have hLow : c < U n / Real.log ((n + 1 : ℕ) : ℝ) := by
    apply lt_of_not_ge
    intro he
    have h := hs (U n) hUn ((div_le_iff₀ hP).1 he)
    rw [show (1 : ℝ) + (D - 1) = D by ring] at hu
    exact (not_lt_of_ge hu) h
  have hHigh : U n / Real.log ((n + 1 : ℕ) : ℝ) < 1 + d := by
    apply lt_of_not_ge
    intro he
    have h := hl (U n) hUn ((le_div_iff₀ hP).1 he)
    exact (not_lt_of_ge (by simpa only [one_add_one_eq_two] using hu')) h
  rw [Real.dist_eq, abs_lt]
  unfold c at hLow
  exact ⟨by linarith only [hLow, hd'], by linarith only [hHigh, hd']⟩

end RenyiProductOrderPhase
