import CriticalScaling

/-! Uniform finite two-threshold bounds for the critical KL moment. -/

open Set

namespace RenyiProductOrderPhase

theorem soft_threshold_reciprocal_upper {b z : ℝ} (hb : 1 ≤ b) (hz : 0 ≤ z) :
    (1 + z / b) ^ (-b) ≤ 1 / (1 + z) := by
  have hd : 0 < 1 + z := by linarith
  have h := (normalized_gap_bounds hb hz).1
  unfold normalizedGap kernelGap at h
  have he : 1 - z / (1 + z) = 1 / (1 + z) := by field_simp [hd.ne']
  linarith only [h, he]

variable {κ : Type*} [Fintype κ]

theorem critical_soft_threshold_sandwich (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i)
    (ζ : ℝ) (n : ℕ) {t d : ℝ}
    (hs : 0 < criticalScale p q n) (ht : 0 < t)
    (hb : 1 ≤ criticalOrder p q ζ n) (hU : Real.log 2 ≤ t * criticalScale p q n) :
    let s := criticalScale p q n
    let Y (i : κ) := standardizedLogLikelihood p q i / Real.sqrt (n : ℝ)
    let A := productScalarMoment p q n (criticalOrder p q ζ n) (criticalPrior p q n t)
    1 - finiteSumEvent p Y n (Iic (ζ + t + d)) - Real.exp (-(d * s)) ≤ A ∧
      A ≤ 1 - finiteSumEvent p Y n (Iic (ζ + t - d)) + 2 * Real.exp (-(d * s)) := by
  let s := criticalScale p q n
  let U := t * s
  let Y (i : κ) := standardizedLogLikelihood p q i / Real.sqrt (n : ℝ)
  let b := criticalOrder p q ζ n
  let a := criticalPrior p q n t
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let X (z : Fin n → κ) := iidSum Y z
  let Z (z : Fin n → κ) := (1 - Real.exp (-U)) * Real.exp (s * (ζ + t - X z))
  let K (z : Fin n → κ) := (1 + Z z / b) ^ (-b)
  let E := Real.exp (-(d * s))
  have hb₀ : 0 < b := zero_lt_one.trans_le hb
  have hUp : 0 < U := mul_pos ht hs
  have hE₀ : 0 ≤ E := Real.exp_nonneg _
  have hC₀ : 0 ≤ 1 - Real.exp (-U) := by
    apply sub_nonneg.mpr
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr (neg_nonpos.mpr hUp.le)
  have hC₁ : 1 - Real.exp (-U) ≤ 1 := sub_le_self _ (Real.exp_nonneg _)
  have hC₂ : 1 / 2 ≤ 1 - Real.exp (-U) := by
    have h : Real.exp (-U) ≤ Real.exp (-Real.log 2) := Real.exp_le_exp.mpr (neg_le_neg hU)
    have he : Real.exp (-Real.log 2) = (1 / 2 : ℝ) := by
      rw [Real.exp_neg, Real.exp_log (by norm_num : (0 : ℝ) < 2), one_div]
    rw [he] at h
    linarith only [h]
  have hZ₀ (z : Fin n → κ) : 0 ≤ Z z := mul_nonneg hC₀ (Real.exp_nonneg _)
  have hK₀ (z : Fin n → κ) : 0 ≤ K z := by
    unfold K
    exact Real.rpow_nonneg (by have := div_nonneg (hZ₀ z) hb₀.le; positivity) _
  have hK₁ (z : Fin n → κ) : K z ≤ 1 := by
    apply (soft_threshold_reciprocal_upper hb (hZ₀ z)).trans
    exact (div_le_iff₀ (by linarith only [hZ₀ z] : 0 < 1 + Z z)).2 (by linarith only [hZ₀ z])
  have hExact : productScalarMoment p q n b a = P.expect K := by
    unfold productScalarMoment
    apply congrArg P.expect
    funext z
    change (1 + a * likelihoodProduct p q z) ^ (-b) = K z
    have h := critical_argument_exact p q ζ n t hs z
    change b * a * Real.exp (likelihoodSum p q z) = Z z at h
    unfold K
    rw [← h, mul_assoc, mul_div_cancel_left₀ _ hb₀.ne', exp_likelihood_sum p q hp hq]
  have hHigh (z : Fin n → κ) (hz : ζ + t + d < X z) : 1 - E ≤ K z := by
    have hNum : Z z ≤ E := by
      unfold Z
      apply (mul_le_of_le_one_left (Real.exp_nonneg _) hC₁).trans
      apply Real.exp_le_exp.2
      have hX : ζ + t - X z ≤ -d := by linarith only [hz]
      nlinarith only [mul_le_mul_of_nonneg_left hX hs.le]
    exact (sub_le_sub_left hNum 1).trans (soft_threshold_small_input hb (hZ₀ z))
  have hLow (z : Fin n → κ) (hz : X z ≤ ζ + t - d) : K z ≤ 2 * E := by
    have hNum : (1 / 2) * Real.exp (d * s) ≤ Z z := by
      unfold Z
      apply mul_le_mul hC₂ _ (Real.exp_nonneg _) hC₀
      apply Real.exp_le_exp.2
      have hX : d ≤ ζ + t - X z := by linarith only [hz]
      nlinarith only [mul_le_mul_of_nonneg_left hX hs.le]
    have hPrec : 0 < (1 / 2 : ℝ) * Real.exp (d * s) :=
      mul_pos (by norm_num) (Real.exp_pos _)
    have hPos : 0 < Z z := hPrec.trans_le hNum
    calc
      _ ≤ 1 / (1 + Z z) := soft_threshold_reciprocal_upper hb (hZ₀ z)
      _ ≤ 1 / Z z :=
        div_le_div_of_nonneg_left zero_le_one hPos (le_add_of_nonneg_left zero_le_one)
      _ ≤ 1 / ((1 / 2) * Real.exp (d * s)) := div_le_div_of_nonneg_left zero_le_one hPrec hNum
      _ = 2 * E := by
        unfold E
        rw [Real.exp_neg]
        field_simp [(Real.exp_pos (d * s)).ne']
  change 1 - finiteSumEvent p Y n (Iic (ζ + t + d)) - E ≤ productScalarMoment p q n b a ∧
    productScalarMoment p q n b a ≤ 1 - finiteSumEvent p Y n (Iic (ζ + t - d)) + 2 * E
  rw [hExact]
  constructor
  · let H (z : Fin n → κ) := (Ioi (ζ + t + d)).indicator (fun _ => (1 : ℝ)) (X z)
    have hPoint (z : Fin n → κ) : (1 - E) * H z ≤ K z := by
      by_cases hz : X z ∈ Ioi (ζ + t + d)
      · unfold H
        rw [indicator_of_mem hz, mul_one]
        exact hHigh z (mem_Ioi.mp hz)
      · unfold H
        rw [indicator_of_not_mem hz, mul_zero]
        exact hK₀ z
    have h := P.expect_mono hPoint
    rw [FiniteMass.expect_scale_function] at h
    change (1 - E) * finiteSumEvent p Y n (Ioi (ζ + t + d)) ≤ P.expect K at h
    rw [finite_sum_cdf_complement] at h
    have hT := finite_sum_event_nonneg p Y n (Iic (ζ + t + d))
    nlinarith only [h, mul_nonneg hE₀ hT]
  · let H (z : Fin n → κ) := (Ioi (ζ + t - d)).indicator (fun _ => (1 : ℝ)) (X z)
    have hPoint (z : Fin n → κ) : K z ≤ H z + 2 * E := by
      by_cases hz : X z ∈ Ioi (ζ + t - d)
      · unfold H
        rw [indicator_of_mem hz]
        exact (hK₁ z).trans (le_add_of_nonneg_right (by positivity))
      · unfold H
        rw [indicator_of_not_mem hz, zero_add]
        exact hLow z (le_of_not_gt hz)
    have h := P.expect_mono hPoint
    rw [FiniteMass.expect_add_functions, FiniteMass.expect_const] at h
    change P.expect K ≤ finiteSumEvent p Y n (Ioi (ζ + t - d)) + 2 * E at h
    rwa [finite_sum_cdf_complement] at h

end RenyiProductOrderPhase
