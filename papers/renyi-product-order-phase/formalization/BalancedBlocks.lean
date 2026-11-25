import FiniteDistributions

/-! Explicit finite decomposition of a mean-one likelihood ratio into
two-point blocks with one value on each side of one. -/

open scoped BigOperators
open Classical

namespace RenyiProductOrderPhase

variable {ι : Type*} [Fintype ι]

noncomputable def lowerIndices (f : ι → ℝ) : Finset ι :=
  Finset.univ.filter (fun i => f i < 1)

noncomputable def upperIndices (f : ι → ℝ) : Finset ι :=
  Finset.univ.filter (fun i => 1 < f i)

@[simp] theorem mem_lowerIndices (f : ι → ℝ) (i : ι) :
    i ∈ lowerIndices f ↔ f i < 1 := by
  simp [lowerIndices]

@[simp] theorem mem_upperIndices (f : ι → ℝ) (i : ι) :
    i ∈ upperIndices f ↔ 1 < f i := by
  simp [upperIndices]

noncomputable def lowerBalance (q : FiniteMass ι) (f : ι → ℝ) : ℝ :=
  ∑ i ∈ lowerIndices f, q i * (1 - f i)

noncomputable def upperBalance (q : FiniteMass ι) (f : ι → ℝ) : ℝ :=
  ∑ i ∈ upperIndices f, q i * (f i - 1)

theorem lower_balance_nonneg (q : FiniteMass ι) (f : ι → ℝ) : 0 ≤ lowerBalance q f :=
  Finset.sum_nonneg (fun i hi => mul_nonneg (q.weight_nonneg i)
    (sub_nonneg.mpr ((mem_lowerIndices f i).mp hi).le))

theorem upper_balance_nonneg (q : FiniteMass ι) (f : ι → ℝ) : 0 ≤ upperBalance q f :=
  Finset.sum_nonneg (fun i hi => mul_nonneg (q.weight_nonneg i)
    (sub_nonneg.mpr ((mem_upperIndices f i).mp hi).le))

theorem mean_one_balance (q : FiniteMass ι) (f : ι → ℝ) (hf : q.expect f = 1) :
    lowerBalance q f = upperBalance q f := by
  apply sub_eq_zero.mp
  unfold lowerBalance upperBalance lowerIndices upperIndices
  simp only [Finset.sum_filter]
  calc
    _ = (∑ i, q i) - q.expect f := by
      unfold FiniteMass.expect
      rw [← Finset.sum_sub_distrib, ← Finset.sum_sub_distrib]
      refine Finset.sum_congr rfl fun i _ => ?_
      by_cases hlow : f i < 1
      · have hhi : ¬ 1 < f i := not_lt_of_ge hlow.le
        simp [hlow, hhi]
        ring
      · by_cases hhi : 1 < f i
        · simp [hlow, hhi]
          ring
        · have he : f i = 1 := le_antisymm (le_of_not_gt hhi) (le_of_not_gt hlow)
          simp [he]
    _ = 0 := by rw [q.total, hf, sub_self]

theorem zero_balance_neutral (q : FiniteMass ι) (f : ι → ℝ)
    (hf : q.expect f = 1) (hz : lowerBalance q f = 0) :
    ∀ i, 0 < q i → f i = 1 := by
  intro i hQi
  apply le_antisymm
  · by_contra hle
    have h : 1 < f i := lt_of_not_ge hle
    have hi : i ∈ upperIndices f := (mem_upperIndices f i).2 h
    have hx : q i * (f i - 1) ≤ upperBalance q f :=
      Finset.single_le_sum (fun j hj => mul_nonneg (q.weight_nonneg j)
        (sub_nonneg.mpr ((mem_upperIndices f j).mp hj).le)) hi
    rw [← mean_one_balance q f hf, hz] at hx
    exact (not_le_of_gt (mul_pos hQi (sub_pos.mpr h))) hx
  · by_contra hle
    have h : f i < 1 := lt_of_not_ge hle
    have hi : i ∈ lowerIndices f := (mem_lowerIndices f i).2 h
    have hx : q i * (1 - f i) ≤ lowerBalance q f :=
      Finset.single_le_sum (fun j hj => mul_nonneg (q.weight_nonneg j)
        (sub_nonneg.mpr ((mem_lowerIndices f j).mp hj).le)) hi
    rw [hz] at hx
    exact (not_le_of_gt (mul_pos hQi (sub_pos.mpr h))) hx

noncomputable def leftBlock (q : FiniteMass ι) (f : ι → ℝ) (i j : ι) : ℝ :=
  q i / lowerBalance q f * (q j * (f j - 1))

noncomputable def rightBlock (q : FiniteMass ι) (f : ι → ℝ) (i j : ι) : ℝ :=
  q j / lowerBalance q f * (q i * (1 - f i))

theorem left_block_nonneg (q : FiniteMass ι) (f : ι → ℝ) (i j : ι) (hj : 1 ≤ f j) :
    0 ≤ leftBlock q f i j :=
  mul_nonneg (div_nonneg (q.weight_nonneg i) (lower_balance_nonneg q f))
    (mul_nonneg (q.weight_nonneg j) (sub_nonneg.mpr hj))

theorem right_block_nonneg (q : FiniteMass ι) (f : ι → ℝ) (i j : ι) (hi : f i ≤ 1) :
    0 ≤ rightBlock q f i j :=
  mul_nonneg (div_nonneg (q.weight_nonneg j) (lower_balance_nonneg q f))
    (mul_nonneg (q.weight_nonneg i) (sub_nonneg.mpr hi))

theorem sum_left_blocks (q : FiniteMass ι) (f : ι → ℝ) (hf : q.expect f = 1)
    (hD : 0 < lowerBalance q f) (i : ι) :
    (∑ j ∈ upperIndices f, leftBlock q f i j) = q i := by
  unfold leftBlock
  rw [← Finset.mul_sum]
  change q i / lowerBalance q f * upperBalance q f = q i
  rw [← mean_one_balance q f hf, div_mul_cancel₀ _ hD.ne']

theorem sum_right_blocks (q : FiniteMass ι) (f : ι → ℝ)
    (hD : 0 < lowerBalance q f) (j : ι) :
    (∑ i ∈ lowerIndices f, rightBlock q f i j) = q j := by
  unfold rightBlock
  rw [← Finset.mul_sum]
  exact div_mul_cancel₀ (q j) hD.ne'

theorem block_weighted_mean (q : FiniteMass ι) (f : ι → ℝ) (i j : ι) :
    leftBlock q f i j * f i + rightBlock q f i j * f j =
      leftBlock q f i j + rightBlock q f i j := by
  unfold leftBlock rightBlock
  ring

/-- Integration against the original mass equals the sum of the left and right
couplings and the singleton mass at every neutral coordinate. -/
theorem sum_balanced_blocks (q : FiniteMass ι) (f g : ι → ℝ)
    (hf : q.expect f = 1) (hD : 0 < lowerBalance q f) :
    (∑ i ∈ lowerIndices f, ∑ j ∈ upperIndices f,
      (leftBlock q f i j * g i + rightBlock q f i j * g j)) +
        (∑ k ∈ Finset.univ.filter (fun k => f k = 1), q k * g k) = q.expect g := by
  simp only [Finset.sum_add_distrib]
  have hleft :
      (∑ i ∈ lowerIndices f, ∑ j ∈ upperIndices f, leftBlock q f i j * g i) =
        ∑ i ∈ lowerIndices f, q i * g i := by
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [← Finset.sum_mul, sum_left_blocks q f hf hD]
  have hright :
      (∑ i ∈ lowerIndices f, ∑ j ∈ upperIndices f, rightBlock q f i j * g j) =
        ∑ j ∈ upperIndices f, q j * g j := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [← Finset.sum_mul, sum_right_blocks q f hD]
  rw [hleft, hright]
  unfold lowerIndices upperIndices FiniteMass.expect
  simp only [Finset.sum_filter]
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rcases lt_trichotomy (f i) 1 with hl | he | hh
  · simp [hl, hl.ne, not_lt_of_ge hl.le]
  · simp [he]
  · simp [hh, hh.ne', not_lt_of_ge hh.le]

end RenyiProductOrderPhase
