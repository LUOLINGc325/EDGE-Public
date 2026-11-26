import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Data.Nat.Choose.Cast
import Mathlib.Tactic.FieldSimp

namespace MomentBayesMinimaxGeometryResearchProof2

/-- Combinatorial factor in 引理 9.1 (60):
`(1/n) * C(n,2) * 2 = n - 1` for every nonempty cardinality `n`.
This is the term `(1/|S|) * binom(|S|,2) * 2 = |S| - 1` arising from the
sum of pairwise squared distances, each contributing `2`. -/
theorem pair_count_offset (n : ℕ) (hn : 0 < n) :
    (1/(n:ℝ))*(n.choose 2 : ℝ)*2 = (n:ℝ)-1 := by
  have hn' : (n:ℝ) ≠ 0 := by exact_mod_cast hn.ne'
  rw [Nat.cast_choose_two]
  field_simp

end MomentBayesMinimaxGeometryResearchProof2
