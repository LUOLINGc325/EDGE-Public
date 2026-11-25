import ProjectedMatching
import Mathlib.Data.Fintype.CardEmbedding
import Mathlib.Data.Fintype.EquivFin
import Mathlib.Data.Fintype.Prod

namespace TwoColorNullity

variable {Item Label : Type*} [DecidableEq Item] {r : ℕ}

/-- The two items at a fixed index of an oriented matching. -/
def indexedPair (embed : (Fin r × Bool) ↪ Item) (k : Fin r) : Finset Item :=
  {embed (k, false), embed (k, true)}

theorem mem_indexedPair {embed : (Fin r × Bool) ↪ Item} {k : Fin r} {g : Item} :
    g ∈ indexedPair embed k ↔ ∃ bit : Bool, embed (k, bit) = g := by
  constructor
  · intro hg
    rcases Finset.mem_insert.mp hg with he | he
    · exact ⟨false, he.symm⟩
    · exact ⟨true, (Finset.mem_singleton.mp he).symm⟩
  · rintro ⟨bit, rfl⟩
    cases bit <;> simp [indexedPair]

theorem indexedPair_card (embed : (Fin r × Bool) ↪ Item) (k : Fin r) :
    (indexedPair embed k).card = 2 := by
  have hne : embed (k, false) ≠ embed (k, true) := fun he =>
    Bool.false_ne_true (congrArg Prod.snd (embed.injective he))
  simp [indexedPair, hne]

theorem indexedPair_disjoint (embed : (Fin r × Bool) ↪ Item) {i j : Fin r} (hne : i ≠ j) :
    Disjoint (indexedPair embed i) (indexedPair embed j) := by
  refine Finset.disjoint_left.mpr fun g hi hj => ?_
  obtain ⟨a, hga⟩ := mem_indexedPair.mp hi
  obtain ⟨b, hgb⟩ := mem_indexedPair.mp hj
  exact hne (congrArg Prod.fst (embed.injective (hga.trans hgb.symm)))

theorem indexedPair_injective (embed : (Fin r × Bool) ↪ Item) : Function.Injective (indexedPair embed) := by
  intro i j he
  by_contra hne
  have hi : embed (i, false) ∈ indexedPair embed i := mem_indexedPair.mpr ⟨false, rfl⟩
  exact Finset.disjoint_left.mp (indexedPair_disjoint embed hne) hi (he ▸ hi)

def unorderedPairs (embed : (Fin r × Bool) ↪ Item) : Finset (Finset Item) :=
  Finset.univ.image (indexedPair embed)

theorem unorderedPairs_card (embed : (Fin r × Bool) ↪ Item) : (unorderedPairs embed).card = r := by
  unfold unorderedPairs
  rw [Finset.card_image_of_injective _ (indexedPair_injective embed)]
  simp

variable [Fintype Item]

theorem unorderedPairs_packing (label : Item → Label) (embed : (Fin r × Bool) ↪ Item)
    (hlabel : ∀ k, label (embed (k, false)) = label (embed (k, true))) :
    PairPacking label Finset.univ (unorderedPairs embed) := by
  refine ⟨?_, fun p _ => p.subset_univ, ?_, ?_⟩
  · intro p hp
    obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp hp
    exact indexedPair_card embed i
  · intro p hp a ha b hb
    obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp hp
    obtain ⟨x, rfl⟩ := mem_indexedPair.mp ha
    obtain ⟨y, rfl⟩ := mem_indexedPair.mp hb
    cases x <;> cases y
    · rfl
    · exact hlabel i
    · exact (hlabel i).symm
    · rfl
  · intro p hp q hq hne
    obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp hp
    obtain ⟨j, _, rfl⟩ := Finset.mem_image.mp hq
    exact indexedPair_disjoint embed (fun he => hne (congrArg (indexedPair embed) he))

/-- Label and orient each pair in a homogeneous packing. -/
theorem PairPacking.exists_indexing {pairs : Finset (Finset Item)} {label : Item → Label}
    (packing : PairPacking label Finset.univ pairs) (hcount : pairs.card = r) :
    ∃ embed : (Fin r × Bool) ↪ Item, unorderedPairs embed = pairs ∧
      ∀ k, label (embed (k, false)) = label (embed (k, true)) := by
  classical
  let index : Fin r ≃ ↥pairs := (Finset.equivFinOfCardEq hcount).symm
  let orient (pair : ↥pairs) : Bool ≃ ↥pair.val :=
    Fintype.equivOfCardEq (by rw [Fintype.card_bool, Fintype.card_coe, packing.two _ pair.property])
  let embed : (Fin r × Bool) ↪ Item := {
    toFun := fun q => (orient (index q.1) q.2).val
    inj' := by
      intro a b he
      change (orient (index a.1) a.2).val = (orient (index b.1) b.2).val at he
      have hmemA : (orient (index a.1) a.2).val ∈ (index a.1).val := (orient (index a.1) a.2).property
      have hmemB : (orient (index a.1) a.2).val ∈ (index b.1).val := by
        rw [he]
        exact (orient (index b.1) b.2).property
      have hpair : index a.1 = index b.1 := by
        apply Subtype.ext
        by_contra hne
        exact Finset.disjoint_left.mp (packing.disjoint _ (index a.1).property _ (index b.1).property hne)
          hmemA hmemB
      have hfst : a.1 = b.1 := index.injective hpair
      refine Prod.ext hfst ?_
      apply (orient (index a.1)).injective
      apply Subtype.ext
      exact he.trans (by rw [hfst])
  }
  have hpairs (i : Fin r) : indexedPair embed i = (index i).val := by
    apply Finset.eq_of_subset_of_card_le
    · intro item hitem
      obtain ⟨bit, rfl⟩ := mem_indexedPair.mp hitem
      exact (orient (index i) bit).property
    · rw [indexedPair_card, packing.two _ (index i).property]
  refine ⟨embed, ?_, ?_⟩
  · ext pair
    constructor
    · intro h
      obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp h
      rw [hpairs]
      exact (index i).property
    · intro h
      let p : ↥pairs := ⟨pair, h⟩
      refine Finset.mem_image.mpr ⟨index.symm p, Finset.mem_univ _, ?_⟩
      simp [hpairs, p]
  · intro k
    exact packing.homogeneous _ (index k).property _ (orient (index k) false).property
      _ (orient (index k) true).property

theorem indexed_matchings_count (items r : ℕ) :
    Fintype.card ((Fin r × Bool) ↪ Fin items) = items.descFactorial (2 * r) := by
  rw [Fintype.card_embedding_eq, Fintype.card_prod, Fintype.card_bool, Fintype.card_fin, Fintype.card_fin,
    Nat.mul_comm]

end TwoColorNullity
