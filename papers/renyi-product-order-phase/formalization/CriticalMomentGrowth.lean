import CriticalScaling

/-! A small-tilt moment bound that controls arbitrarily large critical-window priors. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem centered_finite_log_mgf_upper (p : FiniteMass κ) (Y : κ → ℝ) (t : ℝ)
    (hm : p.expect Y = 0)
    (hSmall : ∀ i, |t * Y i| ≤ 1) :
    Real.log (p.expect (fun i => Real.exp (t * Y i))) ≤
      (Real.exp 1 * t ^ 2) * p.expect (fun i => Y i ^ 2) := by
  have hPoint (i : κ) : Real.exp (t * Y i) ≤ 1 + t * Y i +
      (Real.exp 1 * t ^ 2) * Y i ^ 2 := by
    let z := t * Y i
    have h := (le_abs_self (Real.exp z - (1 + z))).trans (real_exp_linear_remainder z)
    have hE : Real.exp |z| ≤ Real.exp 1 := Real.exp_le_exp.mpr (hSmall i)
    have hB := mul_le_mul_of_nonneg_left hE (sq_nonneg |z|)
    rw [sq_abs] at hB
    change Real.exp z ≤ _
    have hSq : z ^ 2 * Real.exp 1 = (Real.exp 1 * t ^ 2) * Y i ^ 2 := by unfold z; ring
    rw [sq_abs] at h
    change Real.exp z ≤ 1 + z + (Real.exp 1 * t ^ 2) * Y i ^ 2
    linarith only [h, hB, hSq]
  have hW := p.expect_mono hPoint
  rw [FiniteMass.expect_add_functions, FiniteMass.expect_add_functions,
    FiniteMass.expect_scale_function, FiniteMass.expect_scale_function, p.expect_const, hm,
    mul_zero, add_zero] at hW
  obtain ⟨i, hi⟩ := p.exists_weight_pos
  have hPos : 0 < p.expect (fun i => Real.exp (t * Y i)) :=
    p.expect_pos (fun _ => Real.exp_nonneg _) hi (Real.exp_pos _)
  exact (Real.log_le_sub_one_of_pos hPos).trans (by linarith only [hW])

noncomputable def klCenteredLikelihood (p q : FiniteMass κ) (i : κ) : ℝ :=
  -logLikelihood p q i - klMean p q

theorem kl_centered_likelihood_eq (p q : FiniteMass κ)
    (hσ : 0 < klSigma p q) (i : κ) :
    klCenteredLikelihood p q i = klSigma p q * standardizedLogLikelihood p q i := by
  unfold klCenteredLikelihood standardizedLogLikelihood
  rw [mul_div_cancel₀ _ hσ.ne']

theorem kl_centered_likelihood_stats (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) :
    p.expect (klCenteredLikelihood p q) = 0 ∧
      p.expect (fun i => klCenteredLikelihood p q i ^ 2) = klSigma p q ^ 2 := by
  have hσ := kl_sigma_pos p q hp hq hne
  constructor
  · rw [show klCenteredLikelihood p q = _ from funext (kl_centered_likelihood_eq p q hσ)]
    rw [FiniteMass.expect_scale_function, standardized_likelihood_mean, mul_zero]
  · simp_rw [kl_centered_likelihood_eq p q hσ, mul_pow]
    rw [FiniteMass.expect_scale_function, standardized_likelihood_variance p q hp hq hne, mul_one]

theorem cumulant_from_kl_centered_likelihood (p q : FiniteMass κ) (t : ℝ) :
    logCumulant p q (-t) = t * klMean p q +
      Real.log (p.expect (fun i => Real.exp (t * klCenteredLikelihood p q i))) := by
  let f (i : κ) := Real.exp (t * klCenteredLikelihood p q i)
  have hP (i : κ) : Real.exp (-t * logLikelihood p q i) =
      Real.exp (t * klMean p q) * f i := by
    unfold f klCenteredLikelihood
    rw [← Real.exp_add]
    congr 1
    ring
  have hZ : tiltNormalizer p q (-t) = Real.exp (t * klMean p q) * p.expect f := by
    unfold tiltNormalizer
    simp only [hP, FiniteMass.expect_scale_function]
  have hPos : 0 < p.expect f := by
    obtain ⟨i, hi⟩ := p.exists_weight_pos
    exact p.expect_pos (fun _ => Real.exp_nonneg _) hi (Real.exp_pos _)
  rw [logCumulant, hZ, Real.log_mul (Real.exp_pos _).ne' hPos.ne', Real.log_exp]

theorem critical_argument_plain (p q : FiniteMass κ) (ζ : ℝ) (n : ℕ) (t : ℝ)
    (hs : 0 < criticalScale p q n) (z : Fin n → κ) :
    let X := iidSum (fun i => standardizedLogLikelihood p q i / Real.sqrt (n : ℝ)) z
    criticalOrder p q ζ n * criticalPrior p q n t * Real.exp (likelihoodSum p q z) =
      criticalPrior p q n t * Real.exp (criticalScale p q n * (ζ - X)) := by
  let X := iidSum (fun i => standardizedLogLikelihood p q i / Real.sqrt (n : ℝ)) z
  let s := criticalScale p q n
  have hX : X * s = -likelihoodSum p q z - (n : ℝ) * klMean p q :=
    (eq_div_iff hs.ne').1 (standardized_likelihood_block_exact p q n z)
  have hE : s * (ζ - X) = (n : ℝ) * klMean p q + ζ * s + likelihoodSum p q z := by
    nlinarith only [hX]
  change Real.exp ((n : ℝ) * klMean p q + ζ * s) * criticalPrior p q n t *
    Real.exp (likelihoodSum p q z) = criticalPrior p q n t * Real.exp (s * (ζ - X))
  rw [hE]
  simp only [Real.exp_add]
  ring

end RenyiProductOrderPhase
