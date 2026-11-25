import PublishedFrontier
import Mathlib.Tactic.FinCases

/-! The five-job witness and the discontinuity at a vanishing early prediction error. -/

open scoped BigOperators Topology
open Filter

namespace FiniteFrontier

theorem five_job_branch : UnitBranch 5 (9 / 5) 2 := by
  constructor <;> norm_num [baselineRobustness, unitGap]

theorem five_job_levels :
    activeUnitLevel 5 (9 / 5) 1 = 8 / 13 ∧
      activeUnitLevel 5 (9 / 5) 2 = 197 / 312 := by
  constructor <;> norm_num [activeUnitLevel, unitFraction, unitDenominator, unitGap]

theorem five_job_value : unitFrontier 5 (9 / 5) = 17 / 12 := by
  have h := equivalent_branch_value
    (unit_index_is_branch 5 (9 / 5) (by decide) five_job_branch.robust) five_job_branch
  unfold unitFrontier
  rw [h]
  norm_num [unitValue, triangularCost, activeUnitTailSum, Finset.sum_range_succ,
    activeUnitTail, activeUnitLevel, unitFraction, unitGap, unitDenominator]

noncomputable def fiveEarlySizes (ε : ℝ) : Fin 5 → ℝ := Fin.cons (1 - ε) (fun _ : Fin 4 => 1)

noncomputable def fiveActual (ε : ℝ) (hε : ε < 1) : PositiveSizes (Fin 5) :=
  ⟨fiveEarlySizes ε, fun i => Fin.cases (sub_pos.mpr hε) (fun _ => zero_lt_one) i⟩

noncomputable def fiveEarlyTime (ε : ℝ) : ℝ := (45 / 13) * (1 - ε)

noncomputable def fiveEarlyRatio (ε : ℝ) : ℝ := ((305 - 97 * ε) / 13) / (15 - 5 * ε)

theorem five_first_mark_time : five_job_branch.plan.time 1 = 45 / 13 := by
  unfold UnitBranch.plan
  rw [unit_snapshot_time _ _ _ _ (show 1 ≤ 5 by decide)]
  norm_num [cappedUnitLevel, five_job_levels.1]

theorem five_first_phase (t : ℝ) (ht : 0 ≤ t) (hT : t ≤ 45 / 13) :
    let p := five_job_branch.plan
    p.plannedService t 0 = (13 / 45) * t ∧
      ∀ i : Fin 4, p.plannedService t i.succ = (8 / 45) * t := by
  let p := five_job_branch.plan
  have hfrac : p.phaseFraction 0 t = (13 / 45) * t := by
    unfold SnapshotPlan.phaseFraction
    rw [p.time_zero, five_first_mark_time, sub_zero, sub_zero]
    have h0 : 0 ≤ t / (45 / 13 : ℝ) := div_nonneg ht (by norm_num)
    have h1 : t / (45 / 13 : ℝ) ≤ 1 := (div_le_one (by norm_num)).mpr hT
    rw [max_eq_right h0, min_eq_right h1]
    ring
  have h0 : p.time 0 ≤ t := by rw [p.time_zero]; exact ht
  have h1 : t ≤ p.time (0 + 1) := by rw [five_first_mark_time]; exact hT
  change p.plannedService t 0 = (13 / 45) * t ∧
    ∀ i : Fin 4, p.plannedService t i.succ = (8 / 45) * t
  rw [p.planned_service_on_phase 0 (by decide) t h0 h1, hfrac]
  constructor
  · simp [SnapshotPlan.interpolation, p.initial, p, UnitBranch.plan, unitSnapshotPlan,
      capped_unit_level_zero]
  intro i
  have hi : ¬ i.succ.val < 1 := by simp
  simp [SnapshotPlan.interpolation, p.initial, p, UnitBranch.plan, unitSnapshotPlan, hi,
    cappedUnitLevel, five_job_levels.1]
  simp only [activeUnitLevel]
  ring

theorem five_early_hit (ε : ℝ) (hε₀ : 0 < ε) (hε₁ : ε < 1) :
    five_job_branch.plan.firstHit 0 (1 - ε) = fiveEarlyTime ε := by
  let p := five_job_branch.plan
  let t := fiveEarlyTime ε
  have ht : 0 ≤ t := mul_nonneg (by norm_num) (sub_nonneg.mpr hε₁.le)
  have hT : t ≤ 45 / 13 := by unfold t fiveEarlyTime; nlinarith only [hε₀]
  have hv : 0 < 1 - ε ∧ 1 - ε ≤ (fun _ : Fin 5 => (1 : ℝ)) 0 :=
    ⟨sub_pos.mpr hε₁, sub_le_self _ hε₀.le⟩
  have hxt : p.plannedService t 0 = 1 - ε := by
    rw [(five_first_phase t ht hT).1]
    unfold t fiveEarlyTime
    ring
  have hf := (p.first_hit_iff 0 (1 - ε) hv t ht).mpr hxt.ge
  apply le_antisymm hf
  have hl := p.first_hit_exact 0 (1 - ε) hv
  have hh := (five_first_phase _ (p.first_hit_pos 0 _ hv).le (hf.trans hT)).1
  rw [hh] at hl
  unfold t fiveEarlyTime
  linarith only [hl]

theorem five_early_switch (ε : ℝ) (hε₀ : 0 < ε) (hε₁ : ε < 1) :
    five_job_branch.plan.switchTime (fiveActual ε hε₁) = fiveEarlyTime ε := by
  let p := five_job_branch.plan
  let x := fiveActual ε hε₁
  let t := fiveEarlyTime ε
  have hx₀ : x.val 0 = 1 - ε := rfl
  have hne : x.val 0 ≠ 1 := by rw [hx₀]; linarith only [hε₀]
  have hs : p.triggerTime x 0 = t := by
    unfold SnapshotPlan.triggerTime
    rw [if_neg hne, hx₀, min_eq_left (sub_le_self _ hε₀.le)]
    exact five_early_hit ε hε₀ hε₁
  have hle : t ≤ p.time 5 := by
    calc
      t ≤ 45 / 13 := by unfold t fiveEarlyTime; linarith only [hε₀]
      _ = p.time 1 := five_first_mark_time.symm
      _ ≤ _ := p.time_monotone (by decide)
  apply le_antisymm ((p.switch_time_le_trigger x 0).trans_eq hs)
  have hm := p.switch_time_mem x
  rw [SnapshotPlan.triggerTimes, Finset.mem_insert] at hm
  rcases hm with he | he
  · rwa [he]
  obtain ⟨i, _, he⟩ := Finset.mem_image.mp he
  rw [← he]
  refine Fin.cases (by rw [hs]) (fun j => ?_) i
  have heq : x.val j.succ = 1 := rfl
  rw [SnapshotPlan.triggerTime, if_pos heq]
  exact hle

theorem five_early_offline_cost (ε : ℝ) (hε : 0 ≤ ε) :
    frozenCost (fiveEarlySizes ε) = 15 - 5 * ε := by
  have hsmall : 1 - ε ≤ (1 : ℝ) := sub_le_self _ hε
  unfold frozenCost fiveEarlySizes
  simp only [Fin.sum_univ_succ, Fin.cons_zero, Fin.cons_succ, min_self,
    min_eq_left hsmall, min_eq_right hsmall]
  norm_num
  ring

theorem five_early_completion_cost (ε : ℝ) (hε₀ : 0 < ε) (hε₁ : ε < 1) :
    (five_job_branch.plan.execute (fiveActual ε hε₁) (fun _ => zero_lt_one)).cost =
      (305 - 97 * ε) / 13 := by
  let p := five_job_branch.plan
  let x := fiveActual ε hε₁
  let τ := fiveEarlyTime ε
  let ρ := (5 + 8 * ε) / 13
  have hτ : p.switchTime x = τ := five_early_switch ε hε₀ hε₁
  have ht : 0 ≤ τ := mul_nonneg (by norm_num) (sub_nonneg.mpr hε₁.le)
  have hT : τ ≤ 45 / 13 := by unfold τ fiveEarlyTime; linarith only [hε₀]
  have hx₀ : x.val 0 = 1 - ε := rfl
  have hx (i : Fin 4) : x.val i.succ = 1 := rfl
  have hb₀ : p.switchService x 0 = x.val 0 := by
    unfold SnapshotPlan.switchService
    rw [hτ, (five_first_phase τ ht hT).1, hx₀]
    unfold τ fiveEarlyTime
    ring
  have hb (i : Fin 4) : p.switchService x i.succ = 1 - ρ := by
    unfold SnapshotPlan.switchService
    rw [hτ, (five_first_phase τ ht hT).2 i]
    unfold τ fiveEarlyTime ρ
    ring
  have hρ : 0 < ρ := by unfold ρ; positivity
  have hres₀ : p.residual x 0 = 0 := sub_eq_zero.mpr hb₀.symm
  have hres (i : Fin 4) : p.residual x i.succ = ρ := by unfold SnapshotPlan.residual; rw [hx, hb]; ring
  have hclock : roundRobinClock (p.residual x) ρ = 4 * ρ := by
    unfold roundRobinClock roundRobinIncrement
    rw [Fin.sum_univ_succ, hres₀]
    simp [hres, min_eq_left hρ.le]
  have hC₀ : p.executedCompletion x 0 = τ := by
    rw [SnapshotPlan.executedCompletion, if_pos hb₀, hx₀]
    exact five_early_hit ε hε₀ hε₁
  have hC (i : Fin 4) : p.executedCompletion x i.succ = τ + 4 * ρ := by
    have hne : p.switchService x i.succ ≠ x.val i.succ := by rw [hb, hx]; linarith only [hρ]
    rw [SnapshotPlan.executedCompletion, if_neg hne, hτ, hres, hclock]
  change (∑ i, p.executedCompletion x i) = _
  rw [Fin.sum_univ_succ, hC₀]
  simp only [hC]
  norm_num
  unfold τ ρ fiveEarlyTime
  ring

theorem five_early_exact_ratio (ε : ℝ) (hε₀ : 0 < ε) (hε₁ : ε < 1) :
    (five_job_branch.plan.execute (fiveActual ε hε₁) (fun _ => zero_lt_one)).cost /
      frozenCost (fiveEarlySizes ε) = fiveEarlyRatio ε := by
  rw [five_early_completion_cost ε hε₀ hε₁, five_early_offline_cost ε hε₀.le]
  rfl

theorem five_early_ratio_limit :
    Tendsto fiveEarlyRatio (𝓝[>] (0 : ℝ)) (𝓝 (61 / 39)) := by
  have hcont : ContinuousAt fiveEarlyRatio (0 : ℝ) := by
    unfold fiveEarlyRatio
    apply ContinuousAt.div
    · fun_prop
    · fun_prop
    · norm_num
  have he : fiveEarlyRatio 0 = 61 / 39 := by norm_num [fiveEarlyRatio]
  rw [← he]
  exact hcont.tendsto.mono_left nhdsWithin_le_nhds

theorem five_early_jump : (61 / 39 : ℝ) - unitFrontier 5 (9 / 5) = 23 / 156 := by
  rw [five_job_value]
  norm_num

noncomputable def fiveActualRatio (ε : ℝ) : ℝ :=
  if h : ε < 1 then
    (five_job_branch.plan.execute (fiveActual ε h) (fun _ => zero_lt_one)).cost /
      frozenCost (fiveEarlySizes ε)
  else 0

theorem five_actual_limit :
    Tendsto fiveActualRatio (𝓝[>] (0 : ℝ)) (𝓝 (61 / 39)) := by
  have hpos : ∀ᶠ ε : ℝ in 𝓝[>] (0 : ℝ), 0 < ε := self_mem_nhdsWithin
  have hlt : ∀ᶠ ε : ℝ in 𝓝[>] (0 : ℝ), ε < 1 :=
    nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))
  apply five_early_ratio_limit.congr'
  filter_upwards [hpos, hlt] with ε hε hl
  rw [fiveActualRatio, dif_pos hl, five_early_exact_ratio ε hε hl]

/-- Li, Christianson and Li's finite maximum for the mTSS robustness guarantee
evaluated at the manuscript's five-job comparison point. -/
noncomputable def mTSSCandidate (n : ℕ) (excess : ℝ) (s : ℕ) : ℝ :=
  let margin := ((n : ℝ) - 1) / ((n : ℝ) + 1) - excess
  (2 * excess * (n : ℝ) ^ 2 + margin * s * (2 * (n : ℝ) + 1 - s)) /
    (excess * n * ((n : ℝ) + 1) + margin * s * ((s : ℝ) + 1))

theorem five_mTSS_comparison :
    IsGreatest (Set.range fun i : Fin 5 => mTSSCandidate 5 (5 / 12) (i.val + 1)) (38 / 21) ∧
      (9 / 5 : ℝ) < 38 / 21 := by
  constructor
  · constructor
    · exact ⟨1, by norm_num [mTSSCandidate]⟩
    · intro t ht
      obtain ⟨i, rfl⟩ := ht
      fin_cases i <;> norm_num [mTSSCandidate]
  · norm_num

end FiniteFrontier
