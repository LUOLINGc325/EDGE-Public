import SubcubicDefs
import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise
import Mathlib.Algebra.BigOperators.Ring.Finset

set_option autoImplicit false
set_option linter.unusedSectionVars false
open scoped BigOperators

namespace Subcubic

universe u v
variable {V : Type u} {C : Type v}
variable [Fintype V] [DecidableEq V] [Fintype C] [DecidableEq C]

/-- Inserting one color into an empty vertex adds precisely its outgoing and
incoming same-color edges. The empty diagonal cannot be counted twice. -/
theorem monoTerm_put (G : Graph V) (q : Coloring V C) (x : V) (c : C)
    (hx : q x = none) (y z : V) :
    monoTerm G (put q x c) y z = monoTerm G q y z +
      (if y = x then (if Adj G x z ∧ q z = some c then 1 else 0) else 0) +
      (if z = x then (if Adj G x y ∧ q y = some c then 1 else 0) else 0) := by
  by_cases hy : y = x
  · subst y
    by_cases hz : z = x
    · subst z
      simp [monoTerm, put, Adj, G.loopless, hx]
    · by_cases hc : q z = some c
      · simp [monoTerm, put, Function.update_apply, hz, Ne.symm hz, hx, hc]
      · have hn : some c ≠ q z := Ne.symm hc
        simp [monoTerm, put, Function.update_apply, hz, Ne.symm hz, hx, hc, hn]
  · by_cases hz : z = x
    · subst z
      by_cases hc : q y = some c
      · have hn : q y ≠ none := by simp [hc]
        simp [monoTerm, put, Function.update_apply, hy, Ne.symm hy, hx, hc, hn,
          Adj, G.symmetric y x]
      · simp [monoTerm, put, Function.update_apply, hy, Ne.symm hy, hx, hc]
    · simp [monoTerm, put, Function.update_apply, hy, Ne.symm hy, hz, Ne.symm hz]

/-- Natural-valued version of the insertion identity for ordered mono edges. -/
theorem monoArcs_put_nat (G : Graph V) (q : Coloring V C) (x : V) (c : C)
    (hx : q x = none) :
    monoArcs G (put q x c) = monoArcs G q + 2 * sameCount G q c x := by
  have hcount : (∑ y : V, if Adj G x y ∧ q y = some c then 1 else 0) =
      sameCount G q c x := by
    simp [sameCount, sameNeighbors, neighbors, Finset.filter_filter]
  unfold monoArcs
  simp_rw [monoTerm_put G q x c hx]
  simp only [Finset.sum_add_distrib]
  simp only [Finset.sum_ite_irrel, Finset.sum_const_zero, Finset.sum_ite_eq',
    Finset.mem_univ, if_true]
  rw [hcount]
  omega

/-- Integer-valued insertion identity. This is the graph counting bridge needed
for the change 2*(md-ms) under a legal jump. -/
theorem monoArcs_put (G : Graph V) (q : Coloring V C) (x : V) (c : C)
    (hx : q x = none) :
    (monoArcs G (put q x c) : ℤ) = (monoArcs G q : ℤ) +
      2 * (sameCount G q c x : ℤ) := by
  rw [monoArcs_put_nat G q x c hx]
  simp

end Subcubic
