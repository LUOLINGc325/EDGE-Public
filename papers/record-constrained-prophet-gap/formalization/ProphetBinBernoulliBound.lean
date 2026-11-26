import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

namespace RecordConstrainedProphetGapResearchProof3

/-- Bernoulli's inequality at every integer exponent, on `[0,1]`.

This is the elementary estimate used to pass from the geometric-series
identity
  `ρ_{n,m} = (1/n) * ∑_{k=0}^{n-1} (1 - 1/m)^k`
to the bound `ρ_{n,m} ≥ 1 - (n-1)/(2m)` in equation (14) of the manuscript.
-/
theorem bernoulli_power_bound (x : ℝ) (hx : 0 ≤ x) (hx1 : x ≤ 1) :
    ∀ k : ℕ, 1 - (k : ℝ) * x ≤ (1 - x) ^ k := by
  intro k
  induction k with
  | zero => simp
  | succ k ih =>
    have hkx : 0 ≤ (k : ℝ) * x := by positivity
    have hnonneg : 0 ≤ (1 - x) ^ k := pow_nonneg (by linarith) k
    have hstep : (1 - x) ^ k * (1 - x) ≥ (1 - (k : ℝ) * x) * (1 - x) := by
      exact mul_le_mul_of_nonneg_right ih (by linarith)
    have heq : (1 - (k : ℝ) * x) * (1 - x)
        = 1 - ((k : ℝ) + 1) * x + (k : ℝ) * x ^ 2 := by ring
    have hsq : 0 ≤ (k : ℝ) * x ^ 2 := by positivity
    have hcast : ((k + 1 : ℕ) : ℝ) = (k : ℝ) + 1 := by push_cast; ring
    rw [hcast]
    calc 1 - ((k : ℝ) + 1) * x
        = 1 - ((k : ℝ) + 1) * x + (k : ℝ) * x ^ 2 - (k : ℝ) * x ^ 2 := by ring
      _ ≤ 1 - ((k : ℝ) + 1) * x + (k : ℝ) * x ^ 2 := by linarith
      _ = (1 - (k : ℝ) * x) * (1 - x) := heq.symm
      _ ≤ (1 - x) ^ k * (1 - x) := hstep
      _ = (1 - x) ^ (k + 1) := by ring

end RecordConstrainedProphetGapResearchProof3
