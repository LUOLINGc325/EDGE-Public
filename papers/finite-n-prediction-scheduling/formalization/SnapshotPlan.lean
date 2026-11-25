import OfflineOptimum

/-! Completion snapshots, the marked objective, and common-order combinations. -/

open scoped BigOperators

namespace FiniteFrontier

variable {n : ℕ}

structure SnapshotPlan (prediction : Fin n → ℝ) where
  attained : ℕ → Fin n → ℝ
  initial : attained 0 = 0
  monotone : ∀ i, Monotone (fun k => attained k i)
  upper : ∀ k i, attained k i ≤ prediction i
  marked : ∀ k i, i.val < k → attained k i = prediction i

namespace SnapshotPlan

variable {y : Fin n → ℝ} (p : SnapshotPlan y)

theorem attained_nonneg (k : ℕ) (i : Fin n) : 0 ≤ p.attained k i := by
  have h := p.monotone i (Nat.zero_le k)
  simpa only [p.initial, Pi.zero_apply] using h

@[simp] theorem attained_at_last : p.attained n = y :=
  funext fun i => p.marked n i i.isLt

noncomputable def time (k : ℕ) : ℝ := ∑ i, p.attained k i

theorem time_monotone : Monotone p.time := by
  intro u v h
  exact Finset.sum_le_sum fun i _ => p.monotone i h

@[simp] theorem time_zero : p.time 0 = 0 := by simp [time, p.initial]

theorem time_nonneg (k : ℕ) : 0 ≤ p.time k :=
  Finset.sum_nonneg fun i _ => p.attained_nonneg k i

theorem no_work_zero_phase (k : ℕ) (ht : p.time (k + 1) = p.time k) :
    p.attained (k + 1) = p.attained k := by
  have hnonneg (i : Fin n) : 0 ≤ p.attained (k + 1) i - p.attained k i :=
    sub_nonneg.mpr (p.monotone i (Nat.le_succ k))
  have hsum : (∑ i, (p.attained (k + 1) i - p.attained k i)) = 0 := by
    rw [Finset.sum_sub_distrib]
    exact sub_eq_zero.mpr ht
  funext i
  have h := Finset.single_le_sum (f := fun j => p.attained (k + 1) j - p.attained k j)
    (fun j _ => hnonneg j) (Finset.mem_univ i)
  rw [hsum] at h
  exact sub_eq_zero.mp (le_antisymm h (hnonneg i))

theorem marked_job_stays_fixed (k j : ℕ) (hkj : k ≤ j) (i : Fin n)
    (h : p.attained k i = y i) : p.attained j i = y i :=
  le_antisymm (p.upper j i) (h ▸ p.monotone i hkj)

/-- Marked cost paid through stage k, counting one virtual completion at each marked time. -/
noncomputable def paidAt (k : ℕ) : ℝ := ∑ i : Fin n, p.time (min k (i.val + 1))

noncomputable def markedCost : ℝ := ∑ i : Fin n, p.time (i.val + 1)

theorem paid_at_time (k : ℕ) :
    p.paidAt k = ∑ i : Fin n, min (p.time k) (p.time (i.val + 1)) := by
  apply Finset.sum_congr rfl
  intro i _
  rcases le_total k (i.val + 1) with h | h
  · rw [min_eq_left h, min_eq_left (p.time_monotone h)]
  · rw [min_eq_right h, min_eq_right (p.time_monotone h)]

theorem paid_at_last : p.paidAt n = p.markedCost := by
  unfold paidAt markedCost
  exact Finset.sum_congr rfl fun i _ => by rw [min_eq_right (Nat.succ_le_of_lt i.isLt)]

def Feasible (R : ℝ) : Prop := ∀ k ≤ n, p.paidAt k ≤ R * frozenCost (p.attained k)

def interpolation (k : ℕ) (θ : ℝ) (i : Fin n) : ℝ :=
  (1 - θ) * p.attained k i + θ * p.attained (k + 1) i

theorem interpolation_sum (k : ℕ) (θ : ℝ) :
    (∑ i, p.interpolation k θ i) = (1 - θ) * p.time k + θ * p.time (k + 1) := by
  simp [interpolation, time, Finset.sum_add_distrib, Finset.mul_sum]

theorem interpolation_le_prediction (k : ℕ) (θ : ℝ) (hθ₀ : 0 ≤ θ) (hθ₁ : θ ≤ 1)
    (i : Fin n) : p.interpolation k θ i ≤ y i := by
  unfold interpolation
  nlinarith only [mul_le_mul_of_nonneg_left (p.upper k i) (sub_nonneg.mpr hθ₁),
    mul_le_mul_of_nonneg_left (p.upper (k + 1) i) hθ₀]

theorem virtual_cost_on_phase (k : ℕ) (θ : ℝ) (hθ₀ : 0 ≤ θ) (hθ₁ : θ ≤ 1) :
    (∑ i : Fin n, min ((1 - θ) * p.time k + θ * p.time (k + 1)) (p.time (i.val + 1))) =
      (1 - θ) * p.paidAt k + θ * p.paidAt (k + 1) := by
  have h01 := p.time_monotone (Nat.le_succ k)
  have ht₀ : p.time k ≤ (1 - θ) * p.time k + θ * p.time (k + 1) := by
    nlinarith only [mul_nonneg hθ₀ (sub_nonneg.mpr h01)]
  have ht₁ : (1 - θ) * p.time k + θ * p.time (k + 1) ≤ p.time (k + 1) := by
    nlinarith only [mul_nonneg (sub_nonneg.mpr hθ₁) (sub_nonneg.mpr h01)]
  simp only [paid_at_time, Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  by_cases h : i.val + 1 ≤ k
  · have ht := p.time_monotone h
    have ht' := p.time_monotone (h.trans (Nat.le_succ k))
    rw [min_eq_right (ht.trans ht₀), min_eq_right ht, min_eq_right ht']
    ring
  · have hj : k + 1 ≤ i.val + 1 := by omega
    have ht := p.time_monotone hj
    have ht' := p.time_monotone ((Nat.le_succ k).trans hj)
    rw [min_eq_left (ht₁.trans ht), min_eq_left ht', min_eq_left ht]

theorem interior_frozen_invariant (R : ℝ) (hR : 0 ≤ R) (hp : p.Feasible R)
    (k : ℕ) (hk : k < n) (θ : ℝ) (hθ₀ : 0 ≤ θ) (hθ₁ : θ ≤ 1) :
    (∑ i : Fin n, min ((1 - θ) * p.time k + θ * p.time (k + 1)) (p.time (i.val + 1))) ≤
      R * frozenCost (p.interpolation k θ) := by
  rw [p.virtual_cost_on_phase k θ hθ₀ hθ₁]
  exact segment_invariant (p.attained k) (p.attained (k + 1)) (p.paidAt k)
    (p.paidAt (k + 1)) R θ hR hθ₀ hθ₁
    (hp k (Nat.le_of_lt hk)) (hp (k + 1) (Nat.succ_le_of_lt hk))

variable {α : Type*}

/-- A finite positive combination at each snapshot in the same marked order. -/
noncomputable def combine (s : Finset α) (w : α → ℝ) (y : α → Fin n → ℝ)
    (p : ∀ a, SnapshotPlan (y a)) (hw : ∀ a ∈ s, 0 ≤ w a) :
    SnapshotPlan (fun i => ∑ a ∈ s, w a * y a i) where
  attained k i := ∑ a ∈ s, w a * (p a).attained k i
  initial := by ext i; simp [(p _).initial]
  monotone i := fun _ _ h =>
    Finset.sum_le_sum fun a ha => mul_le_mul_of_nonneg_left ((p a).monotone i h) (hw a ha)
  upper k i :=
    Finset.sum_le_sum fun a ha => mul_le_mul_of_nonneg_left ((p a).upper k i) (hw a ha)
  marked k i hi := Finset.sum_congr rfl fun a _ => by rw [(p a).marked k i hi]

theorem combine_time (s : Finset α) (w : α → ℝ) (y : α → Fin n → ℝ)
    (p : ∀ a, SnapshotPlan (y a)) (hw : ∀ a ∈ s, 0 ≤ w a) (k : ℕ) :
    (combine s w y p hw).time k = ∑ a ∈ s, w a * (p a).time k := by
  simp only [time, combine, Finset.mul_sum]
  exact Finset.sum_comm

theorem combine_paid_at (s : Finset α) (w : α → ℝ) (y : α → Fin n → ℝ)
    (p : ∀ a, SnapshotPlan (y a)) (hw : ∀ a ∈ s, 0 ≤ w a) (k : ℕ) :
    (combine s w y p hw).paidAt k = ∑ a ∈ s, w a * (p a).paidAt k := by
  simp only [paidAt, combine_time, Finset.mul_sum]
  exact Finset.sum_comm

theorem combine_marked_cost (s : Finset α) (w : α → ℝ) (y : α → Fin n → ℝ)
    (p : ∀ a, SnapshotPlan (y a)) (hw : ∀ a ∈ s, 0 ≤ w a) :
    (combine s w y p hw).markedCost = ∑ a ∈ s, w a * (p a).markedCost := by
  simp only [← paid_at_last, combine_paid_at]

theorem combine_feasible (s : Finset α) (w : α → ℝ) (y : α → Fin n → ℝ)
    (p : ∀ a, SnapshotPlan (y a)) (hw : ∀ a ∈ s, 0 ≤ w a)
    (R : ℝ) (hR : 0 ≤ R) (hp : ∀ a ∈ s, (p a).Feasible R) :
    (combine s w y p hw).Feasible R := by
  intro k hk
  rw [combine_paid_at]
  exact weighted_snapshot_invariant s w (fun a => (p a).paidAt k)
    (fun a => (p a).attained k) R hR hw (fun a ha => hp a ha k hk)

end SnapshotPlan

end FiniteFrontier
