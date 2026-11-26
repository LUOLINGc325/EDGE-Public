import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

namespace AojGeneralServiceIndexabilityResearchProof2

/-- Corollary 6.2 (partial): with the maximizing integer `n` from (6.1) held fixed,
increasing the second service moment `τ` by `δ` lowers the exact index `W(d,k)`
by exactly `w·δ/μ`.  The two displayed candidate formulas differ identically,
so the equality is algebraic and applies to any realizable parameter tuple. -/
theorem service_moment_shift (w μ x z τ δ : ℝ) (n : ℕ) :
    (w/μ)*(x*(n+μ+z)-(n:ℝ)*(n-1:ℝ)/2-μ*n-(τ+δ))
      - (w/μ)*(x*(n+μ+z)-(n:ℝ)*(n-1:ℝ)/2-μ*n-τ)
      = -w*δ/μ := by
  ring

end AojGeneralServiceIndexabilityResearchProof2
