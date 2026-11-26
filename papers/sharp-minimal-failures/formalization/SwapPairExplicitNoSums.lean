import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace SwapRoundingMinimalFailures

/-- The conditional first moment of the exchange increment in Section 2. -/
theorem swap_delta_mean_zero {u v : ℝ} (hu : 0 < u) (hv : 0 < v) :
    u/(u+v)*v + v/(u+v)*(-u) = 0 := by
  have hd : u+v ≠ 0 := (add_pos hu hv).ne'
  field_simp [hd]
  ring

/-- The conditional second moment of the exchange increment in Section 2. -/
theorem swap_delta_second_moment {u v : ℝ} (hu : 0 < u) (hv : 0 < v) :
    u/(u+v)*v^2 + v/(u+v)*(-u)^2 = u*v := by
  have hd : u+v ≠ 0 := (add_pos hu hv).ne'
  field_simp [hd]
  ring

/-- In a paired exchange the conditional mean of the product of the two
fractional coordinates decreases by exactly u·v. -/
theorem swap_paired_product_expectation {u v : ℝ} (hu : 0 < u) (hv : 0 < v)
    (x y : ℝ) :
    u/(u+v)*(x+v)*(y-v) + v/(u+v)*(x-u)*(y+u) = x*y-u*v := by
  have hd : u+v ≠ 0 := (add_pos hu hv).ne'
  field_simp [hd]
  ring

end SwapRoundingMinimalFailures
