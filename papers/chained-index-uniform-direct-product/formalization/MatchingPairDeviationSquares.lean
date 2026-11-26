import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset

universe u
open scoped BigOperators
namespace ChainedIndexUniformDirectProductResearchProof1

theorem pair_deviation_squares {ι : Type u} (indices : Finset ι) (a b : ι → ℝ) (mean : ℝ) :
         (∑ i ∈ indices, (a i - b i)^2) ≤ 2*(∑ i ∈ indices, ((a i - mean)^2+(b i - mean)^2)) := by
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i _
  nlinarith only [sq_nonneg (a i + b i - 2*mean)]

end ChainedIndexUniformDirectProductResearchProof1
