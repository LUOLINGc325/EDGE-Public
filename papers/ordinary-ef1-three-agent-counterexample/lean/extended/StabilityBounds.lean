import Semantics

open scoped BigOperators
noncomputable section
namespace OrdinaryEF1

/-- Independent perturbations of every observer/recipient/item entry. -/
noncomputable def closeProfile {n m : ℕ} (u v : Fin n → Fin n → Fin m → ℝ) (ε : ℝ) : Prop :=
  ∀ i r x, |v i r x - u i r x| < ε

theorem contribution_perturbation_bound {n m : ℕ}
    (u v : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n)
    (i j : Fin n) (x : Fin m) (ε : ℝ) (h : closeProfile u v ε) :
    |contribution v A i j x - contribution u A i j x| < 2 * ε := by
  obtain ⟨h₁, h₂⟩ := abs_lt.mp (h i (swapRecipient i j (A x)) x)
  obtain ⟨h₃, h₄⟩ := abs_lt.mp (h i (A x) x)
  unfold contribution
  apply abs_lt.mpr
  constructor <;> linarith

/-- Two items remain after a deletion, whereas no deletion retains three.
This distinguishes the two error budgets in Section 6 of the manuscript. -/
theorem three_item_gap_perturbation_bound {n : ℕ}
    (u v : Fin n → Fin n → Fin 3 → ℝ) (A : Fin 3 → Fin n)
    (i j : Fin n) (d : Fin 4) (ε : ℝ) (h : closeProfile u v ε) :
    |gap v A i j d - gap u A i j d| <
      if d.val = 3 then 6 * ε else 4 * ε := by
  have h0 := abs_lt.mp (contribution_perturbation_bound u v A i j 0 ε h)
  have h1 := abs_lt.mp (contribution_perturbation_bound u v A i j 1 ε h)
  have h2 := abs_lt.mp (contribution_perturbation_bound u v A i j 2 ε h)
  dsimp [contribution] at h0 h1 h2
  fin_cases d <;> norm_num [gap, Fin.sum_univ_three, Fin.ext_iff]
  all_goals apply abs_lt.mpr
  all_goals constructor <;> linarith

end OrdinaryEF1
