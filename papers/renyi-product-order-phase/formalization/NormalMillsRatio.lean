import StandardNormalTail

/-! Strict monotonicity of the Gaussian Mills ratio on the entire real line. -/

open Set MeasureTheory

namespace RenyiProductOrderPhase

noncomputable def millsIntegrand (x s : ℝ) : ℝ :=
  Real.exp (-x * s - s ^ 2 / 2)

noncomputable def normalMillsRatio (x : ℝ) : ℝ := standardNormalTail x / gaussianProfile 1 1 x

theorem normal_tail_reflection (x : ℝ) : standardNormalTail x = gaussianCDF 1 (-x) := by
  unfold standardNormalTail gaussianCDF
  rw [← integral_comp_neg_Ioi]
  simp only [gaussian_profile_even]

theorem normal_density_shift (x s : ℝ) :
    gaussianProfile 1 1 (s + x) = gaussianProfile 1 1 x * millsIntegrand x s := by
  rw [gaussian_unit_profile_formula (v := 1) zero_lt_one,
    gaussian_unit_profile_formula (v := 1) zero_lt_one]
  unfold millsIntegrand
  have h : -(1 / (2 * (1 : ℝ))) * (s + x) ^ 2 =
      -(1 / (2 * (1 : ℝ))) * x ^ 2 + (-x * s - s ^ 2 / 2) := by ring
  rw [h, Real.exp_add]
  ring

theorem normal_tail_translate (x : ℝ) :
    standardNormalTail x = ∫ s in Ioi (0 : ℝ), gaussianProfile 1 1 (s + x) := by
  let f := (Ioi x).indicator (gaussianProfile 1 1)
  have h (s : ℝ) : (Ioi (0 : ℝ)).indicator (fun v => gaussianProfile 1 1 (v + x)) s = f (s + x) := by
    by_cases hs : 0 < s
    · unfold f
      rw [indicator_of_mem (show s ∈ Ioi (0 : ℝ) from hs),
        indicator_of_mem (show s + x ∈ Ioi x from lt_add_of_pos_left _ hs)]
    · unfold f
      rw [indicator_of_not_mem (show s ∉ Ioi (0 : ℝ) from hs),
        indicator_of_not_mem (show s + x ∉ Ioi x from fun h => hs (by linarith only [mem_Ioi.mp h]))]
  unfold standardNormalTail
  rw [← integral_indicator measurableSet_Ioi, ← integral_indicator measurableSet_Ioi]
  simp only [h, integral_add_right_eq_self, f]

theorem normal_mills_integral (x : ℝ) :
    IntegrableOn (millsIntegrand x) (Ioi 0) ∧
      normalMillsRatio x = ∫ s in Ioi (0 : ℝ), millsIntegrand x s := by
  have hPos := standard_normal_density_positive x
  have hg := gaussian_unit_profile_integrable (by norm_num : (0 : ℝ) < 1)
  have h := ((measurePreserving_add_right volume x).integrable_comp hg.aestronglyMeasurable).2 hg
  have hShift : Integrable (fun s : ℝ => gaussianProfile 1 1 (s + x)) := h
  have hInt : Integrable (millsIntegrand x) := by
    have hEq (s : ℝ) : (gaussianProfile 1 1 x)⁻¹ * gaussianProfile 1 1 (s + x) =
        millsIntegrand x s := by
      rw [normal_density_shift, ← mul_assoc, inv_mul_cancel₀ hPos.ne', one_mul]
    simpa only [hEq] using hShift.const_mul (gaussianProfile 1 1 x)⁻¹
  refine ⟨hInt.integrableOn, ?_⟩
  unfold normalMillsRatio
  rw [normal_tail_translate, show (fun s => gaussianProfile 1 1 (s + x)) =
    (fun s => gaussianProfile 1 1 x * millsIntegrand x s) from funext (normal_density_shift x),
    integral_const_mul]
  exact mul_div_cancel_left₀ _ hPos.ne'

theorem normal_mills_positive (x : ℝ) : 0 < normalMillsRatio x :=
  div_pos (standard_normal_tail_bounds x).1 (standard_normal_density_positive x)

theorem normal_mills_strict_antitone : StrictAnti normalMillsRatio := by
  intro x y hxy
  let f := millsIntegrand x
  let g := millsIntegrand y
  let B := Icc (1 : ℝ) 2
  let c := Real.exp (-2 * |x| - 2) * (1 - Real.exp (-(y - x)))
  have hC : 0 < c := mul_pos (Real.exp_pos _) (sub_pos.mpr (by
    simpa only [Real.exp_zero] using Real.exp_lt_exp.mpr (neg_lt_zero.mpr (sub_pos.mpr hxy))))
  have hf := (normal_mills_integral x).1
  have hg := (normal_mills_integral y).1
  have hPos (s : ℝ) (hs : 0 < s) : 0 ≤ f s - g s := by
    unfold f g millsIntegrand
    apply sub_nonneg.mpr
    apply Real.exp_le_exp.2
    nlinarith only [mul_le_mul_of_nonneg_right hxy.le hs.le]
  have hPoint (s : ℝ) (hs : s ∈ B) : c ≤ f s - g s := by
    have hs₀ : 0 ≤ s := zero_le_one.trans hs.1
    have hValue : f s - g s = f s * (1 - Real.exp (-(y - x) * s)) := by
      unfold f g millsIntegrand
      rw [mul_sub, mul_one, ← Real.exp_add]
      congr 2
      ring
    rw [hValue]
    have hF : Real.exp (-2 * |x| - 2) ≤ f s := by
      unfold f millsIntegrand
      apply Real.exp_le_exp.2
      have hX : x * s ≤ |x| * 2 :=
        mul_le_mul (le_abs_self x) hs.2 hs₀ (abs_nonneg x)
      have hS : s ^ 2 ≤ 2 ^ 2 := pow_le_pow_left₀ hs₀ hs.2 2
      nlinarith only [hX, hS]
    have hG : 1 - Real.exp (-(y - x)) ≤ 1 - Real.exp (-(y - x) * s) := by
      apply sub_le_sub_left _ 1
      apply Real.exp_le_exp.2
      have h := mul_le_mul_of_nonneg_left hs.1 (sub_pos.mpr hxy).le
      nlinarith only [h]
    unfold c
    exact mul_le_mul hF hG (by
      simpa only [Real.exp_zero] using
        sub_nonneg.mpr (Real.exp_le_exp.mpr (neg_nonpos.mpr (sub_pos.mpr hxy).le)))
      (Real.exp_nonneg _)
  have hSubset : B ⊆ Ioi (0 : ℝ) := fun _ hs => zero_lt_one.trans_le hs.1
  have hDiff : IntegrableOn (fun s => f s - g s) (Ioi (0 : ℝ)) := hf.sub hg
  have hBi : IntegrableOn (fun s => f s - g s) B := hDiff.mono_set hSubset
  have hBc : IntegrableOn (fun _ : ℝ => c) B := by
    apply integrableOn_const.2
    right
    rw [show volume B = ENNReal.ofReal (2 - 1) from Real.volume_Icc]
    exact ENNReal.ofReal_lt_top
  have hJ : c ≤ ∫ s in B, f s - g s := by
    have h := setIntegral_mono_on hBc hBi measurableSet_Icc hPoint
    rw [setIntegral_const] at h
    change (volume B).toReal * c ≤ _ at h
    rwa [show volume B = ENNReal.ofReal (2 - 1) from Real.volume_Icc,
      ENNReal.toReal_ofReal (by norm_num), show (2 : ℝ) - 1 = 1 by norm_num, one_mul] at h
  have hI := setIntegral_mono_set (hf.sub hg)
    ((ae_restrict_mem measurableSet_Ioi).mono (fun s hs => hPos s (mem_Ioi.mp hs)))
    (Filter.Eventually.of_forall hSubset)
  have hDis : 0 < (∫ s in Ioi (0 : ℝ), f s) - ∫ s in Ioi (0 : ℝ), g s := by
    rw [← integral_sub hf hg]
    exact hC.trans_le (hJ.trans hI)
  rw [(normal_mills_integral x).2, (normal_mills_integral y).2]
  exact sub_pos.mp hDis

end RenyiProductOrderPhase
