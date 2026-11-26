import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Data.Matrix.Notation
import Mathlib.Tactic.FinCases

universe u
namespace BinaryMarkovGrayDispersionResearchProof1

theorem noise_rank_one (ρ s g d : ℝ) (hρ : ρ = s^2) (hgs : (1-2*d)*g = s) :
         (1-d) • (!![(1+ρ+2*g)/4, (1-ρ)/4; (1-ρ)/4, (1+ρ-2*g)/4] : Matrix (Fin 2) (Fin 2) ℝ)
         + d • (!![(1+ρ-2*g)/4, (1-ρ)/4; (1-ρ)/4, (1+ρ+2*g)/4] : Matrix (Fin 2) (Fin 2) ℝ)
         = !![(1+s)*(1+s)/4, (1+s)*(1-s)/4; (1-s)*(1+s)/4, (1-s)*(1-s)/4] := by
  subst ρ
  have hd : d*g = (g-s)/2 := by linarith only [hgs]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;>
    nlinarith only [hd]

end BinaryMarkovGrayDispersionResearchProof1
