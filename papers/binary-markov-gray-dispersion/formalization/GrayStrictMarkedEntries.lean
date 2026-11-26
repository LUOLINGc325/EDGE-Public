import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Data.Real.Sqrt

universe u
namespace BinaryMarkovGrayDispersionResearchProof1

theorem gray_marked_entry_positive (rho d : ℝ) (hrho : 0 < rho) (hrho1 : rho < 1)
         (hd : d < (1-2*Real.sqrt rho/(1+rho))/2) :
         0 < (1+rho-2*Real.sqrt rho/(1-2*d))/4 ∧ 0 < (1-rho)/4 := by
  have hs := Real.sqrt_nonneg rho
  have hbase : 0 < 1+rho := by linarith only [hrho]
  have hlt : 2*Real.sqrt rho/(1+rho) < 1-2*d := by linarith only [hd]
  have hden : 0 < 1-2*d := lt_of_le_of_lt (div_nonneg (by positivity) hbase.le) hlt
  have hprod := (div_lt_iff₀ hbase).mp hlt
  have hratio : 2*Real.sqrt rho/(1-2*d) < 1+rho := by
    apply (div_lt_iff₀ hden).mpr
    simpa only [mul_comm (1+rho)] using hprod
  exact ⟨by linarith only [hratio], by linarith only [hrho1]⟩

end BinaryMarkovGrayDispersionResearchProof1
