import EndpointAtomicSandwich
import Mathlib.Analysis.MeanInequalities

/-! Monotonicity and concavity of the negative log moment on all nonnegative priors. -/

open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def negativeLogProductMoment (p q : FiniteMass κ) (n : ℕ) (b a : ℝ) : ℝ :=
  -Real.log (productScalarMoment p q n b a)

theorem product_moment_pos_nonnegative_prior (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (n : ℕ) (b : ℝ)
    {a : ℝ} (ha : 0 ≤ a) :
    0 < productScalarMoment p q n b a := by
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let f (z : Fin n → κ) := (1 + a * likelihoodProduct p q z) ^ (-b)
  have hB (z : Fin n → κ) : 0 < 1 + a * likelihoodProduct p q z := by
    rw [← exp_likelihood_sum p q hp hq]
    positivity
  obtain ⟨x, hx⟩ := P.exists_weight_pos
  exact P.expect_pos (fun z => (Real.rpow_pos_of_pos (hB z) _).le) hx
    (Real.rpow_pos_of_pos (hB x) _)

theorem negative_log_product_moment_mono (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (n : ℕ) {b : ℝ} (hb : 0 < b) :
    MonotoneOn (negativeLogProductMoment p q n b) (Ici 0) := by
  intro x hx y hy hxy
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  have h : productScalarMoment p q n b y ≤ productScalarMoment p q n b x := by
    apply P.expect_mono
    intro z
    have hR : 0 < likelihoodProduct p q z := by
      rw [← exp_likelihood_sum p q hp hq]
      exact Real.exp_pos _
    change (1 + y * likelihoodProduct p q z) ^ (-b) ≤ (1 + x * likelihoodProduct p q z) ^ (-b)
    exact Real.rpow_le_rpow_of_nonpos (by have hx₀ : 0 ≤ x := hx; positivity)
      (add_le_add_left (mul_le_mul_of_nonneg_right hxy hR.le) _) (neg_nonpos.mpr hb.le)
  exact neg_le_neg (Real.log_le_log (product_moment_pos_nonnegative_prior p q hp hq n b hy) h)

theorem negative_log_product_moment_zero (p q : FiniteMass κ) (n : ℕ) (b : ℝ) :
    negativeLogProductMoment p q n b 0 = 0 := by
  unfold negativeLogProductMoment productScalarMoment
  simp only [zero_mul, add_zero, Real.one_rpow, FiniteMass.expect_const, Real.log_one, neg_zero]

theorem negative_log_product_moment_concave (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (n : ℕ) {b : ℝ} (hb : 0 < b) :
    ConcaveOn ℝ (Ici 0) (negativeLogProductMoment p q n b) := by
  refine ⟨convex_Ici 0, ?_⟩
  intro x hx y hy u v hu hv huv
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let base (a : ℝ) (z : Fin n → κ) := 1 + a * likelihoodProduct p q z
  let f (a : ℝ) (z : Fin n → κ) := (base a z) ^ (-b)
  let A (a : ℝ) := productScalarMoment p q n b a
  let w := u * x + v * y
  have hx₀ : 0 ≤ x := hx
  have hy₀ : 0 ≤ y := hy
  have hw : 0 ≤ w := add_nonneg (mul_nonneg hu hx₀) (mul_nonneg hv hy₀)
  have hbase {a : ℝ} (ha : 0 ≤ a) (z : Fin n → κ) : 0 < base a z := by
    unfold base
    rw [← exp_likelihood_sum p q hp hq]
    positivity
  have hF {a : ℝ} (ha : 0 ≤ a) (z : Fin n → κ) : 0 < f a z :=
    Real.rpow_pos_of_pos (hbase ha z) _
  have hX : 0 < A x := product_moment_pos_nonnegative_prior p q hp hq n b hx₀
  have hY : 0 < A y := product_moment_pos_nonnegative_prior p q hp hq n b hy₀
  let C := A x ^ u * A y ^ v
  have hC : 0 < C := mul_pos (Real.rpow_pos_of_pos hX _) (Real.rpow_pos_of_pos hY _)
  have hInterp (z : Fin n → κ) : f w z ≤ f x z ^ u * f y z ^ v := by
    have hL := strictConcaveOn_log_Ioi.concaveOn.2 (show base x z ∈ Ioi 0 from hbase hx₀ z)
      (show base y z ∈ Ioi 0 from hbase hy₀ z) hu hv huv
    simp only [smul_eq_mul] at hL
    have hEq : u * base x z + v * base y z = base w z := by
      unfold base w
      nlinarith only [huv]
    rw [hEq] at hL
    unfold f
    rw [← Real.rpow_mul (hbase hx₀ z).le, ← Real.rpow_mul (hbase hy₀ z).le,
      Real.rpow_def_of_pos (hbase hw z), Real.rpow_def_of_pos (hbase hx₀ z),
      Real.rpow_def_of_pos (hbase hy₀ z), ← Real.exp_add]
    apply Real.exp_le_exp.2
    nlinarith only [mul_le_mul_of_nonneg_left hL hb.le]
  have hPoint (z : Fin n → κ) : f w z ≤ C * (u * (f x z / A x) + v * (f y z / A y)) := by
    apply (hInterp z).trans
    have h := Real.geom_mean_le_arith_mean2_weighted hu hv
      (div_nonneg (hF hx₀ z).le hX.le) (div_nonneg (hF hy₀ z).le hY.le) huv
    have hf : C * ((f x z / A x) ^ u * (f y z / A y) ^ v) = f x z ^ u * f y z ^ v := by
      unfold C
      rw [Real.div_rpow (hF hx₀ z).le hX.le, Real.div_rpow (hF hy₀ z).le hY.le]
      field_simp [(Real.rpow_pos_of_pos hX u).ne', (Real.rpow_pos_of_pos hY v).ne']
    rw [← hf]
    exact mul_le_mul_of_nonneg_left h hC.le
  have hE (t : ℝ) (ht : 0 < A t) : P.expect (fun z => f t z / A t) = 1 := by
    simp only [div_eq_mul_inv, mul_comm _ (A t)⁻¹, FiniteMass.expect_scale_function]
    have h : P.expect (f t) = A t := rfl
    rw [h, inv_mul_cancel₀ ht.ne']
  have hM := P.expect_mono hPoint
  rw [FiniteMass.expect_scale_function, FiniteMass.expect_add_functions,
    FiniteMass.expect_scale_function, FiniteMass.expect_scale_function, hE x hX, hE y hY,
    mul_one, mul_one, huv, mul_one] at hM
  have hLog := Real.log_le_log (product_moment_pos_nonnegative_prior p q hp hq n b hw) hM
  unfold C at hLog
  rw [Real.log_mul (Real.rpow_pos_of_pos hX _).ne' (Real.rpow_pos_of_pos hY _).ne',
    Real.log_rpow hX, Real.log_rpow hY] at hLog
  change u * -Real.log (A x) + v * -Real.log (A y) ≤ -Real.log (A w)
  linarith only [hLog]

theorem negative_log_product_moment_small_prior (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (n : ℕ) {b a : ℝ}
    (hb : 0 < b) (ha : 0 ≤ a) (ha' : a ≤ 1) :
    a * negativeLogProductMoment p q n b 1 ≤ negativeLogProductMoment p q n b a := by
  have h := (negative_log_product_moment_concave p q hp hq n hb).2
    (mem_Ici.mpr (show (0 : ℝ) ≤ 1 from zero_le_one)) (mem_Ici.mpr (le_refl (0 : ℝ)))
    ha (sub_nonneg.mpr ha') (show a + (1 - a) = 1 by ring)
  simpa only [smul_eq_mul, negative_log_product_moment_zero, mul_zero, mul_one, add_zero] using h

end RenyiProductOrderPhase
