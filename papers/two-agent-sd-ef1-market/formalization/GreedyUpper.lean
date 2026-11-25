import ComplementarySeed

open Finset

namespace MarketFairDivision

variable {Goods : Type*} [DecidableEq Goods] {k : ℕ}

theorem insert_inter_eq (A S : Finset Goods) (g : Goods) :
    insert g A ∩ S = if g ∈ S then insert g (A ∩ S) else A ∩ S := by
  by_cases h : g ∈ S
  · rw [if_pos h]
    ext x
    simp only [mem_inter, mem_insert]
    aesop
  · rw [if_neg h]
    ext x
    simp only [mem_inter, mem_insert]
    aesop

theorem card_inside_add_outside (A S : Finset Goods) :
    (A ∩ S).card + (A \ S).card = A.card := by
  have he : A \ (A ∩ S) = A \ S := by
    ext x
    simp only [mem_sdiff, mem_inter]
    aesop
  rw [← he, Nat.add_comm]
  exact Finset.card_sdiff_add_card_eq_card Finset.inter_subset_left

variable [Fintype Goods]

theorem upper_mono (r : Goods ≃ Fin (2 * k)) {A B : Finset Goods}
    (hAB : A ⊆ B) (hB : UpperIndependent r B) : UpperIndependent r A :=
  fun t ht => (Finset.card_le_card (Finset.inter_subset_inter_right hAB)).trans (hB t ht)

theorem empty_upper (r : Goods ≃ Fin (2 * k)) :
    UpperIndependent r (∅ : Finset Goods) := by
  intro t _
  simp

theorem upper_card (r : Goods ≃ Fin (2 * k)) {A : Finset Goods}
    (h : UpperIndependent r A) : A.card ≤ k := by
  simpa using h k le_rfl

noncomputable def tightThresholds (r : Goods ≃ Fin (2 * k)) (A : Finset Goods) : Finset ℕ :=
  (Finset.range (k + 1)).filter (fun t => (A ∩ rankPrefix r (2 * t)).card = t)

@[simp] theorem mem_tightThresholds (r : Goods ≃ Fin (2 * k)) (A : Finset Goods) (t : ℕ) :
    t ∈ tightThresholds r A ↔ t ≤ k ∧ (A ∩ rankPrefix r (2 * t)).card = t := by
  simp [tightThresholds, Nat.lt_succ_iff]

theorem tightThresholds_nonempty (r : Goods ≃ Fin (2 * k)) (A : Finset Goods) :
    (tightThresholds r A).Nonempty :=
  ⟨0, by simp⟩

theorem insertion_blocked_by_tight_prefix (r : Goods ≃ Fin (2 * k)) {A : Finset Goods}
    (hA : UpperIndependent r A) {g : Goods} (hg : g ∉ A)
    (hn : ¬UpperIndependent r (insert g A)) :
    ∃ t ∈ tightThresholds r A, g ∈ rankPrefix r (2 * t) := by
  obtain ⟨t, hb⟩ := not_forall.mp hn
  have ht : t ≤ k := by
    by_contra ht
    exact hb (fun hx => (ht hx).elim)
  have hv : t < (insert g A ∩ rankPrefix r (2 * t)).card :=
    Nat.lt_of_not_ge (fun hle => hb (fun _ => hle))
  rw [insert_inter_eq] at hv
  by_cases hp : g ∈ rankPrefix r (2 * t)
  · rw [if_pos hp, Finset.card_insert_of_not_mem (fun h => hg (mem_inter.mp h).1)] at hv
    exact ⟨t, (mem_tightThresholds r A t).mpr ⟨ht, by have := hA t ht; omega⟩, hp⟩
  · rw [if_neg hp] at hv
    exact ((Nat.not_lt_of_ge (hA t ht)) hv).elim

/-- The augmentation exchange property for the nested upper quotas. -/
theorem upper_augmentation (r : Goods ≃ Fin (2 * k)) {A B : Finset Goods}
    (hA : UpperIndependent r A) (hB : UpperIndependent r B) (hc : A.card < B.card) :
    ∃ g ∈ B \ A, UpperIndependent r (insert g A) := by
  classical
  by_contra h
  let T := tightThresholds r A
  let t := T.max' (tightThresholds_nonempty r A)
  have ht : t ∈ tightThresholds r A :=
    Finset.max'_mem T (tightThresholds_nonempty r A)
  have hT := (mem_tightThresholds r A t).mp ht
  let S := rankPrefix r (2 * t)
  have hBA : B \ A ⊆ S := by
    intro g hg
    have hn : ¬UpperIndependent r (insert g A) := fun ha => h ⟨g, hg, ha⟩
    obtain ⟨s, hs, hgs⟩ := insertion_blocked_by_tight_prefix r hA (mem_sdiff.mp hg).2 hn
    have hst : s ≤ t := Finset.le_max' T s hs
    exact prefix_mono r (by omega : 2 * s ≤ 2 * t) hgs
  have hsub : B \ S ⊆ A \ S := by
    intro g hg
    obtain ⟨hgb, hgs⟩ := mem_sdiff.mp hg
    have hga : g ∈ A := by
      by_contra hn
      exact hgs (hBA (mem_sdiff.mpr ⟨hgb, hn⟩))
    exact mem_sdiff.mpr ⟨hga, hgs⟩
  have hout := Finset.card_le_card hsub
  have hin : (B ∩ S).card ≤ (A ∩ S).card := (hB t hT.1).trans_eq hT.2.symm
  have hcard_A := card_inside_add_outside A S
  have hcard_B := card_inside_add_outside B S
  omega

theorem upper_rank_attained (r : Goods ≃ Fin (2 * k)) :
    ∃ A : Finset Goods, UpperIndependent r A ∧ A.card = k := by
  obtain ⟨A, h, _⟩ := complementary_ordinal_seed r r
  exact ⟨A, h.2, feasible_card_eq r r h⟩

open Classical in
/-- The actual left-to-right scan of the first ranking under the second ranking's quotas. -/
noncomputable def scan (p q : Goods ≃ Fin (2 * k)) : ℕ → Finset Goods
  | 0 => ∅
  | n + 1 =>
    if hn : n < 2 * k then
      let g := p.symm ⟨n, hn⟩
      let previous := scan p q n
      if UpperIndependent q (insert g previous) then insert g previous else previous
    else scan p q n

theorem scan_independent (p q : Goods ≃ Fin (2 * k)) (n : ℕ) :
    UpperIndependent q (scan p q n) := by
  classical
  induction n with
  | zero => exact empty_upper q
  | succ n ih =>
    by_cases hn : n < 2 * k
    · rw [scan, dif_pos hn]
      dsimp only
      split_ifs with hI
      · exact hI
      · exact ih
    · rw [scan, dif_neg hn]
      exact ih

theorem scan_mono (p q : Goods ≃ Fin (2 * k)) : Monotone (scan p q) := by
  classical
  apply monotone_nat_of_le_succ
  intro n
  by_cases hn : n < 2 * k
  · conv_rhs => rw [scan, dif_pos hn]
    dsimp only
    split_ifs
    · exact Finset.subset_insert _ _
    · exact Finset.Subset.refl _
  · conv_rhs => rw [scan, dif_neg hn]

theorem scan_subset_prefix (p q : Goods ≃ Fin (2 * k)) (n : ℕ) :
    scan p q n ⊆ rankPrefix p n := by
  classical
  induction n with
  | zero => simp [scan]
  | succ n ih =>
    have hmono : rankPrefix p n ⊆ rankPrefix p (n + 1) :=
      prefix_mono p (Nat.le_succ n)
    by_cases hn : n < 2 * k
    · rw [scan, dif_pos hn]
      dsimp only
      split_ifs
      · apply Finset.insert_subset_iff.mpr
        refine ⟨?_, ih.trans hmono⟩
        exact (mem_prefix p _ _).mpr (by simp)
      · exact ih.trans hmono
    · rw [scan, dif_neg hn]
      exact ih.trans hmono

noncomputable def greedy (p q : Goods ≃ Fin (2 * k)) : Finset Goods := scan p q (2 * k)

theorem greedy_independent (p q : Goods ≃ Fin (2 * k)) :
    UpperIndependent q (greedy p q) := scan_independent p q _

theorem inserted_when_independent (p q : Goods ≃ Fin (2 * k)) (g : Goods)
    (h : UpperIndependent q (insert g (scan p q (p g).val))) :
    g ∈ scan p q ((p g).val + 1) := by
  classical
  rw [scan, dif_pos (p g).isLt]
  simp only [p.symm_apply_apply, if_pos h, Finset.mem_insert_self]

theorem greedy_maximal (p q : Goods ≃ Fin (2 * k)) {g : Goods}
    (hg : g ∉ greedy p q) : ¬UpperIndependent q (insert g (greedy p q)) := by
  intro h
  have hA : scan p q (p g).val ⊆ greedy p q := scan_mono p q (p g).isLt.le
  have hsub : insert g (scan p q (p g).val) ⊆ insert g (greedy p q) :=
    Finset.insert_subset_insert g hA
  have hg' := inserted_when_independent p q g (upper_mono q hsub h)
  exact hg (scan_mono p q (p g).isLt hg')

theorem greedy_card (p q : Goods ≃ Fin (2 * k)) : (greedy p q).card = k := by
  refine le_antisymm (upper_card q (greedy_independent p q)) ?_
  by_contra hn
  obtain ⟨A, hA, hcard⟩ := upper_rank_attained q
  have hlt : (greedy p q).card < A.card := by omega
  obtain ⟨g, hg, hgi⟩ := upper_augmentation q (greedy_independent p q) hA hlt
  exact greedy_maximal p q (mem_sdiff.mp hg).2 hgi

theorem first_disagreement_in_greedy (p q : Goods ≃ Fin (2 * k))
    {A : Finset Goods} (hA : UpperIndependent q A) (hne : A ≠ greedy p q) :
    ∃ g ∈ greedy p q \ A,
      (∀ a ∈ A \ greedy p q, (p g).val < (p a).val) ∧
      ∀ x ∈ (A \ greedy p q) ∪ (greedy p q \ A), (p g).val ≤ (p x).val := by
  classical
  let G := greedy p q
  let D := (A \ G) ∪ (G \ A)
  have hD : D.Nonempty := by
    by_contra hn
    have he := Finset.not_nonempty_iff_eq_empty.mp hn
    apply hne
    ext x
    have hnone : x ∉ D := by rw [he]; simp
    simp only [D, mem_union, mem_sdiff] at hnone
    aesop
  obtain ⟨g, hg, hmin⟩ := Finset.exists_min_image D (fun a => (p a).val) hD
  have hcase := mem_union.mp hg
  have hG : g ∈ G \ A := by
    rcases hcase with ha | hb
    · have hprefix_subset : scan p q (p g).val ⊆ A := by
        intro a ha
        have hr := (mem_prefix p _ a).mp (scan_subset_prefix p q _ ha)
        have hG' : a ∈ G := scan_mono p q (p g).isLt.le ha
        by_contra hn
        have hD' : a ∈ D := mem_union.mpr (Or.inr (mem_sdiff.mpr ⟨hG', hn⟩))
        exact (Nat.not_lt_of_ge (hmin _ hD')) hr
      have hI : UpperIndependent q (insert g (scan p q (p g).val)) :=
        upper_mono q (Finset.insert_subset_iff.mpr ⟨(mem_sdiff.mp ha).1, hprefix_subset⟩) hA
      have hg' : g ∈ G := scan_mono p q (p g).isLt (inserted_when_independent p q g hI)
      exact ((mem_sdiff.mp ha).2 hg').elim
    · exact hb
  refine ⟨g, hG, ?_, hmin⟩
  intro a ha
  refine lt_of_le_of_ne (hmin _ (mem_union.mpr (Or.inl ha))) ?_
  intro hn
  have he : g = a := p.injective (Fin.ext hn)
  exact (mem_sdiff.mp ha).2 (he ▸ (mem_sdiff.mp hG).1)

end MarketFairDivision
