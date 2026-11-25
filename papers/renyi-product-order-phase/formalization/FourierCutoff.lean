import FiniteCharacteristic
import Mathlib.Analysis.Fourier.Inversion
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

/-! The compact Fourier cutoff and its real, even inverse integral. -/

open scoped BigOperators FourierTransform InnerProductSpace
open Set MeasureTheory

namespace RenyiProductOrderPhase

noncomputable def triangleCutoff (T t : ℝ) : ℝ := max 0 (1 - |t| / T)

theorem triangle_cutoff_continuous (T : ℝ) : Continuous (triangleCutoff T) := by
  unfold triangleCutoff
  fun_prop

theorem triangle_cutoff_nonneg (T t : ℝ) : 0 ≤ triangleCutoff T t := le_max_left _ _

theorem triangle_cutoff_at_zero {T : ℝ} : triangleCutoff T 0 = 1 := by
  simp [triangleCutoff]

theorem triangle_cutoff_even (T t : ℝ) : triangleCutoff T (-t) = triangleCutoff T t := by
  simp only [triangleCutoff, abs_neg]

theorem triangle_cutoff_zero {T t : ℝ} (hT : 0 < T) (ht : T ≤ |t|) :
    triangleCutoff T t = 0 :=
  max_eq_left (sub_nonpos.mpr ((one_le_div hT).2 ht))

theorem triangle_cutoff_le_one {T : ℝ} (hT : 0 < T) (t : ℝ) : triangleCutoff T t ≤ 1 :=
  max_le zero_le_one (sub_le_self 1 (div_nonneg (abs_nonneg _) hT.le))

theorem triangle_cutoff_ramp {T t : ℝ} (hT : 0 < T) (ht : t ∈ Icc (0 : ℝ) T) :
    triangleCutoff T t = 1 - t / T := by
  unfold triangleCutoff
  rw [abs_of_nonneg ht.1]
  exact max_eq_right (sub_nonneg.mpr ((div_le_one hT).2 ht.2))

theorem continuous_cutoff_integrable {T : ℝ} {f : ℝ → ℂ}
    (hf : Continuous f) (hSupport : ∀ t, t ∉ Icc (-T) T → f t = 0) :
    Integrable f := by
  apply hf.integrable_of_hasCompactSupport
  change IsCompact (tsupport f)
  have hs : Function.support f ⊆ Icc (-T) T := by
    intro t ht
    by_contra h
    exact ht (hSupport t h)
  exact isCompact_Icc.of_isClosed_subset (isClosed_tsupport f) (closure_minimal hs isClosed_Icc)

theorem complex_triangle_integrable {T : ℝ} (hT : 0 < T) :
    Integrable (fun t => (triangleCutoff T t : ℂ)) := by
  apply continuous_cutoff_integrable (T := T)
    (Complex.continuous_ofReal.comp (triangle_cutoff_continuous T))
  intro t ht
  have h : T < |t| := lt_of_not_ge (fun he => ht (abs_le.mp he))
  change (triangleCutoff T t : ℂ) = 0
  rw [triangle_cutoff_zero hT h.le, Complex.ofReal_zero]

theorem fourier_phase_even_pair (x : ℝ) :
    fourierPhase (-x) + fourierPhase x = ((2 * Real.cos (2 * Real.pi * x) : ℝ) : ℂ) := by
  unfold fourierPhase
  rw [show 2 * Real.pi * -x = -(2 * Real.pi * x) by ring,
    Complex.ofReal_neg, Complex.exp_mul_I, Complex.exp_mul_I, Complex.cos_neg, Complex.sin_neg]
  rw [← Complex.ofReal_cos]
  push_cast
  ring

noncomputable def smoothingKernel (T x : ℝ) : ℝ :=
  2 * ∫ t in (0 : ℝ)..T, (1 - t / T) * Real.cos (2 * Real.pi * (t * x))

theorem real_inner_product_eq_mul (x y : ℝ) : ⟪x, y⟫_ℝ = x * y := by
  calc
    ⟪x, y⟫_ℝ = ⟪x • (1 : ℝ), y • (1 : ℝ)⟫_ℝ := by simp only [smul_eq_mul, mul_one]
    _ = x * y := by
      rw [real_inner_smul_left, real_inner_smul_right, real_inner_self_eq_norm_mul_norm]
      norm_num

theorem inverse_triangle_integral {T : ℝ} (hT : 0 < T) (x : ℝ) :
    (𝓕⁻ (fun t => (triangleCutoff T t : ℂ))) x = (smoothingKernel T x : ℂ) := by
  let g (t : ℝ) := fourierPhase (t * x) * (triangleCutoff T t : ℂ)
  have hgc : Continuous g := by
    unfold g fourierPhase
    have hPhase : Continuous (fun t : ℝ =>
        Complex.exp (((2 * Real.pi * (t * x) : ℝ) : ℂ) * Complex.I)) := by fun_prop
    exact hPhase.mul (Complex.continuous_ofReal.comp (triangle_cutoff_continuous T))
  have hgSupport (t : ℝ) (h : t ∉ Icc (-T) T) : g t = 0 := by
    have hout : T < |t| := lt_of_not_ge (fun he => h (abs_le.mp he))
    simp [g, triangle_cutoff_zero hT hout.le]
  have hBand : (∫ t, g t) = ∫ t in -T..T, g t := by
    calc
      _ = ∫ t, (Icc (-T) T).indicator g t := by
        apply integral_congr_ae
        apply Filter.Eventually.of_forall
        intro t
        by_cases h : t ∈ Icc (-T) T
        · rw [indicator_of_mem h]
        · rw [indicator_of_not_mem h, hgSupport t h]
      _ = _ := by
        rw [integral_indicator measurableSet_Icc, integral_Icc_eq_integral_Ioc,
          intervalIntegral.integral_of_le (by linarith only [hT])]
  have hFlip : (∫ t in -T..0, g t) = ∫ t in (0 : ℝ)..T, g (-t) := by
    rw [intervalIntegral.integral_comp_neg, neg_zero]
  have hPair : EqOn (fun t => g (-t) + g t)
      (fun t => ((2 * ((1 - t / T) * Real.cos (2 * Real.pi * (t * x))) : ℝ) : ℂ))
        (uIcc (0 : ℝ) T) := by
    intro t ht
    have hmem : t ∈ Icc (0 : ℝ) T := by rwa [uIcc_of_le hT.le] at ht
    change g (-t) + g t = _
    simp only [g, triangle_cutoff_even, triangle_cutoff_ramp hT hmem, neg_mul]
    rw [← add_mul, fourier_phase_even_pair, ← Complex.ofReal_mul]
    congr 1
    ring
  have hSum : (∫ t in (0 : ℝ)..T, g (-t) + g t) = (smoothingKernel T x : ℂ) := by
    rw [intervalIntegral.integral_congr hPair]
    unfold smoothingKernel
    have hcast (f : ℝ → ℝ) :
        (∫ t in (0 : ℝ)..T, (f t : ℂ)) = Complex.ofReal (∫ t in (0 : ℝ)..T, f t) := by
      simp only [intervalIntegral, integral_complex_ofReal, Complex.ofReal_sub]
    rw [hcast (fun t => 2 * ((1 - t / T) * Real.cos (2 * Real.pi * (t * x))))]
    rw [intervalIntegral.integral_const_mul]
  rw [Real.fourierIntegralInv_eq']
  simp only [real_inner_product_eq_mul, smul_eq_mul]
  change (∫ t, g t) = _
  rw [hBand, ← intervalIntegral.integral_add_adjacent_intervals (hgc.intervalIntegrable (-T) 0)
    (hgc.intervalIntegrable 0 T), hFlip]
  have hNeg : Continuous (fun t : ℝ => g (-t)) := hgc.comp continuous_neg
  have hAdd := intervalIntegral.integral_add (hNeg.intervalIntegrable (μ := volume) 0 T)
    (hgc.intervalIntegrable (μ := volume) 0 T)
  exact hAdd.symm.trans hSum

end RenyiProductOrderPhase
