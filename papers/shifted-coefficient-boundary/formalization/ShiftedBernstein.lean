import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

/-!
Source: `cases/qubit-cooling-bernstein-certificate/supplements/
shifted-coefficient-boundary/README.md`, section "复算／推导".

With `m = 19`, `n = (15,3,1)` and

  `G(r) = (18/19)(15 + 3r + r²) − (1+r)(5/2 + 3r/4)`,

the manuscript records the cleared rational identity

  `684·G(r) = 8010 − 279r + 135r²`,

and, substituting `r = 1 + z`,

  `684·G(1+z) = 7866 − 9z + 135z²`.

Below we formalize these exact algebraic statements over `ℝ`, together with
the completion-of-the-square decomposition

  `135 z² − 9 z + 7866 = 135·(z − 1/30)² + (7866 − 3/20)`

and the resulting strict positivity on `ℝ`. The `z`-linear coefficient is
negative (`−9`), but the shifted quadratic is strictly positive, showing that
termwise nonnegativity of shifted coefficients is only sufficient, not
necessary. We do not assert anything about Bernstein coefficients of `G`.
-/

namespace ShiftedCoefficientBoundaryResearchProof1

/-- The shell-capacity polynomial of the manuscript, over `ℝ`. -/
noncomputable def G (r : ℝ) : ℝ :=
  (18 / 19) * (15 + 3 * r + r ^ 2) - (1 + r) * (5 / 2 + 3 * r / 4)

/-- Cleared identity: `684·G(r) = 8010 − 279r + 135r²`. -/
theorem G_cleared (r : ℝ) :
    (684 : ℝ) * G r = 8010 - 279 * r + 135 * r ^ 2 := by
  unfold G
  ring

/-- Shifted form: substituting `r = 1 + z` gives
`684·G(1+z) = 7866 − 9z + 135z²`. -/
theorem G_shifted (z : ℝ) :
    (684 : ℝ) * G (1 + z) = 7866 - 9 * z + 135 * z ^ 2 := by
  unfold G
  ring

/-- The shifted linear coefficient is negative. -/
theorem shifted_linear_coeff_neg : (-9 : ℚ) < 0 := by
  norm_num

/-- The shifted discriminant `81 − 4·135·7866` is negative. -/
theorem shifted_discriminant_neg :
    (81 : ℚ) - 4 * 135 * 7866 < 0 := by
  norm_num

/-- Completion of the square with exact coefficients:
`135 z² − 9 z + 7866 = 135·(z − 1/30)² + (7866 − 3/20)`. -/
theorem shifted_complete_square (z : ℝ) :
    135 * z ^ 2 - 9 * z + 7866
      = 135 * (z - 1 / 30) ^ 2 + (7866 - 3 / 20) := by
  ring

/-- The shifted quadratic is strictly positive on all of `ℝ`. -/
theorem shifted_quadratic_pos (z : ℝ) :
    (0 : ℝ) < 7866 - 9 * z + 135 * z ^ 2 := by
  have h : 7866 - 9 * z + 135 * z ^ 2
      = 135 * (z - 1 / 30) ^ 2 + (7866 - 3 / 20) := by
    ring
  rw [h]
  have hsq : (0 : ℝ) ≤ (z - 1 / 30) ^ 2 := sq_nonneg _
  nlinarith

/-- The original shell-capacity polynomial is strictly positive at every real radius. -/
theorem G_pos (r : ℝ) : 0 < G r := by
  have h := G_shifted (r - 1)
  have hsum : 1 + (r - 1) = r := by ring
  rw [hsum] at h
  linarith [shifted_quadratic_pos (r - 1)]

end ShiftedCoefficientBoundaryResearchProof1
