import Mathlib.Data.Nat.Basic
import Lean.Elab.Tactic.Omega

namespace FinitePinwheelThreeTaskResearchProof1

/-- Exact inverse relation: the `r`-th positive nonmultiple of 3 is `r + (r-1)/2`. -/
theorem third_slot_rank (r t : ℕ) (hr : 1 ≤ r) : (r ≤ t-t/3 ↔ r+(r-1)/2 ≤ t) := by
  omega

end FinitePinwheelThreeTaskResearchProof1
