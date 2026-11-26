import EFX.InsertionAC
import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Union

/-! The local completions transported to four distinct labels in a finite set. -/

namespace EFXResearch

universe u v
variable {Value : Type u} {G : Type v} [DecidableEq G]

def FiniteMonotone (O : ValueOrder Value) (value : Finset G → Value) : Prop :=
  ∀ ⦃S T⦄, S ⊆ T → O.le (value S) (value T)

def EFXAgainst (O : ValueOrder Value) (value : Finset G → Value)
    (own other : Finset G) : Prop :=
  ∀ ⦃g⦄, g ∈ other → O.le (value (other.erase g)) (value own)

/-- A utility-preserving EFX partition of the local set to be repaired. -/
structure Completion (O : ValueOrder Value) (p q : Finset G → Value)
    (goods initialP initialQ : Finset G) where
  left : Finset G
  right : Finset G
  disjoint : Disjoint left right
  cover : left ∪ right = goods
  left_ne : left.Nonempty
  right_ne : right.Nonempty
  left_efx : EFXAgainst O p left right
  right_efx : EFXAgainst O q right left
  left_floor : O.le (p initialP) (p left)
  right_floor : O.le (q initialQ) (q right)

private def labels : Finset Good := {.a, .b, .c, .z}

private theorem mem_labels (g : Good) : g ∈ labels := by
  cases g <;> simp [labels]

private def allGoods : Bundle := ⟨true, true, true, true⟩

private def imageBundle (label : Good → G) (S : Bundle) : Finset G :=
  (labels.filter (fun g => member S g = true)).image label

private theorem mem_imageBundle (label : Good → G) (S : Bundle) (x : G) :
    x ∈ imageBundle label S ↔ ∃ g, member S g = true ∧ label g = x := by
  simp only [imageBundle, Finset.mem_image, Finset.mem_filter, mem_labels, true_and]

private theorem image_mono (label : Good → G) {S T : Bundle} (h : Subset S T) :
    imageBundle label S ⊆ imageBundle label T := by
  intro x hx
  obtain ⟨g, hg, rfl⟩ := (mem_imageBundle _ _ _).mp hx
  exact (mem_imageBundle _ _ _).mpr ⟨g, h g hg, rfl⟩

private theorem image_erase (label : Good → G) (hinj : Function.Injective label)
    (S : Bundle) (g : Good) :
    imageBundle label (erase S g) = (imageBundle label S).erase (label g) := by
  have membership (k : Good) :
      member (erase S g) k = true ↔ k ≠ g ∧ member S k = true := by
    cases g <;> cases k <;> simp [erase, member]
  ext x
  simp only [mem_imageBundle, Finset.mem_erase, membership]
  constructor
  · rintro ⟨k, ⟨hne, hmem⟩, rfl⟩
    exact ⟨fun h => hne (hinj h), k, hmem, rfl⟩
  · rintro ⟨hne, k, hmem, rfl⟩
    exact ⟨k, ⟨fun h => hne (congrArg label h), hmem⟩, rfl⟩

private theorem image_sa (label : Good → G) : imageBundle label sa = {label .a} := by
  simp [imageBundle, labels, Finset.filter_insert, Finset.filter_singleton, sa, member]

private theorem image_sb (label : Good → G) : imageBundle label sb = {label .b} := by
  simp [imageBundle, labels, Finset.filter_insert, Finset.filter_singleton, sb, member]

private theorem image_sc (label : Good → G) : imageBundle label sc = {label .c} := by
  simp [imageBundle, labels, Finset.filter_insert, Finset.filter_singleton, sc, member]

private theorem image_sz (label : Good → G) : imageBundle label sz = {label .z} := by
  simp [imageBundle, labels, Finset.filter_insert, Finset.filter_singleton, sz, member]

private theorem image_bc (label : Good → G) :
    imageBundle label bc = {label .b, label .c} := by
  simp [imageBundle, labels, Finset.filter_insert, Finset.filter_singleton, bc, member]

private theorem image_abc (label : Good → G) :
    imageBundle label abc = {label .a, label .b, label .c} := by
  simp [imageBundle, labels, Finset.filter_insert, Finset.filter_singleton, abc, member]

private theorem image_all (label : Good → G) :
    imageBundle label allGoods = {label .a, label .b, label .c, label .z} := by
  simp [imageBundle, labels, Finset.filter_insert, Finset.filter_singleton, allGoods, member]

private theorem complete_on_all {P Q : Bundle} (h : Complete P Q) :
    CompleteOn allGoods P Q := by
  intro g
  cases g <;> exact h _

private def liftCompletion (O : ValueOrder Value) (p q : Finset G → Value)
    (label : Good → G) (hinj : Function.Injective label)
    (S initialP initialQ P Q : Bundle)
    (hcover : CompleteOn S P Q)
    (hfair : FullEFX O (fun X => p (imageBundle label X))
      (fun X => q (imageBundle label X)) P Q)
    (pfloor : O.le (p (imageBundle label initialP)) (p (imageBundle label P)))
    (qfloor : O.le (q (imageBundle label initialQ)) (q (imageBundle label Q)))
    (pne : NonemptyBundle P) (qne : NonemptyBundle Q) :
    Completion O p q (imageBundle label S)
      (imageBundle label initialP) (imageBundle label initialQ) := by
  refine ⟨imageBundle label P, imageBundle label Q, ?_, ?_, ?_, ?_, ?_, ?_, pfloor, qfloor⟩
  · rw [Finset.disjoint_left]
    intro x hxP hxQ
    obtain ⟨g, hgP, rfl⟩ := (mem_imageBundle _ _ _).mp hxP
    obtain ⟨k, hkQ, hkg⟩ := (mem_imageBundle _ _ _).mp hxQ
    obtain rfl := hinj hkg
    have h := (hcover k).2
    simp [hgP, hkQ] at h
  · ext x
    simp only [Finset.mem_union, mem_imageBundle]
    constructor
    · rintro (⟨g, hg, rfl⟩ | ⟨g, hg, rfl⟩)
      · exact ⟨g, by simpa [hg] using (hcover g).1.symm, rfl⟩
      · exact ⟨g, by simpa [hg] using (hcover g).1.symm, rfl⟩
    · rintro ⟨g, hg, rfl⟩
      have h : (member P g || member Q g) = true := (hcover g).1.trans hg
      rcases Bool.or_eq_true_iff.mp h with hp | hq
      · exact Or.inl ⟨g, hp, rfl⟩
      · exact Or.inr ⟨g, hq, rfl⟩
  · obtain ⟨g, hg⟩ := pne
    exact ⟨label g, (mem_imageBundle _ _ _).mpr ⟨g, hg, rfl⟩⟩
  · obtain ⟨g, hg⟩ := qne
    exact ⟨label g, (mem_imageBundle _ _ _).mpr ⟨g, hg, rfl⟩⟩
  · intro x hx
    obtain ⟨g, hg, rfl⟩ := (mem_imageBundle _ _ _).mp hx
    rw [← image_erase label hinj]
    exact hfair.2.1 g hg
  · intro x hx
    obtain ⟨g, hg, rfl⟩ := (mem_imageBundle _ _ _).mp hx
    rw [← image_erase label hinj]
    exact hfair.2.2.1 g hg

/-- Lemma A on a finite set. The fourth label is unused in the resulting partition. -/
theorem finiteInsertionA (O : ValueOrder Value) (p q : Finset G → Value)
    (hp : FiniteMonotone O p) (hq : FiniteMonotone O q)
    (label : Good → G) (hinj : Function.Injective label)
    (hpc : O.le (p {label .c}) (p {label .a}))
    (hqc : O.le (q {label .c}) (q {label .b})) :
    Nonempty (Completion O p q {label .a, label .b, label .c} {label .a} {label .b}) := by
  obtain ⟨P, Q, hc, hf, pf, qf, pn, qn⟩ :=
    insertionA O (fun S => p (imageBundle label S)) (fun S => q (imageBundle label S))
      (fun _ _ h => hp (image_mono label h)) (fun _ _ h => hq (image_mono label h))
      (by simpa only [image_sc, image_sa] using hpc)
      (by simpa only [image_sc, image_sb] using hqc)
  exact ⟨by simpa only [image_abc, image_sa, image_sb] using
    liftCompletion O p q label hinj abc sa sb P Q hc hf pf qf pn qn⟩

theorem finiteInsertionB (O : ValueOrder Value) (p q : Finset G → Value)
    (hp : FiniteMonotone O p) (hq : FiniteMonotone O q)
    (label : Good → G) (hinj : Function.Injective label)
    (hqb : O.le (q {label .b}) (q {label .a}))
    (hqc : O.le (q {label .c}) (q {label .a}))
    (hqz : O.le (q {label .z}) (q {label .a}))
    (hpz : O.le (p {label .z}) (p {label .b, label .c})) :
    Nonempty (Completion O p q {label .a, label .b, label .c, label .z}
      {label .b, label .c} {label .a}) := by
  obtain ⟨P, Q, hc, hf, pf, qf, pn, qn⟩ :=
    insertionB O (fun S => p (imageBundle label S)) (fun S => q (imageBundle label S))
      (fun _ _ h => hp (image_mono label h)) (fun _ _ h => hq (image_mono label h))
      (by simpa only [image_sb, image_sa] using hqb)
      (by simpa only [image_sc, image_sa] using hqc)
      (by simpa only [image_sz, image_sa] using hqz)
      (by simpa only [image_sz, image_bc] using hpz)
  exact ⟨by simpa only [image_all, image_bc, image_sa] using
    liftCompletion O p q label hinj allGoods bc sa P Q (complete_on_all hc) hf pf qf pn qn⟩

theorem finiteInsertionC (O : ValueOrder Value) (p q : Finset G → Value)
    (hp : FiniteMonotone O p) (hq : FiniteMonotone O q)
    (label : Good → G) (hinj : Function.Injective label)
    (hpc : O.le (p {label .c}) (p {label .a}))
    (hqc : O.le (q {label .c}) (q {label .b}))
    (hpz : O.le (p {label .z}) (p {label .a}))
    (hqz : O.le (q {label .z}) (q {label .b})) :
    Nonempty (Completion O p q {label .a, label .b, label .c, label .z}
      {label .a} {label .b}) := by
  obtain ⟨P, Q, hc, hf, pf, qf, pn, qn⟩ :=
    insertionC O (fun S => p (imageBundle label S)) (fun S => q (imageBundle label S))
      (fun _ _ h => hp (image_mono label h)) (fun _ _ h => hq (image_mono label h))
      (by simpa only [image_sc, image_sa] using hpc)
      (by simpa only [image_sc, image_sb] using hqc)
      (by simpa only [image_sz, image_sa] using hpz)
      (by simpa only [image_sz, image_sb] using hqz)
  exact ⟨by simpa only [image_all, image_sa, image_sb] using
    liftCompletion O p q label hinj allGoods sa sb P Q (complete_on_all hc) hf pf qf pn qn⟩

end EFXResearch
