import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

namespace AojGeneralServiceIndexabilityResearchProof1

theorem waiting_quadratic_shift (w x g : ℝ) (n : ℕ) :
    let Q := fun y : ℝ => fun k : ℕ =>
      w / 2 * (k : ℝ) * ((k : ℝ) - 1) + (w * y - g) * k
    Q x (n + 1) = w * x - g + Q (x + 1) n := by
  dsimp only
  push_cast
  ring

end AojGeneralServiceIndexabilityResearchProof1
