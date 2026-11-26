import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace ConditionalInformationPowerBoundariesResearchProof1

/-- With the two possible observed values `l < 1 < h` of `R` and null conditional
sign probability `p = (1-l)/(h-l)` of the high branch, the conditional variance of
`R` given the deviance equals `(1-l)*(h-1)`.

This is the identity used in Theorem 1:
`v(D) = Var_0(R | D) = (1-r_-)(r_+ - 1)`. -/
theorem branch_conditional_variance (l h : ℝ) (hl : l < 1) (hh : 1 < h) :
    let p := (1 - l) / (h - l);
    (1 - p) * (l - 1) ^ 2 + p * (h - 1) ^ 2 = (1 - l) * (h - 1) := by
  intro p
  have hne : h - l ≠ 0 := by linarith
  dsimp only [p]
  field_simp
  ring

end ConditionalInformationPowerBoundariesResearchProof1
