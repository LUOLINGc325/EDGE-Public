import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace RandomizedTwoJobRobustness

noncomputable section

/-- The two-job virtual cost of a fixed virtual share, evaluated at sizes `u,v`, is
`min u v + β (A u + B v + min u v)`.  This is the Section 4 upper bound
`min(u,v) + β OPT`. -/
def virtualUpper (A B β u v : ℝ) : ℝ :=
  min u v + β * (A * u + B * v + min u v)

/-- At the two shapes `(z,3z)` and `(3z,z)`, the average of the two upper bounds
is `(1 + β * (2(A+B)+1)) * z`. -/
theorem average_two_shapes (A B β z : ℝ) (hz : 0 < z) :
    (virtualUpper A B β z (3 * z) + virtualUpper A B β (3 * z) z) / 2 =
      (1 + β * (2 * (A + B) + 1)) * z := by
  have hz3 : 0 < 3 * z := by positivity
  have hmin1 : min z (3 * z) = z := by
    apply min_eq_left
    linarith
  have hmin2 : min (3 * z) z = z := by
    apply min_eq_right
    linarith
  unfold virtualUpper
  rw [hmin1, hmin2]
  ring

end

end RandomizedTwoJobRobustness
