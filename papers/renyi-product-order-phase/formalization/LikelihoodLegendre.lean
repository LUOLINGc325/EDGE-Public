import MinimumAtomTilt

/-! The finite-law Legendre transform and its unique interior saddle. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def likelihoodRate (p q : FiniteMass κ) (x : ℝ) : ℝ :=
  sSup (range (fun s => s * x - logCumulant p q s))

theorem negative_tilt_at_target (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) {M x : ℝ}
    (hM : ∀ i, -M ≤ logLikelihood p q i) (hAtom : 0 < endpointAtomMass p q M)
    (hx : -M < x) (hD : x < tiltedMean p q 0) :
    ∃! s : ℝ, s < 0 ∧ tiltedMean p q s = x := by
  have h := (tilted_mean_tendsto_minimum p q hM hAtom).eventually (gt_mem_nhds hx)
  obtain ⟨A, hA⟩ := eventually_atTop.1 h
  let t := max A 1
  have hNeg : -t < 0 := neg_lt_zero.mpr (zero_lt_one.trans_le (le_max_right _ _))
  have hT : tiltedMean p q (-t) < x := hA t (le_max_left _ _)
  have hC : Continuous (tiltedMean p q) :=
    continuous_iff_continuousAt.2 (fun a => (hasDerivAt_tilted_mean p q a).continuousAt)
  obtain ⟨s, hs, he⟩ := intermediate_value_Icc hNeg.le hC.continuousOn
    (show x ∈ Icc (tiltedMean p q (-t)) (tiltedMean p q 0) from ⟨hT.le, hD.le⟩)
  have hs' : s < 0 := lt_of_le_of_ne hs.2 (fun hh => hD.ne (by simpa only [hh] using he.symm))
  exact ⟨s, ⟨hs', he⟩, fun u hu => (tilted_mean_strict_mono p q hp hq hne).injective
    (hu.2.trans he.symm)⟩

theorem likelihood_rate_saddle (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) (t : ℝ) :
    let x := tiltedMean p q t
    IsGreatest (range (fun s => s * x - logCumulant p q s)) (t * x - logCumulant p q t) ∧
      ∀ s ≠ t, s * x - logCumulant p q s < t * x - logCumulant p q t := by
  let x := tiltedMean p q t
  let f (s : ℝ) := s * x - logCumulant p q s
  have hD (s : ℝ) : HasDerivAt f (x - tiltedMean p q s) s := by
    simpa only [f, id_eq, one_mul] using
      ((hasDerivAt_id s).mul_const x).sub (hasDerivAt_log_cumulant p q s)
  have hC : Continuous f :=
    continuous_iff_continuousAt.2 (fun s => (hD s).continuousAt)
  have hM := tilted_mean_strict_mono p q hp hq hne
  have hStrict (s : ℝ) (hs : s ≠ t) : f s < f t := by
    rcases lt_or_gt_of_ne hs with h | h
    · have hF : StrictMonoOn f (Icc s t) := by
        apply strictMonoOn_of_deriv_pos (convex_Icc s t) hC.continuousOn
        intro u hu
        rw [interior_Icc] at hu
        rw [(hD u).deriv]
        exact sub_pos.mpr (hM hu.2)
      exact hF ⟨le_rfl, h.le⟩ ⟨h.le, le_rfl⟩ h
    · have hF : StrictAntiOn f (Icc t s) := by
        apply strictAntiOn_of_deriv_neg (convex_Icc t s) hC.continuousOn
        intro u hu
        rw [interior_Icc] at hu
        rw [(hD u).deriv]
        exact sub_neg.mpr (hM hu.1)
      exact hF ⟨le_rfl, h.le⟩ ⟨h.le, le_rfl⟩ h
  refine ⟨⟨⟨t, rfl⟩, ?_⟩, hStrict⟩
  rintro z ⟨s, rfl⟩
  by_cases h : s = t
  · rw [h]
  · exact (hStrict s h).le

theorem likelihood_rate_at_tilt (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) (t : ℝ) :
    likelihoodRate p q (tiltedMean p q t) = t * tiltedMean p q t - logCumulant p q t :=
  (likelihood_rate_saddle p q hp hq hne t).1.csSup_eq

theorem likelihood_rate_at_minimum (p q : FiniteMass κ)
    {M : ℝ} (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hAtom : 0 < endpointAtomMass p q M) :
    likelihoodRate p q (-M) = endpointLogRate p q M := by
  classical
  let f (s : ℝ) := s * (-M) - logCumulant p q s
  let ell := endpointLogRate p q M
  have hZ (s : ℝ) :
      endpointAtomMass p q M * Real.exp (s * (-M)) ≤ tiltNormalizer p q s := by
    unfold endpointAtomMass tiltNormalizer
    rw [mul_comm, ← FiniteMass.expect_scale_function]
    apply p.expect_mono
    intro i
    by_cases hi : logLikelihood p q i = -M
    · simp only [hi, if_pos rfl, if_true, mul_one, le_refl]
    · simp only [hi, if_false, mul_zero]
      exact Real.exp_nonneg _
  have hF (s : ℝ) : f s ≤ ell := by
    have h := Real.log_le_log (mul_pos hAtom (Real.exp_pos _)) (hZ s)
    rw [Real.log_mul hAtom.ne' (Real.exp_pos _).ne', Real.log_exp] at h
    unfold f ell endpointLogRate logCumulant
    linarith only [h]
  have hUpper : BddAbove (range f) := ⟨ell, fun z ⟨s, hs⟩ => hs ▸ hF s⟩
  apply le_antisymm (csSup_le (range_nonempty f) (fun z ⟨s, hs⟩ => hs ▸ hF s))
  have hT : Tendsto (fun t : ℝ => f (-t)) atTop (𝓝 ell) := by
    apply ((minimum_tilt_cumulant_limit p q hM hAtom).neg).congr
    intro t
    unfold f
    ring
  exact le_of_tendsto_of_tendsto' hT tendsto_const_nhds
    (fun t => le_csSup hUpper ⟨-t, rfl⟩)

theorem likelihood_rate_inverse_tangent (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {r beta t : ℝ} (hRoot : logCumulant p q (-beta) = r * beta) :
    let u := -tiltedMean p q t - r
    beta * u ≤ likelihoodRate p q (tiltedMean p q t) ∧
      (beta * u = likelihoodRate p q (tiltedMean p q t) ↔ t = -beta) := by
  let x := tiltedMean p q t
  let u := -x - r
  have hLine : beta * u = (-beta) * x - logCumulant p q (-beta) := by
    unfold u
    rw [hRoot]
    ring
  have h := likelihood_rate_saddle p q hp hq hne t
  have hE := likelihood_rate_at_tilt p q hp hq hne t
  change beta * u ≤ _ ∧ (_ ↔ _)
  rw [hLine, hE]
  refine ⟨h.1.2 ⟨-beta, rfl⟩, ?_⟩
  constructor
  · intro he
    exact (not_ne_iff.mp (fun hne => (h.2 _ (Ne.symm hne)).ne he))
  · rintro rfl
    rfl

end RenyiProductOrderPhase
