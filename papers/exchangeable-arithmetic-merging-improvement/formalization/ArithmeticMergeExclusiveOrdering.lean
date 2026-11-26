import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace ExchangeableArithmeticMergingImprovementResearchProof1

/-- In the three-coordinate two-high orbit (one low value `x` and two high values
`y, z`, with total sum `< 3`), the two high values cannot both be at least
`(3 - x) / 2`.  Equivalently, the additional three-coordinate condition cannot
be triggered in both of the remaining low-first orderings, since that would
force `y ≥ (3-x)/2` and `z ≥ (3-x)/2`, contradicting `x + y + z < 3`.

This is the exact obstruction from the manuscript's orbit argument; it does not
count the orbit or prove significance. -/
theorem exclusive_extra_ordering (x y z : ℝ) (ht : x+y+z < 3) :
    ¬ ((3-x)/2 ≤ y ∧ (3-x)/2 ≤ z) := by
  rintro ⟨hy, hz⟩
  nlinarith

end ExchangeableArithmeticMergingImprovementResearchProof1
