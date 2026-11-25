import OfflineOptimum

/-! The proportional-service witness from the earlier independent service review,
expressed using the same cumulative-service model as the full proof. -/

open scoped BigOperators

namespace FiniteFrontier

variable {ι : Type*} [Fintype ι] [Nonempty ι]

noncomputable def totalPositiveWork (x : PositiveSizes ι) : ℝ := ∑ i, x.val i

theorem total_positive_work_pos (x : PositiveSizes ι) : 0 < totalPositiveWork x :=
  Finset.sum_pos (fun i _ => x.property i) Finset.univ_nonempty

noncomputable def proportionalService (x : PositiveSizes ι) (t : ℝ) (i : ι) : ℝ :=
  min t (totalPositiveWork x) / totalPositiveWork x * x.val i

theorem proportional_service_sum (x : PositiveSizes ι) (t : ℝ) :
    (∑ i, proportionalService x t i) = min t (totalPositiveWork x) := by
  unfold proportionalService
  rw [← Finset.mul_sum]
  exact div_mul_cancel₀ _ (total_positive_work_pos x).ne'

theorem proportional_service_complete_iff (x : PositiveSizes ι) (i : ι) (t : ℝ) :
    proportionalService x t i = x.val i ↔ totalPositiveWork x ≤ t := by
  have hw := total_positive_work_pos x
  by_cases ht : totalPositiveWork x ≤ t
  · simp [proportionalService, min_eq_right ht, hw.ne', ht]
  have hu : t < totalPositiveWork x := lt_of_not_ge ht
  have hfrac : min t (totalPositiveWork x) / totalPositiveWork x < 1 :=
    (div_lt_one hw).mpr ((min_le_left _ _).trans_lt hu)
  have hlt : proportionalService x t i < x.val i := by
    unfold proportionalService
    simpa only [one_mul] using mul_lt_mul_of_pos_right hfrac (x.property i)
  simp [ht, hlt.ne]

/-- An offline fluid witness in which all jobs complete at the total workload. -/
noncomputable def proportionalRun (x : PositiveSizes ι) : Run x.val where
  service := proportionalService x
  completion _ := totalPositiveWork x
  service_zero i := by simp [proportionalService, min_eq_left (total_positive_work_pos x).le]
  service_mono i u t _ hut := by
    unfold proportionalService
    exact mul_le_mul_of_nonneg_right (div_le_div_of_nonneg_right
      (min_le_min_right _ hut) (total_positive_work_pos x).le) (x.property i).le
  capacity u t _ hut := by
    rw [proportional_service_sum, proportional_service_sum]
    rcases le_total u (totalPositiveWork x) with h | h
    · rw [min_eq_left h]
      exact sub_le_sub_right (min_le_left _ _) _
    · rw [min_eq_right h, min_eq_right (h.trans hut), sub_self]
      exact sub_nonneg.mpr hut
  service_le_size i t _ := by
    unfold proportionalService
    have hf := (div_le_one (total_positive_work_pos x)).mpr (min_le_right t (totalPositiveWork x))
    simpa only [one_mul] using mul_le_mul_of_nonneg_right hf (x.property i).le
  completion_pos _ := total_positive_work_pos x
  complete_iff i t _ := proportional_service_complete_iff x i t

theorem proportional_run_cost (x : PositiveSizes ι) :
    (proportionalRun x).cost = (Fintype.card ι : ℝ) * totalPositiveWork x := by
  simp [Run.cost, proportionalRun, nsmul_eq_mul]

theorem proportional_two_job_example :
    (proportionalRun (⟨fun _ : Fin 2 => 1, fun _ => zero_lt_one⟩ : PositiveSizes (Fin 2))).cost = 4 := by
  rw [proportional_run_cost]
  norm_num [totalPositiveWork]

end FiniteFrontier
