import FourierLocalScaling
import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform

/-! Uniform Gaussian approximation for smoothed interval probabilities. -/

open scoped Topology
open Set Filter MeasureTheory

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def gaussianProfile (v : ℝ) (n : ℕ) (x : ℝ) : ℝ :=
  Real.sqrt (Real.pi / (2 * Real.pi ^ 2 * v)) *
    Real.exp (-(2 * Real.pi * x / Real.sqrt (n : ℝ)) ^ 2 / (4 * (2 * Real.pi ^ 2 * v)))

theorem gaussian_profile_nonneg (v : ℝ) (n : ℕ) (x : ℝ) : 0 ≤ gaussianProfile v n x :=
  mul_nonneg (Real.sqrt_nonneg _) (Real.exp_pos _).le

theorem gaussian_profile_le_constant (v : ℝ) (hv : 0 < v) (n : ℕ) (x : ℝ) :
    gaussianProfile v n x ≤ Real.sqrt (Real.pi / (2 * Real.pi ^ 2 * v)) := by
  unfold gaussianProfile
  apply mul_le_of_le_one_right (Real.sqrt_nonneg _)
  rw [← Real.exp_zero, Real.exp_le_exp]
  exact div_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (sq_nonneg _)) (by positivity)

theorem integral_rescale_complex {r : ℝ} (hr : 0 < r) {f : ℝ → ℂ} (hf : StronglyMeasurable f) :
    (∫ u, f (u / r)) = (r : ℂ) * ∫ t, f t := by
  have hMap := integral_map_of_stronglyMeasurable (μ := volume)
    ((continuous_const.mul continuous_id).measurable :
      Measurable (fun u : ℝ => r⁻¹ * u)) hf
  change (∫ y, f y ∂Measure.map (fun x : ℝ => r⁻¹ * x) volume) =
    ∫ x, f (r⁻¹ * x) at hMap
  have h := Real.map_volume_mul_left (inv_ne_zero hr.ne')
  rw [h, inv_inv, abs_of_pos hr, integral_smul_measure, ENNReal.toReal_ofReal hr.le] at hMap
  simpa only [div_eq_mul_inv, mul_comm, Complex.real_smul] using hMap.symm

theorem gaussian_profile_fourier (v : ℝ) (hv : 0 < v) (n : ℕ) (x : ℝ) :
    (∫ u, fourierPhase ((u / Real.sqrt (n : ℝ)) * x) * gaussianSpectral v u) =
      (gaussianProfile v n x : ℂ) := by
  let k := 2 * Real.pi ^ 2 * v
  let z := 2 * Real.pi * x / Real.sqrt (n : ℝ)
  have hk : 0 < k := by unfold k; positivity
  have hw : 0 < (k : ℂ).re := by simpa using hk
  have h := fourierIntegral_gaussian (b := (k : ℂ)) hw (z : ℂ)
  have he (u : ℝ) :
      ((2 * Real.pi * ((u / Real.sqrt (n : ℝ)) * x) : ℝ) : ℂ) * Complex.I =
        Complex.I * (z : ℂ) * (u : ℂ) := by
    unfold z
    push_cast
    ring
  have hExp (u : ℝ) : gaussianSpectral v u = Complex.exp (-(k : ℂ) * (u : ℂ) ^ 2) := by
    unfold gaussianSpectral k
    rw [Complex.ofReal_exp]
    congr 1
    push_cast
    rfl
  simp only [fourierPhase, he, hExp]
  rw [h]
  have hLeft : (↑Real.pi / (k : ℂ)) ^ (1 / 2 : ℂ) =
      (Real.sqrt (Real.pi / k) : ℂ) := by
    have hd := div_nonneg Real.pi_pos.le hk.le
    rw [Real.sqrt_eq_rpow, Complex.ofReal_cpow hd, Complex.ofReal_div]
    norm_num
  have hRight : -(z : ℂ) ^ 2 / (4 * (k : ℂ)) = ((-z ^ 2 / (4 * k) : ℝ) : ℂ) := by
    push_cast
    ring
  rw [hLeft, hRight, ← Complex.ofReal_exp, ← Complex.ofReal_mul]
  rfl

theorem smoothed_interval_uniform_error (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (Y : κ → ℝ) (hNon : ¬ ArithmeticSupport Y)
    (hm : p.expect Y = 0) (hv : 0 < p.expect (fun i => Y i ^ 2))
    {T a b : ℝ} (hT : 0 < T) (hab : a ≤ b) {n : ℕ} (hn : 0 < n) (x : ℝ) :
    |Real.sqrt (n : ℝ) * smoothedIntervalMass p Y n T x a b -
      (b - a) * gaussianProfile (p.expect (fun i => Y i ^ 2)) n x| ≤
      ∫ u, scaledFourierError p Y T a b n u := by
  let r := Real.sqrt (n : ℝ)
  let v := p.expect (fun i => Y i ^ 2)
  let A := intervalFourierFactor T a b
  let P (u : ℝ) := fourierPhase ((u / r) * x)
  let F (u : ℝ) := P u * rescaledSpectral p Y T a b n u
  let G (u : ℝ) := P u * (((b - a : ℝ) : ℂ) * gaussianSpectral v u)
  have hr : 0 < r := Real.sqrt_pos.2 (by exact_mod_cast hn)
  have hArg : Continuous (fun u : ℝ => (u / r) * x) := by fun_prop
  have hP : Continuous P := fourier_phase_continuous.comp hArg
  have hC : Continuous (fun t : ℝ => (fourierPhase (t * x) * A t) * characteristic p Y (-t) ^ n) :=
    ((fourier_phase_continuous.comp (continuous_id.mul continuous_const)).mul
      (interval_fourier_factor_continuous T hab)).mul
        (((characteristic_continuous p Y).comp continuous_neg).pow n)
  have hRes : (∫ u, F u) = (r : ℂ) * (smoothedIntervalMass p Y n T x a b : ℂ) := by
    rw [smoothed_interval_fourier_power p Y n hT hab x]
    have h :=
      integral_rescale_complex hr hC.stronglyMeasurable
    convert h using 1
    refine integral_congr_ae (Filter.Eventually.of_forall fun u => ?_)
    unfold F P rescaledSpectral A
    ring
  have hGauss : (∫ u, G u) = ((b - a : ℝ) : ℂ) * (gaussianProfile v n x : ℂ) := by
    unfold G
    have he (u : ℝ) : P u * (((b - a : ℝ) : ℂ) * gaussianSpectral v u) =
        ((b - a : ℝ) : ℂ) * (P u * gaussianSpectral v u) := by ring
    simp_rw [he, integral_const_mul]
    rw [gaussian_profile_fourier v hv n x]
  obtain ⟨c, hc, hBand⟩ := characteristic_gaussian_on_band p hp Y hNon hm hv hT
  have hF : Integrable F := by
    apply ((integrable_exp_neg_mul_sq hc).const_mul (b - a)).mono'
      ((hP.mul (rescaled_spectral_continuous p Y T hab n)).aestronglyMeasurable)
    refine Filter.Eventually.of_forall fun u => ?_
    change ‖P u * rescaledSpectral p Y T a b n u‖ ≤ _
    rw [norm_mul, fourier_phase_norm, one_mul]
    exact rescaled_spectral_gaussian_bound p Y hT hab hBand hn u
  have hk : 0 < 2 * Real.pi ^ 2 * v :=
    mul_pos (mul_pos (by norm_num) (pow_pos Real.pi_pos 2)) hv
  have hGCont : Continuous G := hP.mul (by unfold gaussianSpectral; fun_prop)
  have hG : Integrable G := by
    apply ((integrable_exp_neg_mul_sq hk).const_mul (b - a)).mono' hGCont.aestronglyMeasurable
    refine Filter.Eventually.of_forall fun u => ?_
    unfold G gaussianSpectral
    rw [norm_mul, norm_mul, fourier_phase_norm, one_mul,
      Complex.norm_of_nonneg (sub_nonneg.mpr hab), Complex.norm_of_nonneg (Real.exp_pos _).le]
  let D := r * smoothedIntervalMass p Y n T x a b - (b - a) * gaussianProfile v n x
  have hD : (D : ℂ) = (∫ u, F u) - ∫ u, G u := by
    rw [hRes, hGauss]
    unfold D
    push_cast
    rfl
  change |D| ≤ _
  calc
    |D| = ‖(D : ℂ)‖ := by rw [Complex.norm_real, Real.norm_eq_abs]
    _ = ‖∫ u, F u - G u‖ := by rw [hD, ← integral_sub hF hG]
    _ ≤ ∫ u, ‖F u - G u‖ := norm_integral_le_integral_norm _
    _ = _ := by
      refine integral_congr_ae (Filter.Eventually.of_forall fun u => ?_)
      unfold F G scaledFourierError
      change ‖P u * rescaledSpectral p Y T a b n u -
        P u * (((b - a : ℝ) : ℂ) * gaussianSpectral v u)‖ = _
      rw [← mul_sub, norm_mul]
      unfold P
      rw [fourier_phase_norm, one_mul]

theorem smoothed_uniform_gaussian (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (Y : κ → ℝ) (hNon : ¬ ArithmeticSupport Y)
    (hm : p.expect Y = 0) (hv : 0 < p.expect (fun i => Y i ^ 2))
    {T a b : ℝ} (hT : 0 < T) (hab : a ≤ b) {ε : ℝ} (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ x : ℝ,
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * smoothedIntervalMass p Y (n + 1) T x a b -
        (b - a) * gaussianProfile (p.expect (fun i => Y i ^ 2)) (n + 1) x| < ε := by
  have h := scaled_fourier_error_integral_tendsto p hp Y hNon hm hv hT hab
  obtain ⟨N, hN⟩ := eventually_atTop.1 (h.eventually (Iio_mem_nhds hε))
  exact ⟨N, fun n hn x =>
    (smoothed_interval_uniform_error p hp Y hNon hm hv hT hab (Nat.succ_pos n) x).trans_lt
      (hN n hn)⟩

end RenyiProductOrderPhase
