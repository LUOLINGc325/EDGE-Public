import RankedAllocations
import PairingColor

open Finset

namespace MarketFairDivision

noncomputable def partnerIndex {k : ℕ} (i : Fin (2 * k)) : Fin (2 * k) :=
  if h : i.val % 2 = 0 then ⟨i.val + 1, by have hi := i.isLt; omega⟩
  else ⟨i.val - 1, by have hi := i.isLt; omega⟩

theorem partnerIndex_val {k : ℕ} (i : Fin (2 * k)) :
    (partnerIndex i).val = if i.val % 2 = 0 then i.val + 1 else i.val - 1 := by
  unfold partnerIndex
  split_ifs <;> rfl

theorem partnerIndex_involution {k : ℕ} (i : Fin (2 * k)) :
    partnerIndex (partnerIndex i) = i := by
  apply Fin.ext
  simp only [partnerIndex_val]
  split_ifs <;> omega

theorem partnerIndex_ne {k : ℕ} (i : Fin (2 * k)) : partnerIndex i ≠ i := by
  intro h
  have he : (partnerIndex i).val = i.val := congrArg Fin.val h
  rw [partnerIndex_val] at he
  split_ifs at he <;> omega

noncomputable def rankPairIndex (k : ℕ) : Equiv.Perm (Fin (2 * k)) where
  toFun := partnerIndex
  invFun := partnerIndex
  left_inv := partnerIndex_involution
  right_inv := partnerIndex_involution

noncomputable def rankPair {Goods : Type*} {k : ℕ} (r : Goods ≃ Fin (2 * k)) :
    Equiv.Perm Goods := r.trans ((rankPairIndex k).trans r.symm)

theorem rankPair_rank {Goods : Type*} {k : ℕ} (r : Goods ≃ Fin (2 * k)) (x : Goods) :
    r (rankPair r x) = partnerIndex (r x) := by
  simp [rankPair, rankPairIndex]

theorem rankPair_involution {Goods : Type*} {k : ℕ} (r : Goods ≃ Fin (2 * k)) (x : Goods) :
    rankPair r (rankPair r x) = x := by
  apply r.injective
  rw [rankPair_rank, rankPair_rank, partnerIndex_involution]

theorem rankPair_ne {Goods : Type*} {k : ℕ} (r : Goods ≃ Fin (2 * k)) (x : Goods) :
    rankPair r x ≠ x :=
  fun hx => partnerIndex_ne (r x) ((rankPair_rank r x).symm.trans (congrArg r hx))

variable {Goods : Type*} [Fintype Goods] {k : ℕ}

noncomputable def colored (c : Goods → Bool) (b : Bool) : Finset Goods :=
  Finset.univ.filter (fun x => c x = b)

@[simp] theorem mem_colored (c : Goods → Bool) (b : Bool) (x : Goods) :
    x ∈ colored c b ↔ c x = b := by
  simp [colored]

variable [DecidableEq Goods]

theorem other_colored (c : Goods → Bool) : other (colored c true) = colored c false := by
  ext x
  cases hx : c x <;> simp [hx]

/-- Each even rankPrefix contains exactly one of each color from every ranked pair. -/
theorem colored_even_prefix (r : Goods ≃ Fin (2 * k)) (c : Goods → Bool) (b : Bool)
    (hflip : ∀ x, c (rankPair r x) = !(c x)) {t : ℕ} (ht : t ≤ k) :
    (colored c b ∩ rankPrefix r (2 * t)).card = t := by
  let low (i : Fin t) : Goods := r.symm ⟨2 * i.val, by have hi := i.isLt; omega⟩
  let high (i : Fin t) : Goods := r.symm ⟨2 * i.val + 1, by have hi := i.isLt; omega⟩
  have low_rank (i : Fin t) : (r (low i)).val = 2 * i.val := by
    simp [low]
  have high_rank (i : Fin t) : (r (high i)).val = 2 * i.val + 1 := by
    simp [high]
  have pair_eq (i : Fin t) : rankPair r (low i) = high i := by
    apply r.injective
    apply Fin.ext
    rw [rankPair_rank, partnerIndex_val, low_rank, high_rank]
    have h : (2 * i.val) % 2 = 0 := by omega
    rw [if_pos h]
  have color_flip (i : Fin t) : c (high i) = !(c (low i)) := by
    rw [← pair_eq i]
    exact hflip _
  let chosen (i : Fin t) : Goods := if c (low i) = b then low i else high i
  have chosen_color (i : Fin t) : c (chosen i) = b := by
    by_cases h : c (low i) = b
    · simp [chosen, h]
    · rw [show chosen i = high i by simp [chosen, h], color_flip]
      cases hi : c (low i) <;> cases b <;> simp_all
  have chosen_rank_pair (i : Fin t) : (r (chosen i)).val / 2 = i.val := by
    unfold chosen
    split_ifs
    · rw [low_rank]
      omega
    · rw [high_rank]
      omega
  have chosen_rank_lt (i : Fin t) : (r (chosen i)).val < 2 * t := by
    unfold chosen
    have hi := i.isLt
    split_ifs
    · rw [low_rank]
      omega
    · rw [high_rank]
      omega
  let e : Fin t ↪ Goods := ⟨chosen, fun i j h => by
    apply Fin.ext
    rw [← chosen_rank_pair i, ← chosen_rank_pair j, h]⟩
  have hset : colored c b ∩ rankPrefix r (2 * t) = Finset.univ.map e := by
    ext g
    simp only [mem_inter, mem_colored, mem_prefix, Finset.mem_map, Finset.mem_univ, true_and]
    constructor
    · rintro ⟨hgc, hgr⟩
      let i : Fin t := ⟨(r g).val / 2, by omega⟩
      refine ⟨i, ?_⟩
      change chosen i = g
      have hi : i.val = (r g).val / 2 := rfl
      have pair_cases : (r g).val = 2 * i.val ∨ (r g).val = 2 * i.val + 1 := by omega
      rcases pair_cases with he | he
      · have hl : g = low i := r.injective (Fin.ext (he.trans (low_rank i).symm))
        have hm : c (low i) = b := by rwa [← hl]
        simp [chosen, hm, hl]
      · have hh : g = high i := r.injective (Fin.ext (he.trans (high_rank i).symm))
        have hne : c (low i) ≠ b := by
          have h2 : c (high i) = b := by rwa [← hh]
          rw [color_flip] at h2
          intro h1
          rw [h1] at h2
          cases b <;> simp at h2
        simp [chosen, hne, hh]
    · rintro ⟨i, rfl⟩
      exact ⟨chosen_color i, chosen_rank_lt i⟩
  rw [hset, Finset.card_map, Finset.card_univ, Fintype.card_fin]

theorem complementary_ordinal_seed (p q : Goods ≃ Fin (2 * k)) :
    ∃ A : Finset Goods, OrdinalFeasible p q A ∧ OrdinalFeasible p q (other A) := by
  obtain ⟨c, hp, hq⟩ := exists_pair_coloring (rankPair p) (rankPair q)
    (rankPair_involution p) (rankPair_involution q) (rankPair_ne p) (rankPair_ne q)
  refine ⟨colored c true, ⟨?_, ?_⟩, ?_⟩
  · intro t ht
    exact (colored_even_prefix p c true hp ht).ge
  · intro t ht
    exact (colored_even_prefix q c true hq ht).le
  · rw [other_colored]
    exact ⟨fun t ht => (colored_even_prefix p c false hp ht).ge,
      fun t ht => (colored_even_prefix q c false hq ht).le⟩

end MarketFairDivision
