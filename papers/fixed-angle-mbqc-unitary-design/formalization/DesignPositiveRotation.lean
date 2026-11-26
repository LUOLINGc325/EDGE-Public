import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum

namespace FixedAngleMbqcUnitaryDesignResearchProof1

theorem positive_rotation_parameter (p : ℝ) (hp : 4 ≤ p) : let z := (p^2+2*p+3)/(2*p*(2*p+1)); 1/4 < z ∧ z < 1 ∧ 0 < 2*(1-Real.sqrt z) ∧ 2*(1-Real.sqrt z) < 1 := by
  intro z
  have hp0 : 0 < p := by linarith
  have hden : 0 < 2*p*(2*p+1) := mul_pos (by positivity) (by linarith)
  have hlow : (1:ℝ)/4 < z := by
    apply (lt_div_iff₀ hden).2
    nlinarith
  have hhigh : z < 1 := by
    apply (div_lt_one hden).2
    nlinarith [sq_nonneg (p-4)]
  have hs : (Real.sqrt z)^2=z := Real.sq_sqrt (by linarith)
  have hp' : 0 ≤ Real.sqrt z := Real.sqrt_nonneg _
  have hsl : (1:ℝ)/2 < Real.sqrt z := by
    by_contra! h
    have hh := sq_le_sq' (by linarith : -(1/2:ℝ) ≤ Real.sqrt z) h
    norm_num at hh
    linarith only [hh,hs,hlow]
  have hsh : Real.sqrt z < 1 := by
    simpa using Real.sqrt_lt_sqrt (by linarith : 0 ≤ z) hhigh
  exact ⟨hlow,hhigh,by linarith,by linarith⟩

end FixedAngleMbqcUnitaryDesignResearchProof1
