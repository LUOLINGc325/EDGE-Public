import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Lean.Elab.Tactic.Omega

namespace PreciseMergersWithoutSymmetry

open Finset

/-- Positive part `max 0 x`. -/
noncomputable def posPart (x : ℝ) : ℝ := max 0 x

lemma posPart_nonneg (x : ℝ) : 0 ≤ posPart x := le_max_left _ _

/-- Product-correction merger. -/
noncomputable def M {I : Type*} [Fintype I] (lam : ℝ) (x : I → ℝ) : ℝ :=
  1 + lam * ((∏ i, posPart (x i - 1)) - (∏ i, posPart (1 - x i)))

/-- Each factor `posPart (1 - x i)` lies in `[0,1]` when `x i ≥ 0`. -/
lemma posPart_one_sub_mem {x : ℝ} (hx : 0 ≤ x) :
    0 ≤ posPart (1 - x) ∧ posPart (1 - x) ≤ 1 := by
  unfold posPart
  constructor
  · exact le_max_left _ _
  · exact max_le (by linarith) (by linarith)

/-- The negative-part product is at most one when all coordinates are nonnegative. -/
lemma prod_neg_le_one {I : Type*} [Fintype I] {x : I → ℝ}
    (hx : ∀ i, 0 ≤ x i) : (∏ i, posPart (1 - x i)) ≤ 1 := by
  have h1 : ∀ i ∈ (univ : Finset I), posPart (1 - x i) ≤ 1 :=
    fun i _ => (posPart_one_sub_mem (hx i)).2
  have h2 : ∀ i ∈ (univ : Finset I), 0 ≤ posPart (1 - x i) :=
    fun i _ => posPart_nonneg _
  calc ∏ i, posPart (1 - x i) ≤ ∏ _i : I, (1 : ℝ) :=
        Finset.prod_le_prod h2 h1
    _ = 1 := by simp

/-- Main nonnegativity statement: `M lam x ≥ 0` when `x i ≥ 0` and `0 ≤ lam ≤ 1`. -/
theorem M_nonneg {I : Type*} [Fintype I] (lam : ℝ) (x : I → ℝ)
    (hx : ∀ i, 0 ≤ x i) (hlam0 : 0 ≤ lam) (hlam1 : lam ≤ 1) : 0 ≤ M lam x := by
  unfold M
  have hpos : (0 : ℝ) ≤ ∏ i, posPart (x i - 1) :=
    Finset.prod_nonneg (fun i _ => posPart_nonneg _)
  have hneg : (∏ i, posPart (1 - x i)) ≤ 1 := prod_neg_le_one hx
  have hdiff : -(1 : ℝ) ≤ (∏ i, posPart (x i - 1)) - (∏ i, posPart (1 - x i)) := by
    have := Finset.prod_nonneg (fun i (_ : i ∈ (univ : Finset I)) => posPart_nonneg (x i - 1))
    linarith
  rcases le_or_lt 0 ((∏ i, posPart (x i - 1)) - (∏ i, posPart (1 - x i))) with h | h
  · nlinarith [mul_nonneg hlam0 h]
  · -- lam * d ≥ d ≥ -1 when 0 ≤ lam ≤ 1 (d ≤ 0)
    have hd : (∏ i, posPart (x i - 1)) - (∏ i, posPart (1 - x i)) ≤ 0 := le_of_lt h
    have hmul : lam * ((∏ i, posPart (x i - 1)) - (∏ i, posPart (1 - x i)))
        ≥ (∏ i, posPart (x i - 1)) - (∏ i, posPart (1 - x i)) := by
      have := mul_le_mul_of_nonpos_right hlam1 hd
      linarith
    linarith

/-- Coordinatewise monotonicity of the positive-part product. -/
lemma prod_posPart_mono {I : Type*} [Fintype I] {x y : I → ℝ}
    (h : ∀ i, x i ≤ y i) : (∏ i, posPart (x i - 1)) ≤ ∏ i, posPart (y i - 1) := by
  apply Finset.prod_le_prod
  · intro i _; exact posPart_nonneg _
  · intro i _
    unfold posPart
    exact max_le_max le_rfl (sub_le_sub_right (h i) 1)

/-- Coordinatewise antimonotonicity of the negative-part product. -/
lemma prod_negPart_anti {I : Type*} [Fintype I] {x y : I → ℝ}
    (h : ∀ i, x i ≤ y i) : (∏ i, posPart (1 - y i)) ≤ ∏ i, posPart (1 - x i) := by
  apply Finset.prod_le_prod
  · intro i _; exact posPart_nonneg _
  · intro i _
    unfold posPart
    exact max_le_max le_rfl (sub_le_sub_left (h i) 1)

/-- Coordinatewise monotonicity of `M lam` for `lam ≥ 0`. -/
theorem M_mono {I : Type*} [Fintype I] (lam : ℝ) (hlam : 0 ≤ lam) {x y : I → ℝ}
    (h : ∀ i, x i ≤ y i) : M lam x ≤ M lam y := by
  unfold M
  have h1 := prod_posPart_mono h
  have h2 := prod_negPart_anti h
  nlinarith

end PreciseMergersWithoutSymmetry
