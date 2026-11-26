import ThinTransition

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

noncomputable def fractionalTransition (n : ℕ) : ℝ := transitionLog n - (transitionFloor n : ℝ)

def OutsideTransitionWindows (n : ℕ) : Prop :=
  fractionalTransition n < 1 - boundaryWidth thresholdWindowConstant n

noncomputable def centeredEFX (n : ℕ) (bits : BitProfile n (3 * n - 1)) : ℝ :=
  (n : ℝ) / optimalFactor (profileTag bits) - binaryLog n

theorem windowUpper_eq_floor_of_outside (n : ℕ) (hn : 1 ≤ n) (hw : OutsideTransitionWindows n) :
    windowUpper n = transitionFloor n := by
  have hl := transitionLog_nonnegative n hn
  have hnLog : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg (by exact_mod_cast hn)
  have hw₀ : 0 ≤ boundaryWidth thresholdWindowConstant n :=
    mul_nonneg thresholdWindowConstant_pos.le (div_nonneg hnLog (Real.sqrt_nonneg _))
  have hp := add_nonneg hl hw₀
  have hlo : transitionFloor n ≤ windowUpper n := (Nat.le_floor_iff hp).mpr
    ((transitionFloor_bounds n hn).1.trans (le_add_of_nonneg_right hw₀))
  have hhi : (windowUpper n : ℝ) < (transitionFloor n : ℝ) + 1 := by
    have hfloor : (windowUpper n : ℝ) ≤ transitionLog n + boundaryWidth thresholdWindowConstant n := Nat.floor_le hp
    unfold OutsideTransitionWindows fractionalTransition at hw
    linarith only [hfloor, hw]
  have hle : windowUpper n < transitionFloor n + 1 := by exact_mod_cast hhi
  omega

/-- Explicit reciprocal error for the lower endpoint of the integer factor interval. -/
theorem factorReciprocal_error (n s : ℕ) (hs : 0 < s) (hroom : 2 * s ≤ n - 1) :
    let factor := (((n - 1) ⌈/⌉ s - 1 : ℕ) : ℝ)
    0 ≤ (n : ℝ) / factor - (s : ℝ) ∧
      (n : ℝ) / factor - (s : ℝ) ≤ 2 * (s : ℝ) * ((s : ℝ) + 1) / ((n - 1 : ℕ) : ℝ) := by
  dsimp only
  let q := (n - 1) ⌈/⌉ s
  let factor := ((q - 1 : ℕ) : ℝ)
  let extra := ((n - 1 : ℕ) : ℝ)
  have hsR : 0 < (s : ℝ) := by exact_mod_cast hs
  have hn₁ : 1 ≤ n := by omega
  have hq : 1 ≤ q := by
    have h := (ceilDiv_le_iff_le_mul hs).mp (le_refl q)
    by_contra! hbad
    have hzero : q = 0 := by omega
    rw [hzero, mul_zero] at h
    omega
  have hfactor : factor = (q : ℝ) - 1 := by unfold factor; rw [Nat.cast_sub hq, Nat.cast_one]
  have hextra : extra = (n : ℝ) - 1 := by unfold extra; rw [Nat.cast_sub hn₁, Nat.cast_one]
  obtain ⟨hlo, hhi⟩ := ceilDiv_real_bounds (n - 1) s hs
  change extra / (s : ℝ) ≤ (q : ℝ) at hlo
  change (q : ℝ) ≤ extra / (s : ℝ) + 1 at hhi
  have hl : extra / (s : ℝ) - 1 ≤ factor := by linarith only [hlo, hfactor]
  have hh : factor ≤ extra / (s : ℝ) := by linarith only [hhi, hfactor]
  have hsmall : (2 : ℝ) ≤ extra / (s : ℝ) := by
    apply (le_div_iff₀ hsR).mpr
    change 2 * (s : ℝ) ≤ ((n - 1 : ℕ) : ℝ)
    exact_mod_cast hroom
  have hfactor₁ : 0 < factor := by linarith only [hsmall, hl]
  have hextra₁ : 0 < extra := by
    change 0 < ((n - 1 : ℕ) : ℝ)
    exact_mod_cast (show 0 < n - 1 by omega)
  have hhalf : extra / (2 * (s : ℝ)) ≤ factor := by
    have hrewrite : extra / (2 * (s : ℝ)) = extra / (s : ℝ) / 2 := by ring
    rw [hrewrite]
    linarith only [hl, hsmall]
  have hupper : (n : ℝ) - factor * (s : ℝ) ≤ (s : ℝ) + 1 := by
    have h := mul_le_mul_of_nonneg_right hl hsR.le
    rw [sub_mul, div_mul_cancel₀ _ hsR.ne', one_mul] at h
    linarith only [h, hextra]
  have hlower : 0 ≤ (n : ℝ) - factor * (s : ℝ) := by
    have h := (le_div_iff₀ hsR).mp hh
    linarith only [h, hextra]
  have hratio : (n : ℝ) / factor - (s : ℝ) = ((n : ℝ) - factor * (s : ℝ)) / factor := by
    rw [sub_div, mul_comm factor, mul_div_cancel_right₀ _ hfactor₁.ne']
  change 0 ≤ (n : ℝ) / factor - (s : ℝ) ∧ (n : ℝ) / factor - (s : ℝ) ≤
    2 * (s : ℝ) * ((s : ℝ) + 1) / extra
  rw [hratio]
  refine ⟨div_nonneg hlower hfactor₁.le, ?_⟩
  have ha : 0 ≤ (s : ℝ) + 1 := by linarith [hsR.le]
  have hp := div_le_div₀ ha hupper (div_pos hextra₁ (by positivity)) hhalf
  have hm : ((s : ℝ) + 1) / (extra / (2 * (s : ℝ))) =
      2 * (s : ℝ) * ((s : ℝ) + 1) / extra := by
    field_simp [hextra₁.ne', hsR.ne']
  exact hp.trans_eq hm

noncomputable def reciprocalEnvelope (n : ℕ) : ℝ :=
  4 * (binaryLog n + 3) * (binaryLog n + 4) / (n : ℝ)

theorem reciprocalEnvelope_zero : Tendsto reciprocalEnvelope atTop (𝓝 0) := by
  have hsq := (log_count_over_n_zero.div_const (Real.log 2 ^ 2))
  have hInv : Tendsto (fun n : ℕ => ((n : ℝ))⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_zero.comp tendsto_natCast_atTop_atTop
  have h := (((hsq.add (binaryLog_over_n_zero.const_mul (7 : ℝ))).add (hInv.const_mul (12 : ℝ))).const_mul (4 : ℝ))
  simp only [zero_div, mul_zero, add_zero] at h
  refine h.congr' (Eventually.of_forall fun n => ?_)
  unfold reciprocalEnvelope binaryLog
  ring

theorem transitionFloor_le_log_add_two (n : ℕ) (hn : 1 ≤ n) :
    (transitionFloor n : ℝ) ≤ binaryLog n + 2 := by
  have hlt : criticalRatio < (2 : ℝ) ^ (2 : ℕ) := by norm_num; linarith [criticalRatio_mem_Ioo.2]
  have h := (lt_two_nat_pow_iff_binaryLog 2 criticalRatio_pos).mp hlt
  have hfloor := (transitionFloor_bounds n hn).1
  rw [transitionLog_shift n hn] at hfloor
  norm_num at h
  linarith only [h, hfloor]

theorem reciprocal_error_le_envelope (n s : ℕ) (hn : 2 ≤ n) (hs : 0 < s) (hroom : 2 * s ≤ n - 1)
    (hsize : (s : ℝ) ≤ binaryLog n + 3) :
    let factor := (((n - 1) ⌈/⌉ s - 1 : ℕ) : ℝ)
    |(n : ℝ) / factor - (s : ℝ)| ≤ reciprocalEnvelope n := by
  obtain ⟨h₀, h₁⟩ := factorReciprocal_error n s hs hroom
  dsimp only
  rw [abs_of_nonneg h₀]
  refine h₁.trans ?_
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hden : (n : ℝ) / 2 ≤ ((n - 1 : ℕ) : ℝ) := by
    rw [Nat.cast_sub (by omega : 1 ≤ n), Nat.cast_one]
    have h : (2 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  have hsR : 0 ≤ (s : ℝ) := by positivity
  have hnum : 2 * (s : ℝ) * ((s : ℝ) + 1) ≤ 2 * (binaryLog n + 3) * (binaryLog n + 4) := by
    apply mul_le_mul
    · exact mul_le_mul_of_nonneg_left hsize (by norm_num)
    · linarith only [hsize]
    · positivity
    · exact mul_nonneg (by norm_num) (hsR.trans hsize)
  have hc₀ : 0 ≤ binaryLog n + 3 := hsR.trans hsize
  have hc₁ : 0 ≤ binaryLog n + 4 := by linarith
  have h := div_le_div₀ (mul_nonneg (mul_nonneg (by norm_num) hc₀) hc₁) hnum
    (div_pos hnR (by norm_num)) hden
  refine h.trans_eq ?_
  unfold reciprocalEnvelope
  ring

theorem centered_lattice_formula {ε : ℝ} (hε : 0 < ε) :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      OutsideTransitionWindows n ∧ ε ≤ |centeredEFX n bits - (binaryLog criticalRatio - fractionalTransition n)|))
      atTop (𝓝 0) := by
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity)
    ?_ sharp_random_efx_threshold
  filter_upwards [eventually_ge_atTop (2 : ℕ), transitionFloor_eventually_admissible,
    reciprocalEnvelope_zero.eventually (gt_mem_nhds hε)] with n hn hadm henv
  apply finiteProbability_mono
  intro bits hbad hgood
  have heq : maximumFeasibleOwners (profileTag bits) = transitionFloor n :=
    le_antisymm (hgood.2.1.trans_eq (windowUpper_eq_floor_of_outside n (by omega) hbad.1)) hgood.1
  have h := reciprocal_error_le_envelope n (transitionFloor n) hn hadm.1 hadm.2.2
    ((transitionFloor_le_log_add_two n (by omega)).trans (by linarith))
  have hcenter : centeredEFX n bits - (binaryLog criticalRatio - fractionalTransition n) =
      (n : ℝ) / (((n - 1) ⌈/⌉ transitionFloor n - 1 : ℕ) : ℝ) - (transitionFloor n : ℝ) := by
    unfold centeredEFX
    rw [hgood.2.2]
    unfold typicalOptimum fractionalTransition
    rw [heq, transitionLog_shift n (by omega)]
    ring
  exact (not_lt_of_ge hbad.2) (by rw [hcenter]; exact h.trans_lt henv)

end TwoColorNullity.Occupancy
