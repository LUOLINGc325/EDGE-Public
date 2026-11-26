import LatticeCorrection
import Mathlib.Order.Interval.Finset.Nat

open Filter
open scoped BigOperators Topology

namespace TwoColorNullity.Occupancy

noncomputable def transitionMark (s : ℕ) : ℝ := (2 : ℝ) ^ s / criticalRatio

noncomputable def windowRatio (width : ℝ) : ℝ := Real.exp (-(Real.log 2 * width))

theorem windowRatio_bounds {width : ℝ} (hw : 0 ≤ width) :
    0 < windowRatio width ∧ windowRatio width ≤ 1 ∧ 1 - windowRatio width ≤ Real.log 2 * width := by
  unfold windowRatio
  refine ⟨Real.exp_pos _, ?_, ?_⟩
  · rw [← Real.exp_zero]
    exact Real.exp_le_exp.mpr (neg_nonpos.mpr (mul_nonneg log_two_pos.le hw))
  · have h := Real.add_one_le_exp (-(Real.log 2 * width))
    linarith only [h]

theorem transitionMark_pos (s : ℕ) : 0 < transitionMark s :=
  div_pos (by positivity) criticalRatio_pos

theorem thinCandidate_monotone_of_pos (n N : ℕ) (hn : 1 ≤ n) (hN : n ≤ N) :
    thinCandidate n ≤ thinCandidate N := by
  have hpos : 0 < criticalRatio * (n : ℝ) :=
    mul_pos criticalRatio_pos (by exact_mod_cast (show 0 < n by omega))
  have hmul : criticalRatio * (n : ℝ) ≤ criticalRatio * (N : ℝ) :=
    mul_le_mul_of_nonneg_left (by exact_mod_cast hN) criticalRatio_pos.le
  have h := div_le_div_of_nonneg_right (Real.log_le_log hpos hmul) log_two_pos.le
  have hfloor := Nat.floor_mono (show transitionLog n ≤ transitionLog N from h)
  unfold thinCandidate transitionFloor
  exact Nat.add_le_add_right hfloor _

theorem transitionMark_thin_le_twice (N : ℕ) (hN : 1 ≤ N) :
    transitionMark (thinCandidate N) ≤ 2 * (N : ℝ) := by
  unfold transitionMark thinCandidate
  rw [pow_succ]
  apply (div_le_iff₀ criticalRatio_pos).mpr
  have h := mul_le_mul_of_nonneg_right (transition_power_bounds N hN).1 (show (0 : ℝ) ≤ 2 by norm_num)
  nlinarith only [h]

theorem excluded_size_in_threshold_interval (n : ℕ) (hn : 1 ≤ n) (width : ℝ)
    (hw : boundaryWidth thresholdWindowConstant n ≤ width) (hexcluded : ¬ OutsideTransitionWindows n) :
    windowRatio width * transitionMark (thinCandidate n) ≤ (n : ℝ) ∧
      (n : ℝ) < transitionMark (thinCandidate n) := by
  let j := thinCandidate n
  let diff := (j : ℝ) - transitionLog n
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hgap : diff ≤ width := by
    unfold OutsideTransitionWindows fractionalTransition at hexcluded
    have h := le_of_not_gt hexcluded
    unfold diff j thinCandidate
    push_cast
    linarith only [h, hw]
  have hp : transitionMark j = (n : ℝ) * Real.exp (Real.log 2 * diff) := by
    have heq := bins_ratio_from_logGap n j hn
    change (2 : ℝ) ^ j / (n : ℝ) = criticalRatio * Real.exp (Real.log 2 * diff) at heq
    unfold transitionMark
    field_simp [criticalRatio_pos.ne']
    have h := (div_eq_iff hnR.ne').mp heq
    linear_combination h
  have hi : Real.exp (Real.log 2 * diff) ≤ Real.exp (Real.log 2 * width) :=
    Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left hgap log_two_pos.le)
  refine ⟨?_, ?_⟩
  · rw [hp, windowRatio]
    calc
      _ ≤ Real.exp (-(Real.log 2 * width)) * ((n : ℝ) * Real.exp (Real.log 2 * width)) :=
        mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left hi hnR.le) (Real.exp_pos _).le
      _ = _ := by
        have h : Real.exp (-(Real.log 2 * width)) * Real.exp (Real.log 2 * width) = 1 := by
          rw [← Real.exp_add, neg_add_cancel, Real.exp_zero]
        calc
          _ = (n : ℝ) * (Real.exp (-(Real.log 2 * width)) * Real.exp (Real.log 2 * width)) := by ring
          _ = _ := by rw [h, mul_one]
  · apply (lt_div_iff₀ criticalRatio_pos).mpr
    rw [mul_comm]
    exact (lt_two_nat_pow_iff_binaryLog j (mul_pos criticalRatio_pos hnR)).mpr (thinCandidate_above_transition n)

noncomputable def thresholdInterval (width : ℝ) (j : ℕ) : Finset ℕ :=
  Finset.Ico ⌈windowRatio width * transitionMark j⌉₊ ⌈transitionMark j⌉₊

theorem thresholdInterval_contains (width : ℝ) (j n : ℕ)
    (h : windowRatio width * transitionMark j ≤ (n : ℝ) ∧ (n : ℝ) < transitionMark j) :
    n ∈ thresholdInterval width j := by
  unfold thresholdInterval
  apply Finset.mem_Ico.mpr
  exact ⟨Nat.ceil_le.mpr h.1, lt_of_lt_of_le (Nat.lt_succ_self _) (Nat.add_one_le_ceil_iff.mpr h.2)⟩

theorem thresholdInterval_card_le (width : ℝ) (hw : 0 ≤ width) (j : ℕ) :
    ((thresholdInterval width j).card : ℝ) ≤ (1 - windowRatio width) * transitionMark j + 1 := by
  have hpos := (transitionMark_pos j).le
  have hmon : windowRatio width * transitionMark j ≤ transitionMark j :=
    by simpa only [one_mul] using mul_le_mul_of_nonneg_right (windowRatio_bounds hw).2.1 hpos
  unfold thresholdInterval
  rw [Nat.card_Ico, Nat.cast_sub (Nat.ceil_mono hmon)]
  have hu := Nat.ceil_lt_add_one hpos
  have hl := Nat.le_ceil (windowRatio width * transitionMark j)
  linarith only [hu, hl]

end TwoColorNullity.Occupancy
