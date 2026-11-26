import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace RecordConstrainedProphetGapResearchProof3

/-- Compactness input of §4: from the nonnegative normalized weighted sum
`∑ p j * v j = 1`, together with `0 ≤ v j ≤ v (m-1)`, `0 ≤ p j`, `p (m-1) > 0`,
every coordinate obeys `v j ≤ 1 / p (m-1)`.
The upper bound on the maximum coordinate follows by lower-bounding the sum
by the single term `p (m-1) * v (m-1)`. -/
theorem normalized_reward_bound (m : ℕ) (p v : ℕ → ℝ) (hm : 0 < m)
    (hp : ∀ j ∈ Finset.range m, 0 ≤ p j)
    (hv : ∀ j ∈ Finset.range m, 0 ≤ v j ∧ v j ≤ v (m-1))
    (hlast : 0 < p (m-1)) (hmean : (∑ j ∈ Finset.range m, p j * v j) = 1) :
    ∀ j ∈ Finset.range m, v j ≤ 1 / p (m-1) := by
  intro j hj
  have hm1 : m - 1 < m := Nat.sub_one_lt (Nat.ne_of_gt hm)
  have hle : p (m-1) * v j ≤ ∑ k ∈ Finset.range m, p k * v k := by
    have hnonneg : ∀ k ∈ Finset.range m, 0 ≤ p k * v k := by
      intro k hk
      exact mul_nonneg (hp k hk) (hv k hk).1
    have hmem : m - 1 ∈ Finset.range m := Finset.mem_range.mpr hm1
    have hvj : v j ≤ v (m-1) := (hv j hj).2
    have hterm : p (m-1) * v j ≤ p (m-1) * v (m-1) :=
      mul_le_mul_of_nonneg_left hvj (le_of_lt hlast)
    calc p (m-1) * v j ≤ p (m-1) * v (m-1) := hterm
      _ ≤ ∑ k ∈ Finset.range m, p k * v k :=
          Finset.single_le_sum hnonneg hmem
  rw [hmean] at hle
  exact (le_div_iff₀ hlast).mpr (by linarith)

end RecordConstrainedProphetGapResearchProof3
