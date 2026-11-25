import SubcubicPotential
import GenericDescent
import SubcubicBounds

set_option autoImplicit false
set_option linter.unusedSectionVars false

namespace Subcubic
universe u v
variable {V : Type u} {C : Type v}
variable [Fintype V] [DecidableEq V] [Fintype C] [DecidableEq C]

/-- Every finite simple graph of maximum degree at most three has the
finite improvement property for variety jumps with exactly two vacant vertices. -/
theorem subcubic_fip (G : Graph V) (hmax : MaxDegreeThree G) :
    FiniteImprovementProperty (C := C) G := by
  exact Descent.no_infinite_sequence (Improves G)
    (fun q : Coloring V C => (holes q).card = 2) (potential G)
    (improves_preserves_two_holes G)
    (fun q q' hh hstep => by have h := potential_drop G hmax q q' hh hstep; omega)

/-- Every prefix has a budget at the rate of two potential units per move. -/
theorem improvement_prefix_budget (G : Graph V) (hmax : MaxDegreeThree G)
    (q : Nat → Coloring V C) (N : Nat) (hholes : (holes (q 0)).card = 2)
    (hsteps : ∀ n, n < N → Improves G (q n) (q (n + 1))) :
    ∀ k, k ≤ N → (holes (q k)).card = 2 ∧
      2 * k + potential G (q k) ≤ potential G (q 0) := by
  exact Descent.finite_prefix_budget_two (Improves G)
    (fun q : Coloring V C => (holes q).card = 2) (potential G)
    (improves_preserves_two_holes G) (potential_drop G hmax) q N hholes hsteps

/-- Every improvement path has length at most half the initial doubled potential. -/
theorem improvement_path_length_le_half (G : Graph V) (hmax : MaxDegreeThree G)
    (q : Nat → Coloring V C) (N : Nat) (hholes : (holes (q 0)).card = 2)
    (hsteps : ∀ n, n < N → Improves G (q n) (q (n + 1))) :
    N ≤ potential G (q 0) / 2 := by
  exact Descent.finite_path_length_le_half (Improves G)
    (fun q : Coloring V C => (holes q).card = 2) (potential G)
    (improves_preserves_two_holes G) (potential_drop G hmax) q N hholes hsteps

/-- A uniform linear upper bound on every improvement path. -/
theorem improvement_path_length_linear (G : Graph V) (hmax : MaxDegreeThree G)
    (q : Nat → Coloring V C) (N : Nat) (hholes : (holes (q 0)).card = 2)
    (hsteps : ∀ n, n < N → Improves G (q n) (q (n + 1))) :
    N ≤ 6 * Fintype.card V + 36 := by
  exact (improvement_path_length_le_half G hmax q N hholes hsteps).trans
    (half_potential_linear_bound G (q 0) hmax hholes)

/-- A pure equilibrium is reachable from each specified initial state.
Reachability fixes the initial population; no minimization over all populations occurs. -/
theorem exists_reachable_equilibrium (G : Graph V) (hmax : MaxDegreeThree G)
    (q : Coloring V C) (hholes : (holes q).card = 2) :
    ∃ q', Relation.ReflTransGen (Improves G) q q' ∧
      (holes q').card = 2 ∧ Equilibrium G q' := by
  exact Descent.exists_reachable_terminal (Improves G)
    (fun q : Coloring V C => (holes q).card = 2) (potential G)
    (improves_preserves_two_holes G)
    (fun q q' hh hstep => by have h := potential_drop G hmax q q' hh hstep; omega)
    q hholes

end Subcubic
