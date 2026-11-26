import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace ReversibleMarkovWeakResponse

/-- The transverse-mode threshold `max 0 (|β| - α)`. -/
noncomputable def modeBound (α β : ℝ) : ℝ := max 0 (|β| - α)

/-- **Exact scalar transverse mode criterion (normal case of Theorem 1).**
For `α > 0` and `x ≥ 0`, the quadratic transverse form is nonnegative
exactly when the speed scale `x` dominates the threshold `max 0 (|β| - α)`. -/
theorem transverse_mode_criterion
    (α x β : ℝ) (hα : 0 < α) (hx : 0 ≤ x) :
    (0 ≤ (α + x) ^ 2 - β ^ 2) ↔ modeBound α β ≤ x := by
  rw [modeBound, max_le_iff]
  constructor
  · intro h
    refine ⟨hx, ?_⟩
    -- `|β| - α ≤ x` follows from `β ^ 2 ≤ (α + x) ^ 2`.
    have hβ : β ^ 2 ≤ (α + x) ^ 2 := by linarith
    have hsum : α + x ≥ 0 := by linarith
    have habs : |β| ≤ α + x := by
      nlinarith [abs_nonneg β, sq_abs β, sq_nonneg (α + x),
        sq_nonneg (|β| - (α + x))]
    linarith
  · rintro ⟨_, hβx⟩
    have hβ : |β| ≤ α + x := by linarith [abs_nonneg β, hα]
    have hsq : β ^ 2 ≤ (α + x) ^ 2 := by
      nlinarith [abs_nonneg β, sq_abs β, sq_nonneg (α + x), hβ]
    linarith

/-- **Strict positivity above the threshold.**
If `x > max 0 (|β| - α)` then the transverse form is strictly positive. -/
theorem transverse_mode_strict
    (α x β : ℝ) (hα : 0 < α) (hx : modeBound α β < x) :
    0 < (α + x) ^ 2 - β ^ 2 := by
  rw [modeBound, max_lt_iff] at hx
  obtain ⟨hx0, hβx⟩ := hx
  have hβ : |β| < α + x := by linarith [abs_nonneg β, hα]
  have hsq : β ^ 2 < (α + x) ^ 2 := by
    nlinarith [abs_nonneg β, sq_abs β, hβ, hα]
  linarith

end ReversibleMarkovWeakResponse
