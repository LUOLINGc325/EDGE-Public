import Definitions

open scoped BigOperators
noncomputable section

namespace OrdinaryEF1

/-! The two-agent existence argument minimizes a real-valued discrepancy over
the finite set of all complete allocations. No existence premise is imported. -/

noncomputable def twoNoDeletion (m : ℕ) : Fin (m + 1) := ⟨m, Nat.lt_succ_self m⟩

noncomputable def twoFlip {m : ℕ} (A : Fin m → Fin 2) : Fin m → Fin 2 :=
  fun x => swapRecipient 0 1 (A x)

noncomputable def twoContribution {m : ℕ} (u : Fin 2 → Fin 2 → Fin m → ℝ)
    (A : Fin m → Fin 2) (i : Fin 2) (x : Fin m) : ℝ :=
  u i (swapRecipient 0 1 (A x)) x - u i (A x) x

noncomputable def twoSumGap {m : ℕ} (u : Fin 2 → Fin 2 → Fin m → ℝ)
    (A : Fin m → Fin 2) (i : Fin 2) : ℝ :=
  ∑ x : Fin m, twoContribution u A i x

theorem two_swap_twice (r : Fin 2) :
    swapRecipient 0 1 (swapRecipient 0 1 r) = r := by
  fin_cases r <;> norm_num [swapRecipient]

theorem two_swap_reverse (r : Fin 2) :
    swapRecipient 1 0 r = swapRecipient 0 1 r := by
  fin_cases r <;> norm_num [swapRecipient]

theorem twoSumGap_flip {m : ℕ} (u : Fin 2 → Fin 2 → Fin m → ℝ)
    (A : Fin m → Fin 2) (i : Fin 2) :
    twoSumGap u (twoFlip A) i = -twoSumGap u A i := by
  unfold twoSumGap
  rw [← Finset.sum_neg_distrib]
  apply Finset.sum_congr rfl
  intro x _
  simp only [twoContribution, twoFlip, two_swap_twice]
  ring

theorem twoGap_first_noDeletion {m : ℕ} (u : Fin 2 → Fin 2 → Fin m → ℝ)
    (A : Fin m → Fin 2) :
    gap u A 0 1 (twoNoDeletion m) = twoSumGap u A 0 := by
  unfold gap twoSumGap
  apply Finset.sum_congr rfl
  intro x _
  have hx : m ≠ x.val := ne_of_gt x.isLt
  simp [twoNoDeletion, hx, twoContribution]

theorem twoGap_second_noDeletion {m : ℕ} (u : Fin 2 → Fin 2 → Fin m → ℝ)
    (A : Fin m → Fin 2) :
    gap u A 1 0 (twoNoDeletion m) = twoSumGap u A 1 := by
  unfold gap twoSumGap
  apply Finset.sum_congr rfl
  intro x _
  have hx : m ≠ x.val := ne_of_gt x.isLt
  simp [twoNoDeletion, hx, twoContribution, two_swap_reverse]

theorem twoSumGap_move_item {m : ℕ} (u : Fin 2 → Fin 2 → Fin m → ℝ)
    (A : Fin m → Fin 2) (i : Fin 2) (x : Fin m) :
    twoSumGap u (Function.update A x (swapRecipient 0 1 (A x))) i =
      twoSumGap u A i - 2 * twoContribution u A i x := by
  classical
  have hp : ∀ y : Fin m,
      twoContribution u (Function.update A x (swapRecipient 0 1 (A x))) i y =
        twoContribution u A i y - (if y = x then 2 * twoContribution u A i x else 0) := by
    intro y
    by_cases h : y = x
    · subst y
      simp only [twoContribution, Function.update_self, two_swap_twice, if_pos rfl, ite_true]
      ring
    · simp [twoContribution, Function.update, h, Ne.symm h]
  unfold twoSumGap
  simp_rw [hp]
  simp [Finset.sum_sub_distrib]

theorem twoGap_delete_item {m : ℕ} (u : Fin 2 → Fin 2 → Fin m → ℝ)
    (A : Fin m → Fin 2) (x : Fin m) :
    gap u A 0 1 x.castSucc = twoSumGap u A 0 - twoContribution u A 0 x := by
  classical
  have hp : ∀ y : Fin m,
      (if x.val = y.val then (0 : ℝ) else twoContribution u A 0 y) =
        twoContribution u A 0 y - (if y = x then twoContribution u A 0 x else 0) := by
    intro y
    by_cases h : y = x
    · subst y
      simp
    · have hxy : x.val ≠ y.val := fun hval => h (Fin.ext hval.symm)
      simp [h, hxy]
  change (∑ y : Fin m, if x.val = y.val then (0 : ℝ) else twoContribution u A 0 y) = _
  simp_rw [hp]
  simp [Finset.sum_sub_distrib, twoSumGap]

theorem two_first_EF1_of_minimum {m : ℕ} (u : Fin 2 → Fin 2 → Fin m → ℝ)
    (A : Fin m → Fin 2)
    (hmin : ∀ B : Fin m → Fin 2, |twoSumGap u A 0| ≤ |twoSumGap u B 0|) :
    ∃ d : Fin (m + 1), gap u A 0 1 d ≤ 0 := by
  classical
  by_cases hnonpos : twoSumGap u A 0 ≤ 0
  · exact ⟨twoNoDeletion m, by simpa only [twoGap_first_noDeletion] using hnonpos⟩
  have hg : 0 < twoSumGap u A 0 := lt_of_not_ge hnonpos
  have hex : ∃ x : Fin m, 0 < twoContribution u A 0 x := by
    by_contra h
    push_neg at h
    have hsum : twoSumGap u A 0 ≤ 0 := by
      exact Finset.sum_nonpos (fun x _ => h x)
    exact (not_le_of_gt hg) hsum
  obtain ⟨x, hx⟩ := hex
  have hbound : twoSumGap u A 0 ≤ twoContribution u A 0 x := by
    by_contra h
    have hxg : twoContribution u A 0 x < twoSumGap u A 0 := lt_of_not_ge h
    have hbetter : |twoSumGap u A 0 - 2 * twoContribution u A 0 x| < twoSumGap u A 0 := by
      apply abs_lt.mpr
      constructor <;> linarith
    have hminimal := hmin (Function.update A x (swapRecipient 0 1 (A x)))
    rw [twoSumGap_move_item, abs_of_pos hg] at hminimal
    exact (not_le_of_gt hbetter) hminimal
  refine ⟨x.castSucc, ?_⟩
  rw [twoGap_delete_item]
  linarith

theorem two_EF1_of_minimum_and_second_nonenvy {m : ℕ}
    (u : Fin 2 → Fin 2 → Fin m → ℝ) (A : Fin m → Fin 2)
    (hmin : ∀ B : Fin m → Fin 2, |twoSumGap u A 0| ≤ |twoSumGap u B 0|)
    (hsecond : twoSumGap u A 1 ≤ 0) : EF1 u A := by
  have hfirst := two_first_EF1_of_minimum u A hmin
  have hother : ∃ d : Fin (m + 1), gap u A 1 0 d ≤ 0 :=
    ⟨twoNoDeletion m, by simpa only [twoGap_second_noDeletion] using hsecond⟩
  intro i j hij
  fin_cases i <;> fin_cases j
  · exact (hij rfl).elim
  · exact hfirst
  · exact hother
  · exact (hij rfl).elim

/-- Lemma 4: two agents admit EF1 for every finite item count and every real
additive externality tensor, with no sign restriction. -/
theorem two_agents_exists_EF1 (m : ℕ) (u : Fin 2 → Fin 2 → Fin m → ℝ) :
    ∃ A : Fin m → Fin 2, EF1 u A := by
  classical
  obtain ⟨A, _, hmin⟩ := Finset.exists_min_image
    (Finset.univ : Finset (Fin m → Fin 2))
    (fun B => |twoSumGap u B 0|) Finset.univ_nonempty
  have hminimum : ∀ B : Fin m → Fin 2, |twoSumGap u A 0| ≤ |twoSumGap u B 0| :=
    fun B => hmin B (Finset.mem_univ B)
  by_cases hsecond : twoSumGap u A 1 ≤ 0
  · exact ⟨A, two_EF1_of_minimum_and_second_nonenvy u A hminimum hsecond⟩
  · refine ⟨twoFlip A, two_EF1_of_minimum_and_second_nonenvy u (twoFlip A) ?_ ?_⟩
    · intro B
      simpa only [twoSumGap_flip, abs_neg] using hminimum B
    · rw [twoSumGap_flip]
      linarith

#print axioms two_agents_exists_EF1

end OrdinaryEF1
