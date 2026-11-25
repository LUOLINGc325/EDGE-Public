import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.Order.BigOperators.Ring.Finset

open scoped BigOperators

namespace AnnealedFrequencyReduction

theorem slow_crossing_monotone {ι : Type*} [Fintype ι] [Nonempty ι] (a : ι → ℝ) (ha : ∀ i, 0<a i) (x y : ℝ) (hx : ∀ i, 0<1+a i*x) (hxy : x<y) : (∏ i, (1+a i*x)) < ∏ i, (1+a i*y) := by
  apply Finset.prod_lt_prod_of_nonempty
  · intro i _
    exact hx i
  · intro i _
    exact add_lt_add_left (mul_lt_mul_of_pos_left hxy (ha i)) 1
  · exact Finset.univ_nonempty

end AnnealedFrequencyReduction
