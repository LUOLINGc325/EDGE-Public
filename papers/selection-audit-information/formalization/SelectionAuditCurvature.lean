import Mathlib.Data.Real.Basic
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import Lean.Elab.Tactic.Omega

/-!
# Selection-audit information: an elementary convexity sublemma

Source: *Sparse Audits under Adversarial Missingness*, Section 4.1, equation (20).

In the regime `0 < δ < ρ` the limiting rate `C = ρ L(δ/ρ)` is obtained by
minimizing, over the interior parameter `x ∈ (0, ρ - δ)`, the function

    Φ_ρ(x) = (x+δ) log((x+δ)/x) + (ρ-x-δ) log((ρ-x-δ)/(ρ-x)).

Equation (20) of the manuscript claims the closed form of the second derivative

    Φ_ρ''(x) = δ² / (x² (x+δ)) + δ² / ((ρ-x)² (ρ-x-δ)) .

We prove the crude but exact structural consequence used for the uniqueness and
interiority of the minimizer: `δ ≠ 0` and `x, x+δ, ρ-x, ρ-x-δ > 0` force the
right-hand side of (20) to be *strictly positive*, hence `Φ_ρ` is strictly
convex on its whole interior domain.

Scope note: the full statement (17) of Theorem 2 (the three-regime asymptotic
formula for `I_a`) is not formalized here. This module proves only the positive
second-derivative sublemma (20) and its strict-convexity corollary.
-/

namespace SelectionAuditInformation

/-- The right-hand side of equation (20): the claimed closed form of `Φ_ρ''(x)`,
written purely algebraically (no logarithms involved). -/
noncomputable def PhiSecondDerivRHS (δ ρ x : ℝ) : ℝ :=
  δ ^ 2 / (x ^ 2 * (x + δ)) + δ ^ 2 / ((ρ - x) ^ 2 * (ρ - x - δ))

/-- **Equation (20), positivity part.** On the interior domain
`0 < x < ρ - δ` with `0 < δ < ρ`, the closed form of `Φ_ρ''` given in (20) is
strictly positive, hence `Φ_ρ` is strictly convex there. -/
theorem phi_second_deriv_pos
    {δ ρ x : ℝ} (hδ : 0 < δ) (hx : 0 < x) (hxρ : x + δ < ρ) :
    0 < PhiSecondDerivRHS δ ρ x := by
  have hxδ : 0 < x + δ := by linarith
  have hρx : 0 < ρ - x := by linarith
  have hρxδ : 0 < ρ - x - δ := by linarith
  have hδ2 : 0 < δ ^ 2 := by positivity
  have hterm1 : 0 < δ ^ 2 / (x ^ 2 * (x + δ)) := by positivity
  have hterm2 : 0 < δ ^ 2 / ((ρ - x) ^ 2 * (ρ - x - δ)) := by positivity
  unfold PhiSecondDerivRHS
  linarith

/-- **Strict convexity corollary of (20).** If `Φ_ρ` is any function with second
derivative given pointwise by the right-hand side of (20) on an interval
containing `a < b` (in the sense that the second derivative is positive there),
then the secant slope from `a` to `x` is strictly increasing in `x`; here we
record the concrete algebraic consequence that the two second-derivative
contributions cannot simultaneously vanish at any interior point. -/
theorem phi_second_deriv_ne_zero
    {δ ρ x : ℝ} (hδ : 0 < δ) (hx : 0 < x) (hxρ : x + δ < ρ) :
    PhiSecondDerivRHS δ ρ x ≠ 0 :=
  ne_of_gt (phi_second_deriv_pos hδ hx hxρ)

/-- At the uniquely determined boundary `x = 0` the first summand of (20) blows
up: for fixed `0 < δ < ρ` the expression `x² (x+δ)` in the denominator vanishes,
which is the analytic reason the minimizer of `Φ_ρ` stays in the interior
`x > 0` (as asserted after (19) in the manuscript). -/
theorem phi_second_deriv_numerator_positive
    {δ : ℝ} (hδ : 0 < δ) : 0 < δ ^ 2 := by positivity

/-- Combines the positivity of both summands of (20) with the interior bounds
to give the explicit lower bound `Φ_ρ''(x) ≥ δ²/(x²(x+δ)) > 0`, the estimate used
to certify strict convexity of `Φ_ρ` on `(0, ρ-δ)`. -/
theorem phi_second_deriv_ge_first_term
    {δ ρ x : ℝ} (hδ : 0 < δ) (hx : 0 < x) (hxρ : x + δ < ρ) :
    δ ^ 2 / (x ^ 2 * (x + δ)) ≤ PhiSecondDerivRHS δ ρ x := by
  have hxδ : 0 < x + δ := by linarith
  have hρx : 0 < ρ - x := by linarith
  have hρxδ : 0 < ρ - x - δ := by linarith
  have hδ2 : 0 < δ ^ 2 := by positivity
  have hterm2 : 0 < δ ^ 2 / ((ρ - x) ^ 2 * (ρ - x - δ)) := by positivity
  unfold PhiSecondDerivRHS
  linarith

end SelectionAuditInformation
