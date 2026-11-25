import RandomThresholdBound
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
import Mathlib.Topology.MetricSpace.Pseudo.Lemmas
import Mathlib.Tactic.FieldSimp

open Filter
open scoped BigOperators Topology

namespace TwoColorNullity

noncomputable def binaryLog (x : ℝ) : ℝ := Real.log x / Real.log 2

theorem log_two_pos : 0 < Real.log 2 := Real.log_pos (by norm_num)

theorem binaryLog_floor_bounds (n : ℕ) (hn : 0 < n) :
    (n.log2 : ℝ) ≤ binaryLog n ∧ binaryLog n < (n.log2 : ℝ) + 1 := by
  have hlo : (2 : ℕ) ^ n.log2 ≤ n := (Nat.le_log2 hn.ne').mp (le_refl _)
  have hhi : n < (2 : ℕ) ^ (n.log2 + 1) := (Nat.log2_lt hn.ne').mp (by omega)
  have hnR : 0 < (n : ℝ) := by exact_mod_cast hn
  have hloR : (2 : ℝ) ^ n.log2 ≤ n := by exact_mod_cast hlo
  have hhiR : (n : ℝ) < (2 : ℝ) ^ (n.log2 + 1) := by exact_mod_cast hhi
  have hloLog := Real.log_le_log (by positivity) hloR
  have hhiLog := Real.log_lt_log hnR hhiR
  rw [Real.log_pow] at hloLog hhiLog
  unfold binaryLog
  exact ⟨(le_div_iff₀ log_two_pos).mpr hloLog,
    (div_lt_iff₀ log_two_pos).mpr (by exact_mod_cast hhiLog)⟩

theorem threshold_le_binaryLog_add (n : ℕ) (hn : 0 < n) :
    (largeSetThreshold n : ℝ) ≤ binaryLog n + 7 := by
  have hlo := (binaryLog_floor_bounds n hn).1
  have hhi : n < (2 : ℕ) ^ (n.log2 + 1) := (Nat.log2_lt hn.ne').mp (by omega)
  have hclog : Nat.clog 2 n ≤ n.log2 + 1 :=
    (Nat.clog_le_iff_le_pow (by decide : 1 < 2)).mpr hhi.le
  have h : (Nat.clog 2 n : ℝ) ≤ (n.log2 : ℝ) + 1 := by exact_mod_cast hclog
  unfold largeSetThreshold
  push_cast
  linarith

theorem polynomial_exponential_decay (power : ℕ) {scale : ℝ} (hscale : 0 < scale) :
    Tendsto (fun n : ℕ => (n : ℝ) ^ power * Real.exp (-(scale * (n : ℝ)))) atTop (𝓝 0) := by
  have argument : Tendsto (fun n : ℕ => scale * (n : ℝ)) atTop atTop :=
    (tendsto_natCast_atTop_atTop : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop).const_mul_atTop hscale
  have decay := (Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero power).comp argument
  simpa only [mul_zero, Function.comp_apply, mul_pow, ← mul_assoc,
    inv_mul_cancel₀ (pow_ne_zero _ hscale.ne'), one_mul] using decay.const_mul ((scale ^ power)⁻¹)

private theorem smallWitnessBase_le (n : ℕ) :
    smallWitnessBase n ≤ 9 * ((n : ℝ) ^ 3 * Real.exp (-(Real.log 2 / 2 * (n : ℝ)))) := by
  have hhalf : (n : ℝ) / 2 ≤ ((n - n / 2 : ℕ) : ℝ) := by
    have h : n ≤ 2 * (n - n / 2) := by omega
    have hc : (n : ℝ) ≤ 2 * ((n - n / 2 : ℕ) : ℝ) := by exact_mod_cast h
    linarith
  have hlog : Real.log ((1 : ℝ) / 2) = -Real.log 2 := by
    rw [Real.log_div (by norm_num) (by norm_num), Real.log_one, zero_sub]
  have hexp : ((1 : ℝ) / 2) ^ (n - n / 2) ≤
      Real.exp (-(Real.log 2 / 2 * (n : ℝ))) := by
    rw [← Real.exp_log (show 0 < (1 : ℝ) / 2 by norm_num), ← Real.exp_nat_mul, hlog]
    apply Real.exp_le_exp.mpr
    nlinarith only [mul_le_mul_of_nonneg_right hhalf log_two_pos.le]
  simpa only [smallWitnessBase, mul_assoc] using
    mul_le_mul_of_nonneg_left hexp (show 0 ≤ 9 * (n : ℝ) ^ 3 by positivity)

private theorem smallWitness_tail_zero :
    Tendsto (fun n : ℕ => ∑ r ∈ Finset.Icc 1 (n / 2), smallWitnessBase n ^ r) atTop (𝓝 0) := by
  have hscale : 0 < Real.log 2 / 2 := div_pos log_two_pos (by norm_num)
  have hbase : ∀ᶠ n in atTop, smallWitnessBase n ≤ 1 := by
    have h := (polynomial_exponential_decay 3 hscale).const_mul (9 : ℝ)
    rw [mul_zero] at h
    filter_upwards [h.eventually (gt_mem_nhds zero_lt_one)] with n hn
    exact (smallWitnessBase_le n).trans hn.le
  have hlimit := (polynomial_exponential_decay 4 hscale).const_mul (9 : ℝ)
  rw [mul_zero] at hlimit
  apply squeeze_zero' (Eventually.of_forall fun n => Finset.sum_nonneg fun _ _ => by unfold smallWitnessBase; positivity) ?_ hlimit
  filter_upwards [hbase] with n hn
  have hb : 0 ≤ smallWitnessBase n := by unfold smallWitnessBase; positivity
  have hcard : ((Finset.Icc 1 (n / 2)).card : ℝ) ≤ n := by
    have hc : (Finset.Icc 1 (n / 2)).card ≤ n := by rw [Nat.card_Icc]; omega
    exact_mod_cast hc
  calc
    _ ≤ ∑ _r ∈ Finset.Icc 1 (n / 2), smallWitnessBase n := by
      apply Finset.sum_le_sum
      intro r hr
      simpa only [pow_one] using pow_le_pow_of_le_one hb hn (Finset.mem_Icc.mp hr).1
    _ ≤ (n : ℝ) * smallWitnessBase n := by
      simp only [Finset.sum_const, nsmul_eq_mul]
      exact mul_le_mul_of_nonneg_right hcard hb
    _ ≤ (n : ℝ) * (9 * ((n : ℝ) ^ 3 * Real.exp (-(Real.log 2 / 2 * (n : ℝ))))) :=
      mul_le_mul_of_nonneg_left (smallWitnessBase_le n) (by positivity)
    _ = _ := by ring

theorem real_log_over_n_zero :
    Tendsto (fun n : ℕ => Real.log (n : ℝ) / n) atTop (𝓝 0) := by
  simpa only [Function.comp_apply, id_eq] using
    Real.isLittleO_log_id_atTop.tendsto_div_nhds_zero.comp
      (tendsto_natCast_atTop_atTop : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop)

private theorem log_squared_over_n_zero :
    Tendsto (fun n : ℕ => (Real.log (n : ℝ)) ^ 2 / n) atTop (𝓝 0) := by
  have h := (isLittleO_log_rpow_rpow_atTop 2 (show (0 : ℝ) < 1 by norm_num)).tendsto_div_nhds_zero
  simpa only [Real.rpow_one, Real.rpow_two, Function.comp_apply] using
    h.comp (tendsto_natCast_atTop_atTop : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop)

private theorem largeWitness_tail_zero :
    Tendsto (fun n : ℕ => (n : ℝ) ^ largeSetThreshold n * largeWitnessBase ^ (n / 2)) atTop (𝓝 0) := by
  let beta := -Real.log largeWitnessBase / 6
  have hb : 0 < beta := div_pos (neg_pos.mpr (Real.log_neg largeWitnessBase_bounds.1 largeWitnessBase_bounds.2))
    (by norm_num)
  have envelope := (log_squared_over_n_zero.div_const (Real.log 2)).add (real_log_over_n_zero.const_mul 7)
  simp only [zero_div, mul_zero, add_zero] at envelope
  have hd := polynomial_exponential_decay 0 hb
  simp only [pow_zero, one_mul] at hd
  apply squeeze_zero' (Eventually.of_forall fun n =>
    mul_nonneg (pow_nonneg (Nat.cast_nonneg n) _) (pow_nonneg largeWitnessBase_bounds.1.le _)) ?_ hd
  filter_upwards [eventually_ge_atTop (3 : ℕ), envelope.eventually (gt_mem_nhds hb)] with n hn hs
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hlog : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg (by exact_mod_cast (show 1 ≤ n by omega))
  have ht := mul_le_mul_of_nonneg_right (threshold_le_binaryLog_add n (by omega)) hlog
  have hthird : (n : ℝ) ≤ 3 * ((n / 2 : ℕ) : ℝ) := by
    exact_mod_cast (show n ≤ 3 * (n / 2) by omega)
  have hscaled : (Real.log (n : ℝ)) ^ 2 / Real.log 2 + 7 * Real.log (n : ℝ) ≤ beta * n := by
    have h := mul_le_mul_of_nonneg_right hs.le hnR.le
    have logTwo := log_two_pos.ne'
    have heq : ((Real.log (n : ℝ)) ^ 2 / (n : ℝ) / Real.log 2 +
        7 * (Real.log (n : ℝ) / (n : ℝ))) * (n : ℝ) =
        (Real.log (n : ℝ)) ^ 2 / Real.log 2 + 7 * Real.log (n : ℝ) := by
      field_simp [hnR.ne', logTwo]
    rwa [heq] at h
  have expForm : (n : ℝ) ^ largeSetThreshold n * largeWitnessBase ^ (n / 2) =
      Real.exp ((largeSetThreshold n : ℝ) * Real.log (n : ℝ) +
        ((n / 2 : ℕ) : ℝ) * Real.log largeWitnessBase) := by
    rw [Real.exp_add, Real.exp_nat_mul, Real.exp_nat_mul, Real.exp_log hnR,
      Real.exp_log largeWitnessBase_bounds.1]
  rw [expForm]
  apply Real.exp_le_exp.mpr
  have hlogBound : (largeSetThreshold n : ℝ) * Real.log (n : ℝ) ≤ beta * n := by
    refine ht.trans ?_
    have heq : (binaryLog n + 7) * Real.log (n : ℝ) =
        (Real.log (n : ℝ)) ^ 2 / Real.log 2 + 7 * Real.log (n : ℝ) := by
      unfold binaryLog
      ring
    rwa [heq]
  have hbEq : Real.log largeWitnessBase = -6 * beta := by unfold beta; ring
  rw [hbEq]
  nlinarith only [hlogBound, mul_le_mul_of_nonneg_right hthird hb.le]

theorem bad_owner_sets_probability_vanishes :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      largeSetThreshold n ≤ maximumFeasibleOwners (profileTag bits))) atTop (𝓝 0) := by
  have h := smallWitness_tail_zero.add largeWitness_tail_zero
  rw [zero_add] at h
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity) ?_ h
  filter_upwards [eventually_ge_atTop (3 : ℕ)] with n hn
  exact large_set_threshold_probability_bound n hn

end TwoColorNullity
