import SmoothedFourierSum
import Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral
import Mathlib.MeasureTheory.Integral.DominatedConvergence

/-! L¹ convergence on the rescaled Fourier side, with a position-independent error. -/

open scoped Topology
open Set Filter MeasureTheory

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem nat_sqrt_tendsto_atTop : Tendsto (fun n : ℕ => Real.sqrt (n : ℝ)) atTop atTop := by
  have h := (tendsto_rpow_atTop (by norm_num : 0 < (1 / 2 : ℝ))).comp
    (tendsto_natCast_atTop_atTop : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop)
  simpa only [Function.comp_apply, Real.sqrt_eq_rpow] using h

theorem div_nat_sqrt_tendsto_zero (c : ℝ) :
    Tendsto (fun n : ℕ => c / Real.sqrt (n : ℝ)) atTop (𝓝 0) := by
  have hInv : Tendsto (fun t : ℝ => t⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_nhdsGT_zero.mono_right nhdsWithin_le_nhds
  have ht : Tendsto (fun _ : ℕ => c) atTop (𝓝 c) := tendsto_const_nhds
  simpa only [Function.comp_apply, div_eq_mul_inv, mul_zero] using
    ht.mul (hInv.comp nat_sqrt_tendsto_atTop)

noncomputable def gaussianSpectral (v u : ℝ) : ℂ :=
  (Real.exp (-(2 * Real.pi ^ 2 * v) * u ^ 2) : ℂ)

theorem characteristic_scaled_tendsto (p : FiniteMass κ) (Y : κ → ℝ)
    (hm : p.expect Y = 0) (hv : 0 < p.expect (fun i => Y i ^ 2)) (u : ℝ) :
    Tendsto (fun n : ℕ => characteristic p Y (u / Real.sqrt (n : ℝ)) ^ n)
      atTop (𝓝 (gaussianSpectral (p.expect (fun i => Y i ^ 2)) u)) := by
  obtain ⟨C, _, hC⟩ := characteristic_scaled_error_bound p Y hm hv
  apply Metric.tendsto_atTop.2
  intro ε hε
  have hErrors : ∀ᶠ n : ℕ in atTop, C * |u| ^ 3 / Real.sqrt (n : ℝ) < ε :=
    (div_nat_sqrt_tendsto_zero (C * |u| ^ 3)).eventually (Iio_mem_nhds hε)
  have hSize : ∀ᶠ n : ℕ in atTop, |u| ≤ Real.sqrt (n : ℝ) :=
    (tendsto_atTop.1 nat_sqrt_tendsto_atTop) _
  have hPositive : ∀ᶠ n : ℕ in atTop, 0 < n := eventually_gt_atTop 0
  apply eventually_atTop.1
  filter_upwards [hErrors, hSize, hPositive] with n hn hn' hn''
  rw [dist_eq_norm]
  exact (hC u n hn'' hn').trans_lt hn

noncomputable def rescaledSpectral (p : FiniteMass κ) (Y : κ → ℝ)
    (T a b : ℝ) (n : ℕ) (u : ℝ) : ℂ :=
  intervalFourierFactor T a b (u / Real.sqrt (n : ℝ)) *
    characteristic p Y (-(u / Real.sqrt (n : ℝ))) ^ n

theorem rescaled_spectral_continuous (p : FiniteMass κ) (Y : κ → ℝ)
    (T : ℝ) {a b : ℝ} (hab : a ≤ b) (n : ℕ) :
    Continuous (rescaledSpectral p Y T a b n) := by
  have hArg : Continuous (fun u : ℝ => u / Real.sqrt (n : ℝ)) := continuous_id.div_const _
  unfold rescaledSpectral
  exact ((interval_fourier_factor_continuous T hab).comp hArg).mul
    (((characteristic_continuous p Y).comp hArg.neg).pow n)

theorem rescaled_spectral_tendsto (p : FiniteMass κ) (Y : κ → ℝ)
    (hm : p.expect Y = 0) (hv : 0 < p.expect (fun i => Y i ^ 2))
    (T : ℝ) {a b : ℝ} (hab : a ≤ b) (u : ℝ) :
    Tendsto (fun n : ℕ => rescaledSpectral p Y T a b n u) atTop
      (𝓝 (((b - a : ℝ) : ℂ) * gaussianSpectral (p.expect (fun i => Y i ^ 2)) u)) := by
  have hA := (interval_fourier_factor_continuous T hab).continuousAt.tendsto.comp
    (div_nat_sqrt_tendsto_zero u)
  rw [interval_fourier_factor_at_zero] at hA
  have hP := characteristic_scaled_tendsto p Y hm hv (-u)
  have he : gaussianSpectral (p.expect (fun i => Y i ^ 2)) (-u) =
      gaussianSpectral (p.expect (fun i => Y i ^ 2)) u := by simp [gaussianSpectral]
  rw [he] at hP
  simpa only [Function.comp_apply, neg_div, rescaledSpectral] using hA.mul hP

theorem rescaled_spectral_gaussian_bound (p : FiniteMass κ) (Y : κ → ℝ) {T c a b : ℝ}
    (hT : 0 < T) (hab : a ≤ b)
    (hBand : ∀ t : ℝ, |t| ≤ T → ‖characteristic p Y t‖ ≤ Real.exp (-c * t ^ 2))
    {n : ℕ} (hn : 0 < n) (u : ℝ) :
    ‖rescaledSpectral p Y T a b n u‖ ≤ (b - a) * Real.exp (-c * u ^ 2) := by
  let t := u / Real.sqrt (n : ℝ)
  have hL : 0 ≤ b - a := sub_nonneg.mpr hab
  change ‖intervalFourierFactor T a b t * characteristic p Y (-t) ^ n‖ ≤ _
  by_cases ht : |t| ≤ T
  · have hp := hBand (-t) (by rwa [abs_neg])
    have hPow : ‖characteristic p Y (-t) ^ n‖ ≤ Real.exp (-c * u ^ 2) := by
      rw [norm_pow]
      calc
        _ ≤ (Real.exp (-c * (-t) ^ 2)) ^ n := pow_le_pow_left₀ (norm_nonneg _) hp _
        _ = _ := by
          rw [neg_sq]
          exact gaussian_scaling_power c u hn
    rw [norm_mul]
    exact (mul_le_mul_of_nonneg_right (interval_fourier_factor_bound hT hab t)
      (norm_nonneg _)).trans (mul_le_mul_of_nonneg_left hPow hL)
  · rw [interval_fourier_factor_zero hT (lt_of_not_ge ht).le a b, zero_mul, norm_zero]
    exact mul_nonneg hL (Real.exp_pos _).le

noncomputable def scaledFourierError (p : FiniteMass κ) (Y : κ → ℝ)
    (T a b : ℝ) (n : ℕ) (u : ℝ) : ℝ :=
  ‖rescaledSpectral p Y T a b n u -
    ((b - a : ℝ) : ℂ) * gaussianSpectral (p.expect (fun i => Y i ^ 2)) u‖

theorem scaled_fourier_error_integral_tendsto (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (Y : κ → ℝ) (hNon : ¬ ArithmeticSupport Y)
    (hm : p.expect Y = 0) (hv : 0 < p.expect (fun i => Y i ^ 2))
    {T a b : ℝ} (hT : 0 < T) (hab : a ≤ b) :
    Tendsto (fun n : ℕ => ∫ u, scaledFourierError p Y T a b (n + 1) u) atTop (𝓝 0) := by
  obtain ⟨c, hc, hBand⟩ := characteristic_gaussian_on_band p hp Y hNon hm hv hT
  let k := 2 * Real.pi ^ 2 * p.expect (fun i => Y i ^ 2)
  have hk : 0 < k := mul_pos (mul_pos (by norm_num) (pow_pos Real.pi_pos 2)) hv
  let C (u : ℝ) := (b - a) * Real.exp (-c * u ^ 2) + (b - a) * Real.exp (-k * u ^ 2)
  have hC : Integrable C :=
    ((integrable_exp_neg_mul_sq hc).const_mul _).add ((integrable_exp_neg_mul_sq hk).const_mul _)
  have hTarget : Continuous (fun u : ℝ =>
      ((b - a : ℝ) : ℂ) * gaussianSpectral (p.expect (fun i => Y i ^ 2)) u) := by
    unfold gaussianSpectral
    fun_prop
  have hMeas (n : ℕ) : AEStronglyMeasurable (scaledFourierError p Y T a b (n + 1)) :=
    (((rescaled_spectral_continuous p Y T hab (n + 1)).sub hTarget).norm).aestronglyMeasurable
  have hMajor (n : ℕ) (u : ℝ) : ‖scaledFourierError p Y T a b (n + 1) u‖ ≤ C u := by
    rw [Real.norm_of_nonneg (show 0 ≤ scaledFourierError p Y T a b (n + 1) u from norm_nonneg _)]
    unfold scaledFourierError
    have hPoint := rescaled_spectral_gaussian_bound p Y hT hab hBand (Nat.succ_pos n) u
    have hNorm : ‖((b - a : ℝ) : ℂ) * gaussianSpectral (p.expect (fun i => Y i ^ 2)) u‖ =
        (b - a) * Real.exp (-k * u ^ 2) := by
      unfold gaussianSpectral
      rw [norm_mul, Complex.norm_of_nonneg (sub_nonneg.mpr hab),
        Complex.norm_of_nonneg (Real.exp_pos _).le]
    exact (norm_sub_le _ _).trans (add_le_add hPoint hNorm.le)
  have hShift : Tendsto (fun n : ℕ => n + 1) atTop atTop := tendsto_atTop.2 fun N =>
    (eventually_ge_atTop N).mono (fun n h => h.trans (Nat.le_succ n))
  have hLimit (u : ℝ) : Tendsto (fun n : ℕ => scaledFourierError p Y T a b (n + 1) u)
      atTop (𝓝 0) := by
    have h := (rescaled_spectral_tendsto p Y hm hv T hab u).comp hShift
    let v := ((b - a : ℝ) : ℂ) * gaussianSpectral (p.expect (fun i => Y i ^ 2)) u
    have hV : Tendsto (fun _ : ℕ => v) atTop (𝓝 v) := tendsto_const_nhds
    simpa only [Function.comp_apply, sub_self, norm_zero, scaledFourierError, v] using
      (h.sub hV).norm
  simpa only [integral_zero] using tendsto_integral_of_dominated_convergence C hMeas hC
    (fun n => Filter.Eventually.of_forall (hMajor n))
    (Filter.Eventually.of_forall hLimit)

end RenyiProductOrderPhase
