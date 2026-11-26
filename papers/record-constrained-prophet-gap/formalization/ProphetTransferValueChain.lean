import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace RecordConstrainedProphetGapResearchProof1

/-- Final constant-preserving inequality (16) of the transfer theorem.

The distributional and policy comparisons are supplied as premises:
`hVS : S ≤ V` and `hSP : a * P ≤ S` express the chain
`a_{n,m} P_{n,m}(v) ≤ S(v) ≤ V_n(F)`, while `hPM : rho * M ≤ P`
is the bin-mean prophet bound of Lemma 3.  Nonnegativity of the
coefficient `a` lets the two multiplicative bounds be composed. -/
theorem transfer_value_chain (V S P M a rho : ℝ)
    (ha : 0 ≤ a) (hVS : S ≤ V) (hSP : a*P ≤ S) (hPM : rho*M ≤ P) :
    rho*a*M ≤ V := by
  have h1 : a * (rho * M) ≤ a * P :=
    mul_le_mul_of_nonneg_left hPM ha
  have h2 : rho * a * M = a * (rho * M) := by ring
  rw [h2]
  linarith

end RecordConstrainedProphetGapResearchProof1
