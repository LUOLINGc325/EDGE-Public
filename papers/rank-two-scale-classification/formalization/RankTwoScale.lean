import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace RankTwoScaleClassificationResearchProof1

/-- Right side of the first equation in (6), after eliminating ζ.
Here m denotes the squared modulus of the off-diagonal coefficient. -/
noncomputable def scaleValue (b m q : ℝ) : ℝ :=
  (-2 : ℝ) * q * m / (1 - q * b)

/-- A nonscalar square-zero case can meet the scalar equation at most once
because the right side is strictly decreasing on the positive-denominator domain. -/
theorem scaleValue_strict_antitone (b m q₁ q₂ : ℝ) (hm : 0 < m)
    (h₁ : 0 < 1 - q₁ * b) (h₂ : 0 < 1 - q₂ * b) (hq : q₁ < q₂) :
    scaleValue b m q₂ < scaleValue b m q₁ := by
  unfold scaleValue
  apply (div_lt_div_iff₀ h₂ h₁).2
  have hd : (0 : ℝ) < (2 * m) * (q₂ - q₁) :=
    mul_pos (mul_pos (by norm_num) hm) (sub_pos.mpr hq)
  nlinarith only [hd]

theorem scale_value_unique (b m q₁ q₂ v : ℝ) (hm : 0 < m)
    (h₁ : 0 < 1 - q₁ * b) (h₂ : 0 < 1 - q₂ * b)
    (hval₁ : scaleValue b m q₁ = v) (hval₂ : scaleValue b m q₂ = v) :
    q₁ = q₂ := by
  rcases lt_trichotomy q₁ q₂ with h | h | h
  · have hd := scaleValue_strict_antitone b m q₁ q₂ hm h₁ h₂ h
    rw [hval₁, hval₂] at hd
    exact False.elim (lt_irrefl _ hd)
  · exact h
  · have hd := scaleValue_strict_antitone b m q₂ q₁ hm h₂ h₁ h
    rw [hval₁, hval₂] at hd
    exact False.elim (lt_irrefl _ hd)

end RankTwoScaleClassificationResearchProof1
