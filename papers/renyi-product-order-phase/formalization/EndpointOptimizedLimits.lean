import EndpointUniformShell
import InverseOrderExactCoefficient

/-! Exact maxima and fine Lambert localization at the maximum-likelihood endpoint. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

private theorem exp_remainder_nonneg (x : ℝ) : 0 ≤ Real.exp x - 1 - x := by
  linarith only [Real.add_one_le_exp x]

theorem exp_remainder_sublevel_at_zero {ε : ℝ} (hε : 0 < ε) :
    ∃ c > 0, ∀ x, Real.exp x - 1 - x < c → |x| < ε := by
  let f (x : ℝ) := Real.exp x - 1 - x
  let c := min (f ε) (f (-ε))
  have hPos (x : ℝ) (hx : x ≠ 0) : 0 < f x := by
    unfold f
    linarith only [Real.add_one_lt_exp hx]
  have hc : 0 < c := lt_min (hPos ε hε.ne') (hPos (-ε) (neg_ne_zero.mpr hε.ne'))
  refine ⟨c, hc, fun x hx => ?_⟩
  have hEq (u v : ℝ) : f (u + v) = f u + Real.exp u * f v + (Real.exp u - 1) * v := by
    unfold f
    rw [Real.exp_add]
    ring
  rw [abs_lt]
  constructor
  · apply lt_of_not_ge
    intro h
    let t := x - (-ε)
    have hT : t ≤ 0 := sub_nonpos.mpr h
    have hE : Real.exp (-ε) - 1 ≤ 0 := by
      rw [sub_nonpos, ← Real.exp_zero, Real.exp_le_exp]
      exact neg_nonpos.mpr hε.le
    have he : f x = f (-ε) + Real.exp (-ε) * f t + (Real.exp (-ε) - 1) * t := by
      have hxt : -ε + t = x := by unfold t; ring
      simpa only [hxt] using hEq (-ε) t
    have hF : f (-ε) ≤ f x := by
      have hN : 0 ≤ Real.exp (-ε) * f t := mul_nonneg (Real.exp_nonneg (-ε)) (exp_remainder_nonneg t)
      linarith only [he, hN, mul_nonneg_of_nonpos_of_nonpos hE hT]
    exact (not_lt_of_ge ((min_le_right _ _).trans hF)) hx
  · apply lt_of_not_ge
    intro h
    let t := x - ε
    have hT : 0 ≤ t := sub_nonneg.mpr h
    have hE : 0 ≤ Real.exp ε - 1 := by
      rw [sub_nonneg, ← Real.exp_zero, Real.exp_le_exp]
      exact hε.le
    have he : f x = f ε + Real.exp ε * f t + (Real.exp ε - 1) * t := by
      have hxt : ε + t = x := by unfold t; ring
      simpa only [hxt] using hEq ε t
    have hF : f ε ≤ f x := by
      have hN : 0 ≤ Real.exp ε * f t := mul_nonneg (Real.exp_nonneg ε) (exp_remainder_nonneg t)
      linarith only [he, hN, mul_nonneg hE hT]
    exact (not_lt_of_ge ((min_le_left _ _).trans hF)) hx

variable {κ : Type*} [Fintype κ]

theorem endpoint_all_exact_time_limits (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) {M : ℝ}
    (hM₀ : 0 < M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hm : 0 < endpointAtomMass p q M) (hm' : endpointAtomMass p q M < 1)
    (U : ℕ → ℝ) (hU : ∀ᶠ n in atTop, 0 < U n)
    (hOpt : ∀ᶠ n in atTop, ∀ t > 0, exponentialPriorCost p q M (n + 1) (U n) ≤
      exponentialPriorCost p q M (n + 1) t) :
    let ell := endpointLogRate p q M
    let T (n : ℕ) := endpointBlockTime ell (n + 1)
    Tendsto (fun n => Real.log ((n + 1 : ℕ) : ℝ) *
      (Real.exp (T n) - exponentialPriorCost p q M (n + 1) (U n))) atTop (𝓝 0) ∧
    Tendsto (fun n => U n - T n) atTop (𝓝 0) ∧
    Tendsto (fun n => Real.exp (-(U n)) / (Real.log ((n + 1 : ℕ) : ℝ) /
      (((n + 1 : ℕ) : ℝ) * ell))) atTop (𝓝 1) := by
  let ell := endpointLogRate p q M
  have hEll : 0 < ell := neg_pos.mpr (Real.log_neg hm hm')
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  let T (n : ℕ) := endpointBlockTime ell (n + 1)
  let L (n : ℕ) := N n * ell
  let H (n : ℕ) := L n / Real.log (N n)
  let S (n : ℕ) := endpointSurrogate (L n)
  let V (n : ℕ) := exponentialPriorCost p q M (n + 1) (U n)
  have hN : Tendsto N atTop atTop := successor_real_tendsto
  have hLevel : ∀ᶠ n in atTop, 1 ≤ L n :=
    (hN.atTop_mul_const hEll).eventually (eventually_ge_atTop 1)
  have hLam := endpoint_lambert_block_ratios hEll
  have hT₀ : ∀ᶠ n in atTop, 0 < T n := hLevel.mono (fun _ hn => (lambert_endpoint_time_spec hn).1)
  have hValue : ∀ᶠ n in atTop, V n ≤ Real.exp (T n) := by
    filter_upwards [hT₀, hLevel, hOpt] with n hn hl ho
    have hUp := (endpoint_cost_sandwich p q hp hq hM₀.le hM hm (n + 1) hn).2
    exact (ho (T n) hn).trans (hUp.trans (endpoint_surrogate_exact_minimum hl).1.le)
  have hRel (ε : ℝ) (hε : 0 < ε) : ∀ᶠ n in atTop, V n / H n ≤ 1 + ε := by
    filter_upwards [hValue, hLam.2.eventually (gt_mem_nhds (lt_add_of_pos_right 1 hε)),
      hN.eventually (eventually_gt_atTop 1)] with n hn hLamN hNn
    have hH : 0 < H n := div_pos (mul_pos (zero_lt_one.trans hNn) hEll) (Real.log_pos hNn)
    exact (div_le_div_of_nonneg_right hn hH.le).trans hLamN.le
  have hUratio := endpoint_relative_time_limit p q hp hq hM₀ hM hm hm' U hU hRel
  obtain ⟨d, hd, hGap⟩ := minimum_likelihood_positive_gap p q hM
  have hErr := endpoint_cost_surrogate_error p q hp hq hM₀ hM hd hGap hm hm' U hUratio
  have hSur (n : ℕ) (hn : 1 ≤ L n) (hUn : 0 < U n) : Real.exp (T n) ≤ S n (U n) := by
    have h := endpoint_surrogate_exact_minimum hn
    have hV : S n (T n) = Real.exp (T n) := h.1
    rw [← hV]
    by_cases he : U n = T n
    · rw [he]
    · exact ((endpoint_surrogate_exact_minimum hn).2 (U n) hUn he).le
  have hDifference : Tendsto (fun n => Real.log (N n) * (Real.exp (T n) - V n)) atTop (𝓝 0) := by
    apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds hErr
    · filter_upwards [hValue, hN.eventually (eventually_gt_atTop 1)] with n hn hNn
      exact mul_nonneg (Real.log_pos hNn).le (sub_nonneg.mpr hn)
    · filter_upwards [hLevel, hU, hN.eventually (eventually_gt_atTop 1)] with n hn hu hNn
      exact mul_le_mul_of_nonneg_left (sub_le_sub_right (hSur n hn hu) _) (Real.log_pos hNn).le
  have hD : Tendsto (fun n => U n - T n) atTop (𝓝 0) := by
    apply Metric.tendsto_nhds.2
    intro ε hε
    obtain ⟨c, hc, hC⟩ := exp_remainder_sublevel_at_zero hε
    have hApprox := (hErr.const_mul (2 : ℝ)).eventually (gt_mem_nhds (by simpa only [mul_zero] using hc))
    have hUR := hUratio.eventually (gt_mem_nhds (by norm_num : (1 : ℝ) < 2))
    filter_upwards [hLevel, hT₀, hU, hValue, hApprox, hUR, hN.eventually (eventually_gt_atTop 1)]
      with n hn hTn hun hV hNear hURn hNn
    have hLog := Real.log_pos hNn
    have hUpper : U n ≤ 2 * Real.log (N n) := (div_le_iff₀ hLog).1 hURn.le
    let t := U n - T n
    let E := Real.exp t - 1 - t
    have hSep := endpoint_surrogate_separation hn t
      (show 0 < lambertEndpointTime (L n) + t by change 0 < T n + (U n - T n); linarith only [hun])
    have heq : T n + t = U n := by unfold t; ring
    change S n (T n + t) - S n (T n) = Real.exp (T n) * E / (T n + t) at hSep
    have hST : S n (T n) = Real.exp (T n) := (endpoint_surrogate_exact_minimum hn).1
    rw [heq, hST] at hSep
    have hExp : 1 ≤ Real.exp (T n) := by
      simpa only [Real.exp_zero] using Real.exp_le_exp.mpr hTn.le
    have hD' : 0 ≤ S n (U n) - Real.exp (T n) :=
      sub_nonneg.mpr (hSur n hn hun)
    have hEq := (div_eq_iff hun.ne').1 hSep.symm
    have hE : E ≤ 2 * (Real.log (N n) * (S n (U n) - V n)) := by
      calc
        _ ≤ Real.exp (T n) * E := le_mul_of_one_le_left (exp_remainder_nonneg t) hExp
        _ = (S n (U n) - Real.exp (T n)) * U n := hEq
        _ ≤ (S n (U n) - Real.exp (T n)) * (2 * Real.log (N n)) :=
          mul_le_mul_of_nonneg_left hUpper hD'
        _ ≤ (S n (U n) - V n) * (2 * Real.log (N n)) :=
          mul_le_mul_of_nonneg_right (sub_le_sub_left hV _) (mul_nonneg (by norm_num) hLog.le)
        _ = _ := by ring
    rw [Real.dist_eq, sub_zero]
    exact hC t (hE.trans_lt hNear)
  refine ⟨hDifference, hD, ?_⟩
  have hExpT : Tendsto (fun n => Real.exp (-(U n - T n))) atTop (𝓝 1) := by
    have hNeg : Tendsto (fun n => -(U n - T n)) atTop (𝓝 0) := by
      simpa only [neg_zero] using hD.neg
    exact Real.tendsto_exp_nhds_zero_nhds_one.comp hNeg
  have hInverse := hLam.2.inv₀ one_ne_zero
  rw [inv_one] at hInverse
  have h := hExpT.mul hInverse
  rw [one_mul] at h
  apply h.congr'
  filter_upwards [hN.eventually (eventually_gt_atTop 1)] with n hn
  have hL : 0 < L n := mul_pos (zero_lt_one.trans hn) hEll
  have hLog := Real.log_pos hn
  have hE : Real.exp (-(U n - T n)) = Real.exp (-(U n)) * Real.exp (T n) := by
    rw [neg_sub, sub_eq_add_neg, add_comm (T n), Real.exp_add]
  rw [hE, inv_div]
  change (Real.exp (-(U n)) * Real.exp (T n)) * ((L n / Real.log (N n)) / Real.exp (T n)) =
    Real.exp (-(U n)) / (Real.log (N n) / L n)
  field_simp [hL.ne', hLog.ne', (Real.exp_pos _).ne']
  ring

theorem endpoint_exact_coefficient_limits (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) {M : ℝ}
    (hM₀ : 0 < M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hm : 0 < endpointAtomMass p q M) (hm' : endpointAtomMass p q M < 1) :
    let ell := endpointLogRate p q M
    let T (n : ℕ) := endpointBlockTime ell (n + 1)
    let V (n : ℕ) := orderAtRate M (n + 1) *
      sInf (productDeficitValues p q (n + 1) (orderAtRate M (n + 1)))
    Tendsto (fun n => Real.log ((n + 1 : ℕ) : ℝ) * (V n - Real.exp (T n))) atTop (𝓝 0) ∧
    Tendsto (fun n => V n / ((((n + 1 : ℕ) : ℝ) * ell) / Real.log ((n + 1 : ℕ) : ℝ)))
      atTop (𝓝 1) := by
  classical
  let ell := endpointLogRate p q M
  have hEll : 0 < ell := neg_pos.mpr (Real.log_neg hm hm')
  let T (n : ℕ) := endpointBlockTime ell (n + 1)
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  let H (n : ℕ) := N n * ell / Real.log (N n)
  let V (n : ℕ) := orderAtRate M (n + 1) *
    sInf (productDeficitValues p q (n + 1) (orderAtRate M (n + 1)))
  choose U hU hMin hEq using fun n : ℕ => exponential_prior_cost_least p q hp hq hne (Nat.succ_pos n) M
  have hAll := endpoint_all_exact_time_limits p q hp hq hM₀ hM hm hm' U
    (Filter.Eventually.of_forall hU) (Filter.Eventually.of_forall hMin)
  have hE : Tendsto (fun n => Real.log (N n) * (Real.exp (T n) - V n)) atTop (𝓝 0) :=
    hAll.1.congr (fun n => by rw [hEq n])
  constructor
  · simpa only [neg_zero, ← mul_neg, neg_sub] using hE.neg
  · have hInv : Tendsto (fun n => (N n * ell)⁻¹) atTop (𝓝 0) :=
      tendsto_inv_atTop_zero.comp (successor_real_tendsto.atTop_mul_const hEll)
    have hErr := hE.mul hInv
    have hLam := (endpoint_lambert_block_ratios hEll).2
    have h := hLam.sub hErr
    simp only [mul_zero, sub_zero] at h
    apply h.congr'
    filter_upwards [successor_real_tendsto.eventually (eventually_gt_atTop 1)]
      with n hn
    have hL := (mul_pos (zero_lt_one.trans hn) hEll).ne'
    have hN := (Real.log_pos hn).ne'
    change Real.exp (T n) / H n - Real.log (N n) * (Real.exp (T n) - V n) *
      (N n * ell)⁻¹ = V n / H n
    unfold H
    field_simp [hL, hN]
    ring

end RenyiProductOrderPhase
