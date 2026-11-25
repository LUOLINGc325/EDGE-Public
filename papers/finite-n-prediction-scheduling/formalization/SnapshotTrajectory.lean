import SnapshotPlan
import RoundRobinExecution

/-! Legal piecewise-linear service associated with a completion snapshot plan. -/

open scoped BigOperators

namespace FiniteFrontier.SnapshotPlan

variable {n : ℕ} {y : Fin n → ℝ} (p : SnapshotPlan y)

noncomputable def phaseFraction (k : ℕ) (t : ℝ) : ℝ :=
  min 1 (max 0 ((t - p.time k) / (p.time (k + 1) - p.time k)))

theorem phase_fraction_mem (k : ℕ) (t : ℝ) : p.phaseFraction k t ∈ Set.Icc 0 1 :=
  ⟨le_min zero_le_one (le_max_left _ _), min_le_left _ _⟩

theorem phase_fraction_monotone (k : ℕ) : Monotone (p.phaseFraction k) := by
  intro u t hut
  have h : 0 ≤ p.time (k + 1) - p.time k :=
    sub_nonneg.mpr (p.time_monotone (Nat.le_succ k))
  exact min_le_min_left _ (max_le_max_left _ (div_le_div_of_nonneg_right
    (sub_le_sub_right hut _) h))

theorem phase_fraction_before (k : ℕ) (t : ℝ) (h : t ≤ p.time k) :
    p.phaseFraction k t = 0 := by
  have hd : 0 ≤ p.time (k + 1) - p.time k :=
    sub_nonneg.mpr (p.time_monotone (Nat.le_succ k))
  simp [phaseFraction, max_eq_left (div_nonpos_of_nonpos_of_nonneg (sub_nonpos.mpr h) hd)]

theorem phase_fraction_after (k : ℕ) (t : ℝ) (h : p.time (k + 1) ≤ t)
    (hp : p.time k < p.time (k + 1)) : p.phaseFraction k t = 1 := by
  have hd := sub_pos.mpr hp
  have hc : 1 ≤ (t - p.time k) / (p.time (k + 1) - p.time k) := by
    apply (le_div_iff₀ hd).mpr
    simpa using sub_le_sub_right h (p.time k)
  exact min_eq_left (hc.trans (le_max_right _ _))

theorem phase_fraction_elapsed (k : ℕ) (t : ℝ) :
    (p.time (k + 1) - p.time k) * p.phaseFraction k t =
      min t (p.time (k + 1)) - min t (p.time k) := by
  have hmon := p.time_monotone (Nat.le_succ k)
  rcases eq_or_lt_of_le hmon with hzero | hpos
  · simp [← hzero]
  by_cases ht₀ : t ≤ p.time k
  · simp [p.phase_fraction_before k t ht₀, min_eq_left ht₀, min_eq_left (ht₀.trans hmon)]
  by_cases ht₁ : p.time (k + 1) ≤ t
  · simp [p.phase_fraction_after k t ht₁ hpos, min_eq_right ht₁, min_eq_right (hmon.trans ht₁)]
  have hd := sub_pos.mpr hpos
  have hl := (le_of_not_ge ht₀ : p.time k ≤ t)
  have hu := (le_of_not_ge ht₁ : t ≤ p.time (k + 1))
  have hβ₀ : 0 ≤ (t - p.time k) / (p.time (k + 1) - p.time k) :=
    div_nonneg (sub_nonneg.mpr hl) hd.le
  have hβ₁ : (t - p.time k) / (p.time (k + 1) - p.time k) ≤ 1 :=
    (div_le_one hd).mpr (sub_le_sub_right hu _)
  rw [phaseFraction, max_eq_right hβ₀, min_eq_right hβ₁, min_eq_left hu, min_eq_right hl,
    mul_comm, div_mul_cancel₀ _ hd.ne']

/-- This sum integrates the constant velocity of every positive-length phase.
The work increment of every zero-length phase is zero by the snapshot conditions. -/
noncomputable def plannedService (t : ℝ) (i : Fin n) : ℝ :=
  ∑ k ∈ Finset.range n, (p.attained (k + 1) i - p.attained k i) * p.phaseFraction k t

theorem planned_service_continuous (i : Fin n) : Continuous (fun t => p.plannedService t i) := by
  apply continuous_finset_sum
  intro k _
  exact continuous_const.mul
    (continuous_const.min (continuous_const.max ((continuous_id.sub continuous_const).div_const _)))

theorem planned_service_zero : p.plannedService 0 = 0 := by
  ext i
  simp [plannedService, p.phase_fraction_before _ _ (p.time_nonneg _)]

theorem planned_service_mono (i : Fin n) : Monotone (fun t => p.plannedService t i) := by
  intro u t hut
  apply Finset.sum_le_sum
  intro k _
  exact mul_le_mul_of_nonneg_left (p.phase_fraction_monotone k hut)
    (sub_nonneg.mpr (p.monotone i (Nat.le_succ k)))

theorem sum_successive_real_sub (f : ℕ → ℝ) (m : ℕ) :
    (∑ k ∈ Finset.range m, (f (k + 1) - f k)) = f m - f 0 := by
  induction m with
  | zero => simp
  | succ m ih => rw [Finset.sum_range_succ, ih]; ring

theorem planned_service_after_phase (i : Fin n) (k : ℕ) (t : ℝ) (h : p.time (k + 1) ≤ t) :
    (p.attained (k + 1) i - p.attained k i) * p.phaseFraction k t =
      p.attained (k + 1) i - p.attained k i := by
  rcases eq_or_lt_of_le (p.time_monotone (Nat.le_succ k)) with hEq | hLt
  · rw [p.no_work_zero_phase k hEq.symm, sub_self, zero_mul]
  · rw [p.phase_fraction_after k t h hLt, mul_one]

theorem planned_service_after_last (t : ℝ) (h : p.time n ≤ t) :
    p.plannedService t = y := by
  ext i
  unfold plannedService
  calc
    _ = ∑ k ∈ Finset.range n, (p.attained (k + 1) i - p.attained k i) :=
      Finset.sum_congr rfl fun k hk => p.planned_service_after_phase i k t
        ((p.time_monotone (Nat.succ_le_of_lt (Finset.mem_range.mp hk))).trans h)
    _ = y i := by
      rw [sum_successive_real_sub (fun j => p.attained j i) n]
      simp [p.initial]

theorem planned_service_le_prediction (t : ℝ) (i : Fin n) : p.plannedService t i ≤ y i := by
  have he := congrFun (p.planned_service_after_last (max t (p.time n)) (le_max_right _ _)) i
  exact (p.planned_service_mono i (le_max_left _ _)).trans_eq he

theorem planned_service_sum (t : ℝ) (ht : 0 ≤ t) :
    (∑ i, p.plannedService t i) = min t (p.time n) := by
  unfold plannedService
  rw [Finset.sum_comm]
  calc
    _ = ∑ k ∈ Finset.range n, (min t (p.time (k + 1)) - min t (p.time k)) := by
      apply Finset.sum_congr rfl
      intro k _
      rw [← Finset.sum_mul, Finset.sum_sub_distrib]
      exact p.phase_fraction_elapsed k t
    _ = _ := by
      rw [sum_successive_real_sub (fun j => min t (p.time j)) n]
      simp [min_eq_right ht]

theorem planned_service_on_phase (k : ℕ) (hk : k < n) (t : ℝ)
    (h₀ : p.time k ≤ t) (h₁ : t ≤ p.time (k + 1)) :
    p.plannedService t = p.interpolation k (p.phaseFraction k t) := by
  ext i
  unfold plannedService
  rw [← Finset.sum_subset (Finset.range_mono (Nat.succ_le_of_lt hk))]
  · rw [Finset.sum_range_succ]
    have hsum :
        (∑ j ∈ Finset.range k, (p.attained (j + 1) i - p.attained j i) * p.phaseFraction j t) =
          p.attained k i := by
      calc
        _ = ∑ j ∈ Finset.range k, (p.attained (j + 1) i - p.attained j i) :=
          Finset.sum_congr rfl fun j hj => p.planned_service_after_phase i j t
            ((p.time_monotone (Nat.succ_le_of_lt (Finset.mem_range.mp hj))).trans h₀)
        _ = _ := by
          rw [sum_successive_real_sub (fun j => p.attained j i) k]
          simp [p.initial]
    rw [hsum]
    unfold interpolation
    ring
  · intro j _ hj
    have hj' : k + 1 ≤ j := Nat.le_of_not_gt (fun hh => hj (Finset.mem_range.mpr hh))
    rw [p.phase_fraction_before j t (h₁.trans (p.time_monotone hj')), mul_zero]

theorem planned_service_at_snapshot (k : ℕ) (hk : k ≤ n) :
    p.plannedService (p.time k) = p.attained k := by
  rcases eq_or_lt_of_le hk with rfl | h
  · rw [p.planned_service_after_last _ le_rfl, p.attained_at_last]
  rw [p.planned_service_on_phase k h _ le_rfl (p.time_monotone (Nat.le_succ k)),
    p.phase_fraction_before k _ le_rfl]
  ext i
  simp [interpolation]

theorem planned_service_hit_by_mark (i : Fin n) :
    p.plannedService (p.time (i.val + 1)) i = y i := by
  rw [p.planned_service_at_snapshot _ (Nat.succ_le_of_lt i.isLt)]
  exact p.marked _ i (Nat.lt_succ_self _)

theorem planned_time_in_phase (k : ℕ) (t : ℝ) (h₀ : p.time k ≤ t) (h₁ : t ≤ p.time (k + 1)) :
    (1 - p.phaseFraction k t) * p.time k + p.phaseFraction k t * p.time (k + 1) = t := by
  have h := p.phase_fraction_elapsed k t
  rw [min_eq_left h₁, min_eq_right h₀] at h
  linarith only [h]

/-- A feasible plan maintains the virtual paid-cost invariant at every planned time. -/
theorem planned_frozen_invariant (R : ℝ) (hR : 0 ≤ R) (hp : p.Feasible R)
    (t : ℝ) (ht : 0 ≤ t) (htn : t ≤ p.time n) :
    (∑ i : Fin n, min t (p.time (i.val + 1))) ≤ R * frozenCost (p.plannedService t) := by
  by_cases hlast : t = p.time n
  · rw [hlast, ← p.paid_at_time, p.planned_service_at_snapshot n le_rfl]
    exact hp n le_rfl
  have hex : ∃ j, t < p.time j := ⟨n, lt_of_le_of_ne htn hlast⟩
  obtain ⟨k, he⟩ : ∃ k, Nat.find hex = k + 1 := by
    have hne : Nat.find hex ≠ 0 := by
      intro he
      have hh := Nat.find_spec hex
      rw [he, p.time_zero] at hh
      exact (not_lt_of_ge ht) hh
    exact ⟨(Nat.find hex).pred, (Nat.succ_pred_eq_of_ne_zero hne).symm⟩
  have hk : k < n := by have hj := Nat.find_min' hex (lt_of_le_of_ne htn hlast); omega
  have h₀ : p.time k ≤ t := le_of_not_gt (Nat.find_min hex (by omega))
  have h₁ : t ≤ p.time (k + 1) := by simpa only [he] using (Nat.find_spec hex).le
  have hi := p.phase_fraction_mem k t
  have hb := p.interior_frozen_invariant R hR hp k hk _ hi.1 hi.2
  rw [p.planned_time_in_phase k t h₀ h₁] at hb
  rw [p.planned_service_on_phase k hk t h₀ h₁]
  exact hb

end FiniteFrontier.SnapshotPlan
