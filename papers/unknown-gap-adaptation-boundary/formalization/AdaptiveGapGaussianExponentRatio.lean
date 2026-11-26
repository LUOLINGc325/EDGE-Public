import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Analysis.SpecialFunctions.Exp

namespace UnknownGapAdaptationBoundaryResearchProof3

/-- Pointwise comparison of unnormalized Gaussian densities:
for `s ≥ 0` and `t ≥ 0`, the density of `N(1/2,1)` at `s+t` is at most
`exp(t/2 - t^2/2)` times its density at `s`. This is the density comparison
used just before Lemma 5's tail integration. -/
theorem gaussian_shift_exponent (s t : ℝ) (hs : 0 ≤ s) (ht : 0 ≤ t) :
    Real.exp (-((s + t - 1 / 2) ^ 2) / 2) ≤
      Real.exp (t / 2 - t ^ 2 / 2) * Real.exp (-((s - 1 / 2) ^ 2) / 2) := by
  rw [← Real.exp_add]
  apply Real.exp_le_exp.mpr
  nlinarith [mul_nonneg hs ht]

end UnknownGapAdaptationBoundaryResearchProof3
