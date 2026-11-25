import GrowingSmoothingSpectrum
import Mathlib.MeasureTheory.Group.Integral

/-! Densities of normalized sums convolved with the increasing-band Fejér kernel. -/

open scoped Topology
open Filter Set MeasureTheory

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def smoothedSumDensity (p : FiniteMass κ) (Y : κ → ℝ)
    (n : ℕ) (T x : ℝ) : ℝ :=
  (FiniteMass.tensor (fun _ : Fin n => p)).expect (fun z => smoothingKernel T (x - iidSum Y z))

theorem smoothed_sum_density_nonneg (p : FiniteMass κ) (Y : κ → ℝ)
    (n : ℕ) {T : ℝ} (hT : 0 < T) (x : ℝ) : 0 ≤ smoothedSumDensity p Y n T x := by
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  change (0 : ℝ) ≤ P.expect _
  rw [← P.expect_const 0]
  exact P.expect_mono (fun _ => smoothing_kernel_nonneg hT _)

theorem smoothed_sum_density_fourier (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    {T : ℝ} (hT : 0 < T) (x : ℝ) :
    (smoothedSumDensity p Y n T x : ℂ) =
      ∫ t, (fourierPhase (t * x) * (triangleCutoff T t : ℂ)) * characteristic p Y (-t) ^ n := by
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let A (t : ℝ) := (triangleCutoff T t : ℂ)
  have hA : Continuous A := Complex.continuous_ofReal.comp (triangle_cutoff_continuous T)
  have hInt (z : Fin n → κ) : Integrable (fun t => (P z : ℂ) *
      ((fourierPhase (t * x) * A t) * fourierPhase (-t * iidSum Y z))) := by
    apply continuous_cutoff_integrable (T := T)
    · exact continuous_const.mul
        (((fourier_phase_continuous.comp (continuous_id.mul continuous_const)).mul hA).mul
          (fourier_phase_continuous.comp (continuous_neg.mul continuous_const)))
    · intro t ht
      have hbnd : T < |t| := lt_of_not_ge (fun he => ht (abs_le.mp he))
      simp [A, triangle_cutoff_zero hT hbnd.le]
  have hPhase (z : Fin n → κ) (t : ℝ) :
      fourierPhase (t * (x - iidSum Y z)) * A t =
        (fourierPhase (t * x) * A t) * fourierPhase (-t * iidSum Y z) := by
    rw [show t * (x - iidSum Y z) = t * x + -t * iidSum Y z by ring, fourier_phase_add]
    ring
  unfold smoothedSumDensity
  rw [← FiniteMass.complex_expect_coe]
  have hE (z : Fin n → κ) :
      (smoothingKernel T (x - iidSum Y z) : ℂ) =
        ∫ t, (fourierPhase (t * x) * A t) * fourierPhase (-t * iidSum Y z) := by
    rw [smoothing_kernel_fourier hT]
    exact integral_congr_ae (Filter.Eventually.of_forall (hPhase z))
  simp_rw [hE]
  change P.complexExpect (fun z => ∫ t, (fourierPhase (t * x) * A t) *
    fourierPhase (-t * iidSum Y z)) = _
  unfold FiniteMass.complexExpect
  simp only [← integral_const_mul]
  rw [← integral_finset_sum Finset.univ (fun z _ => hInt z)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun t => ?_)
  change (∑ z : Fin n → κ, (P z : ℂ) * ((fourierPhase (t * x) * A t) *
    fourierPhase (-t * iidSum Y z))) = (fourierPhase (t * x) * A t) * characteristic p Y (-t) ^ n
  rw [← characteristic_independent_sum p Y n (-t), characteristic, FiniteMass.complexExpect,
    Finset.mul_sum]
  refine Finset.sum_congr rfl fun z _ => ?_
  ring

theorem translated_smoothing_kernel_integrable {T : ℝ} (hT : 0 < T) (s : ℝ) :
    Integrable (fun x : ℝ => smoothingKernel T (x - s)) := by
  have h := smoothing_kernel_integrable hT
  have hMeas := (smoothing_kernel_continuous hT).aestronglyMeasurable (μ := volume)
  simpa only [Function.comp_apply, sub_eq_add_neg] using
    ((measurePreserving_add_right volume (-s)).integrable_comp hMeas).2 h

theorem smoothed_sum_density_integrable (p : FiniteMass κ) (Y : κ → ℝ)
    (n : ℕ) {T : ℝ} (hT : 0 < T) : Integrable (smoothedSumDensity p Y n T) := by
  unfold smoothedSumDensity FiniteMass.expect
  exact integrable_finset_sum Finset.univ
    (fun z _ => (translated_smoothing_kernel_integrable hT (iidSum Y z)).const_mul _)

theorem smoothed_sum_density_mass (p : FiniteMass κ) (Y : κ → ℝ)
    (n : ℕ) {T : ℝ} (hT : 0 < T) : (∫ x, smoothedSumDensity p Y n T x) = 1 := by
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  have hKernel (z : Fin n → κ) : (∫ x, smoothingKernel T (x - iidSum Y z)) = 1 := by
    rw [show (fun x : ℝ => smoothingKernel T (x - iidSum Y z)) =
      (fun x => smoothingKernel T (x + -iidSum Y z)) by simp only [sub_eq_add_neg]]
    rw [integral_add_right_eq_self, smoothing_kernel_unit_mass hT]
  change (∫ x, ∑ z : Fin n → κ, P z * smoothingKernel T (x - iidSum Y z)) = _
  rw [integral_finset_sum Finset.univ (fun z _ =>
    (translated_smoothing_kernel_integrable hT (iidSum Y z)).const_mul _)]
  simp only [integral_const_mul, hKernel, mul_one, P.total]

theorem smoothed_density_wide_cutoff_error (p : FiniteMass κ) (Y : κ → ℝ)
    (hv : 0 < p.expect (fun i => Y i ^ 2))
    {δ c : ℝ} (hδ : 0 < δ) (hc : 0 < c)
    (hBand : ∀ t : ℝ, |t| ≤ δ → ‖characteristic p Y t‖ ≤ Real.exp (-c * t ^ 2))
    {n : ℕ} (hn : 0 < n) (x : ℝ) :
    |smoothedSumDensity p (fun i => Y i / Real.sqrt (n : ℝ)) n
      (δ * Real.sqrt (n : ℝ)) x - gaussianProfile (p.expect (fun i => Y i ^ 2)) 1 x| ≤
        ∫ u, wideCutoffError p Y δ n u := by
  let v := p.expect (fun i => Y i ^ 2)
  let r := Real.sqrt (n : ℝ)
  let U (t : ℝ) := fourierPhase (t * x)
  let F (t : ℝ) := U t * wideCutoffSpectrum p Y δ n t
  let G (t : ℝ) := U t * gaussianSpectral v t
  let d := smoothedSumDensity p (fun i => Y i / r) n (δ * r) x
  have hr : 0 < r := Real.sqrt_pos.2 (by exact_mod_cast hn)
  have hD : (d : ℂ) = ∫ t, F t := by
    unfold d
    rw [smoothed_sum_density_fourier p (fun i => Y i / r) n (mul_pos hδ hr)]
    simp_rw [characteristic_div_summand p Y r]
    simp only [F, U, wideCutoffSpectrum, r, mul_assoc]
  have hG : (∫ t, G t) = (gaussianProfile v 1 x : ℂ) := by
    simpa only [G, U, Nat.cast_one, Real.sqrt_one, div_one] using gaussian_profile_fourier v hv 1 x
  have hUse : Continuous U := fourier_phase_continuous.comp (continuous_id.mul continuous_const)
  have hFInt : Integrable F := by
    apply (integrable_exp_neg_mul_sq hc).mono'
      ((hUse.mul (wide_cutoff_spectral_continuous p Y δ n)).aestronglyMeasurable)
    refine Filter.Eventually.of_forall fun t => ?_
    change ‖fourierPhase (t * x) * wideCutoffSpectrum p Y δ n t‖ ≤ _
    rw [norm_mul, fourier_phase_norm, one_mul]
    exact wide_cutoff_spectral_bound p Y hδ hBand hn t
  have hk : 0 < 2 * Real.pi ^ 2 * v := mul_pos (mul_pos (by norm_num)
    (pow_pos Real.pi_pos 2)) hv
  have hGInt : Integrable G := by
    have hCont : Continuous G := hUse.mul (by unfold gaussianSpectral; fun_prop)
    apply (integrable_exp_neg_mul_sq hk).mono' hCont.aestronglyMeasurable
    refine Filter.Eventually.of_forall fun t => ?_
    change ‖fourierPhase (t * x) * gaussianSpectral v t‖ ≤ _
    unfold gaussianSpectral
    rw [norm_mul, fourier_phase_norm, one_mul, Complex.norm_of_nonneg (Real.exp_pos _).le]
  change |d - gaussianProfile v 1 x| ≤ _
  calc
    _ = ‖((d - gaussianProfile v 1 x : ℝ) : ℂ)‖ := by rw [Complex.norm_real, Real.norm_eq_abs]
    _ = ‖∫ t, F t - G t‖ := by rw [Complex.ofReal_sub, hD, ← hG, ← integral_sub hFInt hGInt]
    _ ≤ ∫ t, ‖F t - G t‖ := norm_integral_le_integral_norm _
    _ = _ := by
      refine integral_congr_ae (Filter.Eventually.of_forall fun t => ?_)
      unfold F G U wideCutoffError
      change ‖fourierPhase (t * x) * wideCutoffSpectrum p Y δ n t -
        fourierPhase (t * x) * gaussianSpectral v t‖ = _
      rw [← mul_sub, norm_mul, fourier_phase_norm, one_mul]

end RenyiProductOrderPhase
