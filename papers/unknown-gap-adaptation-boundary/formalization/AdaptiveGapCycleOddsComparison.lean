import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Analysis.SpecialFunctions.Exp

namespace UnknownGapAdaptationBoundaryResearchProof2

/-- The diagnostic odds `q/(1-q)` are bounded by `e^{-h}/(1-e^{-h})` whenever
`q ≤ e^{-h}`, with `h > 0` ensuring `0 < e^{-h} < 1`. This is the algebraic
comparison of (22) and (24) used in (25). -/
theorem cycle_odds_comparison (h q : ℝ) (hh : 0 < h)
    (hq : q ≤ Real.exp (-h)) :
    q/(1-q) ≤ Real.exp (-h)/(1-Real.exp (-h)) := by
  have hpos : 0 < Real.exp (-h) := Real.exp_pos _
  have hlt : Real.exp (-h) < 1 := by
    rw [Real.exp_lt_one_iff]
    linarith
  have hq1 : q < 1 := lt_of_le_of_lt hq hlt
  have hqsub' : 0 < 1 - q := by linarith
  have hqsub : 0 < 1 - Real.exp (-h) := by linarith
  rw [div_le_div_iff₀ hqsub' hqsub]
  nlinarith [hpos, hlt, hq, mul_pos hqsub hqsub']

end UnknownGapAdaptationBoundaryResearchProof2
