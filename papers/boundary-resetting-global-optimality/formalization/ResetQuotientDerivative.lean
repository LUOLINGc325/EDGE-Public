import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Tactic.Ring

namespace BoundaryResettingGlobalOptimalityResearchProof1

/-- Exact child of Lemma 4.1's proof: from the Wronskian value
`s x * dk - ds * k x = B`, the quotient `k / s` has derivative
`B / (s x)^2` at any point `x` where `s x ≠ 0`. -/
theorem reset_quotient_derivative (s k : ℝ → ℝ) (x ds dk B : ℝ)
    (hs : HasDerivAt s ds x) (hk : HasDerivAt k dk x) (hn : s x ≠ 0)
    (hW : s x * dk - ds * k x = B) :
    HasDerivAt (fun y => k y / s y) (B / (s x)^2) x := by
  have hdiv := hk.div hs hn
  -- derivative value of `k / s`
  have hval : (dk * s x - k x * ds) / (s x)^2 = B / (s x)^2 := by
    rw [← hW]
    congr 1
    ring
  rw [hval] at hdiv
  exact hdiv

end BoundaryResettingGlobalOptimalityResearchProof1
