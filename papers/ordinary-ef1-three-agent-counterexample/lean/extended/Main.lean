import AllocationBridge
import Family
import Numeric
import TwoItems
import TwoAgents
import Stability

open scoped BigOperators
noncomputable section
namespace OrdinaryEF1

/-- Theorem 1 expressed in the original utility/partition semantics. -/
theorem integer_counterexample_original_definition :
    ¬ ∃ A : Fin 3 → Fin 3, semanticEF1 (cyclicProfile 2 1 2 2) A := by
  rintro ⟨A, hA⟩
  exact integer_counterexample ⟨A, (EF1_iff_original_definition _ A).mpr hA⟩

/-- The existence side includes all equality boundaries of Theorem 2. -/
theorem exact_existence_region {a b g z : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hg : 0 < g) (hz : 0 < z) :
    (∃ A : Fin 3 → Fin 3, EF1 (cyclicProfile a b g z) A) ↔
      a = b ∨ min g z ≤ min a b := by
  classical
  have h := not_congr (exact_nonexistence_region ha hb hg hz)
  simpa only [not_not, not_and_or, not_lt] using h

/-- Lemma 3 also holds with the manuscript's arbitrary deletion set. -/
theorem at_most_two_items_original_definition {n m : ℕ} (hn : 0 < n) (hm : m ≤ 2)
    (u : Fin n → Fin n → Fin m → ℝ) :
    ∃ A : Fin m → Fin n, semanticEF1 u A := by
  obtain ⟨A, hA⟩ := at_most_two_items_exists_EF1 hn hm u
  exact ⟨A, (EF1_iff_original_definition u A).mp hA⟩

/-- Lemma 4 in the original definition, for arbitrary signed real utilities. -/
theorem two_agents_original_definition (m : ℕ)
    (u : Fin 2 → Fin 2 → Fin m → ℝ) :
    ∃ A : Fin m → Fin 2, semanticEF1 u A := by
  obtain ⟨A, hA⟩ := two_agents_exists_EF1 m u
  exact ⟨A, (EF1_iff_original_definition u A).mp hA⟩

theorem nonexistence_requires_three_agents {n m : ℕ} (hn : 0 < n)
    (u : Fin n → Fin n → Fin m → ℝ)
    (h : ¬ ∃ A : Fin m → Fin n, EF1 u A) : 3 ≤ n := by
  by_contra hsmall
  have hn' : n = 1 ∨ n = 2 := by omega
  rcases hn' with rfl | rfl
  · exact h (one_agent_exists_EF1 u)
  · exact h (two_agents_exists_EF1 m u)

theorem nonexistence_requires_three_items {n m : ℕ} (hn : 0 < n)
    (u : Fin n → Fin n → Fin m → ℝ)
    (h : ¬ ∃ A : Fin m → Fin n, EF1 u A) : 3 ≤ m := by
  by_contra hsmall
  have hm : m ≤ 2 := by omega
  exact h (at_most_two_items_exists_EF1 hn hm u)

/-- Corollary 5: the same 3-by-3 instance attains both universal lower bounds.
The usual nonempty-agent convention is explicit in the minimality assertion. -/
theorem simultaneous_minimality :
    (¬ ∃ A : Fin 3 → Fin 3, EF1 (cyclicProfile 2 1 2 2) A) ∧
    ∀ (n m : ℕ), 0 < n → ∀ u : Fin n → Fin n → Fin m → ℝ,
      (¬ ∃ A : Fin m → Fin n, EF1 u A) → 3 ≤ n ∧ 3 ≤ m := by
  refine ⟨integer_counterexample, ?_⟩
  intro n m hn u h
  exact ⟨nonexistence_requires_three_agents hn u h,
    nonexistence_requires_three_items hn u h⟩

#print axioms integer_counterexample_original_definition
#print axioms exact_existence_region
#print axioms simultaneous_minimality

end OrdinaryEF1
