import SmoothingKernelMass
import CharacteristicScaling
import Mathlib.MeasureTheory.Integral.Prod

/-! The Fourier representation of smoothing over a translated interval. -/

open scoped BigOperators FourierTransform
open Set MeasureTheory

namespace RenyiProductOrderPhase

theorem fourier_phase_continuous : Continuous fourierPhase := by
  unfold fourierPhase
  fun_prop

theorem smoothing_kernel_fourier {T : ℝ} (hT : 0 < T) (x : ℝ) :
    (smoothingKernel T x : ℂ) =
      ∫ t, fourierPhase (t * x) * (triangleCutoff T t : ℂ) := by
  rw [← inverse_triangle_integral hT, Real.fourierIntegralInv_eq']
  simp only [real_inner_product_eq_mul, smul_eq_mul, fourierPhase]

theorem interval_restricted_volume_finite (a b : ℝ) :
    IsFiniteMeasure (volume.restrict (Ioc a b)) := by
  constructor
  rw [Measure.restrict_apply MeasurableSet.univ, univ_inter, Real.volume_Ioc]
  exact ENNReal.ofReal_lt_top

noncomputable def intervalFourierFactor (T a b t : ℝ) : ℂ :=
  (triangleCutoff T t : ℂ) * ∫ v in a..b, fourierPhase (t * v)

theorem interval_fourier_factor_at_zero (T a b : ℝ) :
    intervalFourierFactor T a b 0 = ((b - a : ℝ) : ℂ) := by
  simp [intervalFourierFactor, triangle_cutoff_at_zero, fourier_phase_zero, smul_eq_mul]

theorem interval_fourier_factor_bound {T a b : ℝ} (hT : 0 < T) (hab : a ≤ b) (t : ℝ) :
    ‖intervalFourierFactor T a b t‖ ≤ b - a := by
  have h : ‖∫ v in a..b, fourierPhase (t * v)‖ ≤ b - a := by
    calc
      _ ≤ ∫ v in a..b, ‖fourierPhase (t * v)‖ :=
        intervalIntegral.norm_integral_le_integral_norm hab
      _ = _ := by simp [fourier_phase_norm]
  unfold intervalFourierFactor
  rw [norm_mul, Complex.norm_of_nonneg (triangle_cutoff_nonneg T t)]
  calc
    _ ≤ 1 * ‖∫ v in a..b, fourierPhase (t * v)‖ :=
      mul_le_mul_of_nonneg_right (triangle_cutoff_le_one hT t) (norm_nonneg _)
    _ ≤ _ := by simpa only [one_mul] using h

theorem interval_fourier_factor_zero {T t : ℝ} (hT : 0 < T) (ht : T ≤ |t|) (a b : ℝ) :
    intervalFourierFactor T a b t = 0 := by
  simp [intervalFourierFactor, triangle_cutoff_zero hT ht]

theorem interval_fourier_factor_continuous (T : ℝ) {a b : ℝ} (hab : a ≤ b) :
    Continuous (intervalFourierFactor T a b) := by
  let μ := volume.restrict (Ioc a b)
  letI : IsFiniteMeasure μ := interval_restricted_volume_finite a b
  have hC : Continuous (fun t : ℝ => ∫ v, fourierPhase (t * v) ∂μ) := by
    apply continuous_of_dominated (bound := fun _ => (1 : ℝ))
    · intro t
      exact (fourier_phase_continuous.comp (continuous_const.mul continuous_id)).aestronglyMeasurable
    · intro t
      exact Filter.Eventually.of_forall (fun _ => (fourier_phase_norm _).le)
    · exact integrable_const _
    · exact Filter.Eventually.of_forall (fun v =>
        fourier_phase_continuous.comp (continuous_id.mul continuous_const))
  unfold intervalFourierFactor
  simp only [intervalIntegral.integral_of_le hab]
  exact (Complex.continuous_ofReal.comp (triangle_cutoff_continuous T)).mul hC

theorem smoothing_interval_fourier {T a b : ℝ} (hT : 0 < T) (hab : a ≤ b) (x s : ℝ) :
    Complex.ofReal (∫ v in a..b, smoothingKernel T (x + v - s)) =
      ∫ t, (fourierPhase (t * x) * intervalFourierFactor T a b t) * fourierPhase (-t * s) := by
  let μ := volume.restrict (Ioc a b)
  letI : IsFiniteMeasure μ := interval_restricted_volume_finite a b
  let F (v t : ℝ) := fourierPhase (t * (x + v - s)) * (triangleCutoff T t : ℂ)
  have hFCont : Continuous (fun z : ℝ × ℝ => F z.1 z.2) := by
    unfold F
    apply Continuous.mul
    · exact fourier_phase_continuous.comp (by fun_prop)
    · exact Complex.continuous_ofReal.comp ((triangle_cutoff_continuous T).comp continuous_snd)
  have hFN (v t : ℝ) : ‖F v t‖ = triangleCutoff T t := by
    unfold F
    rw [norm_mul, fourier_phase_norm, one_mul, Complex.norm_of_nonneg (triangle_cutoff_nonneg T t)]
  have hJoint : Integrable (Function.uncurry F) (μ.prod volume) := by
    apply (integrable_prod_iff hFCont.aestronglyMeasurable).2
    constructor
    · refine Filter.Eventually.of_forall fun v => ?_
      apply continuous_cutoff_integrable (T := T)
      · exact hFCont.comp (continuous_const.prodMk continuous_id)
      · intro t ht
        have hs : T < |t| := lt_of_not_ge (fun h => ht (abs_le.mp h))
        simp [F, triangle_cutoff_zero hT hs.le]
    · simp only [hFN]
      exact integrable_const _
  calc
    _ = ∫ v, (smoothingKernel T (x + v - s) : ℂ) ∂μ := by
      rw [intervalIntegral.integral_of_le hab, integral_complex_ofReal]
    _ = ∫ v, ∫ t, F v t ∂volume ∂μ := by
      refine integral_congr_ae (Filter.Eventually.of_forall fun v => ?_)
      exact smoothing_kernel_fourier hT (x + v - s)
    _ = ∫ t, ∫ v, F v t ∂μ := integral_integral_swap hJoint
    _ = _ := by
      refine integral_congr_ae (Filter.Eventually.of_forall fun t => ?_)
      let c := (fourierPhase (t * x) * (triangleCutoff T t : ℂ)) * fourierPhase (-t * s)
      have hFactor (v : ℝ) : F v t = c * fourierPhase (t * v) := by
        unfold F c
        rw [show t * (x + v - s) = t * x + t * v + (-t * s) by ring,
          fourier_phase_add, fourier_phase_add]
        ring
      simp only [hFactor, integral_const_mul, intervalFourierFactor,
        intervalIntegral.integral_of_le hab]
      change c * (∫ v, fourierPhase (t * v) ∂μ) = _
      unfold c
      ring

end RenyiProductOrderPhase
