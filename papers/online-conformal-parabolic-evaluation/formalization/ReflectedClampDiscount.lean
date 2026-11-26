import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

namespace OnlineConformalParabolicEvaluationResearchProof1

/-- Conversion of the horizon-`r` clipping error into the discounted value bound.

The undiscounted bound `E ≤ 2 * δ * (exp (r/2) - 1)` implies the discounted bound
`exp (-r/2) * E ≤ 2 * δ * (1 - exp (-r/2))`, using `exp (-r/2) * exp (r/2) = 1`
and `δ ≥ 0`. -/
theorem discounted_clipping_error (r δ E : ℝ) (_hr : 0 ≤ r) (_hδ : 0 ≤ δ) (hE : 0 ≤ E)
    (he : E ≤ 2 * δ * (Real.exp (r / 2) - 1)) :
    0 ≤ Real.exp (-r / 2) * E ∧
      Real.exp (-r / 2) * E ≤ 2 * δ * (1 - Real.exp (-r / 2)) := by
  have hpos : 0 < Real.exp (-r/2) := Real.exp_pos _
  refine ⟨mul_nonneg hpos.le hE, ?_⟩
  have he' := mul_le_mul_of_nonneg_left he hpos.le
  have hone : Real.exp (-r/2)*Real.exp (r/2)=1 := by
    rw [← Real.exp_add, show -r/2+r/2=0 by ring, Real.exp_zero]
  have heq : Real.exp (-r/2)*(2*δ*(Real.exp (r/2)-1)) =
      2*δ*(1-Real.exp (-r/2)) := by
    calc
      _ = 2*δ*(Real.exp (-r/2)*Real.exp (r/2)-Real.exp (-r/2)) := by ring
      _ = _ := by rw [hone]
  exact he'.trans_eq heq

end OnlineConformalParabolicEvaluationResearchProof1
