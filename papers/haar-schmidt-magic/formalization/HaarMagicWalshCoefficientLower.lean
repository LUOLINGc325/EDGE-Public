import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace HaarSchmidtMagicResearchProof1

theorem walsh_second_coefficient_negative {ι : Type u} (S : Finset ι)
    (c : ι → ℝ) (i₀ : ι) (P A : ℝ) (hi : i₀ ∈ S)
    (hP : 0 < P) (hPmax : P < 22/7) (hchar : c i₀ = 8/(3*P))
    (hA : A = ∑ i ∈ S, (c i)^4) :
    3/14 < A ∧ 3/16 - 7*A/8 < 0 := by
  have hc : (28 : ℝ)/33 ≤ c i₀ := by
    rw [hchar]
    apply (le_div_iff₀ (by positivity : 0 < 3*P)).mpr
    linarith
  have hpow := pow_le_pow_left₀ (by norm_num : 0 ≤ (28 : ℝ)/33) hc 4
  have hsingle : (c i₀)^4 ≤ ∑ i ∈ S, (c i)^4 :=
    Finset.single_le_sum (fun i _ => show 0 ≤ (c i)^4 by positivity) hi
  have hrat : (3 : ℝ)/14 < ((28 : ℝ)/33)^4 := by norm_num
  have hstrict : (3 : ℝ)/14 < A := by
    rw [hA]
    exact (hrat.trans_le hpow).trans_le hsingle
  exact ⟨hstrict, by linarith⟩

end HaarSchmidtMagicResearchProof1
