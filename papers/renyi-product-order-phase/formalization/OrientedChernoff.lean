import PublicTheoremInterfaces
import Mathlib.Analysis.Calculus.LocalExtr.Rolle

/-! The oriented asymmetric extension with a saddle supplied by the finite model. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem unique_oriented_chernoff_saddle (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) :
    ∃ t ∈ Ioo (0 : ℝ) 1, tiltedMean p q t = 0 ∧
      ∀ s ≠ t, logCumulant p q t < logCumulant p q s := by
  let ψ := logCumulant p q
  have hC : Continuous ψ :=
    continuous_iff_continuousAt.2 (fun t => (hasDerivAt_log_cumulant p q t).continuousAt)
  have hEq : ψ 0 = ψ 1 := (log_cumulant_zero p q).trans (log_cumulant_one p q hp hq).symm
  obtain ⟨t, ht, he⟩ := exists_deriv_eq_zero (f := ψ) zero_lt_one hC.continuousOn hEq
  have hD : tiltedMean p q t = 0 := (hasDerivAt_log_cumulant p q t).deriv.symm.trans he
  have hMono := tilted_mean_strict_mono p q hp hq hne
  refine ⟨t, ht, hD, ?_⟩
  intro s hs
  rcases lt_or_gt_of_ne hs with h | h
  · have hA : StrictAntiOn ψ (Icc s t) := by
      apply strictAntiOn_of_deriv_neg (convex_Icc s t) hC.continuousOn
      intro u hu
      rw [interior_Icc] at hu
      rw [(hasDerivAt_log_cumulant p q u).deriv, ← hD]
      exact hMono hu.2
    exact hA ⟨le_rfl, h.le⟩ ⟨h.le, le_rfl⟩ h
  · have hA : StrictMonoOn ψ (Icc t s) := by
      apply strictMonoOn_of_deriv_pos (convex_Icc t s) hC.continuousOn
      intro u hu
      rw [interior_Icc] at hu
      rw [(hasDerivAt_log_cumulant p q u).deriv, ← hD]
      exact hMono hu.1
    exact hA ⟨le_rfl, h.le⟩ ⟨h.le, le_rfl⟩ h

theorem unique_oriented_growing_saddle (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) {r t : ℝ}
    (hr : 0 < r) (hD : r < klMean p q) (ht : 0 < t) (hm : tiltedMean p q t = 0) :
    ∃! s : ℝ, s ∈ Ioo 0 t ∧ tiltedMean p q s = -r := by
  let f := tiltedMean p q
  have hC : Continuous f :=
    continuous_iff_continuousAt.2 (fun s => (hasDerivAt_tilted_mean p q s).continuousAt)
  have hLo : f 0 < -r := by unfold klMean at hD; linarith only [hD]
  have hHi : -r < f t := by change -r < tiltedMean p q t; rw [hm]; exact neg_lt_zero.mpr hr
  obtain ⟨s, hs, he⟩ := intermediate_value_Icc ht.le hC.continuousOn
    (show -r ∈ Icc (f 0) (f t) from ⟨hLo.le, hHi.le⟩)
  have hs₀ : 0 < s := lt_of_le_of_ne hs.1 (fun h => hLo.ne (h ▸ he))
  have hs₁ : s < t := lt_of_le_of_ne hs.2 (fun h => hHi.ne (h ▸ he).symm)
  exact ⟨s, ⟨⟨hs₀, hs₁⟩, he⟩, fun u hu =>
    (tilted_mean_strict_mono p q hp hq hne).injective (hu.2.trans he.symm)⟩

theorem oriented_nonarithmetic_fixed_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (hNon : ¬ ArithmeticSupport (logLikelihood p q)) {b : ℝ} (hb : 1 ≤ b) :
    ∃ θ ∈ Ioo (0 : ℝ) 1, (∀ s ≠ θ, logCumulant p q θ < logCumulant p q s) ∧
      ∃ aStar > 0, θ * (1 + aStar) * Real.log (1 + aStar) = aStar ∧
        let v := tiltedVariance p q θ
        let I := -logCumulant p q θ
        Tendsto (fun n : ℕ => blockScale I (n + 1) * sInf (productDeficitValues p q (n + 1) b))
          atTop (𝓝 ((Real.Gamma (1 - θ) * Real.Gamma (b + θ) /
            (θ * Real.Gamma (b + 1) * Real.sqrt (2 * Real.pi * v))) * priorCost θ aStar)) := by
  obtain ⟨θ, hθ, hm, hMin⟩ := unique_oriented_chernoff_saddle p q hp hq hne
  obtain ⟨a, ha, hEq, hLim⟩ := nonarithmetic_fixed_exact_limit p q hp hq hne hNon hb hθ.1 hθ.2 hm
  refine ⟨θ, hθ, hMin, a, ha, hEq, ?_⟩
  let v := tiltedVariance p q θ
  let I := -logCumulant p q θ
  have hv : 0 < v := tilted_variance_pos p q hp hq hne θ
  have hb₀ := zero_lt_one.trans_le hb
  have hN := fixed_tilt_constant_normal_form hv hb₀ hθ.1
  have h := hLim.div_const b
  rw [mul_comm (fixedTiltConstant v b θ), mul_div_assoc, hN, mul_comm (priorCost θ a)] at h
  apply h.congr
  intro n
  change (b * blockScale I (n + 1) * sInf (productDeficitValues p q (n + 1) b)) / b =
    blockScale I (n + 1) * sInf (productDeficitValues p q (n + 1) b)
  rw [show (b * blockScale I (n + 1) * sInf (productDeficitValues p q (n + 1) b)) =
    (blockScale I (n + 1) * sInf (productDeficitValues p q (n + 1) b)) * b by ring,
    mul_div_cancel_right₀ _ hb₀.ne']

theorem oriented_nonarithmetic_growing_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (hNon : ¬ ArithmeticSupport (logLikelihood p q)) {r : ℝ} (hr : 0 < r) (hD : r < klMean p q) :
    ∃ θ₀ ∈ Ioo (0 : ℝ) 1, (∀ s ≠ θ₀, logCumulant p q θ₀ < logCumulant p q s) ∧
      ∃ θ ∈ Ioo 0 θ₀, tiltedMean p q θ = -r ∧
        ∃ aStar > 0, θ * (1 + aStar) * Real.log (1 + aStar) = aStar ∧
          let B (n : ℕ) := orderAtRate r (n + 1)
          let v := tiltedVariance p q θ
          let I := -(logCumulant p q θ + θ * r)
          Tendsto (fun n : ℕ => B n * blockScale I (n + 1) * sInf (productDeficitValues p q (n + 1) (B n)))
            atTop (𝓝 ((Real.Gamma (1 - θ) / (θ * Real.sqrt (2 * Real.pi * v))) * priorCost θ aStar)) := by
  obtain ⟨θ₀, hθ₀, hm₀, hMin⟩ := unique_oriented_chernoff_saddle p q hp hq hne
  obtain ⟨θ, ⟨hθ, hm⟩, _⟩ := unique_oriented_growing_saddle p q hp hq hne hr hD hθ₀.1 hm₀
  obtain ⟨a, ha, hEq, hT⟩ := nonarithmetic_growing_exact_limit p q hp hq hne hNon hr
    hθ.1 (hθ.2.trans hθ₀.2) hm
  refine ⟨θ₀, hθ₀, hMin, θ, hθ, hm, a, ha, hEq, ?_⟩
  have hv := tilted_variance_pos p q hp hq hne θ
  have hConst : growingTiltConstant (tiltedVariance p q θ) θ =
      Real.Gamma (1 - θ) / (θ * Real.sqrt (2 * Real.pi * tiltedVariance p q θ)) := by
    rw [growingTiltConstant, gaussian_height_normal_form hv]
    have hS : 0 < Real.sqrt (2 * Real.pi * tiltedVariance p q θ) := Real.sqrt_pos.2 (by positivity)
    field_simp [hθ.1.ne', hS.ne']
    ring_nf
    exact Or.inl trivial
  rwa [hConst] at hT

end RenyiProductOrderPhase
