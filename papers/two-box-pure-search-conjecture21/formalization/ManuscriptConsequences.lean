import DepartureBounds
import MixedBenchmark
import SuffixPayoffs
import Mathlib.Analysis.Asymptotics.Defs

/-! The explicit values, examples and large-parameter limits in the manuscript. -/

set_option autoImplicit false

open Filter Asymptotics
open scoped ENNReal Topology

namespace PureSearch

lemma candidate_power_gt_base (m : ℕ) (hm : 3 ≤ m) :
    (m : ℝ) < (m : ℝ) ^ (m - 1) := by
  have hm1 : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have h := pow_lt_pow_right₀ hm1 (show 1 < m - 1 by omega)
  simpa using h

theorem candidate_value_conjecture_formula (m : ℕ) (hm : 3 ≤ m) :
    candidateValue m = 2 + 1 / (m : ℝ) +
      ((m : ℝ) ^ (m - 2) + (m : ℝ) - 2) /
        (((m : ℝ) - 1) * ((m : ℝ) ^ (m - 1) - 1)) := by
  have hm1 : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have hm0 : (m : ℝ) ≠ 0 := by linarith
  have hsub : (m : ℝ) - 1 ≠ 0 := by linarith
  have hpower := candidate_power_gt_base m hm
  have hden : (m : ℝ) ^ (m - 1) - 1 ≠ 0 := by linarith
  have he : (m : ℝ) ^ (m - 1) = (m : ℝ) ^ (m - 2) * (m : ℝ) := by
    rw [show m - 1 = (m - 2) + 1 by omega, pow_succ]
  rw [candidate_value_formula m hm]
  field_simp
  rw [he]
  ring

theorem uniform_departure_margin_formula (m : ℕ) (hm : 3 ≤ m) :
    uniformDepartureMargin m = ((m : ℝ) ^ (m - 2) - 1) / ((m : ℝ) ^ (m - 1) - 1) := by
  have hm1 : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have hpow := candidate_power_gt_base m hm
  have hden : (m : ℝ) ^ (m - 1) - 1 ≠ 0 := by linarith
  have he : (m : ℝ) ^ (m - 1) = (m : ℝ) ^ (m - 2) * (m : ℝ) := by
    rw [show m - 1 = (m - 2) + 1 by omega, pow_succ]
  unfold uniformDepartureMargin candidateDelta
  field_simp
  rw [he]
  ring

theorem three_parameter_values :
    searchMean 3 = 3 / 2 ∧ candidateDelta 3 = 1 / 4 ∧
      uniformDepartureMargin 3 = 1 / 4 ∧ candidateValue 3 = 31 / 12 ∧
      departureMargin 3 1 = 11 / 12 := by
  norm_num [searchMean, candidateDelta, uniformDepartureMargin, candidateValue, departureMargin]

theorem three_periodic_payoff_table :
    let payoff (n : ℕ) :=
      (expectedDetectionTime 3 (suffix (candidate 3) n) true,
        expectedDetectionTime 3 (suffix (candidate 3) n) false)
    payoff 2 = (ENNReal.ofReal (15/4), ENNReal.ofReal (7/4)) ∧
      payoff 3 = (ENNReal.ofReal (11/4), ENNReal.ofReal (9/4)) ∧
      payoff 4 = (ENNReal.ofReal (7/4), ENNReal.ofReal (15/4)) ∧
      payoff 5 = (ENNReal.ofReal (9/4), ENNReal.ofReal (11/4)) := by
  dsimp
  refine ⟨?_, ?_, ?_, ?_⟩
  · have h := periodic_suffix_payoffs 3 0 0 (by omega) (by omega)
    norm_num [searchMean, candidateDelta, blockAction] at h
    exact Prod.ext h.1 h.2
  · have h := periodic_suffix_payoffs 3 0 1 (by omega) (by omega)
    norm_num [searchMean, candidateDelta, blockAction] at h
    exact Prod.ext h.1 h.2
  · have h := periodic_suffix_payoffs 3 1 0 (by omega) (by omega)
    norm_num [searchMean, candidateDelta, blockAction] at h
    exact Prod.ext h.1 h.2
  · have h := periodic_suffix_payoffs 3 1 1 (by omega) (by omega)
    norm_num [searchMean, candidateDelta, blockAction] at h
    exact Prod.ext h.1 h.2

theorem three_periodic_actions_and_margins :
    (candidate 3 2, candidate 3 3, candidate 3 4, candidate 3 5) = (false, false, true, true) ∧
      (departureMargin 3 2, departureMargin 3 3, departureMargin 3 4, departureMargin 3 5) =
        (3/4, 1/4, 3/4, 1/4) := by
  norm_num [candidate, periodicAction, blockAction, departureMargin, candidateDelta]

theorem boundary_margin_at_two : uniformDepartureMargin 2 = 0 := by
  norm_num [uniformDepartureMargin, candidateDelta]

noncomputable def gapRemainder (m : ℕ) : ℝ :=
  ((m : ℝ) - 1) / ((m : ℝ) * ((m : ℝ) ^ (m - 1) - 1))

theorem gap_formula (m : ℕ) (hm : 3 ≤ m) :
    candidateValue m - mixedValue m = 1 / 2 - 1 / ((m : ℝ) - 1) + gapRemainder m := by
  have hm1 : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  rw [candidate_value_formula m hm, mixed_value_formula m hm1]
  unfold gapRemainder
  ring

theorem gap_remainder_bounds (m : ℕ) (hm : 3 ≤ m) :
    0 < gapRemainder m ∧ gapRemainder m < 1 / ((m : ℝ) ^ (m - 1)) := by
  have hm1 : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have hm0 : (0 : ℝ) < m := by linarith
  have hp := candidate_power_gt_base m hm
  have hden : 0 < (m : ℝ) * ((m : ℝ) ^ (m - 1) - 1) := mul_pos hm0 (by linarith)
  unfold gapRemainder
  refine ⟨div_pos (by linarith) hden, ?_⟩
  apply (div_lt_div_iff₀ hden (pow_pos hm0 _)).2
  nlinarith

theorem three_and_four_gap_values :
    candidateValue 3 - mixedValue 3 = 1/12 ∧
      candidateValue 4 = 197/84 ∧ mixedValue 4 = 13/6 ∧
      candidateValue 4 - mixedValue 4 = 5/28 := by
  norm_num [candidateValue, mixedValue, searchMean, candidateDelta]

theorem pure_mixed_gap_pos (m : ℕ) (hm : 3 ≤ m) :
    0 < candidateValue m - mixedValue m := by
  by_cases he : m = 3
  · subst m
    change 0 < candidateValue 3 - mixedValue 3
    rw [three_and_four_gap_values.1]
    norm_num
  · have hm4 : (4 : ℝ) ≤ m := by exact_mod_cast (show 4 ≤ m by omega)
    have hden : 0 < (m : ℝ) - 1 := by linarith
    have hsmall : 1 / ((m : ℝ) - 1) < 1 / 2 := (div_lt_div_iff₀ hden (by norm_num)).2 (by linarith)
    rw [gap_formula m hm]
    linarith [(gap_remainder_bounds m hm).1]

theorem gap_remainder_bigO :
    (fun m : ℕ => candidateValue m - mixedValue m - (1 / 2 - 1 / ((m : ℝ) - 1))) =O[atTop]
      (fun m : ℕ => 1 / ((m : ℝ) ^ (m - 1))) := by
  apply IsBigO.of_bound'
  filter_upwards [eventually_ge_atTop (3 : ℕ)] with m hm
  change |candidateValue m - mixedValue m - (1 / 2 - 1 / ((m : ℝ) - 1))| ≤
    |1 / ((m : ℝ) ^ (m - 1))|
  rw [gap_formula m hm, add_sub_cancel_left, abs_of_pos (gap_remainder_bounds m hm).1,
    abs_of_nonneg (by positivity : 0 ≤ 1 / ((m : ℝ) ^ (m - 1)))]
  exact (gap_remainder_bounds m hm).2.le

theorem large_m_limits :
    Tendsto candidateValue atTop (𝓝 2) ∧
      Tendsto (fun m : ℕ => mixedValue m) atTop (𝓝 (3 / 2)) ∧
      Tendsto (fun m : ℕ => candidateValue m - mixedValue m) atTop (𝓝 (1 / 2)) ∧
      Tendsto (fun m : ℕ => candidateValue m / mixedValue m) atTop (𝓝 (4 / 3)) := by
  have hnat : Tendsto (fun m : ℕ => (m : ℝ)) atTop atTop := tendsto_natCast_atTop_atTop
  have hbase : Tendsto (fun m : ℕ => 1 / (m : ℝ)) atTop (𝓝 0) := by
    simpa only [one_div] using tendsto_inv_atTop_zero.comp hnat
  have hshift : Tendsto (fun m : ℕ => (m : ℝ) - 1) atTop atTop := by
    simpa only [sub_eq_add_neg] using tendsto_atTop_add_const_right atTop (-1 : ℝ) hnat
  have hrec : Tendsto (fun m : ℕ => 1 / ((m : ℝ) - 1)) atTop (𝓝 0) := by
    simpa only [one_div] using tendsto_inv_atTop_zero.comp hshift
  have hrem : Tendsto gapRemainder atTop (𝓝 0) := by
    apply squeeze_zero' _ _ hbase
    · filter_upwards [eventually_ge_atTop (3 : ℕ)] with m hm
      exact (gap_remainder_bounds m hm).1.le
    · filter_upwards [eventually_ge_atTop (3 : ℕ)] with m hm
      have hm0 : (0 : ℝ) < m := by exact_mod_cast (show 0 < m by omega)
      exact ((gap_remainder_bounds m hm).2.trans_le
        (one_div_le_one_div_of_le hm0 (candidate_power_gt_base m hm).le)).le
  have hV : Tendsto candidateValue atTop (𝓝 2) := by
    have h := (hrec.const_add (2 : ℝ)).add hrem
    apply (by simpa only [add_zero] using h : Tendsto
      (fun m : ℕ => 2 + 1 / ((m : ℝ) - 1) + gapRemainder m) atTop (𝓝 2)).congr'
    filter_upwards [eventually_ge_atTop (3 : ℕ)] with m hm
    exact (candidate_value_formula m hm).symm
  have hM : Tendsto (fun m : ℕ => mixedValue m) atTop (𝓝 (3 / 2)) := by
    have h := (hrec.const_mul (2 : ℝ)).const_add (3 / 2 : ℝ)
    rw [mul_zero, add_zero] at h
    apply h.congr'
    filter_upwards [eventually_ge_atTop (3 : ℕ)] with m hm
    rw [mixed_value_formula m (by exact_mod_cast (show 1 < m by omega)), mul_one_div]
  refine ⟨hV, hM, ?_, ?_⟩
  · convert hV.sub hM using 1
    norm_num
  · convert hV.div hM (by norm_num : (3 / 2 : ℝ) ≠ 0) using 1
    norm_num

end PureSearch

#print axioms PureSearch.candidate_power_gt_base
#print axioms PureSearch.candidate_value_conjecture_formula
#print axioms PureSearch.uniform_departure_margin_formula
#print axioms PureSearch.three_parameter_values
#print axioms PureSearch.three_periodic_payoff_table
#print axioms PureSearch.three_periodic_actions_and_margins
#print axioms PureSearch.boundary_margin_at_two
#print axioms PureSearch.gap_formula
#print axioms PureSearch.gap_remainder_bounds
#print axioms PureSearch.three_and_four_gap_values
#print axioms PureSearch.pure_mixed_gap_pos
#print axioms PureSearch.gap_remainder_bigO
#print axioms PureSearch.large_m_limits
