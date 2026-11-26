import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace DCASharpResidual

/-- One DCA step cancels the shared linear terms in the two curvature
inequalities, leaving their summed quadratic decrease. -/
theorem dca_one_step_curvature {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (f₁ f₂ : E → ℝ) (μ₁ μ₂ : ℝ) (x y p : E)
    (h₁ : f₁ x ≥ f₁ y + @inner ℝ E _ p (x - y) + (μ₁ / 2) * ‖x - y‖^2)
    (h₂ : f₂ y ≥ f₂ x + @inner ℝ E _ p (y - x) + (μ₂ / 2) * ‖y - x‖^2) :
    (f₁ x - f₂ x) - (f₁ y - f₂ y) ≥ ((μ₁ + μ₂) / 2) * ‖x - y‖^2 := by
  rw [norm_sub_rev y x] at h₂
  have hCancel : @inner ℝ E _ p (x - y) + @inner ℝ E _ p (y - x) = 0 := by
    simp only [inner_sub_right]
    ring
  nlinarith only [h₁, h₂, hCancel]

end DCASharpResidual
