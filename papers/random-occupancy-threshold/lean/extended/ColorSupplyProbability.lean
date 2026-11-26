import ColorSupplyTail
import OccupancyUpperThreshold

open Filter
open scoped BigOperators Topology

namespace TwoColorNullity.Occupancy

def SomeColorDeficit (n : ℕ) (bits : BitProfile n (3 * n - 1)) : Prop :=
  ∃ owners : Finset (Fin n), owners.card < largeSetThreshold n ∧ n.log2 ≤ owners.card ∧
    ∃ owner : ↥owners, ∃ color : Bool,
      (restrictedOddCount (designatedColorBins owner color) (signature (profileTag bits) owners) : ℝ) <
        colorSupplyCoefficient * (n : ℝ) / 2

noncomputable def colorDecayRate : ℝ := colorSupplyCoefficient ^ 2 / 24

theorem colorDecayRate_pos : 0 < colorDecayRate := by
  unfold colorDecayRate
  have h := colorSupplyCoefficient_pos
  positivity

private theorem owner_count_probability_bound (n : ℕ) (hn : 8 ≤ n)
    (ht : largeSetThreshold n ≤ n) (hlarge : 50 ≤ occupancyCurve (1 / 2) * (n : ℝ)) :
    finiteProbability (SomeColorDeficit n) ≤ (n : ℝ) ^ (largeSetThreshold n + 1) *
      (2 * (n : ℝ) * Real.exp (-(colorDecayRate * (n : ℝ)))) := by
  classical
  let t := largeSetThreshold n
  let q := Real.exp (-(colorDecayRate * (n : ℝ)))
  let fail (owners : Finset (Fin n)) (check : ↥owners × Bool) (bits : BitProfile n (3 * n - 1)) :=
    (restrictedOddCount (designatedColorBins check.1 check.2) (signature (profileTag bits) owners) : ℝ) <
      colorSupplyCoefficient * (n : ℝ) / 2
  let event (owners : Finset (Fin n)) (bits : BitProfile n (3 * n - 1)) :=
    n.log2 ≤ owners.card ∧ ∃ owner : ↥owners, ∃ color : Bool, fail owners (owner, color) bits
  apply bounded_owner_group_union n t (by omega) ht (2 * (n : ℝ) * q) (by positivity) event
  intro owners hnear
  by_cases hrange : n.log2 ≤ owners.card
  · have hdom : finiteProbability (event owners) ≤
        finiteProbability (fun bits => ∃ check ∈ (Finset.univ : Finset (↥owners × Bool)), fail owners check bits) := by
      apply finiteProbability_mono
      rintro bits ⟨_, owner, color, hf⟩
      exact ⟨(owner, color), Finset.mem_univ _, hf⟩
    refine hdom.trans ((finiteProbability_union_bound (witnesses := Finset.univ) (fail owners)).trans ?_)
    have hc : (Fintype.card (↥owners × Bool) : ℝ) ≤ 2 * (n : ℝ) := by
      have hcard : owners.card ≤ n := by simpa using Finset.card_le_univ owners
      have h : Fintype.card (↥owners × Bool) ≤ 2 * n := by
        simpa [Fintype.card_prod, Nat.mul_comm] using Nat.mul_le_mul_left 2 hcard
      exact_mod_cast h
    calc
      _ ≤ ∑ _p : ↥owners × Bool, q := by
        apply Finset.sum_le_sum
        intro check _
        have htail := colorDeficit_fixed_group_tail n owners hn hrange hlarge check.1 check.2
        change finiteProbability (fail owners check) ≤ q
        unfold q colorDecayRate
        convert htail using 2
        ring
      _ = (Fintype.card (↥owners × Bool) : ℝ) * q := by simp [Finset.sum_const, nsmul_eq_mul]
      _ ≤ _ := mul_le_mul_of_nonneg_right hc (Real.exp_pos _).le
  · have hf : event owners = fun _ => False := by
      funext bits
      apply propext
      exact ⟨fun h => hrange h.1, False.elim⟩
    rw [hf]
    have hz : finiteProbability (fun _ : BitProfile n (3 * n - 1) => False) = 0 := by
      unfold finiteProbability
      simp
    rw [hz]
    positivity

theorem log_count_over_n_zero :
    Tendsto (fun n : ℕ => (Real.log (n : ℝ)) ^ 2 / (n : ℝ)) atTop (𝓝 0) := by
  have h := (isLittleO_log_rpow_rpow_atTop 2 (show (0 : ℝ) < 1 by norm_num)).tendsto_div_nhds_zero
  simpa only [Real.rpow_one, Real.rpow_two, Function.comp_apply] using
    h.comp (tendsto_natCast_atTop_atTop : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop)

private theorem cutoff_exponent_eventually_below {c : ℝ} (hc : 0 < c) :
    ∀ᶠ n : ℕ in atTop, ((largeSetThreshold n + 2 : ℕ) : ℝ) * Real.log (n : ℝ) ≤ c * (n : ℝ) := by
  have hlimit := (log_count_over_n_zero.div_const (Real.log 2)).add (real_log_over_n_zero.const_mul (9 : ℝ))
  simp only [zero_div, mul_zero, add_zero] at hlimit
  filter_upwards [eventually_ge_atTop (1 : ℕ), hlimit.eventually (gt_mem_nhds hc)] with n hn hs
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hl0 : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg (by exact_mod_cast hn)
  have ht : ((largeSetThreshold n + 2 : ℕ) : ℝ) ≤ binaryLog n + 9 := by
    push_cast
    linarith only [threshold_le_binaryLog_add n (by omega)]
  have hm := mul_le_mul_of_nonneg_right ht hl0
  have he : (binaryLog n + 9) * Real.log (n : ℝ) =
      ((Real.log (n : ℝ)) ^ 2 / (n : ℝ) / Real.log 2 + 9 * (Real.log (n : ℝ) / (n : ℝ))) * (n : ℝ) := by
    unfold binaryLog
    field_simp [hnR.ne', log_two_pos.ne']
  rw [he] at hm
  exact hm.trans (mul_le_mul_of_nonneg_right hs.le hnR.le)

theorem any_color_deficit_probability_zero :
    Tendsto (fun n : ℕ => finiteProbability (SomeColorDeficit n)) atTop (𝓝 0) := by
  have hb := polynomial_exponential_decay 0 (show 0 < colorDecayRate / 2 by
    exact div_pos colorDecayRate_pos (by norm_num))
  simp only [pow_zero, one_mul] at hb
  have ho := hb.const_mul (2 : ℝ)
  rw [mul_zero] at ho
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity) ?_ ho
  have hp := occupancyCurve_pos (1 / 2) (by norm_num)
  have hcast : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop := tendsto_natCast_atTop_atTop
  filter_upwards [eventually_ge_atTop (8 : ℕ), largeSetThreshold_eventually_le,
    tendsto_atTop.1 hcast (50 / occupancyCurve (1 / 2)),
    cutoff_exponent_eventually_below (show 0 < colorDecayRate / 2 by
      exact div_pos colorDecayRate_pos (by norm_num))] with n hn ht hratio he
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hlarge : 50 ≤ occupancyCurve (1 / 2) * (n : ℝ) := by
    simpa only [mul_comm] using (div_le_iff₀ hp).mp hratio
  have h := owner_count_probability_bound n hn ht hlarge
  refine h.trans ?_
  have heq :
      (n : ℝ) ^ (largeSetThreshold n + 1) * (2 * (n : ℝ) * Real.exp (-(colorDecayRate * (n : ℝ)))) =
        2 * Real.exp (((largeSetThreshold n + 2 : ℕ) : ℝ) * Real.log (n : ℝ) - colorDecayRate * (n : ℝ)) := by
    rw [Real.exp_sub, Real.exp_nat_mul, Real.exp_log hnR, Real.exp_neg, div_eq_mul_inv]
    change _ = 2 * ((n : ℝ) ^ ((largeSetThreshold n + 1) + 1) * _)
    rw [pow_succ (n : ℝ) (largeSetThreshold n + 1)]
    ring
  rw [heq]
  exact mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr (by linarith only [he])) (by norm_num)

end TwoColorNullity.Occupancy
