import GrowingKernelIntegral

/-! Common endpoint envelopes and a uniform estimate for the growing-order kernel. -/

namespace RenyiProductOrderPhase

theorem exp_weighted_envelope {θ A : ℝ} (hA : 0 ≤ A)
    (f : ℝ → ℝ) (s : ℝ) (h₀ : 0 ≤ f s) (h₁ : f s ≤ 1) (h₂ : f s ≤ A * Real.exp s) :
    0 ≤ Real.exp (-(θ * s)) * f s ∧
      Real.exp (-(θ * s)) * f s ≤ max 1 A * Real.exp (-(min θ (1 - θ) * |s|)) := by
  refine ⟨mul_nonneg (Real.exp_nonneg _) h₀, ?_⟩
  let c := min θ (1 - θ)
  have hc₀ : c ≤ θ := min_le_left _ _
  have hc₁ : c ≤ 1 - θ := min_le_right _ _
  change _ ≤ max 1 A * Real.exp (-(c * |s|))
  rcases le_or_gt 0 s with hs | hs
  · rw [abs_of_nonneg hs]
    calc
      _ ≤ Real.exp (-(θ * s)) := mul_le_of_le_one_right (Real.exp_nonneg _) h₁
      _ ≤ Real.exp (-(c * s)) :=
        Real.exp_le_exp.2 (neg_le_neg (mul_le_mul_of_nonneg_right hc₀ hs))
      _ ≤ _ := le_mul_of_one_le_left (Real.exp_nonneg _) (le_max_left _ _)
  · rw [abs_of_neg hs]
    calc
      _ ≤ Real.exp (-(θ * s)) * (A * Real.exp s) :=
        mul_le_mul_of_nonneg_left h₂ (Real.exp_nonneg _)
      _ = A * Real.exp ((1 - θ) * s) := by
        rw [show (1 - θ) * s = -(θ * s) + s by ring, Real.exp_add]
        ring
      _ ≤ A * Real.exp (-(c * -s)) := by
        apply mul_le_mul_of_nonneg_left _ hA
        apply Real.exp_le_exp.2
        rw [mul_neg, neg_neg]
        exact mul_le_mul_of_nonpos_right hc₁ hs.le
      _ ≤ _ := mul_le_mul_of_nonneg_right (le_max_right _ _) (Real.exp_nonneg _)

theorem fixed_tilted_kernel_envelope {a A b θ : ℝ} (ha : 0 ≤ a) (haA : a ≤ A)
    (hb : 1 ≤ b) (s : ℝ) :
    0 ≤ tiltedKernel b a θ s ∧
      tiltedKernel b a θ s ≤ max 1 (b * A) * Real.exp (-(min θ (1 - θ) * |s|)) := by
  let f (s : ℝ) := kernelGap b (a * Real.exp s)
  let z := a * Real.exp s
  have hz : 0 ≤ z := mul_nonneg ha (Real.exp_nonneg _)
  have hh := kernel_gap_bounds hb hz
  have h₀ : 0 ≤ f s := (div_nonneg hz (by linarith)).trans hh.1
  have hA : 0 ≤ b * A := mul_nonneg (by linarith) (ha.trans haA)
  have h₂ : f s ≤ (b * A) * Real.exp s := by
    apply hh.2.1.trans
    unfold z
    rw [← mul_assoc]
    exact mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left haA (by linarith))
      (Real.exp_nonneg _)
  exact exp_weighted_envelope hA f s h₀ hh.2.2.le h₂

theorem growing_tilted_kernel_envelope {a A b θ : ℝ} (ha : 0 ≤ a) (haA : a ≤ A)
    (hb : 1 ≤ b) (s : ℝ) :
    0 ≤ growingTiltedKernel b a θ s ∧
      growingTiltedKernel b a θ s ≤ max 1 A * Real.exp (-(min θ (1 - θ) * |s|)) := by
  let z := a * Real.exp s
  have hz : 0 ≤ z := mul_nonneg ha (Real.exp_nonneg _)
  have h := normalized_gap_bounds hb hz
  have h₀ : 0 ≤ normalizedGap b z := (div_nonneg hz (by linarith)).trans h.1
  have h₂ : normalizedGap b z ≤ A * Real.exp s :=
    (h.2.trans (min_le_left _ _)).trans (mul_le_mul_of_nonneg_right haA (Real.exp_nonneg _))
  exact exp_weighted_envelope (ha.trans haA) (fun s => normalizedGap b (a * Real.exp s))
    s h₀ (h.2.trans (min_le_right _ _)) h₂

theorem growing_limit_kernel_envelope {a A θ : ℝ} (ha : 0 ≤ a) (haA : a ≤ A)
    (s : ℝ) :
    0 ≤ growingLimitKernel a θ s ∧
      growingLimitKernel a θ s ≤ max 1 A * Real.exp (-(min θ (1 - θ) * |s|)) := by
  let z := a * Real.exp s
  have h := growing_limit_gap_bounds (mul_nonneg ha (Real.exp_nonneg s))
  have h₂ : growingLimitGap z ≤ A * Real.exp s :=
    h.2.1.trans (mul_le_mul_of_nonneg_right haA (Real.exp_nonneg _))
  exact exp_weighted_envelope (ha.trans haA) (fun s => growingLimitGap (a * Real.exp s))
    s h.1 h.2.2 h₂

theorem growing_tilted_kernel_compact_error {a A θ b K s : ℝ} (ha : 0 ≤ a) (haA : a ≤ A)
    (hθ : 0 ≤ θ) (hb : 1 ≤ b) (hK : |s| ≤ K) :
    0 ≤ growingLimitKernel a θ s - growingTiltedKernel b a θ s ∧
      growingLimitKernel a θ s - growingTiltedKernel b a θ s ≤
        Real.exp (θ * K) * (A * Real.exp K) ^ 2 / b := by
  let z := a * Real.exp s
  let e := growingLimitGap z - normalizedGap b z
  have hz : 0 ≤ z := mul_nonneg ha (Real.exp_nonneg _)
  have hA := ha.trans haA
  have hDiff : 0 ≤ e ∧ e ≤ z ^ 2 / b := normalized_gap_exp_error hb hz
  have hZ : z ≤ A * Real.exp K :=
    (mul_le_mul_of_nonneg_right haA (Real.exp_nonneg _)).trans
      (mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr ((le_abs_self s).trans hK)) hA)
  have hWeight : Real.exp (-(θ * s)) ≤ Real.exp (θ * K) := by
    apply Real.exp_le_exp.2
    rw [← mul_neg]
    exact mul_le_mul_of_nonneg_left ((neg_le_abs s).trans hK) hθ
  have hExact : growingLimitKernel a θ s - growingTiltedKernel b a θ s = Real.exp (-(θ * s)) * e := by
    unfold growingLimitKernel growingTiltedKernel e z
    rw [mul_sub]
  rw [hExact]
  refine ⟨mul_nonneg (Real.exp_nonneg _) hDiff.1, ?_⟩
  have hPow := pow_le_pow_left₀ hz hZ 2
  calc
    _ ≤ Real.exp (-(θ * s)) * (z ^ 2 / b) :=
      mul_le_mul_of_nonneg_left hDiff.2 (Real.exp_nonneg _)
    _ ≤ Real.exp (θ * K) * ((A * Real.exp K) ^ 2 / b) := by
      have hb₀ : 0 ≤ b := by linarith
      exact mul_le_mul hWeight (div_le_div_of_nonneg_right hPow hb₀)
        (div_nonneg (sq_nonneg _) hb₀) (Real.exp_nonneg _)
    _ = _ := (mul_div_assoc _ _ _).symm

variable {κ : Type*} [Fintype κ]

theorem product_deficit_by_missing (p q : FiniteMass κ)
    (n : ℕ) {b a : ℝ} (hb : 0 < b) (ha : 0 < a) :
    productMissing p q n b a / (b * Real.log (1 + a)) ≤ productScalarDeficit p q n b a ∧
      productScalarDeficit p q n b a ≤
        productMissing p q n b a / ((1 - productMissing p q n b a) * (b * Real.log (1 + a))) := by
  have hMoment : 0 < productScalarMoment p q n b a := by
    rw [← scalar_moment_of_products p q n b a]
    exact scalar_moment_pos _ _ b ha
  have hLess : productMissing p q n b a < 1 := by
    unfold productMissing
    linarith only [hMoment]
  have hSubtract : 1 - productMissing p q n b a = productScalarMoment p q n b a := by
    unfold productMissing
    ring
  have h := neg_log_one_sub_bounds hLess
  rw [hSubtract] at h
  have hDen : 0 ≤ b * Real.log (1 + a) := (mul_pos hb (Real.log_pos (by linarith))).le
  constructor
  · exact div_le_div_of_nonneg_right h.1 hDen
  · calc
      _ ≤ (productMissing p q n b a / productScalarMoment p q n b a) / (b * Real.log (1 + a)) :=
        div_le_div_of_nonneg_right h.2 hDen
      _ = _ := by rw [div_div, hSubtract]

end RenyiProductOrderPhase
