import LatticeScale
import OccupancyVarianceLower

namespace TwoColorNullity.Occupancy

theorem binaryLog_mul_of_pos {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    binaryLog (x * y) = binaryLog x + binaryLog y := by
  unfold binaryLog
  rw [Real.log_mul hx.ne' hy.ne', add_div]

theorem binaryLog_pow_two (s : ℕ) : binaryLog ((2 : ℝ) ^ s) = s := by
  unfold binaryLog
  rw [Real.log_pow, mul_div_assoc, div_self log_two_pos.ne', mul_one]

noncomputable def criticalSlope : ℝ := varianceCurve (3 / 128) / 2

theorem criticalSlope_pos : 0 < criticalSlope := by
  unfold criticalSlope
  exact div_pos (varianceCurve_pos (by norm_num)) (by norm_num)

theorem criticalSlope_le_derivative (u : ℝ) (hu : 0 < u) (hmax : u ≤ 64) :
    criticalSlope ≤ occupancyCurveDerivative u := by
  have harg : (3 : ℝ) / 128 ≤ (3 / 2) / u := by
    apply (le_div_iff₀ hu).mpr
    linarith
  have hcmp := varianceCurve_monotone (by norm_num : (0 : ℝ) < 3 / 128) (by positivity : 0 < (3 / 2 : ℝ) / u) harg
  have heq : varianceCurve ((3 / 2) / u) / 2 = occupancyCurveDerivative u := by
    unfold varianceCurve occupancyCurveDerivative
    have h : (4 : ℝ) * ((3 / 2) / u) = 6 / u := by ring
    rw [h, neg_div]
  exact (div_le_div_of_nonneg_right hcmp (by norm_num : (0 : ℝ) ≤ 2)).trans_eq heq

theorem occupancyCurve_gap_lower (u : ℝ) (hlo : criticalRatio ≤ u) (hhi : u ≤ 64) :
    1 + criticalSlope * (u - criticalRatio) ≤ occupancyCurve u := by
  let f (x : ℝ) := occupancyCurve x - criticalSlope * x
  have hderiv (x : ℝ) (hx : 0 < x) :
      HasDerivAt f (occupancyCurveDerivative x - criticalSlope) x := by
    simpa only [f, id_eq, mul_one] using
      (occupancyCurve_hasDerivAt x hx.ne').sub ((hasDerivAt_id x).const_mul criticalSlope)
  have hmono : MonotoneOn f (Set.Icc criticalRatio 64) := by
    apply monotoneOn_of_deriv_nonneg (convex_Icc _ _)
    · intro x hx
      exact (hderiv x (criticalRatio_pos.trans_le hx.1)).continuousAt.continuousWithinAt
    · intro x hx
      have hx' : x ∈ Set.Icc criticalRatio 64 := interior_subset hx
      exact (hderiv x (criticalRatio_pos.trans_le hx'.1)).differentiableAt.differentiableWithinAt
    · intro x hx
      have hx' : x ∈ Set.Icc criticalRatio 64 := interior_subset hx
      have hpos := criticalRatio_pos.trans_le hx'.1
      rw [(hderiv x hpos).deriv]
      exact sub_nonneg.mpr (criticalSlope_le_derivative x hpos hx'.2)
  have hc : criticalRatio ≤ 64 := hlo.trans hhi
  have h := hmono (show criticalRatio ∈ Set.Icc criticalRatio 64 from ⟨le_rfl, hc⟩)
    (show u ∈ Set.Icc criticalRatio 64 from ⟨hlo, hhi⟩) hlo
  unfold f at h
  rw [occupancyCurve_criticalRatio] at h
  nlinarith only [h]

theorem occupancyCurve_gap_upper (u : ℝ) (hlo : criticalRatio ≤ u) :
    occupancyCurve u ≤ 1 + (u - criticalRatio) / 2 := by
  let f (x : ℝ) := x / 2 - occupancyCurve x
  have hderiv (x : ℝ) (hx : 0 < x) :
      HasDerivAt f (1 / 2 - occupancyCurveDerivative x) x := by
    simpa only [f, id_eq] using
      ((hasDerivAt_id x).div_const (2 : ℝ)).sub (occupancyCurve_hasDerivAt x hx.ne')
  have hmono : MonotoneOn f (Set.Icc criticalRatio u) := by
    apply monotoneOn_of_deriv_nonneg (convex_Icc _ _)
    · intro x hx
      exact (hderiv x (criticalRatio_pos.trans_le hx.1)).continuousAt.continuousWithinAt
    · intro x hx
      have hx' : x ∈ Set.Icc criticalRatio u := interior_subset hx
      exact (hderiv x (criticalRatio_pos.trans_le hx'.1)).differentiableAt.differentiableWithinAt
    · intro x hx
      have hx' : x ∈ Set.Icc criticalRatio u := interior_subset hx
      have hx0 := criticalRatio_pos.trans_le hx'.1
      rw [(hderiv x hx0).deriv]
      unfold occupancyCurveDerivative
      have h : 0 ≤ (1 + 6 / x) * Real.exp (-(6 : ℝ) / x) := by positivity
      linarith
  have h := hmono (show criticalRatio ∈ Set.Icc criticalRatio u from ⟨le_rfl, hlo⟩)
    (show u ∈ Set.Icc criticalRatio u from ⟨hlo, le_rfl⟩) hlo
  unfold f at h
  rw [occupancyCurve_criticalRatio] at h
  linarith only [h]

theorem bins_ratio_from_logGap (n s : ℕ) (hn : 1 ≤ n) :
    (2 : ℝ) ^ s / (n : ℝ) =
      criticalRatio * Real.exp (Real.log 2 * ((s : ℝ) - transitionLog n)) := by
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hx := mul_pos criticalRatio_pos hnR
  have harg : Real.log 2 * ((s : ℝ) - transitionLog n) =
      (s : ℝ) * Real.log 2 - Real.log (criticalRatio * (n : ℝ)) := by
    unfold transitionLog binaryLog
    field_simp [log_two_pos.ne']
  rw [harg, Real.exp_sub, Real.exp_nat_mul, Real.exp_log (by norm_num : (0 : ℝ) < 2), Real.exp_log hx]
  field_simp [criticalRatio_pos.ne', hnR.ne']

theorem bins_ratio_le_sixty_four_of_before_cutoff (n s : ℕ) (hn : 1 ≤ n) (hs : s < largeSetThreshold n) :
    (2 : ℝ) ^ s / (n : ℝ) ≤ 64 := by
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hcast : (s : ℝ) + 1 ≤ (largeSetThreshold n : ℝ) := by
    exact_mod_cast (show s + 1 ≤ largeSetThreshold n by omega)
  have hlog : (s : ℝ) ≤ binaryLog (64 * (n : ℝ)) := by
    rw [binaryLog_mul_of_pos (by norm_num) hnR, show (64 : ℝ) = 2 ^ (6 : ℕ) by norm_num, binaryLog_pow_two]
    norm_num
    linarith only [threshold_le_binaryLog_add n (by omega), hcast]
  apply (div_le_iff₀ hnR).mpr
  exact (two_nat_pow_le_iff_binaryLog s (by positivity)).mpr hlog

end TwoColorNullity.Occupancy
