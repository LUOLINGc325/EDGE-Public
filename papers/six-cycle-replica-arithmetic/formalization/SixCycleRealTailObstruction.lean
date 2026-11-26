import SixCycleInfiniteObstruction
import Mathlib.Data.Set.Finite.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Lean.Elab.Tactic.Omega

namespace SixCycleReplicaArithmeticResearchProof1

noncomputable def minusTail (N j : ℕ) : ℝ := (2:ℝ)^(j+N+2)-1

noncomputable def plusTail (N j : ℕ) : ℝ := (2:ℝ)^(j+N+2)+1

theorem minus_tail_infinite (N : ℕ) : (Set.range (minusTail N)).Infinite := by
  apply Set.infinite_range_of_injective
  apply StrictMono.injective
  intro j k hjk
  unfold minusTail
  have h : (2:ℝ)^(j+N+2) < (2:ℝ)^(k+N+2) :=
    pow_right_strictMono₀ (by norm_num) (by omega)
  linarith

theorem plus_tail_infinite (N : ℕ) : (Set.range (plusTail N)).Infinite := by
  apply Set.infinite_range_of_injective
  apply StrictMono.injective
  intro j k hjk
  unfold plusTail
  have h : (2:ℝ)^(j+N+2) < (2:ℝ)^(k+N+2) :=
    pow_right_strictMono₀ (by norm_num) (by omega)
  linarith

/-- The two explicit branch expressions cannot agree with a single
real rational function defined at every index in both shifted tails. -/
theorem no_common_rational_on_tails (N : ℕ) (num den : Polynomial ℝ)
    (hden : den ≠ 0) :
    ¬ ((∀ j, den.eval (minusTail N j) ≠ 0 ∧
          num.eval (minusTail N j) / den.eval (minusTail N j) =
            minusNumerator.eval (minusTail N j) / (minusTail N j)^4) ∧
       (∀ j, den.eval (plusTail N j) ≠ 0 ∧
          num.eval (plusTail N j) / den.eval (plusTail N j) =
            plusNumerator.eval (plusTail N j) / (plusTail N j)^4)) := by
  rintro ⟨hm,hp⟩
  apply no_common_rational_function _ _ (minus_tail_infinite N) (plus_tail_infinite N) num den hden
  constructor
  · rintro x ⟨j,rfl⟩
    have hpow : 4 ≤ (2:ℝ)^(j+N+2) := by
      have hd : (2:ℝ)^2 = 4 := by norm_num
      rw [← hd]
      exact pow_le_pow_right₀ (by norm_num) (by omega)
    have hx : minusTail N j ≠ 0 := by unfold minusTail; linarith
    rcases hm j with ⟨hnz,heq⟩
    simpa only [mul_comm] using (div_eq_div_iff hnz (pow_ne_zero 4 hx)).mp heq
  · rintro x ⟨j,rfl⟩
    have hx : plusTail N j ≠ 0 := by
      unfold plusTail
      linarith [pow_nonneg (show (0:ℝ) ≤ 2 by norm_num) (j+N+2)]
    rcases hp j with ⟨hnz,heq⟩
    simpa only [mul_comm] using (div_eq_div_iff hnz (pow_ne_zero 4 hx)).mp heq

end SixCycleReplicaArithmeticResearchProof1
