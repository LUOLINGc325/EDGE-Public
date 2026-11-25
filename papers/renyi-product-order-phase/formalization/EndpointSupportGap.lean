import MinimumAtomTilt

/-! A positive finite support gap and the endpoint Laplace-transform bound. -/

open scoped BigOperators Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem minimum_likelihood_positive_gap (p q : FiniteMass κ) {M : ℝ}
    (hM : ∀ i, -M ≤ logLikelihood p q i) :
    ∃ d > 0, ∀ i, logLikelihood p q i = -M ∨ d ≤ logLikelihood p q i + M := by
  let W (i : κ) := logLikelihood p q i + M
  have hW (i : κ) : 0 ≤ W i := by unfold W; linarith only [hM i]
  let B := 1 + ∑ i, (W i)⁻¹
  have hB : 0 < B := add_pos_of_pos_of_nonneg zero_lt_one
    (Finset.sum_nonneg (fun i _ => inv_nonneg.mpr (hW i)))
  refine ⟨B⁻¹, inv_pos.mpr hB, fun i => ?_⟩
  by_cases hi : logLikelihood p q i = -M
  · exact Or.inl hi
  · right
    have hWi : 0 < W i := by
      unfold W
      linarith only [lt_of_le_of_ne (hM i) (Ne.symm hi)]
    have h := Finset.single_le_sum (f := fun j : κ => (W j)⁻¹)
      (fun j _ => inv_nonneg.mpr (hW j)) (Finset.mem_univ i)
    change B⁻¹ ≤ W i
    rw [← inv_inv (W i)]
    exact (inv_le_inv₀ hB (inv_pos.mpr hWi)).2 (h.trans (by unfold B; linarith))

theorem endpoint_expectation_bound_of_gap (p q : FiniteMass κ) {M d : ℝ}
    (hGap : ∀ i, logLikelihood p q i = -M ∨ d ≤ logLikelihood p q i + M)
    (g : ℝ → ℝ) (hg : Antitone g) :
    p.expect (fun i => g (logLikelihood p q i + M)) ≤
      endpointAtomMass p q M * g 0 + (1 - endpointAtomMass p q M) * g d := by
  classical
  let f (i : κ) : ℝ := if logLikelihood p q i = -M then 1 else 0
  have hPoint (i : κ) : g (logLikelihood p q i + M) ≤ g d + (g 0 - g d) * f i := by
    rcases hGap i with hi | hi
    · simp only [f, hi, if_pos rfl, if_true, neg_add_cancel, mul_one]
      linarith only
    · by_cases he : logLikelihood p q i = -M
      · simp only [f, he, if_pos rfl, if_true, neg_add_cancel, mul_one]
        linarith only
      · simpa only [f, he, if_false, mul_zero, add_zero] using hg hi
  have h := p.expect_mono hPoint
  rw [FiniteMass.expect_add_functions, FiniteMass.expect_const, FiniteMass.expect_scale_function] at h
  change _ ≤ g d + (g 0 - g d) * endpointAtomMass p q M at h
  calc
    _ ≤ _ := h
    _ = _ := by ring

theorem minimum_shifted_exponential_upper (p q : FiniteMass κ) {M d t : ℝ}
    (hGap : ∀ i, logLikelihood p q i = -M ∨ d ≤ logLikelihood p q i + M)
    (ht : 0 ≤ t) :
    p.expect (fun i => Real.exp (-t * (logLikelihood p q i + M))) ≤
      endpointAtomMass p q M + (1 - endpointAtomMass p q M) * Real.exp (-t * d) := by
  have h := endpoint_expectation_bound_of_gap p q hGap (fun x => Real.exp (-t * x))
    (fun a b hab => Real.exp_le_exp.mpr (mul_le_mul_of_nonpos_left hab (neg_nonpos.mpr ht)))
  simpa only [mul_zero, Real.exp_zero, mul_one] using h

theorem minimum_tilt_cumulant_upper (p q : FiniteMass κ) {M d t : ℝ}
    (hGap : ∀ i, logLikelihood p q i = -M ∨ d ≤ logLikelihood p q i + M)
    (ht : 0 ≤ t) (hAtom : 0 < endpointAtomMass p q M) (hAtom' : endpointAtomMass p q M ≤ 1) :
    logCumulant p q (-t) ≤ t * M - endpointLogRate p q M +
      ((1 - endpointAtomMass p q M) / endpointAtomMass p q M) * Real.exp (-t * d) := by
  let A := endpointAtomMass p q M
  let Z := p.expect (fun i => Real.exp (-t * (logLikelihood p q i + M)))
  let e := ((1 - A) / A) * Real.exp (-t * d)
  have h : Z ≤ A + (1 - A) * Real.exp (-t * d) :=
    minimum_shifted_exponential_upper p q hGap ht
  have hZ : 0 < Z := by
    obtain ⟨i, hi⟩ := p.exists_weight_pos
    exact p.expect_pos (fun _ => Real.exp_nonneg _) hi (Real.exp_pos _)
  have he : 0 ≤ e := mul_nonneg (div_nonneg (sub_nonneg.mpr hAtom') hAtom.le) (Real.exp_nonneg _)
  have hA : A + (1 - A) * Real.exp (-t * d) = A * (1 + e) := by
    unfold e
    field_simp [hAtom.ne']
  rw [hA] at h
  have hLog := Real.log_le_log hZ h
  rw [Real.log_mul hAtom.ne' (by positivity : (1 + e) ≠ 0)] at hLog
  have hLog' := (log_one_add_bounds he).2
  unfold logCumulant endpointLogRate
  rw [minimum_tilt_normalizer_factorization p q M t, Real.log_mul (Real.exp_pos _).ne' hZ.ne',
    Real.log_exp]
  change t * M + Real.log Z ≤ t * M - -Real.log A + e
  linarith only [hLog, hLog']

end RenyiProductOrderPhase
