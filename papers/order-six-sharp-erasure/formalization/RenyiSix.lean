import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace OrderSixSharpErasureResearchProof1

/-- The erasure-channel scalar in equation (1). -/
noncomputable def erasureCombine (x y : ℝ) : ℝ :=
  (1 / 32 : ℝ) + (x - 1 / 32) * ((y - 1 / 32) / (1 - 1 / 32))

theorem erasure_combine_symmetric (x y : ℝ) :
    erasureCombine x y = erasureCombine y x := by
  unfold erasureCombine
  ring

theorem erasure_combine_ge_lower {x y : ℝ} (hx : (1 / 32 : ℝ) ≤ x)
    (hy : (1 / 32 : ℝ) ≤ y) :
    (1 / 32 : ℝ) ≤ erasureCombine x y := by
  unfold erasureCombine
  exact le_add_of_nonneg_right (mul_nonneg (sub_nonneg.mpr hx)
    (div_nonneg (sub_nonneg.mpr hy) (by norm_num)))

theorem erasure_combine_le_left {x y : ℝ} (hx : (1 / 32 : ℝ) ≤ x) (hy : y ≤ 1) :
    erasureCombine x y ≤ x := by
  have hn : (0 : ℝ) < 1 - 1 / 32 := by norm_num
  have hy' : (y - 1 / 32) / (1 - 1 / 32) ≤ 1 :=
    (div_le_one hn).2 (sub_le_sub_right hy (1 / 32 : ℝ))
  have hb := mul_le_of_le_one_right (sub_nonneg.mpr hx) hy'
  unfold erasureCombine
  linarith

/-- The scalar output remains between 1/32 and the smaller input moment. -/
theorem erasure_combine_mem {x y : ℝ} (hx : (1 / 32 : ℝ) ≤ x) (hx' : x ≤ 1)
    (hy : (1 / 32 : ℝ) ≤ y) (hy' : y ≤ 1) :
    (1 / 32 : ℝ) ≤ erasureCombine x y ∧ erasureCombine x y ≤ min x y := by
  refine ⟨erasure_combine_ge_lower hx hy, le_min (erasure_combine_le_left hx hy') ?_⟩
  rw [erasure_combine_symmetric]
  exact erasure_combine_le_left hy hx'

end OrderSixSharpErasureResearchProof1
