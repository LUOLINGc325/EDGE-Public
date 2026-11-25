import MinimumAtomTilt
import SoftThresholdBounds
import NegativeLogPriorShape

/-! Endpoint prior bounds that hold on the entire positive half-line. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

theorem endpoint_support_lower_monotone {b : ℝ} (hb : 1 ≤ b) :
    MonotoneOn (fun a => b * Real.log (1 + a / b) / Real.log (1 + a)) (Ioi (0 : ℝ)) := by
  have hb₀ : 0 < b := zero_lt_one.trans_le hb
  let L (a : ℝ) := Real.log (1 + a)
  let K (a : ℝ) := Real.log (1 + a / b)
  have hL (a : ℝ) (ha : 0 ≤ a) : HasDerivAt L (1 / (1 + a)) a := by
    have hPos : 0 < 1 + a := by linarith
    simpa only [L, id_eq, zero_add] using
      ((hasDerivAt_const a 1).add (hasDerivAt_id a)).log hPos.ne'
  have hK (a : ℝ) (ha : 0 ≤ a) : HasDerivAt K (1 / (b + a)) a := by
    have hDiv : 0 ≤ a / b := div_nonneg ha hb₀.le
    have hPos : 0 < 1 + a / b := by linarith only [hDiv]
    have hDeriv := ((hasDerivAt_const a 1).add ((hasDerivAt_id a).div_const b)).log hPos.ne'
    have hEq : (0 + 1 / b) / (1 + a / b) = 1 / (b + a) := by
      field_simp [hb₀.ne', hPos.ne', (add_pos_of_pos_of_nonneg hb₀ ha).ne']
    simpa only [K, id_eq, hEq] using hDeriv
  have hOrder (a : ℝ) (ha : 0 ≤ a) : K a ≤ L a := by
    unfold K L
    have hPos : 0 < 1 + a / b := add_pos_of_pos_of_nonneg zero_lt_one (div_nonneg ha hb₀.le)
    have hDiv : a / b ≤ a := (div_le_iff₀ hb₀).2 (le_mul_of_one_le_right ha hb)
    exact Real.log_le_log hPos (by linarith only [hDiv])
  let N (a : ℝ) := (1 + a) * L a - (b + a) * K a
  have hN (a : ℝ) (ha : 0 ≤ a) : HasDerivAt N (L a - K a) a := by
    have hDeriv := (((hasDerivAt_const a 1).add (hasDerivAt_id a)).mul (hL a ha)).sub
      (((hasDerivAt_const a b).add (hasDerivAt_id a)).mul (hK a ha))
    convert hDeriv using 1
    simp only [id_eq, zero_add, one_mul, one_div, mul_inv_cancel₀
      (add_pos_of_pos_of_nonneg zero_lt_one ha).ne', mul_inv_cancel₀
      (add_pos_of_pos_of_nonneg hb₀ ha).ne']
    ring
  have hMono : MonotoneOn N (Ici 0) := by
    apply monotoneOn_of_deriv_nonneg (convex_Ici 0)
    · intro a ha
      exact (hN a (mem_Ici.mp ha)).continuousAt.continuousWithinAt
    · intro a ha
      rw [interior_Ici] at ha
      exact (hN a (mem_Ioi.mp ha).le).differentiableAt.differentiableWithinAt
    · intro a ha
      rw [interior_Ici] at ha
      have ha' : 0 ≤ a := (mem_Ioi.mp ha).le
      rw [(hN a ha').deriv]
      exact sub_nonneg.mpr (hOrder a ha')
  have hPos (a : ℝ) (ha : 0 ≤ a) : 0 ≤ N a := by
    have h := hMono (show (0 : ℝ) ∈ Ici (0 : ℝ) from mem_Ici.mpr le_rfl) (mem_Ici.mpr ha) ha
    simpa only [N, L, K, add_zero, zero_div, Real.log_one, mul_zero, sub_zero] using h
  apply monotoneOn_of_deriv_nonneg (convex_Ioi 0)
  · intro a ha
    have ha' : 0 < a := mem_Ioi.mp ha
    have hLa : 0 < L a := Real.log_pos (by linarith only [ha'])
    exact ((hK a ha'.le).const_mul b).continuousAt.div (hL a ha'.le).continuousAt
      hLa.ne' |>.continuousWithinAt
  · intro a ha
    rw [interior_Ioi] at ha
    have ha' : 0 < a := mem_Ioi.mp ha
    have hLa : 0 < L a := Real.log_pos (by linarith only [ha'])
    exact (((hK a ha'.le).const_mul b).div (hL a ha'.le) hLa.ne').differentiableAt.differentiableWithinAt
  · intro a ha
    rw [interior_Ioi] at ha
    have ha' : 0 < a := mem_Ioi.mp ha
    have hLa : 0 < L a := Real.log_pos (by linarith only [ha'])
    have hD := (((hK a ha'.le).const_mul b).div (hL a ha'.le) hLa.ne').deriv
    change deriv (fun a => b * K a / L a) a ≥ 0
    rw [hD]
    have he : b * (1 / (b + a)) * L a - (b * K a) * (1 / (1 + a)) =
        b * N a / ((b + a) * (1 + a)) := by
      unfold N
      field_simp [(add_pos hb₀ ha').ne', (add_pos zero_lt_one ha').ne']
      ring
    rw [he]
    exact div_nonneg (div_nonneg (mul_nonneg hb₀.le (hPos a ha'.le))
      (mul_nonneg (add_pos hb₀ ha').le (add_pos zero_lt_one ha').le)) (sq_nonneg _)

variable {κ : Type*} [Fintype κ]

theorem endpoint_negative_log_one_eventually_lower (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i)
    {M c : ℝ} (hM₀ : 0 < M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hAtom : 0 < endpointAtomMass p q M) (hc : c < endpointLogRate p q M) :
    ∀ᶠ n : ℕ in atTop, ((n + 1 : ℕ) : ℝ) * c ≤
      negativeLogProductMoment p q (n + 1) (Real.exp (((n + 1 : ℕ) : ℝ) * M)) 1 := by
  let ell := endpointLogRate p q M
  let mid := (c + ell) / 2
  have hmid : c < mid := by unfold mid; linarith only [hc]
  have hmid' : mid < ell := by unfold mid; linarith only [hc]
  have hF := (minimum_tilt_cumulant_limit p q hM hAtom).neg
  have h := hF.eventually (lt_mem_nhds hmid')
  obtain ⟨t, ht₀, ht⟩ := ((eventually_gt_atTop (0 : ℝ)).and h).exists
  have ht' : mid < t * M - logCumulant p q (-t) := by
    change mid < -(logCumulant p q (-t) - t * M) at ht
    linarith only [ht]
  have hNum : Tendsto (fun n : ℕ => ((n + 1 : ℕ) : ℝ)) atTop atTop := by
    exact tendsto_natCast_atTop_atTop.comp
      (tendsto_atTop.2 fun m => (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n)))
  have hB : Tendsto (fun n : ℕ => Real.exp (((n + 1 : ℕ) : ℝ) * M)) atTop atTop :=
    Real.tendsto_exp_atTop.comp (hNum.atTop_mul_const hM₀)
  filter_upwards [hB.eventually (eventually_ge_atTop t),
    hNum.eventually (eventually_ge_atTop ((t * Real.log t) / (mid - c)))] with n hn hn'
  have hn₀ : 0 ≤ ((n + 1 : ℕ) : ℝ) := Nat.cast_nonneg _
  have hSmall := (div_le_iff₀ (sub_pos.mpr hmid)).1 hn'
  have he := product_negative_log_power_lower p q hp hq (n + 1) zero_lt_one ht₀ hn
  rw [Real.log_exp, Real.log_one, add_zero] at he
  have hMul := mul_le_mul_of_nonneg_left ht'.le hn₀
  unfold negativeLogProductMoment
  nlinarith only [he, hSmall, hMul]

end RenyiProductOrderPhase
