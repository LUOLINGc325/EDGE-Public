import Std

/-!
# Two-agent, four-good insertion

The result mechanically encodes the small insertion lemma called Lemma B in
`common_dominant_theorem.txt`.  The existence content of these small completion
lemmas follows from Mahara, arXiv:2107.09901v2, Lemmas 8 and 16; the derivation,
including ties and zero values, is in RELATED_WORK.md.  No novelty
claim is made here.

The utility type is arbitrary.  An explicit total-preorder parameter supplies
the only order laws used in the proof.  In particular, the theorem is NOT
restricted to natural-number valuations.  No external EFX existence theorem
is added as an axiom or used in this file.
-/

namespace EFXResearch

universe u

/-- Explicit order hypotheses; instantiated by any linearly ordered utility type. -/
structure ValueOrder (Value : Type u) where
  le : Value → Value → Prop
  refl : ∀ x, le x x
  trans : ∀ {x y z}, le x y → le y z → le x z
  total : ∀ x y, le x y ∨ le y x

inductive Good where
  | a | b | c | z
  deriving DecidableEq, Repr

/-- All sixteen subsets of the four named goods, without a finite-set library. -/
structure Bundle where
  a : Bool
  b : Bool
  c : Bool
  z : Bool
  deriving DecidableEq, Repr

def member (S : Bundle) : Good → Bool
  | .a => S.a
  | .b => S.b
  | .c => S.c
  | .z => S.z

def erase (S : Bundle) : Good → Bundle
  | .a => { S with a := false }
  | .b => { S with b := false }
  | .c => { S with c := false }
  | .z => { S with z := false }

def Subset (S T : Bundle) : Prop :=
  ∀ g, member S g = true → member T g = true

def empty : Bundle := ⟨false, false, false, false⟩
def sa : Bundle := ⟨true,  false, false, false⟩
def sb : Bundle := ⟨false, true,  false, false⟩
def sc : Bundle := ⟨false, false, true,  false⟩
def sz : Bundle := ⟨false, false, false, true⟩
def ab : Bundle := ⟨true,  true,  false, false⟩
def ac : Bundle := ⟨true,  false, true,  false⟩
def az : Bundle := ⟨true,  false, false, true⟩
def bc : Bundle := ⟨false, true,  true,  false⟩
def bz : Bundle := ⟨false, true,  false, true⟩
def cz : Bundle := ⟨false, false, true,  true⟩
def bcz : Bundle := ⟨false, true, true, true⟩

def Monotone {Value : Type u} (O : ValueOrder Value)
    (v : Bundle → Value) : Prop :=
  ∀ S T, Subset S T → O.le (v S) (v T)

/-- Every good is allocated once: union is the full set and intersection is empty. -/
def Complete (P Q : Bundle) : Prop :=
  ∀ g, (member P g || member Q g) = true ∧
       (member P g && member Q g) = false

def NonemptyBundle (S : Bundle) : Prop := ∃ g, member S g = true

/-- Cross-agent EFX, checking every good in the other bundle, including zero marginals. -/
def CrossEFX {Value : Type u} (O : ValueOrder Value)
    (p q : Bundle → Value) (P Q : Bundle) : Prop :=
  (∀ g, member Q g = true → O.le (p (erase Q g)) (p P)) ∧
  (∀ g, member P g = true → O.le (q (erase P g)) (q Q))

/-- All four ordered-agent comparisons, including self comparisons. -/
def FullEFX {Value : Type u} (O : ValueOrder Value)
    (p q : Bundle → Value) (P Q : Bundle) : Prop :=
  (∀ g, member P g = true → O.le (p (erase P g)) (p P)) ∧
  (∀ g, member Q g = true → O.le (p (erase Q g)) (p P)) ∧
  (∀ g, member P g = true → O.le (q (erase P g)) (q Q)) ∧
  (∀ g, member Q g = true → O.le (q (erase Q g)) (q Q))

theorem empty_subset (S : Bundle) : Subset empty S := by
  intro g h
  cases g <;> cases h

theorem erase_subset (S : Bundle) (removed : Good) : Subset (erase S removed) S := by
  intro kept h
  cases removed <;> cases kept <;> simp_all [erase, member]

theorem fullEFX_of_cross {Value : Type u} (O : ValueOrder Value)
    (p q : Bundle → Value) (hp : Monotone O p) (hq : Monotone O q)
    (P Q : Bundle) (hcross : CrossEFX O p q P Q) : FullEFX O p q P Q := by
  refine ⟨?_, hcross.1, hcross.2, ?_⟩
  · intro g _
    exact hp _ _ (erase_subset P g)
  · intro g _
    exact hq _ _ (erase_subset Q g)

theorem subset_sb_bc : Subset sb bc := by
  intro g
  cases g <;> decide

theorem subset_sc_bc : Subset sc bc := by
  intro g
  cases g <;> decide

theorem subset_sa_ab : Subset sa ab := by
  intro g
  cases g <;> decide

theorem subset_sa_ac : Subset sa ac := by
  intro g
  cases g <;> decide

theorem subset_sa_az : Subset sa az := by
  intro g
  cases g <;> decide

theorem subset_bc_bcz : Subset bc bcz := by
  intro g
  cases g <;> decide

theorem subset_bz_bcz : Subset bz bcz := by
  intro g
  cases g <;> decide

theorem subset_cz_bcz : Subset cz bcz := by
  intro g
  cases g <;> decide

theorem complete_bc_az : Complete bc az := by
  intro g
  cases g <;> decide

theorem complete_bz_ac : Complete bz ac := by
  intro g
  cases g <;> decide

theorem complete_cz_ab : Complete cz ab := by
  intro g
  cases g <;> decide

theorem complete_sa_bcz : Complete sa bcz := by
  intro g
  cases g <;> decide

theorem complete_bcz_sa : Complete bcz sa := by
  intro g
  cases g <;> decide

/--
The two-agent four-good utility-preserving insertion lemma.

Initially p owns {b,c} and q owns {a}; the unallocated good is z.  The singleton
holder q weakly prefers a to each of b,c,z, and p values {b,c} at least as much
as z.  There is a complete EFX allocation retaining both old utility floors.

Only totality, reflexivity, transitivity and inclusion-monotonicity are used.
The implementation uses weak comparisons throughout; ties are not discarded.
-/
theorem insertionB_cross {Value : Type u} (O : ValueOrder Value)
    (p q : Bundle → Value)
    (hp : Monotone O p) (hq : Monotone O q)
    (hqb : O.le (q sb) (q sa))
    (hqc : O.le (q sc) (q sa))
    (hqz : O.le (q sz) (q sa))
    (hpz : O.le (p sz) (p bc)) :
    ∃ P Q, Complete P Q ∧ CrossEFX O p q P Q ∧
      O.le (p bc) (p P) ∧ O.le (q sa) (q Q) ∧
      NonemptyBundle P ∧ NonemptyBundle Q := by
  cases O.total (p sa) (p bc) with
  | inl ha_le_bc =>
    have hqa_az : O.le (q sa) (q az) := hq _ _ subset_sa_az
    refine ⟨bc, az, complete_bc_az, ?_, O.refl _, hqa_az,
      ⟨Good.b, rfl⟩, ⟨Good.a, rfl⟩⟩
    constructor
    · intro g hg
      cases g with
      | a => exact hpz
      | b => cases hg
      | c => cases hg
      | z => exact ha_le_bc
    · intro g hg
      cases g with
      | a => cases hg
      | b => exact O.trans hqc hqa_az
      | c => exact O.trans hqb hqa_az
      | z => cases hg
  | inr hbc_le_a =>
    cases O.total (p sa) (p bz) with
    | inl ha_le_bz =>
      have hbc_le_bz : O.le (p bc) (p bz) := O.trans hbc_le_a ha_le_bz
      have hqa_ac : O.le (q sa) (q ac) := hq _ _ subset_sa_ac
      refine ⟨bz, ac, complete_bz_ac, ?_, hbc_le_bz, hqa_ac,
        ⟨Good.b, rfl⟩, ⟨Good.a, rfl⟩⟩
      constructor
      · intro g hg
        cases g with
        | a => exact O.trans (hp _ _ subset_sc_bc) hbc_le_bz
        | b => cases hg
        | c => exact ha_le_bz
        | z => cases hg
      · intro g hg
        cases g with
        | a => cases hg
        | b => exact O.trans hqz hqa_ac
        | c => cases hg
        | z => exact O.trans hqb hqa_ac
    | inr hbz_le_a =>
      cases O.total (p sa) (p cz) with
      | inl ha_le_cz =>
        have hbc_le_cz : O.le (p bc) (p cz) := O.trans hbc_le_a ha_le_cz
        have hqa_ab : O.le (q sa) (q ab) := hq _ _ subset_sa_ab
        refine ⟨cz, ab, complete_cz_ab, ?_, hbc_le_cz, hqa_ab,
          ⟨Good.c, rfl⟩, ⟨Good.a, rfl⟩⟩
        constructor
        · intro g hg
          cases g with
          | a => exact O.trans (hp _ _ subset_sb_bc) hbc_le_cz
          | b => exact ha_le_cz
          | c => cases hg
          | z => cases hg
        · intro g hg
          cases g with
          | a => cases hg
          | b => cases hg
          | c => exact O.trans hqz hqa_ab
          | z => exact O.trans hqc hqa_ab
      | inr hcz_le_a =>
        cases O.total (q sa) (q bcz) with
        | inl hqa_le_bcz =>
          refine ⟨sa, bcz, complete_sa_bcz, ?_, hbc_le_a, hqa_le_bcz,
            ⟨Good.a, rfl⟩, ⟨Good.b, rfl⟩⟩
          constructor
          · intro g hg
            cases g with
            | a => cases hg
            | b => exact hcz_le_a
            | c => exact hbz_le_a
            | z => exact hbc_le_a
          · intro g hg
            cases g with
            | a => exact hq _ _ (empty_subset bcz)
            | b => cases hg
            | c => cases hg
            | z => cases hg
        | inr hqbcz_le_a =>
          refine ⟨bcz, sa, complete_bcz_sa, ?_, hp _ _ subset_bc_bcz, O.refl _,
            ⟨Good.b, rfl⟩, ⟨Good.a, rfl⟩⟩
          constructor
          · intro g hg
            cases g with
            | a => exact hp _ _ (empty_subset bcz)
            | b => cases hg
            | c => cases hg
            | z => cases hg
          · intro g hg
            cases g with
            | a => cases hg
            | b => exact O.trans (hq _ _ subset_cz_bcz) hqbcz_le_a
            | c => exact O.trans (hq _ _ subset_bz_bcz) hqbcz_le_a
            | z => exact O.trans (hq _ _ subset_bc_bcz) hqbcz_le_a

/-- The result with the canonical all-ordered-pairs EFX comparisons restored. -/
theorem insertionB {Value : Type u} (O : ValueOrder Value)
    (p q : Bundle → Value)
    (hp : Monotone O p) (hq : Monotone O q)
    (hqb : O.le (q sb) (q sa))
    (hqc : O.le (q sc) (q sa))
    (hqz : O.le (q sz) (q sa))
    (hpz : O.le (p sz) (p bc)) :
    ∃ P Q, Complete P Q ∧ FullEFX O p q P Q ∧
      O.le (p bc) (p P) ∧ O.le (q sa) (q Q) ∧
      NonemptyBundle P ∧ NonemptyBundle Q := by
  cases insertionB_cross O p q hp hq hqb hqc hqz hpz with
  | intro P hP =>
    cases hP with
    | intro Q h =>
      exact ⟨P, Q, h.1, fullEFX_of_cross O p q hp hq P Q h.2.1,
        h.2.2.1, h.2.2.2.1, h.2.2.2.2⟩

end EFXResearch

#print axioms EFXResearch.insertionB
