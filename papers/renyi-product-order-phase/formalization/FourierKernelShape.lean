import FourierCutoff
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv

/-! Positivity and pointwise bounds for the triangular smoothing density. -/

open scoped FourierTransform InnerProductSpace
open Set MeasureTheory

namespace RenyiProductOrderPhase

theorem smoothing_kernel_formula {T x : ℝ} (hT : 0 < T) (hx : x ≠ 0) :
    smoothingKernel T x =
      (1 - Real.cos (2 * Real.pi * (T * x))) / (2 * Real.pi ^ 2 * T * x ^ 2) := by
  let c := 2 * Real.pi * x
  let F (t : ℝ) := ((1 - t / T) * Real.sin (c * t)) / c -
    Real.cos (c * t) / (T * c ^ 2)
  have hc : c ≠ 0 := mul_ne_zero (mul_ne_zero (by norm_num) Real.pi_ne_zero) hx
  have hDeriv (t : ℝ) : HasDerivAt F ((1 - t / T) * Real.cos (c * t)) t := by
    have hL : HasDerivAt (fun t : ℝ => c * t) c t := by
      simpa only [mul_one] using (hasDerivAt_id t).const_mul c
    have hRamp : HasDerivAt (fun t : ℝ => 1 - t / T) (-1 / T) t := by
      simpa only [zero_sub, neg_div] using
        (hasDerivAt_const t (1 : ℝ)).sub ((hasDerivAt_id t).div_const T)
    have h := ((hRamp.mul hL.sin).div_const c).sub (hL.cos.div_const (T * c ^ 2))
    convert h using 1
    field_simp [hT.ne', hc]
    ring
  have hFTC :
      (∫ t in (0 : ℝ)..T, (1 - t / T) * Real.cos (c * t)) = F T - F 0 := by
    have hint : Continuous (fun t : ℝ => (1 - t / T) * Real.cos (c * t)) := by fun_prop
    exact intervalIntegral.integral_eq_sub_of_hasDerivAt (fun t _ => hDeriv t)
      (hint.intervalIntegrable 0 T)
  have hAngle (t : ℝ) : 2 * Real.pi * (t * x) = c * t := by unfold c; ring
  unfold smoothingKernel
  simp only [hAngle]
  rw [hFTC]
  have hEval : 2 * (F T - F 0) = 2 * (1 - Real.cos (c * T)) / (T * c ^ 2) := by
    unfold F
    simp only [div_self hT.ne', sub_self, mul_zero, zero_mul, zero_div,
      Real.sin_zero, Real.cos_zero, zero_sub, sub_neg_eq_add]
    ring
  have hDen : T * c ^ 2 = 2 * (2 * Real.pi ^ 2 * T * x ^ 2) := by unfold c; ring
  rw [hEval, hDen, mul_div_mul_left _ _ (by norm_num : (2 : ℝ) ≠ 0)]

theorem smoothing_kernel_even (T x : ℝ) : smoothingKernel T (-x) = smoothingKernel T x := by
  simp only [smoothingKernel, mul_neg, Real.cos_neg]

theorem smoothing_kernel_nonneg {T : ℝ} (hT : 0 < T) (x : ℝ) :
    0 ≤ smoothingKernel T x := by
  by_cases hx : x = 0
  · subst x
    simp only [smoothingKernel, mul_zero, Real.cos_zero, mul_one]
    apply mul_nonneg (by norm_num)
    apply intervalIntegral.integral_nonneg hT.le
    intro t ht
    exact sub_nonneg.mpr ((div_le_one hT).2 ht.2)
  · rw [smoothing_kernel_formula hT hx]
    exact div_nonneg (sub_nonneg.mpr (Real.cos_le_one _))
      (by positivity)

theorem smoothing_kernel_decay {T x : ℝ} (hT : 0 < T) (hx : x ≠ 0) :
    smoothingKernel T x ≤ 1 / (Real.pi ^ 2 * T * x ^ 2) := by
  rw [smoothing_kernel_formula hT hx]
  calc
    _ ≤ 2 / (2 * Real.pi ^ 2 * T * x ^ 2) :=
      div_le_div_of_nonneg_right (by linarith only [Real.neg_one_le_cos (2 * Real.pi * (T * x))])
        (by positivity)
    _ = _ := by
      rw [show 2 * Real.pi ^ 2 * T * x ^ 2 = 2 * (Real.pi ^ 2 * T * x ^ 2) by ring]
      simpa only [mul_one] using
        (mul_div_mul_left (1 : ℝ) (Real.pi ^ 2 * T * x ^ 2) (by norm_num : (2 : ℝ) ≠ 0))

theorem smoothing_kernel_continuous {T : ℝ} (hT : 0 < T) :
    Continuous (smoothingKernel T) := by
  let f (t : ℝ) := (triangleCutoff T t : ℂ)
  have hF : Continuous (𝓕 f) := by
    unfold Real.fourierIntegral
    apply VectorFourier.fourierIntegral_continuous Real.continuous_fourierChar
    · change Continuous (fun p : ℝ × ℝ => ⟪p.1, p.2⟫_ℝ)
      simp only [real_inner_product_eq_mul]
      exact continuous_fst.mul continuous_snd
    · exact complex_triangle_integrable hT
  have hEq : (fun x : ℝ => (𝓕 f (-x)).re) = smoothingKernel T := by
    funext x
    rw [← Real.fourierIntegralInv_eq_fourierIntegral_neg, inverse_triangle_integral hT,
      Complex.ofReal_re]
  rw [← hEq]
  exact Complex.continuous_re.comp (hF.comp continuous_neg)

end RenyiProductOrderPhase
