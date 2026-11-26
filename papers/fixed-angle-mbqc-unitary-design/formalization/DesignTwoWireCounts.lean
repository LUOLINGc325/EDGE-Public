import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum

namespace FixedAngleMbqcUnitaryDesignResearchProof1

theorem two_wire_positive_root : let x := (3-3/Real.sqrt 5)/2; let NA:=4-3*x+x^2/2; let NAB:=1+x^2/2; (0:ℝ)<x ∧ x<1 ∧ 4*NA+4*NAB-64/5=0 := by
  dsimp only
  let s := Real.sqrt 5
  have hs : 0 < s := Real.sqrt_pos.mpr (by norm_num)
  have hss : s^2 = 5 := Real.sq_sqrt (by norm_num)
  have hsl : 1 < s := by
    have ht := Real.sqrt_lt_sqrt (by norm_num : (0:ℝ) ≤ 1) (by norm_num : (1:ℝ) < 5)
    simpa [s] using ht
  have hsh : s < 3 := by
    have ht := Real.sqrt_lt_sqrt (by norm_num : (0:ℝ) ≤ 5) (by norm_num : (5:ℝ) < 9)
    rw [show (9:ℝ)=3^2 by norm_num, Real.sqrt_sq (by norm_num : (0:ℝ) ≤ 3)] at ht
    exact ht
  have hu : (3:ℝ)/s < 3 := (div_lt_iff₀ hs).2 (by linarith)
  have hl : (1:ℝ) < 3/s := (lt_div_iff₀ hs).2 (by linarith)
  change 0 < (3-3/s)/2 ∧ (3-3/s)/2 < 1 ∧ _
  refine ⟨by linarith,by linarith,?_⟩
  change 4*(4-3*((3-3/s)/2)+((3-3/s)/2)^2/2) +
    4*(1+((3-3/s)/2)^2/2)-64/5=0
  calc
    _ = 9*(s⁻¹)^2-9/5 := by ring
    _ = 0 := by rw [inv_pow,hss]; norm_num

end FixedAngleMbqcUnitaryDesignResearchProof1
