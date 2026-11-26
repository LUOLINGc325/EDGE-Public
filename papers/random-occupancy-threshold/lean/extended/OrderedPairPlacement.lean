import OddRepresentatives
import Mathlib.Data.Finset.Sort

namespace TwoColorNullity.Occupancy

private theorem chore_pairs_containing_singleton {Item Label : Type*} [DecidableEq Item]
    {bins : Item → Label} {all : Finset Item} {pairs : Finset (Finset Item)}
    (packing : PairPacking bins all pairs) {item : Item} {pair : Finset Item}
    (hp : pair ∈ pairs) (hg : item ∈ pair) :
    (pairs.filter fun p => item ∈ p) = {pair} := by
  ext other
  rw [Finset.mem_filter, Finset.mem_singleton]
  refine ⟨fun ⟨hq, hitem⟩ => ?_, ?_⟩
  · by_contra hne
    exact Finset.disjoint_left.mp (packing.disjoint _ hq _ hp hne) hitem hg
  · rintro rfl
    exact ⟨hp, hg⟩

private def chorePairValue {Item : Type*} [DecidableEq Item] (pairs : Finset (Finset Item)) (item : Item) :
    Finset Item :=
  (pairs.filter fun p => item ∈ p).biUnion id

private theorem chorePairValue_eq {Item Label : Type*} [DecidableEq Item]
    {bins : Item → Label} {all : Finset Item} {pairs : Finset (Finset Item)}
    (packing : PairPacking bins all pairs) {item : Item} {pair : Finset Item}
    (hp : pair ∈ pairs) (hg : item ∈ pair) : chorePairValue pairs item = pair := by
  unfold chorePairValue
  rw [chore_pairs_containing_singleton packing hp hg]
  simp

/-- Recover the unique pair containing a paired chore by scanning the chosen pairs. -/
def chorePair {Item Label : Type*} [DecidableEq Item]
    {bins : Item → Label} {all : Finset Item} {pairs : Finset (Finset Item)}
    (packing : PairPacking bins all pairs) (item : Item) (h : item ∈ usedItems pairs) : ↥pairs :=
  ⟨chorePairValue pairs item, by
    obtain ⟨p, hp, hg⟩ := Finset.mem_biUnion.mp h
    rwa [chorePairValue_eq packing hp hg]⟩

theorem chorePair_eq {Item Label : Type*} [DecidableEq Item]
    {bins : Item → Label} {all : Finset Item} {pairs : Finset (Finset Item)}
    (packing : PairPacking bins all pairs) {item : Item} (h : item ∈ usedItems pairs)
    (p : ↥pairs) (hg : item ∈ p.val) : chorePair packing item h = p :=
  Subtype.ext (chorePairValue_eq packing p.property hg)

theorem chorePair_contains {Item Label : Type*} [DecidableEq Item]
    {bins : Item → Label} {all : Finset Item} {pairs : Finset (Finset Item)}
    (packing : PairPacking bins all pairs) {item : Item} (h : item ∈ usedItems pairs) :
    item ∈ (chorePair packing item h).val := by
  obtain ⟨p, hp, hg⟩ := Finset.mem_biUnion.mp h
  rwa [chorePair_eq packing h ⟨p, hp⟩ hg]

private def pairKey {Item Label : Type*} [LinearOrder Item] {bins : Item → Label} {all : Finset Item}
    {pairs : Finset (Finset Item)} (packing : PairPacking bins all pairs) (p : ↥pairs) : Item :=
  p.val.min' (Finset.card_pos.mp (by rw [packing.two p.val p.property]; decide))

private theorem pairKey_mem {Item Label : Type*} [LinearOrder Item] {bins : Item → Label} {all : Finset Item}
    {pairs : Finset (Finset Item)} (packing : PairPacking bins all pairs) (p : ↥pairs) :
    pairKey packing p ∈ p.val := Finset.min'_mem _ _

private theorem pairKey_injective {Item Label : Type*} [LinearOrder Item] {bins : Item → Label} {all : Finset Item}
    {pairs : Finset (Finset Item)} (packing : PairPacking bins all pairs) :
    Function.Injective (pairKey packing) := by
  intro p q he
  apply Subtype.ext
  by_contra hn
  exact Finset.disjoint_left.mp (packing.disjoint p.val p.property q.val q.property hn)
    (pairKey_mem packing p) (he.symm ▸ pairKey_mem packing q)

private def pairKeys {Item Label : Type*} [LinearOrder Item] {bins : Item → Label} {all : Finset Item}
    {pairs : Finset (Finset Item)} (packing : PairPacking bins all pairs) : Finset Item :=
  Finset.univ.image (pairKey packing)

private theorem pairKeys_card {Item Label : Type*} [LinearOrder Item] {bins : Item → Label} {all : Finset Item}
    {pairs : Finset (Finset Item)} (packing : PairPacking bins all pairs) :
    (pairKeys packing).card = pairs.card := by
  unfold pairKeys
  rw [Finset.card_image_of_injective _ (pairKey_injective packing), Finset.card_univ, Fintype.card_coe]

/-- Match pairs ordered by their smallest chore with the available owners in order. -/
def orderedPairOwner {Item Label Owner : Type*} [LinearOrder Item] [LinearOrder Owner]
    {bins : Item → Label} {all : Finset Item} {pairs : Finset (Finset Item)}
    (packing : PairPacking bins all pairs) (outside : Finset Owner)
    (hcount : outside.card = pairs.card) (p : ↥pairs) : ↥outside :=
  let index := ((pairKeys packing).orderIsoOfFin (pairKeys_card packing)).symm
    ⟨pairKey packing p, Finset.mem_image.mpr ⟨p, Finset.mem_univ _, rfl⟩⟩
  outside.orderIsoOfFin hcount index

theorem orderedPairOwner_bijective {Item Label Owner : Type*} [LinearOrder Item] [LinearOrder Owner]
    {bins : Item → Label} {all : Finset Item} {pairs : Finset (Finset Item)}
    (packing : PairPacking bins all pairs) (outside : Finset Owner)
    (hcount : outside.card = pairs.card) : Function.Bijective (orderedPairOwner packing outside hcount) := by
  let toKey (p : ↥pairs) : ↥(pairKeys packing) :=
    ⟨pairKey packing p, Finset.mem_image.mpr ⟨p, Finset.mem_univ _, rfl⟩⟩
  have hkey : Function.Bijective toKey := by
    constructor
    · intro a b h
      exact pairKey_injective packing (congrArg Subtype.val h)
    · intro key
      obtain ⟨p, _, hp⟩ := Finset.mem_image.mp key.property
      exact ⟨p, Subtype.ext hp⟩
  exact (outside.orderIsoOfFin hcount).bijective.comp
    (((pairKeys packing).orderIsoOfFin (pairKeys_card packing)).symm.bijective.comp hkey)

end TwoColorNullity.Occupancy
