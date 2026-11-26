import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

namespace DirectedCycleTwoSeasonWitness

/-- Equation (5), with `u = exp ε` and `s = u + u⁻¹`. -/
noncomputable def overlap (u : ℝ) : ℝ := (u + u⁻¹ + 2)^2 / (8 * (u + u⁻¹))

theorem overlap_gap {u : ℝ} (hu : 0 < u) :
    overlap u = 1 + (u + u⁻¹ - 2)^2 / (8 * (u + u⁻¹)) := by
  have hs : 0 < u + u⁻¹ := add_pos hu (inv_pos.mpr hu)
  unfold overlap
  field_simp [ne_of_gt hs]
  ring

theorem overlap_gt_one {u : ℝ} (hu : 0 < u) (hne : u ≠ 1) : 1 < overlap u := by
  have hdiff : u + u⁻¹ - 2 = (u - 1)^2 / u := by
    field_simp [ne_of_gt hu]
    ring
  have hpos : 0 < u + u⁻¹ - 2 := by
    rw [hdiff]
    exact div_pos (sq_pos_of_ne_zero (sub_ne_zero.mpr hne)) hu
  have hs : 0 < u + u⁻¹ := add_pos hu (inv_pos.mpr hu)
  rw [overlap_gap hu]
  have hg : 0 < (u + u⁻¹ - 2)^2 / (8 * (u + u⁻¹)) :=
    div_pos (pow_pos hpos 2) (mul_pos (by norm_num) hs)
  linarith

theorem overlap_two : overlap 2 = 81/80 := by norm_num [overlap]

end DirectedCycleTwoSeasonWitness
