import Mathlib.Tactic.NormNum
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

namespace OddCyclePauliProductLaw

open scoped BigOperators

private theorem halfProduct {I : Type*} [Fintype I] (f : I → ℝ) :
    (∏ i, f i / 2) = (1 / 2 : ℝ)^Fintype.card I * ∏ i, f i := by
  calc
    (∏ i, f i / 2) = ∏ i, (1 / 2 : ℝ) * f i := by
      apply Finset.prod_congr rfl
      intro i _
      ring
    _ = _ := by rw [Finset.prod_mul_distrib, Finset.prod_const, Finset.card_univ]

/-- The termwise normalization in (1), comparing a sign assignment to its
complement. The product-law normalizers become the common power of 1/2. -/
theorem per_sign_normalized_product_term_abs {I : Type*} [Fintype I] (xi s : I → ℝ) :
    |((∏ i, (1 + s i * xi i) / 2) - ∏ i, (1 - s i * xi i) / 2) / 2| =
      (1 / 2 : ℝ)^Fintype.card I *
        |((∏ i, (1 + s i * xi i)) - ∏ i, (1 - s i * xi i)) / 2| := by
  rw [halfProduct, halfProduct]
  have pull_scale (a b c : ℝ) : (c * a - c * b) / 2 = c * ((a - b) / 2) := by ring
  have h : (0 : ℝ) ≤ (1 / 2 : ℝ)^Fintype.card I :=
    pow_nonneg (show (0 : ℝ) ≤ 1 / 2 by norm_num) _
  rw [pull_scale, abs_mul, abs_of_nonneg h]

end OddCyclePauliProductLaw
