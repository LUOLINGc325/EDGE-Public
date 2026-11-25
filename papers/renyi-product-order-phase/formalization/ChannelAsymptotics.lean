import NonarithmeticExactLimits
import StandardNormalTail
import InverseOrderExactCoefficient

/-! The manuscript's constants and exact identification with the channel deficit. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem gaussian_height_normal_form {v : ℝ} (hv : 0 < v) :
    gaussianHeight v = (Real.sqrt (2 * Real.pi * v))⁻¹ := by
  have h := gaussian_unit_profile_formula hv 0
  unfold gaussianProfile at h
  simpa only [gaussianHeight, Nat.cast_one, Real.sqrt_one, div_one, mul_zero,
    neg_zero, zero_div, zero_pow (by norm_num : (2 : ℕ) ≠ 0), Real.exp_zero, mul_one] using h

theorem fixed_tilt_constant_normal_form {v b θ : ℝ} (hv : 0 < v) (hb : 0 < b) (hθ : 0 < θ) :
    fixedTiltConstant v b θ / b =
      Real.Gamma (1 - θ) * Real.Gamma (b + θ) /
        (θ * Real.Gamma (b + 1) * Real.sqrt (2 * Real.pi * v)) := by
  rw [fixedTiltConstant, gaussian_height_normal_form hv, Real.Gamma_add_one hb.ne']
  field_simp [hb.ne', hθ.ne', (Real.Gamma_pos_of_pos hb).ne',
    (Real.sqrt_pos.2 (by positivity : 0 < 2 * Real.pi * v)).ne']
  ring_nf
  exact Or.inl trivial

theorem fixed_chernoff_constant_normal_form {v b : ℝ} (hv : 0 < v) (hb : 0 < b) :
    fixedTiltConstant v b (1 / 2) / b =
      Real.sqrt 2 * Real.Gamma (b + 1 / 2) / (Real.sqrt v * Real.Gamma (b + 1)) := by
  rw [fixed_tilt_constant_normal_form hv hb (by norm_num : (0 : ℝ) < 1 / 2),
    show (1 : ℝ) - 1 / 2 = 1 / 2 by norm_num, Real.Gamma_one_half_eq,
    Real.sqrt_mul (by positivity : 0 ≤ 2 * Real.pi), Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 2)]
  have hG := (Real.Gamma_pos_of_pos (add_pos hb zero_lt_one)).ne'
  have hS := (Real.sqrt_pos.2 hv).ne'
  have hP := (Real.sqrt_pos.2 Real.pi_pos).ne'
  have hTwo := (Real.sqrt_pos.2 (by norm_num : (0 : ℝ) < 2)).ne'
  field_simp [hG, hS, hP, hTwo]
  have h : Real.sqrt (2 : ℝ) ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  calc
    _ = (Real.sqrt 2) ^ 2 * Real.sqrt Real.pi * Real.Gamma (b + 1 / 2) *
        Real.sqrt v * Real.Gamma (b + 1) := by rw [h]; ring
    _ = _ := by ring

noncomputable def channelProductDeficit (w : BinarySymmetricChannel κ) (n : ℕ) (b : ℝ) : ℝ :=
  1 - contractionCoefficient b (tensorChannel w.channel n)

theorem channel_product_deficit_eventually_eq (w : BinarySymmetricChannel κ) (b : ℕ → ℝ)
    (hb : ∀ᶠ n in atTop, 1 ≤ b n) :
    (fun n => channelProductDeficit w (n + 1) (b n)) =ᶠ[atTop]
      (fun n => sInf (productDeficitValues (w.channel false) (w.channel true) (n + 1) (b n))) :=
  hb.mono (fun n hn => product_contraction_deficit w (Nat.succ_pos n) (b n) hn)

theorem biso_positive_kl_and_finite_endpoint (w : BinarySymmetricChannel κ) :
    let p := w.channel false
    let q := w.channel true
    0 < klMean p q ∧ ∃ M > klMean p q, (∀ i, -M ≤ logLikelihood p q i) ∧
      (∃ i, logLikelihood p q i = -M) ∧ 0 < endpointAtomMass p q M ∧ endpointAtomMass p q M < 1 := by
  classical
  let p := w.channel false
  let q := w.channel true
  have hD : 0 < klMean p q := kl_mean_pos p q (w.positive false) (w.positive true) w.informative
  obtain ⟨j, _⟩ := p.exists_weight_pos
  obtain ⟨i, _, hi⟩ := Finset.exists_min_image Finset.univ (logLikelihood p q)
    ⟨j, Finset.mem_univ j⟩
  let M := -logLikelihood p q i
  have hAtom : logLikelihood p q i = -M := (neg_neg _).symm
  have hM (y : κ) : -M ≤ logLikelihood p q y := by rw [← hAtom]; exact hi y (Finset.mem_univ y)
  obtain ⟨k, l, hneq⟩ := ratio_nonconstant p q (w.positive false) w.informative
  have hOther : ∃ k, -M < logLikelihood p q k := by
    by_contra! h
    have hEq : logLikelihood p q k = logLikelihood p q l :=
      ((h k).antisymm (hM k)).trans ((h l).antisymm (hM l)).symm
    have he := congrArg Real.exp hEq
    unfold logLikelihood at he
    rw [Real.exp_log (div_pos (w.positive true k) (w.positive false k)),
      Real.exp_log (div_pos (w.positive true l) (w.positive false l))] at he
    exact hneq he
  have hBound := tilted_mean_strictly_above_minimum p q (w.positive false) hM hOther 0
  have hKL : klMean p q < M := by unfold klMean; linarith only [hBound]
  obtain ⟨k, hk⟩ := hOther
  have hm := endpoint_atom_mass_bounds p q (w.positive false) ⟨i, hAtom⟩ ⟨k, hk.ne'⟩
  exact ⟨hD, M, hKL, hM, ⟨i, hAtom⟩, hm⟩

theorem biso_nonarithmetic_fixed_chernoff_limit (w : BinarySymmetricChannel κ)
    (hNon : ¬ ArithmeticSupport (logLikelihood (w.channel false) (w.channel true)))
    {b : ℝ} (hb : 1 ≤ b) :
    let p := w.channel false
    let q := w.channel true
    let I := -logCumulant p q (1 / 2)
    let v := tiltedVariance p q (1 / 2)
    ∃ aStar > 0, (1 + aStar) * Real.log (1 + aStar) = 2 * aStar ∧
      -(1 / 2 : ℝ) * Real.log (priorWeight aStar) = 1 - priorWeight aStar ∧
      Tendsto (fun n : ℕ => blockScale I (n + 1) * channelProductDeficit w (n + 1) b) atTop
        (𝓝 ((Real.sqrt 2 * Real.Gamma (b + 1 / 2) / (Real.sqrt v * Real.Gamma (b + 1))) *
          (Real.sqrt aStar / Real.log (1 + aStar)))) := by
  let p := w.channel false
  let q := w.channel true
  let I := -logCumulant p q (1 / 2)
  let v := tiltedVariance p q (1 / 2)
  have hv : 0 < v := tilted_variance_pos p q (w.positive false) (w.positive true) w.informative _
  have hb₀ : 0 < b := zero_lt_one.trans_le hb
  obtain ⟨aStar, ha, haEq, hT⟩ := nonarithmetic_fixed_exact_limit p q
    (w.positive false) (w.positive true) w.informative hNon hb
    (by norm_num) (by norm_num) w.halfway_tilt_centered
  refine ⟨aStar, ha, by linarith only [haEq], (prior_weight_stationarity ha).1 haEq, ?_⟩
  have hNorm := fixed_chernoff_constant_normal_form hv hb₀
  have hLim := hT.div_const b
  rw [mul_comm (fixedTiltConstant v b (1 / 2)), mul_div_assoc, hNorm, mul_comm (priorCost (1 / 2) aStar)] at hLim
  unfold priorCost at hLim
  rw [← Real.sqrt_eq_rpow] at hLim
  apply hLim.congr
  intro n
  rw [channelProductDeficit, product_contraction_deficit w (Nat.succ_pos n) b hb,
    show (b * blockScale I (n + 1)) * sInf (productDeficitValues p q (n + 1) b) =
      (blockScale I (n + 1) * sInf (productDeficitValues p q (n + 1) b)) * b by ring,
    mul_div_cancel_right₀ _ hb₀.ne']

end RenyiProductOrderPhase
