import TriangleModel

namespace Review15Johnson
open Finset

private theorem card3 {a b c : ℕ} (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) :
    ({a,b,c} : Finset ℕ).card = 3 := by
  simp [hab, hac, hbc]

private theorem triple_inter (a b c : ℕ) (T : Finset ℕ)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) :
    (({a,b,c} : Finset ℕ) ∩ T).card =
      (if a ∈ T then 1 else 0) + (if b ∈ T then 1 else 0) + (if c ∈ T then 1 else 0) := by
  by_cases ha : a ∈ T <;> by_cases hb : b ∈ T <;> by_cases hc : c ∈ T <;>
    simp [insert_inter_distrib, singleton_inter, ha, hb, hc, hab, hac, hbc]

noncomputable def bigO (m r : ℕ) : Finset ℕ :=
  if r = m then {r,r+1,0} else {r,r+1,r+2}

noncomputable def bigE (m r : ℕ) : Finset ℕ := {m+2,r+1,r+2}
noncomputable def bigExtra (m : ℕ) : Finset ℕ := {m+1,0,1}

private theorem bigO_card (m r : ℕ) (hm : 3 ≤ m) (_hr : r ≤ m) :
    (bigO m r).card = 3 := by
  unfold bigO
  split_ifs with h
  · apply card3 <;> omega
  · apply card3 <;> omega

private theorem bigE_card (m r : ℕ) (_hm : 3 ≤ m) (hr : r < m) :
    (bigE m r).card = 3 := by
  apply card3 <;> omega

private theorem bigExtra_card (m : ℕ) (hm : 3 ≤ m) :
    (bigExtra m).card = 3 := by
  apply card3 <;> omega

private theorem bigOO_adj (m r s : ℕ) (hm : 3 ≤ m) (hr : r ≤ m) (hs : s ≤ m) :
    Adj (bigO m r) (bigO m s) ↔ r + 1 = s ∨ s + 1 = r := by
  rw [adj_iff_inter_card (by decide : 0 < 3) (bigO_card m r hm hr) (bigO_card m s hm hs)]
  unfold bigO
  split_ifs with hrm hsm
  all_goals rw [triple_inter] <;> try omega
  all_goals simp only [mem_insert, mem_singleton]
  all_goals split_ifs
  all_goals simp_all
  all_goals omega

private theorem bigEE_adj (m r s : ℕ) (hm : 3 ≤ m) (hr : r < m) (hs : s < m) :
    Adj (bigE m r) (bigE m s) ↔ r + 1 = s ∨ s + 1 = r := by
  rw [adj_iff_inter_card (by decide : 0 < 3) (bigE_card m r hm hr) (bigE_card m s hm hs)]
  unfold bigE
  rw [triple_inter] <;> try omega
  simp only [mem_insert, mem_singleton]
  split_ifs
  all_goals simp_all
  all_goals omega

private theorem bigEO_adj (m r s : ℕ) (hm : 3 ≤ m) (hr : r < m) (hs : s ≤ m) :
    Adj (bigE m r) (bigO m s) ↔ s = r ∨ s = r + 1 := by
  rw [adj_iff_inter_card (by decide : 0 < 3) (bigE_card m r hm hr) (bigO_card m s hm hs)]
  unfold bigE bigO
  split_ifs with hsm
  all_goals rw [triple_inter] <;> try omega
  all_goals simp only [mem_insert, mem_singleton]
  all_goals split_ifs
  all_goals simp_all
  all_goals omega

private theorem bigExtraO_adj (m r : ℕ) (hm : 3 ≤ m) (hr : r ≤ m) :
    Adj (bigExtra m) (bigO m r) ↔ r = 0 ∨ r = m := by
  rw [adj_iff_inter_card (by decide : 0 < 3) (bigExtra_card m hm) (bigO_card m r hm hr)]
  unfold bigExtra bigO
  split_ifs with hrm
  all_goals rw [triple_inter] <;> try omega
  all_goals simp only [mem_insert, mem_singleton]
  all_goals split_ifs
  all_goals simp_all
  all_goals omega

private theorem bigExtraE_not_adj (m r : ℕ) (hm : 3 ≤ m) (hr : r < m) :
    ¬ Adj (bigExtra m) (bigE m r) := by
  rw [adj_iff_inter_card (by decide : 0 < 3) (bigExtra_card m hm) (bigE_card m r hm hr)]
  unfold bigExtra bigE
  rw [triple_inter] <;> try omega
  simp only [mem_insert, mem_singleton]
  split_ifs
  all_goals simp_all
  all_goals omega

private theorem bigOO_injective (m r s : ℕ) (hm : 3 ≤ m) (hr : r ≤ m) (_hs : s ≤ m)
    (heq : bigO m r = bigO m s) : r = s := by
  have hc : (bigO m r ∩ bigO m s).card = 3 := by
    rw [← heq, inter_self]; exact bigO_card m r hm hr
  unfold bigO at hc
  split_ifs at hc
  all_goals rw [triple_inter] at hc <;> try omega
  all_goals simp only [mem_insert, mem_singleton] at hc
  all_goals split_ifs at hc
  all_goals simp_all
  all_goals omega

private theorem bigEE_injective (m r s : ℕ) (hm : 3 ≤ m) (hr : r < m) (hs : s < m)
    (heq : bigE m r = bigE m s) : r = s := by
  have hc : (bigE m r ∩ bigE m s).card = 3 := by
    rw [← heq, inter_self]; exact bigE_card m r hm hr
  unfold bigE at hc
  rw [triple_inter] at hc <;> try omega
  simp only [mem_insert, mem_singleton] at hc
  split_ifs at hc
  all_goals simp_all
  all_goals omega

private theorem bigEO_ne (m r s : ℕ) (hm : 3 ≤ m) (_hr : r < m) (hs : s ≤ m) :
    bigE m r ≠ bigO m s := by
  intro he
  have ht : m + 2 ∈ bigE m r := by simp [bigE]
  rw [he] at ht
  unfold bigO at ht
  split_ifs at ht <;> simp only [mem_insert, mem_singleton] at ht <;> omega

private theorem bigExtraO_ne (m r : ℕ) (hm : 3 ≤ m) (hr : r ≤ m) :
    bigExtra m ≠ bigO m r := by
  intro heq
  have hc : (bigExtra m ∩ bigO m r).card = 3 := by
    rw [← heq, inter_self]; exact bigExtra_card m hm
  unfold bigExtra bigO at hc
  split_ifs at hc
  all_goals rw [triple_inter] at hc <;> try omega
  all_goals simp only [mem_insert, mem_singleton] at hc
  all_goals split_ifs at hc
  all_goals simp_all
  all_goals omega

private theorem bigExtraE_ne (m r : ℕ) (hm : 3 ≤ m) (_hr : r < m) :
    bigExtra m ≠ bigE m r := by
  intro he
  have ht : m + 2 ∈ bigE m r := by simp [bigE]
  rw [← he] at ht
  simp only [bigExtra, mem_insert, mem_singleton] at ht
  omega

noncomputable def bigChain (m j : ℕ) : Finset ℕ :=
  if j % 2 = 0 then bigO m (j / 2) else bigE m (j / 2)

noncomputable def bigRep (m : ℕ) (hm : 3 ≤ m) : ClosedChainRep (2*m+1) ℕ where
  k := 3
  k_pos := by decide
  chain := bigChain m
  extra := bigExtra m
  card_chain := by
    intro j hj
    unfold bigChain
    split_ifs with hp
    · exact bigO_card m (j / 2) hm (by omega)
    · exact bigE_card m (j / 2) hm (by omega)
  card_extra := bigExtra_card m hm
  injective_chain := by
    intro i j hi hj heq
    unfold bigChain at heq
    split_ifs at heq with hpi hpj hpj
    · have hh := bigOO_injective m (i/2) (j/2) hm (by omega) (by omega) heq
      omega
    · exact False.elim (bigEO_ne m (j/2) (i/2) hm (by omega) (by omega) heq.symm)
    · exact False.elim (bigEO_ne m (i/2) (j/2) hm (by omega) (by omega) heq)
    · have hh := bigEE_injective m (i/2) (j/2) hm (by omega) (by omega) heq
      omega
  extra_distinct := by
    intro j hj
    unfold bigChain
    split_ifs with hp
    · exact bigExtraO_ne m (j/2) hm (by omega)
    · exact bigExtraE_ne m (j/2) hm (by omega)
  chain_adj := by
    intro i j hi hj
    unfold bigChain
    split_ifs with hpi hpj hpj
    · rw [bigOO_adj m (i/2) (j/2) hm (by omega) (by omega)]
      omega
    · have hsym : Adj (bigO m (i/2)) (bigE m (j/2)) ↔
        Adj (bigE m (j/2)) (bigO m (i/2)) := ⟨adj_symm, adj_symm⟩
      rw [hsym, bigEO_adj m (j/2) (i/2) hm (by omega) (by omega)]
      omega
    · rw [bigEO_adj m (i/2) (j/2) hm (by omega) (by omega)]
      omega
    · rw [bigEE_adj m (i/2) (j/2) hm (by omega) (by omega)]
      omega
  extra_adj := by
    intro j hj
    unfold bigChain
    split_ifs with hp
    · rw [bigExtraO_adj m (j/2) hm (by omega)]
      omega
    · have hn := bigExtraE_not_adj m (j/2) hm (by omega)
      constructor
      · exact fun h => False.elim (hn h)
      · omega

noncomputable def oneChain : ℕ → Finset ℕ
  | 0 => {0,1}
  | 1 => {3,1}
  | 2 => {1,2}
  | _ => ∅

noncomputable def twoChain : ℕ → Finset ℕ
  | 0 => {0,1}
  | 1 => {4,1}
  | 2 => {1,2}
  | 3 => {4,2}
  | 4 => {2,3}
  | _ => ∅

noncomputable def oneRep : ClosedChainRep 3 ℕ where
  k := 2
  k_pos := by decide
  chain := oneChain
  extra := {2,0}
  card_chain := by
    intro j hj
    have h : j = 0 ∨ j = 1 ∨ j = 2 := by omega
    rcases h with rfl | rfl | rfl <;> decide
  card_extra := by decide
  injective_chain := by
    intro i j hi hj he
    have h1 : i = 0 ∨ i = 1 ∨ i = 2 := by omega
    have h2 : j = 0 ∨ j = 1 ∨ j = 2 := by omega
    rcases h1 with rfl | rfl | rfl <;> rcases h2 with rfl | rfl | rfl <;>
      (revert he; decide)
  extra_distinct := by
    intro j hj
    have h : j = 0 ∨ j = 1 ∨ j = 2 := by omega
    rcases h with rfl | rfl | rfl <;> decide
  chain_adj := by
    intro i j hi hj
    have h1 : i = 0 ∨ i = 1 ∨ i = 2 := by omega
    have h2 : j = 0 ∨ j = 1 ∨ j = 2 := by omega
    rcases h1 with rfl | rfl | rfl <;> rcases h2 with rfl | rfl | rfl <;>
      simp only [Adj] <;> decide
  extra_adj := by
    intro j hj
    have h : j = 0 ∨ j = 1 ∨ j = 2 := by omega
    rcases h with rfl | rfl | rfl <;> simp only [Adj] <;> decide

noncomputable def twoRep : ClosedChainRep 5 ℕ where
  k := 2
  k_pos := by decide
  chain := twoChain
  extra := {3,0}
  card_chain := by
    intro j hj
    have h : j = 0 ∨ j = 1 ∨ j = 2 ∨ j = 3 ∨ j = 4 := by omega
    rcases h with rfl | rfl | rfl | rfl | rfl <;> decide
  card_extra := by decide
  injective_chain := by
    intro i j hi hj he
    have h1 : i = 0 ∨ i = 1 ∨ i = 2 ∨ i = 3 ∨ i = 4 := by omega
    have h2 : j = 0 ∨ j = 1 ∨ j = 2 ∨ j = 3 ∨ j = 4 := by omega
    rcases h1 with rfl | rfl | rfl | rfl | rfl <;>
      rcases h2 with rfl | rfl | rfl | rfl | rfl <;> (revert he; decide)
  extra_distinct := by
    intro j hj
    have h : j = 0 ∨ j = 1 ∨ j = 2 ∨ j = 3 ∨ j = 4 := by omega
    rcases h with rfl | rfl | rfl | rfl | rfl <;> decide
  chain_adj := by
    intro i j hi hj
    have h1 : i = 0 ∨ i = 1 ∨ i = 2 ∨ i = 3 ∨ i = 4 := by omega
    have h2 : j = 0 ∨ j = 1 ∨ j = 2 ∨ j = 3 ∨ j = 4 := by omega
    rcases h1 with rfl | rfl | rfl | rfl | rfl <;>
      rcases h2 with rfl | rfl | rfl | rfl | rfl <;> simp only [Adj] <;> decide
  extra_adj := by
    intro j hj
    have h : j = 0 ∨ j = 1 ∨ j = 2 ∨ j = 3 ∨ j = 4 := by omega
    rcases h with rfl | rfl | rfl | rfl | rfl <;> simp only [Adj] <;> decide

theorem odd_rep (m : ℕ) (hm : 1 ≤ m) :
    ∃ R : ClosedChainRep (2*m+1) ℕ, R.k = (if m ≤ 2 then 2 else 3) := by
  by_cases h : m ≤ 2
  · have hh : m = 1 ∨ m = 2 := by omega
    rcases hh with rfl | rfl
    · exact ⟨oneRep, rfl⟩
    · exact ⟨twoRep, rfl⟩
  · exact ⟨bigRep m (by omega), by simp [bigRep, h]⟩

#print axioms odd_rep

end Review15Johnson
