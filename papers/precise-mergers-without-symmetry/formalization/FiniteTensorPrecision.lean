import PositivePartMerger
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Ring

namespace PreciseMergersWithoutSymmetry

open scoped BigOperators

private theorem positive_negative_difference (t : ℝ) :
    posPart (t - 1) - posPart (1 - t) = t - 1 := by
  unfold posPart
  by_cases h : t ≤ 1
  · rw [max_eq_left (sub_nonpos.mpr h), max_eq_right (sub_nonneg.mpr h)]
    ring
  · have h' : 1 ≤ t := le_of_lt (lt_of_not_ge h)
    rw [max_eq_right (sub_nonneg.mpr h'), max_eq_left (sub_nonpos.mpr h'), sub_zero]

/-- Finite weighted balance of the two parts of a centered score. -/
theorem centered_parts_balance {A : Type*} [Fintype A] (p x : A → ℝ)
    (h : ∑ a, p a * x a = ∑ a, p a) :
    (∑ a, p a * posPart (x a - 1)) = ∑ a, p a * posPart (1 - x a) := by
  apply sub_eq_zero.mp
  rw [← Finset.sum_sub_distrib]
  have heq (a : A) :
      p a * posPart (x a - 1) - p a * posPart (1 - x a) = p a * x a - p a := by
    rw [← mul_sub, positive_negative_difference]
    ring
  simp_rw [heq, Finset.sum_sub_distrib, h, sub_self]

/-- Equation (3) has expectation one under any finite independent product of
mean-one inputs. The weights in each coordinate sum to one. -/
theorem product_correction_finite_precision
    {I : Type*} [Fintype I] [DecidableEq I]
    {A : I → Type*} [∀ i, Fintype (A i)]
    (p x : ∀ i, A i → ℝ) (lam : ℝ)
    (mass : ∀ i, ∑ a, p i a = 1)
    (mean : ∀ i, ∑ a, p i a * x i a = 1) :
    (∑ y : ∀ i, A i, (∏ i, p i (y i)) * M lam (fun i => x i (y i))) = 1 := by
  let w (y : ∀ i, A i) : ℝ := ∏ i, p i (y i)
  let plus (y : ∀ i, A i) : ℝ := ∏ i, posPart (x i (y i) - 1)
  let minus (y : ∀ i, A i) : ℝ := ∏ i, posPart (1 - x i (y i))
  have base : (∑ y, w y) = 1 := by
    rw [show (∑ y, w y) = ∏ i, ∑ a, p i a from (Fintype.prod_sum p).symm]
    simp [mass]
  have factor (f : ∀ i, A i → ℝ) :
      (∑ y, w y * (∏ i, f i (y i))) = ∏ i, ∑ a, p i a * f i a := by
    simp only [w, ← Finset.prod_mul_distrib]
    exact (Fintype.prod_sum (fun i a => p i a * f i a)).symm
  have balance : (∑ y, w y * plus y) = ∑ y, w y * minus y := by
    change (∑ y, w y * (∏ i, posPart (x i (y i) - 1))) =
      ∑ y, w y * (∏ i, posPart (1 - x i (y i)))
    rw [factor (fun i a => posPart (x i a - 1)),
      factor (fun i a => posPart (1 - x i a))]
    apply Finset.prod_congr rfl
    intro i _
    exact centered_parts_balance (p i) (x i) ((mean i).trans (mass i).symm)
  change (∑ y, w y * (1 + lam * (plus y - minus y))) = 1
  have expand (y : ∀ i, A i) :
      w y * (1 + lam * (plus y - minus y)) =
        w y + lam * (w y * plus y - w y * minus y) := by ring
  simp_rw [expand, Finset.sum_add_distrib, ← Finset.mul_sum, Finset.sum_sub_distrib,
    base, balance, sub_self, mul_zero, add_zero]

end PreciseMergersWithoutSymmetry
