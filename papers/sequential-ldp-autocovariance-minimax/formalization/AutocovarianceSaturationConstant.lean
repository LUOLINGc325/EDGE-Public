import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

universe u
namespace SequentialLdpAutocovarianceMinimaxResearchProof1

theorem information_bound_saturation (N a D : ℝ) (hN : 0 ≤ N) (ha : 0 ≤ a) (hD : 0 < D) :
         (8192+D)⁻¹ * (max 1 (N*a^4))⁻¹ ≤ (8192*N*a^4+D)⁻¹ := by
  have hbase : 0 ≤ N*a^4 := mul_nonneg hN (pow_nonneg ha 4)
  have hpositive : 0 < 8192*N*a^4+D := by
    linarith only [hbase, hD]
  have hlower : N*a^4 ≤ max 1 (N*a^4) := le_max_right _ _
  have hone : 1 ≤ max 1 (N*a^4) := le_max_left _ _
  have hdiff : 0 ≤ D*(max 1 (N*a^4)-1) :=
    mul_nonneg hD.le (sub_nonneg.mpr hone)
  have hbound : 8192*N*a^4+D ≤ (8192+D)*max 1 (N*a^4) := by
    nlinarith only [hdiff, hlower]
  rw [← mul_inv_rev]
  simpa only [one_div, mul_comm (8192+D)] using one_div_le_one_div_of_le hpositive hbound

end SequentialLdpAutocovarianceMinimaxResearchProof1
