import EndpointTimeConfinement
import EndpointSharpError

/-! Uniform decay of the endpoint error on the polynomial prior range. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

theorem log_time_prior_in_polynomial_range (U : ℕ → ℝ)
    (hU : Tendsto (fun n => U n / Real.log ((n + 1 : ℕ) : ℝ)) atTop (𝓝 1)) :
    ∀ᶠ n in atTop,
      Real.sqrt ((n + 1 : ℕ) : ℝ) ≤ priorFromTime (U n) ∧
      priorFromTime (U n) ≤ ((n + 1 : ℕ) : ℝ) ^ (3 / 2 : ℝ) ∧
      (3 / 4 : ℝ) * Real.log ((n + 1 : ℕ) : ℝ) ≤ U n := by
  have hQ := (tendsto_rpow_atTop (by norm_num : (0 : ℝ) < 1 / 4)).comp successor_real_tendsto
  filter_upwards [hU.eventually (Icc_mem_nhds (by norm_num : (3 / 4 : ℝ) < 1) (by norm_num : (1 : ℝ) < 5 / 4)),
    successor_real_tendsto.eventually (eventually_gt_atTop 1), hQ.eventually (eventually_ge_atTop 2)]
    with n hn hNn hP
  let N : ℝ := ((n + 1 : ℕ) : ℝ)
  have hN : 0 < N := zero_lt_one.trans hNn
  have hL := Real.log_pos hNn
  have hLow : (3 / 4 : ℝ) * Real.log N ≤ U n := (le_div_iff₀ hL).1 hn.1
  have hHigh : U n ≤ (5 / 4 : ℝ) * Real.log N := (div_le_iff₀ hL).1 hn.2
  refine ⟨?_, ?_, hLow⟩
  · have hExp := Real.exp_le_exp.mpr hLow
    rw [mul_comm, ← Real.rpow_def_of_pos hN,
      show (3 / 4 : ℝ) = 1 / 2 + 1 / 4 by norm_num, Real.rpow_add hN, ← Real.sqrt_eq_rpow] at hExp
    have hP' : 2 ≤ N ^ (1 / 4 : ℝ) := hP
    have h := mul_le_mul_of_nonneg_left hP' (Real.sqrt_nonneg N)
    have hR : 1 ≤ Real.sqrt N := by
      simpa only [Real.sqrt_one] using Real.sqrt_le_sqrt hNn.le
    unfold priorFromTime
    linarith only [h, hExp, hR]
  · have hExp := Real.exp_le_exp.mpr hHigh
    rw [mul_comm (5 / 4 : ℝ), ← Real.rpow_def_of_pos hN] at hExp
    have hR := Real.rpow_le_rpow_of_exponent_le hNn.le (by norm_num : (5 / 4 : ℝ) ≤ 3 / 2)
    exact (sub_le_self _ zero_le_one).trans (hExp.trans hR)

variable {κ : Type*} [Fintype κ]

noncomputable def endpointErrorBound (p q : FiniteMass κ) (M d : ℝ) (n : ℕ) : ℝ :=
  (n : ℝ) ^ 3 / orderAtRate M n +
    (n : ℝ) * ((1 - endpointAtomMass p q M) / endpointAtomMass p q M) *
      Real.exp (-(d / 4) * Real.sqrt (n : ℝ)) +
    Real.exp ((n : ℝ) * endpointLogRate p q M - orderAtRate M n * Real.log 2)

theorem endpoint_polynomial_error_tendsto (p q : FiniteMass κ) {M d : ℝ}
    (hM : 0 < M) (hd : 0 < d) (hm : 0 < endpointAtomMass p q M)
    (hm' : endpointAtomMass p q M < 1) :
    Tendsto (fun n : ℕ => endpointErrorBound p q M d (n + 1)) atTop (𝓝 0) := by
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  let C := (1 - endpointAtomMass p q M) / endpointAtomMass p q M
  let ell := endpointLogRate p q M
  have hN : Tendsto N atTop atTop := successor_real_tendsto
  have hEll : 0 < ell := neg_pos.mpr (Real.log_neg hm hm')
  have hFirst : Tendsto (fun n => N n ^ 3 / orderAtRate M (n + 1)) atTop (𝓝 0) := by
    have h := (tendsto_rpow_mul_exp_neg_mul_atTop_nhds_zero 3 M hM).comp hN
    apply h.congr
    intro n
    change N n ^ (3 : ℝ) * Real.exp (-M * N n) = N n ^ (3 : ℕ) / Real.exp (N n * M)
    rw [show (3 : ℝ) = ((3 : ℕ) : ℝ) by norm_num, Real.rpow_natCast, neg_mul,
      mul_comm M, Real.exp_neg, div_eq_mul_inv]
  have hRoot : Tendsto (fun n => Real.sqrt (N n)) atTop atTop :=
    nat_sqrt_tendsto_atTop.comp (tendsto_atTop.2 fun m =>
      (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n)))
  have hd₀ : 0 < d / 4 := div_pos hd (by norm_num)
  have hSecond : Tendsto (fun n => N n * C * Real.exp (-(d / 4) * Real.sqrt (N n))) atTop (𝓝 0) := by
    have h := ((tendsto_rpow_mul_exp_neg_mul_atTop_nhds_zero 2 (d / 4) hd₀).comp hRoot).const_mul C
    simp only [mul_zero] at h
    apply h.congr
    intro n
    change C * (Real.sqrt (N n) ^ (2 : ℝ) * Real.exp (-(d / 4) * Real.sqrt (N n))) =
      N n * C * Real.exp (-(d / 4) * Real.sqrt (N n))
    rw [show (2 : ℝ) = ((2 : ℕ) : ℝ) by norm_num, Real.rpow_natCast,
      Real.sq_sqrt (show 0 ≤ N n from Nat.cast_nonneg _)]
    ring
  have hLog : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hTail : Tendsto (fun n => orderAtRate M (n + 1) * Real.log 2 - N n * ell) atTop atTop := by
    apply tendsto_atTop.2
    intro A
    have hLevel := (hN.atTop_mul_const hEll).eventually (eventually_ge_atTop A)
    filter_upwards [hN.eventually (eventually_ge_atTop (2 * ell / Real.log 2)),
      eventual_polynomial_below_exponential hM 2, hLevel] with n hn hp hA
    have hm₀ : 0 ≤ N n := Nat.cast_nonneg _
    have hn' := (div_le_iff₀ hLog).1 hn
    have hL := mul_le_mul_of_nonneg_right hn' hm₀
    have hp' : (N n) ^ 2 ≤ orderAtRate M (n + 1) := by
      change (N n) ^ (2 : ℝ) ≤ _ at hp
      rwa [show (2 : ℝ) = ((2 : ℕ) : ℝ) by norm_num, Real.rpow_natCast] at hp
    have he := mul_le_mul_of_nonneg_right hp' hLog.le
    nlinarith only [hL, he, hA]
  have hThird : Tendsto (fun n => Real.exp (N n * ell - orderAtRate M (n + 1) * Real.log 2))
      atTop (𝓝 0) := by
    apply (Real.tendsto_exp_neg_atTop_nhds_zero.comp hTail).congr
    intro n
    change Real.exp (-(orderAtRate M (n + 1) * Real.log 2 - N n * ell)) = _
    rw [neg_sub]
  simpa only [endpointErrorBound, zero_add] using (hFirst.add hSecond).add hThird

theorem endpoint_cost_surrogate_error (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) {M d : ℝ}
    (hM₀ : 0 < M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hd : 0 < d) (hGap : ∀ i, logLikelihood p q i = -M ∨ d ≤ logLikelihood p q i + M)
    (hm : 0 < endpointAtomMass p q M) (hm' : endpointAtomMass p q M < 1)
    (U : ℕ → ℝ) (hU : Tendsto (fun n => U n / Real.log ((n + 1 : ℕ) : ℝ)) atTop (𝓝 1)) :
    Tendsto (fun n =>
      Real.log ((n + 1 : ℕ) : ℝ) *
        (endpointSurrogate (((n + 1 : ℕ) : ℝ) * endpointLogRate p q M) (U n) -
          exponentialPriorCost p q M (n + 1) (U n))) atTop (𝓝 0) := by
  have hBound := endpoint_polynomial_error_tendsto p q hM₀ hd hm hm'
  have hUpper := hBound.const_mul (4 / 3 : ℝ)
  rw [mul_zero] at hUpper
  have hC : 0 ≤ (1 - endpointAtomMass p q M) / endpointAtomMass p q M :=
    div_nonneg (sub_nonneg.mpr hm'.le) hm.le
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds hUpper
  · filter_upwards [log_time_prior_in_polynomial_range U hU,
      successor_real_tendsto.eventually (eventually_gt_atTop 1)] with n hn hN
    have hL := Real.log_pos hN
    have hU₀ : 0 < U n := (mul_pos (by norm_num : (0 : ℝ) < 3 / 4) hL).trans_le hn.2.2
    exact mul_nonneg hL.le (sub_nonneg.mpr (endpoint_cost_sandwich p q hp hq hM₀.le hM hm
      (n + 1) hU₀).2)
  · filter_upwards [log_time_prior_in_polynomial_range U hU,
      successor_real_tendsto.eventually (eventually_gt_atTop 1), eventual_polynomial_below_exponential hM₀ (3 / 2)]
      with n hn hN hb
    let N : ℝ := ((n + 1 : ℕ) : ℝ)
    let a := priorFromTime (U n)
    let b := orderAtRate M (n + 1)
    let ell := endpointLogRate p q M
    let E := endpointErrorBound p q M d (n + 1)
    let C := (1 - endpointAtomMass p q M) / endpointAtomMass p q M
    have hL := Real.log_pos hN
    have hU₀ : 0 < U n := (mul_pos (by norm_num : (0 : ℝ) < 3 / 4) hL).trans_le hn.2.2
    have ha : 0 < a := prior_from_time_pos hU₀
    have hB : a ≤ b := hn.2.1.trans hb
    have hK := endpoint_negative_log_approximation p q hp hq hM₀.le hM hGap hm hm'.le
      (n + 1) ha hB
    have hPow : a ^ 2 ≤ N ^ 3 := by
      calc
        _ ≤ (N ^ (3 / 2 : ℝ)) ^ (2 : ℕ) := pow_le_pow_left₀ ha.le hn.2.1 2
        _ = (N ^ (3 / 2 : ℝ)) ^ (2 : ℝ) := by
          rw [show (2 : ℝ) = ((2 : ℕ) : ℝ) by norm_num, Real.rpow_natCast]
        _ = _ := by
          rw [← Real.rpow_mul (show 0 ≤ N from Nat.cast_nonneg _),
            show (3 / 2 : ℝ) * 2 = ((3 : ℕ) : ℝ) by norm_num, Real.rpow_natCast]
    have hExp : Real.exp (-(a / 4) * d) ≤ Real.exp (-(d / 4) * Real.sqrt N) := by
      apply Real.exp_le_exp.mpr
      nlinarith only [mul_le_mul_of_nonneg_right hn.1 hd.le]
    have hUp : N * ell + a - negativeLogProductMoment p q (n + 1) b a ≤ E := by
      apply hK.2.trans
      apply add_le_add_right
      exact add_le_add (div_le_div_of_nonneg_right hPow (Real.exp_nonneg _))
        (mul_le_mul_of_nonneg_left hExp (mul_nonneg (Nat.cast_nonneg _) hC))
    have hR : Real.log N / U n ≤ 4 / 3 := (div_le_iff₀ hU₀).2 (by
      have hz : (3 / 4 : ℝ) * Real.log N ≤ U n := hn.2.2
      linarith only [hz])
    change Real.log N * (endpointSurrogate (N * ell) (U n) -
      negativeLogProductMoment p q (n + 1) b a / U n) ≤ 4 / 3 * E
    unfold endpointSurrogate
    rw [show N * ell + Real.exp (U n) - 1 = N * ell + a by unfold a priorFromTime; ring]
    rw [← sub_div, ← mul_div_assoc, mul_comm (Real.log N), mul_div_assoc]
    rw [mul_comm (N * ell + a - negativeLogProductMoment p q (n + 1) b a)]
    exact mul_le_mul hR hUp hK.1 (by norm_num)

end RenyiProductOrderPhase
