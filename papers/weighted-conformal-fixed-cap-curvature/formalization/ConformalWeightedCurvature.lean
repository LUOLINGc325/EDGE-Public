import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace WeightedConformalFixedCapCurvatureResearchProof1

theorem extremal_weight_curvature {ι : Type*} [DecidableEq ι] (S A : Finset ι) (p D : ι → ℝ) (B : ℝ)
    (hc : (∑ i ∈ S, p i * D i) = 0) :
    (∑ i ∈ S, p i * (if i ∈ A then B else 1) * D i) =
      (B - 1) * (∑ i ∈ S.filter (fun i => i ∈ A), p i * D i) := by
  -- Split the sum over `S` according to membership in `A`.
  have hsplit :
      (∑ i ∈ S, p i * (if i ∈ A then B else 1) * D i) =
        (∑ i ∈ S.filter (fun i => i ∈ A), p i * B * D i) +
        (∑ i ∈ S.filter (fun i => i ∉ A), p i * 1 * D i) := by
    rw [← Finset.sum_filter_add_sum_filter_not S (fun i => i ∈ A)]
    congr 1
    · apply Finset.sum_congr rfl
      intro i hi
      rw [Finset.mem_filter] at hi
      rw [if_pos hi.2]
    · apply Finset.sum_congr rfl
      intro i hi
      rw [Finset.mem_filter] at hi
      rw [if_neg hi.2]
  -- Also split the mean-zero hypothesis.
  have hc_split :
      (∑ i ∈ S.filter (fun i => i ∈ A), p i * D i) +
        (∑ i ∈ S.filter (fun i => i ∉ A), p i * D i) = 0 := by
    rw [← Finset.sum_filter_add_sum_filter_not S (fun i => i ∈ A)] at hc
    exact hc
  -- Rewrite the target sum in terms of the `A`-part plus the complement.
  rw [hsplit]
  -- Simplify the complement sum: `p i * 1 * D i = p i * D i`.
  have hcomp :
      (∑ i ∈ S.filter (fun i => i ∉ A), p i * 1 * D i) =
        (∑ i ∈ S.filter (fun i => i ∉ A), p i * D i) := by
    apply Finset.sum_congr rfl
    intro i _
    ring
  rw [hcomp]
  -- Let `X` be the sum over `A` and `Y` the sum over its complement.
  set X := ∑ i ∈ S.filter (fun i => i ∈ A), p i * D i
  set Y := ∑ i ∈ S.filter (fun i => i ∉ A), p i * D i
  -- Express the `A`-part with the extra factor `B`.
  have hA :
      (∑ i ∈ S.filter (fun i => i ∈ A), p i * B * D i) = B * X := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i _
    ring
  rw [hA]
  -- Now `Y = -X` from the centered hypothesis, and the conclusion is algebraic.
  have hY : Y = -X := by linarith
  rw [hY]
  ring

end WeightedConformalFixedCapCurvatureResearchProof1
