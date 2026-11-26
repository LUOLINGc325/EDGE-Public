import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace BinaryMarkovGrayDispersionResearchProof1

/-- Equation (27), the two dot-product identities for the explicit real vectors
`u_0 = (1+s, 1-s)` and `u_1 = (1-s, 1+s)` with `s^2 = 1 - 2p`.
The first conjunct is `u_x^† u_x = 4(1-p)` (equal-state pairing),
the second is `u_x^† u_{1-x} = 4p` (unequal-state pairing). -/
theorem marked_vector_pairings (p s : ℝ) (hs : s^2 = 1-2*p) :
         (1+s)^2+(1-s)^2 = 4*(1-p) ∧ (1+s)*(1-s)+(1-s)*(1+s) = 4*p := by
  constructor
  · nlinarith [hs]
  · nlinarith [hs]

end BinaryMarkovGrayDispersionResearchProof1
