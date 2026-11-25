import SnapshotExecution

/-! A prediction-dependent feasible plan gives a deterministic policy.
The proof identifies the first switched state from observable events. -/

open scoped BigOperators

namespace FiniteFrontier.SnapshotPlan

variable {n : ℕ} {y : Fin n → ℝ} (p : SnapshotPlan y)
variable (x z : PositiveSizes (Fin n)) (hy : ∀ i, 0 < y i)

def UnchangedObservations (t : ℝ) : Prop :=
  ∀ i, if p.executedCompletion x i ≤ t then z.val i = x.val i
    else p.executedService x t i < z.val i

include hy

/-- No altered instance with the same observed prefix can need a switch strictly
before both that prefix and the original switch point. -/
theorem alternate_switch_not_earlier (t : ℝ)
    (hobs : p.UnchangedObservations x z t) :
    min t (p.switchTime x) ≤ p.switchTime z := by
  by_contra! h
  let s := p.switchTime z
  have hts : s ≤ t := (h.trans_le (min_le_left _ _)).le
  have hsx : s < p.switchTime x := h.trans_le (min_le_right _ _)
  have hs : 0 ≤ s := p.switch_time_nonneg z hy
  obtain ⟨i, hwrong, hcut⟩ := p.switch_event z hy (hsx.trans_le (p.switch_time_le_end x))
  change p.plannedService s i = min (z.val i) (y i) at hcut
  have hsvc : p.executedService x s i = p.plannedService s i :=
    congrFun (p.executed_service_before x s hsx.le) i
  rcases lt_or_gt_of_ne hwrong with hearly | hlate
  · rw [min_eq_left hearly.le] at hcut
    have hfinish : p.executedCompletion x i ≤ t := by
      by_contra hn
      have hz := hobs i
      rw [if_neg hn] at hz
      have hm := p.executed_service_mono x i s t hts
      exact (not_lt_of_ge (hm.trans' (hsvc.trans hcut).ge)) hz
    have hzx : z.val i = x.val i := by simpa only [if_pos hfinish] using hobs i
    have hne : x.val i ≠ y i := by rw [← hzx]; exact hwrong
    have hx := p.no_wrong_threshold_before_switch x hy s hs hsx i hne
    rw [← hzx, min_eq_left hearly.le, hcut] at hx
    exact (lt_irrefl _) hx
  rw [min_eq_right hlate.le] at hcut
  have heq : x.val i = y i := by
    by_contra hne
    have hx := p.no_wrong_threshold_before_switch x hy s hs hsx i hne
    exact (not_lt_of_ge (min_le_right _ _)) (hcut ▸ hx)
  have hfinish : p.executedCompletion x i ≤ t :=
    ((p.executed_complete_iff x hy i s hs).mp (hsvc.trans (hcut.trans heq.symm))).trans hts
  have hzx : z.val i = x.val i := by simpa only [if_pos hfinish] using hobs i
  exact hwrong (hzx.trans heq)

theorem alternate_switch_eq_after (t : ℝ) (ht : p.switchTime x ≤ t)
    (hobs : p.UnchangedObservations x z t) :
    p.switchTime z = p.switchTime x := by
  have hlo := p.alternate_switch_not_earlier x z hy t hobs
  rw [min_eq_right ht] at hlo
  apply le_antisymm _ hlo
  by_cases hend : p.switchTime x = p.time n
  · rw [hend]
    exact p.switch_time_le_end z
  let s := p.switchTime x
  have hs : 0 ≤ s := p.switch_time_nonneg x hy
  have href : p.executedService x s = p.plannedService s :=
    p.executed_service_before x s le_rfl
  obtain ⟨i, hi, hcut⟩ := p.switch_event x hy
    (lt_of_le_of_ne (p.switch_time_le_end x) hend)
  change p.plannedService s i = min (x.val i) (y i) at hcut
  have hz (h : x.val i < y i) : z.val i = x.val i := by
    have hdone : p.executedCompletion x i ≤ s :=
      (p.executed_complete_iff x hy i s hs).mp
        ((congrFun href i).trans (hcut.trans (min_eq_left h.le)))
    simpa only [if_pos (hdone.trans ht)] using hobs i
  have hlate (h : y i < x.val i) : y i < z.val i := by
    by_cases hdone : p.executedCompletion x i ≤ t
    · have hx : z.val i = x.val i := by simpa only [if_pos hdone] using hobs i
      rwa [hx]
    have hwork : y i ≤ p.executedService x t i := by
      rw [← min_eq_right h.le, ← hcut, ← congrFun href i]
      exact p.executed_service_mono x i s t ht
    exact hwork.trans_lt (by simpa only [if_neg hdone] using hobs i)
  have hcut' : z.val i ≠ y i ∧ p.plannedService s i = min (z.val i) (y i) := by
    rcases lt_or_gt_of_ne hi with h | h
    · rw [hz h]
      exact ⟨hi, hcut⟩
    · exact ⟨(hlate h).ne', hcut.trans ((min_eq_right h.le).trans (min_eq_right (hlate h).le).symm)⟩
  calc
    p.switchTime z ≤ p.triggerTime z i := p.switch_time_le_trigger z i
    _ ≤ s := by
      rw [triggerTime, if_neg hcut'.1]
      exact (p.first_hit_iff i _ (mismatch_level_pos z hy i) s hs).mpr hcut'.2.ge

/-- Agreement through an observed prefix of the run. Predictions and completion
information determine the same service even for alternative future processing times. -/
theorem execute_prefix (t : ℝ) (hobs : p.UnchangedObservations x z t)
    (u : ℝ) (hu : 0 ≤ u) (hut : u ≤ t) :
    p.executedService z u = p.executedService x u := by
  rcases le_total t (p.switchTime x) with htx | hxt
  · have hz := p.alternate_switch_not_earlier x z hy t hobs
    rw [min_eq_left htx] at hz
    rw [p.executed_service_before z u (hut.trans hz), p.executed_service_before x u (hut.trans htx)]
  have hτ := p.alternate_switch_eq_after x z hy t hxt hobs
  rcases le_total u (p.switchTime x) with huτ | hτu
  · rw [p.executed_service_before z u (hτ.symm ▸ huτ), p.executed_service_before x u huτ]
  have hbase : p.switchService z = p.switchService x := by unfold switchService; rw [hτ]
  let rx := p.residual x
  let rz := p.residual z
  let s := p.switchTime x
  have hobs' (i : Fin n) : if roundRobinService rx (t - s) i = rx i then rz i = rx i
      else roundRobinService rx (t - s) i < rz i := by
    have hs := p.executed_service_after x t hxt i
    have hfinish : roundRobinService rx (t - s) i = rx i ↔ p.executedCompletion x i ≤ t := by
      rw [← p.executed_complete_iff x hy i t (hu.trans hut), hs]
      dsimp only [rx, residual]
      constructor <;> intro h <;> linarith only [h]
    by_cases hdone : p.executedCompletion x i ≤ t
    · rw [if_pos (hfinish.mpr hdone)]
      have h := hobs i
      rw [if_pos hdone] at h
      dsimp only [rx, rz, residual]
      rw [hbase, h]
    · rw [if_neg (fun h => hdone (hfinish.mp h))]
      have h := hobs i
      rw [if_neg hdone, hs] at h
      dsimp only [rz, residual]
      rw [hbase]
      linarith only [h]
  have hrr := round_robin_prefix rx rz (p.residual_nonneg x) (p.residual_nonneg z)
    (u - s) (t - s) (sub_nonneg.mpr hτu) (sub_le_sub_right hut _) hobs'
  ext i
  rw [p.executed_service_after z u (hτ.symm ▸ hτu), p.executed_service_after x u hτu, hτ, hbase]
  exact congrArg (p.switchService x i + ·) (congrFun hrr i)

end FiniteFrontier.SnapshotPlan
