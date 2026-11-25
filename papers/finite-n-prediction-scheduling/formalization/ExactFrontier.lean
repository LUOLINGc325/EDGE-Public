import GapSynthesis

/-! Achievability on every positive prediction vector and exact minimax value. -/

open scoped BigOperators

namespace FiniteFrontier

variable {n : ℕ}

namespace Run

noncomputable def castSize {x z : Fin n → ℝ} (h : x = z) (r : Run x) : Run z := h ▸ r

@[simp] theorem cast_size_service {x z : Fin n → ℝ} (h : x = z) (r : Run x) (t : ℝ) :
    (castSize h r).service t = r.service t := by subst z; rfl

@[simp] theorem cast_size_completion {x z : Fin n → ℝ} (h : x = z) (r : Run x) :
    (castSize h r).completion = r.completion := by subst z; rfl

@[simp] theorem cast_size_cost {x z : Fin n → ℝ} (h : x = z) (r : Run x) :
    (castSize h r).cost = r.cost := by subst z; rfl

noncomputable def undoPermutation {x : Fin n → ℝ} (σ : Equiv.Perm (Fin n)) (r : Run (x ∘ σ)) : Run x :=
  castSize (by ext i; simp) (r.reindex σ.symm)

@[simp] theorem undo_service {x : Fin n → ℝ} (σ : Equiv.Perm (Fin n))
    (r : Run (x ∘ σ)) (t : ℝ) (i : Fin n) :
    (r.undoPermutation σ).service t i = r.service t (σ.symm i) := by simp [undoPermutation, reindex]

@[simp] theorem undo_completion {x : Fin n → ℝ} (σ : Equiv.Perm (Fin n))
    (r : Run (x ∘ σ)) (i : Fin n) :
    (r.undoPermutation σ).completion i = r.completion (σ.symm i) := by simp [undoPermutation, reindex]

@[simp] theorem undo_cost {x : Fin n → ℝ} (σ : Equiv.Perm (Fin n)) (r : Run (x ∘ σ)) :
    (r.undoPermutation σ).cost = r.cost := by simp [undoPermutation, reindex_cost]

end Run

noncomputable def positivePermutation (p : PositiveSizes (Fin n)) (σ : Equiv.Perm (Fin n)) :
    PositiveSizes (Fin n) := ⟨p.val ∘ σ, fun i => p.property (σ i)⟩

/-- Feasible planned execution is equivariant under the fixed relabeling chosen by
sorting predictions. Tied predictions use the same permutation on both instances. -/
noncomputable def predictionSortedPolicy
    (plans : ∀ y : PositiveSizes (Fin n), Monotone y.val → SnapshotPlan y.val) :
    Policy (Fin n) where
  run y x := by
    let σ := Tuple.sort y.val
    let ys := positivePermutation y σ
    let xs := positivePermutation x σ
    exact ((plans ys (Tuple.monotone_sort y.val)).execute xs ys.property).undoPermutation σ
  prefix_agrees y x z t _ hobs u hu hut := by
    let σ := Tuple.sort y.val
    let ys := positivePermutation y σ
    let xs := positivePermutation x σ
    let zs := positivePermutation z σ
    let p := plans ys (Tuple.monotone_sort y.val)
    have h : p.UnchangedObservations xs zs t := by
      intro i
      have hi := hobs (σ i)
      change (if ((p.execute xs ys.property).undoPermutation σ).completion (σ i) ≤ t then
        z.val (σ i) = x.val (σ i)
        else ((p.execute xs ys.property).undoPermutation σ).service t (σ i) < z.val (σ i)) at hi
      simp only [Run.undo_completion, Run.undo_service, Equiv.symm_apply_apply] at hi
      exact hi
    have hp := p.execute_prefix xs zs ys.property t h u hu hut
    funext i
    change ((p.execute zs ys.property).undoPermutation σ).service u i =
      ((p.execute xs ys.property).undoPermutation σ).service u i
    simp only [Run.undo_service]
    exact congrFun hp (σ.symm i)

theorem prediction_sorted_robust
    (plans : ∀ y : PositiveSizes (Fin n), Monotone y.val → SnapshotPlan y.val)
    (R : ℝ) (hR₀ : 0 ≤ R) (hR : baselineRobustness (n : ℝ) ≤ R)
    (hplan : ∀ y h, (plans y h).Feasible R) :
    Robust (predictionSortedPolicy plans) R := by
  intro x y
  let σ := Tuple.sort y.val
  let ys := positivePermutation y σ
  let xs := positivePermutation x σ
  let p := plans ys (Tuple.monotone_sort y.val)
  change ((p.execute xs ys.property).undoPermutation σ).cost ≤ R * frozenCost x.val
  rw [Run.undo_cost, ← frozen_reindex σ x.val]
  exact p.execute_robust xs ys.property R hR₀ hR (hplan ys _)

theorem prediction_sorted_consistent
    (plans : ∀ y : PositiveSizes (Fin n), Monotone y.val → SnapshotPlan y.val)
    (C : ℝ) (hplan : ∀ y h, (plans y h).markedCost ≤ C * frozenCost y.val) :
    Consistent (predictionSortedPolicy plans) C := by
  intro y
  let σ := Tuple.sort y.val
  let ys := positivePermutation y σ
  let p := plans ys (Tuple.monotone_sort y.val)
  change ((p.execute ys ys.property).undoPermutation σ).cost ≤ C * frozenCost y.val
  rw [Run.undo_cost, ← frozen_reindex σ y.val]
  exact (p.execute_correct_cost_le_marked ys ys.property rfl).trans (hplan ys _)

noncomputable def optimumPolicy (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R) :
    Policy (Fin n) :=
  predictionSortedPolicy fun y h => synthesizeSorted y.val (fun i => (y.property i).le) h R hR

theorem optimum_policy_robust (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R) :
    Robust (optimumPolicy R hR : Policy (Fin n)) R := by
  have hbase : 0 ≤ baselineRobustness (n : ℝ) := div_nonneg (by positivity) (by positivity)
  exact prediction_sorted_robust _ R (hbase.trans hR) hR fun y h =>
    synthesized_feasible y.val (fun i => (y.property i).le) h R hR

theorem optimum_policy_consistent (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R) :
    Consistent (optimumPolicy R hR : Policy (Fin n)) (unitFrontier n R) :=
  prediction_sorted_consistent _ _ fun y h =>
    synthesized_cost_le y.val (fun i => (y.property i).le) h R hR

theorem frozen_ones (n : ℕ) :
    frozenCost (fun _ : Fin n => (1 : ℝ)) = triangularCost (n : ℝ) := by
  simpa only [mul_one] using frozen_uniform n (1 : ℝ)

/-- Every allowed policy must pay at least the formula's consistency, even if it does
not use the marked completion order and even if it idles. -/
theorem consistency_lower (hn : 0 < n) (R C : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R)
    (A : Policy (Fin n)) (hA : Robust A R) (hC : Consistent A C) :
    unitFrontier n R ≤ C := by
  let ones : PositiveSizes (Fin n) := ⟨fun _ => 1, fun _ => zero_lt_one⟩
  have hupper := hC ones
  change (A.run ones ones).cost ≤ C * frozenCost (fun _ : Fin n => (1 : ℝ)) at hupper
  rw [frozen_ones] at hupper
  have hl := (unit_index_is_branch n R hn hR).policy_unit_lower A hA
  have hnr : 0 < (n : ℝ) := by exact_mod_cast hn
  have hQ : 0 < triangularCost (n : ℝ) := by unfold triangularCost; positivity
  apply (mul_le_mul_left hQ).mp
  change triangularCost n * unitValue n R (unitIndex n R) ≤ _
  exact hl.trans (by rwa [mul_comm C] at hupper)

def consistencyBounds (n : ℕ) (R : ℝ) : Set ℝ :=
  {C | ∃ A : Policy (Fin n), Robust A R ∧ Consistent A C}

/-- The infimum over all deterministic policies is attained by the explicit
prediction-sort, suffix-synthesis and mismatch-continuation algorithm. -/
theorem exact_finite_job_frontier (hn : 0 < n) (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R) :
    IsLeast (consistencyBounds n R) (unitFrontier n R) :=
  ⟨⟨optimumPolicy R hR, optimum_policy_robust R hR, optimum_policy_consistent R hR⟩,
    fun C ⟨A, ha, hc⟩ => consistency_lower hn R C hR A ha hc⟩

end FiniteFrontier
