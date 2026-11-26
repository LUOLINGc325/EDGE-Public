import OccupancyParity
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Topology.Order.IntermediateValue

namespace TwoColorNullity.Occupancy

noncomputable def occupancyCurve (u : ℝ) : ℝ :=
  u * (1 - Real.exp (-(6 : ℝ) / u)) / 2

noncomputable def occupancyCurveDerivative (u : ℝ) : ℝ :=
  (1 - (1 + 6 / u) * Real.exp (-(6 : ℝ) / u)) / 2

theorem occupancyCurve_hasDerivAt (u : ℝ) (hu : u ≠ 0) :
    HasDerivAt occupancyCurve (occupancyCurveDerivative u) u := by
  have hquot : HasDerivAt (fun v : ℝ => -(6 : ℝ) / v) (6 / u ^ 2) u := by
    convert (hasDerivAt_const u (-(6 : ℝ))).div (hasDerivAt_id u) hu using 1
    simp
  have hprod := ((hasDerivAt_id u).mul ((hasDerivAt_const u (1 : ℝ)).sub hquot.exp)).div_const 2
  convert hprod using 1
  simp only [occupancyCurveDerivative, id_eq, Pi.sub_apply, one_mul, zero_sub]
  field_simp [hu]
  ring

theorem occupancyCurveDerivative_pos (u : ℝ) (hu : 0 < u) :
    0 < occupancyCurveDerivative u := by
  have hq : 0 < (6 : ℝ) / u := div_pos (by norm_num) hu
  have hExp := Real.add_one_lt_exp hq.ne'
  have hcore : (1 + 6 / u) * Real.exp (-(6 : ℝ) / u) < 1 := by
    rw [neg_div, Real.exp_neg, ← div_eq_mul_inv]
    apply (div_lt_iff₀ (Real.exp_pos _)).mpr
    simpa only [one_mul, add_comm] using hExp
  unfold occupancyCurveDerivative
  exact div_pos (sub_pos.mpr hcore) (by norm_num)

theorem occupancyCurve_pos (u : ℝ) (hu : 0 < u) : 0 < occupancyCurve u := by
  have hexp : Real.exp (-(6 : ℝ) / u) < 1 := by
    rw [← Real.exp_zero]
    exact Real.exp_lt_exp.mpr (div_neg_of_neg_of_pos (by norm_num) hu)
  exact div_pos (mul_pos hu (sub_pos.mpr hexp)) (by norm_num)

theorem occupancyCurve_strictMono : StrictMonoOn occupancyCurve (Set.Ioi 0) := by
  apply strictMonoOn_of_deriv_pos (convex_Ioi 0)
  · intro u hu
    exact (occupancyCurve_hasDerivAt u (ne_of_gt hu)).continuousAt.continuousWithinAt
  · intro u hu
    rw [interior_Ioi] at hu
    rw [(occupancyCurve_hasDerivAt u (ne_of_gt hu)).deriv]
    exact occupancyCurveDerivative_pos u hu

theorem occupancyCurve_two_lt_one : occupancyCurve 2 < 1 := by
  unfold occupancyCurve
  have hp := Real.exp_pos (-(6 : ℝ) / 2)
  linarith

theorem one_lt_occupancyCurve_three : 1 < occupancyCurve 3 := by
  have he : (3 : ℝ) < Real.exp 2 := by
    have h := Real.add_one_lt_exp (show (2 : ℝ) ≠ 0 by norm_num)
    norm_num at h
    exact h
  have hsmall : Real.exp (-(2 : ℝ)) < 1 / 3 := by
    rw [Real.exp_neg, ← one_div]
    exact (div_lt_div_iff₀ (Real.exp_pos _) (by norm_num)).mpr (by simpa only [one_mul] using he)
  unfold occupancyCurve
  rw [show -(6 : ℝ) / 3 = -2 by norm_num]
  linarith

theorem occupancyCurve_root_interval :
    ∃ u ∈ Set.Ioo (2 : ℝ) 3, occupancyCurve u = 1 := by
  have hc : ContinuousOn occupancyCurve (Set.Icc (2 : ℝ) 3) := fun u hu =>
    (occupancyCurve_hasDerivAt u (by linarith [hu.1])).continuousAt.continuousWithinAt
  have hmem : (1 : ℝ) ∈ Set.Icc (occupancyCurve 2) (occupancyCurve 3) :=
    ⟨occupancyCurve_two_lt_one.le, one_lt_occupancyCurve_three.le⟩
  obtain ⟨u, hu, hroot⟩ := intermediate_value_Icc (by norm_num : (2 : ℝ) ≤ 3) hc hmem
  have hne2 : u ≠ 2 := fun h => by rw [h] at hroot; exact occupancyCurve_two_lt_one.ne hroot
  have hne3 : u ≠ 3 := fun h => by rw [h] at hroot; exact one_lt_occupancyCurve_three.ne hroot.symm
  exact ⟨u, ⟨lt_of_le_of_ne hu.1 hne2.symm, lt_of_le_of_ne hu.2 hne3⟩, hroot⟩

noncomputable def criticalRatio : ℝ := Classical.choose occupancyCurve_root_interval

theorem criticalRatio_mem_Ioo : criticalRatio ∈ Set.Ioo (2 : ℝ) 3 :=
  (Classical.choose_spec occupancyCurve_root_interval).1

theorem occupancyCurve_criticalRatio : occupancyCurve criticalRatio = 1 :=
  (Classical.choose_spec occupancyCurve_root_interval).2

theorem criticalRatio_unique (u : ℝ) (hu : 0 < u) (hroot : occupancyCurve u = 1) :
    u = criticalRatio := by
  have hp : 0 < criticalRatio := by linarith [criticalRatio_mem_Ioo.1]
  exact occupancyCurve_strictMono.injOn hu hp (hroot.trans occupancyCurve_criticalRatio.symm)

end TwoColorNullity.Occupancy
