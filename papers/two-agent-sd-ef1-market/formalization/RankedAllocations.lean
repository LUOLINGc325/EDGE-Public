import CsCore
import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Max
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fin.Basic

open Finset

namespace MarketFairDivision

variable {Goods : Type*} [Fintype Goods] {m k : ℕ}

noncomputable def rankPrefix (r : Goods ≃ Fin m) (l : ℕ) : Finset Goods :=
  Finset.univ.filter fun g => (r g).val < l

@[simp] theorem mem_prefix (r : Goods ≃ Fin m) (l : ℕ) (g : Goods) :
    g ∈ rankPrefix r l ↔ (r g).val < l := by
  simp [rankPrefix]

theorem prefix_mono (r : Goods ≃ Fin m) : Monotone (rankPrefix r) := by
  intro a b hab g hg
  exact (mem_prefix r b g).mpr (((mem_prefix r a g).mp hg).trans_le hab)

@[simp] theorem prefix_zero (r : Goods ≃ Fin m) : rankPrefix r 0 = ∅ := by
  ext g
  simp

@[simp] theorem prefix_all (r : Goods ≃ Fin m) : rankPrefix r m = Finset.univ := by
  ext g
  simp [(r g).isLt]

theorem card_goods (r : Goods ≃ Fin m) : Fintype.card Goods = m :=
  (Fintype.card_congr r).trans (Fintype.card_fin m)

theorem card_prefix (r : Goods ≃ Fin m) {l : ℕ} (hl : l ≤ m) :
    (rankPrefix r l).card = l := by
  let e : Fin l ↪ Goods :=
    ⟨fun i => r.symm ⟨i.val, i.isLt.trans_le hl⟩, fun i j h => by
      have he : (⟨i.val, i.isLt.trans_le hl⟩ : Fin m) = ⟨j.val, j.isLt.trans_le hl⟩ :=
        r.symm.injective h
      exact Fin.ext (congrArg (fun a : Fin m => a.val) he)⟩
  have he : rankPrefix r l = Finset.univ.map e := by
    ext g
    rw [mem_prefix, Finset.mem_map]
    constructor
    · intro hg
      refine ⟨⟨(r g).val, hg⟩, Finset.mem_univ _, ?_⟩
      change r.symm ⟨(r g).val, _⟩ = g
      exact r.symm_apply_apply g
    · rintro ⟨i, _, hi⟩
      change r.symm ⟨i.val, i.isLt.trans_le hl⟩ = g at hi
      have hv : ⟨i.val, i.isLt.trans_le hl⟩ = r g := by
        rw [← hi, r.apply_symm_apply]
      rw [← hv]
      exact i.isLt
  rw [he, Finset.card_map, Finset.card_univ, Fintype.card_fin]

variable [DecidableEq Goods]

noncomputable def other (A : Finset Goods) : Finset Goods := Finset.univ \ A

@[simp] theorem mem_other (g : Goods) (A : Finset Goods) : g ∈ other A ↔ g ∉ A := by
  simp [other]

@[simp] theorem other_other (A : Finset Goods) : other (other A) = A := by
  ext g
  simp

theorem card_partition (A S : Finset Goods) :
    (A ∩ S).card + (other A ∩ S).card = S.card := by
  have he : other A ∩ S = S \ (A ∩ S) := by
    ext g
    simp only [Finset.mem_inter, mem_other, Finset.mem_sdiff]
    aesop
  rw [he, Nat.add_comm]
  exact Finset.card_sdiff_add_card_eq_card Finset.inter_subset_right

theorem card_allocation (A : Finset Goods) :
    A.card + (other A).card = Fintype.card Goods := by
  simpa using card_partition A (Finset.univ : Finset Goods)

/-- The same removed good must work for every prefix of the agent's ranking. -/
def RankEF1 (r : Goods ≃ Fin m) (A B : Finset Goods) : Prop :=
  B = ∅ ∨ ∃ g ∈ B, ∀ l ≤ m, ((B.erase g) ∩ rankPrefix r l).card ≤ (A ∩ rankPrefix r l).card

def PrefixDeficit (r : Goods ≃ Fin m) (A B : Finset Goods) : Prop :=
  ∀ l ≤ m, (B ∩ rankPrefix r l).card ≤ (A ∩ rankPrefix r l).card + 1

omit [Fintype Goods] in
theorem erase_inter_eq (A S : Finset Goods) (g : Goods) :
    A.erase g ∩ S = (A ∩ S).erase g := by
  ext x
  simp only [Finset.mem_inter, Finset.mem_erase]
  aesop

theorem prefix_witness_equivalence (r : Goods ≃ Fin m) (A B : Finset Goods) :
    RankEF1 r A B ↔ PrefixDeficit r A B := by
  constructor
  · intro h l hl
    rcases h with he | ⟨g, _, hw⟩
    · simp [he]
    have h' := hw l hl
    rw [erase_inter_eq] at h'
    by_cases hg : g ∈ B ∩ rankPrefix r l
    · have he := Finset.card_erase_add_one hg
      omega
    · rw [Finset.erase_eq_of_not_mem hg] at h'
      omega
  · intro h
    by_cases he : B = ∅
    · exact Or.inl he
    obtain ⟨g, hg, hmin⟩ := Finset.exists_min_image B (fun j => (r j).val)
      (Finset.nonempty_iff_ne_empty.mpr he)
    right
    refine ⟨g, hg, fun l hl => ?_⟩
    rw [erase_inter_eq]
    by_cases hs : (B ∩ rankPrefix r l).Nonempty
    · obtain ⟨b, hb⟩ := hs
      have hb' := Finset.mem_inter.mp hb
      have hgp : g ∈ rankPrefix r l :=
        (mem_prefix r l g).mpr ((hmin b hb'.1).trans_lt ((mem_prefix r l b).mp hb'.2))
      have hc := Finset.card_erase_add_one (Finset.mem_inter.mpr ⟨hg, hgp⟩)
      have hbound := h l hl
      omega
    · have hz := Finset.not_nonempty_iff_eq_empty.mp hs
      simp [hz]

def UpperIndependent (r : Goods ≃ Fin (2 * k)) (A : Finset Goods) : Prop :=
  ∀ t ≤ k, (A ∩ rankPrefix r (2 * t)).card ≤ t

def LowerQuotas (r : Goods ≃ Fin (2 * k)) (A : Finset Goods) : Prop :=
  ∀ t ≤ k, t ≤ (A ∩ rankPrefix r (2 * t)).card

def OrdinalFeasible (p q : Goods ≃ Fin (2 * k)) (A : Finset Goods) : Prop :=
  LowerQuotas p A ∧ UpperIndependent q A

theorem feasible_card_eq (p q : Goods ≃ Fin (2 * k)) {A : Finset Goods}
    (h : OrdinalFeasible p q A) : A.card = k := by
  have h₁ : k ≤ A.card := by simpa using h.1 k le_rfl
  have h₂ : A.card ≤ k := by simpa using h.2 k le_rfl
  exact le_antisymm h₂ h₁

theorem lower_quotas_iff_deficits (r : Goods ≃ Fin (2 * k)) (A : Finset Goods) :
    LowerQuotas r A ↔ PrefixDeficit r A (other A) := by
  constructor
  · intro h l hl
    have ht : l / 2 ≤ k := by omega
    have hcount := h (l / 2) ht
    have hp := prefix_mono r (show 2 * (l / 2) ≤ l by omega)
    have hc := Finset.card_le_card (Finset.inter_subset_inter_left (s := A) hp)
    have hsum := card_partition A (rankPrefix r l)
    rw [card_prefix r hl] at hsum
    exact (FairDivisionCore.prefix_deficit_iff_floor_half _ _).mpr
      (by rw [hsum]; exact hcount.trans hc)
  · intro h t ht
    have hl : 2 * t ≤ 2 * k := by omega
    have hsum := card_partition A (rankPrefix r (2 * t))
    rw [card_prefix r hl] at hsum
    have hd := h (2 * t) hl
    omega

theorem complementary_quotas (r : Goods ≃ Fin (2 * k)) (A : Finset Goods) :
    UpperIndependent r A ↔ LowerQuotas r (other A) := by
  constructor
  · intro h t ht
    have hu := h t ht
    have hs := card_partition A (rankPrefix r (2 * t))
    rw [card_prefix r (show 2 * t ≤ 2 * k by omega)] at hs
    omega
  · intro h t ht
    have hl := h t ht
    have hs := card_partition A (rankPrefix r (2 * t))
    rw [card_prefix r (show 2 * t ≤ 2 * k by omega)] at hs
    omega

theorem ordinal_feasibility_iff (p q : Goods ≃ Fin (2 * k)) (A : Finset Goods) :
    OrdinalFeasible p q A ↔ RankEF1 p A (other A) ∧ RankEF1 q (other A) A := by
  unfold OrdinalFeasible
  rw [complementary_quotas q A, lower_quotas_iff_deficits p A,
    lower_quotas_iff_deficits q (other A), other_other,
    ← prefix_witness_equivalence, ← prefix_witness_equivalence]

end MarketFairDivision
