import FiniteStages

/-! The actual finite feasible plan on equal jobs, including the serial branch. -/

open scoped BigOperators

namespace FiniteFrontier

variable {m : ℕ}

theorem capped_unit_level_interval (m R : ℝ) (a : ℕ) (hm : 0 < m)
    (hR : baselineRobustness m ≤ R) (ha : (a : ℝ) < m) (hgap : 0 ≤ unitGap m R a)
    (k : ℕ) : cappedUnitLevel m R a k ∈ Set.Icc 0 1 :=
  active_unit_level_interval m R a hm hR ha hgap _ (min_le_right _ _)

theorem capped_unit_level_zero (m R : ℝ) (a : ℕ) : cappedUnitLevel m R a 0 = 0 := by
  simp [cappedUnitLevel, activeUnitLevel]

/-- Symmetric service only for the construction. The matching lower bound quantifies
over arbitrary schedules and does not impose any condition of this kind. -/
noncomputable def unitSnapshotPlan (m : ℕ) (q : ℕ → ℝ) (hzero : q 0 = 0)
    (hmono : Monotone q) (hmax : ∀ k, q k ≤ 1) : SnapshotPlan (fun _ : Fin m => 1) where
  attained k i := if i.val < k then 1 else q k
  initial := by ext i; simp [hzero]
  monotone i := by
    intro a b hab
    by_cases ha : i.val < a
    · simp [ha, ha.trans_le hab]
    by_cases hb : i.val < b
    · simpa only [if_pos hb, if_neg ha] using hmax a
    · simpa only [if_neg hb, if_neg ha] using hmono hab
  upper k i := by split <;> simp_all
  marked k i hi := if_pos hi

theorem unit_snapshot_time (q : ℕ → ℝ) (hz : q 0 = 0) (hm : Monotone q)
    (hmax : ∀ k, q k ≤ 1) {k : ℕ} (hk : k ≤ m) :
    (unitSnapshotPlan m q hz hm hmax).time k = (k : ℝ) + ((m : ℝ) - k) * q k := by
  have hsum (i : Fin m) : (if i.val < k then 1 else q k) =
      prefixIndicator k i + (if i.val < k then 0 else q k) := by
    by_cases h : i.val < k <;> simp [prefixIndicator, h]
  unfold SnapshotPlan.time
  simp only [unitSnapshotPlan, hsum, Finset.sum_add_distrib]
  rw [sum_prefix_indicator hk, sum_fin_after_const hk]

theorem unit_snapshot_frozen (q : ℕ → ℝ) (hz : q 0 = 0) (hm : Monotone q)
    (hmax : ∀ k, q k ≤ 1) {k : ℕ} (hk : k ≤ m) :
    frozenCost ((unitSnapshotPlan m q hz hm hmax).attained k) =
      triangularCost k + ((m : ℝ) + k + 1) / 2 * (((m : ℝ) - k) * q k) := by
  let p := unitSnapshotPlan m q hz hm hmax
  have hq : 0 ≤ q k := hz ▸ hm (Nat.zero_le k)
  have htail : tailVector k (p.attained k) = tailVector k (fun _ : Fin m => q k) := by
    ext i
    by_cases h : i.val < k <;> simp [p, unitSnapshotPlan, tailVector, h]
  have h := frozen_unit_prefix hk (p.attained k)
    (fun i => ⟨p.attained_nonneg k i, p.upper k i⟩) (p.marked k)
  rw [htail, frozen_tail_constant hk (q k) hq] at h
  change frozenCost (p.attained k) = _
  rw [h]
  change triangularCost (k : ℝ) + (k : ℝ) * (∑ i : Fin m, if i.val < k then 0 else q k) +
    triangularCost ((m : ℝ) - k) * q k = _
  rw [sum_fin_after_const hk]
  unfold triangularCost
  ring

theorem sum_range_after_shift (f : ℕ → ℝ) (k : ℕ) :
    (∑ i ∈ Finset.range k, f (i + 1)) = (∑ i ∈ Finset.range k, f i) + f k - f 0 := by
  have h : (∑ i ∈ Finset.range (k + 1), f i) =
      (∑ i ∈ Finset.range k, f (i + 1)) + f 0 := Finset.sum_range_succ' f k
  rw [Finset.sum_range_succ] at h
  linarith only [h]

noncomputable def unitTailAt (m : ℕ) (q : ℕ → ℝ) (k : ℕ) : ℝ :=
  ((m : ℝ) - k) * q k

theorem unit_snapshot_paid (q : ℕ → ℝ) (hz : q 0 = 0) (hm : Monotone q)
    (hmax : ∀ k, q k ≤ 1) {k : ℕ} (hk : k ≤ m) :
    (unitSnapshotPlan m q hz hm hmax).paidAt k =
      (k : ℝ) * (2 * (m : ℝ) + 1 - k) / 2 +
        (∑ j ∈ Finset.range k, unitTailAt m q j) + ((m : ℝ) - k + 1) * unitTailAt m q k := by
  unfold SnapshotPlan.paidAt
  rw [marked_paid_as_prefix _ hk]
  have h (j : ℕ) (hj : j ∈ Finset.range k) :
      (unitSnapshotPlan m q hz hm hmax).time (j + 1) = (j : ℝ) + 1 + unitTailAt m q (j + 1) := by
    rw [unit_snapshot_time q hz hm hmax ((Nat.succ_le_of_lt (Finset.mem_range.mp hj)).trans hk)]
    simp only [unitTailAt, Nat.cast_succ]
  rw [Finset.sum_congr rfl h, Finset.sum_add_distrib, triangular_sum, sum_range_after_shift,
    unit_snapshot_time q hz hm hmax hk]
  have hzero : unitTailAt m q 0 = 0 := by simp [unitTailAt, hz]
  rw [hzero]
  unfold triangularCost unitTailAt
  ring

noncomputable def snapshotDeficit (m : ℕ) (R : ℝ) (q : ℕ → ℝ) (k : ℕ) : ℝ :=
  unitIntercept m R k + (∑ j ∈ Finset.range k, unitTailAt m q j) -
    unitDenominator m R k * unitTailAt m q k

theorem unit_snapshot_deficit (R : ℝ) (q : ℕ → ℝ) (hz : q 0 = 0) (hm : Monotone q)
    (hmax : ∀ k, q k ≤ 1) {k : ℕ} (hk : k ≤ m) :
    (unitSnapshotPlan m q hz hm hmax).paidAt k -
      R * frozenCost ((unitSnapshotPlan m q hz hm hmax).attained k) = snapshotDeficit m R q k := by
  rw [unit_snapshot_paid q hz hm hmax hk, unit_snapshot_frozen q hz hm hmax hk]
  unfold snapshotDeficit unitIntercept unitDenominator triangularCost unitTailAt
  ring

theorem snapshot_deficit_constant_level (R : ℝ) (q : ℕ → ℝ) (k : ℕ) (hq : q (k + 1) = q k) :
    snapshotDeficit m R q (k + 1) - snapshotDeficit m R q k =
      (1 - q k) * unitGap (m : ℝ) R ((k : ℝ) + 1) := by
  have hA := unit_intercept_step (m : ℝ) R k
  have hD := unit_denominator_complement (m : ℝ) R k
  have hh := congrArg (fun t : ℝ => t * q k) hD
  dsimp at hh
  unfold snapshotDeficit
  rw [Finset.sum_range_succ]
  simp only [unitTailAt, Nat.cast_succ, hq]
  nlinarith only [hA, hh]

/-- Parameter conditions for a branch use two neighboring gap signs.
At a shared endpoint either adjacent branch can be used. -/
structure UnitBranch (m : ℕ) (R : ℝ) (a : ℕ) : Prop where
  numJobs : 0 < m
  robust : baselineRobustness (m : ℝ) ≤ R
  index : a < m
  active : 0 ≤ unitGap (m : ℝ) R a
  inactive : unitGap (m : ℝ) R ((a : ℝ) + 1) ≤ 0

namespace UnitBranch

variable {R : ℝ} {a : ℕ} (b : UnitBranch m R a)

include b

theorem num_jobs_real : 0 < (m : ℝ) := by exact_mod_cast b.numJobs

theorem index_real : (a : ℝ) < (m : ℝ) := by exact_mod_cast b.index

theorem parameter_positive : 0 < R := (base_robustness_positive _ b.num_jobs_real).trans_le b.robust

noncomputable def plan : SnapshotPlan (fun _ : Fin m => 1) :=
  unitSnapshotPlan m (cappedUnitLevel m R a) (capped_unit_level_zero m R a)
    (capped_unit_level_monotone m R a b.num_jobs_real b.robust b.index_real b.active)
    (fun k => (capped_unit_level_interval m R a b.num_jobs_real b.robust b.index_real b.active k).2)

theorem deficit_eq_zero_through_active (k : ℕ) (hk : k ≤ a) :
    snapshotDeficit m R (cappedUnitLevel m R a) k = 0 := by
  cases k with
  | zero =>
    simp [snapshotDeficit, unitIntercept, unitTailAt, capped_unit_level_zero]
  | succ j =>
    have hs := active_unit_prefix_equality (m : ℝ) R a b.num_jobs_real b.robust b.index_real j hk
    unfold snapshotDeficit
    rw [show unitTailAt m (cappedUnitLevel m R a) (j + 1) =
        activeUnitTail m R (j + 1) by simp [unitTailAt, cappedUnitLevel, min_eq_left hk, activeUnitTail]]
    have hsum : (∑ x ∈ Finset.range (j + 1), unitTailAt m (cappedUnitLevel m R a) x) =
        activeUnitTailSum m R j := by
      unfold activeUnitTailSum
      apply Finset.sum_congr rfl
      intro i hi
      have hia := (Nat.le_of_lt (Finset.mem_range.mp hi)).trans hk
      simp [unitTailAt, cappedUnitLevel, min_eq_left hia, activeUnitTail]
    rw [hsum, Nat.cast_succ]
    linarith only [hs]

theorem deficit_nonpos_after_active (k : ℕ) (hk : a ≤ k) :
    snapshotDeficit m R (cappedUnitLevel m R a) k ≤ 0 := by
  induction k, hk using Nat.le_induction with
  | base => rw [b.deficit_eq_zero_through_active a le_rfl]
  | succ k hka ih =>
    have hlevel : cappedUnitLevel m R a (k + 1) = cappedUnitLevel m R a k := by
      simp [cappedUnitLevel, min_eq_right hka, min_eq_right (hka.trans (Nat.le_succ k))]
    have hg : unitGap (m : ℝ) R ((k : ℝ) + 1) ≤ 0 := by
      have hi : (a : ℝ) ≤ k := by exact_mod_cast hka
      have hR : 0 ≤ R + 1 := by have h := b.parameter_positive; linarith
      have hmul := mul_le_mul_of_nonneg_left (add_le_add_right hi 1) hR
      have ha := b.inactive
      unfold unitGap at *
      linarith only [hmul, ha]
    have hq := (capped_unit_level_interval m R a b.num_jobs_real b.robust b.index_real b.active k).2
    have hi := snapshot_deficit_constant_level (m := m) R (cappedUnitLevel m R a) k hlevel
    linarith only [hi, ih, mul_nonpos_of_nonneg_of_nonpos (sub_nonneg.mpr hq) hg]

theorem plan_feasible : b.plan.Feasible R := by
  intro k hk
  apply sub_nonpos.mp
  unfold plan
  rw [unit_snapshot_deficit R _ _ _ _ hk]
  rcases le_total k a with h | h
  · exact (b.deficit_eq_zero_through_active k h).le
  · exact b.deficit_nonpos_after_active k h

end UnitBranch

end FiniteFrontier
