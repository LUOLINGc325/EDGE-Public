import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

namespace CompositeSequentialTestInductionResearchProof1

/-- The exact three-leaf Section 3 example.

We prove, for `a b c ∈ [0,1]` satisfying the two null mean constraints,
that the `Q`-mean is at most `3/25 - c/5`, and hence at most `3/25`.
We also check that the witness `(1/5, 1/5, 0)` is feasible and attains the bound. -/
theorem three_leaf_Q_bound
    (a b c : ℝ) (hc : 0 ≤ c)
    (h1 : (2/5 : ℝ) * a + (1/10 : ℝ) * b + (1/2 : ℝ) * c ≤ 1/10)
    (h2 : (1/10 : ℝ) * a + (2/5 : ℝ) * b + (1/2 : ℝ) * c ≤ 1/10) :
    (3/10 : ℝ) * a + (3/10 : ℝ) * b + (2/5 : ℝ) * c ≤ 3/25 - c/5 ∧
    (3/10 : ℝ) * a + (3/10 : ℝ) * b + (2/5 : ℝ) * c ≤ 3/25 := by
  constructor
  · -- This is exactly the manuscript's averaging of the two null inequalities.
    linarith
  · -- The second bound follows since `c ≥ 0`.
    have hmain : (3/10 : ℝ) * a + (3/10 : ℝ) * b + (2/5 : ℝ) * c ≤ 3/25 - c/5 := by
      linarith
    linarith

/-- The witness test `(1/5, 1/5, 0)` is feasible for both null laws. -/
theorem witness_feasible :
    (2/5 : ℝ) * (1/5) + (1/10 : ℝ) * (1/5) + (1/2 : ℝ) * 0 ≤ 1/10 ∧
    (1/10 : ℝ) * (1/5) + (2/5 : ℝ) * (1/5) + (1/2 : ℝ) * 0 ≤ 1/10 := by
  constructor <;> norm_num

/-- The witness test attains the exact `Q`-mean value `3/25`. -/
theorem witness_Q_eq :
    (3/10 : ℝ) * (1/5) + (3/10 : ℝ) * (1/5) + (2/5 : ℝ) * 0 = 3/25 := by
  norm_num

/-- The witness has entries in `[0,1]`. -/
theorem witness_in_unit :
    (0 : ℝ) ≤ 1/5 ∧ (1/5 : ℝ) ≤ 1 ∧
    (0 : ℝ) ≤ 1/5 ∧ (1/5 : ℝ) ≤ 1 ∧
    (0 : ℝ) ≤ 0 ∧ (0 : ℝ) ≤ 1 := by
  norm_num

end CompositeSequentialTestInductionResearchProof1
