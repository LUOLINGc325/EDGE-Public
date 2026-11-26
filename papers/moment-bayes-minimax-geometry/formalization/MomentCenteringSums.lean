import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Tactic.FieldSimp

namespace MomentBayesMinimaxGeometryResearchProof2

/-- Centered-sum identity for the arithmetic centroid of a nonempty finset:
the deviations of the coordinates from the centroid sum to zero. This is the
coordinate-wise identity used in the square expansion in the proof of (60). -/
theorem centroid_coordinate_sum {ι : Type*} (s : Finset ι) (hs : s.Nonempty)
    (c : ι → ℝ) :
    (∑ i ∈ s, (c i - (∑ j ∈ s, c j) / (s.card : ℝ))) = 0 := by
  have hcard : (s.card : ℝ) ≠ 0 := by
    exact_mod_cast Finset.card_ne_zero.mpr hs
  rw [Finset.sum_sub_distrib, Finset.sum_const, nsmul_eq_mul]
  have hcount : (s.card : ℝ) * ((∑ j ∈ s, c j) / (s.card : ℝ)) = ∑ j ∈ s, c j := by
    field_simp
  rw [hcount, sub_self]

end MomentBayesMinimaxGeometryResearchProof2
