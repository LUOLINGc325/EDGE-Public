import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

namespace OrdinalOnlyFrontier

/-- Left endpoint of the finite-job robustness interval. -/
noncomputable def endpoint (n : ℕ) : ℝ := 2*(n : ℝ)/((n : ℝ)+1)

theorem endpoint_mono {N n : ℕ} (h : N ≤ n) : endpoint N ≤ endpoint n := by
  have hcast : (N : ℝ) ≤ (n : ℝ) := by exact_mod_cast h
  unfold endpoint
  apply (div_le_div_iff₀ (by positivity : 0 < (N : ℝ)+1)
    (by positivity : 0 < (n : ℝ)+1)).2
  nlinarith

/-- The sign of the fallback potential drift in Section 4. -/
theorem fallback_drift {N n : ℕ} {R : ℝ} (hN : N ≤ n) (hR : endpoint n ≤ R) :
    (N : ℝ) - R*((N : ℝ)+1)/2 ≤ 0 := by
  have h := (endpoint_mono hN).trans hR
  have hden : 0 < (N : ℝ)+1 := by positivity
  have hmul := (div_le_iff₀ hden).mp h
  linarith

end OrdinalOnlyFrontier
