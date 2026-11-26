import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp

namespace GaussianProductAllOrders

/-!
Manuscript equation (4.4) → (2.3) simplification, reproduced as an exact algebraic
identity.

From Section 4 of the manuscript: for `a ≥ 2`, taking `κ = 1/a` in the forward
all-orders bound (4.4)

  U₊(a) ≤ d²/(2(2−κ)) + d²/a² · [ b²/(2κ) + 2/(κ(2−κ)) ]

and simplifying exactly gives

  F_a = d²/4 + 9d²/(4(2a−1)) + b²d²/(2a).

We prove the underlying algebraic equivalence between the right-hand side of
(4.4) at `κ = 1/a` and `F_a` (equation (2.3)). Scope: this is only the exact
finite simplification step; it does not claim the analytic inequality
(4.1) or the choice-of-`t` argument leading to (4.4).
-/

/-- The right-hand side of (4.4) evaluated at `κ = 1/a`, denoted `Gₐ(d, b)`. -/
noncomputable def G (a d b : ℝ) : ℝ :=
  d ^ 2 / (2 * (2 - 1 / a)) + d ^ 2 / a ^ 2 * (b ^ 2 / (2 * (1 / a)) + 2 / ((1 / a) * (2 - 1 / a)))

/-- Equation (2.3): `F_a = d²/4 + 9d²/(4(2a−1)) + b²d²/(2a)`. -/
noncomputable def F (a d b : ℝ) : ℝ :=
  d ^ 2 / 4 + 9 * d ^ 2 / (4 * (2 * a - 1)) + b ^ 2 * d ^ 2 / (2 * a)

/-- Exact algebraic simplification: for `a ≥ 2` (indeed for `a > 1/2`), the
bound (4.4) at `κ = 1/a` coincides with the closed form `F_a` of (2.3). -/
theorem G_eq_F (a d b : ℝ) (ha : 1 / 2 < a) :
    G a d b = F a d b := by
  have ha2 : a ≠ 0 := by linarith
  have h2a1 : 2 * a - 1 ≠ 0 := by linarith
  have h2a : 2 - 1 / a = (2 * a - 1) / a := by
    field_simp
  unfold G F
  rw [h2a]
  field_simp
  ring

/-- Exact simplified form used in the manuscript after "Exact simplification
gives": the three-term expression equals `F_a` verbatim. This records that
`d²a/(2(2a−1)) + 2d²/(2a−1) + b²d²/(2a)` simplifies to (2.3). -/
theorem simplified_form (a d b : ℝ) (ha : 1 / 2 < a) :
    d ^ 2 * a / (2 * (2 * a - 1)) + 2 * d ^ 2 / (2 * a - 1)
        + b ^ 2 * d ^ 2 / (2 * a) = F a d b := by
  have ha2 : a ≠ 0 := by linarith
  have h2a1 : 2 * a - 1 ≠ 0 := by linarith
  unfold F
  field_simp
  ring

end GaussianProductAllOrders
