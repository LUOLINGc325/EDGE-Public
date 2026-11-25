import FiniteFrontier
import Mathlib.Tactic.Positivity

/-! The exact Bernstein certificate for the branch derivative in Appendix A. -/

namespace FiniteFrontier

noncomputable def branchNumerator (R H a : ℝ) : ℝ :=
  let s := (R - 2) * H
  let c := R + 2
  (R + 1) * (s + c) * (s + 2) * (s + c * a + 2) -
    R * (s + c + 2) * s * ((R - 1) * H + (R + 1) * a)

noncomputable def bernsteinZero (v b : ℝ) : ℝ :=
  2 * (v + 3) *
    (b ^ 2 * (v ^ 4 + 6 * v ^ 3 + 9 * v ^ 2) +
      b * (2 * v ^ 4 + 14 * v ^ 3 + 35 * v ^ 2 + 38 * v + 16) +
      (v ^ 4 + 8 * v ^ 3 + 26 * v ^ 2 + 40 * v + 24))

noncomputable def bernsteinOne (v b : ℝ) : ℝ :=
  2 * (v + 3) / 3 *
    (b ^ 2 * (2 * v ^ 4 + 12 * v ^ 3 + 18 * v ^ 2) +
      b * (6 * v ^ 4 + 41 * v ^ 3 + 96 * v ^ 2 + 96 * v + 48) +
      (4 * v ^ 4 + 31 * v ^ 3 + 94 * v ^ 2 + 132 * v + 72))

noncomputable def bernsteinTwo (v b : ℝ) : ℝ :=
  2 * (v + 3) / 3 *
    (b ^ 2 * (v ^ 4 + 6 * v ^ 3 + 9 * v ^ 2) +
      b * (4 * v ^ 4 + 28 * v ^ 3 + 69 * v ^ 2 + 78 * v + 48) +
      (4 * v ^ 4 + 31 * v ^ 3 + 92 * v ^ 2 + 126 * v + 72))

noncomputable def bernsteinThree (v b : ℝ) : ℝ :=
  2 * (v + 2) * (v + 3) * (v + 4) * (b * v + 2 * b + 2 * v + 3)

theorem bernstein_basis_partition (θ : ℝ) :
    (1 - θ) ^ 3 + 3 * θ * (1 - θ) ^ 2 +
      3 * θ ^ 2 * (1 - θ) + θ ^ 3 = 1 := by
  ring

theorem branch_numerator_expansion (v b θ : ℝ) :
    branchNumerator (v + 2) ((v + 3) * (b + 1 + θ)) (b + 1) =
      bernsteinZero v b * (1 - θ) ^ 3 +
        bernsteinOne v b * (3 * θ * (1 - θ) ^ 2) +
        bernsteinTwo v b * (3 * θ ^ 2 * (1 - θ)) +
        bernsteinThree v b * θ ^ 3 := by
  unfold branchNumerator bernsteinZero bernsteinOne bernsteinTwo bernsteinThree
  ring

theorem bernstein_coefficients_positive (v b : ℝ) (hv : 0 ≤ v) (hb : 0 ≤ b) :
    0 < bernsteinZero v b ∧ 0 < bernsteinOne v b ∧
      0 < bernsteinTwo v b ∧ 0 < bernsteinThree v b := by
  unfold bernsteinZero bernsteinOne bernsteinTwo bernsteinThree
  exact ⟨by positivity, by positivity, by positivity, by positivity⟩

theorem branch_numerator_positive_transformed (v b θ : ℝ) (hv : 0 ≤ v) (hb : 0 ≤ b)
    (hθ₀ : 0 ≤ θ) (hθ₁ : θ ≤ 1) :
    0 < branchNumerator (v + 2) ((v + 3) * (b + 1 + θ)) (b + 1) := by
  have hθ : 0 ≤ 1 - θ := sub_nonneg.mpr hθ₁
  obtain ⟨h0, h1, h2, h3⟩ := bernstein_coefficients_positive v b hv hb
  rw [branch_numerator_expansion]
  by_cases hboundary : θ = 1
  · simpa [hboundary] using h3
  have hstrict : 0 < 1 - θ := sub_pos.mpr (lt_of_le_of_ne hθ₁ hboundary)
  have ht₀ : 0 < bernsteinZero v b * (1 - θ) ^ 3 := by positivity
  have ht₁ : 0 ≤ bernsteinOne v b * (3 * θ * (1 - θ) ^ 2) := by positivity
  have ht₂ : 0 ≤ bernsteinTwo v b * (3 * θ ^ 2 * (1 - θ)) := by positivity
  have ht₃ : 0 ≤ bernsteinThree v b * θ ^ 3 := by positivity
  linarith

/-- The Bernstein certificate on every positive-index branch, including its endpoints. -/
theorem branch_numerator_positive (R H a : ℝ) (hR : 2 ≤ R) (ha : 1 ≤ a)
    (hH₀ : (R + 1) * a ≤ H) (hH₁ : H ≤ (R + 1) * (a + 1)) :
    0 < branchNumerator R H a := by
  have hp : 0 < R + 1 := by linarith
  let θ := H / (R + 1) - a
  have hθ₀ : 0 ≤ θ := sub_nonneg.mpr ((le_div_iff₀ hp).mpr (by simpa [mul_comm] using hH₀))
  have hθ₁ : θ ≤ 1 := by
    have h : H / (R + 1) ≤ a + 1 := (div_le_iff₀ hp).mpr (by simpa [mul_comm] using hH₁)
    dsimp [θ]
    linarith
  have hparam : (R - 2 + 3) * (a - 1 + 1 + θ) = H := by
    have hd : H / (R + 1) * (R + 1) = H := div_mul_cancel₀ _ hp.ne'
    dsimp [θ]
    calc
      (R - 2 + 3) * (a - 1 + 1 + (H / (R + 1) - a)) =
          H / (R + 1) * (R + 1) := by ring
      _ = H := hd
  have hR' : R - 2 + 2 = R := by ring
  have ha' : a - 1 + 1 = a := by ring
  have h := branch_numerator_positive_transformed (R - 2) (a - 1) θ
    (sub_nonneg.mpr hR) (sub_nonneg.mpr ha) hθ₀ hθ₁
  rw [hparam, hR', ha'] at h
  exact h

end FiniteFrontier
