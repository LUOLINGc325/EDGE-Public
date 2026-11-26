import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace SharpTwoStepActivityResearchProof1

/-- The net probability moved from the higher-energy endpoint `H` to the
lower-energy endpoint `L` along a single edge during the first update equals
the Gibbs-deficit form `(pL + pH) * (t₁ - t₀) / (2 * d)`.

The hypothesis `h : pL * (1 - t₀) = pH * (1 + t₀)` is the Gibbs odds relation
`pL / pH = (1 + t₀) / (1 - t₀)` cleared of denominators, which is valid also
for ties, where the two endpoints have equal energy and `t₀ = 0`. -/
theorem edge_current_identity (pL pH t₀ t₁ d : ℝ) (hd : 0 < d)
    (h : pL * (1 - t₀) = pH * (1 + t₀)) :
    (pH * (1 + t₁) - pL * (1 - t₁)) / (2 * d)
      = (pL + pH) * (t₁ - t₀) / (2 * d) := by
  have hd' : 2*d ≠ 0 := mul_ne_zero (by norm_num) hd.ne'
  apply (div_eq_div_iff hd' hd').2
  have hnum : pH*(1+t₁)-pL*(1-t₁) = (pL+pH)*(t₁-t₀) := by nlinarith only [h]
  rw [hnum]

end SharpTwoStepActivityResearchProof1
