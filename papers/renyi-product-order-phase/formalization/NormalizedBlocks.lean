import BalancedBlocks

/-! Normalization of the two-point blocks and preservation of finite expectations. -/

open scoped BigOperators
open Classical

namespace RenyiProductOrderPhase

variable {ι : Type*} [Fintype ι]

namespace FiniteMass

noncomputable def densityChange (q : FiniteMass ι) (f : ι → ℝ)
    (hf : ∀ i, 0 ≤ f i) (hm : q.expect f = 1) : FiniteMass ι where
  weight i := q i * f i
  weight_nonneg i := mul_nonneg (q.weight_nonneg i) (hf i)
  total := hm

@[simp] theorem density_change_apply (q : FiniteMass ι) (f : ι → ℝ)
    (hf : ∀ i, 0 ≤ f i) (hm : q.expect f = 1) (i : ι) :
    q.densityChange f hf hm i = q i * f i := rfl

theorem mix_expect (p q : FiniteMass ι) (t : ℝ) (ht : t ∈ Set.Icc (0 : ℝ) 1)
    (f : ι → ℝ) :
    (mix p q t ht).expect f = t * p.expect f + (1 - t) * q.expect f := by
  unfold expect
  simp only [mix_apply, add_mul, mul_assoc, Finset.sum_add_distrib, Finset.mul_sum]

theorem expect_indicator (p : FiniteMass ι) (i : ι) :
    p.expect (fun j => if j = i then 1 else 0) = p i := by
  simp [expect, mul_ite]

end FiniteMass

noncomputable def pairPrior (f : ι → ℝ) (i j : ι) : ℝ :=
  (f j - 1) / (f j - f i)

omit [Fintype ι] in
theorem pair_prior_mem (f : ι → ℝ) {i j : ι} (hi : f i < 1) (hj : 1 < f j) :
    pairPrior f i j ∈ Set.Icc (0 : ℝ) 1 := by
  have hd : 0 < f j - f i := sub_pos.mpr (hi.trans hj)
  exact ⟨(div_pos (sub_pos.mpr hj) hd).le, (div_le_one hd).mpr (by linarith)⟩

noncomputable def pairReference (f : ι → ℝ) (i j : ι)
    (hi : f i < 1) (hj : 1 < f j) : FiniteMass ι :=
  FiniteMass.mix (FiniteMass.dirac i) (FiniteMass.dirac j) (pairPrior f i j)
    (pair_prior_mem f hi hj)

theorem pair_reference_expect (f g : ι → ℝ) (i j : ι)
    (hi : f i < 1) (hj : 1 < f j) :
    (pairReference f i j hi hj).expect g =
      pairPrior f i j * g i + (1 - pairPrior f i j) * g j := by
  rw [pairReference, FiniteMass.mix_expect, FiniteMass.dirac_expect, FiniteMass.dirac_expect]

theorem pair_reference_mean (f : ι → ℝ) (i j : ι) (hi : f i < 1) (hj : 1 < f j) :
    (pairReference f i j hi hj).expect f = 1 := by
  have hd : f j - f i ≠ 0 := (sub_pos.mpr (hi.trans hj)).ne'
  rw [pair_reference_expect]
  unfold pairPrior
  calc
    _ = (f j - 1) / (f j - f i) * (f i - f j) + f j := by ring
    _ = -(f j - 1) + f j := by
      rw [show f i - f j = -(f j - f i) by ring, mul_neg, div_mul_cancel₀ _ hd]
    _ = 1 := by ring

theorem weighted_pair_prior (q : FiniteMass ι) (f : ι → ℝ) (i j : ι)
    (hi : f i < 1) (hj : 1 < f j) :
    (leftBlock q f i j + rightBlock q f i j) * pairPrior f i j = leftBlock q f i j := by
  have hd : f j - f i ≠ 0 := (sub_pos.mpr (hi.trans hj)).ne'
  unfold pairPrior
  rw [← mul_div_assoc]
  apply (div_eq_iff hd).2
  unfold leftBlock rightBlock
  ring

theorem weighted_complementary_prior (q : FiniteMass ι) (f : ι → ℝ) (i j : ι)
    (hi : f i < 1) (hj : 1 < f j) :
    (leftBlock q f i j + rightBlock q f i j) * (1 - pairPrior f i j) =
      rightBlock q f i j := by
  rw [mul_sub, mul_one, weighted_pair_prior q f i j hi hj]
  ring

theorem weighted_pair_expect (q : FiniteMass ι) (f g : ι → ℝ) (i j : ι)
    (hi : f i < 1) (hj : 1 < f j) :
    (leftBlock q f i j + rightBlock q f i j) * (pairReference f i j hi hj).expect g =
      leftBlock q f i j * g i + rightBlock q f i j * g j := by
  rw [pair_reference_expect, mul_add, ← mul_assoc, ← mul_assoc,
    weighted_pair_prior q f i j hi hj, weighted_complementary_prior q f i j hi hj]

noncomputable def blockCoefficient (q : FiniteMass ι) (f : ι → ℝ) :
    Sum (ι × ι) ι → ℝ
  | Sum.inl (i, j) =>
    if f i < 1 ∧ 1 < f j then leftBlock q f i j + rightBlock q f i j else 0
  | Sum.inr i => if f i = 1 then q i else 0

noncomputable def blockReference (q : FiniteMass ι) (f : ι → ℝ) :
    Sum (ι × ι) ι → FiniteMass ι
  | Sum.inl (i, j) =>
    if h : f i < 1 ∧ 1 < f j then pairReference f i j h.1 h.2 else q
  | Sum.inr i => if f i = 1 then FiniteMass.dirac i else q

theorem block_coefficient_nonneg (q : FiniteMass ι) (f : ι → ℝ) (k : Sum (ι × ι) ι) :
    0 ≤ blockCoefficient q f k := by
  cases k with
  | inl k =>
    obtain ⟨i, j⟩ := k
    by_cases h : f i < 1 ∧ 1 < f j
    · simpa only [blockCoefficient, if_pos h] using
        add_nonneg (left_block_nonneg q f i j h.2.le) (right_block_nonneg q f i j h.1.le)
    · simp [blockCoefficient, h]
  | inr i =>
    by_cases h : f i = 1
    · simpa only [blockCoefficient, if_pos h] using q.weight_nonneg i
    · simp [blockCoefficient, h]

theorem block_reference_mean (q : FiniteMass ι) (f : ι → ℝ)
    (hf : q.expect f = 1) (k : Sum (ι × ι) ι) :
    (blockReference q f k).expect f = 1 := by
  cases k with
  | inl k =>
    obtain ⟨i, j⟩ := k
    by_cases h : f i < 1 ∧ 1 < f j
    · simpa only [blockReference, dif_pos h] using pair_reference_mean f i j h.1 h.2
    · simpa only [blockReference, dif_neg h] using hf
  | inr i =>
    by_cases hi : f i = 1
    · simp [blockReference, hi, FiniteMass.dirac_expect]
    · simpa only [blockReference, if_neg hi] using hf

theorem block_expectations (q : FiniteMass ι) (f g : ι → ℝ)
    (hf : q.expect f = 1) (hD : 0 < lowerBalance q f) :
    (∑ k, blockCoefficient q f k * (blockReference q f k).expect g) = q.expect g := by
  rw [← Finset.univ_disjSum_univ, Finset.sum_disj_sum, Fintype.sum_prod_type]
  calc
    _ = (∑ i, ∑ j, if f i < 1 ∧ 1 < f j then
        leftBlock q f i j * g i + rightBlock q f i j * g j else 0) +
          (∑ i, if f i = 1 then q i * g i else 0) := by
      congr 1
      · refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
        by_cases h : f i < 1 ∧ 1 < f j
        · simpa only [blockCoefficient, blockReference, if_pos h, dif_pos h] using
            weighted_pair_expect q f g i j h.1 h.2
        · simp [blockCoefficient, h]
      · refine Finset.sum_congr rfl fun i _ => ?_
        by_cases hi : f i = 1
        · simp [blockCoefficient, blockReference, hi, FiniteMass.dirac_expect]
        · simp [blockCoefficient, hi]
    _ = q.expect g := by
      rw [← sum_balanced_blocks q f g hf hD]
      congr 1
      · simp only [lowerIndices, upperIndices, Finset.sum_filter]
        refine Finset.sum_congr rfl fun i _ => ?_
        by_cases hi : f i < 1 <;> simp [hi]
      · rw [Finset.sum_filter]

noncomputable def blockMasses (q : FiniteMass ι) (f : ι → ℝ)
    (hf : q.expect f = 1) (hD : 0 < lowerBalance q f) : FiniteMass (Sum (ι × ι) ι) where
  weight := blockCoefficient q f
  weight_nonneg := block_coefficient_nonneg q f
  total := by
    simpa only [FiniteMass.expect_const, mul_one] using
      block_expectations q f (fun _ => 1) hf hD

end RenyiProductOrderPhase
