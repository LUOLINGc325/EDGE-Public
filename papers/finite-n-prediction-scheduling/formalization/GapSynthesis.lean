import SuffixEmbedding

/-! Gap decomposition and common-order synthesis for all sorted positive predictions. -/

open scoped BigOperators

namespace FiniteFrontier

variable {n : ℕ}

noncomputable def orderedPredictionStage (y : Fin n → ℝ) : ℕ → ℝ
  | 0 => 0
  | j + 1 => if h : j < n then y ⟨j, h⟩ else 0

@[simp] theorem ordered_prediction_zero (y : Fin n → ℝ) : orderedPredictionStage y 0 = 0 := rfl

@[simp] theorem ordered_prediction_rank (y : Fin n → ℝ) (i : Fin n) :
    orderedPredictionStage y (i.val + 1) = y i := by
  rw [orderedPredictionStage, dif_pos i.isLt]

noncomputable def predictionGap (y : Fin n → ℝ) (i : Fin n) : ℝ :=
  orderedPredictionStage y (i.val + 1) - orderedPredictionStage y i.val

theorem prediction_gap_nonneg (y : Fin n → ℝ) (hy : ∀ i, 0 ≤ y i) (hs : Monotone y)
    (i : Fin n) : 0 ≤ predictionGap y i := by
  unfold predictionGap
  rw [ordered_prediction_rank]
  obtain ⟨j, hj⟩ := i
  cases j with
  | zero => simpa [orderedPredictionStage] using hy (⟨0, hj⟩ : Fin n)
  | succ j =>
    change 0 ≤ y ⟨j + 1, hj⟩ - orderedPredictionStage y (j + 1)
    rw [orderedPredictionStage, dif_pos (Nat.lt_of_succ_lt hj)]
    exact sub_nonneg.mpr (hs (show (⟨j, _⟩ : Fin n) ≤ ⟨j + 1, hj⟩ from Nat.le_succ j))

theorem predictions_as_suffixes (y : Fin n → ℝ) :
    (fun j => ∑ i : Fin n, predictionGap y i * suffix n i.val j) = y := by
  funext j
  let f (k : ℕ) := orderedPredictionStage y (k + 1) - orderedPredictionStage y k
  calc
    _ = ∑ i : Fin n, if i.val < j.val + 1 then f i.val else 0 := by
      apply Finset.sum_congr rfl
      intro i _
      by_cases h : i.val < j.val + 1
      · have h' : ¬ j.val < i.val := by omega
        simp [predictionGap, suffix, h, h', f]
      · have h' : j.val < i.val := by omega
        simp [suffix, h, h']
    _ = ∑ k ∈ Finset.range (j.val + 1), f k := sum_fin_before f (Nat.succ_le_of_lt j.isLt)
    _ = _ := by
      unfold f
      rw [SnapshotPlan.sum_successive_real_sub (orderedPredictionStage y) (j.val + 1)]
      simp

variable {α : Type*}

/-- On predictions sorted in a shared order, all the pair minima are exactly linear. -/
theorem frozen_comonotone (s : Finset α) (w : α → ℝ) (v : α → Fin n → ℝ)
    (hw : ∀ a ∈ s, 0 ≤ w a) (hv : ∀ a ∈ s, Monotone (v a)) :
    frozenCost (fun i => ∑ a ∈ s, w a * v a i) = ∑ a ∈ s, w a * frozenCost (v a) := by
  let u : Fin n → ℝ := fun i => ∑ a ∈ s, w a * v a i
  have hmono : Monotone u := by
    intro i j h
    exact Finset.sum_le_sum fun a ha => mul_le_mul_of_nonneg_left (hv a ha h) (hw a ha)
  have hmin (i j : Fin n) :
      min (u i) (u j) = ∑ a ∈ s, w a * min (v a i) (v a j) := by
    rcases le_total i j with h | h
    · rw [min_eq_left (hmono h)]
      exact Finset.sum_congr rfl fun a ha => by rw [min_eq_left (hv a ha h)]
    · rw [min_eq_right (hmono h)]
      exact Finset.sum_congr rfl fun a ha => by rw [min_eq_right (hv a ha h)]
  have h₁ : (∑ i, u i) = ∑ a ∈ s, w a * ∑ i, v a i := by
    simp only [u, Finset.mul_sum]
    exact Finset.sum_comm
  have h₂ : (∑ i, ∑ j, min (u i) (u j)) =
      ∑ a ∈ s, w a * ∑ i, ∑ j, min (v a i) (v a j) := by
    simp only [hmin, Finset.mul_sum]
    calc
      _ = ∑ i, ∑ a ∈ s, ∑ j, w a * min (v a i) (v a j) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_comm
      _ = _ := Finset.sum_comm
  unfold frozenCost
  change ((∑ i, u i) + ∑ i, ∑ j, min (u i) (u j)) / 2 = _
  rw [h₁, h₂, ← Finset.sum_add_distrib, Finset.sum_div]
  exact Finset.sum_congr rfl fun a _ => by ring

theorem frozen_predictions_as_suffixes (y : Fin n → ℝ) (hy : ∀ i, 0 ≤ y i) (hs : Monotone y) :
    frozenCost y = ∑ i : Fin n, predictionGap y i * triangularCost (n - i.val : ℕ) := by
  conv_lhs => rw [← predictions_as_suffixes y]
  rw [frozen_comonotone Finset.univ (predictionGap y) (fun i => suffix n i.val)
    (fun i _ => prediction_gap_nonneg y hy hs i) (fun i _ => suffix_mono n i.val)]
  exact Finset.sum_congr rfl fun i _ => by rw [frozen_suffix i.isLt.le]

theorem suffix_size_robust {R : ℝ} (hR : baselineRobustness (n : ℝ) ≤ R) (i : Fin n) :
    baselineRobustness ((n - i.val : ℕ) : ℝ) ≤ R := by
  have hn : ((n - i.val : ℕ) : ℝ) ≤ (n : ℝ) := by exact_mod_cast Nat.sub_le n i.val
  exact (baseline_mono (by positivity) hn).trans hR

noncomputable def unitSuffixPlan (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R) (i : Fin n) :
    SnapshotPlan (suffix n i.val) :=
  asSuffixPlan i.val (Nat.sub_add_cancel i.isLt.le)
    (unit_index_is_branch (n - i.val) R (Nat.sub_pos_of_lt i.isLt) (suffix_size_robust hR i)).plan

theorem unit_suffix_plan_feasible (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R) (i : Fin n) :
    (unitSuffixPlan R hR i).Feasible R := by
  unfold unitSuffixPlan
  exact suffix_plan_feasible _ _ _ _ (UnitBranch.plan_feasible _)

theorem unit_suffix_plan_cost (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R) (i : Fin n) :
    (unitSuffixPlan R hR i).markedCost =
      triangularCost (n - i.val : ℕ) * unitFrontier (n - i.val) R := by
  rw [unitSuffixPlan, suffix_plan_marked_cost, UnitBranch.plan_marked_cost]
  rfl

noncomputable def synthesizeSorted (y : Fin n → ℝ) (hy : ∀ i, 0 ≤ y i) (hs : Monotone y)
    (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R) : SnapshotPlan y :=
  SnapshotPlan.castPrediction (predictions_as_suffixes y)
    (SnapshotPlan.combine Finset.univ (predictionGap y) (fun i => suffix n i.val)
      (unitSuffixPlan R hR) (fun i _ => prediction_gap_nonneg y hy hs i))

theorem synthesized_feasible (y : Fin n → ℝ) (hy : ∀ i, 0 ≤ y i) (hs : Monotone y)
    (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R) :
    (synthesizeSorted y hy hs R hR).Feasible R := by
  have hR₀ : 0 ≤ R := (div_nonneg (by positivity) (by positivity) : 0 ≤ baselineRobustness (n : ℝ)).trans hR
  unfold synthesizeSorted
  rw [SnapshotPlan.cast_feasible]
  exact SnapshotPlan.combine_feasible _ _ _ _ _ R hR₀ fun i _ => unit_suffix_plan_feasible R hR i

theorem synthesized_cost_le (y : Fin n → ℝ) (hy : ∀ i, 0 ≤ y i) (hs : Monotone y)
    (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R) :
    (synthesizeSorted y hy hs R hR).markedCost ≤ unitFrontier n R * frozenCost y := by
  unfold synthesizeSorted
  rw [SnapshotPlan.cast_marked_cost, SnapshotPlan.combine_marked_cost,
    frozen_predictions_as_suffixes y hy hs, Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i _
  rw [unit_suffix_plan_cost]
  calc
    _ = (predictionGap y i * triangularCost (n - i.val : ℕ)) *
        unitFrontier (n - i.val) R := by ring
    _ ≤ (predictionGap y i * triangularCost (n - i.val : ℕ)) * unitFrontier n R := by
      apply mul_le_mul_of_nonneg_left
      · exact dimension_monotonicity (Nat.sub_pos_of_lt i.isLt) (Nat.sub_le _ _) R hR
      · unfold triangularCost
        exact mul_nonneg (prediction_gap_nonneg y hy hs i) (by positivity)
    _ = _ := by ring

end FiniteFrontier
