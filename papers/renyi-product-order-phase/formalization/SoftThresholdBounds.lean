import EndpointAtomicSandwich

/-! Finite soft-threshold bounds and a general power bound for the exact moment. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

theorem soft_threshold_small_input {b z : ℝ} (hb : 1 ≤ b) (hz : 0 ≤ z) :
    1 - z ≤ (1 + z / b) ^ (-b) := by
  have h := (normalized_gap_bounds hb hz).2.trans (min_le_left _ _)
  unfold normalizedGap kernelGap at h
  linarith only [h]

theorem soft_threshold_large_input {b z : ℝ} (hb : 0 < b) (hz : 0 ≤ z) :
    (1 + z / b) ^ (-b) ≤ Real.exp (-(min (z / 2) (b * Real.log 2))) := by
  let x := z / b
  have hx : 0 ≤ x := div_nonneg hz hb.le
  have hBase : 0 < 1 + x := by linarith
  have hB : min (z / 2) (b * Real.log 2) ≤ b * Real.log (1 + x) := by
    rcases le_or_gt x 1 with h | h
    · apply (min_le_left _ _).trans
      have hDen : x / 2 ≤ x / (1 + x) :=
        div_le_div_of_nonneg_left hx hBase (by linarith)
      have hR := mul_le_mul_of_nonneg_left (hDen.trans (log_one_add_bounds hx).1) hb.le
      have hX : b * x = z := mul_div_cancel₀ _ hb.ne'
      rwa [← mul_div_assoc, hX] at hR
    · exact (min_le_right _ _).trans (mul_le_mul_of_nonneg_left
        (Real.log_le_log (by norm_num) (by linarith only [h])) hb.le)
  rw [Real.rpow_def_of_pos hBase]
  apply Real.exp_le_exp.2
  linarith only [hB]

theorem soft_threshold_power_bound {b z t : ℝ} (ht : 0 < t) (htb : t ≤ b) (hz : 0 < z) :
    (1 + z / b) ^ (-b) ≤ (z / t) ^ (-t) := by
  have hb : 0 < b := ht.trans_le htb
  have hX : 0 ≤ z / b := div_nonneg hz.le hb.le
  have hP : 1 ≤ b / t := (le_div_iff₀ ht).2 (by simpa only [one_mul] using htb)
  have h := one_add_mul_self_le_rpow_one_add (show -1 ≤ z / b by linarith) hP
  have he : b / t * (z / b) = z / t := by
    field_simp [hb.ne', ht.ne']
    ring
  rw [he] at h
  have hDown : z / t ≤ (1 + z / b) ^ (b / t) := (le_add_of_nonneg_left zero_le_one).trans h
  have hR := Real.rpow_le_rpow_of_nonpos (div_pos hz ht) hDown (neg_nonpos.mpr ht.le)
  have hExponent : b / t * -t = -b := by
    rw [mul_neg, div_mul_cancel₀ _ ht.ne']
  rwa [← Real.rpow_mul (by linarith : 0 ≤ 1 + z / b), hExponent] at hR

variable {κ : Type*} [Fintype κ]

theorem tensor_exponential_moment (p q : FiniteMass κ) (s : ℝ) (n : ℕ) :
    (FiniteMass.tensor (fun _ : Fin n => p)).expect (fun x =>
      Real.exp (s * likelihoodSum p q x)) = tiltNormalizer p q s ^ n := by
  let f (i : κ) := Real.exp (s * logLikelihood p q i)
  have hPoint (x : Fin n → κ) : Real.exp (s * likelihoodSum p q x) = ∏ j, f (x j) := by
    unfold f likelihoodSum
    rw [Finset.mul_sum, Real.exp_sum]
  simp_rw [hPoint]
  rw [FiniteMass.expect_tensor_product (fun _ : Fin n => p) (fun _ => f)]
  simp only [tiltNormalizer, f, Finset.prod_const, Finset.card_univ, Fintype.card_fin]

theorem product_moment_power_upper (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (n : ℕ)
    {b a t : ℝ} (ha : 0 < a) (ht : 0 < t) (htb : t ≤ b) :
    productScalarMoment p q n b a ≤ (b * a / t) ^ (-t) * tiltNormalizer p q (-t) ^ n := by
  let C := (b * a / t) ^ (-t)
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  have hb : 0 < b := ht.trans_le htb
  rw [← tensor_exponential_moment p q (-t) n, ← FiniteMass.expect_scale_function]
  change P.expect (fun x => (1 + a * likelihoodProduct p q x) ^ (-b)) ≤ _
  apply P.expect_mono
  intro x
  let s := likelihoodSum p q x
  let z := b * a * Real.exp s
  have hz : 0 < z := mul_pos (mul_pos hb ha) (Real.exp_pos _)
  have hB : z / b = a * Real.exp s := by
    unfold z
    rw [mul_assoc, mul_div_cancel_left₀ _ hb.ne']
  have hT : z / t = (b * a / t) * Real.exp s := by
    unfold z
    rw [mul_div_right_comm]
  change (1 + a * likelihoodProduct p q x) ^ (-b) ≤ C * Real.exp (-t * s)
  rw [← exp_likelihood_sum p q hp hq, ← hB]
  apply (soft_threshold_power_bound ht htb hz).trans_eq
  rw [hT, Real.mul_rpow (div_nonneg (mul_nonneg hb.le ha.le) ht.le) (Real.exp_nonneg _),
    ← Real.exp_mul, mul_comm s (-t)]

theorem product_negative_log_power_lower (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (n : ℕ)
    {b a t : ℝ} (ha : 0 < a) (ht : 0 < t) (htb : t ≤ b) :
    t * (Real.log b + Real.log a - Real.log t) - (n : ℝ) * logCumulant p q (-t) ≤
      -Real.log (productScalarMoment p q n b a) := by
  have hb := ht.trans_le htb
  have hBase : 0 < b * a / t := div_pos (mul_pos hb ha) ht
  have hZ := tilt_normalizer_pos p q (-t)
  have hPos : 0 < productScalarMoment p q n b a := by
    rw [← scalar_moment_of_products]
    exact scalar_moment_pos _ _ b ha
  have h := Real.log_le_log hPos (product_moment_power_upper p q hp hq n ha ht htb)
  rw [Real.log_mul (Real.rpow_pos_of_pos hBase _).ne' (pow_pos hZ _).ne',
    Real.log_rpow hBase, Real.log_pow, Real.log_div (mul_pos hb ha).ne' ht.ne',
    Real.log_mul hb.ne' ha.ne'] at h
  unfold logCumulant
  linarith only [h]

end RenyiProductOrderPhase
