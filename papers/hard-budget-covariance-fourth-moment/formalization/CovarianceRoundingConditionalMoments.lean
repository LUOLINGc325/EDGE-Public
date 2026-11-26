import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

universe u
namespace HardBudgetCovarianceFourthMomentResearchProof2

theorem rounding_bernoulli_moments (sigma a theta : ℝ) (h0 : 0 ≤ theta) (h1 : theta ≤ 1) :
         (1-theta)*(sigma*a)+theta*(sigma*(a+1)) = sigma*(a+theta) ∧
         (1-theta)*(sigma*a-sigma*(a+theta))^2+theta*(sigma*(a+1)-sigma*(a+theta))^2
           = sigma^2*theta*(1-theta) ∧ sigma^2*theta*(1-theta) ≤ sigma^2/4 := by
  refine ⟨by ring, by ring, ?_⟩
  have ht : 0 ≤ theta*(1-theta) := mul_nonneg h0 (sub_nonneg.mpr h1)
  have ht' : |theta*(1-theta)| ≤ (1:ℝ)/4 := by
    rw [abs_of_nonneg ht]
    nlinarith only [sq_nonneg (theta-1/2)]
  have hmul := mul_le_mul_of_nonneg_left ((abs_le.mp ht').2) (sq_nonneg sigma)
  nlinarith only [hmul]

end HardBudgetCovarianceFourthMomentResearchProof2
