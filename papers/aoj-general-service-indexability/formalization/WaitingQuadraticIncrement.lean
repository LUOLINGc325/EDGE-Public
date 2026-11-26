import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

namespace AojGeneralServiceIndexabilityResearchProof1

theorem waiting_quadratic_increment (w x g : ℝ) (n : ℕ) :
    let Q := fun k : ℕ => w/2*(k:ℝ)*((k:ℝ)-1)+(w*x-g)*k
    Q (n+1)-Q n = w*((n:ℝ)+x)-g := by
  simp only
  push_cast
  ring

end AojGeneralServiceIndexabilityResearchProof1
