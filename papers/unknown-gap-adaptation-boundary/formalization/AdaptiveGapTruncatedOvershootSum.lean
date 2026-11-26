import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace UnknownGapAdaptationBoundaryResearchProof3

/-- Bounded-time overshoot summation: if each term `E i` is bounded by `3 * p i`
and the crossing probabilities `p i` sum to at most `1` over `range N`, then the
total expected overshoot up to time `N` is at most `3`. -/
theorem truncated_overshoot_sum (N : ℕ) (E p : ℕ → ℝ)
    (he : ∀ i ∈ Finset.range N, E i ≤ 3*p i) (hp : (∑ i ∈ Finset.range N, p i) ≤ 1) :
    (∑ i ∈ Finset.range N, E i) ≤ 3 := by
  calc
    (∑ i ∈ Finset.range N, E i) ≤ ∑ i ∈ Finset.range N, 3 * p i :=
      Finset.sum_le_sum he
    _ = 3 * ∑ i ∈ Finset.range N, p i := (Finset.mul_sum ..).symm
    _ ≤ 3 := by linarith

end UnknownGapAdaptationBoundaryResearchProof3
