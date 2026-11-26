import ModeDiscriminant
import NormalModeAnalysis
import Mathlib.Tactic.Linarith

namespace ReversibleMarkovWeakResponse

/-- The derivative of a normal mode is nonpositive exactly beyond the
single-mode threshold, including equality at the threshold. -/
theorem normal_mode_deriv_nonpos_iff (a b x : ℝ) (ha : 0 < a) (hx : 0 ≤ x) :
    deriv (normalModeResponse a b) x ≤ 0 ↔ modeBound a b ≤ x := by
  have hsum : 0 < a + x := add_pos_of_pos_of_nonneg ha hx
  have hden : 0 < ((a + x)^2 + b^2)^2 :=
    pow_pos (add_pos_of_pos_of_nonneg (pow_pos hsum _) (sq_nonneg b)) _
  rw [(normal_mode_hasDerivAt a b x hsum).deriv, div_le_iff₀ hden, zero_mul]
  exact (show b^2 - (a + x)^2 ≤ 0 ↔ 0 ≤ (a + x)^2 - b^2 by
    constructor <;> intro h <;> linarith)
      |>.trans (transverse_mode_criterion a x b ha hx)

end ReversibleMarkovWeakResponse
