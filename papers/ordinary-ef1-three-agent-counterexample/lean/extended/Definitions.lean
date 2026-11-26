import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Finset.Max
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

open scoped BigOperators
noncomputable section
namespace OrdinaryEF1

noncomputable def swapRecipient {n : ℕ} (i j r : Fin n) : Fin n :=
  if r = i then j else if r = j then i else r

-- Allocation is a total function from items to recipients.
-- Deletion code m means no item is deleted; 0,...,m-1 delete exactly one.
noncomputable def gap {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) (i j : Fin n) (d : Fin (m + 1)) : ℝ :=
  ∑ x : Fin m, if d.val = x.val then 0
    else u i (swapRecipient i j (A x)) x - u i (A x) x

noncomputable def EF1 {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) : Prop :=
  ∀ i j : Fin n, i ≠ j → ∃ d : Fin (m + 1), gap u A i j d ≤ 0


end OrdinaryEF1
