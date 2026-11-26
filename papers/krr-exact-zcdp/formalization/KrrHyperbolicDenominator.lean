import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace KrrExactZcdpResearchProof1

/-- The exact formula `B'(t) = t * sinh t` for
`B(t) = t * cosh t - sinh t`, as used in Lemma 1 of the manuscript. -/
theorem curvature_denominator_derivative (t : ℝ) :
    HasDerivAt (fun z : ℝ => z*Real.cosh z-Real.sinh z) (t*Real.sinh t) t := by
  have hz : HasDerivAt (fun z : ℝ => z * Real.cosh z)
      (1 * Real.cosh t + t * Real.sinh t) t := by
    have h1 : HasDerivAt (fun z : ℝ => z) 1 t := hasDerivAt_id t
    have h2 : HasDerivAt Real.cosh (Real.sinh t) t := Real.hasDerivAt_cosh t
    simpa using h1.mul h2
  have hs : HasDerivAt Real.sinh (Real.cosh t) t := Real.hasDerivAt_sinh t
  have h := hz.sub hs
  convert h using 1
  ring

end KrrExactZcdpResearchProof1
