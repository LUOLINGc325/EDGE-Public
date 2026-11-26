import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Ring.Finset

universe u
open scoped BigOperators
namespace GaussianFrequencyGradientVarianceResearchProof1

theorem finite_mode_cauchy_schwarz {ι : Type u} (modes : Finset ι) (weight mass : ι → ℝ) :
         (∑ k ∈ modes, weight k * mass k)^2
         ≤ (∑ k ∈ modes, (weight k)^2) * (∑ k ∈ modes, (mass k)^2) := by
  have cs := Finset.sum_mul_sq_le_sq_mul_sq modes weight mass
  simpa only [pow_two] using cs

end GaussianFrequencyGradientVarianceResearchProof1
