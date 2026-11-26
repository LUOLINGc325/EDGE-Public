import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Analysis.SpecialFunctions.Exp

namespace UnknownGapAdaptationBoundaryResearchProof3

/-- Completion of the square identity for the Gaussian shift integrand of
Lemma 5 (paper lines 421–428): for every real `t`,
`exp(t/2 - t²/2) = exp(1/8) * exp(-((t - 1/2)²)/2)`.
The exponent identity `t/2 - t²/2 = 1/8 - (t - 1/2)²/2` is pure algebra;
the conclusion follows from `Real.exp_add`. -/
theorem gaussian_shift_complete_square (t : ℝ) :
    Real.exp (t / 2 - t ^ 2 / 2) = Real.exp (1 / 8) * Real.exp (-((t - 1 / 2) ^ 2) / 2) := by
  rw [← Real.exp_add]
  congr 1
  ring

end UnknownGapAdaptationBoundaryResearchProof3
