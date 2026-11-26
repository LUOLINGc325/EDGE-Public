import CriticalGapEstimates
import OccupancyLowerThreshold

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

noncomputable def thinConstant : ℝ :=
  thresholdDescent / (2 * criticalRatio * Real.log 2)

theorem thinConstant_pos : 0 < thinConstant :=
  div_pos thresholdDescent_pos (mul_pos (mul_pos (by norm_num) criticalRatio_pos) log_two_pos)

noncomputable def thinCandidate (n : ℕ) : ℕ := transitionFloor n + 1

def InThinWindow (n : ℕ) : Prop :=
  (thinCandidate n : ℝ) - transitionLog n ≤ thinConstant / Real.sqrt (n : ℝ)

theorem sqrt_nat_atTop : Tendsto (fun n : ℕ => Real.sqrt (n : ℝ)) atTop atTop := by
  apply tendsto_atTop.2
  intro bound
  have hcast : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop := tendsto_natCast_atTop_atTop
  filter_upwards [tendsto_atTop.1 hcast ((max 0 bound) ^ 2)] with n hn
  exact (le_max_right 0 bound).trans ((Real.le_sqrt (le_max_left 0 bound) (Nat.cast_nonneg n)).mpr hn)

theorem thinCandidate_above_transition (n : ℕ) : transitionLog n < (thinCandidate n : ℝ) := by
  simpa only [thinCandidate, Nat.cast_add, Nat.cast_one] using Nat.lt_floor_add_one (transitionLog n)

theorem thinCandidate_eventually_small {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n : ℕ in atTop, (thinCandidate n : ℝ) ≤ ε * (n : ℝ) := by
  have hcast : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop := tendsto_natCast_atTop_atTop
  filter_upwards [transitionFloor_eventually_small (half_pos hε),
    tendsto_atTop.1 hcast (2 / ε)] with n hfloor hn
  have hscaled := (div_le_iff₀ hε).mp hn
  unfold thinCandidate
  push_cast
  linarith [hfloor, hscaled, mul_comm (n : ℝ) ε]

theorem thin_group_count_atTop :
    Tendsto (fun n : ℕ => n / thinCandidate n) atTop atTop := by
  apply tendsto_atTop.2
  intro bound
  have hden : 0 < ((bound + 1 : ℕ) : ℝ) := by positivity
  filter_upwards [thinCandidate_eventually_small (one_div_pos.mpr hden)] with n h
  have hn : (thinCandidate n : ℝ) ≤ (n : ℝ) / ((bound + 1 : ℕ) : ℝ) := by
    simpa only [one_div, div_eq_mul_inv, mul_comm, mul_one] using h
  have hmul : thinCandidate n * (bound + 1) ≤ n := by
    exact_mod_cast (le_div_iff₀ hden).mp hn
  have hpos : 0 < thinCandidate n := by unfold thinCandidate; omega
  apply (Nat.le_div_iff_mul_le hpos).mpr
  exact (Nat.mul_le_mul_right _ (Nat.le_succ bound)).trans (by simpa only [Nat.mul_comm] using hmul)

theorem thinCandidate_ratio_bound (n : ℕ) (hn : 1 ≤ n) (ht : InThinWindow n)
    (hroot : Real.log 2 * thinConstant ≤ Real.sqrt (n : ℝ)) :
    criticalRatio ≤ (2 : ℝ) ^ thinCandidate n / (n : ℝ) ∧
      (2 : ℝ) ^ thinCandidate n / (n : ℝ) ≤ criticalRatio + thresholdDescent / Real.sqrt (n : ℝ) := by
  let root := Real.sqrt (n : ℝ)
  let gap := (thinCandidate n : ℝ) - transitionLog n
  let arg := Real.log 2 * gap
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hrootPos : 0 < root := Real.sqrt_pos.mpr hnR
  have hgap : 0 ≤ gap := sub_nonneg.mpr (thinCandidate_above_transition n).le
  have harg : 0 ≤ arg := mul_nonneg log_two_pos.le hgap
  have hargBound : arg ≤ (Real.log 2 * thinConstant) / root := by
    change gap ≤ thinConstant / root at ht
    rw [mul_div_assoc]
    exact mul_le_mul_of_nonneg_left ht log_two_pos.le
  have hargOne : arg ≤ 1 := hargBound.trans ((div_le_iff₀ hrootPos).mpr (by simpa only [one_mul] using hroot))
  have hi := (abs_le.mp (Real.abs_exp_sub_one_le (show |arg| ≤ 1 by rwa [abs_of_nonneg harg]))).2
  rw [abs_of_nonneg harg] at hi
  have hchi : 2 * criticalRatio * (Real.log 2 * thinConstant) = thresholdDescent := by
    unfold thinConstant
    field_simp [criticalRatio_pos.ne', log_two_pos.ne']
  have hupper := mul_le_mul_of_nonneg_left (show Real.exp arg ≤ 1 + 2 * arg by linarith only [hi])
    criticalRatio_pos.le
  have hscale := mul_le_mul_of_nonneg_left hargBound (show 0 ≤ (2 : ℝ) * criticalRatio from mul_nonneg (by norm_num) criticalRatio_pos.le)
  have hs : 2 * criticalRatio * (Real.log 2 * thinConstant / root) = thresholdDescent / root := by
    rw [← mul_div_assoc, hchi]
  rw [hs] at hscale
  rw [bins_ratio_from_logGap n (thinCandidate n) hn]
  change criticalRatio ≤ criticalRatio * Real.exp arg ∧ criticalRatio * Real.exp arg ≤ _
  refine ⟨?_, by nlinarith only [hupper, hscale]⟩
  have hnonneg : 1 ≤ Real.exp arg := by rw [← Real.exp_zero]; exact Real.exp_le_exp.mpr harg
  simpa only [mul_one] using mul_le_mul_of_nonneg_left hnonneg criticalRatio_pos.le

end TwoColorNullity.Occupancy
