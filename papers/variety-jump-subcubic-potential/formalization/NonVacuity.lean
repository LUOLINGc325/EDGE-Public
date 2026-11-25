import SubcubicDefs
import Mathlib.Tactic.NormNum

set_option autoImplicit false
set_option maxHeartbeats 0

namespace Subcubic.Example

noncomputable def graph : Graph (Fin 7) where
  edge x y := decide ((x=0 ∧ y=3) ∨ (x=3 ∧ y=0) ∨
    (x=3 ∧ y=4) ∨ (x=4 ∧ y=3) ∨ (x=4 ∧ y=1) ∨ (x=1 ∧ y=4) ∨
    (x=1 ∧ y=5) ∨ (x=5 ∧ y=1) ∨ (x=5 ∧ y=2) ∨ (x=2 ∧ y=5) ∨
    (x=1 ∧ y=6) ∨ (x=6 ∧ y=1))
  symmetric := by decide
  loopless := by decide

noncomputable def typeOf (a : Fin 5) : Fin 2 := if a=4 then 1 else 0

noncomputable def before : Fin 7 → Option (Fin 5) := fun x =>
  if x=0 then some 0 else if x=3 then some 1 else if x=4 then some 2 else
  if x=5 then some 3 else if x=6 then some 4 else none

noncomputable def after : Fin 7 → Option (Fin 5) :=
  Function.update (Function.update before 0 none) 1 (some 0)

noncomputable def qb : Coloring (Fin 7) (Fin 2) := project typeOf before
noncomputable def qa : Coloring (Fin 7) (Fin 2) := project typeOf after

theorem graph_subcubic : MaxDegreeThree graph := by unfold MaxDegreeThree; decide
theorem before_wellFormed : WellFormed before := by unfold WellFormed ExistsUnique; decide
theorem after_wellFormed : WellFormed after := by unfold WellFormed ExistsUnique; decide
theorem before_two_holes : (holes qb).card = 2 := by decide
theorem after_two_holes : (holes qa).card = 2 := by decide

theorem actual_labelled_improvement : LabelledImproves graph typeOf before after := by
  refine ⟨0, 1, 0, ?_, ?_, rfl, ?_⟩ <;> decide

theorem utility_values : utility graph qb 0 0 = 0 ∧ utility graph qa 0 1 = 1 := by
  decide

theorem feature_values_before :
    TE graph qb = 3 ∧ monoArcs graph qb = 4 ∧ emptyArcs graph qb = 0 ∧
    D graph qb = 4 ∧ potential graph qb = 56 := by decide

theorem feature_values_after :
    TE graph qa = 2 ∧ monoArcs graph qa = 6 ∧ emptyArcs graph qa = 0 ∧
    D graph qa = 2 ∧ potential graph qa = 48 := by decide

/-- Twice the old cubic potential is unchanged on this strictly improving jump. -/
theorem old_cubic_potential_unchanged :
    4 * TE graph qb + 2 * monoArcs graph qb + emptyArcs graph qb = 20 ∧
    4 * TE graph qa + 2 * monoArcs graph qa + emptyArcs graph qa = 20 := by decide

end Subcubic.Example
