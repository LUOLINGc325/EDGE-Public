import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

universe u
namespace WeightedConformalPoissonTransferResearchProof1

theorem normalized_ratio_perturbation (a b A B du dv : ℝ)
         (hb : (1:ℝ)/2 ≤ b) (hB : 0 < B) (h0 : 0 ≤ A/B) (h1 : A/B ≤ 1)
         (hu : |a-A| ≤ du) (hv : |b-B| ≤ dv) : |a/b-A/B| ≤ 2*(du+dv) := by
  have hbp : 0 < b := by linarith only [hb]
  have hparts : a/b-A/B = (a-A)/b + (A/B)*((B-b)/b) := by
    field_simp [ne_of_gt hbp, ne_of_gt hB]
    ring
  have hflip : |B-b| ≤ dv := by rwa [abs_sub_comm]
  have hscaled : (A/B)*|B-b| ≤ |B-b| := by
    simpa only [one_mul] using mul_le_mul_of_nonneg_right h1 (abs_nonneg (B-b))
  have hnum : |a-A|+(A/B)*|B-b| ≤ du+dv :=
    add_le_add hu (hscaled.trans hflip)
  have hpositive : 0 ≤ du+dv :=
    add_nonneg ((abs_nonneg _).trans hu) ((abs_nonneg _).trans hv)
  calc
    |a/b-A/B| ≤ |(a-A)/b|+|(A/B)*((B-b)/b)| := by
      rw [hparts]
      exact abs_add _ _
    _ = (|a-A|+(A/B)*|B-b|)/b := by
      simp only [abs_mul, abs_of_nonneg h0, abs_div, abs_of_pos hbp]
      ring
    _ ≤ (du+dv)/b := div_le_div_of_nonneg_right hnum hbp.le
    _ ≤ 2*(du+dv) := by
      apply (div_le_iff₀ hbp).2
      nlinarith only [mul_nonneg hpositive (sub_nonneg.mpr hb)]

end WeightedConformalPoissonTransferResearchProof1
