import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace GeneralQutritCoolingResearchProof1

/-- Fisher-norm / dissipation form of the qutrit moment inequality.

If the row moments `m` and mean squared shifts `s` (relative to the system
probabilities `p`) satisfy `3 * ∑ p i * m i ^ 2 ≤ 2 * ∑ p i * s i`, then the
local second-order dissipation `(1/2) * ∑ p i * (s i - m i ^ 2)` is at least
`(1/4) * ∑ p i * m i ^ 2`, i.e. `Q ≥ ‖δ‖_F^2 / 4`. -/
theorem qutrit_surplus_fisher (p m s : Fin 3 → ℝ)
    (h : 3*(∑ i, p i*(m i)^2) ≤ 2*(∑ i, p i*s i)) :
    (∑ i, p i*(m i)^2)/4 ≤ (∑ i, p i*(s i-(m i)^2))/2 := by
  simp_rw [mul_sub, Finset.sum_sub_distrib]
  linarith only [h]

end GeneralQutritCoolingResearchProof1
