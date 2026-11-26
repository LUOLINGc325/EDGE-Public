import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

namespace SharpTwoStepActivityResearchProof1

/-- The endpoint coefficients `b_{H,e}` and `b_{L,e}` from the two-step Glauber
activity theorem both lie in `[0, t₂]`, including the zero-temperature case. -/
theorem endpoint_coefficients (t₀ t₁ t₂ : ℝ) (h0 : 0 ≤ t₀) (h1 : t₀ ≤ t₁)
    (h2 : t₁ ≤ t₂) (h3 : t₂ < 1) :
    (t₁ - t₀) / (1 - t₀) ∈ Set.Icc 0 t₂ ∧ (t₁ - t₀) / (1 + t₀) ∈ Set.Icc 0 t₂ := by
  constructor
  · -- The `H` coefficient: numerator `t₁ - t₀ ≥ 0`, denominator `1 - t₀ ≥ 1 - t₂ > 0`.
    have hnum : 0 ≤ t₁ - t₀ := by linarith
    have hden : 0 < 1 - t₀ := by linarith
    refine ⟨div_nonneg hnum (le_of_lt hden), ?_⟩
    -- `b_{H,e} = (t₁ - t₀)/(1 - t₀) ≤ t₂` since `(t₁ - t₀) ≤ t₂ (1 - t₀)`.
    rw [div_le_iff₀ hden]
    nlinarith
  · -- The `L` coefficient: denominator `1 + t₀ ≥ 1 > 0`.
    have hnum : 0 ≤ t₁ - t₀ := by linarith
    have hden : 0 < 1 + t₀ := by linarith
    refine ⟨div_nonneg hnum (le_of_lt hden), ?_⟩
    rw [div_le_iff₀ hden]
    nlinarith

end SharpTwoStepActivityResearchProof1
