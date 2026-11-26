import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

/-!
# Six-cycle replica arithmetic: the two odd-index arithmetic branches

Source: 六环图态的奇阶复制秩与两条算术分支, §4 「两条无限分支」, and §1
(the displayed two-polynomial formula for `E(n)`, and the claim that the two branches
agree exactly at `n = 3`).

We model the branch polynomials of §1 / §4 as functions `ℕ → ℤ`:

  n = 2^j - 1,  E(n) = (n-1)(3n^4 + 2n^3 - 2n^2 + n + 4),
  n = 2^j + 1,  E(n) = (n-1)(3n^4 + 2n^3 - 4n^2 + 11n - 8).

The paper's §4 states their difference is `2(n-1)(n-2)(n-3)`, that they coincide at
`n = 3`, and that `n = 3` lies on both index sequences (`j = 2` for the `-1` branch,
`j = 1` for the `+1` branch). These are the exact finite arithmetic facts used to
conclude the two branches are distinct, which is the rational-function obstruction
argument of §4.

Coverage limit: we formalize the exact polynomial identity, the equality at `n = 3`,
the vanishing set of the difference, and `3` arising in both sequences. We do NOT
formalize `Z_n > 0`, the gcd/rank formula of §3, or the nonexistence of a single
rational function, which require the matrix-rank / character-sum machinery of §2–§3.
-/

namespace SixCycleReplicaArithmeticResearchProof1

/-- The `n = 2^j - 1` branch polynomial of §1, as an integer-valued function of `n`. -/
def branchMinus (n : ℕ) : ℤ :=
  ((n : ℤ) - 1) * (3 * (n : ℤ) ^ 4 + 2 * (n : ℤ) ^ 3 - 2 * (n : ℤ) ^ 2 + (n : ℤ) + 4)

/-- The `n = 2^j + 1` branch polynomial of §1, as an integer-valued function of `n`. -/
def branchPlus (n : ℕ) : ℤ :=
  ((n : ℤ) - 1) * (3 * (n : ℤ) ^ 4 + 2 * (n : ℤ) ^ 3 - 4 * (n : ℤ) ^ 2 + 11 * (n : ℤ) - 8)

/-- §4: the difference of the two branch polynomials is `2(n-1)(n-2)(n-3)`. -/
theorem branch_difference (n : ℕ) :
    branchMinus n - branchPlus n = 2 * ((n : ℤ) - 1) * ((n : ℤ) - 2) * ((n : ℤ) - 3) := by
  unfold branchMinus branchPlus
  ring

/-- §1: the two branch polynomials agree at the coincident index `n = 3`. -/
theorem branch_eq_at_three : branchMinus 3 = branchPlus 3 := by
  unfold branchMinus branchPlus
  norm_num

/-- §4: the difference vanishes precisely at `n = 1, 2, 3` (over `ℕ`). -/
theorem branch_difference_zero_iff (n : ℕ) :
    branchMinus n = branchPlus n ↔ n = 1 ∨ n = 2 ∨ n = 3 := by
  have h := branch_difference n
  constructor
  · intro heq
    have hz : 2 * ((n : ℤ) - 1) * ((n : ℤ) - 2) * ((n : ℤ) - 3) = 0 := by
      rw [← h]; exact sub_eq_zero.mpr heq
    rcases mul_eq_zero.mp hz with h1 | h1
    · rcases mul_eq_zero.mp h1 with h2 | h2
      · rcases mul_eq_zero.mp h2 with h3 | h3
        · omega
        · omega
      · omega
    · omega
  · rintro (rfl | rfl | rfl)
    · unfold branchMinus branchPlus; norm_num
    · unfold branchMinus branchPlus; norm_num
    · exact branch_eq_at_three

/-- §4: `n = 3` lies on both index sequences: `3 = 2^2 - 1` and `3 = 2^1 + 1`. -/
theorem three_on_both_sequences :
    (2 : ℕ) ^ 2 - 1 = 3 ∧ (2 : ℕ) ^ 1 + 1 = 3 := by
  exact ⟨by norm_num, by norm_num⟩

/-- §4: the branch polynomials differ at any index `n ≥ 4`. -/
theorem branch_differ_of_ge_four (n : ℕ) (hn : 4 ≤ n) : branchMinus n ≠ branchPlus n := by
  intro heq
  have hz : 2 * ((n : ℤ) - 1) * ((n : ℤ) - 2) * ((n : ℤ) - 3) = 0 := by
    have h := branch_difference n
    rw [heq, sub_self] at h
    exact h.symm
  rcases mul_eq_zero.mp hz with h1 | h1
  · rcases mul_eq_zero.mp h1 with h2 | h2
    · rcases mul_eq_zero.mp h2 with h3 | h3
      · omega
      · omega
    · omega
  · omega

end SixCycleReplicaArithmeticResearchProof1
