import SchedulingModel
import Mathlib.Data.Fin.Tuple.Sort

/-! The pair-minimum expression for offline cost and the capacity lower bound. -/

open scoped BigOperators

namespace FiniteFrontier

variable {ι : Type*} [Fintype ι]

/-- Matrix pairing along the diagonal and the two orientations of each unordered pair. -/
theorem frozen_off_diagonal [LinearOrder ι] (x : ι → ℝ) :
    frozenCost x =
      (∑ i, x i) + ∑ i, ∑ j : ι, if i < j then min (x i) (x j) else 0 := by
  have hterm (i j : ι) :
      min (x i) (x j) = (if i = j then x i else 0) +
        (if i < j then min (x i) (x j) else 0) +
        (if j < i then min (x j) (x i) else 0) := by
    rcases lt_trichotomy i j with h | rfl | h
    · simp [h, h.ne, not_lt_of_gt h]
    · simp
    · simp [h, h.ne', not_lt_of_gt h, min_comm]
  have hflip :
      (∑ i, ∑ j : ι, if j < i then min (x j) (x i) else 0) =
        ∑ i, ∑ j : ι, if i < j then min (x i) (x j) else 0 :=
    Finset.sum_comm
  have htotal :
      (∑ i, ∑ j : ι, min (x i) (x j)) =
        (∑ i, x i) + (∑ i, ∑ j : ι, if i < j then min (x i) (x j) else 0) +
          (∑ i, ∑ j : ι, if j < i then min (x j) (x i) else 0) := by
    calc
      _ = ∑ i, ∑ j : ι, ((if i = j then x i else 0) +
          (if i < j then min (x i) (x j) else 0) +
          (if j < i then min (x j) (x i) else 0)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => hterm i j
      _ = _ := by simp only [Finset.sum_add_distrib, Finset.sum_ite_eq, Finset.mem_univ, ite_true]
  unfold frozenCost
  rw [htotal, hflip]
  ring

theorem frozen_reindex {κ : Type*} [Fintype κ] (σ : κ ≃ ι) (x : ι → ℝ) :
    frozenCost (x ∘ σ) = frozenCost x := by
  unfold frozenCost
  simp only [Function.comp_apply]
  rw [Equiv.sum_comp σ x]
  have hp : (∑ i, ∑ j, min (x (σ i)) (x (σ j))) =
      ∑ i, ∑ j, min (x i) (x j) := by
    calc
      _ = ∑ i, ∑ j : ι, min (x (σ i)) (x j) := by
        exact Finset.sum_congr rfl fun i _ => Equiv.sum_comp σ (fun j => min (x (σ i)) (x j))
      _ = _ := Equiv.sum_comp σ (fun i => ∑ j, min (x i) (x j))
  rw [hp]

theorem frozen_ge_size_sum (x : ι → ℝ) (hx : ∀ i, 0 ≤ x i) :
    (∑ i, x i) ≤ frozenCost x := by
  classical
  have hdiag (i : ι) : x i ≤ ∑ j, min (x i) (x j) := by
    simpa using (Finset.single_le_sum (f := fun j => min (x i) (x j))
      (fun j _ => le_min (hx i) (hx j)) (Finset.mem_univ i))
  have htotal := Finset.sum_le_sum fun i (_ : i ∈ Finset.univ) => hdiag i
  unfold frozenCost
  linarith only [htotal]

/-- The completion time when processing in a prescribed linear order with no idling. -/
noncomputable def serialCompletion [LinearOrder ι] (x : ι → ℝ) (i : ι) : ℝ :=
  ∑ j, if j ≤ i then x j else 0

theorem frozen_eq_serial_sorted [LinearOrder ι] (x : ι → ℝ) (hx : Monotone x) :
    frozenCost x = ∑ i, serialCompletion x i := by
  rw [frozen_off_diagonal]
  unfold serialCompletion
  have h (i j : ι) : (if j ≤ i then x j else 0) =
      (if i = j then x i else 0) + (if j < i then min (x j) (x i) else 0) := by
    rcases lt_trichotomy j i with h | rfl | h
    · simp [h, h.le, h.ne', min_eq_left (hx h.le)]
    · simp
    · simp [h.ne, not_le_of_gt h, not_lt_of_gt h]
  simp only [h, Finset.sum_add_distrib, Finset.sum_ite_eq, Finset.mem_univ, ite_true]
  exact congrArg (fun t => (∑ i, x i) + t) Finset.sum_comm

namespace Run

variable {x : ι → ℝ}

/-- Work already completed when job i finishes. Including ties is valid. -/
noncomputable def completedWork (r : Run x) (i j : ι) : ℝ :=
  if r.completion j ≤ r.completion i then x j else 0

theorem completed_work_le_completion (r : Run x) (i : ι) :
    (∑ j, r.completedWork i j) ≤ r.completion i := by
  apply le_trans _ (r.service_sum_le _ (r.completion_pos i).le)
  apply Finset.sum_le_sum
  intro j _
  unfold completedWork
  split
  · rename_i hj
    rw [(r.complete_iff j _ (r.completion_pos i).le).mpr hj]
  · exact r.service_nonneg j _ (r.completion_pos i).le

/-- Every legal schedule pays at least the pair-minimum cost, with arbitrary completion
order, including ties, idling and fractional or discontinuous changes of rates. -/
theorem frozen_le_cost (r : Run x) : frozenCost x ≤ r.cost := by
  classical
  have hx (i : ι) : 0 ≤ x i :=
    (r.service_nonneg i 0 le_rfl).trans (r.service_le_size i 0 le_rfl)
  have hterm (i j : ι) :
      (if i = j then x i else 0) + min (x i) (x j) ≤
        r.completedWork i j + r.completedWork j i := by
    by_cases hij : i = j
    · subst j
      simp [completedWork]
    rw [if_neg hij, zero_add]
    rcases le_total (r.completion j) (r.completion i) with h | h
    · have hn : 0 ≤ r.completedWork j i := by unfold completedWork; split <;> simp [hx]
      rw [completedWork, if_pos h]
      exact (min_le_right _ _).trans (le_add_of_nonneg_right hn)
    · have hn : 0 ≤ r.completedWork i j := by unfold completedWork; split <;> simp [hx]
      have he : r.completedWork j i = x i := if_pos h
      rw [he]
      exact (min_le_left _ _).trans (le_add_of_nonneg_left hn)
  have hsum := Finset.sum_le_sum (fun i (_ : i ∈ Finset.univ) =>
    Finset.sum_le_sum (fun j (_ : j ∈ Finset.univ) => hterm i j))
  simp only [Finset.sum_add_distrib, Finset.sum_ite_eq, Finset.mem_univ, ite_true] at hsum
  have hflip : (∑ i, ∑ j, r.completedWork j i) = ∑ i, ∑ j, r.completedWork i j :=
    Finset.sum_comm
  rw [hflip] at hsum
  have hl := Finset.sum_le_sum fun i (_ : i ∈ Finset.univ) => r.completed_work_le_completion i
  unfold frozenCost cost
  linarith only [hsum, hl]

/-- Relabel a run, without changing elapsed time or elapsed machine service. -/
noncomputable def reindex {κ : Type*} [Fintype κ] (σ : κ ≃ ι) (r : Run x) : Run (x ∘ σ) where
  service t := r.service t ∘ σ
  completion := r.completion ∘ σ
  service_zero i := r.service_zero (σ i)
  service_mono i := r.service_mono (σ i)
  capacity u t hu hut := by
    simp only [Function.comp_apply]
    rw [Equiv.sum_comp σ (r.service t), Equiv.sum_comp σ (r.service u)]
    exact r.capacity u t hu hut
  service_le_size i := r.service_le_size (σ i)
  completion_pos i := r.completion_pos (σ i)
  complete_iff i := r.complete_iff (σ i)

theorem reindex_cost {κ : Type*} [Fintype κ] (σ : κ ≃ ι) (r : Run x) :
    (r.reindex σ).cost = r.cost := Equiv.sum_comp σ r.completion

theorem reindex_paid_cost {κ : Type*} [Fintype κ] (σ : κ ≃ ι) (r : Run x) (t : ℝ) :
    (r.reindex σ).paidCost t = r.paidCost t :=
  Equiv.sum_comp σ (fun j => min t (r.completion j))

end Run

end FiniteFrontier
