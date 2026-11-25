import FiniteRandomBound
import Mathlib.Analysis.Complex.Exponential
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Data.Nat.Choose.Bounds
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

open scoped BigOperators

namespace TwoColorNullity

theorem unordered_matchings_count_quotient (items r : ℕ) (h : 2 * r ≤ items) :
    Fintype.card (UnorderedMatching (Fin items) r) = items.factorial /
      ((items - 2 * r).factorial * (2 ^ r * r.factorial)) := by
  have hpositive : 0 < r.factorial * 2 ^ r := Nat.mul_pos (Nat.factorial_pos _) (by positivity)
  calc
    _ = items.descFactorial (2 * r) / (r.factorial * 2 ^ r) := by
      rw [← unordered_matchings_count_mul, Nat.mul_div_cancel _ hpositive]
    _ = _ := by rw [Nat.descFactorial_eq_div h, Nat.div_div_eq_div_mul, Nat.mul_comm r.factorial]

theorem unordered_matchings_count_le_pow (items r : ℕ) :
    Fintype.card (UnorderedMatching (Fin items) r) ≤ items ^ (2 * r) := by
  have hfactor : 1 ≤ r.factorial * 2 ^ r := Nat.mul_pos (Nat.factorial_pos _) (by positivity)
  have h := Nat.mul_le_mul_left (Fintype.card (UnorderedMatching (Fin items) r)) hfactor
  rw [Nat.mul_one, unordered_matchings_count_mul] at h
  exact h.trans (Nat.descFactorial_le_pow _ _)

/-- The factorial comparison follows from the exponential series. -/
theorem factorial_lower_exp (r : ℕ) : ((r : ℝ) / Real.exp 1) ^ r ≤ r.factorial := by
  have hfactorial : (0 : ℝ) < r.factorial := by exact_mod_cast Nat.factorial_pos r
  have hseries := (div_le_iff₀ hfactorial).mp (Real.pow_div_factorial_le_exp (r : ℝ) (by positivity) r)
  rw [div_pow]
  apply (div_le_iff₀ (pow_pos (Real.exp_pos 1) r)).mpr
  rw [← Real.exp_nat_mul, mul_one, mul_comm]
  exact hseries

theorem unordered_matchings_count_le_exp (items r : ℕ) (hr : 0 < r) :
    (Fintype.card (UnorderedMatching (Fin items) r) : ℝ) ≤
      (Real.exp 1 * (items : ℝ) ^ 2 / (2 * (r : ℝ))) ^ r := by
  let count : ℝ := Fintype.card (UnorderedMatching (Fin items) r)
  have hcard : count * ((r.factorial : ℝ) * (2 : ℝ) ^ r) ≤ (items : ℝ) ^ (2 * r) := by
    dsimp [count]
    exact_mod_cast (show Fintype.card (UnorderedMatching (Fin items) r) * (r.factorial * 2 ^ r) ≤
      items ^ (2 * r) by rw [unordered_matchings_count_mul]; exact Nat.descFactorial_le_pow _ _)
  have hcount : 0 ≤ count := Nat.cast_nonneg _
  have hfactor : (((r : ℝ) / Real.exp 1) ^ r) * (2 : ℝ) ^ r ≤ (r.factorial : ℝ) * 2 ^ r :=
    mul_le_mul_of_nonneg_right (factorial_lower_exp r) (by positivity)
  have hnum := (mul_le_mul_of_nonneg_left hfactor hcount).trans hcard
  rw [← mul_pow] at hnum
  have hr' : (0 : ℝ) < r := by exact_mod_cast hr
  have hden : 0 < ((r : ℝ) / Real.exp 1 * 2) ^ r := by positivity
  calc
    count ≤ ((items : ℝ) ^ 2) ^ r / ((r : ℝ) / Real.exp 1 * 2) ^ r := by
      apply (le_div_iff₀ hden).mpr
      simpa only [pow_mul] using hnum
    _ = _ := by
      rw [← div_pow]
      congr 1
      field_simp [Real.exp_ne_zero, ne_of_gt hr']

end TwoColorNullity
