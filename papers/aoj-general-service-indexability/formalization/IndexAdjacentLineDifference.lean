import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

namespace AojGeneralServiceIndexabilityResearchProof2

/-- Equation (6.3): the successive difference of the Whittle-index lines
`H_s = (w/μ) * (x * D_s - C_s) / μ`-normalized family, where the time index
ranges over all natural numbers. Concretely, the published difference
`H_{s+1} - H_s = (w/μ) * (x - μ - s)` for the ambient line family
`H s = (w/μ) * (x * ((s:ℝ) + μ + z) - s*(s-1)/2 - μ*s - τ)`. -/
theorem adjacent_line_difference (w μ x z τ : ℝ) (n : ℕ) :
    let H := fun s : ℕ =>
      (w / μ) * (x * ((s : ℝ) + μ + z) - (s : ℝ) * ((s : ℝ) - 1) / 2 - μ * s - τ)
    H (n + 1) - H n = (w / μ) * (x - μ - n) := by
  dsimp only
  simp only [Nat.cast_add, Nat.cast_one]
  show (w / μ) * (x * (((n : ℝ) + 1) + μ + z) - ((n : ℝ) + 1) * (((n : ℝ) + 1) - 1) / 2
        - μ * ((n : ℝ) + 1) - τ)
      - (w / μ) * (x * ((n : ℝ) + μ + z) - (n : ℝ) * ((n : ℝ) - 1) / 2 - μ * n - τ)
      = (w / μ) * (x - μ - n)
  ring

end AojGeneralServiceIndexabilityResearchProof2
