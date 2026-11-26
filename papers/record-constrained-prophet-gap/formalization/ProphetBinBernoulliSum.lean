import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Intervals

namespace RecordConstrainedProphetGapResearchProof3

theorem bin_bernoulli_sum (m n : ℕ) (hm : 0 < m) (hn : 0 < n)
         (hterm : ∀ k ∈ Finset.range n, 1-(k : ℝ)/(m : ℝ) ≤ (1-1/(m : ℝ))^k) :
         1-((n : ℝ)-1)/(2*(m : ℝ)) ≤
           (∑ k ∈ Finset.range n, (1-1/(m : ℝ))^k)/(n : ℝ) := by
  have hmR : 0 < (m : ℝ) := Nat.cast_pos.mpr hm
  have hnR : 0 < (n : ℝ) := Nat.cast_pos.mpr hn
  have htri : ∀ N : ℕ, 2*(∑ k ∈ Finset.range N, (k : ℝ)) = (N : ℝ)*((N : ℝ)-1) := by
    intro N
    induction N with
    | zero => simp
    | succ k ih =>
      rw [Finset.sum_range_succ, Nat.cast_succ]
      nlinarith
  have hsplit : (∑ k ∈ Finset.range n, (1-(k : ℝ)/(m : ℝ))) =
      (n : ℝ) - (∑ k ∈ Finset.range n, (k : ℝ))/(m : ℝ) := by
    rw [Finset.sum_sub_distrib]
    simp only [Finset.sum_const, Finset.card_range, nsmul_eq_mul, mul_one, div_eq_mul_inv, Finset.sum_mul]
  apply (le_div_iff₀ hnR).mpr
  calc
    (1-((n : ℝ)-1)/(2*(m : ℝ)))*(n : ℝ) =
        (n : ℝ) - (∑ k ∈ Finset.range n, (k : ℝ))/(m : ℝ) := by
      field_simp [hmR.ne']
      nlinarith [htri n]
    _ = (∑ k ∈ Finset.range n, (1-(k : ℝ)/(m : ℝ))) := hsplit.symm
    _ ≤ ∑ k ∈ Finset.range n, (1-1/(m : ℝ))^k := Finset.sum_le_sum hterm

end RecordConstrainedProphetGapResearchProof3
