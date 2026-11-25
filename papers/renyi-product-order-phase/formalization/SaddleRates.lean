import CumulantDerivatives
import CharacteristicScaling

/-! Exact saddle rates, centered cumulants, and the inverse Rényi identity. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem log_cumulant_zero (p q : FiniteMass κ) : logCumulant p q 0 = 0 := by
  rw [logCumulant, tilt_normalizer_at_zero, Real.log_one]

theorem log_cumulant_one (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) : logCumulant p q 1 = 0 := by
  have h : tiltNormalizer p q 1 = 1 := by
    unfold tiltNormalizer FiniteMass.expect
    calc
      _ = ∑ y, q y := by
        refine Finset.sum_congr rfl fun y _ => ?_
        change p y * Real.exp (1 * logLikelihood p q y) = q y
        rw [one_mul, logLikelihood, Real.exp_log (div_pos (hq y) (hp y)),
          mul_div_cancel₀ _ (hp y).ne']
      _ = _ := q.total
  rw [logCumulant, h, Real.log_one]

theorem log_cumulant_neg_order (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (b : ℝ) :
    logCumulant p q (-b) = Real.log (renyiMoment b p q) := by
  unfold logCumulant tiltNormalizer renyiMoment
  congr 1
  unfold FiniteMass.expect
  refine Finset.sum_congr rfl fun y _ => ?_
  change p y * Real.exp (-b * logLikelihood p q y) = p y * (p y / q y) ^ b
  have hR : 0 < q y / p y := div_pos (hq y) (hp y)
  rw [logLikelihood, mul_comm (-b), ← Real.rpow_def_of_pos hR, Real.rpow_neg hR.le,
    ← Real.inv_rpow hR.le, inv_div]

theorem inverse_renyi_cumulant_iff (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) {b : ℝ} (hb : b ≠ 0) (r : ℝ) :
    logCumulant p q (-b) = r * b ↔ renyiDivergence b p q = r := by
  rw [log_cumulant_neg_order p q hp hq, renyiDivergence]
  exact (div_eq_iff hb).symm

theorem positive_tilt_rate (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) {θ : ℝ} (hθ : 0 < θ) :
    0 < θ * tiltedMean p q θ - logCumulant p q θ := by
  let m := tiltedMean p q θ
  let F (t : ℝ) := t * m - logCumulant p q t
  have hF (t : ℝ) : HasDerivAt F (m - tiltedMean p q t) t := by
    simpa only [F, id_eq, one_mul] using
      ((hasDerivAt_id t).mul_const m).sub (hasDerivAt_log_cumulant p q t)
  have hC : Continuous F := continuous_iff_continuousAt.2 (fun t => (hF t).continuousAt)
  have hM : StrictMonoOn F (Icc 0 θ) := by
    apply strictMonoOn_of_deriv_pos (convex_Icc 0 θ) hC.continuousOn
    intro t ht
    rw [interior_Icc] at ht
    rw [(hF t).deriv]
    exact sub_pos.mpr (tilted_mean_strict_mono p q hp hq hne ht.2)
  have hZero : F 0 = 0 := by
    unfold F
    rw [zero_mul, log_cumulant_zero, sub_zero]
  change 0 < F θ
  rw [← hZero]
  exact hM ⟨le_rfl, hθ.le⟩ ⟨hθ.le, le_rfl⟩ hθ

theorem tilted_shifted_mean (p q : FiniteMass κ) (θ r : ℝ) :
    (tiltedMass p q θ).expect (fun i => logLikelihood p q i + r) = tiltedMean p q θ + r := by
  let R := tiltedMass p q θ
  change R.expect (fun i => logLikelihood p q i + r) = R.expect (logLikelihood p q) + r
  unfold FiniteMass.expect
  simp only [mul_add, Finset.sum_add_distrib, ← Finset.sum_mul, R.total, one_mul]

theorem tilted_shifted_second_moment (p q : FiniteMass κ) (θ r : ℝ)
    (hm : tiltedMean p q θ = -r) :
    (tiltedMass p q θ).expect (fun i => (logLikelihood p q i + r) ^ 2) = tiltedVariance p q θ := by
  unfold tiltedVariance
  rw [hm]
  simp only [sub_neg_eq_add]

omit [Fintype κ] in
theorem iid_sum_shift (Y : κ → ℝ) (r : ℝ) {n : ℕ} (x : Fin n → κ) :
    iidSum (fun y => Y y + r) x = iidSum Y x + (n : ℝ) * r := by
  unfold iidSum
  simp only [Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]

namespace BinarySymmetricChannel

theorem halfway_chernoff_pos (w : BinarySymmetricChannel κ) :
    0 < -logCumulant (w.channel false) (w.channel true) (1 / 2) := by
  have h := positive_tilt_rate _ _ (w.positive false) (w.positive true) w.informative
    (show (0 : ℝ) < 1 / 2 by norm_num)
  rwa [w.halfway_tilt_centered, mul_zero, zero_sub] at h

theorem growing_saddle_rate_pos (w : BinarySymmetricChannel κ) {θ r : ℝ}
    (hθ : 0 < θ) (hm : tiltedMean (w.channel false) (w.channel true) θ = -r) :
    0 < -(logCumulant (w.channel false) (w.channel true) θ + θ * r) := by
  have h := positive_tilt_rate _ _ (w.positive false) (w.positive true) w.informative hθ
  rw [hm] at h
  linarith only [h]

end BinarySymmetricChannel

end RenyiProductOrderPhase
