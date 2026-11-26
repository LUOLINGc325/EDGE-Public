import Mathlib.Data.Nat.Basic
import Lean.Elab.Tactic.Omega

namespace FinitePinwheelThreeTaskResearchProof1

/-- For `k ≥ 2`, the three endpoint inequalities controlling the exact `(2,3,c)`
threshold: `p (k+1) = 3*k/2 + 1`, `p (k+2) ≤ 3*k`, and `p (k+1) ≤ p (k+2) - 1`. -/
theorem two_third_deadline (k : ℕ) (hk : 2 ≤ k) :
    let p := fun r : ℕ => r + (r - 1) / 2
    p (k + 1) = 3 * k / 2 + 1 ∧ p (k + 2) ≤ 3 * k ∧ p (k + 1) ≤ p (k + 2) - 1 := by
  dsimp only
  exact ⟨by omega, by omega, by omega⟩

end FinitePinwheelThreeTaskResearchProof1
