import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

/-!
Section 3 of the manuscript: exact determinant decomposition of the 2x2
Hermitian matrix

  M = [[4X+3Y-2U,      -X-2Y+3U-5 i V],
       [-X-2Y+3U+5 i V, 3X+6Y-4U        ]]

with X, Y, U, V real.  The printed identity is

  det M = 25 (XY - U^2 - V^2) + 24 (U - X/3 - Y/4)^2
          + (25/3) X^2 + (25/2) Y^2 .

We encode `det M` as the real value `reDetM` (since the off-diagonal
entries are conjugate, the determinant is real).  We prove the exact
decomposition, the nonnegativity consequence, and the quadratic lower
bound det M ≥ (25/6)(X+Y)^2 under the contraction hypothesis
U^2 + V^2 ≤ X Y with X, Y ≥ 0.

Coverage limits: this file formalizes only the algebraic determinant
identities and lower bound from Section 3.  It does not touch the actual
Rényi operator, group moments, or any equality classification.
-/

namespace OrderSevenSharpErasureResearchProof1

/-- Real value of the determinant of the manuscript's 2x2 matrix `M`. -/
noncomputable def reDetM (X Y U V : ℝ) : ℝ :=
  (4 * X + 3 * Y - 2 * U) * (3 * X + 6 * Y - 4 * U)
    - ((-X - 2 * Y + 3 * U) * (-X - 2 * Y + 3 * U) + (5 * V) * (5 * V))

/-- The exact determinant decomposition from Section 3. -/
theorem detM_decomposition (X Y U V : ℝ) :
    reDetM X Y U V =
      25 * (X * Y - U ^ 2 - V ^ 2)
        + 24 * (U - X / 3 - Y / 4) ^ 2
        + (25 / 3 : ℝ) * X ^ 2
        + (25 / 2 : ℝ) * Y ^ 2 := by
  unfold reDetM
  ring

/-- Positivity consequence: if `X ≥ 0`, `Y ≥ 0`, and `U^2 + V^2 ≤ X Y`,
then the determinant of `M` is nonnegative. -/
theorem detM_nonneg (X Y U V : ℝ)
    (hUV : U ^ 2 + V ^ 2 ≤ X * Y) :
    0 ≤ reDetM X Y U V := by
  rw [detM_decomposition]
  have h1 : 0 ≤ 25 * (X * Y - U ^ 2 - V ^ 2) := by nlinarith
  have h2 : 0 ≤ 24 * (U - X / 3 - Y / 4) ^ 2 := by positivity
  have h3 : 0 ≤ (25 / 3 : ℝ) * X ^ 2 := by positivity
  have h4 : 0 ≤ (25 / 2 : ℝ) * Y ^ 2 := by positivity
  linarith

/-- The determinant lower bound of Section 3 under the Gram constraint. -/
theorem detM_lower_bound (X Y U V : ℝ)
    (hUV : U ^ 2 + V ^ 2 ≤ X * Y) :
    (25 / 6 : ℝ) * (X + Y) ^ 2 ≤ reDetM X Y U V := by
  rw [detM_decomposition]
  nlinarith [sq_nonneg (U - X / 3 - Y / 4), sq_nonneg (X - Y),
    sq_nonneg (X + Y), sq_nonneg V, sq_nonneg U,
    sq_nonneg Y, hUV]

end OrderSevenSharpErasureResearchProof1
