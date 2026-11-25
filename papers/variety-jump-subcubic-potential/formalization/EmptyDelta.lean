import SubcubicDefs
import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise

set_option autoImplicit false
set_option linter.unusedSectionVars false
open scoped BigOperators

namespace Subcubic

universe u v
variable {V : Type u} {C : Type v}
variable [Fintype V] [DecidableEq V] [Fintype C] [DecidableEq C]

/-- The empty-edge count is supported precisely on pairs of vacant vertices. -/
theorem emptyArcs_eq_sum_holes (G : Graph V) (q : Coloring V C) :
    emptyArcs G q = ∑ x ∈ holes q, ∑ y ∈ holes q,
      (if Adj G x y then 1 else 0) := by
  unfold emptyArcs
  simp only [holes, Finset.sum_filter]
  apply Finset.sum_congr rfl
  intro x hxmem
  by_cases hx : q x = none
  · simp only [hx, if_true]
    apply Finset.sum_congr rfl
    intro y hymem
    by_cases hy : q y = none <;> simp [emptyTerm, hx, hy]
  · simp [emptyTerm, hx]

/-- With exactly the two distinct vacancies a and b, the ordered empty-edge
count equals twice their adjacency indicator. -/
theorem emptyArcs_two_holes (G : Graph V) (q : Coloring V C) (a b : V)
    (hab : a ≠ b) (hholes : holes q = {a, b}) :
    emptyArcs G q = 2 * (if Adj G a b then 1 else 0) := by
  rw [emptyArcs_eq_sum_holes, hholes]
  by_cases hedge : G.edge a b = true <;>
    simp [Finset.sum_insert, hab, Ne.symm hab, Adj, G.loopless,
      G.symmetric b a, hedge]

/-- Integer form used when subtracting the old and new potentials. -/
theorem emptyArcs_two_holes_int (G : Graph V) (q : Coloring V C) (a b : V)
    (hab : a ≠ b) (hholes : holes q = {a, b}) :
    (emptyArcs G q : ℤ) = 2 * (if Adj G a b then 1 else 0) := by
  rw [emptyArcs_two_holes G q a b hab hholes]
  split <;> simp_all

end Subcubic
