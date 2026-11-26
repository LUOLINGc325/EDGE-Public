import TransitionWindowDensity

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

noncomputable def phaseReal (phase : ℝ) (j : ℕ) : ℝ :=
  Real.exp (Real.log 2 * ((j : ℝ) + phase)) / criticalRatio

noncomputable def phasePopulation (phase : ℝ) (j : ℕ) : ℕ := ⌊phaseReal phase j⌋₊

theorem phaseReal_pos (phase : ℝ) (j : ℕ) : 0 < phaseReal phase j :=
  div_pos (Real.exp_pos _) criticalRatio_pos

theorem phaseReal_exact_log (phase : ℝ) (j : ℕ) :
    binaryLog (criticalRatio * phaseReal phase j) = (j : ℝ) + phase := by
  have h : criticalRatio * phaseReal phase j = Real.exp (Real.log 2 * ((j : ℝ) + phase)) := by
    unfold phaseReal
    field_simp [criticalRatio_pos.ne']
  unfold binaryLog
  rw [h, Real.log_exp]
  field_simp [log_two_pos.ne']

theorem phaseReal_pow (phase : ℝ) (j : ℕ) :
    phaseReal phase j = (Real.exp (Real.log 2 * phase) / criticalRatio) * (2 : ℝ) ^ j := by
  unfold phaseReal
  rw [mul_add, mul_comm (Real.log 2) (j : ℝ), Real.exp_add, Real.exp_nat_mul, Real.exp_log (by norm_num : (0 : ℝ) < 2)]
  ring

theorem phaseReal_atTop (phase : ℝ) : Tendsto (phaseReal phase) atTop atTop := by
  have h := (tendsto_pow_atTop_atTop_of_one_lt (by norm_num : (1 : ℝ) < 2)).const_mul_atTop
    (div_pos (Real.exp_pos (Real.log 2 * phase)) criticalRatio_pos)
  exact h.congr' (Eventually.of_forall fun j => (phaseReal_pow phase j).symm)

theorem phasePopulation_atTop (phase : ℝ) : Tendsto (phasePopulation phase) atTop atTop := by
  apply tendsto_atTop.2
  intro bound
  filter_upwards [tendsto_atTop.1 (phaseReal_atTop phase) (bound : ℝ)] with j h
  exact (Nat.le_floor_iff (phaseReal_pos phase j).le).mpr h

theorem rounded_population_log_error (x : ℝ) (n : ℕ) (hn : 1 ≤ n) (hlo : (n : ℝ) ≤ x) (hhi : x ≤ (n : ℝ) + 1) :
    0 ≤ binaryLog (criticalRatio * x) - transitionLog n ∧
      binaryLog (criticalRatio * x) - transitionLog n ≤ 1 / (n : ℝ) / Real.log 2 := by
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hx : 0 < x := hnR.trans_le hlo
  have hratio : 1 ≤ x / (n : ℝ) := (le_div_iff₀ hnR).mpr (by simpa only [one_mul] using hlo)
  have hupper := div_le_div_of_nonneg_right hhi hnR.le
  rw [add_div, div_self hnR.ne'] at hupper
  have hE : binaryLog (criticalRatio * x) - transitionLog n = Real.log (x / (n : ℝ)) / Real.log 2 := by
    unfold transitionLog
    rw [binaryLog_mul_of_pos criticalRatio_pos hx, binaryLog_mul_of_pos criticalRatio_pos hnR]
    unfold binaryLog
    rw [Real.log_div hx.ne' hnR.ne']
    ring
  rw [hE]
  refine ⟨div_nonneg (Real.log_nonneg hratio) log_two_pos.le, ?_⟩
  apply div_le_div_of_nonneg_right _ log_two_pos.le
  have hlog := Real.log_le_sub_one_of_pos (div_pos hx hnR)
  linarith only [hlog, hupper]

theorem phase_log_error_zero (phase : ℝ) :
    Tendsto (fun j : ℕ => (j : ℝ) + phase - transitionLog (phasePopulation phase j)) atTop (𝓝 0) := by
  have hcast := (tendsto_natCast_atTop_atTop : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop).comp
    (phasePopulation_atTop phase)
  have hbound := (tendsto_inv_atTop_zero.comp hcast).div_const (Real.log 2)
  simp only [zero_div, Function.comp_apply] at hbound
  apply squeeze_zero' ?_ ?_ hbound
  all_goals
    filter_upwards [tendsto_atTop.1 (phasePopulation_atTop phase) 1] with j hj
    have he := rounded_population_log_error (phaseReal phase j) (phasePopulation phase j) hj
      (Nat.floor_le (phaseReal_pos phase j).le) (Nat.lt_floor_add_one _).le
    rw [phaseReal_exact_log] at he
    first | exact he.1 | simpa only [one_div] using he.2

theorem phase_floor_eventually (phase : ℝ) (hphase : 0 < phase) (hphase' : phase < 1) :
    ∀ᶠ j : ℕ in atTop, transitionFloor (phasePopulation phase j) = j := by
  filter_upwards [tendsto_atTop.1 (phasePopulation_atTop phase) 1,
    (phase_log_error_zero phase).eventually (gt_mem_nhds hphase)] with j hj he
  let n := phasePopulation phase j
  have lower : (j : ℝ) ≤ transitionLog n := by linarith only [he]
  have hround := (rounded_population_log_error (phaseReal phase j) n hj
    (Nat.floor_le (phaseReal_pos phase j).le) (Nat.lt_floor_add_one _).le).1
  rw [phaseReal_exact_log] at hround
  have upper : transitionLog n < (j : ℝ) + 1 := by linarith only [hround, hphase']
  have h₁ : j ≤ transitionFloor n := (Nat.le_floor_iff (transitionLog_nonnegative n hj)).mpr lower
  have h₂ : (transitionFloor n : ℝ) < (j : ℝ) + 1 := (transitionFloor_bounds n hj).1.trans_lt upper
  have h₃ : transitionFloor n < j + 1 := by exact_mod_cast h₂
  change transitionFloor n = j
  omega

theorem phase_fraction_limit (phase : ℝ) (hphase : 0 < phase) (hphase' : phase < 1) :
    Tendsto (fun j : ℕ => fractionalTransition (phasePopulation phase j)) atTop (𝓝 phase) := by
  have h := (tendsto_const_nhds (x := phase)).sub (phase_log_error_zero phase)
  rw [sub_zero] at h
  refine h.congr' ?_
  filter_upwards [phase_floor_eventually phase hphase hphase'] with j hj
  unfold fractionalTransition
  rw [hj]
  ring

theorem phase_outside_eventually (phase : ℝ) (hphase : 0 < phase) (hphase' : phase < 1) :
    ∀ᶠ j : ℕ in atTop, OutsideTransitionWindows (phasePopulation phase j) := by
  have h := (phase_fraction_limit phase hphase hphase').add
    ((boundaryWidth_zero thresholdWindowConstant).comp (phasePopulation_atTop phase))
  rw [add_zero] at h
  filter_upwards [h.eventually (gt_mem_nhds hphase')] with j hj
  unfold OutsideTransitionWindows
  change fractionalTransition (phasePopulation phase j) +
    boundaryWidth thresholdWindowConstant (phasePopulation phase j) < 1 at hj
  linarith

def CenteredConvergesInProbability (population : ℕ → ℕ) (target : ℝ) : Prop :=
  ∀ ε > 0, Tendsto (fun j : ℕ =>
    finiteProbability (fun bits : BitProfile (population j) (3 * population j - 1) =>
      ε ≤ |centeredEFX (population j) bits - target|)) atTop (𝓝 0)

theorem centered_phase_limit (phase : ℝ) (hphase : 0 < phase) (hphase' : phase < 1) :
    CenteredConvergesInProbability (phasePopulation phase) (binaryLog criticalRatio - phase) := by
  intro ε hε
  have h := (centered_lattice_formula (half_pos hε)).comp (phasePopulation_atTop phase)
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity) ?_ h
  filter_upwards [phase_outside_eventually phase hphase hphase',
    (phase_fraction_limit phase hphase hphase').eventually (Metric.ball_mem_nhds phase (half_pos hε))]
    with j hj hsmall
  let n := phasePopulation phase j
  have hphaseError : |phase - fractionalTransition n| < ε / 2 := by
    simpa only [Metric.mem_ball, Real.dist_eq, abs_sub_comm] using hsmall
  apply finiteProbability_mono
  intro bits hbad
  refine ⟨hj, ?_⟩
  by_contra! hgood
  have heq : centeredEFX n bits - (binaryLog criticalRatio - phase) =
      (centeredEFX n bits - (binaryLog criticalRatio - fractionalTransition n)) +
        (phase - fractionalTransition n) := by ring
  rw [heq] at hbad
  have htri := abs_add_le
    (centeredEFX n bits - (binaryLog criticalRatio - fractionalTransition n)) (phase - fractionalTransition n)
  linarith only [hbad, hgood, hphaseError, htri]

end TwoColorNullity.Occupancy
