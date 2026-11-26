import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace SlackNullInductionComplexityResearchProof1

theorem terminal_ceiling_expectation {ι : Type*} [DecidableEq ι] (L Z : Finset ι)
    (w f : ι → ℝ) (h : 0 < ∑ i ∈ L, w i) :
    (∑ i ∈ L, w i * (if i ∈ Z then f i else 1)) / (∑ i ∈ L, w i) =
      1 - (∑ i ∈ L.filter (fun i => i ∈ Z), w i * (1 - f i)) / (∑ i ∈ L, w i) := by
  have hparts :
      (∑ i ∈ L, w i * (if i ∈ Z then f i else 1)) =
        (∑ i ∈ L, w i) - ∑ i ∈ L.filter (fun i => i ∈ Z), w i * (1-f i) := by
    rw [Finset.sum_filter, ← Finset.sum_sub_distrib]
    apply Finset.sum_congr rfl
    intro i _
    by_cases hi : i ∈ Z
    · simp only [if_pos hi]
      ring
    · simp [hi]
  rw [hparts, sub_div, div_self h.ne']

end SlackNullInductionComplexityResearchProof1
