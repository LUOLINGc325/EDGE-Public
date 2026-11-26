import Mathlib.Algebra.Polynomial.Roots
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

namespace SixCycleReplicaArithmeticResearchProof1

open Polynomial

noncomputable def minusNumerator : ℝ[X] :=
  3*X^4+2*X^3-2*X^2+X+4

noncomputable def plusNumerator : ℝ[X] :=
  3*X^4+2*X^3-4*X^2+11*X-8

/-- Section 4 arithmetic obstruction for the numerator after cancelling n−1.
The hypotheses describe agreement on each branch after multiplication by
the two denominators. Both index sets can omit finitely many exceptional values. -/
theorem no_common_rational_function
    (sMinus sPlus : Set ℝ) (hm : sMinus.Infinite) (hp : sPlus.Infinite)
    (num den : ℝ[X]) (hden : den ≠ 0) :
    ¬ ((∀ x ∈ sMinus, num.eval x * x^4 = den.eval x * minusNumerator.eval x) ∧
          (∀ x ∈ sPlus, num.eval x * x^4 = den.eval x * plusNumerator.eval x)) := by
  rintro ⟨hMinus, hPlus⟩
  have hmZero : num * X^4 - den * minusNumerator = 0 := by
    apply Polynomial.eq_zero_of_infinite_isRoot
    refine hm.mono ?_
    intro x hx
    change (num * X^4 - den * minusNumerator).eval x = 0
    simp only [eval_sub, eval_mul, eval_pow, eval_X]
    exact sub_eq_zero.mpr (hMinus x hx)
  have hpZero : num * X^4 - den * plusNumerator = 0 := by
    apply Polynomial.eq_zero_of_infinite_isRoot
    refine hp.mono ?_
    intro x hx
    change (num * X^4 - den * plusNumerator).eval x = 0
    simp only [eval_sub, eval_mul, eval_pow, eval_X]
    exact sub_eq_zero.mpr (hPlus x hx)
  have hsame : den * minusNumerator = den * plusNumerator :=
    (sub_eq_zero.mp hmZero).symm.trans (sub_eq_zero.mp hpZero)
  have heq : minusNumerator = plusNumerator := mul_left_cancel₀ hden hsame
  have heval := congrArg (eval 5) heq
  norm_num [minusNumerator, plusNumerator] at heval

end SixCycleReplicaArithmeticResearchProof1
