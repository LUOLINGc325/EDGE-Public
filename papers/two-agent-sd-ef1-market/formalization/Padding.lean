import MarketCrossings
import Mathlib.Data.Fintype.Option
import Mathlib.Logic.Equiv.Fin.Basic

open Finset
open scoped BigOperators

namespace MarketFairDivision

variable {Goods : Type*} {m : ℕ}

noncomputable def paddedRank (r : Goods ≃ Fin m) : Option Goods ≃ Fin (m + 1) :=
  r.optionCongr.trans (finSuccEquivLast (n := m)).symm

@[simp] theorem paddedRank_some (r : Goods ≃ Fin m) (x : Goods) :
    paddedRank r (some x) = (r x).castSucc := by
  simp [paddedRank, Equiv.optionCongr, finSuccEquivLast_symm_some]

@[simp] theorem paddedRank_none (r : Goods ≃ Fin m) :
    paddedRank r none = Fin.last m := by
  simp [paddedRank, Equiv.optionCongr]

noncomputable def someEmbedding : Goods ↪ Option Goods := ⟨some, fun _ _ h => Option.some.inj h⟩

variable [Fintype Goods] [DecidableEq Goods]

noncomputable def realGoods (A : Finset (Option Goods)) : Finset Goods :=
  Finset.univ.filter (fun x => some x ∈ A)

@[simp] theorem mem_realGoods (A : Finset (Option Goods)) (x : Goods) :
    x ∈ realGoods A ↔ some x ∈ A := by simp [realGoods]

@[simp] theorem realGoods_other (A : Finset (Option Goods)) :
    realGoods (other A) = other (realGoods A) := by ext x; simp

theorem realGoods_map (A : Finset (Option Goods)) :
    (realGoods A).map someEmbedding = A.erase none := by
  ext x
  cases x <;> simp [Finset.mem_map, someEmbedding]

theorem realGoods_card (A : Finset (Option Goods)) :
    (realGoods A).card = (A.erase none).card := by
  rw [← realGoods_map A, Finset.card_map]

omit [DecidableEq Goods] in
theorem padded_prefix (r : Goods ≃ Fin m) {l : ℕ} (hl : l ≤ m) :
    rankPrefix (paddedRank r) l = (rankPrefix r l).map someEmbedding := by
  ext x
  cases x <;> simp [Finset.mem_map, someEmbedding, Nat.not_lt_of_ge hl]

theorem real_prefix_count (r : Goods ≃ Fin m) (A : Finset (Option Goods))
    {l : ℕ} (hl : l ≤ m) :
    (realGoods A ∩ rankPrefix r l).card = (A ∩ rankPrefix (paddedRank r) l).card := by
  have he : (realGoods A ∩ rankPrefix r l).map someEmbedding =
      A ∩ rankPrefix (paddedRank r) l := by
    ext x
    cases x <;> simp [Finset.mem_map, someEmbedding, Nat.not_lt_of_ge hl]
  rw [← he, Finset.card_map]

theorem rank_remove_dummy (r : Goods ≃ Fin m) {A B : Finset (Option Goods)}
    (h : RankEF1 (paddedRank r) A B) : RankEF1 r (realGoods A) (realGoods B) := by
  apply (prefix_witness_equivalence r _ _).mpr
  have h' := (prefix_witness_equivalence (paddedRank r) A B).mp h
  intro l hl
  rw [real_prefix_count r B hl, real_prefix_count r A hl]
  exact h' l (hl.trans (Nat.le_succ _))

noncomputable def paddedWeight (w : Goods → ℝ) : Option Goods → ℝ := Option.elim' 0 w

omit [Fintype Goods] [DecidableEq Goods] in
@[simp] theorem paddedWeight_some (w : Goods → ℝ) (x : Goods) :
    paddedWeight w (some x) = w x := rfl

omit [Fintype Goods] [DecidableEq Goods] in
@[simp] theorem paddedWeight_none (w : Goods → ℝ) : paddedWeight w none = 0 := rfl

omit [Fintype Goods] [DecidableEq Goods] in
theorem paddedWeight_nonneg (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x) :
    ∀ x, 0 ≤ paddedWeight w x := by
  intro x
  cases x <;> simp [hw]

theorem value_realGoods (w : Goods → ℝ) (A : Finset (Option Goods)) :
    value w (realGoods A) = value (paddedWeight w) A := by
  have hsum : value (paddedWeight w) ((realGoods A).map someEmbedding) =
      value w (realGoods A) := by simp [value, someEmbedding, Finset.sum_map]
  rw [realGoods_map] at hsum
  rw [← hsum]
  by_cases ha : none ∈ A
  · simpa using value_erase_add (paddedWeight w) ha
  · rw [Finset.erase_eq_of_not_mem ha]

theorem realGoods_erase_some (A : Finset (Option Goods)) (x : Goods) :
    realGoods (A.erase (some x)) = (realGoods A).erase x := by
  ext y
  simp [Finset.mem_erase]

@[simp] theorem realGoods_erase_none (A : Finset (Option Goods)) :
    realGoods (A.erase none) = realGoods A := by
  ext y
  simp [Finset.mem_erase]

theorem additive_remove_dummy (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x)
    {A B : Finset (Option Goods)} (h : AdditiveEF1 (paddedWeight w) A B) :
    AdditiveEF1 w (realGoods A) (realGoods B) := by
  rcases h with hB | ⟨x, hx, h⟩
  · left
    ext y
    simp [hB]
  · rw [← value_realGoods w (B.erase x), ← value_realGoods w A] at h
    cases x with
    | none => exact ef1_of_no_envy w hw (by simpa using h)
    | some x =>
      exact Or.inr ⟨x, (mem_realGoods B x).mpr hx, by simpa only [realGoods_erase_some] using h⟩

theorem market_remove_dummy (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x)
    {A : Finset (Option Goods)} (h : MarketEF1 (paddedWeight w) A) :
    MarketEF1 w (realGoods A) := by
  unfold MarketEF1 at h ⊢
  rw [← realGoods_other]
  exact ⟨additive_remove_dummy w hw h.1, additive_remove_dummy w hw h.2⟩

def Balanced (A B : Finset Goods) : Prop := A.card ≤ B.card + 1 ∧ B.card ≤ A.card + 1

theorem real_bundles_balanced {A : Finset (Option Goods)}
    (h : A.card = (other A).card) : Balanced (realGoods A) (other (realGoods A)) := by
  unfold Balanced
  rw [← realGoods_other, realGoods_card, realGoods_card]
  have hb : ∀ S : Finset (Option Goods), (S.erase none).card ≤ S.card ∧
      S.card ≤ (S.erase none).card + 1 := by
    intro S
    by_cases hn : none ∈ S
    · have := Finset.card_erase_add_one hn
      omega
    · simp [Finset.erase_eq_of_not_mem hn]
  have h₁ := hb A
  have h₂ := hb (other A)
  omega

theorem ef1_reindex {n : ℕ} (r : Goods ≃ Fin m) (he : m = n) (A B : Finset Goods) :
    RankEF1 (r.trans (finCongr he)) A B ↔ RankEF1 r A B := by
  subst n
  rfl

theorem simultaneous_strict (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x) (p q : Goods ≃ Fin m) :
    ∃ A, Balanced A (other A) ∧ RankEF1 p A (other A) ∧
      RankEF1 q (other A) A ∧ MarketEF1 w A := by
  let k := m / 2
  by_cases he : m = 2 * k
  · obtain ⟨A, hA, hB, hp, hq, hm⟩ :=
      simultaneous_even w hw (p.trans (finCongr he)) (q.trans (finCongr he))
    exact ⟨A, ⟨by omega, by omega⟩, (ef1_reindex p he _ _).mp hp,
      (ef1_reindex q he _ _).mp hq, hm⟩
  · have ho : m + 1 = 2 * (k + 1) := by dsimp [k] at *; omega
    obtain ⟨A, hA, hB, hP, hQ, hm⟩ :=
      simultaneous_even (paddedWeight w) (paddedWeight_nonneg w hw)
        ((paddedRank p).trans (finCongr ho)) ((paddedRank q).trans (finCongr ho))
    refine ⟨realGoods A, real_bundles_balanced (hA.trans hB.symm), ?_, ?_,
      market_remove_dummy w hw hm⟩
    · rw [← realGoods_other]
      exact rank_remove_dummy p ((ef1_reindex (paddedRank p) ho _ _).mp hP)
    · rw [← realGoods_other]
      exact rank_remove_dummy q ((ef1_reindex (paddedRank q) ho _ _).mp hQ)

end MarketFairDivision
