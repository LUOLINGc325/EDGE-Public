import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace UnknownGapAdaptationBoundaryResearchProof1

/-- Pathwise scalar overshoot bound at the first crossing: if the running sum
`s` is still below the threshold `h` before an increment `z` that is bounded
above by `B`, then after adding the increment the running sum is at most
`h + B`. -/
theorem bounded_overshoot_step (s z h B : ℝ) (hpre : s < h) (hinc : z ≤ B) :
        s+z ≤ h+B := by
  linarith

end UnknownGapAdaptationBoundaryResearchProof1
