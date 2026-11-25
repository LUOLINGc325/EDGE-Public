import ExactFrontier
import Mathlib.Tactic.FunProp

/-! A clipped recurrence for the parameter dependence of the same frontier.
Clipping is equivalent to the branch cutoff and makes continuity direct. -/

open scoped BigOperators

namespace FiniteFrontier

noncomputable def clippedFraction (m : ℕ) (R : ℝ) (i : ℕ) : ℝ :=
  max 0 (unitGap (m : ℝ) R i) / (((m : ℝ) - i) * unitDenominator m R i)

noncomputable def clippedLevel (m : ℕ) (R : ℝ) : ℕ → ℝ
  | 0 => 0
  | i + 1 =>
    let q := clippedLevel m R i
    q + clippedFraction m R (i + 1) * (1 - q)

theorem clipped_level_eq_capped {m a : ℕ} {R : ℝ} (b : UnitBranch m R a) :
    ∀ i, clippedLevel m R i = cappedUnitLevel m R a i := by
  intro i
  induction i with
  | zero => simp [clippedLevel, capped_unit_level_zero]
  | succ i ih =>
    have hR : 0 ≤ R + 1 := by have h := b.parameter_positive; linarith
    by_cases hi : i + 1 ≤ a
    · have hia : (i : ℝ) + 1 ≤ a := by exact_mod_cast hi
      have hg : 0 ≤ unitGap (m : ℝ) R ((i : ℝ) + 1) := by
        have h := b.active
        unfold unitGap at *
        linarith only [h, mul_le_mul_of_nonneg_left hia hR]
      rw [clippedLevel, ih]
      simp only [clippedFraction, Nat.cast_succ, max_eq_right hg, cappedUnitLevel,
        min_eq_left hi, min_eq_left (Nat.le_of_succ_le hi), activeUnitLevel, unitFraction]
    have hia : a ≤ i := by omega
    have him : (a : ℝ) + 1 ≤ (i : ℝ) + 1 := by exact_mod_cast Nat.succ_le_succ hia
    have hg : unitGap (m : ℝ) R ((i : ℝ) + 1) ≤ 0 := by
      have h := b.inactive
      unfold unitGap at *
      linarith only [h, mul_le_mul_of_nonneg_left him hR]
    rw [clippedLevel, ih]
    simp [clippedFraction, Nat.cast_succ, max_eq_left hg, cappedUnitLevel,
      min_eq_right hia, min_eq_right (hia.trans (Nat.le_succ i))]

theorem clipped_level_interval {m : ℕ} {R : ℝ} (hm : 0 < m)
    (hR : baselineRobustness (m : ℝ) ≤ R) (i : ℕ) :
    clippedLevel m R i ∈ Set.Icc 0 1 := by
  let b := unit_index_is_branch m R hm hR
  rw [clipped_level_eq_capped b]
  exact capped_unit_level_interval m R _ b.num_jobs_real b.robust b.index_real b.active i

theorem clipped_fraction_interval {m : ℕ} {R : ℝ} (hm : 0 < m)
    (hR : baselineRobustness (m : ℝ) ≤ R) (i : ℕ) (hi : i + 1 < m) :
    clippedFraction m R (i + 1) ∈ Set.Icc 0 1 := by
  have hm' : 0 < (m : ℝ) := by exact_mod_cast hm
  have hi' : (i : ℝ) + 1 < (m : ℝ) := by exact_mod_cast hi
  by_cases h : 0 ≤ unitGap (m : ℝ) R ((i : ℝ) + 1)
  · simpa only [clippedFraction, Nat.cast_succ, max_eq_right h, unitFraction] using
      unit_fraction_interval (m : ℝ) R i hm' hR (by linarith only [show (0 : ℝ) ≤ i by positivity]) hi' h
  simp [clippedFraction, Nat.cast_succ, max_eq_left (le_of_not_ge h)]

theorem clipped_fraction_continuousOn (m : ℕ) (i : ℕ) (hi : i + 1 < m) :
    ContinuousOn (fun R => clippedFraction m R (i + 1))
      (Set.Ici (baselineRobustness (m : ℝ))) := by
  have hm' : 0 < (m : ℝ) := by exact_mod_cast (show 0 < m by omega)
  have hi' : (i : ℝ) + 1 < (m : ℝ) := by exact_mod_cast hi
  have hgap : Continuous (fun R : ℝ => unitGap (m : ℝ) R (i + 1 : ℕ)) := by
    unfold unitGap
    fun_prop
  have hden : Continuous (fun R : ℝ =>
     ((m : ℝ) - (i + 1 : ℕ)) * unitDenominator (m : ℝ) R (i + 1 : ℕ)) := by
    unfold unitDenominator
    fun_prop
  apply (continuous_const.max hgap).continuousOn.div hden.continuousOn
  intro R hR
  rw [Nat.cast_succ]
  exact (mul_pos (sub_pos.mpr hi')
    (unit_denominator_positive _ _ _ hm' hR (by linarith only [show (0 : ℝ) ≤ i by positivity]))).ne'

theorem clipped_level_continuousOn (m : ℕ) :
    ∀ i < m, ContinuousOn (fun R => clippedLevel m R i) (Set.Ici (baselineRobustness (m : ℝ))) := by
  intro i
  induction i with
  | zero => intro _; exact continuous_const.continuousOn
  | succ i ih =>
    intro hi
    have h := ih (Nat.lt_of_succ_lt hi)
    have hfrac := clipped_fraction_continuousOn m i hi
    exact h.add (hfrac.mul (continuous_const.continuousOn.sub h))

theorem frontier_clipped_formula {m : ℕ} {R : ℝ} (hm : 0 < m)
    (hR : baselineRobustness (m : ℝ) ≤ R) :
    unitFrontier m R =
      1 + (∑ i ∈ Finset.range m, ((m : ℝ) - i) * clippedLevel m R i) / triangularCost m := by
  let a := unitIndex m R
  let b := unit_index_is_branch m R hm hR
  let q := cappedUnitLevel (m : ℝ) R a
  let E := unitTailAt m q
  have h := b.plan_marked_cost
  change b.plan.markedCost = triangularCost m * unitFrontier m R at h
  have htime (i : Fin m) : b.plan.time (i.val + 1) = (i.val : ℝ) + 1 + E (i.val + 1) := by
    unfold UnitBranch.plan
    rw [unit_snapshot_time _ _ _ _ (Nat.succ_le_of_lt i.isLt)]
    simp only [E, q, a, unitTailAt, Nat.cast_succ, Nat.succ_eq_add_one]
  unfold SnapshotPlan.markedCost at h
  rw [Finset.sum_congr rfl (fun i _ => htime i), Finset.sum_add_distrib,
    Fin.sum_univ_eq_sum_range (fun i => (i : ℝ) + 1) m, triangular_sum,
    Fin.sum_univ_eq_sum_range (fun i => E (i + 1)) m, sum_range_after_shift] at h
  have hM : E m = 0 := by simp [E, unitTailAt]
  have h0 : E 0 = 0 := by simp [E, unitTailAt, q, capped_unit_level_zero]
  rw [hM, h0, add_zero, sub_zero] at h
  have hQ : 0 < triangularCost (m : ℝ) := by
    have hh := b.num_jobs_real
    unfold triangularCost
    positivity
  have hsum : (∑ i ∈ Finset.range m, ((m : ℝ) - i) * clippedLevel m R i) =
      ∑ i ∈ Finset.range m, E i := by
    apply Finset.sum_congr rfl
    intro i _
    rw [clipped_level_eq_capped b]
    rfl
  rw [hsum]
  have hf := (eq_div_iff hQ.ne').mpr (show
      unitFrontier m R * triangularCost m =
        triangularCost m + (∑ i ∈ Finset.range m, E i) by linarith only [h])
  rw [hf, add_div, div_self hQ.ne']

theorem frontier_continuous (m : ℕ) (hm : 0 < m) :
    ContinuousOn (unitFrontier m) (Set.Ici (baselineRobustness (m : ℝ))) := by
  have hs :
      ContinuousOn (fun R : ℝ => ∑ i ∈ Finset.range m, ((m : ℝ) - i) * clippedLevel m R i)
        (Set.Ici (baselineRobustness (m : ℝ))) := by
    apply continuousOn_finset_sum
    intro i hi
    exact continuous_const.continuousOn.mul (clipped_level_continuousOn m i (Finset.mem_range.mp hi))
  exact (continuous_const.continuousOn.add (hs.div_const (triangularCost m))).congr
    (fun R hR => frontier_clipped_formula hm hR)

theorem denominator_mono (m : ℕ) (i : ℕ) {R S : ℝ} (hRS : R ≤ S) :
    unitDenominator (m : ℝ) R i ≤ unitDenominator (m : ℝ) S i := by
  unfold unitDenominator
  have h := mul_nonneg (sub_nonneg.mpr hRS) (show 0 ≤ (m : ℝ) + 1 + i by positivity)
  nlinarith only [h]

theorem clipped_fraction_antitone {m i : ℕ} {R S : ℝ} (hi : i + 1 < m)
    (hR : baselineRobustness (m : ℝ) ≤ R) (hRS : R ≤ S) :
    clippedFraction m S (i + 1) ≤ clippedFraction m R (i + 1) := by
  have hm : 0 < (m : ℝ) := by exact_mod_cast (show 0 < m by omega)
  have hi' : (i : ℝ) + 1 < (m : ℝ) := by exact_mod_cast hi
  have hmi := sub_pos.mpr hi'
  have hdR := unit_denominator_positive m R ((i : ℝ) + 1) hm hR (by linarith only [show (0 : ℝ) ≤ i by positivity])
  have hdS := unit_denominator_positive m S ((i : ℝ) + 1) hm (hR.trans hRS) (by linarith only [show (0 : ℝ) ≤ i by positivity])
  have hg : unitGap (m : ℝ) S ((i : ℝ) + 1) ≤ unitGap m R ((i : ℝ) + 1) := by
    unfold unitGap
    linarith only [mul_le_mul_of_nonneg_right (add_le_add_right hRS 1)
      (show 0 ≤ (i : ℝ) + 1 by positivity)]
  unfold clippedFraction
  simp only [Nat.cast_succ]
  apply (div_le_div_iff₀ (mul_pos hmi hdS) (mul_pos hmi hdR)).mpr
  exact mul_le_mul (max_le_max_left 0 hg)
    (mul_le_mul_of_nonneg_left (by simpa only [Nat.cast_succ] using denominator_mono m (i + 1) hRS) hmi.le)
    (mul_nonneg hmi.le hdR.le) (le_max_left _ _)

theorem clipped_level_antitone {m : ℕ} {R S : ℝ} (hm : 0 < m)
    (hR : baselineRobustness (m : ℝ) ≤ R) (hRS : R ≤ S) :
    ∀ i < m, clippedLevel m S i ≤ clippedLevel m R i := by
  intro i
  induction i with
  | zero => intro _; exact le_rfl
  | succ i ih =>
    intro hi
    have hq := ih (Nat.lt_of_succ_lt hi)
    have hf := clipped_fraction_antitone hi hR hRS
    have hq₁ := (clipped_level_interval hm (hR.trans hRS) i).2
    have hf₁ := (clipped_fraction_interval hm hR i hi).2
    have hg₁ := mul_le_mul_of_nonneg_right hf (sub_nonneg.mpr hq₁)
    have hg₂ := mul_le_mul_of_nonneg_left hq (sub_nonneg.mpr hf₁)
    simp only [clippedLevel]
    nlinarith only [hg₁, hg₂]

theorem first_level_strict_decrease {m : ℕ} {R S : ℝ} (hm : 1 < m)
    (hR : baselineRobustness (m : ℝ) ≤ R) (hRS : R < S) (hS : S ≤ (m : ℝ)) :
    clippedLevel m S 1 < clippedLevel m R 1 := by
  have hm' : 1 < (m : ℝ) := by exact_mod_cast hm
  have hpos : 0 < (m : ℝ) := by linarith
  have hdR := unit_denominator_positive (m : ℝ) R 1 hpos hR le_rfl
  have hdS := unit_denominator_positive (m : ℝ) S 1 hpos (hR.trans hRS.le) le_rfl
  have hg (T : ℝ) : unitGap (m : ℝ) T 1 = (m : ℝ) - T := by unfold unitGap; ring
  have hd : unitDenominator (m : ℝ) R 1 ≤ unitDenominator (m : ℝ) S 1 :=
    by simpa only [Nat.cast_one] using denominator_mono m 1 hRS.le
  simp only [clippedLevel, zero_add, sub_zero, mul_one, clippedFraction, Nat.cast_one, hg,
    max_eq_right (sub_nonneg.mpr hS), max_eq_right (sub_nonneg.mpr (hRS.le.trans hS))]
  apply (div_lt_div_iff₀ (mul_pos (sub_pos.mpr hm') hdS)
    (mul_pos (sub_pos.mpr hm') hdR)).mpr
  apply (mul_lt_mul_of_pos_right (sub_lt_sub_left hRS (m : ℝ))
    (mul_pos (sub_pos.mpr hm') hdR)).trans_le
  exact mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left hd (sub_nonneg.mpr hm'.le))
    (sub_nonneg.mpr (hRS.le.trans hS))

theorem frontier_strict_antitone (m : ℕ) (hm : 1 < m) :
    StrictAntiOn (unitFrontier m) (Set.Icc (baselineRobustness (m : ℝ)) (m : ℝ)) := by
  intro R hR S hS hlt
  have hm₀ : 0 < m := by omega
  have hQ : 0 < triangularCost (m : ℝ) := by
    have hh : 0 < (m : ℝ) := by exact_mod_cast hm₀
    unfold triangularCost
    positivity
  rw [frontier_clipped_formula hm₀ hR.1, frontier_clipped_formula hm₀ hS.1]
  apply add_lt_add_left
  apply (div_lt_div_iff_of_pos_right hQ).mpr
  apply Finset.sum_lt_sum
  · intro i hi
    have hmi : 0 ≤ (m : ℝ) - i := sub_nonneg.mpr (by exact_mod_cast (Finset.mem_range.mp hi).le)
    exact mul_le_mul_of_nonneg_left
      (clipped_level_antitone hm₀ hR.1 hlt.le i (Finset.mem_range.mp hi)) hmi
  · refine ⟨1, Finset.mem_range.mpr hm, ?_⟩
    have hmi : 0 < (m : ℝ) - (1 : ℕ) := by exact sub_pos.mpr (by exact_mod_cast hm)
    exact mul_lt_mul_of_pos_left (first_level_strict_decrease hm hR.1 hlt hS.2) hmi

end FiniteFrontier
