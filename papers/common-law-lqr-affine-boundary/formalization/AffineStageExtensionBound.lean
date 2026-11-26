import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

universe u
namespace CommonLawLqrAffineBoundaryResearchProof1

theorem affine_stage_fraction_bound (t x v : ℝ) (ht : 0 < t) (hx : 0 ≤ x) (hv : 0 ≤ v) :
         0 ≤ x*v/(v+t*x) ∧ x*v/(v+t*x) ≤ min x (v/t) := by
  have ht0 := ht.le
  have htx : 0 ≤ t*x := mul_nonneg ht0 hx
  have hden : 0 ≤ v+t*x := add_nonneg hv htx
  have hvt : 0 ≤ v/t := div_nonneg hv ht0
  refine ⟨div_nonneg (mul_nonneg hx hv) hden, ?_⟩
  by_cases hzero : v+t*x = 0
  · simp only [hzero, div_zero]
    exact le_min hx hvt
  have hd : 0 < v+t*x := lt_of_le_of_ne hden (Ne.symm hzero)
  apply le_min <;> apply (div_le_iff₀ hd).mpr
  · nlinarith only [mul_nonneg ht0 (sq_nonneg x)]
  · have hsplit : v/t*(v+t*x) = v^2/t+x*v := by
      field_simp [ne_of_gt ht]
      ring
    rw [hsplit]
    linarith only [div_nonneg (sq_nonneg v) ht0]

end CommonLawLqrAffineBoundaryResearchProof1
