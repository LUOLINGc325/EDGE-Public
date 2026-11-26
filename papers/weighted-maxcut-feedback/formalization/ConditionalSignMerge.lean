import SignAbsoluteMean

namespace WeightedMaxcutFeedbackResearchProof1

/-- The two-sign merge inequality for nonnegative coefficients from section 4.1. -/
theorem conditional_sign_merge (z a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    (|z + a + b| + |z + a - b| + |z - a + b| + |z - a - b|) / 4 ≤
      (|z + (a + b)| + |z - (a + b)|) / 2 := by
  have hsum : |a + b| = a + b := abs_of_nonneg (add_nonneg ha hb)
  have hdiff : |a - b| ≤ |a + b| := by
    rw [hsum, abs_le]
    exact ⟨by linarith, by linarith⟩
  have hmerge : max |z| |a - b| ≤ max |z| |a + b| :=
    max_le_max le_rfl hdiff
  have h1 : z + a + b = z + (a + b) := by linarith
  have h2 : z + a - b = z + (a - b) := by linarith
  have h3 : z - a + b = z - (a - b) := by linarith
  have h4 : z - a - b = z - (a + b) := by linarith
  rw [h1, h2, h3, h4]
  linarith [two_sign_mean z (a + b), two_sign_mean z (a - b)]

end WeightedMaxcutFeedbackResearchProof1
