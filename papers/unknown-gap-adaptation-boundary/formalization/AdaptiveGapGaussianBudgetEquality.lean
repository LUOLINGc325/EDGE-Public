import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Positivity

namespace UnknownGapAdaptationBoundaryResearchProof3

theorem gaussian_budget_equality (C h : ℝ) (hC : 9 ≤ C)
         (hh : h = C/2-7/2) : 1 ≤ h ∧ (2*h+6)/(1-1/C)=C := by
  subst h
  refine ⟨by linarith, ?_⟩
  have hc : 0 < C := by linarith
  have hone : 1 / C < 1 := (div_lt_one hc).mpr (by linarith)
  apply (div_eq_iff (sub_pos.mpr hone).ne').mpr
  field_simp
  ring

end UnknownGapAdaptationBoundaryResearchProof3
