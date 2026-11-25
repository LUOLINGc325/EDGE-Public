import LatticeInversion
import FourierLocalScaling

/-! Gaussian rescaling and domination on the lattice frequency band. -/

open scoped Topology
open Set Filter MeasureTheory

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def latticeBandSpectral {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) (n : ℕ) (u : ℝ) : ℂ :=
  (Ioc (-L.halfFrequency) L.halfFrequency).indicator
    (fun t => characteristic p Y t ^ n) (u / Real.sqrt (n : ℝ))

theorem lattice_band_measurable {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) (n : ℕ) : Measurable (latticeBandSpectral L p n) := by
  unfold latticeBandSpectral
  exact (((characteristic_continuous p Y).pow n).measurable.indicator measurableSet_Ioc).comp
    (continuous_id.div_const (Real.sqrt (n : ℝ))).measurable

theorem lattice_band_norm {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) {c : ℝ}
    (hBand : ∀ t, |t| ≤ L.halfFrequency → ‖characteristic p Y t‖ ≤ Real.exp (-c * t ^ 2))
    {n : ℕ} (hn : 0 < n) (u : ℝ) :
    ‖latticeBandSpectral L p n u‖ ≤ Real.exp (-c * u ^ 2) := by
  let t := u / Real.sqrt (n : ℝ)
  change ‖(Ioc (-L.halfFrequency) L.halfFrequency).indicator
    (fun t => characteristic p Y t ^ n) t‖ ≤ _
  by_cases ht : t ∈ Ioc (-L.halfFrequency) L.halfFrequency
  · rw [indicator_of_mem ht, norm_pow]
    have ht' : |t| ≤ L.halfFrequency := abs_le.mpr ⟨ht.1.le, ht.2⟩
    exact (pow_le_pow_left₀ (norm_nonneg _) (hBand t ht') n).trans_eq
      (gaussian_scaling_power c u hn)
  · rw [indicator_of_not_mem ht, norm_zero]
    exact (Real.exp_pos _).le

theorem lattice_band_tendsto {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) (hm : p.expect Y = 0) (hv : 0 < p.expect (fun i => Y i ^ 2))
    (u : ℝ) :
    Tendsto (fun n : ℕ => latticeBandSpectral L p n u) atTop
      (𝓝 (gaussianSpectral (p.expect (fun i => Y i ^ 2)) u)) := by
  refine (characteristic_scaled_tendsto p Y hm hv u).congr' ?_
  have hT := L.half_frequency_pos
  have he : ∀ᶠ n : ℕ in atTop,
      u / Real.sqrt (n : ℝ) ∈ Ioo (-L.halfFrequency) L.halfFrequency :=
    (div_nat_sqrt_tendsto_zero u).eventually (Ioo_mem_nhds (neg_lt_zero.mpr hT) hT)
  filter_upwards [he] with n hn
  have hn' : u / Real.sqrt (n : ℝ) ∈ Ioc (-L.halfFrequency) L.halfFrequency :=
    ⟨hn.1, hn.2.le⟩
  simp only [latticeBandSpectral, indicator_of_mem hn']

noncomputable def latticeSpectralError {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) (n : ℕ) (u : ℝ) : ℝ :=
  ‖latticeBandSpectral L p n u - gaussianSpectral (p.expect (fun i => Y i ^ 2)) u‖

theorem lattice_error_integral_tendsto {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (hm : p.expect Y = 0) (hv : 0 < p.expect (fun i => Y i ^ 2)) :
    Tendsto (fun n : ℕ => ∫ u, latticeSpectralError L p (n + 1) u) atTop (𝓝 0) := by
  obtain ⟨c, hc, hBand⟩ := L.characteristic_band p hp hm hv
  let k := 2 * Real.pi ^ 2 * p.expect (fun i => Y i ^ 2)
  have hk : 0 < k := mul_pos (mul_pos (by norm_num) (pow_pos Real.pi_pos 2)) hv
  let C (u : ℝ) := Real.exp (-c * u ^ 2) + Real.exp (-k * u ^ 2)
  have hInt : Integrable C := (integrable_exp_neg_mul_sq hc).add (integrable_exp_neg_mul_sq hk)
  have hGauss : Continuous (gaussianSpectral (p.expect (fun i => Y i ^ 2))) := by
    unfold gaussianSpectral
    fun_prop
  have hMeas (n : ℕ) : AEStronglyMeasurable (latticeSpectralError L p (n + 1)) := by
    unfold latticeSpectralError
    exact (((lattice_band_measurable L p (n + 1)).sub hGauss.measurable).norm).aestronglyMeasurable
  have hDom (n : ℕ) (u : ℝ) : ‖latticeSpectralError L p (n + 1) u‖ ≤ C u := by
    rw [Real.norm_of_nonneg (show 0 ≤ latticeSpectralError L p (n + 1) u from norm_nonneg _)]
    unfold latticeSpectralError
    have hNorm : ‖gaussianSpectral (p.expect (fun i => Y i ^ 2)) u‖ =
        Real.exp (-k * u ^ 2) :=
      Complex.norm_of_nonneg (Real.exp_pos _).le
    exact (norm_sub_le _ _).trans (add_le_add
      (lattice_band_norm L p hBand (Nat.succ_pos n) u) hNorm.le)
  have hSucc : Tendsto (fun n : ℕ => n + 1) atTop atTop := tendsto_atTop.2 fun m =>
    (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n))
  have hLimit u : Tendsto (fun n : ℕ => latticeSpectralError L p (n + 1) u) atTop (𝓝 0) := by
    let g := gaussianSpectral (p.expect (fun i => Y i ^ 2)) u
    have hConst : Tendsto (fun _ : ℕ => g) atTop (𝓝 g) := tendsto_const_nhds
    have h := (lattice_band_tendsto L p hm hv u).comp hSucc
    simpa only [Function.comp_apply, sub_self, norm_zero, latticeSpectralError, g] using
      (h.sub hConst).norm
  simpa only [integral_zero] using tendsto_integral_of_dominated_convergence C hMeas hInt
    (fun n => Filter.Eventually.of_forall (hDom n)) (Filter.Eventually.of_forall hLimit)

end RenyiProductOrderPhase
