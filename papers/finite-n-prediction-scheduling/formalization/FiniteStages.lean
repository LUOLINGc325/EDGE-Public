import SnapshotGuarantees
import UnitProduct

/-! Finite prefix sums used by both the candidate unit plan and the arbitrary-run lower bound. -/

open scoped BigOperators

namespace FiniteFrontier

variable {m : ℕ}

/-- Counting measure of the first k ranks. -/
def prefixIndicator (k : ℕ) (i : Fin m) : ℝ := if i.val < k then 1 else 0

/-- Remove the first k ranks algebraically, preserving all remaining attained services. -/
def tailVector (k : ℕ) (v : Fin m → ℝ) (i : Fin m) : ℝ := if i.val < k then 0 else v i

theorem sum_fin_before (f : ℕ → ℝ) {k : ℕ} (hk : k ≤ m) :
    (∑ i : Fin m, if i.val < k then f i.val else 0) = ∑ i ∈ Finset.range k, f i := by
  rw [Fin.sum_univ_eq_sum_range (fun i => if i < k then f i else 0)]
  rw [← Finset.sum_subset (Finset.range_mono hk)]
  · exact Finset.sum_congr rfl fun i hi => if_pos (Finset.mem_range.mp hi)
  · exact fun i _ hi => if_neg (fun hn => hi (Finset.mem_range.mpr hn))

theorem sum_prefix_indicator {k : ℕ} (hk : k ≤ m) :
    (∑ i : Fin m, prefixIndicator k i) = (k : ℝ) := by
  unfold prefixIndicator
  rw [sum_fin_before (fun _ => 1) hk]
  simp

theorem sum_fin_after_const {k : ℕ} (hk : k ≤ m) (q : ℝ) :
    (∑ i : Fin m, if i.val < k then 0 else q) = ((m : ℝ) - k) * q := by
  have h (i : Fin m) :
      (if i.val < k then 0 else q) = q - (if i.val < k then q else 0) := by
    split <;> simp_all
  simp_rw [h]
  rw [Finset.sum_sub_distrib, sum_fin_before (fun _ => q) hk]
  simp
  ring

theorem triangular_sum (k : ℕ) :
    (∑ j ∈ Finset.range k, ((j : ℝ) + 1)) = triangularCost k := by
  induction k with
  | zero => simp [triangularCost]
  | succ k ih =>
    rw [Finset.sum_range_succ, ih, Nat.cast_succ]
    unfold triangularCost
    ring

/-- Formula (2) in a form that is also valid at stage zero. -/
theorem marked_paid_as_prefix (time : ℕ → ℝ) {k : ℕ} (hk : k ≤ m) :
    (∑ i : Fin m, time (min k (i.val + 1))) =
      (∑ j ∈ Finset.range k, time (j + 1)) + ((m : ℝ) - k) * time k := by
  have h (i : Fin m) :
      time (min k (i.val + 1)) = (if i.val < k then time (i.val + 1) else 0) +
        (if i.val < k then 0 else time k) := by
    by_cases hi : i.val < k
    · simp [hi, min_eq_right (Nat.succ_le_of_lt hi)]
    · simp [hi, min_eq_left (Nat.le_succ_of_le (Nat.le_of_not_gt hi))]
  simp_rw [h]
  rw [Finset.sum_add_distrib, sum_fin_before (fun j => time (j + 1)) hk,
    sum_fin_after_const hk (time k)]

theorem frozen_unit_prefix {k : ℕ} (hk : k ≤ m) (v : Fin m → ℝ)
    (hv : ∀ i, v i ∈ Set.Icc 0 1) (hprefix : ∀ i, i.val < k → v i = 1) :
    frozenCost v = triangularCost k + (k : ℝ) * (∑ i, tailVector k v i) +
      frozenCost (tailVector k v) := by
  let e := tailVector k v
  let b : Fin m → ℝ := prefixIndicator k
  have hvalue (i : Fin m) : v i = b i + e i := by
    by_cases h : i.val < k
    · simp [b, e, prefixIndicator, tailVector, h, hprefix i h]
    · simp [b, e, prefixIndicator, tailVector, h]
  have hpair (i j : Fin m) :
      min (v i) (v j) = b i * b j + b i * e j + e i * b j + min (e i) (e j) := by
    by_cases hi : i.val < k
    · by_cases hj : j.val < k
      · simp [b, e, prefixIndicator, tailVector, hi, hj, hprefix i hi, hprefix j hj]
      · simp [b, e, prefixIndicator, tailVector, hi, hj, hprefix i hi,
          min_eq_right (hv j).2, min_eq_left (hv j).1]
    by_cases hj : j.val < k
    · simp [b, e, prefixIndicator, tailVector, hi, hj, hprefix j hj,
        min_eq_left (hv i).2, min_eq_right (hv i).1]
    · simp [b, e, prefixIndicator, tailVector, hi, hj]
  have hb : (∑ i, b i) = (k : ℝ) := sum_prefix_indicator hk
  have hsum : (∑ i, v i) = (k : ℝ) + ∑ i, e i := by
    conv_lhs => simp only [hvalue, Finset.sum_add_distrib, hb]
  have hdouble :
      (∑ i, ∑ j, min (v i) (v j)) =
        (k : ℝ) * k + (k : ℝ) * (∑ i, e i) + (∑ i, e i) * (k : ℝ) + ∑ i, ∑ j, min (e i) (e j) := by
    calc
      _ = ∑ i, ∑ j, (b i * b j + b i * e j + e i * b j + min (e i) (e j)) :=
        Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => hpair i j
      _ = _ := by
        simp only [Finset.sum_add_distrib]
        simp_rw [← Finset.mul_sum, ← Finset.sum_mul, hb]
  unfold frozenCost triangularCost
  change ((∑ i, v i) + ∑ i, ∑ j, min (v i) (v j)) / 2 =
    (k : ℝ) * ((k : ℝ) + 1) / 2 + (k : ℝ) * (∑ i, e i) +
      ((∑ i, e i) + ∑ i, ∑ j, min (e i) (e j)) / 2
  rw [hsum, hdouble]
  ring

theorem frozen_tail_upper {k : ℕ} (hk : k ≤ m) (v : Fin m → ℝ) :
    frozenCost (tailVector k v) ≤ ((m : ℝ) - k + 1) / 2 * ∑ i, tailVector k v i := by
  let e := tailVector k v
  have hpair (i j : Fin m) :
      min (e i) (e j) ≤ if j.val < k then 0 else e i := by
    by_cases h : j.val < k
    · rw [if_pos h]
      exact (min_le_right (e i) (e j)).trans_eq (if_pos h)
    · rw [if_neg h]
      exact min_le_left _ _
  have hs (i : Fin m) :
      (∑ j, min (e i) (e j)) ≤ ((m : ℝ) - k) * e i :=
    (Finset.sum_le_sum fun j _ => hpair i j).trans_eq (sum_fin_after_const hk (e i))
  have hd := Finset.sum_le_sum fun i (_ : i ∈ Finset.univ) => hs i
  rw [← Finset.mul_sum] at hd
  unfold frozenCost
  change ((∑ i, e i) + ∑ i, ∑ j, min (e i) (e j)) / 2 ≤
    ((m : ℝ) - k + 1) / 2 * ∑ i, e i
  linarith only [hd]

theorem frozen_tail_constant {k : ℕ} (hk : k ≤ m) (q : ℝ) (hq : 0 ≤ q) :
    frozenCost (tailVector k (fun _ : Fin m => q)) = triangularCost ((m : ℝ) - k) * q := by
  let e := tailVector k (fun _ : Fin m => q)
  have hs : (∑ i, e i) = ((m : ℝ) - k) * q := sum_fin_after_const hk q
  have hp (i j : Fin m) :
      min (e i) (e j) = if j.val < k then 0 else e i := by
    by_cases hi : i.val < k <;> by_cases hj : j.val < k <;>
      simp [e, tailVector, hi, hj, min_eq_left hq, min_eq_right hq]
  have hd (i : Fin m) : (∑ j, min (e i) (e j)) = ((m : ℝ) - k) * e i :=
    (Finset.sum_congr rfl fun j _ => hp i j).trans (sum_fin_after_const hk (e i))
  unfold frozenCost triangularCost
  change ((∑ i, e i) + ∑ i, ∑ j, min (e i) (e j)) / 2 = _
  simp_rw [hd, ← Finset.mul_sum, hs]
  ring

end FiniteFrontier
