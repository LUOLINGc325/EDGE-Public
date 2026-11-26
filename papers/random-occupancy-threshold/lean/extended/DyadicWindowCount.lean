import TransitionWindowDensity

open scoped BigOperators

namespace TwoColorNullity.Occupancy

private theorem transitionLog_mono (n N : ℕ) (hn : 1 ≤ n) (hle : n ≤ N) :
    transitionLog n ≤ transitionLog N := by
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hmul : criticalRatio * (n : ℝ) ≤ criticalRatio * (N : ℝ) :=
    mul_le_mul_of_nonneg_left (by exact_mod_cast hle) criticalRatio_pos.le
  exact div_le_div_of_nonneg_right (Real.log_le_log (mul_pos criticalRatio_pos hnR) hmul) log_two_pos.le

private theorem transitionLog_double (n : ℕ) (hn : 1 ≤ n) :
    transitionLog (2 * n) = transitionLog n + 1 := by
  have h : criticalRatio * ((2 * n : ℕ) : ℝ) = (criticalRatio * (n : ℝ)) * 2 := by push_cast; ring
  have hp : 0 < criticalRatio * (n : ℝ) :=
    mul_pos criticalRatio_pos (by exact_mod_cast (show 0 < n by omega))
  have htwo : binaryLog 2 = 1 := by simpa only [pow_one, Nat.cast_one] using binaryLog_pow_two 1
  unfold transitionLog
  rw [h, binaryLog_mul_of_pos hp (by norm_num), htwo]

noncomputable def excludedDyadicSizes (N : ℕ) : Finset ℕ := by
  classical
  exact (Finset.Ico N (2 * N)).filter (fun n => ¬ OutsideTransitionWindows n)

/-- At most two transition intervals contribute in a dyadic block. -/
theorem excludedDyadicSizes_card (N : ℕ) (hN : 1 ≤ N) :
    ((excludedDyadicSizes N).card : ℝ) ≤ 2 +
      8 * Real.log 2 * thresholdWindowConstant * Real.sqrt (N : ℝ) * Real.log (2 * (N : ℝ)) := by
  classical
  let j₀ := thinCandidate N
  let labels := Finset.Icc j₀ (j₀ + 1)
  let width := thresholdWindowConstant * (Real.log (2 * (N : ℝ)) / Real.sqrt (N : ℝ))
  let covered := labels.biUnion (thresholdInterval width)
  have hN' : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hlog : 0 ≤ Real.log (2 * (N : ℝ)) := Real.log_nonneg (by exact_mod_cast (show 1 ≤ 2 * N by omega))
  have hw : 0 ≤ width := mul_nonneg thresholdWindowConstant_pos.le (div_nonneg hlog (Real.sqrt_nonneg _))
  have hincl : excludedDyadicSizes N ⊆ covered := by
    intro n h
    have hm : (N ≤ n ∧ n < 2 * N) ∧ ¬ OutsideTransitionWindows n := by
      simpa [excludedDyadicSizes, Finset.mem_Ico] using h
    have hn : 1 ≤ n := hN.trans hm.1.1
    have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
    have hleft : j₀ ≤ thinCandidate n := thinCandidate_monotone_of_pos N n hN hm.1.1
    have hLo : transitionLog n ≤ transitionLog N + 1 := by
      have hi := transitionLog_mono n (2 * N) hn hm.1.2.le
      rwa [transitionLog_double N hN] at hi
    have hR :
        (transitionFloor n : ℝ) < (j₀ : ℝ) + 1 :=
      (transitionFloor_bounds n hn).1.trans_lt (hLo.trans_lt (add_lt_add_right (thinCandidate_above_transition N) 1))
    have hNat : transitionFloor n < j₀ + 1 := by exact_mod_cast hR
    have hright : thinCandidate n ≤ j₀ + 1 := by unfold thinCandidate; omega
    have hwidth : boundaryWidth thresholdWindowConstant n ≤ width := by
      unfold boundaryWidth width
      apply mul_le_mul_of_nonneg_left _ thresholdWindowConstant_pos.le
      exact div_le_div₀ hlog (Real.log_le_log hnR (by exact_mod_cast hm.1.2.le)) (Real.sqrt_pos.mpr hN')
        (Real.sqrt_le_sqrt (by exact_mod_cast hm.1.1))
    exact Finset.mem_biUnion.mpr ⟨thinCandidate n, Finset.mem_Icc.mpr ⟨hleft, hright⟩,
      thresholdInterval_contains width _ n (excluded_size_in_threshold_interval n hn width hwidth hm.2)⟩
  have hlabels : labels.card = 2 := by unfold labels; rw [Nat.card_Icc]; omega
  have hsource : transitionMark (j₀ + 1) ≤ 4 * (N : ℝ) := by
    have h := mul_le_mul_of_nonneg_left (transitionMark_thin_le_twice N hN) (show (0 : ℝ) ≤ 2 by norm_num)
    have heq : transitionMark (j₀ + 1) = 2 * transitionMark j₀ := by unfold transitionMark; rw [pow_succ]; ring
    rw [heq]
    exact h.trans_eq (by ring)
  have hcovered : ((covered.card : ℕ) : ℝ) ≤ ∑ j ∈ labels, ((thresholdInterval width j).card : ℝ) := by
    rw [← Nat.cast_sum]
    exact_mod_cast (Finset.card_biUnion_le : covered.card ≤ ∑ j ∈ labels, (thresholdInterval width j).card)
  have hsourceBound (j : ℕ) (hj : j ∈ labels) : transitionMark j ≤ 4 * (N : ℝ) := by
    have hpow := pow_le_pow_right₀ (by norm_num : (1 : ℝ) ≤ 2) (Finset.mem_Icc.mp hj).2
    exact (div_le_div_of_nonneg_right hpow criticalRatio_pos.le).trans hsource
  have hratio := windowRatio_bounds hw
  have hcount :
      (∑ j ∈ labels, ((thresholdInterval width j).card : ℝ)) ≤
        2 * ((1 - windowRatio width) * (4 * (N : ℝ)) + 1) := by
    calc
      _ ≤ ∑ _j ∈ labels, ((1 - windowRatio width) * (4 * (N : ℝ)) + 1) := by
        apply Finset.sum_le_sum
        intro j hj
        exact (thresholdInterval_card_le width hw j).trans
          (add_le_add_right (mul_le_mul_of_nonneg_left (hsourceBound j hj) (sub_nonneg.mpr hratio.2.1)) _)
      _ = _ := by
         rw [Finset.sum_const, hlabels]
         simp only [two_nsmul, two_mul]
  have hsize : ((excludedDyadicSizes N).card : ℝ) ≤ (covered.card : ℝ) := by exact_mod_cast Finset.card_le_card hincl
  refine (hsize.trans (hcovered.trans hcount)).trans ?_
  have hmul := mul_le_mul_of_nonneg_right hratio.2.2 (show 0 ≤ 8 * (N : ℝ) by positivity)
  have hroot : (N : ℝ) / Real.sqrt (N : ℝ) = Real.sqrt (N : ℝ) := by
    apply (div_eq_iff (Real.sqrt_pos.mpr hN').ne').mpr
    simpa only [pow_two] using (Real.sq_sqrt hN'.le).symm
  have hrewrite : Real.log 2 * width * (8 * (N : ℝ)) =
      8 * Real.log 2 * thresholdWindowConstant * Real.sqrt (N : ℝ) * Real.log (2 * (N : ℝ)) := by
    unfold width
    calc
      _ = 8 * Real.log 2 * thresholdWindowConstant * ((N : ℝ) / Real.sqrt (N : ℝ)) * Real.log (2 * (N : ℝ)) := by ring
      _ = _ := by rw [hroot]
  rw [hrewrite] at hmul
  nlinarith only [hmul]

end TwoColorNullity.Occupancy
