import Mathlib.Analysis.MeanInequalities
import Mathlib.Tactic.NormNum

open scoped BigOperators

namespace ModularMagnetizationMagicResearchProof1

/-- The unnormalized finite Hölder step in equation (14). -/
theorem finite_eighth_power {ι : Type*} (s : Finset ι) (x : ι → ℝ)
    (hx : ∀ i ∈ s, 0 ≤ x i) :
    (∑ i ∈ s, x i) ^ 8 ≤ (s.card : ℝ) ^ 7 * (∑ i ∈ s, (x i) ^ 8) := by
  have h := Real.rpow_sum_le_const_mul_sum_rpow_of_nonneg
    (s := s) (f := x) (p := (8 : ℝ)) (by norm_num) hx
  have he : (8 : ℝ) - 1 = (7 : ℕ) := by norm_num
  rw [he, Real.rpow_natCast, show (8 : ℝ) = (8 : ℕ) by norm_num,
    Real.rpow_natCast] at h
  simpa only [Real.rpow_natCast] using h

end ModularMagnetizationMagicResearchProof1
