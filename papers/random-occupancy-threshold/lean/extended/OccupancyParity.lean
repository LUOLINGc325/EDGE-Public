import OddBinIdentity
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Data.Fintype.Pi
import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise

open scoped BigOperators

namespace TwoColorNullity.Occupancy

/-- Average over an explicit uniform finite space. -/
noncomputable def finiteMean {Sample : Type*} [Fintype Sample] (f : Sample → ℝ) : ℝ :=
  (∑ sample : Sample, f sample) / Fintype.card Sample

section MeanAlgebra

variable {Sample : Type*} [Fintype Sample]

theorem finiteMean_const [Nonempty Sample] (c : ℝ) : finiteMean (fun _ : Sample => c) = c := by
  unfold finiteMean
  have h : (Fintype.card Sample : ℝ) ≠ 0 := by exact_mod_cast Fintype.card_ne_zero
  simp only [Finset.sum_const, nsmul_eq_mul, Finset.card_univ]
  field_simp

theorem finiteMean_add (f g : Sample → ℝ) :
    finiteMean (fun x => f x + g x) = finiteMean f + finiteMean g := by
  simp only [finiteMean, Finset.sum_add_distrib, add_div]

theorem finiteMean_const_mul (c : ℝ) (f : Sample → ℝ) :
    finiteMean (fun x => c * f x) = c * finiteMean f := by
  simp only [finiteMean, ← Finset.mul_sum, mul_div_assoc]

theorem finiteMean_mul_const (f : Sample → ℝ) (c : ℝ) :
    finiteMean (fun x => f x * c) = finiteMean f * c := by
  simpa only [mul_comm] using finiteMean_const_mul c f

theorem finiteMean_sub (f g : Sample → ℝ) :
    finiteMean (fun x => f x - g x) = finiteMean f - finiteMean g := by
  simp only [finiteMean, Finset.sum_sub_distrib, sub_div]

theorem finiteMean_div (f : Sample → ℝ) (c : ℝ) :
    finiteMean (fun x => f x / c) = finiteMean f / c := by
  simp only [finiteMean, Finset.sum_div, div_div, mul_comm]

theorem finiteMean_finset_sum {Index : Type*} (indices : Finset Index) (f : Index → Sample → ℝ) :
    finiteMean (fun x => ∑ j ∈ indices, f j x) = ∑ j ∈ indices, finiteMean (f j) := by
  unfold finiteMean
  rw [Finset.sum_comm, Finset.sum_div]

end MeanAlgebra

variable {Item Label : Type*} [Fintype Item] [Fintype Label] [DecidableEq Label]

omit [DecidableEq Label] in
theorem finiteMean_product_coordinates [DecidableEq Item] (f : Item → Label → ℝ) :
    finiteMean (fun bins : Item → Label => ∏ item : Item, f item (bins item)) =
      ∏ item : Item, (∑ label : Label, f item label) / Fintype.card Label := by
  classical
  have hpow : (∏ _ : Item, (Fintype.card Label : ℝ)) = (Fintype.card Label : ℝ) ^ Fintype.card Item := by
    simp
  unfold finiteMean
  rw [← Fintype.prod_sum f, Fintype.card_fun, Nat.cast_pow, ← hpow, ← Finset.prod_div_distrib]

def hitCount (bins : Item → Label) (targets : Finset Label) : ℕ :=
  (Finset.univ.filter fun item => bins item ∈ targets).card

noncomputable def flipSign (targets : Finset Label) (label : Label) : ℝ :=
  if label ∈ targets then -1 else 1

omit [Fintype Label] in
theorem hit_parity_eq_product (bins : Item → Label) (targets : Finset Label) :
    (-1 : ℝ) ^ hitCount bins targets = ∏ item : Item, flipSign targets (bins item) := by
  unfold flipSign hitCount
  rw [Finset.prod_ite]
  simp only [Finset.prod_const, one_pow, mul_one]

theorem sum_flipSign (targets : Finset Label) :
    (∑ label : Label, flipSign targets label) = (Fintype.card Label : ℝ) - 2 * targets.card := by
  have heq (label : Label) :
      flipSign targets label = 1 - (2 : ℝ) * (if label ∈ targets then 1 else 0) := by
    by_cases h : label ∈ targets <;> norm_num [flipSign, h]
  simp only [heq, Finset.sum_sub_distrib, ← Finset.mul_sum, Finset.sum_boole]
  have hf : (Finset.univ.filter fun label => label ∈ targets) = targets := by ext; simp
  rw [hf]
  simp

theorem hit_parity_mean [DecidableEq Item] [Nonempty Label] (targets : Finset Label) :
    finiteMean (fun bins : Item → Label => (-1 : ℝ) ^ hitCount bins targets) =
      (1 - 2 * (targets.card : ℝ) / Fintype.card Label) ^ Fintype.card Item := by
  simp only [hit_parity_eq_product, finiteMean_product_coordinates, sum_flipSign,
    sub_div, Finset.prod_const, Finset.card_univ]
  have h : (Fintype.card Label : ℝ) ≠ 0 := by exact_mod_cast Fintype.card_ne_zero
  rw [div_self h]

theorem bin_parity_mean [DecidableEq Item] [Nonempty Label] (label : Label) :
    finiteMean (fun bins : Item → Label => (-1 : ℝ) ^ binOccupancy bins label) =
      (1 - 2 / (Fintype.card Label : ℝ)) ^ Fintype.card Item := by
  have hcount (bins : Item → Label) : hitCount bins {label} = binOccupancy bins label := by
    simp [hitCount, binOccupancy]
  simpa only [hcount, Finset.card_singleton, Nat.cast_one, mul_one] using
    (hit_parity_mean (Item := Item) ({label} : Finset Label))

theorem cast_mod_two_eq_sign (n : ℕ) :
    ((n % 2 : ℕ) : ℝ) = (1 - (-1 : ℝ) ^ n) / 2 := by
  have h : (-1 : ℝ) ^ n = (-1 : ℝ) ^ (n % 2) := by
    conv_lhs => rw [← Nat.div_add_mod n 2]
    rw [pow_add, pow_mul]
    norm_num
  rw [h]
  have hn : n % 2 = 0 ∨ n % 2 = 1 := by omega
  rcases hn with hzero | hone
  · rw [hzero]
    norm_num
  · rw [hone]
    norm_num

theorem oddBinCount_mean [DecidableEq Item] [Nonempty Label] :
    finiteMean (fun bins : Item → Label => (oddBinCount bins : ℝ)) =
      (Fintype.card Label : ℝ) / 2 *
        (1 - (1 - 2 / (Fintype.card Label : ℝ)) ^ Fintype.card Item) := by
  simp only [oddBinCount, Nat.cast_sum, cast_mod_two_eq_sign, finiteMean_finset_sum,
    finiteMean_div, finiteMean_sub, finiteMean_const, bin_parity_mean]
  simp only [Finset.sum_const, nsmul_eq_mul, Finset.card_univ]
  ring

end TwoColorNullity.Occupancy
