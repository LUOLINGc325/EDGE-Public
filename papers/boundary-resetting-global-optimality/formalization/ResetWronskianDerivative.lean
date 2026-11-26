import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Tactic.Ring

namespace BoundaryResettingGlobalOptimalityResearchProof1

/-- Wronskian derivative for the half-interval initial-value solutions:
`s'' = r * s`, `k'' = r * k + 1`. At each point where the ODEs hold,
the Wronskian `s * k' - s' * k` has derivative `s`. -/
theorem reset_wronskian_derivative (s k ds dk : ℝ → ℝ) (r x : ℝ)
    (hs : HasDerivAt s (ds x) x) (hk : HasDerivAt k (dk x) x)
    (hss : HasDerivAt ds (r * s x) x)
    (hkk : HasDerivAt dk (r * k x + 1) x) :
    HasDerivAt (fun y => s y * dk y - ds y * k y) (s x) x := by
  have h1 : HasDerivAt (fun y => s y * dk y) (ds x * dk x + s x * (r * k x + 1)) x :=
    hs.mul hkk
  have h2 : HasDerivAt (fun y => ds y * k y) ((r * s x) * k x + ds x * dk x) x :=
    hss.mul hk
  have h := HasDerivAt.sub h1 h2
  have e : ds x * dk x + s x * (r * k x + 1) - ((r * s x) * k x + ds x * dk x) = s x := by
    ring
  change HasDerivAt (fun y => s y * dk y - ds y * k y)
    (ds x * dk x + s x * (r * k x + 1) - ((r * s x) * k x + ds x * dk x)) x at h
  rw [e] at h
  exact h

end BoundaryResettingGlobalOptimalityResearchProof1
