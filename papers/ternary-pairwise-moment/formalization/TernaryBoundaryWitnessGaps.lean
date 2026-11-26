import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

namespace TernaryPairwiseMomentResearchProof1

/-- Sign change of the first explicit scaled value difference
`36*x - 12` (from the edge `(14,4,7)/25`) across the interior cutpoint `x = 1/3`. -/
theorem ternary_boundary_witness_gaps (x : ℝ) (hx : 0 ≤ x) (hx1 : x < 1) :
    ((0 : ℝ) < 36*x-12 ↔ (1:ℝ)/3 < x) ∧
    ((0 : ℝ) < 35*(1-x)*(2*x-1) ↔ (1:ℝ)/2 < x) := by
  have _hx := hx
  constructor
  · constructor
    · intro h
      nlinarith
    · intro h
      nlinarith
  · constructor
    · intro h
      have hxpos : (0:ℝ) < 1 - x := by linarith
      have h2 : (0:ℝ) < 2*x - 1 := by nlinarith [h]
      nlinarith
    · intro h
      have h2 : (0:ℝ) < 2*x - 1 := by linarith
      have hxpos : (0:ℝ) < 1 - x := by linarith
      nlinarith [mul_pos hxpos h2]

end TernaryPairwiseMomentResearchProof1
