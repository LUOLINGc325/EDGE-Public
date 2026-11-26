import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

open scoped BigOperators

namespace QuantumChannelProductBoundUniversalityResearchProof2

theorem normalized_pair_complement {ι : Type*} (S : Finset (ι × ι)) (p : ι → ℝ) (r : ℝ) : (∑ t ∈ S, (r*p t.1+r*p t.2-(r*p t.1)*(r*p t.2))) = r*((1-r)*(∑ t ∈ S, (p t.1+p t.2)) + r*(∑ t ∈ S,(p t.1+p t.2-p t.1*p t.2))) := by
  have hpoint (t : ι × ι) :
      r*p t.1+r*p t.2-(r*p t.1)*(r*p t.2) =
        r*((1-r)*(p t.1+p t.2)+r*(p t.1+p t.2-p t.1*p t.2)) := by ring
  simp_rw [hpoint]
  rw [← Finset.mul_sum, Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum]

end QuantumChannelProductBoundUniversalityResearchProof2
