import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace TwoWeightQutritSharpCoolingResearchProof1

theorem cycle_cost_attainment (u v : ℝ) :
    (u^2 + v^2 + (u - v)^2 = 3*u^2/2 ↔ v = u/2) := by
  constructor
  · intro h
    have key : 2*(v - u/2)^2 = 0 := by
      nlinarith [sq_nonneg (v - u/2)]
    have hzero : (v - u/2)^2 = 0 := by linarith
    have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hzero
    linarith
  · intro h
    subst h
    ring

end TwoWeightQutritSharpCoolingResearchProof1
