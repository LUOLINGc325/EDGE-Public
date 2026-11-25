import FiniteJensen
import NormalizedBlocks

/-! The two-point support restriction for the moment inequality. -/

open scoped BigOperators
open Classical

namespace RenyiProductOrderPhase

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- The moment contraction inequality restricted to common two-point support. -/
def TwoPointMomentBound (w : ι → FiniteMass κ) (b r : ℝ) : Prop :=
  ∀ i j : ι, i ≠ j → ∀ (s t : ℝ) (hs : s ∈ Set.Icc (0 : ℝ) 1)
    (ht : t ∈ Set.Icc (0 : ℝ) 1), 0 < t → t < 1 →
    let p := FiniteMass.mix (FiniteMass.dirac i) (FiniteMass.dirac j) s hs
    let q := FiniteMass.mix (FiniteMass.dirac i) (FiniteMass.dirac j) t ht
    renyiMoment b (p.push w) (q.push w) ≤ renyiMoment b p q ^ r

omit [Fintype ι] in
theorem pair_prior_interior (f : ι → ℝ) {i j : ι} (hi : f i < 1) (hj : 1 < f j) :
    0 < pairPrior f i j ∧ pairPrior f i j < 1 := by
  have hd : 0 < f j - f i := sub_pos.mpr (hi.trans hj)
  exact ⟨div_pos (sub_pos.mpr hj) hd, (div_lt_one hd).mpr (by linarith)⟩

theorem pair_alternative_is_mixture (f : ι → ℝ) (h₀ : ∀ k, 0 ≤ f k)
    (i j : ι) (hi : f i < 1) (hj : 1 < f j) :
    ∃ s : ℝ, ∃ hs : s ∈ Set.Icc (0 : ℝ) 1,
      (pairReference f i j hi hj).densityChange f h₀ (pair_reference_mean f i j hi hj) =
        FiniteMass.mix (FiniteMass.dirac i) (FiniteMass.dirac j) s hs := by
  let t := pairPrior f i j
  have ht : t ∈ Set.Icc (0 : ℝ) 1 := pair_prior_mem f hi hj
  have hm : t * f i + (1 - t) * f j = 1 := by
    rw [← pair_reference_expect f f i j hi hj, pair_reference_mean]
  have hs : t * f i ∈ Set.Icc (0 : ℝ) 1 :=
    ⟨mul_nonneg ht.1 (h₀ i),
      by linarith only [hm, mul_nonneg (sub_nonneg.mpr ht.2) (h₀ j)]⟩
  have hcomp : 1 - t * f i = (1 - t) * f j := by linarith only [hm]
  have hij : i ≠ j := fun he => (hi.trans hj).ne (congrArg f he)
  refine ⟨t * f i, hs, ?_⟩
  ext k
  simp only [FiniteMass.density_change_apply, pairReference, FiniteMass.mix_apply,
    FiniteMass.dirac_apply]
  by_cases hki : k = i
  · subst k
    simp [hij, t]
  · by_cases hkj : k = j
    · subst k
      simpa [hki, t] using hcomp.symm
    · simp [hki, hkj]

noncomputable def blockAlternative (q : FiniteMass ι) (f : ι → ℝ)
    (h₀ : ∀ k, 0 ≤ f k) (hf : q.expect f = 1) (k : Sum (ι × ι) ι) : FiniteMass ι :=
  (blockReference q f k).densityChange f h₀ (block_reference_mean q f hf k)

theorem reconstruct_reference (q : FiniteMass ι) (f : ι → ℝ)
    (hf : q.expect f = 1) (hD : 0 < lowerBalance q f) :
    (blockMasses q f hf hD).push (blockReference q f) = q := by
  ext i
  have h : ((blockMasses q f hf hD).push (blockReference q f)).expect
      (fun j => if j = i then 1 else 0) = q.expect (fun j => if j = i then 1 else 0) := by
    rw [FiniteMass.push_expect]
    exact block_expectations q f _ hf hD
  simpa only [FiniteMass.expect_indicator] using h

theorem reconstruct_alternative (q : FiniteMass ι) (f : ι → ℝ)
    (h₀ : ∀ k, 0 ≤ f k) (hf : q.expect f = 1) (hD : 0 < lowerBalance q f) :
    (blockMasses q f hf hD).push (blockAlternative q f h₀ hf) = q.densityChange f h₀ hf := by
  ext i
  change (∑ k, blockMasses q f hf hD k * (blockReference q f k i * f i)) =
    q i * f i
  simp_rw [← mul_assoc]
  rw [← Finset.sum_mul]
  change (blockMasses q f hf hD).push (blockReference q f) i * f i = _
  rw [reconstruct_reference q f hf hD]

theorem moment_bound_from_two_points (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (b : ℝ) (hb : 0 < b) (r : ℝ) (hr : r ∈ Set.Icc (0 : ℝ) 1)
    (hbound : TwoPointMomentBound w b r) (p q : FiniteMass ι)
    (hac : p.AbsolutelyContinuous q) :
    renyiMoment b (p.push w) (q.push w) ≤ renyiMoment b p q ^ r := by
  let f (i : ι) := p i / q i
  have h₀ (i : ι) : 0 ≤ f i := div_nonneg (p.weight_nonneg i) (q.weight_nonneg i)
  have hf : q.expect f = 1 := reference_expected_ratio p q hac
  have hrel (i : ι) : p i = q i * f i := density_ratio_eq p q hac i
  have heqp : q.densityChange f h₀ hf = p := FiniteMass.ext (fun i => (hrel i).symm)
  rcases eq_or_lt_of_le (lower_balance_nonneg q f) with hD | hD
  · have he : p = q := by
      ext i
      by_cases hz : q i = 0
      · exact (hac i hz).trans hz.symm
      · rw [hrel i, zero_balance_neutral q f hf hD.symm i
          (lt_of_le_of_ne (q.weight_nonneg i) (Ne.symm hz)), mul_one]
    rw [he, renyi_moment_self, renyi_moment_self, Real.one_rpow]
  let θ := blockMasses q f hf hD
  let q' := blockReference q f
  let p' := blockAlternative q f h₀ hf
  have hq' : θ.push q' = q := reconstruct_reference q f hf hD
  have hp' : θ.push p' = p := (reconstruct_alternative q f h₀ hf hD).trans heqp
  have hshared (k : Sum (ι × ι) ι) (i : ι) : p' k i = q' k i * f i := rfl
  have hinput :
      renyiMoment b p q = θ.expect (fun k => renyiMoment b (p' k) (q' k)) := by
    rw [← hp', ← hq']
    exact mixed_shared_density_moment b hb θ p' q' f hshared
  have hpiece (k : Sum (ι × ι) ι) (hθ : θ k ≠ 0) :
      renyiMoment b ((p' k).push w) ((q' k).push w) ≤ renyiMoment b (p' k) (q' k) ^ r := by
    cases k with
    | inl k =>
      obtain ⟨i, j⟩ := k
      have hs : f i < 1 ∧ 1 < f j := by
        by_contra h
        apply hθ
        change blockCoefficient q f (Sum.inl (i, j)) = 0
        simp [blockCoefficient, h]
      have hqi : q' (Sum.inl (i, j)) = pairReference f i j hs.1 hs.2 := by
        simp [q', blockReference, hs]
      have hpi : p' (Sum.inl (i, j)) =
          (pairReference f i j hs.1 hs.2).densityChange f h₀
            (pair_reference_mean f i j hs.1 hs.2) := by
        ext u
        change q' (Sum.inl (i, j)) u * f u = pairReference f i j hs.1 hs.2 u * f u
        rw [hqi]
      obtain ⟨s, hs₀, hAlt⟩ := pair_alternative_is_mixture f h₀ i j hs.1 hs.2
      rw [hqi, hpi, hAlt]
      have hij : i ≠ j := fun he => (hs.1.trans hs.2).ne (congrArg f he)
      exact hbound i j hij s (pairPrior f i j) hs₀ (pair_prior_mem f hs.1 hs.2)
        (pair_prior_interior f hs.1 hs.2).1 (pair_prior_interior f hs.1 hs.2).2
    | inr i =>
      have hs : f i = 1 := by
        by_cases h : f i = 1
        · exact h
        · exfalso
          apply hθ
          change blockCoefficient q f (Sum.inr i) = 0
          simp [blockCoefficient, h]
      have hi : q' (Sum.inr i) = FiniteMass.dirac i := by
        simp [q', blockReference, hs]
      have he : p' (Sum.inr i) = q' (Sum.inr i) := by
        ext j
        rw [hshared, hi]
        by_cases hj : j = i
        · subst j
          simp [hs]
        · simp [hj]
      rw [he, renyi_moment_self, renyi_moment_self, Real.one_rpow]
  calc
    renyiMoment b (p.push w) (q.push w) =
        renyiMoment b (θ.push (fun k => (p' k).push w))
          (θ.push (fun k => (q' k).push w)) := by
      rw [← hp', ← hq', FiniteMass.push_assoc, FiniteMass.push_assoc]
    _ ≤ θ.expect (fun k => renyiMoment b ((p' k).push w) ((q' k).push w)) :=
      joint_mixture_moment_le b hb θ _ _ (fun k y => (q' k).push_pos w hw y)
    _ ≤ θ.expect (fun k => renyiMoment b (p' k) (q' k) ^ r) := by
      unfold FiniteMass.expect
      refine Finset.sum_le_sum fun k _ => ?_
      by_cases hk : θ k = 0
      · simp [hk]
      · exact mul_le_mul_of_nonneg_left (hpiece k hk) (θ.weight_nonneg k)
    _ ≤ (θ.expect (fun k => renyiMoment b (p' k) (q' k))) ^ r := by
      apply moment_power_jensen θ hr.1 hr.2
      intro k
      exact (renyi_moment_pos _ _ b (fun i hi => by rw [hshared, hi, zero_mul])).le
    _ = renyiMoment b p q ^ r := by rw [← hinput]

end RenyiProductOrderPhase
