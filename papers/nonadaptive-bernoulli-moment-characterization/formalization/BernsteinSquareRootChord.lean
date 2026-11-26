import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Data.Real.Sqrt

universe u
namespace NonadaptiveBernoulliMomentCharacterizationResearchProof1

theorem square_root_chord_bound (x Y : ℝ) (hx0 : 0 < x) (hx1 : x < 1)
         (hY0 : 0 ≤ Y) (hY1 : Y ≤ 1) :
         (Real.sqrt Y-Real.sqrt x)^2+(Real.sqrt (1-Y)-Real.sqrt (1-x))^2
         ≤ (Y-x)^2/x+(Y-x)^2/(1-x) := by
  have pointwise (s y : ℝ) (hs : 0 < s) (hy : 0 ≤ y) :
      (Real.sqrt y - Real.sqrt s)^2 ≤ (y-s)^2/s := by
    have hss := Real.sq_sqrt hs.le
    have hyy := Real.sq_sqrt hy
    have hcross : 0 ≤ Real.sqrt y * Real.sqrt s :=
      mul_nonneg (Real.sqrt_nonneg y) (Real.sqrt_nonneg s)
    have hden : s ≤ (Real.sqrt y + Real.sqrt s)^2 := by
      nlinarith only [hss, hyy, hy, hcross]
    apply (le_div_iff₀ hs).2
    calc
      (Real.sqrt y - Real.sqrt s)^2*s ≤
          (Real.sqrt y - Real.sqrt s)^2*(Real.sqrt y + Real.sqrt s)^2 :=
        mul_le_mul_of_nonneg_left hden (sq_nonneg _)
      _ = (y-s)^2 := by
        rw [← mul_pow]
        congr 1
        nlinarith only [hss, hyy]
  have hleft := pointwise x Y hx0 hY0
  have hright := pointwise (1-x) (1-Y) (sub_pos.mpr hx1) (sub_nonneg.mpr hY1)
  have heq : (1-Y-(1-x))^2 = (Y-x)^2 := by ring
  rw [heq] at hright
  exact add_le_add hleft hright

end NonadaptiveBernoulliMomentCharacterizationResearchProof1
