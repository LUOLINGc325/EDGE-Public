import FirstPredictionError

/-! The actual run, with snapshot service up to the first prediction error
and permanent equal-rate continuation from that event. -/

open scoped BigOperators

namespace FiniteFrontier.SnapshotPlan

variable {n : ℕ} {y : Fin n → ℝ} (p : SnapshotPlan y)
variable (x : PositiveSizes (Fin n))

noncomputable def switchService : Fin n → ℝ := p.plannedService (p.switchTime x)

noncomputable def residual : Fin n → ℝ := fun i => x.val i - p.switchService x i

theorem residual_nonneg (i : Fin n) : 0 ≤ p.residual x i :=
  sub_nonneg.mpr (p.before_switch_le_size x _ le_rfl i)

noncomputable def executedService (t : ℝ) : Fin n → ℝ :=
  if t ≤ p.switchTime x then p.plannedService t
  else fun i => p.switchService x i + roundRobinService (p.residual x) (t - p.switchTime x) i

theorem executed_service_before (t : ℝ) (h : t ≤ p.switchTime x) :
    p.executedService x t = p.plannedService t := if_pos h

theorem executed_service_after (t : ℝ) (h : p.switchTime x ≤ t) (i : Fin n) :
    p.executedService x t i =
      p.switchService x i + roundRobinService (p.residual x) (t - p.switchTime x) i := by
  rcases eq_or_lt_of_le h with he | hl
  · subst t
    rw [p.executed_service_before x _ le_rfl, sub_self,
      round_robin_service_zero _ (p.residual_nonneg x), Pi.zero_apply, add_zero]
    rfl
  · exact congrFun (if_neg (not_le_of_gt hl)) i

theorem executed_service_mono (i : Fin n) (u t : ℝ) (hut : u ≤ t) :
    p.executedService x u i ≤ p.executedService x t i := by
  rcases le_total t (p.switchTime x) with ht | ht
  · rw [p.executed_service_before x t ht, p.executed_service_before x u (hut.trans ht)]
    exact p.planned_service_mono i hut
  rcases le_total u (p.switchTime x) with hu | hu
  · rw [p.executed_service_before x u hu, p.executed_service_after x t ht]
    have hmono := round_robin_service_mono (p.residual x) (p.residual_nonneg x)
      0 (t - p.switchTime x) le_rfl (sub_nonneg.mpr ht) i
    rw [round_robin_service_zero _ (p.residual_nonneg x), Pi.zero_apply] at hmono
    exact (p.planned_service_mono i hu).trans (le_add_of_nonneg_right hmono)
  rw [p.executed_service_after x t ht, p.executed_service_after x u hu]
  exact add_le_add_left (round_robin_service_mono (p.residual x) (p.residual_nonneg x)
    _ _ (sub_nonneg.mpr hu) (sub_le_sub_right hut _) i) _

theorem executed_service_le_size (t : ℝ) (i : Fin n) :
    p.executedService x t i ≤ x.val i := by
  rcases le_total t (p.switchTime x) with ht | ht
  · rw [p.executed_service_before x t ht]
    exact p.before_switch_le_size x t ht i
  rw [p.executed_service_after x t ht]
  have hi : roundRobinService (p.residual x) (t - p.switchTime x) i ≤ p.residual x i :=
    min_le_left _ _
  change roundRobinService (p.residual x) (t - p.switchTime x) i ≤
    x.val i - p.switchService x i at hi
  linarith only [hi]

theorem executed_service_sum (hy : ∀ i, 0 < y i) (t : ℝ) (ht : 0 ≤ t) :
    (∑ i, p.executedService x t i) = min t (p.switchTime x + ∑ i, p.residual x i) := by
  have hw : 0 ≤ ∑ i, p.residual x i := Finset.sum_nonneg fun i _ => p.residual_nonneg x i
  have hτ := p.switch_time_nonneg x hy
  rcases le_total t (p.switchTime x) with hb | ha
  · rw [p.executed_service_before x t hb, p.planned_service_sum t ht,
      min_eq_left (hb.trans (p.switch_time_le_end x)),
      min_eq_left (hb.trans (le_add_of_nonneg_right hw))]
  simp_rw [p.executed_service_after x t ha]
  rw [Finset.sum_add_distrib,
    round_robin_service_sum _ (p.residual_nonneg x) _ (sub_nonneg.mpr ha)]
  change (∑ i, p.plannedService (p.switchTime x) i) +
      min (t - p.switchTime x) (∑ i, p.residual x i) = _
  rw [p.planned_service_sum _ hτ, min_eq_left (p.switch_time_le_end x), ← min_add_add_left]
  rw [add_sub_cancel]

noncomputable def executedCompletion (i : Fin n) : ℝ :=
  if p.switchService x i = x.val i then p.firstHit i (x.val i)
  else p.switchTime x + roundRobinClock (p.residual x) (p.residual x i)

theorem completed_by_switch_of_eq (hy : ∀ i, 0 < y i) (i : Fin n)
    (h : p.switchService x i = x.val i) :
    0 < x.val i ∧ x.val i ≤ y i ∧ p.firstHit i (x.val i) ≤ p.switchTime x := by
  have hx : x.val i ≤ y i := h ▸ p.planned_service_le_prediction (p.switchTime x) i
  have hh := (p.first_hit_iff i (x.val i) ⟨x.property i, hx⟩ _ (p.switch_time_nonneg x hy)).mpr h.ge
  exact ⟨x.property i, hx, hh⟩

theorem residual_positive_of_ne (i : Fin n)
    (h : p.switchService x i ≠ x.val i) : 0 < p.residual x i :=
  sub_pos.mpr (lt_of_le_of_ne (p.before_switch_le_size x _ le_rfl i) h)

theorem residual_completion_positive (i : Fin n)
    (h : p.switchService x i ≠ x.val i) :
    0 < roundRobinClock (p.residual x) (p.residual x i) := by
  have hsingle := Finset.single_le_sum
    (f := fun j => roundRobinIncrement (p.residual x) (p.residual x i) j)
    (fun j _ => le_min (p.residual_nonneg x j) (p.residual_nonneg x i))
    (Finset.mem_univ i)
  exact (p.residual_positive_of_ne x i h).trans_le
    (by simpa only [roundRobinIncrement, min_self] using hsingle)

theorem executed_completion_pos (hy : ∀ i, 0 < y i) (i : Fin n) :
    0 < p.executedCompletion x i := by
  unfold executedCompletion
  split
  · rename_i h
    obtain ⟨hx₀, hx₁, _⟩ := p.completed_by_switch_of_eq x hy i h
    exact p.first_hit_pos i _ ⟨hx₀, hx₁⟩
  · rename_i h
    exact add_pos_of_nonneg_of_pos (p.switch_time_nonneg x hy)
      (p.residual_completion_positive x i h)

theorem executed_complete_iff (hy : ∀ i, 0 < y i) (i : Fin n) (t : ℝ) (ht : 0 ≤ t) :
    p.executedService x t i = x.val i ↔ p.executedCompletion x i ≤ t := by
  by_cases hc : p.switchService x i = x.val i
  · rw [executedCompletion, if_pos hc]
    obtain ⟨hx₀, hx₁, ht'⟩ := p.completed_by_switch_of_eq x hy i hc
    rcases le_total t (p.switchTime x) with hb | ha
    · rw [p.executed_service_before x t hb, p.first_hit_iff i _ ⟨hx₀, hx₁⟩ t ht]
      exact ⟨Eq.ge, le_antisymm (p.before_switch_le_size x t hb i)⟩
    have hdone : p.executedService x t i = x.val i := by
      apply le_antisymm (p.executed_service_le_size x t i)
      rw [← hc]
      have hmono := p.executed_service_mono x i _ _ ha
      rw [p.executed_service_before x _ le_rfl] at hmono
      exact hmono
    exact ⟨fun _ => ht'.trans ha, fun _ => hdone⟩
  rw [executedCompletion, if_neg hc]
  have hR := p.residual_completion_positive x i hc
  rcases le_total t (p.switchTime x) with hb | ha
  · rw [p.executed_service_before x t hb]
    have hsize : p.plannedService t i < x.val i :=
      (p.planned_service_mono i hb).trans_lt
        (lt_of_le_of_ne (p.before_switch_le_size x _ le_rfl i) hc)
    have ht' : t < p.switchTime x + roundRobinClock (p.residual x) (p.residual x i) := by
      linarith only [hb, hR]
    exact ⟨fun h => (hsize.ne h).elim, fun h => (not_le_of_gt ht' h).elim⟩
  rw [p.executed_service_after x t ha]
  have h := round_robin_service_complete (p.residual x) (p.residual_nonneg x)
    (t - p.switchTime x) (sub_nonneg.mpr ha) i
  calc
    _ ↔ roundRobinService (p.residual x) (t - p.switchTime x) i = p.residual x i := by
      unfold residual
      constructor <;> intro he <;> linarith only [he]
    _ ↔ _ := by
      rw [h]
      constructor <;> intro he <;> linarith only [he]

/-- A legal schedule on every positive actual size vector. -/
noncomputable def execute (hy : ∀ i, 0 < y i) : Run x.val where
  service := p.executedService x
  completion := p.executedCompletion x
  service_zero i := by
    rw [p.executed_service_before x 0 (p.switch_time_nonneg x hy), p.planned_service_zero, Pi.zero_apply]
  service_mono i u t _ hut := p.executed_service_mono x i u t hut
  capacity u t hu hut := by
    rw [p.executed_service_sum x hy t (hu.trans hut), p.executed_service_sum x hy u hu]
    let stop := p.switchTime x + ∑ i, p.residual x i
    change min t stop - min u stop ≤ t - u
    rcases le_total u stop with h | h
    · rw [min_eq_left h]
      exact sub_le_sub_right (min_le_left _ _) _
    · rw [min_eq_right h, min_eq_right (h.trans hut), sub_self]
      exact sub_nonneg.mpr hut
  service_le_size i t _ := p.executed_service_le_size x t i
  completion_pos := p.executed_completion_pos x hy
  complete_iff := p.executed_complete_iff x hy

end FiniteFrontier.SnapshotPlan
