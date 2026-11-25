import NormalizedSmoothedDensity
import Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral

/-! Normalizing the Gaussian density and upgrading smoothed convergence to an L1 limit. -/

open scoped Topology
open Filter Set MeasureTheory

namespace RenyiProductOrderPhase

theorem gaussian_unit_profile_formula {v : ℝ} (hv : 0 < v) (x : ℝ) :
    gaussianProfile v 1 x =
      (Real.sqrt (2 * Real.pi * v))⁻¹ * Real.exp (-(1 / (2 * v)) * x ^ 2) := by
  have hπ := Real.pi_pos
  have hBase : Real.pi / (2 * Real.pi ^ 2 * v) = 1 / (2 * Real.pi * v) := by
    field_simp [hπ.ne', hv.ne']
    ring
  have hExp : -(2 * Real.pi * x) ^ 2 / (4 * (2 * Real.pi ^ 2 * v)) =
      -(1 / (2 * v)) * x ^ 2 := by
    field_simp [hπ.ne', hv.ne']
    ring
  unfold gaussianProfile
  rw [Nat.cast_one, Real.sqrt_one, div_one, hBase, Real.sqrt_div zero_le_one,
    Real.sqrt_one, one_div, hExp]

theorem gaussian_unit_profile_integrable {v : ℝ} (hv : 0 < v) :
    Integrable (gaussianProfile v 1) := by
  have hc : 0 < 1 / (2 * v) := one_div_pos.mpr (by positivity)
  rw [show gaussianProfile v 1 = _ from funext (gaussian_unit_profile_formula hv)]
  exact (integrable_exp_neg_mul_sq hc).const_mul ((Real.sqrt (2 * Real.pi * v))⁻¹)

theorem gaussian_unit_profile_mass {v : ℝ} (hv : 0 < v) :
    (∫ x, gaussianProfile v 1 x) = 1 := by
  simp_rw [gaussian_unit_profile_formula hv]
  rw [integral_const_mul, integral_gaussian]
  have hRatio : Real.pi / (1 / (2 * v)) = 2 * Real.pi * v := by
    rw [one_div, div_inv_eq_mul]
    ring
  rw [hRatio, inv_mul_cancel₀ (Real.sqrt_pos.2 (by positivity)).ne']

variable {κ : Type*} [Fintype κ]

noncomputable def normalizedSmoothedDensity (p : FiniteMass κ) (Y : κ → ℝ)
    (δ : ℝ) (n : ℕ) (x : ℝ) : ℝ :=
  smoothedSumDensity p (fun i => Y i / Real.sqrt (n : ℝ)) n (δ * Real.sqrt (n : ℝ)) x

theorem normalized_smoothed_density_l1_limit (p : FiniteMass κ) (Y : κ → ℝ)
    (hm : p.expect Y = 0) (hv : 0 < p.expect (fun i => Y i ^ 2)) :
    ∃ δ > 0, Tendsto (fun n : ℕ => ∫ x,
      |normalizedSmoothedDensity p Y δ (n + 1) x - gaussianProfile (p.expect (fun i => Y i ^ 2)) 1 x|)
      atTop (𝓝 0) := by
  let v := p.expect (fun i => Y i ^ 2)
  let G := gaussianProfile v 1
  let c := Real.pi ^ 2 * v
  have hc : 0 < c := mul_pos (pow_pos Real.pi_pos _) hv
  obtain ⟨δ, hδ, hBand⟩ := characteristic_norm_near_zero p Y hm hv
  let g (n : ℕ) := normalizedSmoothedDensity p Y δ (n + 1)
  have hG (x : ℝ) : 0 ≤ G x := gaussian_profile_nonneg v 1 x
  have hT (n : ℕ) : 0 < δ * Real.sqrt ((n + 1 : ℕ) : ℝ) := mul_pos hδ
    (Real.sqrt_pos.2 (by exact_mod_cast Nat.succ_pos n))
  have hg₀ (n : ℕ) (x : ℝ) : 0 ≤ g n x := smoothed_sum_density_nonneg _ _ _ (hT n) x
  have hgI (n : ℕ) : Integrable (g n) := smoothed_sum_density_integrable _ _ _ (hT n)
  have hGI : Integrable G := gaussian_unit_profile_integrable hv
  have hgMass (n : ℕ) : (∫ x, g n x) = 1 := smoothed_sum_density_mass _ _ _ (hT n)
  have hGMass : (∫ x, G x) = 1 := gaussian_unit_profile_mass hv
  have hError := wide_cutoff_error_integral_tendsto p Y hm hv hδ hc hBand
  have hPoint (x : ℝ) : Tendsto (fun n => g n x) atTop (𝓝 (G x)) := by
    apply Metric.tendsto_nhds.2
    intro ε hε
    filter_upwards [hError.eventually (Iio_mem_nhds hε)] with n hn
    rw [Real.dist_eq]
    exact (smoothed_density_wide_cutoff_error p Y hv hδ hc hBand (Nat.succ_pos n) x).trans_lt hn
  let m (n : ℕ) (x : ℝ) := min (g n x) (G x)
  have hMMeas (n : ℕ) : AEStronglyMeasurable (m n) :=
    ((hgI n).aestronglyMeasurable.aemeasurable.min hGI.aestronglyMeasurable.aemeasurable).aestronglyMeasurable
  have hMDom (n : ℕ) (x : ℝ) : ‖m n x‖ ≤ G x := by
    rw [Real.norm_of_nonneg (le_min (hg₀ n x) (hG x))]
    exact min_le_right _ _
  have hMI (n : ℕ) : Integrable (m n) :=
    hGI.mono' (hMMeas n) (Filter.Eventually.of_forall (hMDom n))
  have hMpt (x : ℝ) : Tendsto (fun n => m n x) atTop (𝓝 (G x)) := by
    have hC : Tendsto (fun _ : ℕ => G x) atTop (𝓝 (G x)) := tendsto_const_nhds
    simpa only [m, min_self] using (hPoint x).min hC
  have hmL : Tendsto (fun n => ∫ x, m n x) atTop (𝓝 (∫ x, G x)) :=
    tendsto_integral_of_dominated_convergence G hMMeas hGI
      (fun n => Filter.Eventually.of_forall (hMDom n)) (Filter.Eventually.of_forall hMpt)
  have hEq (n : ℕ) : (∫ x, |g n x - G x|) = 2 - 2 * (∫ x, m n x) := by
    have hP (x : ℝ) : |g n x - G x| = (g n x + G x) - 2 * m n x := by
      unfold m
      rcases le_or_gt (g n x) (G x) with h | h
      · rw [min_eq_left h, abs_of_nonpos (sub_nonpos.mpr h)]
        ring
      · rw [min_eq_right h.le, abs_of_nonneg (sub_nonneg.mpr h.le)]
        ring
    simp_rw [hP]
    have hAdd : Integrable (fun x => g n x + G x) := (hgI n).add hGI
    rw [integral_sub hAdd ((hMI n).const_mul 2), integral_add (hgI n) hGI,
      integral_const_mul, hgMass, hGMass]
    norm_num
  refine ⟨δ, hδ, ?_⟩
  have hC : Tendsto (fun _ : ℕ => (2 : ℝ)) atTop (𝓝 2) := tendsto_const_nhds
  have hL := hC.sub (hmL.const_mul (2 : ℝ))
  change Tendsto (fun n => ∫ x, |g n x - G x|) atTop (𝓝 0)
  simp only [hEq]
  simpa only [hGMass, mul_one, sub_self] using hL

end RenyiProductOrderPhase
