import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

namespace GaussianProductSharpZcdpResearchProof1

/-- Monotonicity of the two reciprocal terms in the forward envelope (2.3). -/
theorem forward_envelope_antitone (d b a c : ℝ) (hd : 0 < d)
    (ha : max (max 2 (d+1)) (b^2/d) ≤ a) (hac : a ≤ c) :
    d^2/4 + 9*d^2/(4*(2*c-1)) + b^2*d^2/(2*c)
      ≤ d^2/4 + 9*d^2/(4*(2*a-1)) + b^2*d^2/(2*a) := by
  have ha2 : (2 : ℝ) ≤ a := le_trans (le_trans (le_max_left 2 (d+1)) (le_max_left _ _)) ha
  have hd2 : 0 ≤ d ^ 2 := pow_nonneg hd.le 2
  have h1 : 9*d^2/(4*(2*c-1)) ≤ 9*d^2/(4*(2*a-1)) := by
    apply div_le_div_of_nonneg_left (mul_nonneg (by positivity) hd2)
    · linarith
    · linarith
  have h2 : b^2*d^2/(2*c) ≤ b^2*d^2/(2*a) := by
    apply div_le_div_of_nonneg_left (mul_nonneg (sq_nonneg b) hd2) <;> linarith
  exact add_le_add (add_le_add_left h1 _) h2

end GaussianProductSharpZcdpResearchProof1
