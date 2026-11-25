import LikelihoodLegendre

/-! The global extended-real Legendre transform and its finite restriction. -/

open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def extendedLikelihoodRate (p q : FiniteMass κ) (x : ℝ) : WithTop ℝ :=
  ⨆ s : ℝ, (↑(s * x - logCumulant p q s) : WithTop ℝ)

theorem log_cumulant_le_of_bounded_exponent (p q : FiniteMass κ) {t L : ℝ}
    (hL : ∀ i, t * logLikelihood p q i ≤ L) :
    logCumulant p q t ≤ L := by
  have h := p.expect_mono (f := fun i => Real.exp (t * logLikelihood p q i))
    (g := fun _ => Real.exp L) (fun i => Real.exp_le_exp.mpr (hL i))
  rw [p.expect_const] at h
  have h' := Real.log_le_log (tilt_normalizer_pos p q t) h
  rw [Real.log_exp] at h'
  exact h'

theorem extended_likelihood_rate_finite_on_support_hull (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) {L U x : ℝ}
    (hL : ∃ i, logLikelihood p q i = L) (hU : ∃ j, logLikelihood p q j = U)
    (hx : x ∈ Icc L U) :
    extendedLikelihoodRate p q x = (↑(likelihoodRate p q x) : WithTop ℝ) := by
  obtain ⟨i, hi⟩ := hL
  obtain ⟨j, hj⟩ := hU
  have hB : BddAbove (range (fun s => s * x - logCumulant p q s)) := by
    refine ⟨max (-Real.log (p i)) (-Real.log (p j)), ?_⟩
    rintro z ⟨t, rfl⟩
    change t * x - logCumulant p q t ≤ _
    rcases le_or_gt 0 t with h | h
    · have hQ := cumulant_lower_from_atom p q t (hp j)
      rw [hj] at hQ
      apply le_trans _ (le_max_right _ _)
      linarith only [hQ, mul_le_mul_of_nonneg_left hx.2 h]
    · have hQ := cumulant_lower_from_atom p q t (hp i)
      rw [hi] at hQ
      apply le_trans _ (le_max_left _ _)
      linarith only [hQ, mul_le_mul_of_nonpos_left hx.1 h.le]
  exact (WithTop.coe_iSup (fun s => s * x - logCumulant p q s) hB).symm

private theorem extended_likelihood_rate_top_of_unbounded (p q : FiniteMass κ) (x : ℝ)
    (h : ¬ BddAbove (range (fun s => s * x - logCumulant p q s))) :
    extendedLikelihoodRate p q x = ⊤ := by
  classical
  let f (s : ℝ) := s * x - logCumulant p q s
  let S : Set (WithTop ℝ) := range (fun s => (↑(f s) : WithTop ℝ))
  have hR : ((fun y : ℝ => (y : WithTop ℝ)) ⁻¹' S) = range f := by
    ext y
    constructor
    · rintro ⟨s, hs⟩
      exact ⟨s, WithTop.coe_inj.mp hs⟩
    · rintro ⟨s, rfl⟩
      exact ⟨s, rfl⟩
  change (if (⊤ : WithTop ℝ) ∈ S then ⊤
    else if BddAbove ((fun y : ℝ => (y : WithTop ℝ)) ⁻¹' S) then
      (↑(sSup ((fun y : ℝ => (y : WithTop ℝ)) ⁻¹' S)) : WithTop ℝ) else ⊤) = ⊤
  have hf : ¬ BddAbove (range f) := h
  simp only [hR, hf, if_false, ite_self]

theorem extended_likelihood_rate_top_above_support (p q : FiniteMass κ)
    {U x : ℝ} (hU : ∀ i, logLikelihood p q i ≤ U) (hx : U < x) :
    extendedLikelihoodRate p q x = ⊤ := by
  apply extended_likelihood_rate_top_of_unbounded
  rw [not_bddAbove_iff]
  intro C
  let t := max 0 ((C + 1) / (x - U))
  have ht : 0 ≤ t := le_max_left _ _
  have hT := (div_le_iff₀ (sub_pos.mpr hx)).1 (show (C + 1) / (x - U) ≤ t from le_max_right _ _)
  have h := log_cumulant_le_of_bounded_exponent p q (fun i => mul_le_mul_of_nonneg_left (hU i) ht)
  refine ⟨t * x - logCumulant p q t, ⟨t, rfl⟩, ?_⟩
  linarith only [hT, h]

theorem extended_likelihood_rate_top_below_support (p q : FiniteMass κ)
    {L x : ℝ} (hL : ∀ i, L ≤ logLikelihood p q i) (hx : x < L) :
    extendedLikelihoodRate p q x = ⊤ := by
  apply extended_likelihood_rate_top_of_unbounded
  rw [not_bddAbove_iff]
  intro C
  let t := max 0 ((C + 1) / (L - x))
  have ht : 0 ≤ t := le_max_left _ _
  have hT := (div_le_iff₀ (sub_pos.mpr hx)).1 (show (C + 1) / (L - x) ≤ t from le_max_right _ _)
  have h := log_cumulant_le_of_bounded_exponent p q (fun i =>
    mul_le_mul_of_nonpos_left (hL i) (neg_nonpos.mpr ht))
  refine ⟨(-t) * x - logCumulant p q (-t), ⟨-t, rfl⟩, ?_⟩
  linarith only [hT, h]

theorem extended_likelihood_rate_at_tilt (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) (t : ℝ) :
    extendedLikelihoodRate p q (tiltedMean p q t) =
      (↑(t * tiltedMean p q t - logCumulant p q t) : WithTop ℝ) := by
  let x := tiltedMean p q t
  let f (s : ℝ) := s * x - logCumulant p q s
  have h := (likelihood_rate_saddle p q hp hq hne t).1
  have hB : BddAbove (range f) := ⟨f t, h.2⟩
  have hEq : sSup (range f) = f t := h.csSup_eq
  change (⨆ s : ℝ, (↑(f s) : WithTop ℝ)) = ↑(f t)
  rw [← WithTop.coe_iSup f hB]
  rw [show (⨆ s : ℝ, f s) = f t from hEq]

end RenyiProductOrderPhase
