import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

open scoped BigOperators

namespace ExactConvexProfileCapitalResearchProof1

theorem zero_capital_slack (a : ℝ) (h : ℝ → ℝ) (hm : MonotoneOn h (Set.Icc 0 1)) : (∀ b ∈ Set.Icc (0:ℝ) 1, ∀ d ∈ Set.Icc (0:ℝ) 1, b*max (a-h d) 0+d*max (a-h b) 0 = 0) ↔ a ≤ h 0 := by
  have h0 : (0:ℝ) ∈ Set.Icc 0 1 := ⟨le_rfl, zero_le_one⟩
  have h1 : (1:ℝ) ∈ Set.Icc 0 1 := ⟨zero_le_one, le_rfl⟩
  constructor
  · intro H
    have he : max (a-h 0) 0 = 0 := by simpa only [one_mul, zero_mul, add_zero] using H 1 h1 0 h0
    linarith [le_max_left (a-h 0) 0]
  · intro hbase b hb d hd
    have hb' : a-h b ≤ 0 := sub_nonpos.mpr (hbase.trans (hm h0 hb hb.1))
    have hd' : a-h d ≤ 0 := sub_nonpos.mpr (hbase.trans (hm h0 hd hd.1))
    rw [max_eq_right hb', max_eq_right hd', mul_zero, mul_zero, add_zero]

end ExactConvexProfileCapitalResearchProof1
