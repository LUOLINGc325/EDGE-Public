import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace UnknownGapAdaptationBoundaryResearchProof1

/-- Child lemma for the factor-128 passage in Section 8 (Theorem 2/3 upper bound).

The source has `h ≥ log 2`, which gives `exp(-h) ≤ 1/2`, hence `1 - exp(-h) ≥ 1/2`
and the reciprocal `1/(1 - exp(-h)) ≤ 2`.  Multiplying the tail coefficient
`64 * exp(-h)/(1 - exp(-h))` (equation (25)) by this factor yields the
`128 * exp(-h)` upper bound used to obtain (7)/(8). -/
theorem half_tail_adaptation_bound (h : ℝ) (hh : Real.log 2 ≤ h) :
    64*(Real.exp (-h)/(1-Real.exp (-h))) ≤ 128*Real.exp (-h) := by
  have h2 : (2:ℝ) = Real.exp (Real.log 2) := (Real.exp_log (by norm_num)).symm
  have hexp_le : Real.exp (-h) ≤ 1/2 := by
    have hle : Real.exp (-h) ≤ Real.exp (-(Real.log 2)) :=
      Real.exp_le_exp.mpr (by linarith)
    have hval : Real.exp (-(Real.log 2)) = 1/2 := by
      rw [Real.exp_neg, h2]
      norm_num
    linarith
  have hpos : 0 < Real.exp (-h) := Real.exp_pos _
  have hden_pos : 0 < 1 - Real.exp (-h) := by linarith
  have hrec : 1 / (1 - Real.exp (-h)) ≤ 2 := by
    rw [div_le_iff₀ hden_pos]
    linarith
  calc 64*(Real.exp (-h)/(1-Real.exp (-h)))
      = 64 * (Real.exp (-h) * (1/(1-Real.exp (-h)))) := by
        rw [div_eq_mul_one_div]
    _ ≤ 64 * (Real.exp (-h) * 2) := by
        apply mul_le_mul_of_nonneg_left _ (by norm_num)
        exact mul_le_mul_of_nonneg_left hrec (le_of_lt hpos)
    _ = 128 * Real.exp (-h) := by ring

end UnknownGapAdaptationBoundaryResearchProof1
