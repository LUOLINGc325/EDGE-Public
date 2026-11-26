import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

namespace UnknownGapAdaptationBoundaryResearchProof2

/-- Exact child scope of (23): given the restart probability comparison `b ≤ β`
with `β < 1`, the cycle accounting ratio `g*mu/(1-b)` is at most `g*mu/(1-β)`.
We need `b < 1` (implied by `b ≤ β < 1`) so that `1 - b > 0`. -/
theorem baseline_cycle_bound (g mu b beta : ℝ) (hg : 0 ≤ g) (hmu : 0 ≤ mu)
         (hbbeta : b ≤ beta) (hbeta : beta < 1) :
         g*mu/(1-b) ≤ g*mu/(1-beta) := by
  have hb1 : b < 1 := lt_of_le_of_lt hbbeta hbeta
  have hden_b : 0 < 1 - b := by linarith
  have hden_beta : 0 < 1 - beta := by linarith
  have hnum : 0 ≤ g * mu := mul_nonneg hg hmu
  rw [div_le_div_iff₀ hden_b hden_beta]
  nlinarith [hnum, hbbeta, hden_b, hden_beta]

end UnknownGapAdaptationBoundaryResearchProof2
