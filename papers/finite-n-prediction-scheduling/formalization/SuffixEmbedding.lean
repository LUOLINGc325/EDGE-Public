import DimensionComparison

/-! Adding zero coordinates and zero marked times for the suffix generators. -/

open scoped BigOperators

namespace FiniteFrontier

variable {m : ℕ}

noncomputable def prependZero (v : Fin m → ℝ) : Fin (m + 1) → ℝ := Fin.cons 0 v

@[simp] theorem prepend_zero_head (v : Fin m → ℝ) : prependZero v 0 = 0 := rfl

@[simp] theorem prepend_zero_succ (v : Fin m → ℝ) (i : Fin m) :
    prependZero v i.succ = v i := by simp [prependZero]

theorem frozen_prepend_zero (v : Fin m → ℝ) (hv : ∀ i, 0 ≤ v i) :
    frozenCost (prependZero v) = frozenCost v := by
  unfold frozenCost
  simp only [Fin.sum_univ_succ, prepend_zero_head, prepend_zero_succ, min_self, zero_add]
  simp [min_eq_left (hv _), min_eq_right (hv _)]

namespace SnapshotPlan

variable {y : Fin m → ℝ}

noncomputable def castPrediction {x z : Fin m → ℝ} (h : x = z) (p : SnapshotPlan x) : SnapshotPlan z :=
  h ▸ p

@[simp] theorem cast_time {x z : Fin m → ℝ} (h : x = z) (p : SnapshotPlan x) (k : ℕ) :
    (castPrediction h p).time k = p.time k := by subst z; rfl

@[simp] theorem cast_marked_cost {x z : Fin m → ℝ} (h : x = z) (p : SnapshotPlan x) :
    (castPrediction h p).markedCost = p.markedCost := by subst z; rfl

@[simp] theorem cast_feasible {x z : Fin m → ℝ} (h : x = z) (p : SnapshotPlan x) (R : ℝ) :
    (castPrediction h p).Feasible R ↔ p.Feasible R := by subst z; rfl

noncomputable def zeroPrepend (p : SnapshotPlan y) : SnapshotPlan (prependZero y) where
  attained k := prependZero (p.attained (k - 1))
  initial := by
    ext i
    refine Fin.cases ?_ (fun j => ?_) i
    · rfl
    · simp [p.initial]
  monotone i := by
    refine Fin.cases ?_ (fun j => ?_) i
    · intro l u _
      simp
    · intro l u hlu
      simpa only [prepend_zero_succ] using p.monotone j (Nat.sub_le_sub_right hlu 1)
  upper k i := Fin.cases (by simp) (fun j => by simpa only [prepend_zero_succ] using p.upper (k - 1) j) i
  marked k i := Fin.cases (fun _ => rfl) (fun j hj => by
    have hj' : j.val < k - 1 := by
      change j.val + 1 < k at hj
      omega
    simpa only [prepend_zero_succ] using p.marked (k - 1) j hj') i

@[simp] theorem prepend_time (p : SnapshotPlan y) (k : ℕ) :
    p.zeroPrepend.time k = p.time (k - 1) := by
  simp [time, zeroPrepend, Fin.sum_univ_succ]

theorem min_shift_down (k j : ℕ) : min k (j + 2) - 1 = min (k - 1) (j + 1) := by
  rcases le_total k (j + 2) with h | h
  · rw [min_eq_left h, min_eq_left (by omega)]
  · rw [min_eq_right h, min_eq_right (by omega)]
    omega

@[simp] theorem prepend_paid (p : SnapshotPlan y) (k : ℕ) :
    p.zeroPrepend.paidAt k = p.paidAt (k - 1) := by
  unfold paidAt
  rw [Fin.sum_univ_succ]
  simp only [prepend_time, Fin.val_zero, zero_add, Fin.val_succ]
  have hfirst : min k 1 - 1 = 0 := by have h := min_le_right k 1; omega
  rw [hfirst, p.time_zero, zero_add]
  exact Finset.sum_congr rfl fun j _ => by rw [min_shift_down]

@[simp] theorem prepend_marked_cost (p : SnapshotPlan y) :
    p.zeroPrepend.markedCost = p.markedCost := by
  rw [← p.paid_at_last, ← p.zeroPrepend.paid_at_last, prepend_paid]
  rfl

theorem prepend_feasible (p : SnapshotPlan y) (R : ℝ) (h : p.Feasible R) :
    p.zeroPrepend.Feasible R := by
  intro k hk
  rw [prepend_paid]
  change p.paidAt (k - 1) ≤ R * frozenCost (prependZero (p.attained (k - 1)))
  rw [frozen_prepend_zero _ (p.attained_nonneg _)]
  exact h (k - 1) (by omega)

noncomputable def prependZeros (y : Fin m → ℝ) : (d : ℕ) → Fin (m + d) → ℝ
  | 0 => y
  | d + 1 => prependZero (prependZeros y d)

noncomputable def pad (p : SnapshotPlan y) : (d : ℕ) → SnapshotPlan (prependZeros y d)
  | 0 => p
  | d + 1 => zeroPrepend (pad p d)

theorem pad_marked_cost (p : SnapshotPlan y) (d : ℕ) :
    (p.pad d).markedCost = p.markedCost := by
  induction d with
  | zero => rfl
  | succ d ih => rw [pad, prepend_marked_cost, ih]

theorem pad_feasible (p : SnapshotPlan y) (R : ℝ) (h : p.Feasible R) (d : ℕ) :
    (p.pad d).Feasible R := by
  induction d with
  | zero => exact h
  | succ d ih => exact prepend_feasible _ R ih

end SnapshotPlan

noncomputable def suffix (n d : ℕ) (i : Fin n) : ℝ := if i.val < d then 0 else 1

theorem prepend_unit_is_suffix (m d : ℕ) :
    SnapshotPlan.prependZeros (fun _ : Fin m => (1 : ℝ)) d = suffix (m + d) d := by
  induction d with
  | zero => funext i; simp [SnapshotPlan.prependZeros, suffix]
  | succ d ih =>
    rw [SnapshotPlan.prependZeros, ih]
    funext i
    refine Fin.cases ?_ (fun j => ?_) i
    · simp [suffix]
    · simp [suffix, Nat.succ_lt_succ_iff]

theorem suffix_mono (n d : ℕ) : Monotone (suffix n d) := by
  intro i j hij
  have hij' : i.val ≤ j.val := hij
  unfold suffix
  by_cases hi : i.val < d
  · by_cases hj : j.val < d <;> simp [hi, hj]
  have hj : ¬ j.val < d := by omega
  simp [hi, hj]

noncomputable def asSuffixPlan {n : ℕ} (d : ℕ) (he : m + d = n)
    (p : SnapshotPlan (fun _ : Fin m => 1)) : SnapshotPlan (suffix n d) := by
  subst n
  exact SnapshotPlan.castPrediction (prepend_unit_is_suffix m d) (p.pad d)

theorem suffix_plan_marked_cost {n : ℕ} (d : ℕ) (he : m + d = n)
    (p : SnapshotPlan (fun _ : Fin m => 1)) :
    (asSuffixPlan d he p).markedCost = p.markedCost := by
  subst n
  simp [asSuffixPlan, SnapshotPlan.pad_marked_cost]

theorem suffix_plan_feasible {n : ℕ} (d : ℕ) (he : m + d = n)
    (p : SnapshotPlan (fun _ : Fin m => 1)) (R : ℝ) (h : p.Feasible R) :
    (asSuffixPlan d he p).Feasible R := by
  subst n
  simpa only [asSuffixPlan, SnapshotPlan.cast_feasible] using p.pad_feasible R h d

theorem frozen_suffix {n d : ℕ} (hd : d ≤ n) :
    frozenCost (suffix n d) = triangularCost (n - d : ℕ) := by
  have h : tailVector d (fun _ : Fin n => (1 : ℝ)) = suffix n d := rfl
  rw [← h, frozen_tail_constant hd 1 zero_le_one, mul_one, Nat.cast_sub hd]

end FiniteFrontier
