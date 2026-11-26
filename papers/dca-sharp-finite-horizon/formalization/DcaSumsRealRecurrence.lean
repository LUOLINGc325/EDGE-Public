import Lean.Elab.Tactic.Omega
import DcaCriticalSums
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Algebra.GeomSum
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

/-!
# DCASharpResidual

This module formalizes the elementary scalar identity used in the sharp finite-horizon
DCA analysis (manuscript equation (2), and the recurrence quoted in the proof of
Lemma 3.1).  With `E_j(t) = ∑_{ℓ=1}^{2j} t^{-ℓ}` and `E_0(t)=0`, one has for `t ≠ 0`

  `E (j+1) t = (E j t + 1 + t) / t^2`.

The proof splits off the first two terms of the finite geometric-type sum using
`Finset.sum_range_add`, then reindexes and factors with `pow_add`.

This is an exact sublemma of the manuscript's scalar bookkeeping and is labelled as
such: it does not claim the full Theorem 1.1 (the DCA finite-horizon bound), which
requires the certificate transfer and all-parameter sign analysis.
-/

namespace DCASharpResidual

theorem E_recurrence (j : ℕ) (t : ℝ) (ht : t ≠ 0) :
    E (j + 1) t = (E j t + 1 + t) / t ^ 2 := by
  have h2 : 2 * (j + 1) = 2 + 2 * j := by ring
  rw [E, h2, Finset.sum_range_add, E]
  -- The shifted block is `∑ i ∈ range(2j), (t⁻¹)^(i+1+2)`.
  have hshift : (∑ i ∈ Finset.range (2 * j), (t⁻¹) ^ (2 + i + 1))
      = (t⁻¹) ^ 2 * ∑ i ∈ Finset.range (2 * j), (t⁻¹) ^ (i + 1) := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i _
    rw [show 2 + i + 1 = 2 + (i+1) by omega, pow_add]
  have hfirst : (∑ i ∈ Finset.range 2, (t⁻¹) ^ (i + 1)) = t⁻¹ + (t⁻¹) ^ 2 := by
    simp [Finset.sum_range_succ]
  rw [hfirst, hshift]
  field_simp [ht]
  ring

theorem E_horizon_one (t : ℝ) : E 1 t = t⁻¹ + (t⁻¹) ^ 2 := by
  have : E 1 t = ∑ i ∈ Finset.range 2, (t⁻¹) ^ (i + 1) := by
    simp [E]
  rw [this, Finset.sum_range_succ, Finset.sum_range_one]
  ring

end DCASharpResidual
