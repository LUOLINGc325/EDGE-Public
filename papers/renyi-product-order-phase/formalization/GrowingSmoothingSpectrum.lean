import FourierSmoothedUniform

/-! Gaussian spectral convergence with a bandwidth that grows as the square root of the block length. -/

open scoped Topology
open Set Filter MeasureTheory

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem characteristic_div_summand (p : FiniteMass κ) (Y : κ → ℝ) (r t : ℝ) :
    characteristic p (fun i => Y i / r) t = characteristic p Y (t / r) := by
  unfold characteristic FiniteMass.complexExpect
  refine Finset.sum_congr rfl fun i _ => ?_
  change _ * fourierPhase (t * (Y i / r)) = _ * fourierPhase ((t / r) * Y i)
  rw [show t * (Y i / r) = (t / r) * Y i by ring]

noncomputable def wideCutoffSpectrum (p : FiniteMass κ) (Y : κ → ℝ)
    (δ : ℝ) (n : ℕ) (u : ℝ) : ℂ :=
  (triangleCutoff (δ * Real.sqrt (n : ℝ)) u : ℂ) *
    characteristic p Y (-u / Real.sqrt (n : ℝ)) ^ n

theorem wide_cutoff_spectral_continuous (p : FiniteMass κ) (Y : κ → ℝ) (δ : ℝ) (n : ℕ) :
    Continuous (wideCutoffSpectrum p Y δ n) := by
  unfold wideCutoffSpectrum
  exact (Complex.continuous_ofReal.comp (triangle_cutoff_continuous _)).mul
    (((characteristic_continuous p Y).comp (continuous_neg.div_const _)).pow n)

theorem gaussian_spectral_even (v u : ℝ) : gaussianSpectral v (-u) = gaussianSpectral v u := by
  simp only [gaussianSpectral, neg_sq]

theorem wide_cutoff_spectral_tendsto (p : FiniteMass κ) (Y : κ → ℝ)
    (hm : p.expect Y = 0) (hv : 0 < p.expect (fun i => Y i ^ 2))
    (δ u : ℝ) :
    Tendsto (fun n : ℕ => wideCutoffSpectrum p Y δ n u) atTop
      (𝓝 (gaussianSpectral (p.expect (fun i => Y i ^ 2)) u)) := by
  have hRatio : Tendsto (fun n : ℕ => |u| / (δ * Real.sqrt (n : ℝ))) atTop (𝓝 0) := by
    simpa only [div_div] using div_nat_sqrt_tendsto_zero (|u| / δ)
  have hOne : Tendsto (fun _ : ℕ => (1 : ℝ)) atTop (𝓝 1) := tendsto_const_nhds
  have hZero : Tendsto (fun _ : ℕ => (0 : ℝ)) atTop (𝓝 0) := tendsto_const_nhds
  have hCut : Tendsto (fun n : ℕ => triangleCutoff (δ * Real.sqrt (n : ℝ)) u) atTop (𝓝 1) := by
    simpa only [triangleCutoff, sub_zero, max_eq_right zero_le_one] using hZero.max (hOne.sub hRatio)
  have hCpx := (Complex.continuous_ofReal.tendsto (1 : ℝ)).comp hCut
  have hChar := characteristic_scaled_tendsto p Y hm hv (-u)
  simpa only [Function.comp_apply, Complex.ofReal_one, one_mul, gaussian_spectral_even,
    wideCutoffSpectrum] using hCpx.mul hChar

theorem wide_cutoff_spectral_bound (p : FiniteMass κ) (Y : κ → ℝ)
    {δ c : ℝ} (hδ : 0 < δ)
    (hBand : ∀ t : ℝ, |t| ≤ δ → ‖characteristic p Y t‖ ≤ Real.exp (-c * t ^ 2))
    {n : ℕ} (hn : 0 < n) (u : ℝ) :
    ‖wideCutoffSpectrum p Y δ n u‖ ≤ Real.exp (-c * u ^ 2) := by
  let r := Real.sqrt (n : ℝ)
  have hr : 0 < r := Real.sqrt_pos.2 (by exact_mod_cast hn)
  have hT : 0 < δ * r := mul_pos hδ hr
  unfold wideCutoffSpectrum
  change ‖(triangleCutoff (δ * r) u : ℂ) *
    characteristic p Y (-u / r) ^ n‖ ≤ _
  rw [norm_mul, norm_pow, Complex.norm_of_nonneg (triangle_cutoff_nonneg _ _)]
  by_cases h : |u| ≤ δ * r
  · have hArg : |-u / r| ≤ δ := by
      rw [abs_div, abs_neg, abs_of_pos hr]
      exact (div_le_iff₀ hr).2 h
    apply (mul_le_of_le_one_left (pow_nonneg (norm_nonneg _) _) (triangle_cutoff_le_one hT u)).trans
    have hN := pow_le_pow_left₀ (norm_nonneg _) (hBand _ hArg) n
    have he : (-u / r) ^ 2 = (u / r) ^ 2 := by rw [neg_div, neg_sq]
    rw [he] at hN
    exact hN.trans_eq (gaussian_scaling_power c u hn)
  · rw [triangle_cutoff_zero hT (le_of_not_ge h), zero_mul]
    exact Real.exp_nonneg _

noncomputable def wideCutoffError (p : FiniteMass κ) (Y : κ → ℝ)
    (δ : ℝ) (n : ℕ) (u : ℝ) : ℝ :=
  ‖wideCutoffSpectrum p Y δ n u - gaussianSpectral (p.expect (fun i => Y i ^ 2)) u‖

theorem wide_cutoff_error_integral_tendsto (p : FiniteMass κ) (Y : κ → ℝ)
    (hm : p.expect Y = 0) (hv : 0 < p.expect (fun i => Y i ^ 2))
    {δ c : ℝ} (hδ : 0 < δ) (hc : 0 < c)
    (hBand : ∀ t : ℝ, |t| ≤ δ → ‖characteristic p Y t‖ ≤ Real.exp (-c * t ^ 2)) :
    Tendsto (fun n : ℕ => ∫ u, wideCutoffError p Y δ (n + 1) u) atTop (𝓝 0) := by
  let v := p.expect (fun i => Y i ^ 2)
  let k := 2 * Real.pi ^ 2 * v
  have hk : 0 < k := mul_pos (mul_pos (by norm_num) (pow_pos Real.pi_pos 2)) hv
  let C (u : ℝ) := Real.exp (-c * u ^ 2) + Real.exp (-k * u ^ 2)
  have hInt : Integrable C := (integrable_exp_neg_mul_sq hc).add (integrable_exp_neg_mul_sq hk)
  have hG : Continuous (gaussianSpectral v) := by unfold gaussianSpectral; fun_prop
  have hMeas (n : ℕ) : AEStronglyMeasurable (wideCutoffError p Y δ (n + 1)) :=
    (((wide_cutoff_spectral_continuous p Y δ (n + 1)).sub hG).norm).aestronglyMeasurable
  have hDom (n : ℕ) (u : ℝ) : ‖wideCutoffError p Y δ (n + 1) u‖ ≤ C u := by
    rw [Real.norm_of_nonneg (show 0 ≤ wideCutoffError p Y δ (n + 1) u from norm_nonneg _)]
    unfold wideCutoffError
    have hNorm : ‖gaussianSpectral v u‖ = Real.exp (-k * u ^ 2) :=
      Complex.norm_of_nonneg (Real.exp_pos _).le
    exact (norm_sub_le _ _).trans (add_le_add
      (wide_cutoff_spectral_bound p Y hδ hBand (Nat.succ_pos n) u) hNorm.le)
  have hSucc : Tendsto (fun n : ℕ => n + 1) atTop atTop := tendsto_atTop.2 fun m =>
    (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n))
  have hLimit (u : ℝ) : Tendsto (fun n : ℕ => wideCutoffError p Y δ (n + 1) u) atTop (𝓝 0) := by
    have h := (wide_cutoff_spectral_tendsto p Y hm hv δ u).comp hSucc
    have hConst : Tendsto (fun _ : ℕ => gaussianSpectral v u) atTop (𝓝 (gaussianSpectral v u)) :=
      tendsto_const_nhds
    simpa only [Function.comp_apply, sub_self, norm_zero, wideCutoffError, v] using (h.sub hConst).norm
  simpa only [integral_zero] using tendsto_integral_of_dominated_convergence C hMeas hInt
    (fun n => Filter.Eventually.of_forall (hDom n)) (Filter.Eventually.of_forall hLimit)

end RenyiProductOrderPhase
