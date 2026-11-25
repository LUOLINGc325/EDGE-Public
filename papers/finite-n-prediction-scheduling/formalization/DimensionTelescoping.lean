import DimensionCertificate
import UnitOptimality
import Mathlib.Tactic.FieldSimp

/-! The exact reciprocal sum estimate in the dimension comparison. -/

open scoped BigOperators

namespace FiniteFrontier

noncomputable def branchDenominator (R H : ℝ) (j : ℕ) : ℝ :=
  (R - 2) * H + (R + 2) * ((j : ℝ) + 1)

noncomputable def branchReciprocalDifference (R H : ℝ) (j : ℕ) : ℝ :=
  1 / (branchDenominator R H j - R) - 1 / branchDenominator R H j

theorem branch_denominator_split (R H : ℝ) (j : ℕ) :
    branchDenominator R H j - R = ((R - 2) * H + 2) + (R + 2) * j := by
  unfold branchDenominator
  ring

theorem branch_denominator_above_parameter (R H : ℝ) (j : ℕ) (hR : 1 ≤ R)
    (hH : 0 < (R - 2) * H + 2) : R < branchDenominator R H j := by
  apply sub_pos.mp
  rw [branch_denominator_split]
  have hnonneg : 0 ≤ (R + 2) * (j : ℝ) := by positivity
  linarith only [hH, hnonneg]

theorem branch_denominator_positive (R H : ℝ) (j : ℕ) (hR : 1 ≤ R)
    (hH : 0 ≤ (R - 2) * H + 2) : 0 < branchDenominator R H j := by
  have h : 0 ≤ branchDenominator R H j - R := by
    rw [branch_denominator_split]
    exact add_nonneg hH (by positivity)
  linarith only [hR, h]

theorem branch_reciprocal_difference_nonneg (R H : ℝ) (j : ℕ) (hR : 1 ≤ R)
    (hH : 0 < (R - 2) * H + 2) : 0 ≤ branchReciprocalDifference R H j := by
  have hd := branch_denominator_above_parameter R H j hR hH
  have hp : 0 < branchDenominator R H j := by linarith
  have hq : 0 < branchDenominator R H j - R := sub_pos.mpr hd
  unfold branchReciprocalDifference
  exact sub_nonneg.mpr (one_div_le_one_div_of_le hq (by linarith only [hR]))

theorem reciprocal_telescope_bound (R H : ℝ) (a : ℕ) (hR : 2 < R) (hH : 0 < H) :
    (∑ j ∈ Finset.range a, branchReciprocalDifference R H j) ≤
      let s := (R - 2) * H
      let c := R + 2
      R * (a : ℝ) * (s + c + 2) / ((s + c) * (s + 2) * (s + c * a + 2)) := by
  let s := (R - 2) * H
  let c := R + 2
  have hs : 0 < s := mul_pos (sub_pos.mpr hR) hH
  have hc : 0 < c := by unfold c; linarith
  have hsc : 0 < s + c := add_pos hs hc
  have h2 : 0 < s + 2 := by positivity
  let W : ℕ → ℝ := fun j => 1 / (s + c * j + 2)
  let M := R / c * ((s + c + 2) / (s + c))
  have hW (j : ℕ) : 0 < s + c * (j : ℝ) + 2 := by positivity
  have hstep (j : ℕ) :
      branchReciprocalDifference R H j ≤ M * (W j - W (j + 1)) := by
    let L := branchDenominator R H j
    have hL : L = s + c * ((j : ℝ) + 1) := rfl
    have hLlower : s + c ≤ L := by
      rw [hL]
      have ht : 0 ≤ c * (j : ℝ) := by positivity
      linarith only [ht]
    have hLp : 0 < L := hsc.trans_le hLlower
    have hLm : 0 < L - R := by
      change 0 < branchDenominator R H j - R
      rw [branch_denominator_split]
      change 0 < s + 2 + c * j
      positivity
    have hL2 : 0 < L + 2 := by positivity
    have hsub : W j - W (j + 1) = 1 / (L - R) - 1 / (L + 2) := by
      have h₀ : L - R = s + c * j + 2 := by
        unfold L branchDenominator s c
        ring
      have h₁ : L + 2 = s + c * (↑(j + 1) : ℝ) + 2 := by
        rw [hL, Nat.cast_succ]
      rw [h₀, h₁]
    have hnonneg : 0 ≤ W j - W (j + 1) := by
      rw [hsub]
      exact sub_nonneg.mpr (one_div_le_one_div_of_le hLm (by linarith only [hR]))
    have he :
        branchReciprocalDifference R H j = R / c * ((L + 2) / L) * (W j - W (j + 1)) := by
      unfold branchReciprocalDifference
      change 1 / (L - R) - 1 / L = _
      rw [hsub]
      field_simp [hc.ne', hLp.ne', hLm.ne', hL2.ne']
      unfold c
      ring
    have hfrac : (L + 2) / L ≤ (s + c + 2) / (s + c) := by
      apply (div_le_div_iff₀ hLp hsc).mpr
      linarith only [hLlower]
    rw [he]
    have hcoef : 0 ≤ R / c := div_nonneg (by linarith only [hR]) hc.le
    exact mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hfrac hcoef) hnonneg
  refine (Finset.sum_le_sum (fun j _ => hstep j)).trans_eq ?_
  rw [← Finset.mul_sum, Finset.sum_sub_distrib, sum_range_after_shift]
  have ht : (∑ j ∈ Finset.range a, W j) - ((∑ j ∈ Finset.range a, W j) + W a - W 0) =
      W 0 - W a := by ring
  rw [ht]
  have hend := hW a
  change M * (W 0 - W a) = R * (a : ℝ) * (s + c + 2) / ((s + c) * (s + 2) * (s + c * a + 2))
  unfold M W
  simp only [Nat.cast_zero, mul_zero, add_zero]
  field_simp [hc.ne', hsc.ne', h2.ne', hend.ne']
  ring

end FiniteFrontier
