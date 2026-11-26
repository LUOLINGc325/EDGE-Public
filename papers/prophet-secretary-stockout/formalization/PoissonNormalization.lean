import PoissonNeighborV2
import Mathlib.Analysis.SpecialFunctions.Exponential

namespace StockoutPoissonBridge

/-- The factorial-series normalization of the mass in Lemma 4.
For a positive rate this and positivity give a normalized positive mass. -/
theorem hasSum_poisson_pmf (r : ℝ) : HasSum (poisson r) 1 := by
  have expSeries : HasSum (fun k : ℕ => r ^ k / k.factorial) (Real.exp r) := by
    rw [Real.exp_eq_exp_ℝ]
    exact NormedSpace.expSeries_div_hasSum_exp ℝ r
  change HasSum (fun k : ℕ => Real.exp (-r) * r ^ k / k.factorial) 1
  have scaled := expSeries.mul_left (Real.exp (-r))
  simpa only [poisson, mul_div_assoc, ← Real.exp_add, neg_add_cancel, Real.exp_zero]
    using scaled

end StockoutPoissonBridge
