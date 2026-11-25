import TiltedKernels

/-! Global bounds used to confine all fixed- and growing-order optimizing priors. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

theorem fixed_gap_half_min {b z : ℝ} (hb : 1 ≤ b) (hz : 0 ≤ z) :
    min z 1 / 2 ≤ kernelGap b z :=
  (half_min_le_ratio hz).trans (kernel_gap_bounds hb hz).1

theorem log_one_add_le_log_add_one {a : ℝ} (ha : 1 ≤ a) :
    Real.log (1 + a) ≤ Real.log a + 1 := by
  have hp : 0 < a := zero_lt_one.trans_le ha
  have hInv : 0 ≤ 1 / a := div_nonneg zero_le_one hp.le
  have hDiv : 1 / a ≤ 1 := (div_le_iff₀ hp).2 (by simpa only [one_mul] using ha)
  have hBase : 0 < 1 + 1 / a := by linarith
  have hEq : 1 + a = a * (1 + 1 / a) := by
    rw [mul_add, mul_one, mul_div_cancel₀ _ hp.ne', add_comm]
  rw [hEq, Real.log_mul hp.ne' hBase.ne']
  exact add_le_add_left ((log_one_add_bounds hInv).2.trans hDiv) _

theorem prior_exponential_threshold {a : ℝ} (ha : 0 < a) (s : ℝ) :
    (a * Real.exp s ≤ 1 ↔ s ≤ -Real.log a) ∧
      (1 ≤ a * Real.exp s ↔ -Real.log a ≤ s) := by
  have hEq : a * Real.exp (-Real.log a) = 1 := by
    rw [Real.exp_neg, Real.exp_log ha, mul_inv_cancel₀ ha.ne']
  constructor
  · rw [← hEq, mul_le_mul_left ha, Real.exp_le_exp]
  · rw [← hEq, mul_le_mul_left ha, Real.exp_le_exp]

theorem small_prior_kernel_lower {g : ℝ → ℝ} {a θ s : ℝ} (ha : 0 < a)
    (hs : s ≤ -Real.log a) (hg : min (a * Real.exp s) 1 / 2 ≤ g (a * Real.exp s)) :
    Real.exp ((1 - θ) * s) / 2 ≤
      Real.exp (-(θ * s)) * g (a * Real.exp s) / Real.log (1 + a) := by
  have hZ := (prior_exponential_threshold ha s).1.2 hs
  have hl := (log_one_add_bounds ha.le).2
  have hlPos : 0 < Real.log (1 + a) := Real.log_pos (by linarith)
  rw [min_eq_left hZ] at hg
  apply (le_div_iff₀ hlPos).2
  calc
    _ ≤ (Real.exp ((1 - θ) * s) / 2) * a :=
      mul_le_mul_of_nonneg_left hl (div_nonneg (Real.exp_nonneg _) (by norm_num))
    _ = Real.exp (-(θ * s)) * ((a * Real.exp s) / 2) := by
      rw [show (1 - θ) * s = -(θ * s) + s by ring, Real.exp_add]
      ring
    _ ≤ _ := mul_le_mul_of_nonneg_left hg (Real.exp_nonneg _)

theorem large_prior_kernel_lower {g : ℝ → ℝ} {a θ s : ℝ} (ha : 1 ≤ a)
    (hs : -Real.log a ≤ s) (hg : min (a * Real.exp s) 1 / 2 ≤ g (a * Real.exp s)) :
    Real.exp (-(θ * s)) / (2 * (Real.log a + 1)) ≤
      Real.exp (-(θ * s)) * g (a * Real.exp s) / Real.log (1 + a) := by
  have hp : 0 < a := zero_lt_one.trans_le ha
  have hZ := (prior_exponential_threshold hp s).2.2 hs
  have hl := log_one_add_le_log_add_one ha
  have hlPos : 0 < Real.log (1 + a) := Real.log_pos (by linarith)
  have hd : 0 < Real.log a + 1 := hlPos.trans_le hl
  rw [min_eq_right hZ] at hg
  apply (le_div_iff₀ hlPos).2
  calc
    _ ≤ (Real.exp (-(θ * s)) / (2 * (Real.log a + 1))) * (Real.log a + 1) :=
      mul_le_mul_of_nonneg_left hl (div_nonneg (Real.exp_nonneg _) (by positivity))
    _ = Real.exp (-(θ * s)) * (1 / 2) := by
      field_simp [hd.ne']
      ring
    _ ≤ _ := mul_le_mul_of_nonneg_left hg (Real.exp_nonneg _)

variable {κ : Type*} [Fintype κ]

theorem log_likelihood_sum_lower (p q : FiniteMass κ) {M : ℝ}
    (hM : ∀ y, -M ≤ logLikelihood p q y) {n : ℕ} (x : Fin n → κ) :
    -(n : ℝ) * M ≤ likelihoodSum p q x := by
  unfold likelihoodSum
  calc
    _ = ∑ _ : Fin n, -M := by simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin,
      nsmul_eq_mul, mul_neg, neg_mul]
    _ ≤ _ := Finset.sum_le_sum (fun i _ => hM (x i))

theorem product_deficit_finite_support_lower (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y)
    (n : ℕ) {M b a : ℝ} (hM : ∀ y, -M ≤ logLikelihood p q y)
    (hb : 0 < b) (ha : 0 < a) :
    Real.log (1 + a * Real.exp (-(n : ℝ) * M)) / Real.log (1 + a) ≤
      productScalarDeficit p q n b a := by
  let z := 1 + a * Real.exp (-(n : ℝ) * M)
  have hz : 0 < z := by unfold z; positivity
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  have hUpper : productScalarMoment p q n b a ≤ z ^ (-b) := by
    change P.expect (fun x => (1 + a * likelihoodProduct p q x) ^ (-b)) ≤ _
    rw [← P.expect_const (z ^ (-b))]
    apply P.expect_mono
    intro x
    rw [← exp_likelihood_sum p q hp hq]
    apply Real.rpow_le_rpow_of_nonpos hz _ (neg_nonpos.mpr hb.le)
    unfold z
    exact add_le_add_left (mul_le_mul_of_nonneg_left
      (Real.exp_le_exp.mpr (log_likelihood_sum_lower p q hM x)) ha.le) _
  have hMoment : 0 < productScalarMoment p q n b a := by
    rw [← scalar_moment_of_products]
    exact scalar_moment_pos _ _ b ha
  have hLog := Real.log_le_log hMoment hUpper
  rw [Real.log_rpow hz] at hLog
  have hP : 0 < Real.log (1 + a) := Real.log_pos (by linarith)
  unfold productScalarDeficit
  apply (le_div_iff₀ (mul_pos hb hP)).2
  have hEq : Real.log z / Real.log (1 + a) * (b * Real.log (1 + a)) =
      b * Real.log z := by
    field_simp [hP.ne']
    ring
  change Real.log z / Real.log (1 + a) * (b * Real.log (1 + a)) ≤ _
  rw [hEq]
  linarith only [hLog]

theorem product_deficit_large_prior_uniform (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y)
    (n : ℕ) {M b a : ℝ} (hM₀ : 0 ≤ M) (hM : ∀ y, -M ≤ logLikelihood p q y)
    (hb : 0 < b) (ha : 0 < a) (ht : 2 * (n : ℝ) * M + 1 ≤ Real.log a) :
    1 / 4 ≤ productScalarDeficit p q n b a := by
  let t := Real.log a
  have ht₀ : 0 ≤ 2 * (n : ℝ) * M := mul_nonneg (mul_nonneg (by norm_num) (Nat.cast_nonneg n)) hM₀
  have ht₁ : 1 ≤ t := (le_add_of_nonneg_left ht₀).trans ht
  have ha' : 1 ≤ a := by
    rw [← Real.exp_zero, ← Real.exp_log ha, Real.exp_le_exp]
    exact zero_le_one.trans ht₁
  have hL := log_one_add_le_log_add_one ha'
  have hExp : Real.log (a * Real.exp (-(n : ℝ) * M)) = t - (n : ℝ) * M := by
    rw [Real.log_mul ha.ne' (Real.exp_pos _).ne', Real.log_exp, neg_mul, sub_eq_add_neg]
  have hB := Real.log_le_log (mul_pos ha (Real.exp_pos _))
    (le_add_of_nonneg_left (zero_le_one : (0 : ℝ) ≤ 1) :
      a * Real.exp (-(n : ℝ) * M) ≤ 1 + a * Real.exp (-(n : ℝ) * M))
  rw [hExp] at hB
  apply le_trans _ (product_deficit_finite_support_lower p q hp hq n hM hb ha)
  apply (le_div_iff₀ (Real.log_pos (by linarith))).2
  linarith only [hB, hL, ht, ht₁]

end RenyiProductOrderPhase
