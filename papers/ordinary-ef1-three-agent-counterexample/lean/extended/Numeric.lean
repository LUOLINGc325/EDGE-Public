import Family
import Semantics

open scoped BigOperators
noncomputable section

namespace OrdinaryEF1

noncomputable def cycleAgent (i : Fin 3) : Fin 3 :=
  if i = 0 then 1 else if i = 1 then 2 else 0

theorem cycleAgent_three (i : Fin 3) :
    cycleAgent (cycleAgent (cycleAgent i)) = i := by
  fin_cases i <;> norm_num [cycleAgent]

theorem cyclicProfile_symmetry (a b g z : ℝ) (i r x : Fin 3) :
    cyclicProfile a b g z (cycleAgent i) (cycleAgent r) x =
      cyclicProfile a b g z i r x := by
  fin_cases i <;> fin_cases r <;> fin_cases x <;>
    norm_num [cyclicProfile, cycleAgent]

theorem cyclic_difference_successor (a b g z : ℝ) (i x : Fin 3) :
    difference (cyclicProfile a b g z) i (cycleAgent i) x =
      if x = 0 then a else if x = 1 then b else -z := by
  fin_cases i <;> fin_cases x <;>
    norm_num [difference, cyclicProfile, cycleAgent]

theorem cyclic_difference_predecessor (a b g z : ℝ) (i x : Fin 3) :
    difference (cyclicProfile a b g z) i (cycleAgent (cycleAgent i)) x =
      if x = 0 then a else if x = 1 then b else g := by
  fin_cases i <;> fin_cases x <;>
    norm_num [difference, cyclicProfile, cycleAgent]

theorem integer_profile_alphabet (i r x : Fin 3) :
    cyclicProfile 2 1 2 2 i r x = 0 ∨ cyclicProfile 2 1 2 2 i r x = 1 ∨
      cyclicProfile 2 1 2 2 i r x = 2 ∨ cyclicProfile 2 1 2 2 i r x = 4 := by
  fin_cases i <;> fin_cases r <;> fin_cases x <;>
    norm_num [cyclicProfile]

theorem integer_profile_nonnegative (i r x : Fin 3) :
    0 ≤ cyclicProfile 2 1 2 2 i r x := by
  rcases integer_profile_alphabet i r x with h | h | h | h <;> rw [h] <;> norm_num

theorem third_item_is_chore (i : Fin 3) :
    cyclicProfile 2 1 2 2 i i 2 <
      cyclicProfile 2 1 2 2 i (cycleAgent i) 2 := by
  fin_cases i <;> norm_num [cyclicProfile, cycleAgent]

theorem shifted_profile_alphabet (i r x : Fin 3) :
    cyclicProfile 2 1 2 2 i r x + 1 = 1 ∨
      cyclicProfile 2 1 2 2 i r x + 1 = 2 ∨
      cyclicProfile 2 1 2 2 i r x + 1 = 3 ∨
      cyclicProfile 2 1 2 2 i r x + 1 = 5 := by
  rcases integer_profile_alphabet i r x with h | h | h | h <;> rw [h] <;> norm_num

theorem shifted_profile_positive (i r x : Fin 3) :
    0 < cyclicProfile 2 1 2 2 i r x + 1 := by
  have h := integer_profile_nonnegative i r x
  linarith

/- The table is indexed by recipients of a and b, with c at agent 0.
The manuscript's human-facing agent labels are each one larger. -/
noncomputable def tableWitness (r s : Fin 3) : Fin 3 × Fin 3 :=
  if r = 0 then (1, 0)
  else if r = 1 then (0, 1)
  else if s = 0 then (1, 0)
  else if s = 1 then (0, 1) else (1, 2)

noncomputable def tableGap (r s : Fin 3) : ℝ :=
  if r = 0 then (if s = 0 then 5 else if s = 1 then 3 else 4)
  else if r = 1 then (if s = 0 then 3 else if s = 1 then 5 else 4)
  else 3

noncomputable def tableOptimalDeletion (r s : Fin 3) : Fin 4 :=
  if r = 2 ∧ s ≠ 2 then 2 else 0

theorem table_witness_distinct (r s : Fin 3) :
    (tableWitness r s).1 ≠ (tableWitness r s).2 := by
  fin_cases r <;> fin_cases s <;> norm_num [tableWitness]

theorem nine_table_gaps (r s : Fin 3) :
    totalGap (cyclicProfile 2 1 2 2) (alloc r s 0)
      (tableWitness r s).1 (tableWitness r s).2 = tableGap r s := by
  fin_cases r <;> fin_cases s <;>
    norm_num [totalGap, contribution, gap, cyclicProfile, swapRecipient, alloc,
      tableWitness, tableGap, Fin.sum_univ_three]

theorem bestReduction_eq_of_certificate {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n) (i j : Fin n)
    (v : ℝ) (hbound : ∀ d : Fin (m + 1), reduction u A i j d ≤ v)
    (hattain : ∃ d : Fin (m + 1), reduction u A i j d = v) :
    bestReduction u A i j = v := by
  apply le_antisymm
  · apply Finset.max'_le
    intro y hy
    obtain ⟨d, rfl⟩ := (mem_reductions_iff u A i j y).mp hy
    exact hbound d
  · obtain ⟨d, hd⟩ := hattain
    rw [← hd]
    apply Finset.le_max'
    exact (mem_reductions_iff u A i j _).mpr ⟨d, rfl⟩

theorem nine_table_best_reductions (r s : Fin 3) :
    bestReduction (cyclicProfile 2 1 2 2) (alloc r s 0)
      (tableWitness r s).1 (tableWitness r s).2 = 2 := by
  apply bestReduction_eq_of_certificate
  · intro d
    fin_cases r <;> fin_cases s <;> fin_cases d <;>
      norm_num [reduction, contribution, cyclicProfile, swapRecipient, alloc,
        tableWitness, Fin.sum_univ_three]
  · refine ⟨tableOptimalDeletion r s, ?_⟩
    fin_cases r <;> fin_cases s <;>
      norm_num [reduction, contribution, cyclicProfile, swapRecipient, alloc,
        tableWitness, tableOptimalDeletion, Fin.sum_univ_three]

theorem nine_table_residuals (r s : Fin 3) :
    residual (cyclicProfile 2 1 2 2) (alloc r s 0)
      (tableWitness r s).1 (tableWitness r s).2 = tableGap r s - 2 := by
  rw [residual, nine_table_gaps, nine_table_best_reductions]

theorem nine_table_residuals_positive (r s : Fin 3) :
    0 < residual (cyclicProfile 2 1 2 2) (alloc r s 0)
      (tableWitness r s).1 (tableWitness r s).2 := by
  rw [nine_table_residuals]
  fin_cases r <;> fin_cases s <;> norm_num [tableGap]

set_option maxHeartbeats 800000 in
/-- Every allocation has a witness with residual at least one; the undeleted
gap is at least three. These are the quantitative margins used in stability. -/
theorem integer_witness_margin (A : Fin 3 → Fin 3) :
    ∃ i j : Fin 3, i ≠ j ∧ ∀ d : Fin 4,
      (if d.val = 3 then (3 : ℝ) else 1) ≤
        gap (cyclicProfile 2 1 2 2) A i j d := by
  have h : ∀ r s t : Fin 3, ∃ i j : Fin 3, i ≠ j ∧ ∀ d : Fin 4,
      (if d.val = 3 then (3 : ℝ) else 1) ≤
        gap (cyclicProfile 2 1 2 2) (alloc r s t) i j d := by
    intro r s t
    fin_cases r <;> fin_cases s <;> fin_cases t
    · refine ⟨1, 0, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨2, 0, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨2, 0, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨1, 0, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨2, 1, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨2, 0, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨1, 0, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨1, 2, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨2, 0, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨0, 1, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨2, 1, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨2, 0, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨0, 1, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨2, 1, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨0, 1, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨0, 1, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨2, 1, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨0, 2, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨1, 0, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨1, 2, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨0, 2, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨0, 1, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨1, 2, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨0, 2, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨1, 2, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨1, 2, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    · refine ⟨0, 2, by decide, ?_⟩
      intro d
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  obtain ⟨i, j, hij, hd⟩ := h (A 0) (A 1) (A 2)
  exact ⟨i, j, hij, by simpa only [alloc_eta] using hd⟩

end OrdinaryEF1
