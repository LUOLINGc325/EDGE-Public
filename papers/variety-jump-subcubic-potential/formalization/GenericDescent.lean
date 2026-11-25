import Lean.Elab.Tactic.Omega
import Mathlib.Logic.Relation

/-!
# Natural-valued descent

These lemmas use no finiteness assumption on the state space. They isolate the
well-founded argument needed after the graph-level potential inequality has been
proved. A finite prefix of `N` transitions loses at least `N` units of potential.
-/

set_option autoImplicit false

namespace Descent

universe u

variable {State : Type u}
variable (R : State → State → Prop) (P : State → Prop) (potential : State → Nat)

/-- An invariant and a natural potential control every finite prefix of a path. -/
theorem finite_prefix_budget
    (preserve : ∀ s t, P s → R s t → P t)
    (decrease : ∀ s t, P s → R s t → potential t < potential s)
    (q : Nat → State) (N : Nat)
    (initial : P (q 0))
    (steps : ∀ n, n < N → R (q n) (q (n + 1))) :
    ∀ k, k ≤ N → P (q k) ∧ k + potential (q k) ≤ potential (q 0) := by
  intro k
  induction k with
  | zero =>
    intro _
    exact ⟨initial, by omega⟩
  | succ k ih =>
    intro hk
    have hkN : k < N := by omega
    obtain ⟨hkP, hkBudget⟩ := ih (by omega)
    have hstep := steps k hkN
    have hnextP := preserve (q k) (q (k + 1)) hkP hstep
    have hdrop := decrease (q k) (q (k + 1)) hkP hstep
    exact ⟨hnextP, by omega⟩

/-- The number of strict improvement steps is bounded by the initial potential. -/
theorem finite_path_length_le
    (preserve : ∀ s t, P s → R s t → P t)
    (decrease : ∀ s t, P s → R s t → potential t < potential s)
    (q : Nat → State) (N : Nat)
    (initial : P (q 0))
    (steps : ∀ n, n < N → R (q n) (q (n + 1))) :
    N ≤ potential (q 0) := by
  have h := finite_prefix_budget R P potential preserve decrease q N initial steps N
    (Nat.le_refl N)
  omega

/-- A two-unit decrease gives the sharper budget for the doubled graph potential. -/
theorem finite_prefix_budget_two
    (preserve : ∀ s t, P s → R s t → P t)
    (decreaseTwo : ∀ s t, P s → R s t → potential t + 2 ≤ potential s)
    (q : Nat → State) (N : Nat)
    (initial : P (q 0))
    (steps : ∀ n, n < N → R (q n) (q (n + 1))) :
    ∀ k, k ≤ N → P (q k) ∧ 2 * k + potential (q k) ≤ potential (q 0) := by
  intro k
  induction k with
  | zero =>
    intro _
    exact ⟨initial, by omega⟩
  | succ k ih =>
    intro hk
    have hkN : k < N := by omega
    obtain ⟨hkP, hkBudget⟩ := ih (by omega)
    have hstep := steps k hkN
    have hnextP := preserve (q k) (q (k + 1)) hkP hstep
    have hdrop := decreaseTwo (q k) (q (k + 1)) hkP hstep
    exact ⟨hnextP, by omega⟩

/-- A path of two-unit decreases has length at most floor(initial potential / 2). -/
theorem finite_path_length_le_half
    (preserve : ∀ s t, P s → R s t → P t)
    (decreaseTwo : ∀ s t, P s → R s t → potential t + 2 ≤ potential s)
    (q : Nat → State) (N : Nat)
    (initial : P (q 0))
    (steps : ∀ n, n < N → R (q n) (q (n + 1))) :
    N ≤ potential (q 0) / 2 := by
  have h := finite_prefix_budget_two R P potential preserve decreaseTwo q N initial steps N
    (Nat.le_refl N)
  omega

/-- No infinite path starts from a state satisfying the invariant. -/
theorem no_infinite_sequence
    (preserve : ∀ s t, P s → R s t → P t)
    (decrease : ∀ s t, P s → R s t → potential t < potential s) :
    ¬ ∃ q : Nat → State, P (q 0) ∧ ∀ n, R (q n) (q (n + 1)) := by
  intro h
  obtain ⟨q, initial, steps⟩ := h
  have hlen := finite_path_length_le R P potential preserve decrease q
    (potential (q 0) + 1) initial (fun n _ => steps n)
  omega

/-- From each invariant state a terminal state is reachable by finitely many moves. -/
theorem exists_reachable_terminal
    (preserve : ∀ s t, P s → R s t → P t)
    (decrease : ∀ s t, P s → R s t → potential t < potential s)
    (s : State) (initial : P s) :
    ∃ t, Relation.ReflTransGen R s t ∧ P t ∧ ∀ u, ¬ R t u := by
  suffices h : ∀ n : Nat, ∀ a : State, potential a = n → P a →
      ∃ t, Relation.ReflTransGen R a t ∧ P t ∧ ∀ u, ¬ R t u by
    exact h (potential s) s rfl initial
  intro n
  induction n using Nat.strongRecOn with
  | ind n ih =>
    intro a hvalue ha
    classical
    by_cases terminal : ∀ t, ¬ R a t
    · exact ⟨a, Relation.ReflTransGen.refl, ha, terminal⟩
    · have hasNext : ∃ b, R a b := by
        apply Classical.byContradiction
        intro hnone
        apply terminal
        intro b hab
        exact hnone ⟨b, hab⟩
      obtain ⟨b, hab⟩ := hasNext
      have hbP := preserve a b ha hab
      have hbLt : potential b < n := by
        have hdrop := decrease a b ha hab
        omega
      obtain ⟨t, hbt, htP, htTerminal⟩ := ih (potential b) hbLt b rfl hbP
      exact ⟨t, hbt.head hab, htP, htTerminal⟩

end Descent

#print axioms Descent.finite_prefix_budget
#print axioms Descent.finite_path_length_le
#print axioms Descent.finite_prefix_budget_two
#print axioms Descent.finite_path_length_le_half
#print axioms Descent.no_infinite_sequence
#print axioms Descent.exists_reachable_terminal

