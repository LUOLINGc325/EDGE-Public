import Mathlib.Analysis.SpecialFunctions.Exponential
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

namespace StockoutPoissonBridge

noncomputable section

/-- Poisson mass function: `poisson r k = e^{-r} r^k / k!` as a real number. -/
def poisson (r : ℝ) (k : ℕ) : ℝ :=
  Real.exp (-r) * r ^ k / (Nat.factorial k : ℝ)

/-- The Poisson mass is strictly positive for every order when the rate is positive. -/
theorem poisson_pos {r : ℝ} (hr : 0 < r) (k : ℕ) : 0 < poisson r k := by
  unfold poisson
  have h_exp : 0 < Real.exp (-r) := Real.exp_pos _
  have h_pow : 0 < r ^ k := pow_pos hr k
  have h_fact : 0 < (Nat.factorial k : ℝ) := by
    exact_mod_cast Nat.factorial_pos k
  positivity

/-- Recurrence for the Poisson mass: `(k+1) * poisson r (k+1) = r * poisson r k`. -/
theorem poisson_succ_mul {r : ℝ} (k : ℕ) :
    (k + 1 : ℝ) * poisson r (k + 1) = r * poisson r k := by
  unfold poisson
  rw [Nat.factorial_succ, pow_succ]
  have h_fact : (Nat.factorial k : ℝ) ≠ 0 := by
    exact_mod_cast Nat.factorial_ne_zero k
  have h_succ : ((k + 1 : ℕ) : ℝ) ≠ 0 := by
    exact_mod_cast Nat.succ_ne_zero k
  field_simp [h_fact, h_succ]
  ring

end

end StockoutPoissonBridge
