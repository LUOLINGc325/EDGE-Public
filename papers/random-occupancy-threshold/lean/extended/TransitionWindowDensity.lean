import TransitionWindowGeometry

open Filter
open scoped BigOperators Topology

namespace TwoColorNullity.Occupancy

noncomputable def excludedSizesBelow (N : ℕ) : Finset ℕ := by
  classical
  exact (Finset.range N).filter (fun n => ¬ OutsideTransitionWindows n)

private theorem sum_powers_two (k : ℕ) :
    (∑ j ∈ Finset.range k, (2 : ℝ) ^ j) = (2 : ℝ) ^ k - 1 := by
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Finset.sum_range_succ, ih, pow_succ]
    ring

private theorem sum_transition_marks (N : ℕ) (hN : 1 ≤ N) :
    (∑ j ∈ Finset.range (thinCandidate N + 1), transitionMark j) ≤ 4 * (N : ℝ) := by
  have hm := (div_le_iff₀ criticalRatio_pos).mp (transitionMark_thin_le_twice N hN)
  unfold transitionMark at hm ⊢
  rw [← Finset.sum_div, sum_powers_two, pow_succ]
  apply (div_le_iff₀ criticalRatio_pos).mpr
  nlinarith only [hm]

theorem excludedSizesBelow_card_bound (N M : ℕ) (hN : 1 ≤ N) (hM : 1 ≤ M)
    (width : ℝ) (hw : 0 ≤ width)
    (hwidth : ∀ n ≥ M, boundaryWidth thresholdWindowConstant n ≤ width) :
    ((excludedSizesBelow N).card : ℝ) ≤
      ((M + 1 : ℕ) : ℝ) + (thinCandidate N : ℝ) + 4 * (N : ℝ) * (1 - windowRatio width) := by
  classical
  let J := thinCandidate N
  let labels := Finset.range (J + 1)
  let windows := labels.biUnion (thresholdInterval width)
  have hh : excludedSizesBelow N ⊆ Finset.range M ∪ windows := by
    intro n h
    have hmem : n < N ∧ ¬ OutsideTransitionWindows n := by simpa [excludedSizesBelow] using h
    apply Finset.mem_union.mpr
    by_cases he : n < M
    · exact Or.inl (Finset.mem_range.mpr he)
    · apply Or.inr
      have hn : 1 ≤ n := by omega
      have hj : thinCandidate n ≤ thinCandidate N := thinCandidate_monotone_of_pos n N hn hmem.1.le
      refine Finset.mem_biUnion.mpr ⟨thinCandidate n, Finset.mem_range.mpr (by dsimp [J]; omega), ?_⟩
      exact thresholdInterval_contains width _ n (excluded_size_in_threshold_interval n hn width
        (hwidth n (by omega)) hmem.2)
  have hcard : (excludedSizesBelow N).card ≤ M + windows.card := by
    exact (Finset.card_le_card hh).trans (by simpa only [Finset.card_range] using Finset.card_union_le (Finset.range M) windows)
  have hwindows : (windows.card : ℝ) ≤ ∑ j ∈ labels, ((thresholdInterval width j).card : ℝ) := by
    rw [← Nat.cast_sum]
    exact_mod_cast (Finset.card_biUnion_le : windows.card ≤ ∑ j ∈ labels, (thresholdInterval width j).card)
  have hδ : 0 ≤ 1 - windowRatio width := sub_nonneg.mpr (windowRatio_bounds hw).2.1
  have hsum : (∑ j ∈ labels, ((thresholdInterval width j).card : ℝ)) ≤
      (1 - windowRatio width) * (4 * (N : ℝ)) + ((J + 1 : ℕ) : ℝ) := by
    calc
      _ ≤ ∑ j ∈ labels, ((1 - windowRatio width) * transitionMark j + 1) :=
        Finset.sum_le_sum (fun j _ => thresholdInterval_card_le width hw j)
      _ = (1 - windowRatio width) * (∑ j ∈ labels, transitionMark j) + ((J + 1 : ℕ) : ℝ) := by
        simp only [Finset.sum_add_distrib, ← Finset.mul_sum, Finset.sum_const, nsmul_eq_mul,
          labels, Finset.card_range, mul_one]
      _ ≤ _ := add_le_add_right (mul_le_mul_of_nonneg_left (sum_transition_marks N hN) hδ) _
  have hcardR : ((excludedSizesBelow N).card : ℝ) ≤ (M : ℝ) + (windows.card : ℝ) := by exact_mod_cast hcard
  push_cast at hsum ⊢
  nlinarith only [hcardR, hwindows, hsum]

/-- The omitted population sizes have natural density zero. -/
theorem transition_windows_natural_density_zero :
    Tendsto (fun N : ℕ => ((excludedSizesBelow N).card : ℝ) / (N : ℝ)) atTop (𝓝 0) := by
  apply tendsto_order.2
  constructor
  · intro lower h
    exact Eventually.of_forall fun N => h.trans_le (div_nonneg (by positivity) (by positivity))
  · intro ε hε
    let width := ε / (8 * Real.log 2)
    have hwidth : 0 < width := div_pos hε (mul_pos (by norm_num) log_two_pos)
    have hb := (boundaryWidth_zero thresholdWindowConstant).eventually (gt_mem_nhds hwidth)
    obtain ⟨M, hM⟩ := eventually_atTop.1 hb
    let M' := max M 1
    have hM' : 1 ≤ M' := le_max_right _ _
    have hwidth' (n : ℕ) (hn : M' ≤ n) : boundaryWidth thresholdWindowConstant n ≤ width :=
      (hM n ((le_max_left _ _).trans hn)).le
    have he : 4 * (1 - windowRatio width) ≤ ε / 2 := by
      refine (mul_le_mul_of_nonneg_left (windowRatio_bounds hwidth.le).2.2 (by norm_num)).trans_eq ?_
      unfold width
      field_simp [log_two_pos.ne']
      ring
    have hInv : Tendsto (fun N : ℕ => ((N : ℝ))⁻¹) atTop (𝓝 0) :=
      tendsto_inv_atTop_zero.comp tendsto_natCast_atTop_atTop
    have hConst := hInv.const_mul ((M' + 1 : ℕ) : ℝ)
    rw [mul_zero] at hConst
    filter_upwards [eventually_ge_atTop (1 : ℕ),
      hConst.eventually (gt_mem_nhds (show 0 < ε / 8 by linarith)),
      thinCandidate_eventually_small (show 0 < ε / 8 by linarith)] with N hn hc hj
    have hN : 0 < (N : ℝ) := by exact_mod_cast (show 0 < N by omega)
    have hc' : ((M' + 1 : ℕ) : ℝ) / (N : ℝ) < ε / 8 := by simpa only [div_eq_mul_inv] using hc
    have hj' : (thinCandidate N : ℝ) / (N : ℝ) ≤ ε / 8 := (div_le_iff₀ hN).mpr hj
    have hcount := div_le_div_of_nonneg_right (excludedSizesBelow_card_bound N M' hn hM' width hwidth.le hwidth') hN.le
    have hsplit :
        (((M' + 1 : ℕ) : ℝ) + (thinCandidate N : ℝ) + 4 * (N : ℝ) * (1 - windowRatio width)) / (N : ℝ) =
          ((M' + 1 : ℕ) : ℝ) / (N : ℝ) + (thinCandidate N : ℝ) / (N : ℝ) + 4 * (1 - windowRatio width) := by
      field_simp [hN.ne']
    rw [hsplit] at hcount
    linarith only [hcount, hc', hj', he, hε]

end TwoColorNullity.Occupancy
