import GreedyUpper

open Finset

namespace MarketFairDivision

variable {Goods : Type*} [DecidableEq Goods] {k : ℕ}

noncomputable def exchange (A : Finset Goods) (a g : Goods) : Finset Goods :=
  insert g (A.erase a)

def SingleExchange (A B : Finset Goods) : Prop :=
  ∃ a ∈ A, ∃ g ∉ A, B = exchange A a g

theorem exchange_card (A : Finset Goods) {a g : Goods} (ha : a ∈ A) (hg : g ∉ A) :
    (exchange A a g).card = A.card := by
  unfold exchange
  rw [Finset.card_insert_of_not_mem (fun hi => hg (Finset.mem_erase.mp hi).2)]
  exact Finset.card_erase_add_one ha

theorem exchange_card_prefix (A S : Finset Goods) {a g : Goods} (hg : g ∉ A) :
    (exchange A a g ∩ S).card = (A ∩ S).card +
      (if g ∈ S then 1 else 0) - (if a ∈ A ∩ S then 1 else 0) := by
  unfold exchange
  rw [insert_inter_eq, erase_inter_eq]
  have hg' : g ∉ (A ∩ S).erase a := fun h => hg (mem_inter.mp (mem_erase.mp h).2).1
  by_cases hgin : g ∈ S <;> by_cases hain : a ∈ A ∩ S
  · simp only [if_pos hgin, if_pos hain, Finset.card_insert_of_not_mem hg']
    have hc := Finset.card_erase_add_one hain
    omega
  · simp only [if_pos hgin, if_neg hain, Finset.card_insert_of_not_mem hg',
      Finset.erase_eq_of_not_mem hain, Nat.sub_zero]
    exact Finset.card_insert_of_not_mem (fun h => hg (mem_inter.mp h).1)
  · simp only [if_neg hgin, if_pos hain]
    have hc := Finset.card_erase_add_one hain
    omega
  · simp only [if_neg hgin, if_neg hain, Finset.erase_eq_of_not_mem hain, Nat.add_zero, Nat.sub_zero]

theorem SingleExchange.reverse {A B : Finset Goods} (h : SingleExchange A B) :
    SingleExchange B A := by
  obtain ⟨a, ha, g, hg, rfl⟩ := h
  have hne : a ≠ g := fun he => hg (he ▸ ha)
  have hga : g ∈ exchange A a g := by simp [exchange]
  have haa : a ∉ exchange A a g := by simp [exchange, hne]
  refine ⟨g, hga, a, haa, ?_⟩
  ext x
  simp only [exchange, mem_insert, mem_erase]
  constructor
  · intro hx
    by_cases hx' : x = a
    · exact Or.inl hx'
    · exact Or.inr ⟨fun he => hg (he ▸ hx), Or.inr ⟨hx', hx⟩⟩
  · intro hx
    rcases hx with hxa | ⟨hxg, h⟩
    · exact hxa.symm ▸ ha
    · exact h.elim (fun he => (hxg he).elim) And.right

theorem exchange_decreases_outside {A G : Finset Goods} {a g : Goods}
    (ha : a ∈ A \ G) (hg : g ∈ G) :
    (exchange A a g \ G).card + 1 = (A \ G).card := by
  have he : exchange A a g \ G = (A \ G).erase a := by
    ext x
    simp only [exchange, mem_sdiff, mem_insert, mem_erase]
    aesop
  rw [he, Finset.card_erase_add_one ha]

variable [Fintype Goods]

theorem lower_preserved_by_earlier_insertion (p : Goods ≃ Fin (2 * k)) {A : Finset Goods}
    (hA : LowerQuotas p A) {a g : Goods} (hg : g ∉ A) (hr : (p g).val < (p a).val) :
    LowerQuotas p (exchange A a g) := by
  intro t ht
  rw [exchange_card_prefix A _ hg]
  have hAt := hA t ht
  by_cases ha : a ∈ A ∩ rankPrefix p (2 * t)
  · have hgp := (mem_prefix p _ _).mpr (hr.trans ((mem_prefix p _ _).mp (mem_inter.mp ha).2))
    simp [ha, hgp, hAt]
  · by_cases hgp : g ∈ rankPrefix p (2 * t) <;> simp [ha, hgp] <;> omega

private noncomputable def tightContaining (q : Goods ≃ Fin (2 * k)) (A : Finset Goods)
    (g : Goods) : Finset ℕ :=
  (tightThresholds q A).filter (fun t => g ∈ rankPrefix q (2 * t))

private theorem tightContaining_mem (q : Goods ≃ Fin (2 * k)) (A : Finset Goods) (g : Goods) (t : ℕ) :
    t ∈ tightContaining q A g ↔
      t ≤ k ∧ (A ∩ rankPrefix q (2 * t)).card = t ∧ g ∈ rankPrefix q (2 * t) := by
  simp [tightContaining, and_assoc]

/-- The three choices in one forward step of the ranked exchange procedure. -/
def GreedyChoice (p q : Goods ≃ Fin (2 * k)) (A : Finset Goods)
    (a g : Goods) (s : ℕ) : Prop :=
  let G := greedy p q
  g ∈ G \ A ∧
    (∀ x ∈ (A \ G) ∪ (G \ A), (p g).val ≤ (p x).val) ∧
    s ∈ tightContaining q A g ∧ (∀ t ∈ tightContaining q A g, s ≤ t) ∧
    a ∈ (A \ G) ∩ rankPrefix q (2 * s) ∧
    ∀ x ∈ (A \ G) ∩ rankPrefix q (2 * s), (q a).val ≤ (q x).val

/-- The algorithm's three searches succeed, and their selected swap keeps all quotas. -/
theorem actual_greedy_step (p q : Goods ≃ Fin (2 * k)) {A : Finset Goods}
    (hA : OrdinalFeasible p q A) (hne : A ≠ greedy p q) :
    ∃ a g s, GreedyChoice p q A a g s ∧ OrdinalFeasible p q (exchange A a g) ∧
      (exchange A a g \ greedy p q).card + 1 = (A \ greedy p q).card := by
  classical
  let G := greedy p q
  have hcard := feasible_card_eq p q hA
  obtain ⟨g, hg, hpriority, hfirst⟩ := first_disagreement_in_greedy p q hA.2 hne
  obtain ⟨hgG, hgA⟩ := mem_sdiff.mp hg
  let T := tightContaining q A g
  have hT : T.Nonempty := ⟨k, (tightContaining_mem q A g k).mpr (by simp [hcard])⟩
  let s := T.min' hT
  have hs : s ∈ T := Finset.min'_mem T hT
  obtain ⟨hsk, hsTight, hgp⟩ := (tightContaining_mem q A g s).mp hs
  let S := rankPrefix q (2 * s)
  have hex : ∃ a ∈ A \ G, a ∈ S := by
    by_contra hn
    have hsub : A ∩ S ⊆ G ∩ S := by
      intro x hx
      have hxs := (mem_inter.mp hx).2
      have hxg : x ∈ G := by
        by_contra hn'
        exact hn ⟨x, mem_sdiff.mpr ⟨(mem_inter.mp hx).1, hn'⟩, hxs⟩
      exact mem_inter.mpr ⟨hxg, hxs⟩
    have hsub' : insert g (A ∩ S) ⊆ G ∩ S :=
      Finset.insert_subset_iff.mpr ⟨mem_inter.mpr ⟨hgG, hgp⟩, hsub⟩
    have hlt := Finset.card_le_card hsub'
    rw [Finset.card_insert_of_not_mem (fun h => hgA (mem_inter.mp h).1)] at hlt
    have hupper : (G ∩ S).card ≤ s := greedy_independent p q s hsk
    change (A ∩ S).card = s at hsTight
    omega
  have hchoices : ((A \ G) ∩ S).Nonempty := by
    obtain ⟨x, hx, hxs⟩ := hex
    exact ⟨x, mem_inter.mpr ⟨hx, hxs⟩⟩
  obtain ⟨a, hchoice, hout⟩ := Finset.exists_min_image _ (fun x => (q x).val) hchoices
  obtain ⟨ha, haS⟩ := mem_inter.mp hchoice
  have haA := (mem_sdiff.mp ha).1
  let B := exchange A a g
  have hlow : LowerQuotas p B := lower_preserved_by_earlier_insertion p hA.1 hgA (hpriority a ha)
  have hupp : UpperIndependent q B := by
    intro t ht
    let P := rankPrefix q (2 * t)
    change (exchange A a g ∩ P).card ≤ t
    rw [exchange_card_prefix A P hgA]
    apply FairDivisionCore.exchange_preserves_upper_capacity
    · exact hA.2 t ht
    · split_ifs <;> decide
    · intro he
      by_cases hgP : g ∈ P
      · have htT : t ∈ T := (tightContaining_mem q A g t).mpr ⟨ht, he, hgP⟩
        have hst : s ≤ t := Finset.min'_le T t htT
        have haP : a ∈ P := prefix_mono q (by omega : 2 * s ≤ 2 * t) haS
        simp [hgP, mem_inter.mpr ⟨haA, haP⟩]
      · simp [hgP]
  exact ⟨a, g, s, ⟨hg, hfirst, hs, fun t ht => Finset.min'_le T t ht, hchoice, hout⟩,
    ⟨hlow, hupp⟩, exchange_decreases_outside ha hgG⟩

theorem GreedyChoice.singleExchange {p q : Goods ≃ Fin (2 * k)} {A : Finset Goods}
    {a g : Goods} {s : ℕ} (h : GreedyChoice p q A a g s) :
    SingleExchange A (exchange A a g) :=
  ⟨a, (mem_sdiff.mp (mem_inter.mp h.2.2.2.2.1).1).1, g, (mem_sdiff.mp h.1).2, rfl⟩

theorem feasible_exchange_toward_greedy (p q : Goods ≃ Fin (2 * k)) {A : Finset Goods}
    (hA : OrdinalFeasible p q A) (hne : A ≠ greedy p q) :
    ∃ B, OrdinalFeasible p q B ∧ SingleExchange A B ∧
      (B \ greedy p q).card + 1 = (A \ greedy p q).card := by
  obtain ⟨a, g, s, hchoice, hfeas, hdist⟩ := actual_greedy_step p q hA hne
  exact ⟨exchange A a g, hfeas, hchoice.singleExchange, hdist⟩

end MarketFairDivision
