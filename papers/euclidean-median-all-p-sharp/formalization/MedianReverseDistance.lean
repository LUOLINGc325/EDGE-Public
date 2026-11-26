import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

namespace EuclideanMedianAllPSharpResearchProof1

/-- Radial reverse-distance inequality used in the compactness estimate (R6):
for `r ≥ 1` and `0 ≤ s ≤ 1`, the Euclidean distance between `(r,0)` and
`(√s, √(1-s))`, whose square is `r^2 + 1 - 2 r √s`, is at least `r - 1`. -/
theorem distance_lower_radial (r s : ℝ) (hr : 1 ≤ r) (hs : 0 ≤ s) (hs1 : s ≤ 1) :
    r - 1 ≤ Real.sqrt (r^2 + 1 - 2*r*Real.sqrt s) := by
  have hr0 : 0 ≤ r := le_trans zero_le_one hr
  have hspos : 0 ≤ Real.sqrt s := Real.sqrt_nonneg s
  have hsle : Real.sqrt s ≤ 1 := by
    calc Real.sqrt s ≤ Real.sqrt 1 := Real.sqrt_le_sqrt hs1
      _ = 1 := Real.sqrt_one
  -- It suffices to compare squares, since `r - 1 ≥ 0`.
  have hr1 : 0 ≤ r - 1 := by linarith
  have hsquare : (r - 1)^2 ≤ r^2 + 1 - 2*r*Real.sqrt s := by
    have hsq : (Real.sqrt s)^2 = s := Real.sq_sqrt hs
    nlinarith [hspos, hs, hr0, mul_nonneg hr0 hspos, mul_le_mul_of_nonneg_left hsle hr0]
  have hnonneg : 0 ≤ r^2 + 1 - 2*r*Real.sqrt s := by linarith [sq_nonneg (r - 1)]
  calc r - 1 = Real.sqrt ((r - 1)^2) := (Real.sqrt_sq hr1).symm
    _ ≤ Real.sqrt (r^2 + 1 - 2*r*Real.sqrt s) := Real.sqrt_le_sqrt hsquare

end EuclideanMedianAllPSharpResearchProof1
