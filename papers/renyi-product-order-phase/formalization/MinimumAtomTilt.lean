import InverseOrderRoot
import EndpointAtomicSandwich
import Mathlib.Analysis.SpecialFunctions.Exp

/-! The minimum-atom limit of the tilted normalizer and mean. -/

open scoped BigOperators Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

private theorem expect_tendsto (p : FiniteMass κ) {f : ℝ → κ → ℝ} {g : κ → ℝ}
    (h : ∀ i, Tendsto (fun t => f t i) atTop (𝓝 (g i))) :
    Tendsto (fun t => p.expect (f t)) atTop (𝓝 (p.expect g)) := by
  unfold FiniteMass.expect
  exact tendsto_finset_sum Finset.univ fun i _ => tendsto_const_nhds.mul (h i)

theorem tilted_mean_strictly_above_minimum (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) {M : ℝ} (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hOther : ∃ i, -M < logLikelihood p q i) (s : ℝ) :
    -M < tiltedMean p q s := by
  let R := tiltedMass p q s
  have h := tilted_shifted_mean p q s M
  obtain ⟨i, hi⟩ := hOther
  have hp' : 0 < R.expect (fun i => logLikelihood p q i + M) :=
    R.expect_pos (fun j => by linarith only [hM j]) (tilted_mass_pos p q hp s i)
      (by linarith only [hi])
  change 0 < (tiltedMass p q s).expect (fun i => logLikelihood p q i + M) at hp'
  rw [h] at hp'
  linarith only [hp']

theorem shifted_minimum_tilt_limit (p q : FiniteMass κ) {M : ℝ}
    (hM : ∀ i, -M ≤ logLikelihood p q i) :
    Tendsto (fun t : ℝ => p.expect (fun i => Real.exp (-t * (logLikelihood p q i + M))))
      atTop (𝓝 (endpointAtomMass p q M)) := by
  classical
  unfold endpointAtomMass
  apply expect_tendsto
  intro i
  by_cases hi : logLikelihood p q i = -M
  · rw [hi]
    simp only [if_pos rfl, neg_add_cancel, mul_zero, Real.exp_zero]
    exact tendsto_const_nhds
  · simp only [hi, if_false, neg_mul]
    have h : 0 < logLikelihood p q i + M := by
      linarith only [lt_of_le_of_ne (hM i) (Ne.symm hi)]
    apply Real.tendsto_exp_atBot.comp
    apply tendsto_atBot.2
    intro a
    filter_upwards [eventually_ge_atTop (-a / (logLikelihood p q i + M))] with t ht
    have h' := (div_le_iff₀ h).1 ht
    linarith only [h']

theorem tilted_mean_tendsto_minimum (p q : FiniteMass κ) {M : ℝ}
    (hM : ∀ i, -M ≤ logLikelihood p q i) (hAtom : 0 < endpointAtomMass p q M) :
    Tendsto (fun t : ℝ => tiltedMean p q (-t)) atTop (𝓝 (-M)) := by
  let Y := logLikelihood p q
  let f (t : ℝ) (i : κ) := Real.exp (-t * (Y i + M))
  let g (t : ℝ) (i : κ) := f t i * (Y i + M)
  have hN : Tendsto (fun t => p.expect (g t)) atTop (𝓝 0) := by
    have h0 : p.expect (fun _ => (0 : ℝ)) = 0 := p.expect_const 0
    rw [← h0]
    apply expect_tendsto
    intro i
    by_cases hi : Y i = -M
    · simp only [g, hi, neg_add_cancel, mul_zero]
      exact tendsto_const_nhds
    · have h : 0 < Y i + M := by
        linarith only [lt_of_le_of_ne (hM i) (Ne.symm hi)]
      have hExp : Tendsto (fun t : ℝ => Real.exp (-t * (Y i + M))) atTop (𝓝 0) := by
        apply Real.tendsto_exp_atBot.comp
        apply tendsto_atBot.2
        intro a
        filter_upwards [eventually_ge_atTop (-a / (Y i + M))] with t ht
        have h' := (div_le_iff₀ h).1 ht
        linarith only [h']
      have hT := hExp.mul (tendsto_const_nhds (x := Y i + M))
      simpa only [g, f, zero_mul] using hT
  have hD : Tendsto (fun t => p.expect (f t)) atTop (𝓝 (endpointAtomMass p q M)) :=
    shifted_minimum_tilt_limit p q hM
  have hEq (t : ℝ) : p.expect (g t) / p.expect (f t) = tiltedMean p q (-t) + M := by
    let c := Real.exp (-t * M)
    have hf : f t = fun i => c * Real.exp (-t * Y i) := by
      funext i
      unfold f c
      rw [mul_add, Real.exp_add, mul_comm]
    have hg : g t = fun i => c * (Real.exp (-t * Y i) * (Y i + M)) := by
      funext i
      change f t i * (Y i + M) = _
      rw [hf, ← mul_assoc]
    rw [hg, hf, FiniteMass.expect_scale_function, FiniteMass.expect_scale_function,
      mul_div_mul_left _ _ (Real.exp_pos _).ne']
    change (p.expect (fun i => Real.exp (-t * logLikelihood p q i) *
      (logLikelihood p q i + M))) / tiltNormalizer p q (-t) = _
    rw [← tilted_expectation, tilted_shifted_mean]
  have h := (hN.div hD hAtom.ne').congr hEq
  have h' := h.sub_const M
  simpa only [zero_div, zero_sub, add_sub_cancel_right] using h'

theorem minimum_tilt_normalizer_factorization (p q : FiniteMass κ) (M t : ℝ) :
    tiltNormalizer p q (-t) =
      Real.exp (t * M) * p.expect (fun i => Real.exp (-t * (logLikelihood p q i + M))) := by
  unfold tiltNormalizer
  rw [← FiniteMass.expect_scale_function]
  congr 1
  funext i
  rw [← Real.exp_add]
  congr 1
  ring

theorem minimum_tilt_cumulant_limit (p q : FiniteMass κ) {M : ℝ}
    (hM : ∀ i, -M ≤ logLikelihood p q i) (hAtom : 0 < endpointAtomMass p q M) :
    Tendsto (fun t : ℝ => logCumulant p q (-t) - t * M) atTop
      (𝓝 (Real.log (endpointAtomMass p q M))) := by
  let f (t : ℝ) := p.expect (fun i => Real.exp (-t * (logLikelihood p q i + M)))
  have h := (Real.continuousAt_log hAtom.ne').tendsto.comp (shifted_minimum_tilt_limit p q hM)
  apply h.congr
  intro t
  have hf : 0 < f t := by
    obtain ⟨i, hi⟩ := p.exists_weight_pos
    exact p.expect_pos (fun _ => Real.exp_nonneg _) hi (Real.exp_pos _)
  change Real.log (f t) = _
  unfold logCumulant
  rw [minimum_tilt_normalizer_factorization p q M t]
  change Real.log (f t) = Real.log (Real.exp (t * M) * f t) - t * M
  rw [Real.log_mul (Real.exp_pos _).ne' hf.ne', Real.log_exp]
  ring

end RenyiProductOrderPhase
