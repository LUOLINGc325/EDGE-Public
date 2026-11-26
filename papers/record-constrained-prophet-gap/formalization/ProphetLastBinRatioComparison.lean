import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace RecordConstrainedProphetGapResearchProof3

/-- The numerator `m * (1 - (1 - 1/m)^n)` appearing in (13) is nonnegative for every
positive integer `m` and every positive integer `n`. -/
private theorem last_bin_numerator_nonneg (m n : ℕ) (hm : 0 < m) :
    0 ≤ (m : ℝ) * (1 - (1 - 1/(m : ℝ))^n) := by
  have hmR : (0 : ℝ) < (m : ℝ) := by exact_mod_cast hm
  have hbase : 0 ≤ 1 - 1/(m : ℝ) := by
    have h1 : (1 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
    have h2 : 1/(m : ℝ) ≤ 1 := by rw [div_le_one hmR]; exact h1
    linarith
  have hpow : (1 - 1/(m : ℝ))^n ≤ 1 := by
    have h1 : (1 - 1/(m : ℝ)) ≤ 1 := by
      have : 0 ≤ 1/(m : ℝ) := by positivity
      linarith
    exact pow_le_one₀ hbase h1
  have : 0 ≤ 1 - (1 - 1/(m : ℝ))^n := by linarith
  exact mul_nonneg (le_of_lt hmR) this

/-- Scalar quotient comparison (13): with the geometric factor `g = 1 - (1-1/m)^n ≥ 0`
and a finite geometric denominator `S = ∑_{k<n} q^k` satisfying `0 < S ≤ n`, we have
`(m/n) * g ≤ (m*g)/S`. -/
theorem last_bin_ratio_comparison (m n : ℕ) (q : ℝ)
    (hm : 0 < m) (hn : 0 < n) (hq : 0 ≤ q) (hq1 : q < 1)
    (hs : 0 < (∑ k ∈ Finset.range n, q^k))
    (hu : (∑ k ∈ Finset.range n, q^k) ≤ (n : ℝ)) :
    ((m : ℝ)/n)*(1-(1-1/(m : ℝ))^n) ≤
      ((m : ℝ)*(1-(1-1/(m : ℝ))^n))/(∑ k ∈ Finset.range n, q^k) := by
  have _ := hq
  have _ := hq1
  have _ := hn
  have hnum := last_bin_numerator_nonneg m n hm
  calc
    ((m : ℝ)/n)*(1-(1-1/(m : ℝ))^n) =
      ((m : ℝ)*(1-(1-1/(m : ℝ))^n))/(n : ℝ) := by ring
    _ ≤ ((m : ℝ)*(1-(1-1/(m : ℝ))^n))/(∑ k ∈ Finset.range n, q^k) :=
      div_le_div_of_nonneg_left hnum hs hu


end RecordConstrainedProphetGapResearchProof3
