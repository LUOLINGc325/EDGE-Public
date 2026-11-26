import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace GaffkeDeltaSharpBoundResearchProof1

/-- Same-`D` comparison from the "Same-`K` compression" paragraph:
if the new Laplace value `L₂` is at most the old value `L₁`, then after subtracting the
common probability `D` the gap is still nonpositive, and strictly negative when `L₂ < L₁`. -/
theorem same_d_comparison (D L₁ L₂ : ℝ) (hL : L₂ ≤ L₁) :
    L₂ - D ≤ L₁ - D ∧ (L₂ < L₁ → L₂ - D < L₁ - D) := by
  constructor
  · linarith
  · intro h
    linarith

end GaffkeDeltaSharpBoundResearchProof1
