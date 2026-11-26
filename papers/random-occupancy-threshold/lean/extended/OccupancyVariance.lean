import OccupancyParity

open scoped BigOperators

namespace TwoColorNullity.Occupancy

variable {Item Label : Type*} [Fintype Item] [Fintype Label] [DecidableEq Label]

noncomputable def singleParityMean (Item Label : Type*) [Fintype Item] [Fintype Label] : ℝ :=
  (1 - 2 / (Fintype.card Label : ℝ)) ^ Fintype.card Item

noncomputable def pairParityMean (Item Label : Type*) [Fintype Item] [Fintype Label] : ℝ :=
  (1 - 4 / (Fintype.card Label : ℝ)) ^ Fintype.card Item

noncomputable def binParity (bins : Item → Label) (label : Label) : ℝ :=
  (-1) ^ binOccupancy bins label

omit [Fintype Label] in
private theorem hitCount_two (bins : Item → Label) {first second : Label} (hne : first ≠ second) :
    hitCount bins {first, second} = binOccupancy bins first + binOccupancy bins second := by
  let left := Finset.univ.filter fun item : Item => bins item = first
  let right := Finset.univ.filter fun item : Item => bins item = second
  classical
  have hdisjoint : Disjoint left right := by
    apply Finset.disjoint_left.mpr
    intro item hl hr
    exact hne ((Finset.mem_filter.mp hl).2.symm.trans (Finset.mem_filter.mp hr).2)
  have hsets : (Finset.univ.filter fun item => bins item ∈ ({first, second} : Finset Label)) = left ∪ right := by
    ext item
    simp [left, right]
  unfold hitCount
  rw [hsets, Finset.card_union_of_disjoint hdisjoint]
  rfl

private theorem product_parity_mean [DecidableEq Item] [Nonempty Label] (first second : Label) :
    finiteMean (fun bins : Item → Label => binParity bins first * binParity bins second) =
      if first = second then 1 else pairParityMean Item Label := by
  by_cases h : first = second
  · subst second
    rw [if_pos rfl]
    have heq (bins : Item → Label) : binParity bins first * binParity bins first = 1 := by
      unfold binParity
      rw [← mul_pow]
      norm_num
    simp only [heq, finiteMean_const]
  · rw [if_neg h]
    have heq (bins : Item → Label) : binParity bins first * binParity bins second =
        (-1 : ℝ) ^ hitCount bins {first, second} := by
      rw [hitCount_two bins h]
      exact (pow_add _ _ _).symm
    have hmem : first ∉ ({second} : Finset Label) := by simpa only [Finset.mem_singleton] using h
    have hcard : ({first, second} : Finset Label).card = 2 := by
      rw [Finset.card_insert_of_notMem hmem, Finset.card_singleton]
    norm_num [heq, hit_parity_mean, pairParityMean, hcard]

private theorem centered_parity_product_mean [DecidableEq Item] [Nonempty Label] (first second : Label) :
    finiteMean (fun bins : Item → Label =>
      (binParity bins first - singleParityMean Item Label) *
        (binParity bins second - singleParityMean Item Label)) =
    (if first = second then 1 else pairParityMean Item Label) -
      singleParityMean Item Label ^ 2 := by
  let a := singleParityMean Item Label
  have heq (bins : Item → Label) :
      (binParity bins first - a) * (binParity bins second - a) =
        binParity bins first * binParity bins second -
          binParity bins first * a - a * binParity bins second + a ^ 2 := by ring
  have hmean (label : Label) : finiteMean (fun bins : Item → Label => binParity bins label) = a :=
    bin_parity_mean label
  change finiteMean (fun bins : Item → Label => (binParity bins first - a) * (binParity bins second - a)) =
    (if first = second then 1 else pairParityMean Item Label) - a ^ 2
  simp only [heq, finiteMean_add, finiteMean_sub, finiteMean_mul_const, finiteMean_const_mul,
    finiteMean_const, product_parity_mean, hmean]
  ring

private theorem sum_centered_parities [DecidableEq Item] [Nonempty Label] (bins : Item → Label) :
    (∑ label : Label, (binParity bins label - singleParityMean Item Label)) =
      -2 * ((oddBinCount bins : ℝ) -
        finiteMean (fun profile : Item → Label => (oddBinCount profile : ℝ))) := by
  have heq (label : Label) :
      binParity bins label = 1 - 2 * ((binOccupancy bins label % 2 : ℕ) : ℝ) := by
    unfold binParity
    linarith only [cast_mod_two_eq_sign (binOccupancy bins label)]
  rw [oddBinCount_mean]
  simp only [heq, Finset.sum_sub_distrib, ← Finset.mul_sum, Finset.sum_const, nsmul_eq_mul, Finset.card_univ,
    ← Nat.cast_sum, oddBinCount, singleParityMean]
  ring

noncomputable def oddBinVariance (Item Label : Type*) [Fintype Item] [Fintype Label] [DecidableEq Item] [DecidableEq Label] : ℝ :=
  let mean := finiteMean (fun bins : Item → Label => (oddBinCount bins : ℝ))
  finiteMean (fun bins : Item → Label => ((oddBinCount bins : ℝ) - mean) ^ 2)

theorem oddBinVariance_exact [DecidableEq Item] [Nonempty Label] :
    4 * oddBinVariance Item Label =
      (Fintype.card Label : ℝ) * (1 - singleParityMean Item Label ^ 2) +
        (Fintype.card Label : ℝ) * ((Fintype.card Label : ℝ) - 1) *
          (pairParityMean Item Label - singleParityMean Item Label ^ 2) := by
  classical
  let z (label : Label) (bins : Item → Label) := binParity bins label - singleParityMean Item Label
  let diag := 1 - singleParityMean Item Label ^ 2
  let off := pairParityMean Item Label - singleParityMean Item Label ^ 2
  have lhs : 4 * oddBinVariance Item Label =
      finiteMean (fun bins : Item → Label => (∑ label : Label, z label bins) ^ 2) := by
    unfold oddBinVariance
    rw [← finiteMean_const_mul]
    apply congrArg finiteMean
    funext bins
    change _ = (∑ label : Label, (binParity bins label - singleParityMean Item Label)) ^ 2
    rw [sum_centered_parities]
    ring
  rw [lhs]
  have expanded (bins : Item → Label) :
      (∑ label : Label, z label bins) ^ 2 = ∑ first : Label, ∑ second : Label, z first bins * z second bins := by
    rw [pow_two, Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro first _
    rw [Finset.mul_sum]
  simp only [expanded, finiteMean_finset_sum]
  have hmean (first second : Label) :
      finiteMean (fun bins => z first bins * z second bins) = if first = second then diag else off := by
    rw [show (fun bins => z first bins * z second bins) =
      (fun bins => (binParity bins first - singleParityMean Item Label) *
        (binParity bins second - singleParityMean Item Label)) from rfl,
      centered_parity_product_mean]
    by_cases h : first = second <;> simp only [h, if_true, if_false, diag, off]
  simp only [hmean]
  have hinner (first : Label) :
      (∑ second : Label, if first = second then diag else off) =
        diag + ((Fintype.card Label : ℝ) - 1) * off := by
    rw [← Finset.sum_erase_add _ _ (Finset.mem_univ first)]
    have hconst : (∑ second ∈ (Finset.univ.erase first), (if first = second then diag else off)) =
        ∑ _second ∈ (Finset.univ.erase first), off := by
      apply Finset.sum_congr rfl
      intro second hsecond
      rw [if_neg (Finset.ne_of_mem_erase hsecond).symm]
    rw [hconst, if_pos rfl]
    simp only [Finset.sum_const, nsmul_eq_mul, Finset.card_erase_of_mem (Finset.mem_univ _), Finset.card_univ,
      Nat.cast_sub (Fintype.card_pos : 1 ≤ Fintype.card Label), Nat.cast_one]
    ring
  simp only [hinner, Finset.sum_const, nsmul_eq_mul, Finset.card_univ, diag, off]
  ring

end TwoColorNullity.Occupancy
