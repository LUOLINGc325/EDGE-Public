import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

namespace EuclideanMedianAllPSharpResearchProof1

/-- The Euclidean two-coordinate square in (R5): the squared distance between
`(r, 0)` and `(√s, √(1-s))` equals `r^2 + 1 - 2*r*√s`, valid for `0 ≤ s ≤ 1`
(so in particular at `s = 0` and `s = 1`). -/
theorem euclidean_distance_square (r s : ℝ) (hs : 0 ≤ s) (hs1 : s ≤ 1) :
    (r - Real.sqrt s)^2 + (Real.sqrt (1 - s))^2 = r^2 + 1 - 2*r*Real.sqrt s := by
  have h1 : (Real.sqrt s)^2 = s := Real.sq_sqrt hs
  have h2 : (Real.sqrt (1 - s))^2 = 1 - s := Real.sq_sqrt (by linarith)
  nlinarith [h1, h2]

end EuclideanMedianAllPSharpResearchProof1
