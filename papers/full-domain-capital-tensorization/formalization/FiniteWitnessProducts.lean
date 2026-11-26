import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.Prod
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace FullDomainCapitalTensorization

open Finset

/-- Exact finite witness multiplication identity for the product law (Section 3):
the total weighted payoff over the product grid factors as a product of the
one-block weighted sums. -/
theorem sum_prod_weighted_mul {ι κ : Type*} [Fintype ι] [Fintype κ]
    (f : ι → ℝ) (g : κ → ℝ) (p : ι → ℝ) (q : κ → ℝ) :
    (∑ ij : ι × κ, (p ij.1 * q ij.2) * (f ij.1 * g ij.2)) =
      (∑ i, p i * f i) * (∑ j, q j * g j) := by
  rw [Fintype.sum_prod_type]
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl ?_
  intro i _
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl ?_
  intro j _
  ring

/-- Two-block cap: under one-sided nonnegativity and when both weighted factors are bounded by their
block cap, then the product-total is bounded by the product of the block caps. -/
theorem two_block_cap_le_mul {A B : ℝ}
    (hA : 0 ≤ A)
    {a b : ℝ} (hb : 0 ≤ b)
    (hacap : a ≤ A) (hbcap : b ≤ B) :
    a * b ≤ A * B := by
  have h1 : a * b ≤ A * b := mul_le_mul_of_nonneg_right hacap hb
  have h2 : A * b ≤ A * B := mul_le_mul_of_nonneg_left hbcap hA
  linarith

end FullDomainCapitalTensorization
