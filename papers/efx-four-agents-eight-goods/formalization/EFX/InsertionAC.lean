import EFX.InsertionB

/-!
# Two-singleton completion

Lemma A partitions the three goods a, b, c, leaving z unused.
Lemma C uses A on those three goods and then applies Lemma B with z
as the last good. Both lemmas preserve the original utility floors.
-/

namespace EFXResearch

universe u

def abc : Bundle := ⟨true, true, true, false⟩

/-- The two bundles partition the specified set of goods. -/
def CompleteOn (S P Q : Bundle) : Prop :=
  ∀ g, (member P g || member Q g) = member S g ∧
    (member P g && member Q g) = false

private theorem insertionA_layout {Value : Type u} (O : ValueOrder Value)
    (p q : Bundle → Value)
    (hp : Monotone O p) (hq : Monotone O q)
    (hpc : O.le (p sc) (p sa)) (hqc : O.le (q sc) (q sb)) :
    ∃ P Q, CompleteOn abc P Q ∧ CrossEFX O p q P Q ∧
      O.le (p sa) (p P) ∧ O.le (q sb) (q Q) ∧
      NonemptyBundle P ∧ NonemptyBundle Q ∧
      (P = sa ∧ Q = bc ∨ P = ac ∧ Q = sb ∨ P = bc ∧ Q = sa) := by
  rcases O.total (p sb) (p sa) with hpa | hpb
  · have hqfloor := hq _ _ subset_sb_bc
    refine ⟨sa, bc, ?_, ⟨?_, ?_⟩, O.refl _, hqfloor, ⟨.a, rfl⟩,
      ⟨.b, rfl⟩, Or.inl ⟨rfl, rfl⟩⟩
    · intro g
      cases g <;> decide
    · intro g hg
      cases g with
      | a => cases hg
      | b => exact hpc
      | c => exact hpa
      | z => cases hg
    · intro g hg
      cases g with
      | a => exact hq _ _ (empty_subset bc)
      | b => cases hg
      | c => cases hg
      | z => cases hg
  · rcases O.total (q sa) (q sb) with hqb | hqa
    · have hpfloor := hp _ _ subset_sa_ac
      refine ⟨ac, sb, ?_, ⟨?_, ?_⟩, hpfloor, O.refl _, ⟨.a, rfl⟩,
        ⟨.b, rfl⟩, Or.inr (Or.inl ⟨rfl, rfl⟩)⟩
      · intro g
        cases g <;> decide
      · intro g hg
        cases g with
        | a => cases hg
        | b => exact hp _ _ (empty_subset ac)
        | c => cases hg
        | z => cases hg
      · intro g hg
        cases g with
        | a => exact hqc
        | b => cases hg
        | c => exact hqb
        | z => cases hg
    · refine ⟨bc, sa, ?_, ⟨?_, ?_⟩, O.trans hpb (hp _ _ subset_sb_bc), hqa,
        ⟨.b, rfl⟩, ⟨.a, rfl⟩, Or.inr (Or.inr ⟨rfl, rfl⟩)⟩
      · intro g
        cases g <;> decide
      · intro g hg
        cases g with
        | a => exact hp _ _ (empty_subset bc)
        | b => cases hg
        | c => cases hg
        | z => cases hg
      · intro g hg
        cases g with
        | a => cases hg
        | b => exact O.trans hqc hqa
        | c => exact hqa
        | z => cases hg

/-- Lemma A, with a and b initially assigned and c added. -/
theorem insertionA {Value : Type u} (O : ValueOrder Value)
    (p q : Bundle → Value)
    (hp : Monotone O p) (hq : Monotone O q)
    (hpc : O.le (p sc) (p sa)) (hqc : O.le (q sc) (q sb)) :
    ∃ P Q, CompleteOn abc P Q ∧ FullEFX O p q P Q ∧
      O.le (p sa) (p P) ∧ O.le (q sb) (q Q) ∧
      NonemptyBundle P ∧ NonemptyBundle Q := by
  obtain ⟨P, Q, partition, hcross, pfloor, qfloor, pne, qne, _⟩ :=
    insertionA_layout O p q hp hq hpc hqc
  exact ⟨P, Q, partition, fullEFX_of_cross O p q hp hq P Q hcross,
    pfloor, qfloor, pne, qne⟩

private def swapGood : Good → Good
  | .a => .b
  | .b => .a
  | .c => .c
  | .z => .z

private def swapBundle (S : Bundle) : Bundle :=
  ⟨S.b, S.a, S.c, S.z⟩

private theorem member_swap (S : Bundle) (g : Good) :
    member (swapBundle S) g = member S (swapGood g) := by
  cases g <;> rfl

private theorem erase_swap (S : Bundle) (g : Good) :
    erase (swapBundle S) g = swapBundle (erase S (swapGood g)) := by
  cases g <;> rfl

private theorem swap_involutive (g : Good) : swapGood (swapGood g) = g := by
  cases g <;> rfl

private theorem mono_swap {Value : Type u} (O : ValueOrder Value)
    (v : Bundle → Value) (hv : Monotone O v) :
    Monotone O (fun S => v (swapBundle S)) := by
  intro S T h
  apply hv
  intro g hg
  simpa only [member_swap] using h (swapGood g) (by simpa only [member_swap] using hg)

private theorem complete_swap (P Q : Bundle) (h : Complete P Q) :
    Complete (swapBundle P) (swapBundle Q) := by
  intro g
  simpa only [member_swap] using h (swapGood g)

private theorem nonempty_swap (P : Bundle) (h : NonemptyBundle P) :
    NonemptyBundle (swapBundle P) := by
  obtain ⟨g, hg⟩ := h
  exact ⟨swapGood g, by simpa only [member_swap, swap_involutive] using hg⟩

private theorem cross_swap {Value : Type u} (O : ValueOrder Value)
    (p q : Bundle → Value) (P Q : Bundle)
    (h : CrossEFX O (fun S => p (swapBundle S)) (fun S => q (swapBundle S)) P Q) :
    CrossEFX O p q (swapBundle P) (swapBundle Q) := by
  constructor
  · intro g hg
    rw [erase_swap]
    exact h.1 (swapGood g) (by simpa only [member_swap] using hg)
  · intro g hg
    rw [erase_swap]
    exact h.2 (swapGood g) (by simpa only [member_swap] using hg)

/-- Lemma C, with a and b initially assigned and c and z added. -/
theorem insertionC {Value : Type u} (O : ValueOrder Value)
    (p q : Bundle → Value)
    (hp : Monotone O p) (hq : Monotone O q)
    (hpc : O.le (p sc) (p sa)) (hqc : O.le (q sc) (q sb))
    (hpz : O.le (p sz) (p sa)) (hqz : O.le (q sz) (q sb)) :
    ∃ P Q, Complete P Q ∧ FullEFX O p q P Q ∧
      O.le (p sa) (p P) ∧ O.le (q sb) (q Q) ∧
      NonemptyBundle P ∧ NonemptyBundle Q := by
  obtain ⟨P, Q, _, interim, pfloor, qfloor, _, _, layouts⟩ :=
    insertionA_layout O p q hp hq hpc hqc
  rcases layouts with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · obtain ⟨Q, P, partition, hcross, qnew, pnew, qne, pne⟩ :=
      insertionB_cross O q p hq hp (interim.1 .c rfl) (interim.1 .b rfl)
        hpz (O.trans hqz qfloor)
    refine ⟨P, Q, ?_, fullEFX_of_cross O p q hp hq P Q ⟨hcross.2, hcross.1⟩,
      pnew, O.trans qfloor qnew, pne, qne⟩
    intro g
    simpa only [Bool.or_comm, Bool.and_comm] using partition g
  · obtain ⟨P, Q, partition, hcross, pnew, qnew, pne, qne⟩ :=
      insertionB_cross O (fun S => p (swapBundle S)) (fun S => q (swapBundle S))
        (mono_swap O p hp) (mono_swap O q hq) (interim.2 .c rfl)
        (interim.2 .a rfl) hqz (O.trans hpz pfloor)
    exact ⟨swapBundle P, swapBundle Q, complete_swap P Q partition,
      fullEFX_of_cross O p q hp hq _ _ (cross_swap O p q P Q hcross),
      O.trans pfloor pnew, qnew, nonempty_swap P pne, nonempty_swap Q qne⟩
  · obtain ⟨P, Q, partition, hcross, pnew, qnew, pne, qne⟩ :=
      insertionB_cross O p q hp hq (interim.2 .c rfl) (interim.2 .b rfl)
        (O.trans hqz qfloor) (O.trans hpz pfloor)
    exact ⟨P, Q, partition, fullEFX_of_cross O p q hp hq P Q hcross,
      O.trans pfloor pnew, O.trans qfloor qnew, pne, qne⟩

end EFXResearch

#print axioms EFXResearch.insertionA
#print axioms EFXResearch.insertionC
