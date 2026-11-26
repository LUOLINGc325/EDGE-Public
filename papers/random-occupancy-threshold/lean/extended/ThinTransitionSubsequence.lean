import PhaseSubsequences

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

noncomputable def boundaryPopulation (j : ℕ) : ℕ := ⌈transitionMark j⌉₊ - 1

theorem boundaryPopulation_atTop : Tendsto boundaryPopulation atTop atTop := by
  have hmarks : Tendsto transitionMark atTop atTop := by
    refine (phaseReal_atTop 0).congr' (Eventually.of_forall fun j => ?_)
    rw [phaseReal_pow]
    simp [transitionMark, div_eq_mul_inv, mul_comm]
  apply tendsto_atTop.2
  intro bound
  filter_upwards [tendsto_atTop.1 hmarks ((bound + 1 : ℕ) : ℝ)] with j hj
  have hc : bound + 1 ≤ ⌈transitionMark j⌉₊ := by
    exact_mod_cast hj.trans (Nat.le_ceil _)
  unfold boundaryPopulation
  omega

theorem boundaryPopulation_rounds_below (j : ℕ) :
    (boundaryPopulation j : ℝ) < transitionMark j ∧ transitionMark j ≤ (boundaryPopulation j : ℝ) + 1 := by
  have hceil : 1 ≤ ⌈transitionMark j⌉₊ := Nat.one_le_ceil_iff.mpr (transitionMark_pos j)
  have heq : boundaryPopulation j + 1 = ⌈transitionMark j⌉₊ := by unfold boundaryPopulation; omega
  refine ⟨Nat.add_one_le_ceil_iff.mp heq.le, ?_⟩
  have hi := Nat.le_ceil (transitionMark j)
  rw [← heq, Nat.cast_add, Nat.cast_one] at hi
  exact hi

private theorem transitionMark_log (j : ℕ) : binaryLog (criticalRatio * transitionMark j) = j := by
  have h : criticalRatio * transitionMark j = (2 : ℝ) ^ j := by
    unfold transitionMark
    field_simp [criticalRatio_pos.ne']
  rw [h, binaryLog_pow_two]

theorem boundaryPopulation_eventually_thin :
    ∀ᶠ j : ℕ in atTop, InThinWindow (boundaryPopulation j) ∧ thinCandidate (boundaryPopulation j) = j := by
  have hcast := (tendsto_natCast_atTop_atTop : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop).comp boundaryPopulation_atTop
  have hinv := (tendsto_inv_atTop_zero.comp hcast).div_const (Real.log 2)
  simp only [zero_div, Function.comp_apply] at hinv
  filter_upwards [tendsto_atTop.1 boundaryPopulation_atTop 1, eventually_ge_atTop (1 : ℕ),
    hinv.eventually (gt_mem_nhds (show (0 : ℝ) < 1 by norm_num)),
    tendsto_atTop.1 (sqrt_nat_atTop.comp boundaryPopulation_atTop) (1 / (thinConstant * Real.log 2))]
    with j hj hj₁ hsmall hroot
  let n := boundaryPopulation j
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hround := boundaryPopulation_rounds_below j
  have hlog := rounded_population_log_error (transitionMark j) n hj hround.1.le hround.2
  rw [transitionMark_log] at hlog
  have hpos : transitionLog n < (j : ℝ) := by
    apply (lt_two_nat_pow_iff_binaryLog j (mul_pos criticalRatio_pos hnR)).mp
    exact (by simpa only [transitionMark, mul_comm] using (lt_div_iff₀ criticalRatio_pos).mp hround.1)
  have hlogSmall : (j : ℝ) - transitionLog n < 1 := (hlog.2).trans_lt (by simpa only [one_div] using hsmall)
  have hfloorLo : j - 1 ≤ transitionFloor n := by
    apply (Nat.le_floor_iff (transitionLog_nonnegative n hj)).mpr
    rw [Nat.cast_sub hj₁, Nat.cast_one]
    linarith only [hlogSmall]
  have hfloorHi : transitionFloor n < j := by exact_mod_cast (transitionFloor_bounds n hj).1.trans_lt hpos
  have hsame : thinCandidate n = j := by unfold thinCandidate; omega
  refine ⟨?_, hsame⟩
  unfold InThinWindow
  rw [hsame]
  refine hlog.2.trans ?_
  rw [div_div]
  have hsqrt : 0 < Real.sqrt (n : ℝ) := Real.sqrt_pos.mpr hnR
  have hcut := (div_le_iff₀ (mul_pos thinConstant_pos log_two_pos)).mp hroot
  apply (div_le_div_iff₀ (mul_pos hnR log_two_pos) hsqrt).mpr
  rw [one_mul]
  calc
    _ ≤ (Real.sqrt (n : ℝ) * (thinConstant * Real.log 2)) * Real.sqrt (n : ℝ) :=
      by simpa only [one_mul] using mul_le_mul_of_nonneg_right hcut hsqrt.le
    _ = thinConstant * Real.log 2 * (Real.sqrt (n : ℝ)) ^ 2 := by ring
    _ = _ := by
      rw [Real.sq_sqrt hnR.le]
      ring

/-- The populations immediately before a powers-of-two transition attain the upper index. -/
theorem boundary_population_attains_index :
    Tendsto (fun j : ℕ => finiteProbability (fun bits : BitProfile (boundaryPopulation j) (3 * boundaryPopulation j - 1) =>
      maximumFeasibleOwners (profileTag bits) ≠ j)) atTop (𝓝 0) := by
  refine (thin_transition_attained.comp boundaryPopulation_atTop).congr' ?_
  filter_upwards [boundaryPopulation_eventually_thin] with j h
  change finiteProbability (fun bits : BitProfile (boundaryPopulation j) (3 * boundaryPopulation j - 1) =>
    InThinWindow (boundaryPopulation j) ∧ maximumFeasibleOwners (profileTag bits) ≠ thinCandidate (boundaryPopulation j)) = _
  simp only [h.1, h.2, true_and]

end TwoColorNullity.Occupancy
