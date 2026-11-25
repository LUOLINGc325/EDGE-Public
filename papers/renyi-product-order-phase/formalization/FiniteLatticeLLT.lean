import LatticeGaussianScaling
import FourierSmoothedUniform

/-! Uniform Gaussian approximation of the point masses on the maximal lattice. -/

open scoped Topology
open Set Filter MeasureTheory

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem gaussian_profile_even (v : ℝ) (n : ℕ) (x : ℝ) :
    gaussianProfile v n (-x) = gaussianProfile v n x := by
  simp only [gaussianProfile, mul_neg, neg_div, neg_sq]

theorem lattice_uniform_error {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) (hp : ∀ i, 0 < p i) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) {n : ℕ} (hn : 0 < n) {x : ℝ}
    (hx : ∃ z : ℤ, x = (n : ℝ) * L.offset + L.span * (z : ℝ)) :
    |Real.sqrt (n : ℝ) * finiteSumEvent p Y n {x} -
      L.span * gaussianProfile (p.expect (fun i => Y i ^ 2)) n x| ≤
      L.span * ∫ u, latticeSpectralError L p n u := by
  let r := Real.sqrt (n : ℝ)
  let v := p.expect (fun i => Y i ^ 2)
  let T := L.halfFrequency
  let P (u : ℝ) := fourierPhase ((u / r) * (-x))
  let F (u : ℝ) := P u * latticeBandSpectral L p n u
  let G (u : ℝ) := P u * gaussianSpectral v u
  have hr : 0 < r := Real.sqrt_pos.2 (by exact_mod_cast hn)
  have hArg : Continuous (fun u : ℝ => (u / r) * (-x)) := by fun_prop
  have hP : Continuous P := fourier_phase_continuous.comp hArg
  let f (t : ℝ) := (Ioc (-T) T).indicator
    (fun t => fourierPhase (t * (-x)) * characteristic p Y t ^ n) t
  have hf : Measurable f := by
    unfold f
    apply Measurable.indicator _ measurableSet_Ioc
    exact (((fourier_phase_continuous.comp (continuous_id.mul continuous_const)).mul
      ((characteristic_continuous p Y).pow n))).measurable
  have hFPoint (u : ℝ) : F u = f (u / r) := by
    change P u * (Ioc (-T) T).indicator (fun t => characteristic p Y t ^ n) (u / r) = _
    by_cases hu : u / r ∈ Ioc (-T) T
    · simp only [f, P, indicator_of_mem hu]
    · simp only [f, indicator_of_not_mem hu, mul_zero]
  have hScaled : (∫ u, F u) = (r : ℂ) * ∫ t, f t := by
    simp only [hFPoint]
    exact integral_rescale_complex hr hf.stronglyMeasurable
  have hOrigin : (∫ t, f t) = ∫ t in -T..T, fourierPhase (-t * x) * characteristic p Y t ^ n := by
    have hT := L.half_frequency_pos
    unfold f
    rw [integral_indicator measurableSet_Ioc,
      intervalIntegral.integral_of_le (show -T ≤ T by linarith only [hT])]
    simp only [mul_neg, neg_mul]
  have hMass := L.atom_fourier_inversion p n hx
  have hRes : ((r * finiteSumEvent p Y n {x} : ℝ) : ℂ) = (L.span : ℂ) * ∫ u, F u := by
    rw [Complex.ofReal_mul, hMass, hScaled, hOrigin]
    ring
  have hGauss : (∫ u, G u) = (gaussianProfile v n x : ℂ) := by
    unfold G P
    rw [gaussian_profile_fourier v hv n (-x), gaussian_profile_even]
  obtain ⟨c, hc, hBand⟩ := L.characteristic_band p hp hm hv
  have hF : Integrable F := by
    apply (integrable_exp_neg_mul_sq hc).mono'
      ((hP.measurable.mul (lattice_band_measurable L p n)).aestronglyMeasurable)
    refine Filter.Eventually.of_forall fun u => ?_
    unfold P
    rw [norm_mul, fourier_phase_norm, one_mul]
    exact lattice_band_norm L p hBand hn u
  have hk : 0 < 2 * Real.pi ^ 2 * v :=
    mul_pos (mul_pos (by norm_num) (pow_pos Real.pi_pos 2)) hv
  have hG : Integrable G := by
    have hC : Continuous G := hP.mul (by unfold gaussianSpectral; fun_prop)
    apply (integrable_exp_neg_mul_sq hk).mono' hC.aestronglyMeasurable
    refine Filter.Eventually.of_forall fun u => ?_
    unfold G P gaussianSpectral
    rw [norm_mul, fourier_phase_norm, one_mul, Complex.norm_of_nonneg (Real.exp_pos _).le]
  let E := r * finiteSumEvent p Y n {x} - L.span * gaussianProfile v n x
  change |E| ≤ _
  calc
    |E| = ‖(E : ℂ)‖ := by rw [Complex.norm_real, Real.norm_eq_abs]
    _ = L.span * ‖(∫ u, F u) - ∫ u, G u‖ := by
      unfold E
      rw [Complex.ofReal_sub, hRes, Complex.ofReal_mul, ← hGauss, ← mul_sub, norm_mul,
        Complex.norm_of_nonneg L.span_pos.le]
    _ ≤ L.span * ∫ u, ‖F u - G u‖ := by
      apply mul_le_mul_of_nonneg_left _ L.span_pos.le
      rw [← integral_sub hF hG]
      exact norm_integral_le_integral_norm _
    _ = _ := by
      congr 1
      refine integral_congr_ae (Filter.Eventually.of_forall fun u => ?_)
      unfold F G P latticeSpectralError
      change ‖fourierPhase ((u / r) * (-x)) * latticeBandSpectral L p n u -
        fourierPhase ((u / r) * (-x)) * gaussianSpectral v u‖ = _
      rw [← mul_sub, norm_mul, fourier_phase_norm, one_mul]

theorem finite_lattice_local_limit {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) (hp : ∀ i, 0 < p i) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) {ε : ℝ} (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ x : ℝ,
      (∃ z : ℤ, x = ((n + 1 : ℕ) : ℝ) * L.offset + L.span * (z : ℝ)) →
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent p Y (n + 1) {x} -
        L.span * gaussianProfile (p.expect (fun i => Y i ^ 2)) (n + 1) x| < ε := by
  obtain ⟨N, hN⟩ := eventually_atTop.1
    ((lattice_error_integral_tendsto L p hp hm hv).eventually
      (Iio_mem_nhds (div_pos hε L.span_pos)))
  refine ⟨N, ?_⟩
  intro n hn x hx
  have h : L.span * (∫ u, latticeSpectralError L p (n + 1) u) < ε := by
    have h' := mul_lt_mul_of_pos_left (hN n hn) L.span_pos
    rwa [mul_div_cancel₀ _ L.span_pos.ne'] at h'
  exact (lattice_uniform_error L p hp hm hv (Nat.succ_pos n) hx).trans_lt h

end RenyiProductOrderPhase
