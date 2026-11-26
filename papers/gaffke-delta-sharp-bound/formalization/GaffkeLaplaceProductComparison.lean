import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.BigOperators.Ring.Finset

universe u
namespace GaffkeDeltaSharpBoundResearchProof1

theorem laplace_product_lower {ι : Type u} (S : Finset ι) (d : ι → ℝ) (lam : ℝ)
         (hL : 0 ≤ lam) (hd : ∀ i ∈ S, 0 ≤ d i ∧ d i ≤ 1) :
         ((1+lam)⁻¹)^S.card ≤ ∏ i ∈ S, (1+lam*d i)⁻¹ := by
  rw [← Finset.prod_const]
  apply Finset.prod_le_prod
  · intro i hi
    exact inv_nonneg.mpr (by linarith only [hL])
  · intro i hi
    obtain ⟨h0,h1⟩ := hd i hi
    have hdpos : 0 < 1+lam*d i := add_pos_of_pos_of_nonneg one_pos (mul_nonneg hL h0)
    have hden : 1+lam*d i ≤ 1+lam := by
      linarith only [mul_le_mul_of_nonneg_left h1 hL]
    simpa only [one_div] using one_div_le_one_div_of_le hdpos hden

end GaffkeDeltaSharpBoundResearchProof1
