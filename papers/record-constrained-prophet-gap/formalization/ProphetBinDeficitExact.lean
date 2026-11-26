import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace RecordConstrainedProphetGapResearchProof3

/-- Exact interpolation-deficit identity (11) from (10).

With `q = a + t*h`, `b = a + h` (so `b - q = (1-t)*h`) and the normalized
bin weight `m*(b-q) = 1-t`, the difference between the tail-prophet value
`M(q) = 1 - q^n` and the bin-mean value
`P(q) = 1 - b^n + m*(b-q)*(b^n - a^n)` equals
`(1-t)*a^n + t*b^n - q^n`. -/
theorem bin_deficit_exact (n : ℕ) (a b q t m : ℝ)
    (hweight : m*(b-q)=1-t) :
    (1-q^n)-(1-b^n+m*(b-q)*(b^n-a^n)) =
      (1-t)*a^n+t*b^n-q^n := by
  rw [hweight]
  ring

end RecordConstrainedProphetGapResearchProof3
