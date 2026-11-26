import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

namespace UnknownGapAdaptationBoundaryResearchProof1

theorem baseline_budget_equality (g D C B h : ℝ) (hg : 0 < g)
         (hD : 0 < D) (hC : 1 < C) (hh : h = (D/g)*(C-1)-B) :
         g*(h+B)/(D*(1-1/C)) = C := by
  have hgne : g ≠ 0 := ne_of_gt hg
  have hDne : D ≠ 0 := ne_of_gt hD
  have hCpos : 0 < C := by linarith
  have hCne : C ≠ 0 := ne_of_gt hCpos
  have h1C : (1 - 1/C) ≠ 0 := by
    have h1 : 1/C < 1 := by
      rw [div_lt_one hCpos]
      linarith
    have : 0 < 1 - 1/C := by linarith
    exact ne_of_gt this
  have hhB : h + B = (D/g)*(C-1) := by
    rw [hh]; ring
  have hgD : g * ((D/g)*(C-1)) = D*(C-1) := by
    field_simp
  have hnum : g*(h+B) = D*(C-1) := by
    rw [hhB]; exact hgD
  rw [hnum]
  have hden : D*(1-1/C) ≠ 0 := mul_ne_zero hDne h1C
  rw [div_eq_iff hden]
  field_simp

end UnknownGapAdaptationBoundaryResearchProof1
