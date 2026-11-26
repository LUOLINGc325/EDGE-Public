import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

namespace SelectionAuditInformationResearchProof1

/-- In the strictly separated regime `r < q - p`, all four coefficients appearing in
the tangent lower bound (15) of the manuscript are strictly positive. -/
theorem strict_reference_coefficients (p q r : ℝ) (hp : 0 < p) (hq : q < 1)
    (_hr : 0 < r) (hgap : r < q - p) :
    let R₁ := (q - r) / p
    let R₀ := (1 - q) / (1 - p - r)
    0 < R₁ - R₀ ∧ 0 < Real.log (R₁ / R₀) ∧ 0 < 1 - R₀ ∧ 0 < Real.log R₁ := by
  -- Basic positivity facts.
  have hqr : 0 < q - r := by linarith
  have h1q : 0 < 1 - q := by linarith
  have h1pr : 0 < 1 - p - r := by linarith
  -- R₁ > 1 and R₁ > 0.
  have hR1gt1 : 1 < (q - r) / p := by
    rw [lt_div_iff₀ hp]; linarith
  have hR1pos : 0 < (q - r) / p := by positivity
  -- R₀ < 1 and R₀ > 0.
  have hR0lt1 : (1 - q) / (1 - p - r) < 1 := by
    rw [div_lt_one h1pr]; linarith
  have hR0pos : 0 < (1 - q) / (1 - p - r) := by positivity
  refine ⟨?_, ?_, ?_, ?_⟩
  · -- R₁ - R₀ > 0 since R₀ < 1 < R₁.
    linarith
  · -- log (R₁ / R₀) > 0 since R₁/R₀ > 1.
    apply Real.log_pos
    rw [one_lt_div hR0pos]
    linarith
  · linarith
  · exact Real.log_pos hR1gt1

end SelectionAuditInformationResearchProof1
