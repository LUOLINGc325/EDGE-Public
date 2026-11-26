import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace GaffkeDeltaSharpBoundResearchProof1

/-- Positive-root extraction from the natural-power inequality `D^r ≤ A^(r+1)`:
the real `(r/(r+1))`-th root of `D` is at most `A`.  Handles `A = 0` and `D = 0`. -/
theorem deletion_root_extraction (A D : ℝ) (r : ℕ)
    (hr : 0 < r) (hA : 0 ≤ A) (hD : 0 ≤ D) (h : D^r ≤ A^(r+1)) :
    Real.rpow D ((r : ℝ)/(r+1)) ≤ A := by
  have hrR : 0 < (r : ℝ) := Nat.cast_pos.mpr hr
  have hN : 0 < (r : ℝ) + 1 := by linarith
  have hcast : (r : ℝ) + 1 = ((r + 1 : ℕ) : ℝ) := by norm_num
  apply (Real.rpow_le_rpow_iff (Real.rpow_nonneg hD _) hA hN).mp
  change (D ^ ((r : ℝ)/((r : ℝ)+1))) ^ ((r : ℝ)+1) ≤ A ^ ((r : ℝ)+1)
  rw [← Real.rpow_mul hD, div_mul_cancel₀ _ hN.ne', Real.rpow_natCast, hcast, Real.rpow_natCast]
  exact h

end GaffkeDeltaSharpBoundResearchProof1
