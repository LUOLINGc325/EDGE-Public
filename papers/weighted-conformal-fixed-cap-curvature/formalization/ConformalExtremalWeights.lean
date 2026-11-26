import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace WeightedConformalFixedCapCurvatureResearchProof1

/-- Reciprocal-weight expectation for endpoint (1/B) extremal weights on a region `A`.

Source bridge: in equation (3), with conditional weight `B` on the maximizing set `A`
and weight `1` elsewhere, one has `E_Q(1/w) = 1 - (1 - 1/B) * Q(A)`.  Here `p i` is the
`Q`-mass of atom `i`, `S` is the finite support with total mass one, and `A` is the
extremal region.  This covers empty `A` and the degenerate cap `B = 1`. -/
theorem extremal_weight_reciprocal {ι : Type*} [DecidableEq ι]
    (S A : Finset ι) (p : ι → ℝ) (B : ℝ) (hB : 1 ≤ B)
    (ht : (∑ i ∈ S, p i) = 1) :
    (∑ i ∈ S, p i / (if i ∈ A then B else 1)) =
      1 - (1 - 1 / B) * (∑ i ∈ S.filter (fun i => i ∈ A), p i) := by
  have hBne : B ≠ 0 := by linarith
  have hterm (i : ι) : p i / (if i ∈ A then B else 1) =
      p i - (1-1/B)*(if i ∈ A then p i else 0) := by
    by_cases hi : i ∈ A
    · simp only [if_pos hi]
      field_simp
      ring
    · simp [hi]
  simp_rw [hterm]
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.sum_filter, ht]

end WeightedConformalFixedCapCurvatureResearchProof1
