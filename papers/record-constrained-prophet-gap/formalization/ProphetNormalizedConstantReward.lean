import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace RecordConstrainedProphetGapResearchProof3

/-- The section 4 normalized ordered nonnegative domain is nonempty: the all-ones
reward vector lies in it, provided the label masses `p` in (8) are normalized.

This is the child obligation of the frozen card (the "normalized domain is
nonempty" statement of Section 4, preceding (9)).  Witness: `v ≡ 1`.

Remaining dependencies of the parent Lemma 3 / formula (9) not covered here are
reported as a comment only:
* compactness of the normalized ordered domain (`v_j ≤ v_m ≤ 1/p_m`);
* continuity of the strict/weak Bellman values `S`, `T` in `v` and existence of
  the minima `a_{n,m}`, `b_{n,m}` in (9);
* homogeneity `S(v) ≥ a_{n,m} P_{n,m}(v)`;
* the ordering `0 ≤ a_{n,m} ≤ b_{n,m} ≤ 1`.
None of these is proved below; only nonemptiness of the ambient domain is. -/
theorem normalized_constant_reward (m : ℕ) (p : ℕ → ℝ)
    (hp : (∑ j ∈ Finset.range m, p j) = 1) :
    ∃ v : ℕ → ℝ, (∀ j k, j ≤ k → 0 ≤ v j ∧ v j ≤ v k) ∧
      (∑ j ∈ Finset.range m, p j * v j) = 1 := by
  refine ⟨fun _ => 1, ?_, ?_⟩
  · intro j k _
    refine ⟨?_, ?_⟩
    · norm_num
    · norm_num
  · simpa using hp

end RecordConstrainedProphetGapResearchProof3
