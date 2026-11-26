import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

namespace TernaryPairwiseMomentResearchProof1

/-- Pointwise algebraic expansion of the product of three affine functions,
used to derive the affine-level formula
`u^3 + 3u^2 d μ + 3u d^2 μ^2 + d^3 V(p,x)` from the normalized three-level
value `V(p,x)`.  Valid for all `u, d` including `d = 0`.  Independence of the
coordinates enters only in the subsequent expectation step, not here. -/
theorem ternary_affine_product_expansion (u d x₁ x₂ x₃ : ℝ) :
    (u + d * x₁) * (u + d * x₂) * (u + d * x₃) =
      u ^ 3 + u ^ 2 * d * (x₁ + x₂ + x₃)
        + u * d ^ 2 * (x₁ * x₂ + x₁ * x₃ + x₂ * x₃)
        + d ^ 3 * x₁ * x₂ * x₃ := by
  ring

end TernaryPairwiseMomentResearchProof1
