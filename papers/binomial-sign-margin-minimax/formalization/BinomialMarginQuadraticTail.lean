import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.Order.BigOperators.Group.Finset

universe u
open scoped BigOperators
namespace BinomialSignMarginMinimaxResearchProof1

theorem quadratic_moment_tail (n d : ℕ) (lam h : ℝ) (delta : ℕ → ℝ)
         (hlam : 0 ≤ lam) (hh : 0 ≤ h)
         (hzero : ∀ j ≤ d, delta j = 0)
         (habs : ∀ j, d < j → |delta j| ≤ 2*lam*h^j) :
         (∑ j ∈ Finset.range (n+1), (n.choose j : ℝ)*(delta j)^2) ≤
         4*lam^2*(∑ j ∈ (Finset.range (n+1)).filter (fun j => d < j), (n.choose j : ℝ)*h^(2*j)) := by
  rw [Finset.sum_filter, Finset.mul_sum]
  apply Finset.sum_le_sum
  intro j _
  by_cases hj : d < j
  · simp only [hj, if_true]
    have hnonneg : 0 ≤ 2*lam*h^j := mul_nonneg (mul_nonneg (by norm_num) hlam) (pow_nonneg hh _)
    have hbound : (delta j)^2 ≤ (2*lam*h^j)^2 := by
      calc
        (delta j)^2 = |delta j|^2 := (sq_abs _).symm
        _ ≤ |2*lam*h^j|^2 := by
          rw [abs_of_nonneg hnonneg]
          exact pow_le_pow_left₀ (abs_nonneg _) (habs j hj) 2
        _ = _ := sq_abs _
    have hweight : (0:ℝ) ≤ (n.choose j : ℝ) := Nat.cast_nonneg _
    calc
      (n.choose j : ℝ)*(delta j)^2 ≤ (n.choose j : ℝ)*(2*lam*h^j)^2 :=
        mul_le_mul_of_nonneg_left hbound hweight
      _ = 4*lam^2*((n.choose j : ℝ)*h^(2*j)) := by
        rw [Nat.mul_comm 2 j, pow_mul]
        ring
  · simp [hj, hzero j (Nat.le_of_not_gt hj)]

end BinomialSignMarginMinimaxResearchProof1
