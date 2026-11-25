import FiniteCentralLimit
import SaddleRates

/-! Exact KL centering and normalization of the finite likelihood sum. -/

open scoped BigOperators Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem tilted_mass_at_zero (p q : FiniteMass κ) : tiltedMass p q 0 = p := by
  apply FiniteMass.ext
  intro y
  rw [tilted_mass_apply, tilt_normalizer_at_zero, zero_mul, Real.exp_zero, mul_one, div_one]

noncomputable def klMean (p q : FiniteMass κ) : ℝ := -tiltedMean p q 0

noncomputable def klSigma (p q : FiniteMass κ) : ℝ := Real.sqrt (tiltedVariance p q 0)

noncomputable def standardizedLogLikelihood (p q : FiniteMass κ) (i : κ) : ℝ :=
  (-logLikelihood p q i - klMean p q) / klSigma p q

theorem kl_mean_pos (p q : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (hq : ∀ i, 0 < q i) (hne : p ≠ q) : 0 < klMean p q := by
  unfold klMean
  apply neg_pos.mpr
  apply lt_of_not_ge
  intro h₀
  have hC : Continuous (logCumulant p q) :=
    continuous_iff_continuousAt.2 (fun t => (hasDerivAt_log_cumulant p q t).continuousAt)
  have hM : StrictMonoOn (logCumulant p q) (Icc 0 1) := by
    apply strictMonoOn_of_deriv_pos (convex_Icc 0 1) hC.continuousOn
    intro t ht
    rw [interior_Icc] at ht
    rw [(hasDerivAt_log_cumulant p q t).deriv]
    exact h₀.trans_lt ((tilted_mean_strict_mono p q hp hq hne) ht.1)
  have h := hM (show (0 : ℝ) ∈ Icc 0 1 from ⟨le_rfl, zero_le_one⟩)
    (show (1 : ℝ) ∈ Icc 0 1 from ⟨zero_le_one, le_rfl⟩) zero_lt_one
  rw [log_cumulant_zero, log_cumulant_one p q hp hq] at h
  exact (lt_irrefl (0 : ℝ)) h

theorem kl_sigma_pos (p q : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (hq : ∀ i, 0 < q i) (hne : p ≠ q) : 0 < klSigma p q :=
  Real.sqrt_pos.2 (tilted_variance_pos p q hp hq hne 0)

theorem standardized_likelihood_mean (p q : FiniteMass κ) :
    p.expect (standardizedLogLikelihood p q) = 0 := by
  let f (i : κ) := -logLikelihood p q i - klMean p q
  let σ := klSigma p q
  have hG : p.expect f = 0 := by
    have hFD : p.expect (logLikelihood p q) = tiltedMean p q 0 := by
      unfold tiltedMean
      rw [tilted_mass_at_zero]
    have he (i : κ) : f i = (-1 : ℝ) * logLikelihood p q i + -klMean p q := by
      unfold f
      ring
    have hEq : f = fun i => (-1 : ℝ) * logLikelihood p q i + -klMean p q := funext he
    rw [hEq, FiniteMass.expect_add_functions, FiniteMass.expect_scale_function,
      FiniteMass.expect_const, hFD]
    unfold klMean
    ring
  have hF : standardizedLogLikelihood p q = fun i => σ⁻¹ * f i := by
    funext i
    unfold standardizedLogLikelihood f σ
    rw [div_eq_mul_inv, mul_comm]
  rw [hF, FiniteMass.expect_scale_function, hG, mul_zero]

theorem standardized_likelihood_variance (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) :
    p.expect (fun i => standardizedLogLikelihood p q i ^ 2) = 1 := by
  let v := tiltedVariance p q 0
  let σ := klSigma p q
  have hv : 0 < v := tilted_variance_pos p q hp hq hne 0
  have hSq : σ ^ 2 = v := Real.sq_sqrt hv.le
  have hPoint (i : κ) : standardizedLogLikelihood p q i ^ 2 =
      (σ ^ 2)⁻¹ * (logLikelihood p q i - tiltedMean p q 0) ^ 2 := by
    unfold standardizedLogLikelihood klMean
    change ((-logLikelihood p q i - -tiltedMean p q 0) / σ) ^ 2 = _
    rw [show -logLikelihood p q i - -tiltedMean p q 0 =
      -(logLikelihood p q i - tiltedMean p q 0) by ring, div_pow, neg_sq,
      div_eq_mul_inv, mul_comm]
  simp only [hPoint, FiniteMass.expect_scale_function]
  have hVar : p.expect (fun i => (logLikelihood p q i - tiltedMean p q 0) ^ 2) = v := by
    unfold v tiltedVariance
    rw [tilted_mass_at_zero]
  rw [hVar, hSq, inv_mul_cancel₀ hv.ne']

omit [Fintype κ] in
theorem iid_sum_divide (Y : κ → ℝ) (d : ℝ) {n : ℕ} (x : Fin n → κ) :
    iidSum (fun i => Y i / d) x = iidSum Y x / d := by
  unfold iidSum
  exact (Finset.sum_div _ _ _).symm

theorem standardized_likelihood_block_exact (p q : FiniteMass κ)
    (n : ℕ) (x : Fin n → κ) :
    iidSum (fun i => standardizedLogLikelihood p q i / Real.sqrt (n : ℝ)) x =
      (-likelihoodSum p q x - (n : ℝ) * klMean p q) / (klSigma p q * Real.sqrt (n : ℝ)) := by
  rw [iid_sum_divide]
  unfold standardizedLogLikelihood
  rw [iid_sum_divide, div_div]
  unfold iidSum likelihoodSum
  simp only [Finset.sum_sub_distrib, Finset.sum_neg_distrib, Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul]

theorem kl_uniform_central_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n : ℕ in atTop, ∀ x : ℝ,
      |finiteSumEvent p (fun i => standardizedLogLikelihood p q i /
        Real.sqrt ((n + 1 : ℕ) : ℝ)) (n + 1) (Iic x) - gaussianCDF 1 x| < ε := by
  have hV := standardized_likelihood_variance p q hp hq hne
  exact (by
    rw [← hV]
    exact finite_uniform_central_limit p (standardizedLogLikelihood p q)
      (standardized_likelihood_mean p q) (by rw [hV]; exact zero_lt_one) hε)

end RenyiProductOrderPhase
