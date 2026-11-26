import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

namespace MomentBayesMinimaxGeometryResearchProof1

/-- Exact one-direction (both directions) Schur complement equivalence for a scalar
quadratic form `s ↦ t*s^2 + 2*b*s + c` with `t > 0`:
this quadratic is nonnegative for all `s` iff `c - b^2/t ≥ 0`. -/
theorem scalar_schur_complement (t b c : ℝ) (ht : 0 < t) :
         (∀ s : ℝ, 0 ≤ t*s^2+2*b*s+c) ↔ 0 ≤ c-b^2/t := by
  constructor
  · intro h
    -- Evaluate at the minimizer s = -b/t, where the quadratic attains c - b^2/t.
    have h1 := h (-b/t)
    have htne : t ≠ 0 := ne_of_gt ht
    have key : t*(-b/t)^2 + 2*b*(-b/t) + c = c - b^2/t := by
      field_simp
      ring
    linarith [key ▸ h1]
  · intro h s
    -- Complete the square: t*s^2 + 2bs + c = t*(s + b/t)^2 + (c - b^2/t).
    have htne : t ≠ 0 := ne_of_gt ht
    have hsq : 0 ≤ t*(s + b/t)^2 := by positivity
    have key : t*s^2 + 2*b*s + c = t*(s + b/t)^2 + (c - b^2/t) := by
      field_simp
      ring
    linarith [key ▸ (add_nonneg hsq h)]

end MomentBayesMinimaxGeometryResearchProof1
