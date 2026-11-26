import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace UnknownGapAdaptationBoundaryResearchProof2

theorem dyadic_term_geometric_comparison (a : ℕ → ℝ) (q a₀ : ℝ)
    (hq : 0 ≤ q) (hinit : a 0 ≤ a₀) (hstep : ∀ k, a (k+1) ≤ q*a k) :
    ∀ k, a k ≤ a₀*q^k := by
  intro k
  induction k with
  | zero =>
    simpa using hinit
  | succ n ih =>
    have hqk : 0 ≤ q ^ n := pow_nonneg hq n
    calc a (n+1) ≤ q * a n := hstep n
      _ ≤ q * (a₀ * q^n) := by
          exact mul_le_mul_of_nonneg_left ih hq
      _ = a₀ * q^(n+1) := by ring

end UnknownGapAdaptationBoundaryResearchProof2
