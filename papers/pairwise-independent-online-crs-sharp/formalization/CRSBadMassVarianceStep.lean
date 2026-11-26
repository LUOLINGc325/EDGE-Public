import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

universe u
namespace PairwiseIndependentOnlineCrsSharpResearchProof1

theorem overload_mass_bound (mass p u : ℝ) (hp0 : 0 ≤ p) (hp1 : p ≤ 1)
         (hmass : 0 ≤ mass) (hu : p < u)
         (hvariance : (u-p)^2*mass^2 ≤ mass*p*(1-p)) :
         mass ≤ p*(1-p)/(u-p)^2 := by
  have hsq := sq_pos_of_pos (sub_pos.mpr hu)
  apply (le_div_iff₀ hsq).mpr
  by_cases hm : mass=0
  · rw [hm, zero_mul]
    exact mul_nonneg hp0 (sub_nonneg.mpr hp1)
  have hpos : 0 < mass := lt_of_le_of_ne hmass (Ne.symm hm)
  apply (mul_le_mul_right hpos).mp
  nlinarith only [hvariance]

end PairwiseIndependentOnlineCrsSharpResearchProof1
