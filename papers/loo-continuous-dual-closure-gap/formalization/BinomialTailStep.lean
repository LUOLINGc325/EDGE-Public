import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace LooContinuousDualClosureGapResearchProof1

/-- Binary-step telescoping identity (Equation (4)) for the binomial tail recursion.

The previous success count is `s`, the next pair indicator is `y` (so the increment is
`j = if y then 1 else 0`), and the next-stage tail function is `H`. The corresponding
one-step update `(1-v) * H s + v * H (s+1)` differs from `H (s+j)` by exactly
`((j:ℝ) - v) * (H (s+1) - H s)`. Both binary outcomes `y = false` and `y = true`
are covered by the single `Bool` binder. -/
theorem binomial_tail_increment (H : ℕ → ℝ) (v : ℝ) (s : ℕ) (y : Bool) :
    let j : ℕ := if y then 1 else 0
    H (s + j) - ((1 - v) * H s + v * H (s + 1)) =
      ((j : ℝ) - v) * (H (s + 1) - H s) := by
  cases y
  · -- y = false, hence j = 0 and the left coordinate is H s
    simp only [Bool.false_eq_true, if_false, Nat.cast_zero]
    ring
  · -- y = true, hence j = 1 and the left coordinate is H (s + 1)
    simp only [if_true, Nat.cast_one]
    ring

end LooContinuousDualClosureGapResearchProof1
