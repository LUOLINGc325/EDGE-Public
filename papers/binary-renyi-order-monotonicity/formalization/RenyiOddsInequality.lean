import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

namespace BinaryRenyiOrderMonotonicityResearchProof1

theorem renyi_odds_inequality (r : ℝ) (hr : 0 < r) (hr1 : r < 1) :
    (-Real.log r)*r^2 < Real.log (1+r)*(1-r^2) := by
  have hx : r ≠ 0 := hr.ne'
  have hp : 0 < 1+r := by linarith
  have h1 : r⁻¹ ≠ 1 := by
    intro h
    have hc := congrArg (fun x : ℝ => r*x) h
    change r*r⁻¹ = r*1 at hc
    rw [mul_inv_cancel₀ hx, mul_one] at hc
    linarith
  have hu := Real.log_lt_sub_one_of_pos (inv_pos.mpr hr) h1
  rw [Real.log_inv] at hu
  have hu' : -Real.log r < (1-r)/r := by
    have hEq : r⁻¹ - 1 = (1-r)/r := by field_simp
    rwa [hEq] at hu
  have hl := Real.one_sub_inv_le_log_of_pos hp
  have hl' : r/(1+r) ≤ Real.log (1+r) := by
    have hEq : 1-(1+r)⁻¹ = r/(1+r) := by field_simp
    rwa [hEq] at hl
  calc
    (-Real.log r)*r^2 < ((1-r)/r)*r^2 := mul_lt_mul_of_pos_right hu' (pow_pos hr _)
    _ = (r/(1+r))*(1-r^2) := by field_simp; ring
    _ ≤ Real.log (1+r)*(1-r^2) := by
      exact mul_le_mul_of_nonneg_right hl' (by nlinarith [mul_nonneg (sub_nonneg.mpr hr1.le) hr.le])

end BinaryRenyiOrderMonotonicityResearchProof1
