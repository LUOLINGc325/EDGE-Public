import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace RecordConstrainedProphetGapResearchProof3

/-- In the last bin `a = 1 - h` the denominator of (13) is the finite geometric
sum `∑ k ∈ range n, q^k`, where `q = a + t h` lies in `[0,1)`.  This lemma
records its two elementary bounds: strict positivity and the bound by `n`.

Positivity: `q ≥ 0`, so every power `q^k` is nonnegative and the `k = 0` term
is `1`.  Upper bound: for `0 ≤ q < 1` we have `q^k ≤ 1` for every `k`, and the
range has exactly `n` terms, so the sum is at most `n` as a real number. -/
theorem last_bin_finite_denominator (n : ℕ) (q : ℝ)
    (hn : 0 < n) (hq : 0 ≤ q) (hq1 : q < 1) :
    0 < (∑ k ∈ Finset.range n, q^k) ∧ (∑ k ∈ Finset.range n, q^k) ≤ (n : ℝ) := by
  constructor
  · have hzero : (0 : ℕ) ∈ Finset.range n := by
      rw [Finset.mem_range]
      exact hn
    have hle : ∀ k ∈ Finset.range n, (0 : ℝ) ≤ q ^ k := by
      intro k _
      exact pow_nonneg hq k
    have hterm : q ^ 0 = (1 : ℝ) := pow_zero q
    calc 0 < q ^ 0 := by rw [hterm]; norm_num
      _ ≤ ∑ k ∈ Finset.range n, q ^ k :=
          Finset.single_le_sum hle hzero
  · have hle : ∀ k ∈ Finset.range n, q ^ k ≤ (1 : ℝ) := by
      intro k _
      exact pow_le_one₀ hq (le_of_lt hq1)
    calc ∑ k ∈ Finset.range n, q ^ k
        ≤ ∑ _k ∈ Finset.range n, (1 : ℝ) := Finset.sum_le_sum hle
      _ = (n : ℝ) := by
          rw [Finset.sum_const, Finset.card_range, nsmul_eq_mul, mul_one]

end RecordConstrainedProphetGapResearchProof3
