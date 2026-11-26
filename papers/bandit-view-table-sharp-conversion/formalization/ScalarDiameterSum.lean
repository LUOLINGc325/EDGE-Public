import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Finset.Card
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace BanditViewTableSharpConversionResearchProof1

open Finset

theorem scalar_diameter_sum {q : ℕ} (v : Fin q → ℝ) (a b : Fin q) :
    2 * ((q : ℝ) - 1) * |v a - v b| ≤ ∑ i, ∑ j, |v i - v j| := by
  let d : Fin q → Fin q → ℝ := fun i j => |v i - v j|
  change 2 * ((q : ℝ) - 1) * d a b ≤ ∑ i, ∑ j, d i j
  have d_nonneg (i j : Fin q) : 0 ≤ d i j := abs_nonneg _
  have d_sym (i j : Fin q) : d i j = d j i := abs_sub_comm _ _
  have d_self (i : Fin q) : d i i = 0 := by simp [d]
  by_cases hab : a = b
  · rw [hab, d_self, mul_zero]
    exact sum_nonneg fun i _ => sum_nonneg fun j _ => d_nonneg i j
  let remaining := ((univ : Finset (Fin q)).erase a).erase b
  have ha : a ∈ (univ : Finset (Fin q)) := mem_univ _
  have hb : b ∈ (univ : Finset (Fin q)).erase a := mem_erase.mpr ⟨fun h => hab h.symm, mem_univ _⟩
  have hsplit (f : Fin q → ℝ) :
      (∑ i, f i) = f a + f b + ∑ i ∈ remaining, f i := by
    calc
      (∑ i, f i) = (∑ i ∈ univ.erase a, f i) + f a := (sum_erase_add _ f ha).symm
      _ = ((∑ i ∈ remaining, f i) + f b) + f a := by rw [sum_erase_add _ f hb]
      _ = _ := by ring
  have hcount : (remaining.card : ℝ) + 2 = q := by
    have hn : remaining.card + 2 = q := by
      calc
        remaining.card + 2 = (remaining.card + 1) + 1 := by omega
        _ = ((univ : Finset (Fin q)).erase a).card + 1 := by rw [card_erase_add_one hb]
        _ = q := by rw [card_erase_add_one ha, card_univ, Fintype.card_fin]
    exact_mod_cast hn
  have htri (i : Fin q) : d a b ≤ d a i + d b i := by
    rw [d_sym b i]
    exact abs_sub_le _ _ _
  have heach : (remaining.card : ℝ) * d a b ≤ ∑ i ∈ remaining, (d a i + d b i) := by
    calc
      (remaining.card : ℝ) * d a b = ∑ _i ∈ remaining, d a b := by
        simp [sum_const, nsmul_eq_mul]
      _ ≤ _ := sum_le_sum fun i _ => htri i
  have hrows :
      (∑ i ∈ remaining, (d a i + d b i)) ≤ ∑ i ∈ remaining, ∑ j, d i j := by
    apply sum_le_sum
    intro i _
    rw [hsplit (d i), d_sym a i, d_sym b i]
    exact le_add_of_nonneg_right (sum_nonneg fun j _ => d_nonneg i j)
  calc
    2 * ((q : ℝ) - 1) * d a b
        = 2 * d a b + 2 * ((remaining.card : ℝ) * d a b) := by
          rw [← hcount]
          ring
    _ ≤ 2 * d a b + 2 * (∑ i ∈ remaining, (d a i + d b i)) := by linarith only [heach]
    _ ≤ ∑ i, ∑ j, d i j := by
      rw [hsplit (fun i => ∑ j, d i j), hsplit (d a), hsplit (d b),
        d_self a, d_self b, d_sym b a]
      rw [sum_add_distrib] at hrows ⊢
      linarith only [hrows]

end BanditViewTableSharpConversionResearchProof1
