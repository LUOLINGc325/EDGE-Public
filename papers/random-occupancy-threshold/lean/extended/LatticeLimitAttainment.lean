import PhaseSubsequences

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

private theorem nearby_interior_phase (phase ε : ℝ) (hp : phase ∈ Set.Icc (0 : ℝ) 1) (hε : 0 < ε) :
    ∃ inside ∈ Set.Ioo (0 : ℝ) 1, |inside - phase| ≤ ε := by
  let inside := (phase + ε) / (1 + 2 * ε)
  have hd : 0 < 1 + 2 * ε := by linarith
  have hi0 : 0 < inside := div_pos (add_pos_of_nonneg_of_pos hp.1 hε) hd
  have hi1 : inside < 1 := (div_lt_iff₀ hd).mpr (by linarith [hp.2, hε])
  have hdiff : inside - phase = ε * (1 - 2 * phase) / (1 + 2 * ε) := by
    unfold inside
    field_simp [hd.ne']
    ring
  have hunit : |1 - 2 * phase| ≤ 1 := abs_le.mpr ⟨by linarith [hp.2], by linarith [hp.1]⟩
  refine ⟨inside, ⟨hi0, hi1⟩, ?_⟩
  rw [hdiff, abs_div, abs_mul, abs_of_nonneg hε.le, abs_of_nonneg hd.le]
  apply (div_le_iff₀ hd).mpr
  have h := mul_le_mul_of_nonneg_left hunit hε.le
  nlinarith only [h, sq_nonneg ε]


private noncomputable def phaseErrorProbability (n : ℕ) (phase cutoff : ℝ) : ℝ :=
  finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
    cutoff ≤ |centeredEFX n bits - (binaryLog criticalRatio - phase)|)

private theorem phaseErrorProbability_nonneg (n : ℕ) (phase cutoff : ℝ) :
    0 ≤ phaseErrorProbability n phase cutoff := by
  unfold phaseErrorProbability finiteProbability
  positivity

private theorem phaseErrorProbability_antitone (n : ℕ) (phase : ℝ) :
    Antitone (phaseErrorProbability n phase) := by
  intro first second hcut
  apply finiteProbability_mono
  exact fun _ h => hcut.trans h

private theorem population_for_phase_accuracy (phase ε : ℝ) (hp : phase ∈ Set.Icc (0 : ℝ) 1)
    (hε : 0 < ε) (minSize : ℕ) :
    ∃ n ≥ minSize, OutsideTransitionWindows n ∧ phaseErrorProbability n phase (2 * ε) ≤ ε := by
  obtain ⟨inside, hi, hnear⟩ := nearby_interior_phase phase ε hp hε
  have hlim := centered_phase_limit inside hi.1 hi.2 ε hε
  obtain ⟨j, hj, houtside, hbound⟩ :=
    ((tendsto_atTop.1 (phasePopulation_atTop inside) minSize).and
      ((phase_outside_eventually inside hi.1 hi.2).and (hlim.eventually (gt_mem_nhds hε)))).exists
  let n := phasePopulation inside j
  refine ⟨n, hj, houtside, ?_⟩
  have h : finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      2 * ε ≤ |centeredEFX n bits - (binaryLog criticalRatio - phase)|) ≤
      finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
        ε ≤ |centeredEFX n bits - (binaryLog criticalRatio - inside)|) := by
    apply finiteProbability_mono
    intro bits hfar
    by_contra! hsmall
    rw [show centeredEFX n bits - (binaryLog criticalRatio - phase) =
      (centeredEFX n bits - (binaryLog criticalRatio - inside)) + (phase - inside) by ring] at hfar
    have htri := abs_add_le (centeredEFX n bits - (binaryLog criticalRatio - inside)) (phase - inside)
    rw [abs_sub_comm phase inside] at htri
    linarith only [hfar, htri, hsmall, hnear]
  exact h.trans hbound.le

private noncomputable def phaseAccuracy (j : ℕ) : ℝ := ((j : ℝ) + 2)⁻¹

private theorem phaseAccuracy_pos (j : ℕ) : 0 < phaseAccuracy j := by unfold phaseAccuracy; positivity

private theorem phaseAccuracy_zero : Tendsto phaseAccuracy atTop (𝓝 0) := by
  have cast : Tendsto (fun j : ℕ => (j : ℝ)) atTop atTop := tendsto_natCast_atTop_atTop
  have shift : Tendsto (fun j : ℕ => (j : ℝ) + 2) atTop atTop := by
    apply tendsto_atTop.2
    intro b
    filter_upwards [tendsto_atTop.1 cast b] with j hj
    linarith
  have h : Tendsto (fun j : ℕ => ((j : ℝ) + 2)⁻¹) atTop (𝓝 0) := tendsto_inv_atTop_zero.comp shift
  exact h

/-- All phases occur as probability limits along increasing populations outside the transition windows. -/
theorem all_closed_interval_phases_attained_outside (phase : ℝ) (hp : phase ∈ Set.Icc (0 : ℝ) 1) :
    ∃ population : ℕ → ℕ, StrictMono population ∧ Tendsto population atTop atTop ∧
      (∀ j, OutsideTransitionWindows (population j)) ∧ CenteredConvergesInProbability population (binaryLog criticalRatio - phase) := by
  let pick (minSize j : ℕ) : ℕ :=
    (population_for_phase_accuracy phase (phaseAccuracy j) hp (phaseAccuracy_pos j) minSize).choose
  have hpick (minSize j : ℕ) := (population_for_phase_accuracy phase
    (phaseAccuracy j) hp (phaseAccuracy_pos j) minSize).choose_spec
  let pop : ℕ → ℕ := Nat.rec (pick 1 0) (fun j last => pick (last + 1) (j + 1))
  have hs (j : ℕ) : pop j < pop (j + 1) :=
    (Nat.lt_succ_self _).trans_le (hpick (pop j + 1) (j + 1)).1
  have hmono := strictMono_nat_of_lt_succ hs
  have hsize (j : ℕ) : j ≤ pop j := by
    induction j with
    | zero => exact Nat.zero_le _
    | succ j ih => have h := hs j; omega
  have htop : Tendsto pop atTop atTop := by
    apply tendsto_atTop.2
    intro b
    filter_upwards [eventually_ge_atTop b] with j hj
    exact hj.trans (hsize j)
  have haccurate (j : ℕ) : phaseErrorProbability (pop j) phase (2 * phaseAccuracy j) ≤ phaseAccuracy j := by
    cases j with
    | zero => exact (hpick 1 0).2.2
    | succ j => exact (hpick (pop j + 1) (j + 1)).2.2
  have houtside (j : ℕ) : OutsideTransitionWindows (pop j) := by
    cases j with
    | zero => exact (hpick 1 0).2.1
    | succ j => exact (hpick (pop j + 1) (j + 1)).2.1
  refine ⟨pop, hmono, htop, houtside, ?_⟩
  intro ε hε
  change Tendsto (fun j => phaseErrorProbability (pop j) phase ε) atTop (𝓝 0)
  apply squeeze_zero' (Eventually.of_forall fun j => phaseErrorProbability_nonneg (pop j) phase ε)
    ?_ phaseAccuracy_zero
  filter_upwards [phaseAccuracy_zero.eventually (gt_mem_nhds (half_pos hε))] with j hj
  exact (phaseErrorProbability_antitone (pop j) phase (by linarith only [hj])).trans (haccurate j)

theorem all_closed_interval_phases_attained (phase : ℝ) (hp : phase ∈ Set.Icc (0 : ℝ) 1) :
    ∃ population : ℕ → ℕ, StrictMono population ∧ Tendsto population atTop atTop ∧
      CenteredConvergesInProbability population (binaryLog criticalRatio - phase) := by
  obtain ⟨population, hmono, htop, _, hlimit⟩ := all_closed_interval_phases_attained_outside phase hp
  exact ⟨population, hmono, htop, hlimit⟩

end TwoColorNullity.Occupancy
