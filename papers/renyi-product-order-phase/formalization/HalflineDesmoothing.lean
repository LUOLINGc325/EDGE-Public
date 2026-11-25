import SmoothedNormalL1
import GridApproximationError
import Desmoothing

/-! Half-line desmoothing with the same explicit kernel tail, including atoms at the threshold. -/

open Set MeasureTheory

namespace RenyiProductOrderPhase

noncomputable def kernelCDF (T x : ℝ) : ℝ :=
  ∫ z in Iic x, smoothingKernel T z

theorem kernel_cdf_bounds {T : ℝ} (hT : 0 < T) (x : ℝ) :
    0 ≤ kernelCDF T x ∧ kernelCDF T x ≤ 1 := by
  unfold kernelCDF
  have h := setIntegral_le_integral (smoothing_kernel_integrable hT)
    (Filter.Eventually.of_forall (smoothing_kernel_nonneg hT)) (s := Iic x)
  rw [smoothing_kernel_unit_mass hT] at h
  exact ⟨setIntegral_nonneg measurableSet_Iic (fun z _ => smoothing_kernel_nonneg hT z), h⟩

theorem kernel_cdf_below_tail {T d x : ℝ} (hT : 0 < T) (hx : x ≤ -d) :
    kernelCDF T x ≤ smoothingTail T d := by
  unfold kernelCDF smoothingTail
  exact setIntegral_mono_set (smoothing_kernel_integrable hT).integrableOn
    (Filter.Eventually.of_forall (smoothing_kernel_nonneg hT))
    (Filter.Eventually.of_forall (fun z hz => by
      have hh : z ≤ -d := (mem_Iic.mp hz).trans hx
      exact (by linarith only [hh, neg_le_abs z] : d ≤ |z|)))

theorem kernel_cdf_above_tail {T d x : ℝ} (hT : 0 < T) (hx : d ≤ x) :
    1 - smoothingTail T d ≤ kernelCDF T x := by
  rw [← smoothing_kernel_good_mass hT]
  unfold kernelCDF
  exact setIntegral_mono_set (smoothing_kernel_integrable hT).integrableOn
    (Filter.Eventually.of_forall (smoothing_kernel_nonneg hT))
    (Filter.Eventually.of_forall (fun _ hz => (mem_Ioo.mp hz).2.le.trans hx))

theorem translated_kernel_cdf {T : ℝ} (x s : ℝ) :
    (∫ z in Iic x, smoothingKernel T (z - s)) = kernelCDF T (x - s) := by
  let f := (Iic (x - s)).indicator (smoothingKernel T)
  have h (z : ℝ) : (Iic x).indicator (fun y => smoothingKernel T (y - s)) z = f (z + -s) := by
    by_cases hz : z ≤ x
    · have hz' : z + -s ≤ x - s := by linarith only [hz]
      unfold f
      rw [indicator_of_mem (show z ∈ Iic x from hz), indicator_of_mem
        (show z + -s ∈ Iic (x - s) from hz'), sub_eq_add_neg]
    · have hz' : ¬ z + -s ≤ x - s := by
        intro hn
        exact hz (by linarith only [hn])
      unfold f
      rw [indicator_of_not_mem (show z ∉ Iic x from hz),
        indicator_of_not_mem (show z + -s ∉ Iic (x - s) from hz')]
  unfold kernelCDF
  rw [← integral_indicator measurableSet_Iic, ← integral_indicator measurableSet_Iic]
  simp only [h, integral_add_right_eq_self, f]

variable {κ : Type*} [Fintype κ]

theorem smoothed_sum_density_cdf (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    {T : ℝ} (hT : 0 < T) (x : ℝ) :
    (∫ y in Iic x, smoothedSumDensity p Y n T y) =
      (FiniteMass.tensor (fun _ : Fin n => p)).expect (fun z => kernelCDF T (x - iidSum Y z)) := by
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  change (∫ y in Iic x, ∑ z : Fin n → κ, P z * smoothingKernel T (y - iidSum Y z)) = _
  rw [integral_finset_sum Finset.univ (fun z _ =>
    ((translated_smoothing_kernel_integrable hT (iidSum Y z)).const_mul (P z)).integrableOn)]
  unfold FiniteMass.expect
  simp only [integral_const_mul, translated_kernel_cdf, P]

theorem sum_cdf_desmoothing (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    {T d : ℝ} (hT : 0 < T) (hd : 0 < d) (x : ℝ) :
    (∫ y in Iic (x - d), smoothedSumDensity p Y n T y) - smoothingTail T d ≤
      finiteSumEvent p Y n (Iic x) ∧ finiteSumEvent p Y n (Iic x) ≤
        (∫ y in Iic (x + d), smoothedSumDensity p Y n T y) + smoothingTail T d := by
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let X (z : Fin n → κ) := iidSum Y z
  let η := smoothingTail T d
  let F := finiteSumEvent p Y n (Iic x)
  let f (z : Fin n → κ) := (Iic x).indicator (fun _ => (1 : ℝ)) (X z)
  have hF : P.expect f = F := rfl
  have hη : 0 ≤ η := (smoothing_tail_bound hT hd).1
  rw [smoothed_sum_density_cdf p Y n hT, smoothed_sum_density_cdf p Y n hT]
  constructor
  · have hPoint (z : Fin n → κ) : kernelCDF T (x - d - X z) ≤ f z + η := by
      by_cases hz : X z ≤ x
      · unfold f
        rw [indicator_of_mem (mem_Iic.mpr hz)]
        exact (kernel_cdf_bounds hT _).2.trans (le_add_of_nonneg_right hη)
      · unfold f
        rw [indicator_of_not_mem (show X z ∉ Iic x from hz), zero_add]
        apply kernel_cdf_below_tail hT
        have hh := lt_of_not_ge hz
        linarith only [hh]
    have h := P.expect_mono hPoint
    rw [FiniteMass.expect_add_functions, P.expect_const, hF] at h
    change P.expect (fun z => kernelCDF T (x - d - X z)) - η ≤ F
    linarith only [h]
  · have hPoint (z : Fin n → κ) : (1 - η) * f z ≤ kernelCDF T (x + d - X z) := by
      by_cases hz : X z ≤ x
      · unfold f
        rw [indicator_of_mem (mem_Iic.mpr hz), mul_one]
        exact kernel_cdf_above_tail hT (by linarith only [hz])
      · unfold f
        rw [indicator_of_not_mem (show X z ∉ Iic x from hz), mul_zero]
        exact (kernel_cdf_bounds hT _).1
    have h := P.expect_mono hPoint
    rw [FiniteMass.expect_scale_function, hF] at h
    have hF₁ : F ≤ 1 := finite_sum_event_le_one p Y n _
    have he : η * F ≤ η := mul_le_of_le_one_right hη hF₁
    change F ≤ P.expect (fun z => kernelCDF T (x + d - X z)) + η
    nlinarith only [h, he]

end RenyiProductOrderPhase
