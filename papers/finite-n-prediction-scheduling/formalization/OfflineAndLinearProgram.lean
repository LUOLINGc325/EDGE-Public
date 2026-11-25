import SnapshotGuarantees

/-! Offline attainment and the auxiliary-variable snapshot linear program. -/

open scoped BigOperators

namespace FiniteFrontier

variable {n : ℕ}

noncomputable def serialSnapshots (x : Fin n → ℝ) (hx : ∀ i, 0 ≤ x i) : SnapshotPlan x where
  attained k i := if i.val < k then x i else 0
  initial := by ext i; simp
  monotone i := by
    intro a b hab
    by_cases h : i.val < a
    · simp [h, h.trans_le hab]
    · simp only [if_neg h]
      split
      · exact hx i
      · exact le_rfl
  upper k i := by split <;> simp_all
  marked k i h := if_pos h

theorem serial_snapshot_completion (x : Fin n → ℝ) (hx : ∀ i, 0 ≤ x i) (i : Fin n) :
    (serialSnapshots x hx).time (i.val + 1) = serialCompletion x i := by
  unfold SnapshotPlan.time serialCompletion
  exact Finset.sum_congr rfl fun j _ => by
    change (if j.val < i.val + 1 then x j else 0) = if j ≤ i then x j else 0
    have h : j.val < i.val + 1 ↔ j ≤ i := Nat.lt_succ_iff
    simp [h]

/-- The finite pair minimum is the offline optimum, attained by shortest processing time.
The lower half ranges over every legal preemptive trajectory. -/
theorem offline_shortest_processing_time (x : PositiveSizes (Fin n)) :
    IsLeast {C | ∃ r : Run x.val, r.cost = C} (frozenCost x.val) := by
  refine ⟨?_, ?_⟩
  · let σ := Tuple.sort x.val
    let xs : PositiveSizes (Fin n) := ⟨x.val ∘ σ, fun i => x.property (σ i)⟩
    let p := serialSnapshots xs.val (fun i => (xs.property i).le)
    let r := p.execute xs xs.property
    let h : (xs.val ∘ σ.symm) = x.val := by ext i; simp [xs]
    let u : Run x.val := h ▸ r.reindex σ.symm
    have hu : u.cost = r.cost := by
      unfold u
      have hcast {a b : Fin n → ℝ} (h : a = b) (f : Run a) : (h ▸ f : Run b).cost = f.cost := by subst b; rfl
      rw [hcast, Run.reindex_cost]
    have hs : p.markedCost = frozenCost xs.val := by
      rw [frozen_eq_serial_sorted xs.val (Tuple.monotone_sort x.val)]
      exact Finset.sum_congr rfl fun i _ => serial_snapshot_completion xs.val (fun j => (xs.property j).le) i
    have hr : r.cost ≤ frozenCost x.val := by
      have h := p.execute_correct_cost_le_marked xs xs.property rfl
      rw [hs] at h
      exact h.trans_eq (frozen_reindex σ x.val)
    exact ⟨u, le_antisymm (hu.trans_le hr) u.frozen_le_cost⟩
  · intro C h
    obtain ⟨r, rfl⟩ := h
    exact r.frozen_le_cost

namespace SnapshotPlan

variable {y : Fin n → ℝ} (p : SnapshotPlan y)

/-- A literal linear-program certificate. Pair variables are used only at strict
unordered indices, so they may be set to zero on other pairs. -/
def LinearFeasible (R : ℝ) : Prop :=
  ∃ z : ℕ → Fin n → Fin n → ℝ,
    ∀ k ≤ n, (∀ i j, i < j → z k i j ∈ Set.Icc 0 (p.attained k i) ∧ z k i j ≤ p.attained k j) ∧
      p.paidAt k ≤ R * ((∑ i, p.attained k i) + ∑ i, ∑ j, if i < j then z k i j else 0)

theorem linear_feasible_iff (R : ℝ) (hR : 0 ≤ R) :
    p.LinearFeasible R ↔ p.Feasible R := by
  constructor
  · intro h k hk
    obtain ⟨z, hz⟩ := h
    obtain ⟨hbound, hf⟩ := hz k hk
    have hsum :
        (∑ i, ∑ j, if i < j then z k i j else 0) ≤
          ∑ i, ∑ j, if i < j then min (p.attained k i) (p.attained k j) else 0 := by
      apply Finset.sum_le_sum
      intro i _
      apply Finset.sum_le_sum
      intro j _
      by_cases hij : i < j
      · simpa only [if_pos hij] using le_min (hbound i j hij).1.2 (hbound i j hij).2
      · simp [hij]
    rw [frozen_off_diagonal]
    exact hf.trans (mul_le_mul_of_nonneg_left (add_le_add_left hsum _) hR)
  · intro h
    refine ⟨fun k i j => min (p.attained k i) (p.attained k j), ?_⟩
    intro k hk
    exact ⟨fun i j _ => ⟨⟨le_min (p.attained_nonneg k i) (p.attained_nonneg k j), min_le_left _ _⟩,
      min_le_right _ _⟩, by simpa only [frozen_off_diagonal] using h k hk⟩

end SnapshotPlan

end FiniteFrontier
