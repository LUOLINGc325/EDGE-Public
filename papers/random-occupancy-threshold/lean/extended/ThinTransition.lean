import ThinTransitionScale
import SharpRandomThreshold

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

private theorem thin_lower_eventually_bounded :
    ∀ᶠ n : ℕ in atTop,
      finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
        InThinWindow n ∧ maximumFeasibleOwners (profileTag bits) < thinCandidate n) ≤
        (1 - thresholdDescentMass) ^ (n / thinCandidate n) := by
  have hcast : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop := tendsto_natCast_atTop_atTop
  filter_upwards [eventually_ge_atTop (8 : ℕ), thinCandidate_eventually_small (show (0 : ℝ) < 1 / 2 by norm_num),
    tendsto_atTop.1 hcast (32 * (3 / (1 : ℝ)) / varianceCurve (2 / 3)),
    tendsto_atTop.1 sqrt_nat_atTop (Real.log 2 * thinConstant),
    tendsto_atTop.1 sqrt_nat_atTop (thresholdDescent / (3 - criticalRatio)),
    eventually_descent_large 28] with n hn hsiz hbig hrootArg hrootCrit hrootDescent
  by_cases hw : InThinWindow n
  · let s := thinCandidate n
    let k := 2 ^ s
    have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
    have hroot := Real.sqrt_pos.mpr hnR
    have hk := thinCandidate_ratio_bound n (by omega) hw hrootArg
    have hklo : (n : ℝ) ≤ (k : ℝ) := by
      have h : (1 : ℝ) ≤ (2 : ℝ) ^ s / (n : ℝ) := by linarith only [hk.1, criticalRatio_mem_Ioo.1]
      have h' := (le_div_iff₀ hnR).mp h
      simpa only [one_mul, k, Nat.cast_pow, Nat.cast_ofNat] using h'
    have hkhi : (k : ℝ) ≤ 3 * (n : ℝ) := by
      have hp : 0 < 3 - criticalRatio := sub_pos.mpr criticalRatio_mem_Ioo.2
      have hsmall : thresholdDescent / Real.sqrt (n : ℝ) ≤ 3 - criticalRatio :=
        (div_le_iff₀ hroot).mpr (by simpa only [mul_comm] using (div_le_iff₀ hp).mp hrootCrit)
      have h : (2 : ℝ) ^ s / (n : ℝ) ≤ 3 := by linarith only [hsmall, hk.2]
      simpa only [k, Nat.cast_pow, Nat.cast_ofNat] using (div_le_iff₀ hnR).mp h
    have hk8 : 8 ≤ k := hn.trans (by exact_mod_cast hklo)
    have htail := oddBinCount_small_deviation n k (by omega) hk8 1 3 (by norm_num) (by norm_num)
      (by simpa only [one_mul] using hklo) hkhi (hbig.trans hklo)
    have hpositive : 0 < (k : ℝ) := hnR.trans_le hklo
    have hratioLow : criticalRatio ≤ (k : ℝ) / (n : ℝ) := by simpa only [k, Nat.cast_pow, Nat.cast_ofNat] using hk.1
    have hratioHi : (k : ℝ) / (n : ℝ) ≤ criticalRatio + thresholdDescent / Real.sqrt (n : ℝ) := by
      simpa only [k, Nat.cast_pow, Nat.cast_ofNat] using hk.2
    have hchi := occupancyCurve_gap_upper _ hratioLow
    have hχlim : occupancyCurve ((k : ℝ) / (n : ℝ)) ≤ 1 + thresholdDescent / Real.sqrt (n : ℝ) / 2 := by
      linarith only [hchi, hratioHi]
    have hmeanLarge := (abs_le.mp (expectedOddCount_approximation n k (by omega) (by omega))).2
    have hm : ((3 * n - 1 : ℕ) : ℝ) ≤ 3 * (k : ℝ) := by
      have h := (show ((3 * n - 1 : ℕ) : ℝ) ≤ 3 * (n : ℝ) by exact_mod_cast Nat.sub_le (3 * n) 1)
      linarith only [h, hklo]
    have herror : 4 * ((3 * n - 1 : ℕ) : ℝ) / (k : ℝ) + 1 ≤ 13 := by
      have h : 4 * ((3 * n - 1 : ℕ) : ℝ) / (k : ℝ) ≤ 12 := (div_le_iff₀ hpositive).mpr (by linarith only [hm])
      linarith
    have hscaled := mul_le_mul_of_nonneg_left hχlim hnR.le
    have hscale :
        (n : ℝ) * (1 + thresholdDescent / Real.sqrt (n : ℝ) / 2) =
          (n : ℝ) + thresholdDescent * Real.sqrt (n : ℝ) / 2 := by
      have h : (n : ℝ) / Real.sqrt (n : ℝ) = Real.sqrt (n : ℝ) :=
        (div_eq_iff hroot.ne').mpr (by simpa only [pow_two] using (Real.sq_sqrt hnR.le).symm)
      calc
        _ = (n : ℝ) + thresholdDescent * ((n : ℝ) / Real.sqrt (n : ℝ)) / 2 := by ring
        _ = _ := by rw [h]
    rw [hscale] at hscaled
    have hs0 : 0 < s := by unfold s thinCandidate; omega
    have hslt : s < n := by
      have hn8 : (8 : ℝ) ≤ n := by exact_mod_cast hn
      exact_mod_cast (show (s : ℝ) < (n : ℝ) by change (s : ℝ) ≤ 1 / 2 * (n : ℝ) at hsiz; linarith)
    have hprob : thresholdDescentMass ≤ finiteProbability (fun draws : Fin (3 * n - 1) → Fin k =>
        oddBinCount draws ≤ n + 2 * s - 1) := by
      refine (min_le_right (1 / 2) _).trans (htail.trans (finiteProbability_mono ?_))
      intro draws hd
      change (oddBinCount draws : ℝ) ≤
        finiteMean (fun d : Fin (3 * n - 1) → Fin k => (oddBinCount d : ℝ)) -
          thresholdDescent * Real.sqrt (n : ℝ) at hd
      have hnat : oddBinCount draws ≤ n := by exact_mod_cast (show (oddBinCount draws : ℝ) ≤ (n : ℝ) by
        linarith only [hd, hmeanLarge, herror, hscaled, hrootDescent])
      exact hnat.trans (by omega)
    have hbound := probability_sStar_below_from_independent_blocks n s hs0 hslt thresholdDescentMass hprob
    exact (finiteProbability_mono fun _ h => h.2).trans hbound
  · have hzero : (fun bits : BitProfile n (3 * n - 1) =>
        InThinWindow n ∧ maximumFeasibleOwners (profileTag bits) < thinCandidate n) = fun _ => False := by
      funext bits
      apply propext
      exact ⟨fun h => hw h.1, False.elim⟩
    rw [hzero]
    have hP : finiteProbability (fun _ : BitProfile n (3 * n - 1) => False) = 0 := by unfold finiteProbability; simp
    rw [hP]
    exact pow_nonneg (by linarith [thresholdDescentMass_bounds.2]) _

private theorem thin_lower_probability_zero :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      InThinWindow n ∧ maximumFeasibleOwners (profileTag bits) < thinCandidate n)) atTop (𝓝 0) := by
  have hp := thresholdDescentMass_bounds
  have h := (tendsto_pow_atTop_nhds_zero_of_lt_one (show 0 ≤ 1 - thresholdDescentMass by linarith [hp.2])
    (show 1 - thresholdDescentMass < 1 by linarith [hp.1])).comp thin_group_count_atTop
  exact squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity)
    thin_lower_eventually_bounded h

theorem windowUpper_eventually_le_thinCandidate :
    ∀ᶠ n : ℕ in atTop, windowUpper n ≤ thinCandidate n := by
  filter_upwards [eventually_ge_atTop (1 : ℕ), (boundaryWidth_zero thresholdWindowConstant).eventually
    (gt_mem_nhds (show (0 : ℝ) < 1 by norm_num))] with n hn hw
  have hlog := transitionLog_nonnegative n hn
  have hnR : (0 : ℝ) ≤ Real.log (n : ℝ) := Real.log_nonneg (by exact_mod_cast hn)
  have hwidth : 0 ≤ boundaryWidth thresholdWindowConstant n := by
    unfold boundaryWidth
    exact mul_nonneg thresholdWindowConstant_pos.le (div_nonneg hnR (Real.sqrt_nonneg _))
  have hfl : (windowUpper n : ℝ) ≤ transitionLog n + boundaryWidth thresholdWindowConstant n :=
    Nat.floor_le (add_nonneg hlog hwidth)
  have h : (windowUpper n : ℝ) < (thinCandidate n : ℝ) + 1 := by
    linarith only [hfl, hw, thinCandidate_above_transition n]
  have hh : windowUpper n < thinCandidate n + 1 := by exact_mod_cast h
  omega

/-- A population just below the integer transition attains the upper integer with high probability. -/
theorem thin_transition_attained :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      InThinWindow n ∧ maximumFeasibleOwners (profileTag bits) ≠ thinCandidate n)) atTop (𝓝 0) := by
  have h := thin_lower_probability_zero.add upper_window_fails_probability_zero
  rw [zero_add] at h
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity) ?_ h
  filter_upwards [windowUpper_eventually_le_thinCandidate] with n hinteger
  let pf (bits : BitProfile n (3 * n - 1)) :=
    InThinWindow n ∧ maximumFeasibleOwners (profileTag bits) < thinCandidate n
  let qf (bits : BitProfile n (3 * n - 1)) :=
    windowUpper n < maximumFeasibleOwners (profileTag bits)
  refine (finiteProbability_mono (fun bits hbad => ?_)).trans (finiteProbability_union_two pf qf)
  rcases lt_or_gt_of_ne hbad.2 with h | h
  · exact Or.inl ⟨hbad.1, h⟩
  · exact Or.inr (lt_of_le_of_lt hinteger h)

end TwoColorNullity.Occupancy
