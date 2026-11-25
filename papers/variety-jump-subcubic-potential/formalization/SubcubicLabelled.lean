import SubcubicTheorems
import LabelledProjection

set_option autoImplicit false
set_option linter.unusedSectionVars false

namespace Subcubic
universe u v w
variable {V : Type u} {C : Type v} {A : Type w}
variable [Fintype V] [DecidableEq V] [Fintype C] [DecidableEq C] [DecidableEq A]

/-- The graph potential decreases on each move of an identified agent. -/
theorem labelled_potential_drop (G : Graph V) (hmax : MaxDegreeThree G)
    (typeOf : A → C) (q q' : V → Option A) (hholes : (holes q).card = 2)
    (hstep : LabelledImproves G typeOf q q') :
    potential G (project typeOf q') + 2 ≤ potential G (project typeOf q) := by
  apply potential_drop G hmax (project typeOf q) (project typeOf q')
  · simpa only [holes_project] using hholes
  · exact labelled_improves_project G typeOf q q' hstep

theorem labelled_preserves_two_holes (G : Graph V) (typeOf : A → C)
    (q q' : V → Option A) (hholes : (holes q).card = 2)
    (hstep : LabelledImproves G typeOf q q') : (holes q').card = 2 := by
  have hh : (holes (project typeOf q)).card = 2 := by
    simpa only [holes_project] using hholes
  have h := improves_preserves_two_holes G (project typeOf q) (project typeOf q') hh
    (labelled_improves_project G typeOf q q' hstep)
  simpa only [holes_project] using h

/-- This strong form even allows malformed label states; in particular it covers
all placements in which every identified agent occurs exactly once. -/
theorem labelled_no_infinite_improvement (G : Graph V) (hmax : MaxDegreeThree G)
    (typeOf : A → C) :
    ¬ ∃ q : Nat → (V → Option A), (holes (q 0)).card = 2 ∧
      ∀ n, LabelledImproves G typeOf (q n) (q (n + 1)) := by
  exact Descent.no_infinite_sequence (LabelledImproves G typeOf)
    (fun q : V → Option A => (holes q).card = 2)
    (fun q => potential G (project typeOf q))
    (labelled_preserves_two_holes G typeOf)
    (fun q q' hh hstep => by
      change potential G (project typeOf q') < potential G (project typeOf q)
      have h := labelled_potential_drop G hmax typeOf q q' hh hstep
      omega)

/-- Finite-prefix potential budget for actual identified-agent paths. -/
theorem labelled_improvement_prefix_budget (G : Graph V) (hmax : MaxDegreeThree G)
    (typeOf : A → C) (q : Nat → (V → Option A)) (N : Nat)
    (hholes : (holes (q 0)).card = 2)
    (hsteps : ∀ n, n < N → LabelledImproves G typeOf (q n) (q (n + 1))) :
    ∀ k, k ≤ N → (holes (q k)).card = 2 ∧
      2 * k + potential G (project typeOf (q k)) ≤ potential G (project typeOf (q 0)) := by
  exact Descent.finite_prefix_budget_two (LabelledImproves G typeOf)
    (fun q : V → Option A => (holes q).card = 2)
    (fun q => potential G (project typeOf q))
    (labelled_preserves_two_holes G typeOf) (labelled_potential_drop G hmax typeOf)
    q N hholes hsteps

theorem labelled_improvement_path_length_le_half (G : Graph V) (hmax : MaxDegreeThree G)
    (typeOf : A → C) (q : Nat → (V → Option A)) (N : Nat)
    (hholes : (holes (q 0)).card = 2)
    (hsteps : ∀ n, n < N → LabelledImproves G typeOf (q n) (q (n + 1))) :
    N ≤ potential G (project typeOf (q 0)) / 2 := by
  exact Descent.finite_path_length_le_half (LabelledImproves G typeOf)
    (fun q : V → Option A => (holes q).card = 2)
    (fun q => potential G (project typeOf q))
    (labelled_preserves_two_holes G typeOf) (labelled_potential_drop G hmax typeOf)
    q N hholes hsteps

theorem labelled_improvement_path_length_linear (G : Graph V) (hmax : MaxDegreeThree G)
    (typeOf : A → C) (q : Nat → (V → Option A)) (N : Nat)
    (hholes : (holes (q 0)).card = 2)
    (hsteps : ∀ n, n < N → LabelledImproves G typeOf (q n) (q (n + 1))) :
    N ≤ 6 * Fintype.card V + 36 := by
  have hhalf := labelled_improvement_path_length_le_half G hmax typeOf q N hholes hsteps
  have hh : (holes (project typeOf (q 0))).card = 2 := by
    simpa only [holes_project] using hholes
  exact hhalf.trans (half_potential_linear_bound G (project typeOf (q 0)) hmax hh)

/-- Starting from any specified well-formed placement, a well-formed pure
Nash equilibrium of the same identified agents is reachable by improvement moves. -/
theorem labelled_exists_reachable_equilibrium (G : Graph V) (hmax : MaxDegreeThree G)
    (typeOf : A → C) (q : V → Option A) (hWF : WellFormed q)
    (hholes : (holes q).card = 2) :
    ∃ q', Relation.ReflTransGen (LabelledImproves G typeOf) q q' ∧
      WellFormed q' ∧ (holes q').card = 2 ∧ ∀ r, ¬ LabelledImproves G typeOf q' r := by
  have preserve : ∀ s t : V → Option A,
      WellFormed s ∧ (holes s).card = 2 → LabelledImproves G typeOf s t →
      WellFormed t ∧ (holes t).card = 2 := by
    intro s t h hstep
    exact ⟨labelled_preserves_wellFormed G typeOf s t h.1 hstep,
      labelled_preserves_two_holes G typeOf s t h.2 hstep⟩
  have decrease : ∀ s t : V → Option A,
      WellFormed s ∧ (holes s).card = 2 → LabelledImproves G typeOf s t →
      potential G (project typeOf t) < potential G (project typeOf s) := by
    intro s t h hstep
    have hd := labelled_potential_drop G hmax typeOf s t h.2 hstep
    omega
  obtain ⟨r, hreach, hr, hterminal⟩ :=
    Descent.exists_reachable_terminal (LabelledImproves G typeOf)
      (fun q : V → Option A => WellFormed q ∧ (holes q).card = 2)
      (fun q => potential G (project typeOf q)) preserve decrease q ⟨hWF, hholes⟩
  exact ⟨r, hreach, hr.1, hr.2, hterminal⟩

end Subcubic
