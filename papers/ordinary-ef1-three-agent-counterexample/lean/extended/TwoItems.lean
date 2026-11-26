import Definitions

open scoped BigOperators
noncomputable section

namespace OrdinaryEF1

/-! Universal EF1 existence for at most two items.  The utilities are arbitrary
real numbers, and a deletion may be made in any recipient's bundle. -/

noncomputable def twoItemSplit {n : ℕ} (p q : Fin n) (x : Fin 2) : Fin n :=
  if x = 0 then p else q

theorem two_item_split_EF1 {n : ℕ}
    (u : Fin n → Fin n → Fin 2 → ℝ) (p q : Fin n) (hpq : p ≠ q)
    (hp : u p q 0 ≤ u p p 0 ∨ u p p 1 ≤ u p q 1)
    (hq : u q q 0 ≤ u q p 0 ∨ u q p 1 ≤ u q q 1) :
    EF1 u (twoItemSplit p q) := by
  have hp' : ∃ d : Fin 3, gap u (twoItemSplit p q) p q d ≤ 0 := by
    rcases hp with hp | hp
    · refine ⟨1, ?_⟩
      simpa [gap, Fin.sum_univ_two, twoItemSplit, swapRecipient, hpq] using
        sub_nonpos.mpr hp
    · refine ⟨0, ?_⟩
      simpa [gap, Fin.sum_univ_two, twoItemSplit, swapRecipient, hpq,
        Ne.symm hpq] using sub_nonpos.mpr hp
  have hq' : ∃ d : Fin 3, gap u (twoItemSplit p q) q p d ≤ 0 := by
    rcases hq with hq | hq
    · refine ⟨1, ?_⟩
      simpa [gap, Fin.sum_univ_two, twoItemSplit, swapRecipient, hpq,
        Ne.symm hpq] using sub_nonpos.mpr hq
    · refine ⟨0, ?_⟩
      simpa [gap, Fin.sum_univ_two, twoItemSplit, swapRecipient, hpq] using
        sub_nonpos.mpr hq
  intro i j hij
  by_cases hip : i = p
  · subst i
    by_cases hjq : j = q
    · subst j
      exact hp'
    · refine ⟨0, ?_⟩
      simp [gap, Fin.sum_univ_two, twoItemSplit, swapRecipient,
        Ne.symm hpq, Ne.symm hjq]
  · by_cases hiq : i = q
    · subst i
      by_cases hjp : j = p
      · subst j
        exact hq'
      · refine ⟨1, ?_⟩
        simp [gap, Fin.sum_univ_two, twoItemSplit, swapRecipient,
          hpq, Ne.symm hjp]
    · by_cases hjp : j = p
      · subst j
        refine ⟨0, ?_⟩
        simp [gap, Fin.sum_univ_two, twoItemSplit, swapRecipient,
          Ne.symm hiq, Ne.symm hpq]
      · refine ⟨1, ?_⟩
        simp [gap, Fin.sum_univ_two, twoItemSplit, swapRecipient,
          Ne.symm hip, Ne.symm hjp]

theorem two_item_same_sign_split_exists {n : ℕ}
    (u : Fin n → Fin n → Fin 2 → ℝ) (i j : Fin n) (hij : i ≠ j)
    (hrow : (u i j 0 ≤ u i i 0 ∧ u i j 1 ≤ u i i 1) ∨
      (u i i 0 ≤ u i j 0 ∧ u i i 1 ≤ u i j 1)) :
    ∃ A : Fin 2 → Fin n, EF1 u A := by
  have hiA : u i j 0 ≤ u i i 0 ∨ u i i 1 ≤ u i j 1 := by
    rcases hrow with h | h
    · exact Or.inl h.1
    · exact Or.inr h.2
  have hiB : u i i 0 ≤ u i j 0 ∨ u i j 1 ≤ u i i 1 := by
    rcases hrow with h | h
    · exact Or.inr h.2
    · exact Or.inl h.1
  by_cases hj : u j j 0 ≤ u j i 0
  · exact ⟨twoItemSplit i j, two_item_split_EF1 u i j hij hiA (Or.inl hj)⟩
  · exact ⟨twoItemSplit j i, two_item_split_EF1 u j i (Ne.symm hij)
      (Or.inl (le_of_lt (lt_of_not_ge hj))) hiB⟩

/-- Lemma 3 for exactly two items, with no sign restriction on utilities. -/
theorem two_items_exists_EF1 {n : ℕ} (hn : 0 < n)
    (u : Fin n → Fin n → Fin 2 → ℝ) :
    ∃ A : Fin 2 → Fin n, EF1 u A := by
  classical
  let p : Fin n := ⟨0, hn⟩
  by_cases hc : EF1 u (fun _ => p)
  · exact ⟨fun _ => p, hc⟩
  · unfold EF1 at hc
    push_neg at hc
    obtain ⟨i, j, hij, hbad⟩ := hc
    have h0 := hbad (1 : Fin 3)
    have h1 := hbad (0 : Fin 3)
    simp only [gap, Fin.sum_univ_two] at h0 h1
    norm_num at h0 h1
    have hp : p = i ∨ p = j := by
      by_contra h
      push_neg at h
      simp [swapRecipient, h.1, h.2] at h0
    apply two_item_same_sign_split_exists u i j hij
    rcases hp with hp | hp
    · rw [hp] at h0 h1
      simp [swapRecipient] at h0 h1
      exact Or.inr ⟨le_of_lt h0, le_of_lt h1⟩
    · rw [hp] at h0 h1
      simp [swapRecipient, Ne.symm hij] at h0 h1
      exact Or.inl ⟨le_of_lt h0, le_of_lt h1⟩

theorem no_items_exists_EF1 {n : ℕ}
    (u : Fin n → Fin n → Fin 0 → ℝ) :
    ∃ A : Fin 0 → Fin n, EF1 u A := by
  refine ⟨Fin.elim0, ?_⟩
  intro i j hij
  refine ⟨0, ?_⟩
  simp [gap]

theorem one_item_exists_EF1 {n : ℕ} (hn : 0 < n)
    (u : Fin n → Fin n → Fin 1 → ℝ) :
    ∃ A : Fin 1 → Fin n, EF1 u A := by
  refine ⟨fun _ => ⟨0, hn⟩, ?_⟩
  intro i j hij
  refine ⟨0, ?_⟩
  simp [gap, Fin.sum_univ_one]

/-- Lemma 3, including the empty-item and one-item boundaries. -/
theorem at_most_two_items_exists_EF1 {n m : ℕ} (hn : 0 < n) (hm : m ≤ 2)
    (u : Fin n → Fin n → Fin m → ℝ) :
    ∃ A : Fin m → Fin n, EF1 u A := by
  have hm' : m = 0 ∨ m = 1 ∨ m = 2 := by omega
  rcases hm' with rfl | rfl | rfl
  · exact no_items_exists_EF1 u
  · exact one_item_exists_EF1 hn u
  · exact two_items_exists_EF1 hn u

theorem one_agent_EF1 {m : ℕ} (u : Fin 1 → Fin 1 → Fin m → ℝ)
    (A : Fin m → Fin 1) : EF1 u A := by
  intro i j hij
  exact (hij (Subsingleton.elim i j)).elim

theorem one_agent_exists_EF1 {m : ℕ} (u : Fin 1 → Fin 1 → Fin m → ℝ) :
    ∃ A : Fin m → Fin 1, EF1 u A :=
  ⟨fun _ => 0, one_agent_EF1 u (fun _ => 0)⟩

end OrdinaryEF1
