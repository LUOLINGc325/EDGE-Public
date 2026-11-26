import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace AdaptiveErasureFeedbackLawResearchProof1

/-- The scalar polynomial used in the comparison of the two derivative bounds. -/
theorem derivative_polynomial_pos (n : ℝ) (hn : 3 ≤ n) :
    0 < 144*n^3 - 324*n^2 - 40*n - 3 := by
  let j : ℝ := n - 3
  have hj : 0 ≤ j := sub_nonneg.mpr hn
  have hf : 144*n^3 - 324*n^2 - 40*n - 3 =
      144*j^3 + 972*j^2 + 1904*j + 849 := by
    dsimp [j]
    ring
  rw [hf]
  linarith [pow_nonneg hj 3, sq_nonneg j]

/-- Equation (16): the upper derivative bound is at most twice the lower
derivative bound for every real n ≥ 3. -/
theorem derivative_ratio_le_two (n : ℝ) (hn : 3 ≤ n) :
    (9*n + 27/4) / (9*n^2) ≤ 2 * ((9*n - 21/4) / (3*n+1/2)^2) := by
  have h1 : 0 < 9*n^2 :=
    mul_pos (by norm_num) (pow_pos (by linarith) _)
  have h2 : 0 < (3*n+1/2)^2 := pow_pos (by linarith) _
  rw [← mul_div_assoc]
  apply (div_le_div_iff₀ h1 h2).2
  have cross : 2*(9*n-21/4)*(9*n^2) - (9*n+27/4)*(3*n+1/2)^2 =
      (9/16 : ℝ)*(144*n^3-324*n^2-40*n-3) := by ring
  linarith only [cross, derivative_polynomial_pos n hn]

end AdaptiveErasureFeedbackLawResearchProof1
