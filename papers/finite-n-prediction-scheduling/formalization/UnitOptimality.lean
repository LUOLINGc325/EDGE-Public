import UnitRunLower

/-! Matching optimality and exact value for each unit instance. -/

open scoped BigOperators

namespace FiniteFrontier

variable {m a : ℕ} {R : ℝ}

theorem triangular_sum_descending (k : ℕ) :
    (∑ j ∈ Finset.range k, ((k : ℝ) - (j : ℝ))) = triangularCost k := by
  have h := triangular_sum k
  rw [Finset.sum_add_distrib] at h
  rw [Finset.sum_sub_distrib]
  simp only [Finset.sum_const, Finset.card_range, nsmul_eq_mul] at h ⊢
  unfold triangularCost at *
  nlinarith only [h]

namespace UnitBranch

variable (b : UnitBranch m R a)

theorem plan_marked_cost :
    b.plan.markedCost = triangularCost m * unitValue m R a := by
  let q := cappedUnitLevel (m : ℝ) R a
  let E := unitTailAt m q
  unfold SnapshotPlan.markedCost
  have ht (i : Fin m) : b.plan.time (i.val + 1) = (i.val : ℝ) + 1 + E (i.val + 1) := by
    unfold plan
    rw [unit_snapshot_time _ _ _ _ (Nat.succ_le_of_lt i.isLt)]
    simp only [E, q, unitTailAt, Nat.cast_succ]
  rw [Finset.sum_congr rfl (fun i _ => ht i), Finset.sum_add_distrib]
  rw [Fin.sum_univ_eq_sum_range (fun i => (i : ℝ) + 1) m, triangular_sum]
  rw [Fin.sum_univ_eq_sum_range (fun i => E (i + 1)), sum_range_after_shift]
  have h0 : E 0 = 0 := by simp [E, unitTailAt, q, capped_unit_level_zero]
  have hM : E m = 0 := by simp [E, unitTailAt]
  rw [hM, add_zero, h0, sub_zero]
  have hsplit : (∑ j ∈ Finset.range m, E j) =
      (∑ j ∈ Finset.range a, activeUnitTail m R j) +
        triangularCost ((m : ℝ) - a) * activeUnitLevel m R a := by
    have hindex := b.index.le
    have hrepl : ∀ j ∈ Finset.range a, E j = activeUnitTail m R j := by
      intro j hj
      simp [E, unitTailAt, q, cappedUnitLevel, activeUnitTail,
        min_eq_left (Nat.le_of_lt (Finset.mem_range.mp hj))]
    have hshift (j : ℕ) :
        E (a + j) = (((m - a : ℕ) : ℝ) - j) * activeUnitLevel m R a := by
      simp only [E, q, unitTailAt, cappedUnitLevel, min_eq_right (Nat.le_add_right a j),
        Nat.cast_sub hindex, Nat.cast_add]
      ring
    calc
      _ = ∑ j ∈ Finset.range (a + (m - a)), E j := by rw [Nat.add_sub_of_le hindex]
      _ = _ := by
        rw [Finset.sum_range_add, Finset.sum_congr rfl hrepl]
        simp only [hshift, ← Finset.sum_mul]
        rw [triangular_sum_descending, Nat.cast_sub hindex]
  rw [hsplit]
  cases a with
  | zero => simp [unitValue, activeUnitLevel]
  | succ a =>
    rw [unitValue]
    change triangularCost m +
        ((∑ j ∈ Finset.range (a + 1), activeUnitTail m R j) +
          triangularCost ((m : ℝ) - (a + 1 : ℕ)) * activeUnitLevel m R (a + 1)) =
      triangularCost m * (1 +
        (activeUnitTailSum m R a + ((m : ℝ) - (a + 1 : ℕ) + 1) / 2 *
          activeUnitTail m R (a + 1)) / triangularCost m)
    have hp : 0 < triangularCost (m : ℝ) := by
      have h := b.num_jobs_real
      unfold triangularCost
      positivity
    rw [mul_add, mul_one, mul_comm (triangularCost (m : ℝ)), div_mul_cancel₀ _ hp.ne']
    unfold activeUnitTailSum activeUnitTail triangularCost
    ring

variable (r : UnitRun m) (hsorted : Monotone r.completion)
variable (hrob : ∀ t, 0 ≤ t → r.paidCost t ≤ R * frozenCost (r.service t))

include b hsorted hrob in
theorem actual_tail_ge_optimal : ∀ i ≤ a, activeUnitTail m R i ≤ r.tailTotal i := by
  intro i
  induction i using Nat.strong_induction_on with
  | h i ih =>
    intro hi
    cases i with
    | zero => simp [activeUnitTail, activeUnitLevel]
    | succ i =>
      have hden : 0 < unitDenominator (m : ℝ) R ((i : ℝ) + 1) :=
        unit_denominator_positive _ _ _ b.num_jobs_real b.robust (by linarith)
      have hp := r.prefix_denominator_bound hsorted R b.parameter_positive.le hrob (hi.trans b.index.le)
      rw [Nat.cast_succ] at hp
      have hunit := active_unit_prefix_equality (m : ℝ) R a b.num_jobs_real b.robust b.index_real i hi
      have hterms : activeUnitTailSum m R i ≤ r.tailPrefix (i + 1) := by
        apply Finset.sum_le_sum
        intro j hj
        have hj' := Finset.mem_range.mp hj
        exact ih j hj' (hj'.le.trans hi)
      apply (mul_le_mul_left hden).mp
      linarith only [hp, hunit, hterms]

include b hsorted hrob in
/-- Unit-instance lower bound with no service symmetry restriction. -/
theorem optimal_lower_sorted :
    triangularCost m * unitValue m R a ≤ r.cost := by
  cases a with
  | zero =>
    have h := r.cost_excess_ge_tail_sum hsorted
    have hsum : 0 ≤ ∑ i : Fin m, r.tailTotal (i.val + 1) :=
      Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => r.tail_nonneg (i.val + 1) j
    rw [unitValue, mul_one]
    linarith only [h, hsum]
  | succ a' =>
    have hE := b.actual_tail_ge_optimal r hsorted hrob (a' + 1) le_rfl
    have hS : activeUnitTailSum m R a' ≤ r.tailPrefix (a' + 1) := by
      apply Finset.sum_le_sum
      intro j hj
      exact b.actual_tail_ge_optimal r hsorted hrob j (Nat.le_of_lt (Finset.mem_range.mp hj))
    let k : ℝ := (a' : ℝ) + 1
    have ha : (↑(a' + 1) : ℝ) = k := Nat.cast_succ _
    have hc := r.cost_excess_ge_charged_tail hsorted b.index.le
    have hq := r.prefix_unsimplified_bound hsorted R hrob b.index.le
    rw [ha] at hq
    have hp := active_unit_prefix_equality (m : ℝ) R (a' + 1)
      b.num_jobs_real b.robust b.index_real a' le_rfl
    change unitDenominator (m : ℝ) R k * activeUnitTail m R (a' + 1) =
      unitIntercept (m : ℝ) R k + activeUnitTailSum m R a' at hp
    have hR := b.parameter_positive
    have hδ := b.active
    rw [ha] at hδ
    have hb : (0 : ℝ) < triangularCost m := by
      have h := b.num_jobs_real
      unfold triangularCost
      positivity
    have hadd := unit_denominator_plus_gap (m : ℝ) R k
    have hprod := congrArg (fun v : ℝ => v * activeUnitTail m R (a' + 1)) hadd
    dsimp at hprod
    rw [unitValue, ha]
    have hf :
        triangularCost m * (1 + (activeUnitTailSum m R a' +
          ((m : ℝ) - k + 1) / 2 * activeUnitTail m R (a' + 1)) / triangularCost m) =
          triangularCost m + (activeUnitTailSum m R a' +
          ((m : ℝ) - k + 1) / 2 * activeUnitTail m R (a' + 1)) := by
      calc
        _ = _ + ((activeUnitTailSum m R a' +
            ((m : ℝ) - k + 1) / 2 * activeUnitTail m R (a' + 1)) / triangularCost m) *
              triangularCost m := by ring
        _ = _ := by rw [div_mul_cancel₀ _ hb.ne']
    rw [hf]
    apply (mul_le_mul_left hR).mp
    nlinarith only [mul_le_mul_of_nonneg_left hc hR.le, hq, hp, hprod, hS,
      mul_le_mul_of_nonneg_left hS hR.le, mul_le_mul_of_nonneg_left hE hδ]

include b in
/-- The lower bound applies to an arbitrary robust policy on positive instances. -/
theorem policy_unit_lower (A : Policy (Fin m)) (hA : Robust A R) :
    triangularCost m * unitValue m R a ≤
      (A.run ⟨fun _ => 1, fun _ => zero_lt_one⟩ ⟨fun _ => 1, fun _ => zero_lt_one⟩).cost := by
  let ones : PositiveSizes (Fin m) := ⟨fun _ => 1, fun _ => zero_lt_one⟩
  let r := A.run ones ones
  let σ := Tuple.sort r.completion
  let s : UnitRun m := r.reindex σ
  have hsorted : Monotone s.completion := Tuple.monotone_sort r.completion
  have hcost : s.cost = r.cost := r.reindex_cost σ
  have hb (t : ℝ) (ht : 0 ≤ t) : s.paidCost t ≤ R * frozenCost (s.service t) := by
    change (r.reindex σ).paidCost t ≤ R * frozenCost (r.service t ∘ σ)
    rw [r.reindex_paid_cost, frozen_reindex]
    exact robustness_requires_frozen A R b.parameter_positive.le hA ones ones t ht
  exact (b.optimal_lower_sorted s hsorted hb).trans_eq hcost

end UnitBranch

end FiniteFrontier
