import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace CommutingEffectThresholdResearchProof1

/-- Recover the Bloch-disk constraint from positivity of the complex qubit
density matrix: from `c^2 + t^2 ≤ a*(1-a)` deduce `(2c)^2 + (2a-1)^2 ≤ 1`. -/
theorem complex_qubit_disk (a c t : ℝ) (h : c^2+t^2 ≤ a*(1-a)) :
    (2*c)^2+(2*a-1)^2 ≤ 1 := by
  nlinarith [sq_nonneg t]

end CommutingEffectThresholdResearchProof1
