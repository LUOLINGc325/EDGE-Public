import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace GaffkeDeltaSharpBoundResearchProof1

/-- Monotonicity of the finite Laplace product
`λ ↦ ∏ i ∈ S, (1 + λ * d i)⁻¹` in the rate `λ ≥ 0`, for nonnegative weights `d`.
This is the bridge used in the same-`K` compression argument: the map
`λ ↦ L(λ)/(1+λ)` is decreasing, hence comparing the target value `D` forces
`λ* ≥ λ`. -/
theorem laplace_product_antitone {ι : Type u} (S : Finset ι) (d : ι → ℝ)
    (l₁ l₂ : ℝ) (hl₁ : 0 ≤ l₁) (hl : l₁ ≤ l₂)
    (hd : ∀ i ∈ S, 0 ≤ d i) :
    (∏ i ∈ S, (1+l₂*d i)⁻¹) ≤ ∏ i ∈ S, (1+l₁*d i)⁻¹ := by
  have hl₂ := hl₁.trans hl
  apply Finset.prod_le_prod
  · intro i hi
    have hdi : 0 ≤ d i := hd i hi
    have h1 : (0:ℝ) < 1 + l₂ * d i := by positivity
    exact le_of_lt (inv_pos.mpr h1)
  · intro i hi
    have hdi : 0 ≤ d i := hd i hi
    have h1 : (0:ℝ) < 1 + l₁ * d i := by positivity
    have hle : 1 + l₁ * d i ≤ 1 + l₂ * d i := by
      have : l₁ * d i ≤ l₂ * d i := mul_le_mul_of_nonneg_right hl hdi
      linarith
    exact inv_anti₀ h1 hle

end GaffkeDeltaSharpBoundResearchProof1
