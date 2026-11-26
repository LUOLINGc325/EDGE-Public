import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Ring.Finset

universe u
open scoped BigOperators
namespace HardBudgetCovarianceFourthMomentResearchProof1

theorem paired_fourth_moment {ι : Type u} (support : Finset ι) (p x : ι → ℝ)
         (mass : (∑ i ∈ support, p i) = 1)
         (center : (∑ i ∈ support, p i*x i) = 0) :
         (∑ i ∈ support, ∑ j ∈ support, p i*p j*(x i-x j)^4/4)
         = (∑ i ∈ support, p i*(x i)^4)/2 + (3/2 : ℝ)*(∑ i ∈ support, p i*(x i)^2)^2 := by
  let Q := fun k : ℕ => fun i => p i*(x i)^k
  have factored (s t : ℕ) :
      (∑ i ∈ support, ∑ j ∈ support, Q s i*Q t j) =
        (∑ i ∈ support, Q s i)*(∑ j ∈ support, Q t j) := by
    rw [Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro i _
    rw [Finset.mul_sum]
  have polyn (i j : ι) :
      p i*p j*(x i-x j)^4/4 =
        (1/4:ℝ)*(Q 4 i*Q 0 j) - Q 3 i*Q 1 j + (3/2:ℝ)*(Q 2 i*Q 2 j) -
        Q 1 i*Q 3 j + (1/4:ℝ)*(Q 0 i*Q 4 j) := by
    dsimp only [Q]
    ring
  simp_rw [polyn]
  simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, factored]
  dsimp only [Q]
  simp only [pow_zero, pow_one, mul_one, mass, center, mul_zero, zero_mul, add_zero, sub_zero]
  simp only [Finset.sum_const_zero, ← Finset.sum_mul, ← Finset.mul_sum,
    mass, center, mul_one, one_mul, mul_zero, zero_mul, sub_zero, add_zero]
  ring

end HardBudgetCovarianceFourthMomentResearchProof1
