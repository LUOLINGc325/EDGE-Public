import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace ExchangeableArithmeticMergingImprovementResearchProof1

/-- In a two-high-value orbit with values `x, y, z`, if the second coordinate `y`
already meets the extra threshold `(3 - x) / 2`, then the rejection budget `5/6`
is at most the arithmetic mean `(x + y + z) / 3`. -/
theorem extra_ordering_budget (x y z : ℝ) (hx : 0 ≤ x) (hz : 1 ≤ z)
    (hy : (3 - x) / 2 ≤ y) :
    (5 : ℝ) / 6 ≤ (x + y + z) / 3 := by
  have hsum : (5 : ℝ) ≤ x + 2 * y + 2 * z := by
    nlinarith [hy, hz]
  linarith

end ExchangeableArithmeticMergingImprovementResearchProof1
