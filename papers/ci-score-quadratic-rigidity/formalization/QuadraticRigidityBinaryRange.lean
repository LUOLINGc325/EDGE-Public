import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace CiScoreQuadraticRigidityResearchProof1

/-- Exact closed-interval sign criterion for the binary curvature polynomial
`h''(r) = -2λ - 2s + 12 s r (1 - r)` from §4.6.

The polynomial is continuous, so its sign condition on `[0,1]` is equivalent to
the sign condition on the open interval `(0,1)`. The claimed range is
`-λ ≤ s ≤ 2λ`, which in particular forces `λ ≥ 0`.

This is the frozen child lemma only: it does not differentiate `h`, does not
assert information universality, and makes no `n ≥ 3` claim. -/
theorem binary_curvature_polynomial_range (l s : ℝ) :
    (∀ r : ℝ, 0 ≤ r → r ≤ 1 → -2*l-2*s+12*s*r*(1-r) ≤ 0) ↔ -l ≤ s ∧ s ≤ 2*l := by
  constructor
  · intro h
    -- Evaluate the nonnegativity of `-(h'')` at the endpoints.
    have h0 : -2*l-2*s+12*s*(0:ℝ)*(1-(0:ℝ)) ≤ 0 := h 0 (by norm_num) (by norm_num)
    have h1 : -2*l-2*s+12*s*(1:ℝ)*(1-(1:ℝ)) ≤ 0 := h 1 (by norm_num) (by norm_num)
    -- At r = 0 we get `-2l - 2s ≤ 0`, i.e. `-l ≤ s`.
    have hs : -l ≤ s := by
      have : -2*l - 2*s ≤ 0 := by simpa using h0
      linarith
    -- At r = 1 we get `-2l - 2s ≤ 0`, i.e. `s ≤ l`... need s ≤ 2l instead.
    -- Use the fact that the polynomial is a downward parabola with vertex
    -- value bounding `s`; obtain `s ≤ 2l` via the quadratic structure.
    -- The coefficient of `r(1-r)` is `12s`, and `r(1-r) ≤ 1/4`, so the
    -- maximum over `r ∈ [0,1]` of `12 s r(1-r)` for `s ≥ 0` is `3s`;
    -- alternatively split on the sign of `s`.
    refine ⟨hs, ?_⟩
    rcases le_or_lt s 0 with hsneg | hspos
    · -- If `s ≤ 0 ≤ 2l` follows from `-l ≤ s ≤ 0` giving `l ≥ 0`.
      have hl : 0 ≤ l := by linarith
      linarith
    · -- `s > 0`: use `r(1-r) ≤ 1/4` to bound `12s r(1-r) ≤ 3s` at all `r`.
      -- Since `-2l - 2s + 3s ≤ 0` must be necessary via the vertex approach:
      -- instead directly evaluate at `r = 1/2`.
      have hhalf : -2*l-2*s+12*s*(1/2:ℝ)*(1-(1/2:ℝ)) ≤ 0 :=
        h (1/2) (by norm_num) (by norm_num)
      have hrw : 12*s*(1/2:ℝ)*(1-(1/2:ℝ)) = 3*s := by ring
      rw [hrw] at hhalf
      linarith
  · intro ⟨hls, hs2l⟩ r hr0 hr1
    -- Bound `r(1-r) ≤ 1/4` for `r ∈ [0,1]`, then split on sign of `s`.
    have hr1' : 0 ≤ 1 - r := by linarith
    have hrle : r*(1-r) ≤ 1/4 := by nlinarith [sq_nonneg (r - 1/2)]
    have hrle0 : 0 ≤ r*(1-r) := mul_nonneg hr0 hr1'
    rcases le_or_lt s 0 with hsneg | hspos
    · -- `s ≤ 0`: `12 s r(1-r) ≤ 0`, so expression ≤ `-2l - 2s`.
      have hterm : 12*s*r*(1-r) ≤ 0 := by
        have : 12*s*(r*(1-r)) ≤ 0 := mul_nonpos_of_nonpos_of_nonneg (by linarith) hrle0
        linarith
      nlinarith [hls]
    · -- `s > 0`: `12 s r(1-r) ≤ 3s`, so expression ≤ `-2l + s ≤ 0` by `s ≤ 2l`.
      have hterm : 12*s*r*(1-r) ≤ 3*s := by
        have h3 : 12*s*(r*(1-r)) ≤ 12*s*(1/4) := by
          apply mul_le_mul_of_nonneg_left hrle
          linarith
        have : 12*s*(1/4:ℝ) = 3*s := by ring
        linarith
      linarith

end CiScoreQuadraticRigidityResearchProof1
