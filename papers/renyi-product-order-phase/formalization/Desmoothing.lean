import SmoothedConvolution

/-! Removing smoothing with strict translation margins and no assumptions on atoms. -/

open Set MeasureTheory

namespace RenyiProductOrderPhase

theorem good_translation_compl (d : ℝ) :
    (Ioo (-d) d)ᶜ = {x : ℝ | d ≤ |x|} := by
  ext x
  change ¬ (-d < x ∧ x < d) ↔ d ≤ |x|
  rw [← abs_lt, not_lt]

theorem smoothing_kernel_good_mass {T : ℝ} (hT : 0 < T) (d : ℝ) :
    (∫ z in Ioo (-d) d, smoothingKernel T z) = 1 - smoothingTail T d := by
  let B := {x : ℝ | d ≤ |x|}
  have hB : MeasurableSet B := (isClosed_le continuous_const continuous_abs).measurableSet
  have he : Bᶜ = Ioo (-d) d := by
    change ({x : ℝ | d ≤ |x|} : Set ℝ)ᶜ = Ioo (-d) d
    rw [← good_translation_compl, compl_compl]
  rw [← he]
  have h := setIntegral_compl hB (smoothing_kernel_integrable hT)
  rw [smoothing_kernel_unit_mass hT] at h
  exact h

variable {κ : Type*} [Fintype κ]

theorem closed_event_below_smoothed (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    {T d h : ℝ} (hT : 0 < T) (hd : 0 < d) (hh : 0 < h) (x : ℝ) :
    (1 - smoothingTail T d) * finiteSumEvent p Y n (Icc x (x + h)) ≤
      smoothedIntervalMass p Y n T x (-d) (h + d) := by
  let U := Ioo (-d) d
  let q := finiteSumEvent p Y n (Icc x (x + h))
  let H (z : ℝ) := smoothingKernel T z *
    finiteSumEvent p Y n (Ioc (x + (-d) - z) (x + (h + d) - z))
  have hI : Integrable H := kernel_times_event_integrable p Y n hT x (-d) (h + d)
  have hs : MeasurableSet U := measurableSet_Ioo
  have hH (z : ℝ) : 0 ≤ H z := mul_nonneg (smoothing_kernel_nonneg hT z)
    (finite_sum_event_nonneg p Y n _)
  have hSub (z : ℝ) (hz : z ∈ U) : Icc x (x + h) ⊆
      Ioc (x + (-d) - z) (x + (h + d) - z) := by
    intro y hy
    exact ⟨by linarith only [hy.1, hz.1], by linarith only [hy.2, hz.2]⟩
  have hA : (∫ z in U, q * smoothingKernel T z) ≤ ∫ z in U, H z :=
    setIntegral_mono_on ((smoothing_kernel_integrable hT).const_mul q).integrableOn
      hI.integrableOn hs (fun z hz => by
        rw [mul_comm q]
        exact mul_le_mul_of_nonneg_left (finite_sum_event_mono p Y n (hSub z hz))
          (smoothing_kernel_nonneg hT z))
  have hBC : (∫ z in U, H z) ≤ ∫ z, H z := by
    rw [← integral_add_compl hs hI]
    exact le_add_of_nonneg_right (setIntegral_nonneg hs.compl (fun z _ => hH z))
  have hFinal := hA.trans hBC
  rw [integral_const_mul, smoothing_kernel_good_mass hT] at hFinal
  rw [smoothed_finite_convolution p Y n hT (show -d ≤ h + d by linarith only [hh, hd]) x, mul_comm]
  exact hFinal

theorem smoothed_inner_below_event (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    {T d h Q : ℝ} (hT : 0 < T) (hd : 0 < d) (hEdge : 2 * d ≤ h)
    (hQ : ∀ y : ℝ, finiteSumEvent p Y n (Icc y (y + h)) ≤ Q) (x : ℝ) :
    smoothedIntervalMass p Y n T x d (h - d) ≤
      finiteSumEvent p Y n (Ico x (x + h)) + Q * smoothingTail T d := by
  let U := Ioo (-d) d
  let q := finiteSumEvent p Y n (Ico x (x + h))
  let H (z : ℝ) := smoothingKernel T z *
    finiteSumEvent p Y n (Ioc (x + d - z) (x + (h - d) - z))
  have hI : Integrable H := kernel_times_event_integrable p Y n hT x d (h - d)
  have hs : MeasurableSet U := measurableSet_Ioo
  have hSub (z : ℝ) (hz : z ∈ U) :
      Ioc (x + d - z) (x + (h - d) - z) ⊆ Ico x (x + h) := by
    intro y hy
    exact ⟨by linarith only [hy.1, hz.2], by linarith only [hy.2, hz.1]⟩
  have hAll (z : ℝ) : Ioc (x + d - z) (x + (h - d) - z) ⊆
      Icc (x + d - z) ((x + d - z) + h) := by
    intro y hy
    exact ⟨hy.1.le, by linarith only [hy.2, hd]⟩
  have hA : (∫ z in U, H z) ≤ ∫ z in U, q * smoothingKernel T z :=
    setIntegral_mono_on hI.integrableOn ((smoothing_kernel_integrable hT).const_mul q).integrableOn
      hs (fun z hz => by
        rw [mul_comm q]
        exact mul_le_mul_of_nonneg_left (finite_sum_event_mono p Y n (hSub z hz))
          (smoothing_kernel_nonneg hT z))
  have hB : (∫ z in Uᶜ, H z) ≤ ∫ z in Uᶜ, Q * smoothingKernel T z :=
    setIntegral_mono_on hI.integrableOn ((smoothing_kernel_integrable hT).const_mul Q).integrableOn
      hs.compl (fun z _ => by
        rw [mul_comm Q]
        exact mul_le_mul_of_nonneg_left
          ((finite_sum_event_mono p Y n (hAll z)).trans (hQ (x + d - z)))
            (smoothing_kernel_nonneg hT z))
  rw [integral_const_mul, smoothing_kernel_good_mass hT] at hA
  have hTailInt : (∫ z in Uᶜ, smoothingKernel T z) = smoothingTail T d :=
    congrArg (fun S : Set ℝ => ∫ z in S, smoothingKernel T z) (good_translation_compl d)
  rw [integral_const_mul, hTailInt] at hB
  have hq : 0 ≤ q := finite_sum_event_nonneg p Y n _
  have htail : 0 ≤ smoothingTail T d := (smoothing_tail_bound hT hd).1
  have hqa : q * (1 - smoothingTail T d) ≤ q := by
    simpa only [mul_one] using
      mul_le_mul_of_nonneg_left (sub_le_self 1 htail) hq
  rw [smoothed_finite_convolution p Y n hT (show d ≤ h - d by linarith) x]
  change (∫ z, H z) ≤ q + Q * smoothingTail T d
  rw [← integral_add_compl hs hI]
  exact add_le_add (hA.trans hqa) hB

end RenyiProductOrderPhase
