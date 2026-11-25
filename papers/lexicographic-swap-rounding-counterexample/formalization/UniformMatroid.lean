import Mathlib.Data.Fintype.Fin
import Mathlib.Data.List.FinRange
import SwapDefinitions

/-!
The basis axioms for the finite family used by the executable algorithm.
All elements, masks and exchange witnesses are quantified over their full
finite domains; these are kernel decision proofs, not sampled checks.
-/

namespace SwapRounding

noncomputable section

set_option maxRecDepth 8192
set_option maxHeartbeats 4000000

theorem basis_family_nonempty : ∃ s : Fin 64, isBase s.val = true := by
  exact ⟨⟨7, by decide⟩, by decide⟩

theorem uniform_symmetric_basis_exchange :
    ∀ left right : Fin 64,
      isBase left.val = true → isBase right.val = true →
      ∀ i : Fin 6, member left.val i.val = true → member right.val i.val = false →
      ∃ j : Fin 6,
        member right.val j.val = true ∧ member left.val j.val = false ∧
        isBase (replace left.val i.val j.val) = true ∧
        isBase (replace right.val j.val i.val) = true := by
  decide +kernel

noncomputable def symmetricDifferenceCard (left right : Base) : Nat :=
  ((List.range 6).filter (fun i => member left i != member right i)).length

/-- Every legal initial pair is at distance at most six (three exchanges). -/
theorem symmetric_difference_bound :
    ∀ left right : Fin 64, symmetricDifferenceCard left.val right.val ≤ 6 := by
  intro left right
  simpa [symmetricDifferenceCard] using
    (List.length_filter_le (fun i => member left.val i != member right.val i) (List.range 6))

noncomputable def legalMasks : List (Fin 64) := (List.finRange 64).filter (fun s => isBase s.val)

noncomputable def selectedStepCheck (left right : Base) : Bool :=
  match exchange left right with
  | none => false
  | some (i, j) =>
    symmetricDifferenceCard (replace left i j) right + 2 == symmetricDifferenceCard left right &&
    symmetricDifferenceCard left (replace right j i) + 2 == symmetricDifferenceCard left right

/-- Complete 20-by-20 base-pair certificate, lifted to all masks below. -/
theorem all_legal_selected_steps :
    legalMasks.all (fun left => legalMasks.all (fun right =>
      left.val == right.val || selectedStepCheck left.val right.val)) = true := by
  decide +kernel

/-- The actual lexicographic choice reduces the distance by two in both branches. -/
theorem every_selected_exchange_decreases_two :
    ∀ left right : Fin 64,
      isBase left.val = true → isBase right.val = true → left.val ≠ right.val →
      match exchange left.val right.val with
      | none => False
      | some (i, j) =>
        symmetricDifferenceCard (replace left.val i j) right.val + 2 =
          symmetricDifferenceCard left.val right.val ∧
        symmetricDifferenceCard left.val (replace right.val j i) + 2 =
          symmetricDifferenceCard left.val right.val := by
  intro left right hl hr hne
  have hleft : left ∈ legalMasks :=
    List.mem_filter.mpr ⟨List.mem_finRange left, hl⟩
  have hright : right ∈ legalMasks :=
    List.mem_filter.mpr ⟨List.mem_finRange right, hr⟩
  have row := List.all_eq_true.mp all_legal_selected_steps left hleft
  have pair := List.all_eq_true.mp row right hright
  have good : selectedStepCheck left.val right.val = true := by
    simpa [hne] using pair
  cases h : exchange left.val right.val with
  | none => simp [selectedStepCheck, h] at good
  | some ij =>
    rcases ij with ⟨i, j⟩
    simpa [selectedStepCheck, h] using good

#print axioms basis_family_nonempty
#print axioms uniform_symmetric_basis_exchange
#print axioms symmetric_difference_bound
#print axioms all_legal_selected_steps
#print axioms every_selected_exchange_decreases_two

end

end SwapRounding
