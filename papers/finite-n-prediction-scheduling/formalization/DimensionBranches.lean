import DimensionTelescoping
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.Calculus.Deriv.MeanValue

/-! Differentiation on one dimension branch, including the finite-sum logarithmic derivative. -/

open scoped BigOperators

namespace FiniteFrontier

variable {α : Type*}

theorem finite_product_relative_derivative (s : Finset α) (f : α → ℝ → ℝ)
    (d : α → ℝ) (x : ℝ) (hf : ∀ i ∈ s, HasDerivAt (f i) (f i x * d i) x) :
    HasDerivAt (fun t => ∏ i ∈ s, f i t)
      ((∏ i ∈ s, f i x) * (∑ i ∈ s, d i)) x := by
  classical
  induction s using Finset.induction_on with
  | empty => simpa using hasDerivAt_const x (1 : ℝ)
  | @insert i s hi ih =>
    have hp := (hf i (Finset.mem_insert_self _ _)).mul
      (ih (fun j hj => hf j (Finset.mem_insert_of_mem hj)))
    simp only [Finset.prod_insert hi, Finset.sum_insert hi]
    convert hp using 1
    ring

noncomputable def branchFactor (R H : ℝ) (j : ℕ) : ℝ := 1 - R / branchDenominator R H j

noncomputable def branchLeading (R H : ℝ) (a : ℕ) : ℝ := R - 1 + (R + 1) * a / H

noncomputable def branchRelativeSlope (R H : ℝ) (a : ℕ) : ℝ :=
  -((R + 1) * a) / (H * ((R - 1) * H + (R + 1) * a)) +
    (R - 2) * ∑ j ∈ Finset.range a, branchReciprocalDifference R H j

theorem branch_factor_derivative (R H : ℝ) (j : ℕ)
    (hden : branchDenominator R H j ≠ 0) :
    HasDerivAt (fun t => branchFactor R t j)
      ((R - 2) * R / branchDenominator R H j ^ 2) H := by
  have hden' : HasDerivAt (fun t => branchDenominator R t j) (R - 2) H := by
    simpa [branchDenominator] using
      (((hasDerivAt_id' H).const_mul (R - 2)).add_const ((R + 2) * ((j : ℝ) + 1)))
  have h := ((hasDerivAt_const H R).div hden' hden).const_sub 1
  convert h using 1
  ring

theorem branch_factor_relative_derivative (R H : ℝ) (j : ℕ) (hR : 1 ≤ R)
    (hH : 0 < (R - 2) * H + 2) :
    HasDerivAt (fun t => branchFactor R t j)
      (branchFactor R H j * ((R - 2) * branchReciprocalDifference R H j)) H := by
  have hp := branch_denominator_positive R H j hR hH.le
  have hq := sub_pos.mpr (branch_denominator_above_parameter R H j hR hH)
  convert branch_factor_derivative R H j hp.ne' using 1
  unfold branchFactor branchReciprocalDifference
  field_simp [hp.ne', hq.ne']
  ring

theorem branch_product_positive (R H : ℝ) (a : ℕ) (hR : 1 ≤ R)
    (hH : 0 < (R - 2) * H + 2) : 0 < branchProduct R H a := by
  change 0 < ∏ j ∈ Finset.range a, branchFactor R H j
  apply Finset.prod_pos
  intro j _
  exact sub_pos.mpr ((div_lt_one (branch_denominator_positive R H j hR hH.le)).mpr
    (branch_denominator_above_parameter R H j hR hH))

theorem branch_leading_derivative (R H : ℝ) (a : ℕ) (hH : H ≠ 0) :
    HasDerivAt (fun t => branchLeading R t a) (-((R + 1) * a) / H ^ 2) H := by
  have h := ((hasDerivAt_const H ((R + 1) * (a : ℝ))).div (hasDerivAt_id' H) hH).const_add (R - 1)
  simpa [branchLeading] using h

theorem branch_leading_relative_derivative (R H : ℝ) (a : ℕ) (hH : 0 < H)
    (hR : 1 ≤ R) (ha : 0 < a) :
    HasDerivAt (fun t => branchLeading R t a)
      (branchLeading R H a * (-((R + 1) * a) / (H * ((R - 1) * H + (R + 1) * a)))) H := by
  have ha' : 0 < (a : ℝ) := by exact_mod_cast ha
  have hR₀ : 0 ≤ R - 1 := sub_nonneg.mpr hR
  have hD : 0 < (R - 1) * H + (R + 1) * (a : ℝ) := by positivity
  convert branch_leading_derivative R H a hH.ne' using 1
  unfold branchLeading
  field_simp [hH.ne', hD.ne']
  ring

theorem branch_value_continuous_at (R H : ℝ) (a : ℕ) (hH : 0 < H) (hR : 1 ≤ R)
    (hf : 0 ≤ (R - 2) * H + 2) : ContinuousAt (fun t => branchValue R t a) H := by
  have hl := (branch_leading_derivative R H a hH.ne').continuousAt
  have hp : ContinuousAt (fun t => ∏ j ∈ Finset.range a, branchFactor R t j) H :=
    (DifferentiableAt.finset_prod fun j _ =>
      (branch_factor_derivative R H j (branch_denominator_positive R H j hR hf).ne').differentiableAt).continuousAt
  exact continuousAt_const.sub (hl.mul hp)

theorem branch_value_derivative (R H : ℝ) (a : ℕ) (hH : 0 < H) (hR : 1 ≤ R)
    (ha : 0 < a) (hf : 0 < (R - 2) * H + 2) :
    HasDerivAt (fun t => branchValue R t a)
      (-(branchLeading R H a * branchProduct R H a) * branchRelativeSlope R H a) H := by
  have hp := finite_product_relative_derivative (Finset.range a)
    (fun j t => branchFactor R t j) (fun j => (R - 2) * branchReciprocalDifference R H j) H
    (fun j _ => branch_factor_relative_derivative R H j hR hf)
  rw [← Finset.mul_sum] at hp
  have hl := branch_leading_relative_derivative R H a hH hR ha
  have h := (hl.mul hp).const_sub R
  change HasDerivAt (fun t => branchValue R t a)
    (-(branchLeading R H a * (-((R + 1) * a) / (H * ((R - 1) * H + (R + 1) * a))) *
        branchProduct R H a + branchLeading R H a *
        (branchProduct R H a * ((R - 2) * ∑ j ∈ Finset.range a, branchReciprocalDifference R H j)))) H at h
  convert h using 1
  unfold branchRelativeSlope
  ring

theorem branch_relative_slope_neg (R H : ℝ) (a : ℕ) (hH : 0 < H) (hR : 1 ≤ R)
    (ha : 0 < a) (hf : 0 < (R - 2) * H + 2)
    (hlo : (R + 1) * (a : ℝ) ≤ H) (hhi : H ≤ (R + 1) * ((a : ℝ) + 1)) :
    branchRelativeSlope R H a < 0 := by
  let D := (R - 1) * H + (R + 1) * (a : ℝ)
  have ha' : 0 < (a : ℝ) := by exact_mod_cast ha
  have hR₀ : 0 ≤ R - 1 := sub_nonneg.mpr hR
  have hD : 0 < D := by unfold D; positivity
  have hden : 0 < H * D := mul_pos hH hD
  have hnum : 0 < (R + 1) * (a : ℝ) := by positivity
  change -((R + 1) * a) / (H * D) +
    (R - 2) * ∑ j ∈ Finset.range a, branchReciprocalDifference R H j < 0
  by_cases hR2 : R ≤ 2
  · have hS : 0 ≤ ∑ j ∈ Finset.range a, branchReciprocalDifference R H j :=
      Finset.sum_nonneg fun j _ => branch_reciprocal_difference_nonneg R H j hR hf
    exact add_neg_of_neg_of_nonpos (div_neg_of_neg_of_pos (neg_neg_of_pos hnum) hden)
      (mul_nonpos_of_nonpos_of_nonneg (sub_nonpos.mpr hR2) hS)
  have hR2' : 2 < R := lt_of_not_ge hR2
  let s := (R - 2) * H
  let c := R + 2
  let B := (s + c) * (s + 2) * (s + c * a + 2)
  have hs : 0 < s := mul_pos (sub_pos.mpr hR2') hH
  have hc : 0 < c := by unfold c; linarith
  have hB : 0 < B := by unfold B; positivity
  have hT := mul_le_mul_of_nonneg_left (reciprocal_telescope_bound R H a hR2' hH) (sub_nonneg.mpr hR2'.le)
  change (R - 2) * (∑ j ∈ Finset.range a, branchReciprocalDifference R H j) ≤
    (R - 2) * (R * (a : ℝ) * (s + c + 2) / B) at hT
  have hN := branch_numerator_positive R H (a : ℝ) hR2'.le (by exact_mod_cast ha) hlo hhi
  have hnumEq : (R + 1) * B - R * (s + c + 2) * s * D = branchNumerator R H (a : ℝ) := by
    unfold B D s c branchNumerator
    ring
  rw [← hnumEq] at hN
  have hstrict : (R - 2) * (R * (a : ℝ) * (s + c + 2) / B) < ((R + 1) * a) / (H * D) := by
    rw [← mul_div_assoc]
    apply (div_lt_div_iff₀ hB hden).mpr
    calc
      _ = (a : ℝ) * (R * (s + c + 2) * s * D) := by unfold s; ring
      _ < (a : ℝ) * ((R + 1) * B) := mul_lt_mul_of_pos_left (sub_pos.mp hN) ha'
      _ = _ := by ring
  rw [neg_div]
  linarith only [hT.trans_lt hstrict]

/-- Every nonconstant branch grows in dimension, including endpoint limits where
the first factor can vanish. -/
theorem branch_strict_mono (R l u : ℝ) (a : ℕ) (ha : 0 < a) (hR : 1 ≤ R)
    (hl : (R + 1) * (a : ℝ) ≤ l) (hu : u ≤ (R + 1) * ((a : ℝ) + 1))
    (hfl : 0 ≤ (R - 2) * l + 2) (hfu : 0 ≤ (R - 2) * u + 2) :
    StrictMonoOn (fun H => branchValue R H a) (Set.Icc l u) := by
  have ha' : 0 < (a : ℝ) := by exact_mod_cast ha
  have hL : 0 < l := (show 0 < (R + 1) * (a : ℝ) by positivity).trans_le hl
  have hfeas (H : ℝ) (hlt : l ≤ H) (hut : H ≤ u) : 0 ≤ (R - 2) * H + 2 := by
    rcases le_total 2 R with h | h
    · have hh := mul_le_mul_of_nonneg_left hlt (sub_nonneg.mpr h)
      linarith only [hh, hfl]
    · have hh := mul_le_mul_of_nonpos_left hut (sub_nonpos.mpr h)
      linarith only [hh, hfu]
  apply strictMonoOn_of_deriv_pos (convex_Icc l u)
  · intro H hH
    exact (branch_value_continuous_at R H a (hL.trans_le hH.1) hR (hfeas H hH.1 hH.2)).continuousWithinAt
  intro H hH
  rw [interior_Icc] at hH
  have hf : 0 < (R - 2) * H + 2 := by
    rcases le_total 2 R with h | h
    · have hHp := hL.trans hH.1
      have hm := mul_nonneg (sub_nonneg.mpr h) hHp.le
      linarith only [hm]
    rcases eq_or_lt_of_le h with he | hh
    · simp [he]
    have hinc := mul_lt_mul_of_neg_left hH.2 (sub_neg.mpr hh)
    linarith only [hinc, hfu]
  have hpos := hL.trans hH.1
  have hR₀ : 0 ≤ R - 1 := sub_nonneg.mpr hR
  have hlp : 0 < branchLeading R H a := by unfold branchLeading; positivity
  have hpp := branch_product_positive R H a hR hf
  have hsv := branch_relative_slope_neg R H a hpos hR ha hf
    (hl.trans hH.1.le) (hH.2.le.trans hu)
  rw [(branch_value_derivative R H a hpos hR ha hf).deriv]
  exact mul_pos_of_neg_of_neg (neg_neg_of_pos (mul_pos hlp hpp)) hsv

end FiniteFrontier
