import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace TernaryPairwiseMomentResearchProof1

/-- Complementary-slackness criterion, per label cell.

The global complementary-slackness identity in the manuscript is
`(Aᵀ y − z)ᵀ w = ∑_t gap t * w t = 0`.  Since each summand `gap t * w t` is
nonnegative (both factors are taken nonnegative on the relevant support `s`),
the sum vanishes if and only if every summand does.  A summand with strictly
positive slack `gap i` therefore forces the corresponding unordered label mass
`w i` to be zero.  This is the exact finite complementary-slackness step for
each of the ten unordered label cells `000,...,222`, before any strong-duality
argument is invoked. -/
theorem nonnegative_slack_sum_zero {ι : Type u} (s : Finset ι) (w gap : ι → ℝ)
    (hw : ∀ i ∈ s, 0 ≤ w i) (hg : ∀ i ∈ s, 0 ≤ gap i) :
    (∑ i ∈ s, gap i*w i)=0 ↔ ∀ i ∈ s, 0 < gap i → w i=0 := by
  constructor
  · -- Forward direction: a vanishing sum of nonnegative terms has zero terms.
    intro hsum i hi hpos
    have hnonneg : ∀ j ∈ s, 0 ≤ gap j * w j := by
      intro j hj
      exact mul_nonneg (hg j hj) (hw j hj)
    have hzero : gap i * w i = 0 :=
      (Finset.sum_eq_zero_iff_of_nonneg hnonneg).mp hsum i hi
    rcases mul_eq_zero.mp hzero with h | h
    · exact absurd h (ne_of_gt hpos)
    · exact h
  · -- Backward direction: if all strictly positive slacks have zero mass,
    -- then each summand `gap i * w i` is zero.
    intro h
    apply Finset.sum_eq_zero
    intro i hi
    by_cases hpos : 0 < gap i
    · rw [h i hi hpos]
      ring
    · have hle : gap i ≤ 0 := le_of_not_gt hpos
      have hzero : gap i = 0 := le_antisymm hle (hg i hi)
      rw [hzero]
      ring

end TernaryPairwiseMomentResearchProof1
