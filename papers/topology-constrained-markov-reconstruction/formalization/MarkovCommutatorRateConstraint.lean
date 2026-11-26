import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

/-!
Scope note (Theorem 1, Section 3.3, equation (2) and the "positivity forces" step).

The manuscript's Section 3.3 sets, on a cycle with vertices indexed by ℤ,
`a_i = q_{i,i+1} > 0`, `b_i = q_{i,i-1} > 0`, and, for the supported matrix `X`
commuting with `Q = A + B` written as `X = α A + β B`,
`[A,B]_{i,i+1} = a_i (b_i - b_{i+1})`  (eq. (2), clockwise part).

The proof then concludes: if `α ≠ β` and `[Q,X] = (β - α)[A,B] = 0`, then
`a_i = a_{i+1}` for every `i` (all clockwise rates equal), because
`a_i > 0` and `(β-α) ≠ 0` force `b_i - b_{i+1} = 0`.

Below we formalize exactly that arithmetic/positivity core as a self-contained
local claim about a single adjacent pair of clockwise rates, matching the sign
and factor structure of eq. (2).  This is a necessary sublemma of the
classification; the global propagation and the full classification are not
formalized.
-/

namespace TopologyMarkovReconstruction

/-- Local "vanishing off-diagonal commutator entry" step of Theorem 1 (Section 3.3).

Given positive clockwise rate `a`, counterclockwise rates `b_i, b_ip1`, and
scalars `α, β` with `(β - α) * a * (b_i - b_ip1) = 0` (the `(i, i+1)` entry of
`[Q,X] = (β - α)[A,B]`, eq. (2), set to zero by commutation) together with
`α ≠ β`, the adjacent counterclockwise rates coincide.

Equivalently, this is the statement that the clockwise ratio constant is
consistent: no distinct-`α,β` supported commutant exists with unequal adjacent
`b`'s. -/
theorem adjacent_ccw_rates_equal_of_commutator_vanishes
    (a b_i b_ip1 alpha beta : ℝ)
    (ha : 0 < a) (hab : (beta - alpha) * a * (b_i - b_ip1) = 0)
    (hne : alpha ≠ beta) :
    b_i = b_ip1 := by
  have hdiff : beta - alpha ≠ 0 := sub_ne_zero.mpr (Ne.symm hne)
  rcases mul_eq_zero.mp hab with h1 | h2
  · exact absurd h1 (mul_ne_zero hdiff (ne_of_gt ha))
  · exact sub_eq_zero.mp h2

/-- Contrapositive form: if adjacent counterclockwise rates differ, then any
supported commutant `X = α A + β B` commuting with `Q` must have `α = β`,
i.e. `X` lies in the one-dimensional span of `Q` locally. -/
theorem alpha_eq_beta_of_adjacent_ccw_rates_ne
    (a b_i b_ip1 alpha beta : ℝ)
    (ha : 0 < a) (hne_rates : b_i ≠ b_ip1)
    (hab : (beta - alpha) * a * (b_i - b_ip1) = 0) :
    alpha = beta := by
  by_contra h
  have hdiff : beta - alpha ≠ 0 := sub_ne_zero.mpr (Ne.symm h)
  exact mul_ne_zero (mul_ne_zero hdiff (ne_of_gt ha))
    (sub_ne_zero.mpr hne_rates) hab

end TopologyMarkovReconstruction
