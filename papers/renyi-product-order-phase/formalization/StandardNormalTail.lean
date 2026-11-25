import FiniteCentralLimit

/-! The true standard normal tail and its first derivative. -/

open Set MeasureTheory

namespace RenyiProductOrderPhase

noncomputable def standardNormalTail (x : ℝ) : ℝ :=
  ∫ s in Ioi x, gaussianProfile 1 1 s

theorem standard_normal_density_positive (x : ℝ) : 0 < gaussianProfile 1 1 x := by
  rw [gaussian_unit_profile_formula zero_lt_one]
  exact mul_pos (inv_pos.mpr (Real.sqrt_pos.2 (by positivity))) (Real.exp_pos _)

theorem standard_normal_density_continuous : Continuous (gaussianProfile 1 1) := by
  have hf : gaussianProfile 1 1 = fun x =>
      (Real.sqrt (2 * Real.pi * 1))⁻¹ * Real.exp (-(1 / (2 * 1)) * x ^ 2) := by
    funext x
    rw [gaussian_unit_profile_formula zero_lt_one]
  rw [hf]
  fun_prop

theorem standard_normal_tail_complement (x : ℝ) : gaussianCDF 1 x + standardNormalTail x = 1 := by
  have h := integral_add_compl (μ := volume) (s := Iic x) measurableSet_Iic
    (gaussian_unit_profile_integrable (by norm_num : (0 : ℝ) < 1))
  rw [compl_Iic, gaussian_unit_profile_mass zero_lt_one] at h
  exact h

theorem standard_normal_probability_positive (x : ℝ) :
    0 < gaussianCDF 1 x ∧ 0 < standardNormalTail x := by
  let f := gaussianProfile 1 1
  have hSupport : Function.support f = univ := by
    ext s
    simp only [Function.mem_support, mem_univ, iff_true]
    exact (standard_normal_density_positive s).ne'
  have hI := gaussian_unit_profile_integrable (by norm_num : (0 : ℝ) < 1)
  have hAux {s : Set ℝ} (hs : 0 < volume s) : 0 < ∫ x in s, f x := by
    rw [setIntegral_pos_iff_support_of_nonneg_ae
      (Filter.Eventually.of_forall (fun x => (standard_normal_density_positive x).le)) hI.integrableOn,
      hSupport, univ_inter]
    exact hs
  exact ⟨hAux (by rw [Real.volume_Iic]; exact ENNReal.zero_lt_top),
    hAux (by rw [Real.volume_Ioi]; exact ENNReal.zero_lt_top)⟩

theorem standard_normal_tail_bounds (x : ℝ) :
    0 < standardNormalTail x ∧ standardNormalTail x < 1 := by
  have h := standard_normal_probability_positive x
  exact ⟨h.2, by linarith only [h.1, standard_normal_tail_complement x]⟩

theorem standard_normal_tail_derivative (x : ℝ) :
    HasDerivAt standardNormalTail (-gaussianProfile 1 1 x) x := by
  let f := gaussianProfile 1 1
  have hf := gaussian_unit_profile_integrable (by norm_num : (0 : ℝ) < 1)
  have hC : Continuous f := standard_normal_density_continuous
  have hI : HasDerivAt (fun y => ∫ s in x..y, f s) (f x) x :=
    intervalIntegral.integral_hasDerivAt_right
      (hC.intervalIntegrable x x) hC.stronglyMeasurable.stronglyMeasurableAtFilter hC.continuousAt
  have hEq : standardNormalTail = fun y => standardNormalTail x - ∫ s in x..y, f s := by
    funext y
    have h := intervalIntegral.integral_Iic_sub_Iic (a := x) (b := y)
      (μ := volume) (f := f) hf.integrableOn hf.integrableOn
    change gaussianCDF 1 y - gaussianCDF 1 x = _ at h
    rw [← h]
    linarith only [standard_normal_tail_complement x, standard_normal_tail_complement y]
  rw [hEq]
  simpa only [zero_sub] using (hasDerivAt_const x (standardNormalTail x)).sub hI

end RenyiProductOrderPhase
