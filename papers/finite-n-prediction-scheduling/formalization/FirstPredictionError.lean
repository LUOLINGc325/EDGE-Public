import SnapshotTrajectory
import Mathlib.Topology.Order.Compact

/-! First planned hitting times and the observable change to round-robin. -/

open scoped BigOperators

namespace FiniteFrontier.SnapshotPlan

variable {n : ℕ} {y : Fin n → ℝ} (p : SnapshotPlan y)

def hitSet (i : Fin n) (q : ℝ) : Set ℝ :=
  Set.Icc 0 (p.time n) ∩ {t | q ≤ p.plannedService t i}

theorem exists_planned_hit (i : Fin n) (q : ℝ) (h : 0 < q ∧ q ≤ y i) :
    ∃ t, IsLeast (p.hitSet i q) t := by
  have hc : IsClosed {t | q ≤ p.plannedService t i} :=
    isClosed_le continuous_const (p.planned_service_continuous i)
  have hcomp : IsCompact (p.hitSet i q) := isCompact_Icc.inter_right hc
  refine hcomp.exists_isLeast ⟨p.time n, ⟨p.time_nonneg n, le_rfl⟩, ?_⟩
  rw [Set.mem_setOf_eq, p.planned_service_after_last _ le_rfl]
  exact h.2

/-- Earliest time at which the precomputed planned trajectory attains the given work. -/
noncomputable def firstHit (i : Fin n) (q : ℝ) : ℝ :=
  if h : 0 < q ∧ q ≤ y i then Classical.choose (p.exists_planned_hit i q h) else 0

theorem first_hit_least (i : Fin n) (q : ℝ) (h : 0 < q ∧ q ≤ y i) :
    IsLeast (p.hitSet i q) (p.firstHit i q) := by
  rw [firstHit, dif_pos h]
  exact Classical.choose_spec (p.exists_planned_hit i q h)

theorem first_hit_pos (i : Fin n) (q : ℝ) (h : 0 < q ∧ q ≤ y i) :
    0 < p.firstHit i q := by
  have hp := (p.first_hit_least i q h).1
  refine lt_of_le_of_ne hp.1.1 (fun he => ?_)
  have hq : q ≤ p.plannedService (p.firstHit i q) i := hp.2
  rw [← he, p.planned_service_zero, Pi.zero_apply] at hq
  exact (not_le_of_gt h.1) hq

theorem first_hit_before_mark (i : Fin n) (q : ℝ) (h : 0 < q ∧ q ≤ y i) :
    p.firstHit i q ≤ p.time (i.val + 1) := by
  apply (p.first_hit_least i q h).2
  refine ⟨⟨p.time_nonneg _, p.time_monotone (Nat.succ_le_of_lt i.isLt)⟩, ?_⟩
  rw [Set.mem_setOf_eq, p.planned_service_hit_by_mark]
  exact h.2

theorem first_hit_iff (i : Fin n) (q : ℝ) (h : 0 < q ∧ q ≤ y i)
    (t : ℝ) (ht : 0 ≤ t) :
    p.firstHit i q ≤ t ↔ q ≤ p.plannedService t i := by
  have hleast := p.first_hit_least i q h
  constructor
  · exact fun ht' => hleast.1.2.trans (p.planned_service_mono i ht')
  · intro hlevel
    rcases le_total t (p.time n) with htn | htn
    · exact hleast.2 ⟨⟨ht, htn⟩, hlevel⟩
    · exact hleast.1.1.2.trans htn

theorem first_hit_exact (i : Fin n) (q : ℝ) (h : 0 < q ∧ q ≤ y i) :
    p.plannedService (p.firstHit i q) i = q := by
  have hleast := p.first_hit_least i q h
  have htarget : q ∈ Set.Icc (p.plannedService 0 i) (p.plannedService (p.firstHit i q) i) := by
    rw [p.planned_service_zero, Pi.zero_apply]
    exact ⟨h.1.le, hleast.1.2⟩
  obtain ⟨t, ht, he⟩ := intermediate_value_Icc hleast.1.1.1
    (p.planned_service_continuous i).continuousOn htarget
  have hfirst : p.firstHit i q ≤ t := (p.first_hit_iff i q h t ht.1).mpr he.ge
  rwa [le_antisymm hfirst ht.2]

variable (x : PositiveSizes (Fin n))

theorem mismatch_level_pos (hy : ∀ i, 0 < y i) (i : Fin n) :
    0 < min (x.val i) (y i) ∧ min (x.val i) (y i) ≤ y i :=
  ⟨lt_min (x.property i) (hy i), min_le_right _ _⟩

/-- A wrong prediction is detectable when the plan first delivers the smaller of
the predicted and actual size. Exact predictions place no switch event. -/
noncomputable def triggerTime (i : Fin n) : ℝ :=
  if x.val i = y i then p.time n else p.firstHit i (min (x.val i) (y i))

noncomputable def triggerTimes : Finset ℝ :=
  insert (p.time n) (Finset.univ.image (p.triggerTime x))

theorem trigger_times_nonempty : (p.triggerTimes x).Nonempty :=
  ⟨p.time n, by simp [triggerTimes]⟩

noncomputable def switchTime : ℝ :=
  (p.triggerTimes x).min' (p.trigger_times_nonempty x)

theorem switch_time_mem : p.switchTime x ∈ p.triggerTimes x := Finset.min'_mem _ _

theorem switch_time_le_end : p.switchTime x ≤ p.time n :=
  Finset.min'_le _ _ (by simp [triggerTimes])

theorem switch_time_le_trigger (i : Fin n) : p.switchTime x ≤ p.triggerTime x i :=
  Finset.min'_le _ _ (Finset.mem_insert_of_mem (Finset.mem_image_of_mem _ (Finset.mem_univ i)))

theorem switch_time_nonneg (hy : ∀ i, 0 < y i) : 0 ≤ p.switchTime x := by
  have h := p.switch_time_mem x
  rw [triggerTimes, Finset.mem_insert] at h
  rcases h with h | h
  · rw [h]
    exact p.time_nonneg n
  obtain ⟨i, _, he⟩ := Finset.mem_image.mp h
  rw [← he, triggerTime]
  split
  · exact p.time_nonneg n
  · exact (p.first_hit_pos i _ (mismatch_level_pos x hy i)).le

theorem switch_event (hy : ∀ i, 0 < y i) (h : p.switchTime x < p.time n) :
    ∃ i, x.val i ≠ y i ∧ p.plannedService (p.switchTime x) i = min (x.val i) (y i) := by
  have hm := p.switch_time_mem x
  rw [triggerTimes, Finset.mem_insert] at hm
  rcases hm with hm | hm
  · exact ((ne_of_lt h) hm).elim
  obtain ⟨i, _, he⟩ := Finset.mem_image.mp hm
  have hne : x.val i ≠ y i := by
    intro hx
    have ht : p.triggerTime x i = p.time n := if_pos hx
    exact (ne_of_lt h) (he.symm.trans ht)
  refine ⟨i, hne, ?_⟩
  rw [← he, triggerTime, if_neg hne]
  exact p.first_hit_exact i _ (mismatch_level_pos x hy i)

theorem before_switch_le_size (t : ℝ) (h : t ≤ p.switchTime x)
    (i : Fin n) : p.plannedService t i ≤ x.val i := by
  rcases le_total (y i) (x.val i) with hlarge | hsmall
  · exact (p.planned_service_le_prediction t i).trans hlarge
  rcases eq_or_lt_of_le hsmall with he | hlt
  · rw [he]
    exact p.planned_service_le_prediction t i
  have htime := h.trans (p.switch_time_le_trigger x i)
  rw [triggerTime, if_neg hlt.ne, min_eq_left hlt.le] at htime
  exact (p.planned_service_mono i htime).trans_eq (p.first_hit_exact i _ ⟨x.property i, hlt.le⟩)

theorem no_wrong_threshold_before_switch (hy : ∀ i, 0 < y i) (t : ℝ)
    (ht : 0 ≤ t) (h : t < p.switchTime x) (i : Fin n) (hne : x.val i ≠ y i) :
    p.plannedService t i < min (x.val i) (y i) := by
  have hi := h.trans_le (p.switch_time_le_trigger x i)
  rw [triggerTime, if_neg hne] at hi
  exact lt_of_not_ge (fun hc =>
    (not_le_of_gt hi) ((p.first_hit_iff i _ (mismatch_level_pos x hy i) t ht).mpr hc))

theorem exact_predictions_switch_at_end (hx : x.val = y) :
    p.switchTime x = p.time n := by
  have he (i : Fin n) : p.triggerTime x i = p.time n :=
    if_pos (congrFun hx i)
  have h := p.switch_time_mem x
  rw [triggerTimes, Finset.mem_insert] at h
  rcases h with h | h
  · exact h
  obtain ⟨i, _, hi⟩ := Finset.mem_image.mp h
  exact hi.symm.trans (he i)

end FiniteFrontier.SnapshotPlan
