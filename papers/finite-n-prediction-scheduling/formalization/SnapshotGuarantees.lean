import SnapshotCausality

/-! Exact consistency and robustness guarantees of finite snapshot execution. -/

open scoped BigOperators

namespace FiniteFrontier.SnapshotPlan

variable {n : ℕ} {y : Fin n → ℝ} (p : SnapshotPlan y)
variable (x : PositiveSizes (Fin n)) (hy : ∀ i, 0 < y i)

theorem paid_before_switch_le_virtual (t : ℝ) (hb : t ≤ p.switchTime x) :
    (p.execute x hy).paidCost t ≤ ∑ i : Fin n, min t (p.time (i.val + 1)) := by
  apply Finset.sum_le_sum
  intro i _
  change min t (p.executedCompletion x i) ≤ min t (p.time (i.val + 1))
  by_cases hm : t ≤ p.time (i.val + 1)
  · rw [min_eq_left hm]
    exact min_le_left _ _
  let s := p.time (i.val + 1)
  have hs : 0 ≤ s := p.time_nonneg _
  have hst : s < t := lt_of_not_ge hm
  have hsz := p.planned_service_hit_by_mark i
  have heq : x.val i = y i := by
    by_contra hne
    have h := p.no_wrong_threshold_before_switch x hy s hs (hst.trans_le hb) i hne
    change p.plannedService (p.time (i.val + 1)) i < _ at h
    rw [hsz] at h
    exact (not_lt_of_ge (min_le_right _ _)) h
  have hd := (p.executed_complete_iff x hy i s hs).mp
    ((congrFun (p.executed_service_before x s (hst.le.trans hb)) i).trans (hsz.trans heq.symm))
  exact min_le_min_left _ hd

theorem paid_frozen_before_switch (R : ℝ) (hR : 0 ≤ R) (hp : p.Feasible R)
    (t : ℝ) (ht : 0 ≤ t) (hb : t ≤ p.switchTime x) :
    (p.execute x hy).paidCost t ≤ R * frozenCost ((p.execute x hy).service t) := by
  change _ ≤ R * frozenCost (p.executedService x t)
  rw [p.executed_service_before x t hb]
  exact (p.paid_before_switch_le_virtual x hy t hb).trans
    (p.planned_frozen_invariant R hR hp t ht (hb.trans (p.switch_time_le_end x)))

theorem paid_at_continuation (t : ℝ) (ht : p.switchTime x ≤ t) :
    (p.execute x hy).paidCost t =
      (p.execute x hy).paidCost (p.switchTime x) +
        roundRobinPaid (p.residual x) (roundRobinQuantum (p.residual x) (t - p.switchTime x)) := by
  let s := p.switchTime x
  let r := p.residual x
  let v := t - s
  let q := roundRobinQuantum r v
  have hv : 0 ≤ v := sub_nonneg.mpr ht
  obtain ⟨hq, he⟩ := round_robin_quantum_spec r (p.residual_nonneg x) v hv
  have hc₀ : 0 ≤ roundRobinClock r q :=
    Finset.sum_nonneg fun i _ => le_min (p.residual_nonneg x i) hq
  unfold Run.paidCost roundRobinPaid
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  change min t (p.executedCompletion x i) =
    min s (p.executedCompletion x i) + min (roundRobinClock r q) (roundRobinClock r (r i))
  by_cases hdone : p.switchService x i = x.val i
  · obtain ⟨_, _, hf⟩ := p.completed_by_switch_of_eq x hy i hdone
    change p.firstHit i (x.val i) ≤ s at hf
    have hz : r i = 0 := sub_eq_zero.mpr hdone.symm
    simp only [executedCompletion, if_pos hdone, min_eq_right hf, min_eq_right (hf.trans ht), hz,
      round_robin_clock_zero r (p.residual_nonneg x), min_eq_right hc₀, add_zero]
  have hd := (p.residual_completion_positive x i hdone).le
  have hC : s ≤ s + roundRobinClock r (r i) := le_add_of_nonneg_right hd
  rw [executedCompletion, if_neg hdone]
  change min t (s + roundRobinClock r (r i)) =
    min s (s + roundRobinClock r (r i)) + min (roundRobinClock r q) (roundRobinClock r (r i))
  change roundRobinClock r q = min v (∑ i, r i) at he
  rw [min_eq_left hC, he, min_assoc,
    min_eq_right (round_robin_clock_le_work r (r i)), ← min_add_add_left]
  have ht' : s + v = t := by dsimp [v]; ring
  rw [ht']

theorem execute_prefix_robust (R : ℝ) (hR₀ : 0 ≤ R)
    (hR : baselineRobustness (n : ℝ) ≤ R) (hp : p.Feasible R) (t : ℝ) (ht : 0 ≤ t) :
    (p.execute x hy).paidCost t ≤ R * frozenCost ((p.execute x hy).service t) := by
  rcases le_total t (p.switchTime x) with hb | ha
  · exact p.paid_frozen_before_switch x hy R hR₀ hp t ht hb
  have hpaid := p.paid_frozen_before_switch x hy R hR₀ hp (p.switchTime x)
    (p.switch_time_nonneg x hy) le_rfl
  have hbase : (p.execute x hy).service (p.switchTime x) = p.switchService x :=
    p.executed_service_before x _ le_rfl
  rw [hbase] at hpaid
  have hR' : baselineRobustness (Fintype.card (Fin n) : ℝ) ≤ R := by simpa using hR
  let q := roundRobinQuantum (p.residual x) (t - p.switchTime x)
  have hq : 0 ≤ q := (round_robin_quantum_spec _ (p.residual_nonneg x) _
    (sub_nonneg.mpr ha)).1
  have h := round_robin_preserves_frozen (p.switchService x) (p.residual x) _ R q hR' hR₀ hpaid
    (p.residual_nonneg x) hq
  rw [p.paid_at_continuation x hy t ha]
  change _ ≤ R * frozenCost (p.executedService x t)
  have hsvc : p.executedService x t = fun i => p.switchService x i +
      roundRobinIncrement (p.residual x) q i := funext (p.executed_service_after x t ha)
  rwa [hsvc]

theorem execute_robust (R : ℝ) (hR₀ : 0 ≤ R)
    (hR : baselineRobustness (n : ℝ) ≤ R) (hp : p.Feasible R) :
    (p.execute x hy).cost ≤ R * frozenCost x.val := by
  let r := p.execute x hy
  let t := p.switchTime x + ∑ i, p.residual x i
  have ht : 0 ≤ t := add_nonneg (p.switch_time_nonneg x hy)
    (Finset.sum_nonneg fun i _ => p.residual_nonneg x i)
  have hfinish (i : Fin n) : r.completion i ≤ t := by
    change p.executedCompletion x i ≤ t
    unfold executedCompletion
    split
    · rename_i hi
      exact (p.completed_by_switch_of_eq x hy i hi).2.2.trans
        (le_add_of_nonneg_right (Finset.sum_nonneg fun j _ => p.residual_nonneg x j))
    · exact add_le_add_left (round_robin_clock_le_work _ _) _
  have hc : r.paidCost t = r.cost :=
    Finset.sum_congr rfl fun i _ => min_eq_right (hfinish i)
  have hs : r.service t = x.val := funext fun i => (r.complete_iff i t ht).mpr (hfinish i)
  have hpaid : r.paidCost t ≤ R * frozenCost (r.service t) :=
    p.execute_prefix_robust x hy R hR₀ hR hp t ht
  rwa [hc, hs] at hpaid

theorem execute_correct_cost_le_marked (hx : x.val = y) :
    (p.execute x hy).cost ≤ p.markedCost := by
  apply Finset.sum_le_sum
  intro i _
  change p.executedCompletion x i ≤ p.time (i.val + 1)
  have hmark : p.time (i.val + 1) ≤ p.switchTime x := by
    rw [p.exact_predictions_switch_at_end x hx]
    exact p.time_monotone (Nat.succ_le_of_lt i.isLt)
  apply (p.executed_complete_iff x hy i _ (p.time_nonneg _)).mp
  rw [p.executed_service_before x _ hmark, p.planned_service_hit_by_mark, hx]

/-- Convert the positive-prediction plan construction to a policy against every actual
positive vector. Causality is proved from the earliest observable event. -/
noncomputable def policyOfPlans (plans : ∀ y : PositiveSizes (Fin n), SnapshotPlan y.val) :
    Policy (Fin n) where
  run y x := (plans y).execute x y.property
  prefix_agrees y x z t _ hobs u hu hut :=
    (plans y).execute_prefix x z y.property t hobs u hu hut

theorem policy_of_plans_robust (plans : ∀ y : PositiveSizes (Fin n), SnapshotPlan y.val)
    (R : ℝ) (hR₀ : 0 ≤ R) (hR : baselineRobustness (n : ℝ) ≤ R)
    (hfeas : ∀ y, (plans y).Feasible R) :
    Robust (policyOfPlans plans) R :=
  fun x y => (plans y).execute_robust x y.property R hR₀ hR (hfeas y)

theorem policy_of_plans_consistent (plans : ∀ y : PositiveSizes (Fin n), SnapshotPlan y.val)
    (C : ℝ) (hcost : ∀ y, (plans y).markedCost ≤ C * frozenCost y.val) :
    Consistent (policyOfPlans plans) C :=
  fun y => ((plans y).execute_correct_cost_le_marked y y.property rfl).trans (hcost y)

end FiniteFrontier.SnapshotPlan
