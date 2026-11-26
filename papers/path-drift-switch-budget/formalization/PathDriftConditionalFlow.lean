import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset

universe u
open scoped BigOperators
namespace PathDriftSwitchBudgetResearchProof1

theorem conditional_flow_preserves_marginals {ι : Type u} [Fintype ι]
         (p next : ι → ℝ) (joint fallback : ι → ι → ℝ)
         (hnn : ∀ i j, 0 ≤ joint i j) (rows : ∀ i, ∑ j, joint i j = p i)
         (cols : ∀ j, ∑ i, joint i j = next j) :
         (∀ i j, p i*(if 0 < p i then joint i j/p i else fallback i j) = joint i j) ∧
         (∀ j, ∑ i, p i*(if 0 < p i then joint i j/p i else fallback i j) = next j) := by
  have preserve (i j : ι) :
      p i*(if 0 < p i then joint i j/p i else fallback i j) = joint i j := by
    by_cases hp : 0 < p i
    · rw [if_pos hp]
      field_simp [ne_of_gt hp]
    · rw [if_neg hp]
      have hrow : 0 ≤ p i := rows i ▸ Finset.sum_nonneg (fun j _ => hnn i j)
      have hzero : p i = 0 := le_antisymm (le_of_not_gt hp) hrow
      have hentry : joint i j ≤ p i := by
        rw [← rows i]
        exact Finset.single_le_sum (fun j' _ => hnn i j') (Finset.mem_univ j)
      rw [hzero, zero_mul]
      exact (le_antisymm (hzero ▸ hentry) (hnn i j)).symm
  refine ⟨preserve, ?_⟩
  intro j
  simpa only [preserve] using cols j

end PathDriftSwitchBudgetResearchProof1
