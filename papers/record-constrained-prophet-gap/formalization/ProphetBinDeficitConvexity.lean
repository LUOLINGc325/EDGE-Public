import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Analysis.Convex.Mul

namespace RecordConstrainedProphetGapResearchProof3

/-- Convexity inequality (11) for the bin deficit. -/
theorem bin_deficit_nonnegative (n : ℕ) (a h t : ℝ)
         (ha : 0 ≤ a) (hh : 0 ≤ h) (ht : 0 ≤ t) (ht1 : t ≤ 1) :
         0 ≤ (1-t)*a^n+t*(a+h)^n-(a+t*h)^n := by
  have hah : a+h ∈ Set.Ici (0 : ℝ) := add_nonneg ha hh
  have hweight : 0 ≤ 1-t := sub_nonneg.mpr ht1
  have htotal : (1-t)+t = 1 := by ring
  have hconv := (convexOn_pow (𝕜 := ℝ) n).2 (show a ∈ Set.Ici (0 : ℝ) from ha)
    hah hweight ht htotal
  simp only [smul_eq_mul] at hconv
  rw [show a+t*h = (1-t)*a+t*(a+h) by ring]
  exact sub_nonneg.mpr hconv

end RecordConstrainedProphetGapResearchProof3
