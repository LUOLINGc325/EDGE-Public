import FourierKernelShape
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.MeasureTheory.Group.Integral

/-! Normalization and quantitative tails of the smoothing density. -/

open scoped FourierTransform
open Set MeasureTheory

namespace RenyiProductOrderPhase

theorem smoothing_kernel_rpow_bound {T x : ℝ} (hT : 0 < T) (hx : 0 < x) :
    smoothingKernel T x ≤ (1 / (Real.pi ^ 2 * T)) * x ^ (-2 : ℝ) := by
  calc
    _ ≤ 1 / (Real.pi ^ 2 * T * x ^ 2) := smoothing_kernel_decay hT hx.ne'
    _ = _ := by
      rw [Real.rpow_neg hx.le, Real.rpow_two, ← one_div (x ^ 2), one_div_mul_one_div]

theorem smoothing_kernel_integrable_right {T d : ℝ} (hT : 0 < T) (hd : 0 < d) :
    IntegrableOn (smoothingKernel T) (Ioi d) := by
  have hdom : IntegrableOn (fun x : ℝ => (1 / (Real.pi ^ 2 * T)) * x ^ (-2 : ℝ)) (Ioi d) :=
    (integrableOn_Ioi_rpow_of_lt (by norm_num : (-2 : ℝ) < -1) hd).const_mul _
  apply hdom.mono' (smoothing_kernel_continuous hT).aestronglyMeasurable
  refine (ae_restrict_iff' measurableSet_Ioi).2 (Filter.Eventually.of_forall ?_)
  intro x hx
  rw [Real.norm_eq_abs, abs_of_nonneg (smoothing_kernel_nonneg hT x)]
  exact smoothing_kernel_rpow_bound hT (hd.trans hx)

theorem smoothing_kernel_integrable {T : ℝ} (hT : 0 < T) :
    Integrable (smoothingKernel T) := by
  have hR : IntegrableOn (smoothingKernel T) (Ioi (1 : ℝ)) :=
    smoothing_kernel_integrable_right hT zero_lt_one
  have hL : IntegrableOn (smoothingKernel T) (Iio (-1 : ℝ)) := by
    have h : IntegrableOn (smoothingKernel T) (Ioi (-(-1 : ℝ))) := by
      simpa only [neg_neg] using hR
    simpa only [smoothing_kernel_even] using h.comp_neg_Iio
  have hM : IntegrableOn (smoothingKernel T) (Icc (-1 : ℝ) 1) :=
    (smoothing_kernel_continuous hT).integrableOn_Icc
  have h : IntegrableOn (smoothingKernel T) ((Iio (-1 : ℝ) ∪ Icc (-1) 1) ∪ Ioi 1) :=
    (hL.union hM).union hR
  have hs : (Iio (-1 : ℝ) ∪ Icc (-1) 1) ∪ Ioi 1 = univ := by
    ext x
    refine ⟨fun _ => mem_univ _, fun _ => ?_⟩
    by_cases hx : x < -1
    · exact Or.inl (Or.inl hx)
    · by_cases hx' : x ≤ 1
      · exact Or.inl (Or.inr ⟨le_of_not_gt hx, hx'⟩)
      · exact Or.inr (lt_of_not_ge hx')
  rwa [hs, integrableOn_univ] at h

theorem smoothing_kernel_unit_mass {T : ℝ} (hT : 0 < T) :
    (∫ x, smoothingKernel T x) = 1 := by
  let f (t : ℝ) := (triangleCutoff T t : ℂ)
  let g (x : ℝ) := (smoothingKernel T x : ℂ)
  have hInv : 𝓕⁻ f = g := funext (inverse_triangle_integral hT)
  have hForward : 𝓕 f = g := by
    funext x
    calc
      (𝓕 f) x = (𝓕⁻ f) (-x) := by rw [Real.fourierIntegralInv_eq_fourierIntegral_neg, neg_neg]
      _ = _ := by simp only [hInv, g, smoothing_kernel_even]
  have hF : Integrable (𝓕 f) := by
    rw [hForward]
    exact (smoothing_kernel_integrable hT).norm.mono'
      (Complex.continuous_ofReal.comp (smoothing_kernel_continuous hT)).aestronglyMeasurable
      (Filter.Eventually.of_forall fun x => le_of_eq (Complex.norm_real _))
  have hfCont : Continuous f := Complex.continuous_ofReal.comp (triangle_cutoff_continuous T)
  have h := (complex_triangle_integrable hT).fourier_inversion_inv hF
    (v := (0 : ℝ)) hfCont.continuousAt
  have hMass : (∫ x, (smoothingKernel T x : ℂ)) = 1 := by
    simpa only [hInv, Real.fourierIntegral_eq', g, f, inner_zero_right, mul_zero,
      Complex.ofReal_zero, zero_mul, Complex.exp_zero, smul_eq_mul, one_mul,
      triangle_cutoff_at_zero, Complex.ofReal_one] using h
  rw [integral_complex_ofReal] at hMass
  exact_mod_cast hMass

theorem smoothing_kernel_mass_pos_tail {T d : ℝ} (hT : 0 < T) (hd : 0 < d) :
    (∫ x in Ioi d, smoothingKernel T x) ≤ 1 / (Real.pi ^ 2 * T * d) := by
  have hi := integrableOn_Ioi_rpow_of_lt (by norm_num : (-2 : ℝ) < -1) hd
  have hdom : IntegrableOn (fun x : ℝ => (1 / (Real.pi ^ 2 * T)) * x ^ (-2 : ℝ)) (Ioi d) :=
    hi.const_mul _
  calc
    _ ≤ ∫ x in Ioi d, (1 / (Real.pi ^ 2 * T)) * x ^ (-2 : ℝ) :=
      setIntegral_mono_on (smoothing_kernel_integrable_right hT hd) hdom measurableSet_Ioi
        (fun x hx => smoothing_kernel_rpow_bound hT (hd.trans hx))
    _ = _ := by
      rw [integral_const_mul, integral_Ioi_rpow_of_lt (by norm_num : (-2 : ℝ) < -1) hd]
      norm_num [Real.rpow_neg_one, ← one_div, one_div_mul_one_div]

theorem smoothing_kernel_tail_reflect {T d : ℝ} :
    (∫ x in Iio (-d), smoothingKernel T x) = ∫ x in Ioi d, smoothingKernel T x := by
  rw [← integral_indicator measurableSet_Iio, ← integral_indicator measurableSet_Ioi]
  calc
    _ = ∫ x, (Iio (-d)).indicator (smoothingKernel T) (-x) :=
      (integral_neg_eq_self _ volume).symm
    _ = _ := by
      refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
      change (Iio (-d)).indicator (smoothingKernel T) (-x) =
        (Ioi d).indicator (smoothingKernel T) x
      by_cases hx : x ∈ Ioi d
      · have hy : -x ∈ Iio (-d) := neg_lt_neg (show d < x from hx)
        rw [indicator_of_mem hy, indicator_of_mem hx, smoothing_kernel_even]
      · have hy : -x ∉ Iio (-d) := fun h =>
          hx (show d < x by linarith only [show -x < -d from h])
        rw [indicator_of_not_mem hy, indicator_of_not_mem hx]

noncomputable def smoothingTail (T d : ℝ) : ℝ :=
  ∫ x in {y : ℝ | d ≤ |y|}, smoothingKernel T x

theorem smoothing_tail_bound {T d : ℝ} (hT : 0 < T) (hd : 0 < d) :
    0 ≤ smoothingTail T d ∧ smoothingTail T d ≤ 2 / (Real.pi ^ 2 * T * d) := by
  have h : {x : ℝ | d ≤ |x|} = Iic (-d) ∪ Ici d := by
    ext x
    change d ≤ |x| ↔ x ≤ -d ∨ d ≤ x
    rcases le_or_gt 0 x with hx | hx
    · rw [abs_of_nonneg hx]
      constructor
      · exact Or.inr
      · intro h'
        rcases h' with h' | h'
        · exfalso; linarith only [h', hd, hx]
        · exact h'
    · rw [abs_of_neg hx]
      constructor
      · intro hh
        exact Or.inl (by linarith only [hh])
      · intro hh
        rcases hh with hh | hh
        · linarith only [hh]
        · exfalso; linarith only [hh, hx, hd]
  have hdj : Disjoint (Iic (-d)) (Ici d) := Set.disjoint_left.2 (by
    intro x hx hy
    have h₁ : x ≤ -d := hx
    have h₂ : d ≤ x := hy
    linarith only [h₁, h₂, hd])
  have hi := smoothing_kernel_integrable hT
  unfold smoothingTail
  rw [h, setIntegral_union hdj measurableSet_Ici hi.integrableOn hi.integrableOn,
    integral_Iic_eq_integral_Iio, integral_Ici_eq_integral_Ioi, smoothing_kernel_tail_reflect]
  constructor
  · exact add_nonneg (setIntegral_nonneg measurableSet_Ioi (fun x _ =>
      smoothing_kernel_nonneg hT x)) (setIntegral_nonneg measurableSet_Ioi (fun x _ =>
      smoothing_kernel_nonneg hT x))
  · linarith only [smoothing_kernel_mass_pos_tail hT hd,
      show 2 / (Real.pi ^ 2 * T * d) = 2 * (1 / (Real.pi ^ 2 * T * d)) by ring]

end RenyiProductOrderPhase
