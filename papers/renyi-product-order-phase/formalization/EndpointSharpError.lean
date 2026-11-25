import EndpointAtomicRemainder

/-! An explicit two-sided error for the endpoint negative log moment. -/

open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem endpoint_negative_log_approximation (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) {M d a : ℝ}
    (hM₀ : 0 ≤ M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hGap : ∀ i, logLikelihood p q i = -M ∨ d ≤ logLikelihood p q i + M)
    (hm : 0 < endpointAtomMass p q M) (hm₁ : endpointAtomMass p q M ≤ 1)
    (n : ℕ) (ha : 0 < a) (haB : a ≤ Real.exp ((n : ℝ) * M)) :
    let b := Real.exp ((n : ℝ) * M)
    let m := endpointAtomMass p q M
    let N := (n : ℝ)
    let ell := endpointLogRate p q M
    let K := negativeLogProductMoment p q n b a
    0 ≤ N * ell + a - K ∧
      N * ell + a - K ≤ a ^ 2 / b + N * ((1 - m) / m) * Real.exp (-(a / 4) * d) +
        Real.exp (N * ell - b * Real.log 2) := by
  let N := (n : ℝ)
  let b := Real.exp (N * M)
  let m := endpointAtomMass p q M
  let ell := endpointLogRate p q M
  let K := negativeLogProductMoment p q n b a
  let C := (1 - m) / m
  let e := Real.exp (-(a / 4) * d)
  let B := 1 + a / b
  let L := N * C * e
  let T := Real.exp (N * ell - b * Real.log 2)
  have hn : 0 ≤ N := Nat.cast_nonneg _
  have hb : 0 < b := Real.exp_pos _
  have hC : 0 ≤ C := div_nonneg (sub_nonneg.mpr hm₁) hm.le
  have hL : 0 ≤ L := mul_nonneg (mul_nonneg hn hC) (Real.exp_nonneg _)
  have hB : 0 < B := add_pos_of_pos_of_nonneg zero_lt_one (div_nonneg ha.le hb.le)
  have hT : 0 ≤ T := Real.exp_nonneg _
  have hA : 0 < productScalarMoment p q n b a := product_moment_pos_nonnegative_prior p q hp hq n b ha.le
  have hRaw := endpoint_relative_moment_upper p q hp hq hM hGap n ha haB
  change productScalarMoment p q n b a ≤ B ^ (-b) *
    ((m + (1 - m) * e) ^ n + Real.exp (-(b * Real.log 2))) at hRaw
  have hFactor : m + (1 - m) * e = m * (1 + C * e) := by
    unfold C
    field_simp [hm.ne']
  have hPow : (m + (1 - m) * e) ^ n ≤ m ^ n * Real.exp L := by
    rw [hFactor, mul_pow]
    apply mul_le_mul_of_nonneg_left _ (pow_nonneg hm.le n)
    have hCe : 0 ≤ C * e := mul_nonneg hC (Real.exp_nonneg _)
    have hBound : 1 + C * e ≤ Real.exp (C * e) := by
      simpa only [add_comm] using Real.add_one_le_exp (C * e)
    have he : Real.exp (C * e) ^ n = Real.exp L := by
      rw [← Real.rpow_natCast, ← Real.exp_mul]
      congr 1
      unfold L N
      ring
    rw [← he]
    exact pow_le_pow_left₀ (by linarith only [hCe]) hBound n
  have hMass : m ^ n = Real.exp (-N * ell) := by
    have hE : -N * ell = Real.log m * N := by unfold ell endpointLogRate; ring
    rw [hE, Real.exp_mul, Real.exp_log hm]
    exact (Real.rpow_natCast m n).symm
  have hTail : Real.exp (-(b * Real.log 2)) = m ^ n * T := by
    rw [hMass]
    unfold T
    rw [← Real.exp_add]
    congr 1
    ring
  have hUpper := hRaw.trans (mul_le_mul_of_nonneg_left
    (add_le_add_right hPow _) (Real.rpow_nonneg hB.le (-b)))
  rw [hTail, ← mul_add] at hUpper
  have hLog := Real.log_le_log hA hUpper
  have he : 0 < Real.exp L + T := add_pos_of_pos_of_nonneg (Real.exp_pos _) hT
  rw [Real.log_mul (Real.rpow_pos_of_pos hB _).ne'
    (mul_pos (pow_pos hm n) he).ne', Real.log_rpow hB,
    Real.log_mul (pow_pos hm n).ne' he.ne', Real.log_pow] at hLog
  have hError : Real.log (Real.exp L + T) ≤ L + T := by
    have hExp : 1 ≤ Real.exp L := by simpa only [Real.exp_zero] using Real.exp_le_exp.mpr hL
    have hF : Real.exp L + T ≤ Real.exp L * (1 + T) := by
      have h := mul_le_mul_of_nonneg_right hExp hT
      nlinarith only [h]
    have h := Real.log_le_log he hF
    rw [Real.log_mul (Real.exp_pos _).ne' (add_pos_of_pos_of_nonneg zero_lt_one hT).ne',
      Real.log_exp] at h
    linarith only [h, (log_one_add_bounds hT).2]
  have hLogLower : a - a ^ 2 / b ≤ b * Real.log B := by
    let t := a / b
    have ht : 0 ≤ t := div_nonneg ha.le hb.le
    have ht' : 0 < 1 + t := add_pos_of_pos_of_nonneg zero_lt_one ht
    have h : t - t ^ 2 ≤ t / (1 + t) := by
      apply (le_div_iff₀ ht').2
      have he : 0 ≤ t ^ 3 := pow_nonneg ht _
      nlinarith only [he]
    have h' := mul_le_mul_of_nonneg_left (h.trans (log_one_add_bounds ht).1) hb.le
    have hS : b * (t - t ^ 2) = a - a ^ 2 / b := by
      unfold t
      field_simp [hb.ne']
      ring
    rwa [hS] at h'
  have hLogUpper : b * Real.log B ≤ a := by
    have h := mul_le_mul_of_nonneg_left (log_one_add_bounds (div_nonneg ha.le hb.le)).2 hb.le
    rwa [mul_div_cancel₀ _ hb.ne'] at h
  have hK : K ≤ N * ell + b * Real.log B := by
    have h := (product_deficit_endpoint_sandwich p q hp hq hM₀ hM hm ha hb n).2
    have hPos : 0 < b * Real.log (1 + a) := mul_pos hb (Real.log_pos (by linarith))
    have hInv : endpointEpsilon M n = b⁻¹ := by
      unfold endpointEpsilon b N
      rw [← Real.exp_neg]
      congr 1
      ring
    rw [hInv, ← div_eq_mul_inv] at h
    have hK' := (le_div_iff₀ hPos).1 h
    unfold productScalarDeficit at hK'
    rw [div_mul_cancel₀ _ hPos.ne'] at hK'
    exact hK'
  change 0 ≤ N * ell + a - K ∧ N * ell + a - K ≤ a ^ 2 / b + L + T
  refine ⟨sub_nonneg.mpr (hK.trans (add_le_add_left hLogUpper _)), ?_⟩
  change Real.log (productScalarMoment p q n b a) ≤
    (-b) * Real.log B + (N * Real.log m + Real.log (Real.exp L + T)) at hLog
  unfold K negativeLogProductMoment
  have hEll : Real.log m = -ell := by unfold ell endpointLogRate; rw [neg_neg]
  rw [hEll] at hLog
  linarith only [hLog, hError, hLogLower]

end RenyiProductOrderPhase
