import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace WeightedMaxcutFeedbackResearchProof1

/-- The conditional absolute mean of two equiprobable signs, from section 4.1. -/
theorem two_sign_mean (z a : ℝ) : (|z + a| + |z - a|) / 2 = max |z| |a| := by
  rcases le_total 0 (z + a) with hsum | hsum <;>
    rcases le_total 0 (z - a) with hdiff | hdiff
  · have ha : |a| ≤ z := abs_le.mpr ⟨by linarith, by linarith⟩
    rw [abs_of_nonneg hsum, abs_of_nonneg hdiff, abs_of_nonneg (by linarith : 0 ≤ z),
      max_eq_left ha]
    linarith
  · have hz : |z| ≤ a := abs_le.mpr ⟨by linarith, by linarith⟩
    rw [abs_of_nonneg hsum, abs_of_nonpos hdiff, abs_of_nonneg (by linarith : 0 ≤ a),
      max_eq_right hz]
    linarith
  · have hz : |z| ≤ -a := abs_le.mpr ⟨by linarith, by linarith⟩
    rw [abs_of_nonpos hsum, abs_of_nonneg hdiff, abs_of_nonpos (by linarith : a ≤ 0),
      max_eq_right hz]
    linarith
  · have ha : |a| ≤ -z := abs_le.mpr ⟨by linarith, by linarith⟩
    rw [abs_of_nonpos hsum, abs_of_nonpos hdiff, abs_of_nonpos (by linarith : z ≤ 0),
      max_eq_left ha]
    linarith

end WeightedMaxcutFeedbackResearchProof1
