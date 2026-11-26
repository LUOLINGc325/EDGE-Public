import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.NormNum

namespace CommutingEffectThresholdResearchProof1

theorem table_gap (s : ℝ) (h : 1/4 ≤ s) (h1 : s ≤ 1) : let z := (1-s^2)/10; let k := 2*z; let l := (1-s)*(4*s-1)/20; 0 ≤ z ∧ 0 ≤ l ∧ l ≤ k ∧ k-l = (1-s)/4 := by
  dsimp only
  have h0 : 0 ≤ 1-s := sub_nonneg.mpr h1
  have h2 : 0 ≤ 4*s-1 := by linarith
  have h3 : 0 ≤ 1+s := by linarith
  have hz : 0 ≤ (1-s^2)/10 := by nlinarith [mul_nonneg h0 h3]
  have hl : 0 ≤ (1-s)*(4*s-1)/20 := div_nonneg (mul_nonneg h0 h2) (by norm_num)
  have hgap : 2*((1-s^2)/10)-(1-s)*(4*s-1)/20=(1-s)/4 := by ring
  exact ⟨hz,hl,by linarith, hgap⟩

end CommutingEffectThresholdResearchProof1
