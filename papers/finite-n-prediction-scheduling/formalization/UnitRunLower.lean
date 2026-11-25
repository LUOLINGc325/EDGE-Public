import UnitPlan

/-! The finite unit-instance lower bound, expressed on arbitrary legal trajectories.
Relabeling by actual completion times permits ties, idling and unequal attained services. -/

open scoped BigOperators

namespace FiniteFrontier

variable {m : ℕ}

abbrev UnitRun (m : ℕ) := Run (fun _ : Fin m => (1 : ℝ))

namespace UnitRun

variable (r : UnitRun m)

noncomputable def stage : ℕ → ℝ
  | 0 => 0
  | k + 1 => if h : k < m then r.completion ⟨k, h⟩ else r.cost

@[simp] theorem stage_zero : r.stage 0 = 0 := rfl

@[simp] theorem stage_completion (i : Fin m) : r.stage (i.val + 1) = r.completion i := by
  rw [stage, dif_pos i.isLt]

theorem stage_nonneg (k : ℕ) : 0 ≤ r.stage k := by
  cases k with
  | zero => exact le_rfl
  | succ k =>
    rw [stage]
    split
    · exact (r.completion_pos _).le
    · exact Finset.sum_nonneg fun i _ => (r.completion_pos i).le

theorem stage_monotone (hsorted : Monotone r.completion) : Monotone r.stage := by
  apply monotone_nat_of_le_succ
  intro k
  cases k with
  | zero => exact r.stage_nonneg 1
  | succ k =>
    rw [stage, stage]
    by_cases h : k < m
    · rw [dif_pos h]
      by_cases h' : k + 1 < m
      · rw [dif_pos h']
        exact hsorted (show (⟨k, h⟩ : Fin m) ≤ ⟨k + 1, h'⟩ from Nat.le_succ k)
      rw [dif_neg h']
      exact Finset.single_le_sum (f := r.completion) (fun i _ => (r.completion_pos i).le)
        (Finset.mem_univ (⟨k, h⟩ : Fin m))
    have h' : ¬ k + 1 < m := by omega
    rw [dif_neg h, dif_neg h']

noncomputable def work (k : ℕ) : Fin m → ℝ := r.service (r.stage k)

noncomputable def tail (k : ℕ) : Fin m → ℝ := tailVector k (r.work k)

noncomputable def tailTotal (k : ℕ) : ℝ := ∑ i, r.tail k i

noncomputable def tailPrefix (k : ℕ) : ℝ := ∑ j ∈ Finset.range k, r.tailTotal j

theorem work_bounds (k : ℕ) (i : Fin m) : r.work k i ∈ Set.Icc 0 1 :=
  ⟨r.service_nonneg i _ (r.stage_nonneg k), r.service_le_size i _ (r.stage_nonneg k)⟩

theorem work_prefix (hsorted : Monotone r.completion) (k : ℕ) (i : Fin m) (hi : i.val < k) :
    r.work k i = 1 := by
  apply (r.complete_iff i _ (r.stage_nonneg k)).mpr
  rw [← r.stage_completion i]
  exact r.stage_monotone hsorted (Nat.succ_le_of_lt hi)

@[simp] theorem tail_total_zero : r.tailTotal 0 = 0 := by
  simp [tailTotal, tail, tailVector, work, r.service_zero]

theorem tail_nonneg (k : ℕ) (i : Fin m) : 0 ≤ r.tail k i := by
  unfold tail tailVector
  split
  · exact le_rfl
  · exact (r.work_bounds k i).1

theorem time_capacity_lower (hsorted : Monotone r.completion) {k : ℕ} (hk : k ≤ m) :
    (k : ℝ) + r.tailTotal k ≤ r.stage k := by
  have hwork (i : Fin m) : r.work k i = prefixIndicator k i + r.tail k i := by
    by_cases h : i.val < k
    · rw [r.work_prefix hsorted k i h]
      simp [prefixIndicator, tail, tailVector, h]
    · simp [prefixIndicator, tail, tailVector, h]
  have hsum : (∑ i, r.work k i) = (k : ℝ) + r.tailTotal k := by
    simp only [hwork, Finset.sum_add_distrib, sum_prefix_indicator hk, tailTotal]
  exact hsum ▸ r.service_sum_le (r.stage k) (r.stage_nonneg k)

theorem paid_as_times (hsorted : Monotone r.completion) {k : ℕ} (hk : k ≤ m) :
    r.paidCost (r.stage k) =
      (∑ j ∈ Finset.range k, r.stage (j + 1)) + ((m : ℝ) - k) * r.stage k := by
  unfold Run.paidCost
  have h (i : Fin m) : min (r.stage k) (r.completion i) = r.stage (min k (i.val + 1)) := by
    rw [← r.stage_completion i]
    rcases le_total k (i.val + 1) with h | h
    · rw [min_eq_left (r.stage_monotone hsorted h), min_eq_left h]
    · rw [min_eq_right (r.stage_monotone hsorted h), min_eq_right h]
  simp only [h]
  exact marked_paid_as_prefix r.stage hk

theorem paid_lower (hsorted : Monotone r.completion) {k : ℕ} (hk : k ≤ m) :
    (k : ℝ) * (2 * (m : ℝ) + 1 - k) / 2 +
      r.tailPrefix k + ((m : ℝ) - k + 1) * r.tailTotal k ≤ r.paidCost (r.stage k) := by
  have hs := r.time_capacity_lower hsorted hk
  have hC : 0 ≤ (m : ℝ) - k := sub_nonneg.mpr (by exact_mod_cast hk)
  have hlast := mul_le_mul_of_nonneg_left hs hC
  have hsmall :
      (∑ j ∈ Finset.range k, ((j : ℝ) + 1 + r.tailTotal (j + 1))) ≤
        ∑ j ∈ Finset.range k, r.stage (j + 1) := by
    apply Finset.sum_le_sum
    intro j hj
    simpa only [Nat.cast_succ] using
      r.time_capacity_lower hsorted ((Nat.succ_le_of_lt (Finset.mem_range.mp hj)).trans hk)
  rw [Finset.sum_add_distrib, triangular_sum, sum_range_after_shift,
    r.tail_total_zero, sub_zero] at hsmall
  rw [r.paid_as_times hsorted hk]
  unfold triangularCost at hsmall
  unfold tailPrefix
  linarith only [hsmall, hlast]

theorem frozen_at_stage (hsorted : Monotone r.completion) {k : ℕ} (hk : k ≤ m) :
    frozenCost (r.work k) = triangularCost k + (k : ℝ) * r.tailTotal k +
      frozenCost (r.tail k) :=
  frozen_unit_prefix hk (r.work k) (r.work_bounds k) (r.work_prefix hsorted k)

theorem cost_excess_ge_tail_sum (hsorted : Monotone r.completion) :
    (∑ i : Fin m, r.tailTotal (i.val + 1)) ≤ r.cost - triangularCost m := by
  have h (i : Fin m) : (i.val : ℝ) + 1 + r.tailTotal (i.val + 1) ≤ r.completion i := by
    simpa only [Nat.cast_succ, r.stage_completion] using
      r.time_capacity_lower hsorted (Nat.succ_le_of_lt i.isLt)
  have hsum := Finset.sum_le_sum fun i (_ : i ∈ Finset.univ) => h i
  rw [Finset.sum_add_distrib, Fin.sum_univ_eq_sum_range (fun i => (i : ℝ) + 1), triangular_sum] at hsum
  unfold Run.cost
  linarith only [hsum]

/-- Each pair that survives stage k is charged at the earlier completion rank
of the two jobs, so arbitrarily uneven attained services are allowed. -/
theorem pair_charging (hsorted : Monotone r.completion) (k : ℕ) :
    (∑ i : Fin m, ∑ j : Fin m, if i < j then min (r.tail k i) (r.tail k j) else 0) ≤
      ∑ i : Fin m, if i.val < k then 0 else r.tailTotal (i.val + 1) := by
  apply Finset.sum_le_sum
  intro i _
  by_cases h₀ : i.val < k
  · rw [if_pos h₀]
    have he : r.tail k i = 0 := if_pos h₀
    simp [he, min_eq_left (r.tail_nonneg k _)]
  rw [if_neg h₀]
  apply Finset.sum_le_sum
  intro j _
  by_cases hij : i < j
  · rw [if_pos hij]
    have hkj : ¬ j.val < k := by
      intro hc
      exact h₀ ((show i.val < j.val from hij).trans hc)
    have hnj : ¬ j.val < i.val + 1 :=
      not_lt_of_ge (Nat.succ_le_of_lt (show i.val < j.val from hij))
    have htime := r.stage_monotone hsorted
      (Nat.le_succ_of_le (Nat.le_of_not_gt h₀))
    have hservice := r.service_mono j _ _ (r.stage_nonneg k) htime
    have hstart : r.tail k j = r.service (r.stage k) j := if_neg hkj
    have hend : r.tail (i.val + 1) j = r.service (r.stage (i.val + 1)) j := if_neg hnj
    exact (min_le_right _ _).trans (hstart.symm ▸ hend.symm ▸ hservice)
  rw [if_neg hij]
  exact r.tail_nonneg _ _

theorem cost_excess_ge_charged_tail (hsorted : Monotone r.completion) {k : ℕ} (hk : k ≤ m) :
    r.tailPrefix k + frozenCost (r.tail k) ≤ r.cost - triangularCost m := by
  have hparts (i : Fin m) : r.tailTotal (i.val + 1) =
      (if i.val < k then r.tailTotal (i.val + 1) else 0) +
        (if i.val < k then 0 else r.tailTotal (i.val + 1)) := by
    by_cases h : i.val < k <;> simp [h]
  have hsplit :
      (∑ i : Fin m, r.tailTotal (i.val + 1)) =
        r.tailPrefix k + r.tailTotal k +
          ∑ i : Fin m, if i.val < k then 0 else r.tailTotal (i.val + 1) := by
    calc
      _ = ∑ i : Fin m, ((if i.val < k then r.tailTotal (i.val + 1) else 0) +
          (if i.val < k then 0 else r.tailTotal (i.val + 1))) :=
        Finset.sum_congr rfl fun i _ => hparts i
      _ = _ := by
        rw [Finset.sum_add_distrib, sum_fin_before (fun j => r.tailTotal (j + 1)) hk,
          sum_range_after_shift, r.tail_total_zero, sub_zero, tailPrefix]
  have hcost := r.cost_excess_ge_tail_sum hsorted
  rw [hsplit] at hcost
  have hcharge := r.pair_charging hsorted k
  rw [frozen_off_diagonal]
  change r.tailPrefix k + (r.tailTotal k + _) ≤ _
  linarith only [hcharge, hcost]

theorem prefix_denominator_bound (hsorted : Monotone r.completion) (R : ℝ) (hR : 0 ≤ R)
    (hrob : ∀ t, 0 ≤ t → r.paidCost t ≤ R * frozenCost (r.service t))
    {k : ℕ} (hk : k ≤ m) :
    unitIntercept (m : ℝ) R k + r.tailPrefix k ≤
      unitDenominator (m : ℝ) R k * r.tailTotal k := by
  have h := hrob (r.stage k) (r.stage_nonneg k)
  change r.paidCost (r.stage k) ≤ R * frozenCost (r.work k) at h
  rw [r.frozen_at_stage hsorted hk] at h
  have hf := frozen_tail_upper hk (r.work k)
  change frozenCost (r.tail k) ≤ _ * r.tailTotal k at hf
  have htail := mul_le_mul_of_nonneg_left hf hR
  have hl := r.paid_lower hsorted hk
  unfold unitIntercept unitDenominator triangularCost at *
  linarith only [h, htail, hl]

theorem prefix_unsimplified_bound (hsorted : Monotone r.completion) (R : ℝ)
    (hrob : ∀ t, 0 ≤ t → r.paidCost t ≤ R * frozenCost (r.service t))
    {k : ℕ} (hk : k ≤ m) :
    unitIntercept (m : ℝ) R k + r.tailPrefix k + unitGap (m : ℝ) R k * r.tailTotal k ≤
      R * frozenCost (r.tail k) := by
  have h := hrob (r.stage k) (r.stage_nonneg k)
  change r.paidCost (r.stage k) ≤ R * frozenCost (r.work k) at h
  rw [r.frozen_at_stage hsorted hk] at h
  have hl := r.paid_lower hsorted hk
  unfold unitIntercept unitGap triangularCost at *
  linarith only [h, hl]

end UnitRun

end FiniteFrontier
