import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace GaffkeDeltaSharpBoundResearchProof1

/-- From the §3 identities `D = 1 - K` and `ΔK = A - D`, together with the
probability bounds `0 ≤ D ≤ A ≤ 1`, the deletion increment `A - D` lies in
`[0, K]`. -/
theorem deletion_positive_gap (A D K : ℝ) (hAD : D ≤ A) (hD : 0 ≤ D)
    (hA : A ≤ 1) (hK : D = 1 - K) :
    0 ≤ A - D ∧ A - D ≤ K := by
  have _ := hD
  constructor
  · linarith
  · linarith

end GaffkeDeltaSharpBoundResearchProof1
