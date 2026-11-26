import Definitions

open scoped BigOperators
noncomputable section
namespace OrdinaryEF1

/-- The actual additive utility after deleting an arbitrary set of items. -/
noncomputable def utility {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) (i : Fin n) (S : Finset (Fin m)) : ℝ :=
  ∑ x : Fin m, if x ∈ S then 0 else u i (A x) x

noncomputable def swapped {n m : ℕ} (A : Fin m → Fin n) (i j : Fin n) : Fin m → Fin n :=
  fun x => swapRecipient i j (A x)

/-- The code `m` means no deletion; each smaller code deletes that item. -/
noncomputable def deleted {m : ℕ} (d : Fin (m + 1)) : Finset (Fin m) :=
  Finset.univ.filter (fun x => d.val = x.val)

@[simp] theorem mem_deleted {m : ℕ} (d : Fin (m + 1)) (x : Fin m) :
    x ∈ deleted d ↔ d.val = x.val := by simp [deleted]

theorem deleted_card_le_one {m : ℕ} (d : Fin (m + 1)) :
    (deleted d).card ≤ 1 := by
  apply Finset.card_le_one.mpr
  intro a ha b hb
  exact Fin.ext ((mem_deleted d a).mp ha |>.symm.trans ((mem_deleted d b).mp hb))

@[simp] theorem deleted_none {m : ℕ} :
    deleted (⟨m, Nat.lt_succ_self m⟩ : Fin (m + 1)) = ∅ := by
  ext x
  simp only [mem_deleted, Finset.not_mem_empty, iff_false]
  exact ne_of_gt x.isLt

@[simp] theorem deleted_item {m : ℕ} (x : Fin m) :
    deleted (⟨x.val, Nat.lt_succ_of_lt x.isLt⟩ : Fin (m + 1)) = {x} := by
  ext y
  simp [Fin.ext_iff, eq_comm]

theorem every_single_deletion {m : ℕ} (S : Finset (Fin m)) (hS : S.card ≤ 1) :
    ∃ d : Fin (m + 1), deleted d = S := by
  rcases S.eq_empty_or_nonempty with h | ⟨x, hx⟩
  · subst S
    exact ⟨⟨m, Nat.lt_succ_self m⟩, deleted_none⟩
  · refine ⟨⟨x.val, Nat.lt_succ_of_lt x.isLt⟩, ?_⟩
    rw [deleted_item]
    ext y
    constructor
    · intro hy
      simpa only [Finset.mem_singleton.mp hy] using hx
    · intro hy
      exact Finset.mem_singleton.mpr ((Finset.card_le_one.mp hS) y hy x hx)

theorem gap_is_actual_swap_gap {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n)
    (i j : Fin n) (d : Fin (m + 1)) :
    gap u A i j d = utility u (swapped A i j) i (deleted d) -
      utility u A i (deleted d) := by
  rw [utility, utility, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro x hx
  by_cases h : d.val = x.val <;> simp [gap, swapped, h]

/-- Original EF1 semantics: deletion is permitted in every bundle. -/
noncomputable def semanticEF1 {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) : Prop :=
  ∀ i j : Fin n, i ≠ j → ∃ S : Finset (Fin m), S.card ≤ 1 ∧
    utility u (swapped A i j) i S ≤ utility u A i S

theorem EF1_iff_original_definition {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n) :
    EF1 u A ↔ semanticEF1 u A := by
  constructor
  · intro h i j hij
    obtain ⟨d, hd⟩ := h i j hij
    refine ⟨deleted d, deleted_card_le_one d, ?_⟩
    exact sub_nonpos.mp ((gap_is_actual_swap_gap u A i j d) ▸ hd)
  · intro h i j hij
    obtain ⟨S, hc, hs⟩ := h i j hij
    obtain ⟨d, rfl⟩ := every_single_deletion S hc
    exact ⟨d, by rw [gap_is_actual_swap_gap]; exact sub_nonpos.mpr hs⟩

noncomputable def difference {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (i j : Fin n) (x : Fin m) : ℝ := u i i x - u i j x

theorem difference_add_recipient_constant {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (c : Fin n → Fin m → ℝ)
    (i j : Fin n) (x : Fin m) :
    difference (fun i r x => u i r x + c i x) i j x = difference u i j x := by
  unfold difference
  ring

noncomputable def contribution {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) (i j : Fin n) (x : Fin m) : ℝ :=
  u i (swapRecipient i j (A x)) x - u i (A x) x

theorem contribution_difference_row {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n)
    (i j : Fin n) (hij : i ≠ j) (x : Fin m) :
    contribution u A i j x =
      if A x = j then difference u i j x
      else if A x = i then -difference u i j x else 0 := by
  by_cases hi : A x = i
  · simp [contribution, swapRecipient, difference, hi, hij]
  · by_cases hj : A x = j
    · simp [contribution, swapRecipient, difference, hj, Ne.symm hij]
    · simp [contribution, swapRecipient, difference, hi, hj]

noncomputable def totalGap {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) (i j : Fin n) : ℝ :=
  ∑ x : Fin m, contribution u A i j x

theorem totalGap_difference_row {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n)
    (i j : Fin n) (hij : i ≠ j) :
    totalGap u A i j =
      (∑ x : Fin m, if A x = j then difference u i j x else 0) -
      ∑ x : Fin m, if A x = i then difference u i j x else 0 := by
  rw [totalGap, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro x hx
  rw [contribution_difference_row u A i j hij x]
  by_cases hi : A x = i
  · simp [hi, hij]
  · by_cases hj : A x = j <;> simp [hi, hj, Ne.symm hij]

noncomputable def reduction {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) (i j : Fin n) (d : Fin (m + 1)) : ℝ :=
  ∑ x : Fin m, if d.val = x.val then contribution u A i j x else 0

theorem gap_eq_total_sub_reduction {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n)
    (i j : Fin n) (d : Fin (m + 1)) :
    gap u A i j d = totalGap u A i j - reduction u A i j d := by
  rw [totalGap, reduction, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro x hx
  by_cases h : d.val = x.val <;> simp [gap, contribution, h]

@[simp] theorem reduction_none {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n) (i j : Fin n) :
    reduction u A i j ⟨m, Nat.lt_succ_self m⟩ = 0 := by
  apply Finset.sum_eq_zero
  intro x hx
  simp [ne_of_gt x.isLt]

@[simp] theorem reduction_item {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n)
    (i j : Fin n) (x : Fin m) :
    reduction u A i j ⟨x.val, Nat.lt_succ_of_lt x.isLt⟩ = contribution u A i j x := by
  unfold reduction
  have h : ∀ y : Fin m, (x.val = y.val) ↔ y = x :=
    fun y => by simp [Fin.ext_iff, eq_comm]
  simp_rw [h]
  simp

noncomputable def reductions {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) (i j : Fin n) : Finset ℝ :=
  insert 0 (Finset.univ.image (contribution u A i j))

theorem reductions_nonempty {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) (i j : Fin n) : (reductions u A i j).Nonempty := by
  exact ⟨0, Finset.mem_insert_self _ _⟩

theorem mem_reductions_iff {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) (i j : Fin n) (r : ℝ) :
    r ∈ reductions u A i j ↔ ∃ d : Fin (m + 1), reduction u A i j d = r := by
  constructor
  · intro h
    rcases Finset.mem_insert.mp h with h | h
    · subst r
      exact ⟨⟨m, Nat.lt_succ_self m⟩, reduction_none u A i j⟩
    · obtain ⟨x, hx, hxr⟩ := Finset.mem_image.mp h
      exact ⟨⟨x.val, Nat.lt_succ_of_lt x.isLt⟩, (reduction_item u A i j x).trans hxr⟩
  · rintro ⟨d, rfl⟩
    by_cases h : d.val < m
    · let x : Fin m := ⟨d.val, h⟩
      have hd : d = ⟨x.val, Nat.lt_succ_of_lt x.isLt⟩ := Fin.ext rfl
      rw [hd, reduction_item]
      exact Finset.mem_insert_of_mem (Finset.mem_image.mpr ⟨x, Finset.mem_univ x, rfl⟩)
    · have hd : d = ⟨m, Nat.lt_succ_self m⟩ := by
        apply Fin.ext
        change d.val = m
        exact Nat.le_antisymm (Nat.le_of_lt_succ d.isLt) (Nat.le_of_not_gt h)
      rw [hd, reduction_none]
      exact Finset.mem_insert_self _ _

/-- The maximum always includes zero, so it is defined for an empty item set. -/
noncomputable def bestReduction {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) (i j : Fin n) : ℝ :=
  (reductions u A i j).max' (reductions_nonempty u A i j)

noncomputable def residual {n m : ℕ} (u : Fin n → Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) (i j : Fin n) : ℝ :=
  totalGap u A i j - bestReduction u A i j

theorem residual_is_least_remaining_gap {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n) (i j : Fin n) :
    (∀ d : Fin (m + 1), residual u A i j ≤ gap u A i j d) ∧
      ∃ d : Fin (m + 1), gap u A i j d = residual u A i j := by
  constructor
  · intro d
    have hd : reduction u A i j d ≤ bestReduction u A i j := by
      apply Finset.le_max'
      exact (mem_reductions_iff u A i j _).mpr ⟨d, rfl⟩
    rw [residual, gap_eq_total_sub_reduction]
    linarith
  · obtain ⟨d, hd⟩ := (mem_reductions_iff u A i j _).mp
      (Finset.max'_mem (reductions u A i j) (reductions_nonempty u A i j))
    exact ⟨d, by rw [gap_eq_total_sub_reduction, hd]; rfl⟩

theorem EF1_iff_all_residuals_nonpositive {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n) :
    EF1 u A ↔ ∀ i j : Fin n, i ≠ j → residual u A i j ≤ 0 := by
  constructor
  · intro h i j hij
    obtain ⟨d, hd⟩ := h i j hij
    exact (residual_is_least_remaining_gap u A i j).1 d |>.trans hd
  · intro h i j hij
    obtain ⟨d, hd⟩ := (residual_is_least_remaining_gap u A i j).2
    exact ⟨d, hd ▸ h i j hij⟩

theorem not_EF1_iff_positive_residual {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n) :
    ¬ EF1 u A ↔ ∃ i j : Fin n, i ≠ j ∧ 0 < residual u A i j := by
  rw [EF1_iff_all_residuals_nonpositive]
  push_neg
  rfl

end OrdinaryEF1
