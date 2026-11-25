import RoundRobin
import Mathlib.Topology.Algebra.Monoid
import Mathlib.Topology.Order.IntermediateValue
import Mathlib.Topology.Instances.Real.Lemmas

/-! Wall-clock realization and causal prefix agreement for the equal-rate continuation. -/

open scoped BigOperators

namespace FiniteFrontier

variable {ι : Type*} [Fintype ι]

theorem round_robin_clock_saturated (r : ι → ℝ) (q : ℝ) (h : ∀ i, r i ≤ q) :
    roundRobinClock r q = ∑ i, r i := by
  exact Finset.sum_congr rfl fun i _ => min_eq_left (h i)

theorem round_robin_clock_le_work (r : ι → ℝ) (q : ℝ) :
    roundRobinClock r q ≤ ∑ i, r i :=
  Finset.sum_le_sum fun _ _ => min_le_left _ _

theorem round_robin_clock_continuous (r : ι → ℝ) : Continuous (roundRobinClock r) :=
  continuous_finset_sum _ fun _ _ => continuous_const.min continuous_id

theorem round_robin_clock_exists (r : ι → ℝ) (hr : ∀ i, 0 ≤ r i) (t : ℝ) (ht : 0 ≤ t) :
    ∃ q, 0 ≤ q ∧ roundRobinClock r q = min t (∑ i, r i) := by
  classical
  let work := ∑ i, r i
  have hw : 0 ≤ work := Finset.sum_nonneg fun i _ => hr i
  have hb (i : ι) : r i ≤ work := Finset.single_le_sum (fun j _ => hr j) (Finset.mem_univ i)
  have htarget : min t work ∈ Set.Icc (roundRobinClock r 0) (roundRobinClock r work) := by
    rw [round_robin_clock_zero r hr, round_robin_clock_saturated r work hb]
    exact ⟨le_min ht hw, min_le_right _ _⟩
  obtain ⟨q, hq, hEq⟩ :=
    intermediate_value_Icc hw (round_robin_clock_continuous r).continuousOn htarget
  exact ⟨q, hq.1, hEq⟩

/-- Any wall-clock inverse gives the same service, including on the final flat part. -/
noncomputable def roundRobinQuantum (r : ι → ℝ) (t : ℝ) : ℝ := by
  classical
  exact if h : ∃ q, 0 ≤ q ∧ roundRobinClock r q = min t (∑ i, r i)
    then Classical.choose h else 0

theorem round_robin_quantum_spec (r : ι → ℝ) (hr : ∀ i, 0 ≤ r i) (t : ℝ) (ht : 0 ≤ t) :
    0 ≤ roundRobinQuantum r t ∧ roundRobinClock r (roundRobinQuantum r t) = min t (∑ i, r i) := by
  have h := round_robin_clock_exists r hr t ht
  rw [roundRobinQuantum, dif_pos h]
  exact Classical.choose_spec h

theorem round_robin_increment_mono_of_clock (r : ι → ℝ) {q s : ℝ}
    (h : roundRobinClock r q ≤ roundRobinClock r s) (i : ι) :
    roundRobinIncrement r q i ≤ roundRobinIncrement r s i := by
  classical
  rcases le_total q s with hqs | hsq
  · exact min_le_min_left _ hqs
  have hnonneg (j : ι) : 0 ≤ roundRobinIncrement r q j - roundRobinIncrement r s j :=
    sub_nonneg.mpr (min_le_min_left _ hsq)
  have hinc := Finset.single_le_sum
    (f := fun j => roundRobinIncrement r q j - roundRobinIncrement r s j)
    (fun j _ => hnonneg j) (Finset.mem_univ i)
  rw [Finset.sum_sub_distrib] at hinc
  change roundRobinIncrement r q i - roundRobinIncrement r s i ≤
    roundRobinClock r q - roundRobinClock r s at hinc
  linarith only [hinc, h]

noncomputable def roundRobinService (r : ι → ℝ) (t : ℝ) (i : ι) : ℝ :=
  roundRobinIncrement r (roundRobinQuantum r t) i

theorem round_robin_service_sum (r : ι → ℝ) (hr : ∀ i, 0 ≤ r i) (t : ℝ) (ht : 0 ≤ t) :
    (∑ i, roundRobinService r t i) = min t (∑ i, r i) :=
  (round_robin_quantum_spec r hr t ht).2

theorem round_robin_service_eq_of_clock (r : ι → ℝ) (hr : ∀ i, 0 ≤ r i)
    (t : ℝ) (ht : 0 ≤ t) (q : ℝ) (hq : roundRobinClock r q = min t (∑ i, r i)) :
    roundRobinService r t = roundRobinIncrement r q := by
  have h := (round_robin_quantum_spec r hr t ht).2.trans hq.symm
  exact funext fun i => le_antisymm
    (round_robin_increment_mono_of_clock r h.le i)
    (round_robin_increment_mono_of_clock r h.ge i)

theorem round_robin_service_zero (r : ι → ℝ) (hr : ∀ i, 0 ≤ r i) :
    roundRobinService r 0 = 0 := by
  rw [round_robin_service_eq_of_clock r hr 0 le_rfl 0]
  · exact funext fun i => min_eq_right (hr i)
  · rw [round_robin_clock_zero r hr, min_eq_left (Finset.sum_nonneg fun i _ => hr i)]

theorem round_robin_service_mono (r : ι → ℝ) (hr : ∀ i, 0 ≤ r i)
    (u t : ℝ) (hu : 0 ≤ u) (hut : u ≤ t) (i : ι) :
    roundRobinService r u i ≤ roundRobinService r t i := by
  have h := min_le_min_right (∑ j, r j) hut
  rw [← (round_robin_quantum_spec r hr u hu).2,
    ← (round_robin_quantum_spec r hr t (hu.trans hut)).2] at h
  exact round_robin_increment_mono_of_clock r h i

theorem round_robin_service_complete (r : ι → ℝ) (hr : ∀ i, 0 ≤ r i)
    (t : ℝ) (ht : 0 ≤ t) (i : ι) :
    roundRobinService r t i = r i ↔ roundRobinClock r (r i) ≤ t := by
  have hq := (round_robin_quantum_spec r hr t ht).2
  change min (r i) (roundRobinQuantum r t) = r i ↔ _
  constructor
  · intro h
    have hi : r i ≤ roundRobinQuantum r t := h ▸ min_le_right _ _
    exact ((round_robin_clock_monotone r hi).trans_eq hq).trans (min_le_left _ _)
  · intro h
    have hc := le_min h (round_robin_clock_le_work r (r i))
    rw [← hq] at hc
    have hi := round_robin_increment_mono_of_clock r hc i
    have he : roundRobinIncrement r (r i) i = r i := min_self _
    rw [he] at hi
    exact le_antisymm (min_le_left _ _) hi

theorem roundRobinCapacity (r : ι → ℝ) (hr : ∀ i, 0 ≤ r i)
    (u t : ℝ) (hu : 0 ≤ u) (hut : u ≤ t) :
    (∑ i, roundRobinService r t i) - (∑ i, roundRobinService r u i) ≤ t - u := by
  rw [round_robin_service_sum r hr t (hu.trans hut), round_robin_service_sum r hr u hu]
  rcases le_total u (∑ i, r i) with h | h
  · rw [min_eq_left h]
    exact sub_le_sub_right (min_le_left _ _) _
  · rw [min_eq_right h, min_eq_right (h.trans hut), sub_self]
    exact sub_nonneg.mpr hut

/-- Prefix agreement needs only the jobs already finished and the fact that all
other jobs are still unfinished. It works for continuations with zero residual jobs. -/
theorem round_robin_prefix (r z : ι → ℝ) (hr : ∀ i, 0 ≤ r i) (hz : ∀ i, 0 ≤ z i)
    (u t : ℝ) (hu : 0 ≤ u) (hut : u ≤ t)
    (hobs : ∀ i, if roundRobinService r t i = r i then z i = r i
      else roundRobinService r t i < z i) :
    roundRobinService z u = roundRobinService r u := by
  classical
  by_cases hall : ∀ i, roundRobinService r t i = r i
  · have he : z = r := funext fun i => by simpa only [if_pos (hall i)] using hobs i
    rw [he]
  push_neg at hall
  obtain ⟨i, hi⟩ := hall
  let q := roundRobinQuantum r u
  have hq := (round_robin_quantum_spec r hr u hu).2
  have hinc (j : ι) : roundRobinIncrement z q j = roundRobinIncrement r q j := by
    by_cases hj : roundRobinService r t j = r j
    · have he : z j = r j := by simpa only [if_pos hj] using hobs j
      simp [roundRobinIncrement, he]
    have hlt : roundRobinService r t j < r j :=
      lt_of_le_of_ne (min_le_left _ _) hj
    have hmax := round_robin_service_mono r hr u t hu hut j
    have hx : roundRobinService r u j < r j := hmax.trans_lt hlt
    have hqj : q < r j := by
      by_contra! hc
      have he : roundRobinService r u j = r j := min_eq_left hc
      rw [he] at hx
      exact (lt_irrefl _) hx
    have he : roundRobinService r u j = q := min_eq_right hqj.le
    have hzo : roundRobinService r t j < z j := by simpa only [if_neg hj] using hobs j
    have hqz : q < z j := by rw [← he]; exact hmax.trans_lt hzo
    simp [roundRobinIncrement, min_eq_right hqz.le, min_eq_right hqj.le]
  have htime : u ≤ ∑ j, r j := by
    have ht : t < roundRobinClock r (r i) := lt_of_not_ge
      (fun h => hi ((round_robin_service_complete r hr t (hu.trans hut) i).mpr h))
    exact hut.trans (ht.le.trans (round_robin_clock_le_work r (r i)))
  have hclock : roundRobinClock z q = u := by
    calc
      _ = roundRobinClock r q := Finset.sum_congr rfl fun j _ => hinc j
      _ = u := hq.trans (min_eq_left htime)
  have htimeZ : u ≤ ∑ j, z j := hclock ▸ round_robin_clock_le_work z q
  rw [round_robin_service_eq_of_clock z hz u hu q (hclock.trans (min_eq_left htimeZ).symm)]
  exact funext hinc

/-- Permanent equal-rate round-robin as a legal finite run. -/
noncomputable def roundRobinRun (x : PositiveSizes ι) : Run x.val where
  service := roundRobinService x.val
  completion i := roundRobinClock x.val (x.val i)
  service_zero i := congrFun (round_robin_service_zero x.val (fun j => (x.property j).le)) i
  service_mono i u t hu hut := round_robin_service_mono x.val (fun j => (x.property j).le) u t hu hut i
  capacity := roundRobinCapacity x.val (fun j => (x.property j).le)
  service_le_size i _ _ := min_le_left (x.val i) _
  completion_pos i := by
    classical
    have h := Finset.single_le_sum (f := fun j => min (x.val j) (x.val i))
      (fun j _ => le_min (x.property j).le (x.property i).le) (Finset.mem_univ i)
    exact (x.property i).trans_le (by simpa only [min_self] using h)
  complete_iff i t ht := round_robin_service_complete x.val (fun j => (x.property j).le) t ht i

/-- The no-prediction policy ignores the prediction and only sees completions. -/
noncomputable def roundRobinPolicy (ι : Type*) [Fintype ι] : Policy ι where
  run _ := roundRobinRun
  prefix_agrees _ x z t ht hobs u hu hut := by
    refine round_robin_prefix x.val z.val (fun i => (x.property i).le)
      (fun i => (z.property i).le) u t hu hut fun i => ?_
    have h := hobs i
    change (if roundRobinClock x.val (x.val i) ≤ t then z.val i = x.val i
      else roundRobinService x.val t i < z.val i) at h
    simpa only [round_robin_service_complete x.val (fun j => (x.property j).le) t ht i] using h

theorem round_robin_policy_robust :
    Robust (roundRobinPolicy ι) (baselineRobustness (Fintype.card ι : ℝ)) := by
  intro x _
  classical
  let q := ∑ i, x.val i
  have hq (i : ι) : x.val i ≤ q := Finset.single_le_sum
    (fun j _ => (x.property j).le) (Finset.mem_univ i)
  have h := round_robin_bound x.val q
  have he : roundRobinIncrement x.val q = x.val := funext fun i => min_eq_left (hq i)
  rw [he] at h
  have hp : roundRobinPaid x.val q = (roundRobinRun x).cost := by
    apply Finset.sum_congr rfl
    intro i _
    rw [round_robin_clock_saturated x.val q hq]
    exact min_eq_right (round_robin_clock_le_work _ _)
  rw [hp] at h
  exact h

end FiniteFrontier
