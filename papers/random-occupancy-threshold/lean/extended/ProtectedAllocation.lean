import ProtectedColorEFX
import RoundRobinAllocation
import OrderedPairPlacement

open scoped BigOperators

namespace TwoColorNullity.Occupancy

private theorem chosenOwner_card (owners : Finset (Fin n)) (owner : ↥owners) :
    ((Finset.univ : Finset (↥owners × Bool × Fin 2)).filter fun r => r.1 = owner).card = 4 := by
  classical
  let e : {r : ↥owners × Bool × Fin 2 // r.1 = owner} ≃ Bool × Fin 2 :=
    ⟨fun r => r.val.2, fun r => ⟨(owner, r), rfl⟩, by
      rintro ⟨⟨i, r⟩, h⟩
      change i = owner at h
      subst i
      rfl, fun _ => rfl⟩
  have h := Fintype.card_congr e
  rw [Fintype.card_subtype] at h
  simpa [Fintype.card_prod] using h


variable {n : ℕ} {owners : Finset (Fin n)}

private def reservedChores (chosen : (↥owners × Bool × Fin 2) → Fin (3 * n - 1)) : Finset (Fin (3 * n - 1)) :=
  Finset.univ.image chosen

private def reservationOwners (chosen : (↥owners × Bool × Fin 2) → Fin (3 * n - 1))
    (item : Fin (3 * n - 1)) : Finset (Fin n) :=
  ((Finset.univ : Finset (↥owners × Bool × Fin 2)).filter fun r => chosen r = item).image
    (fun r => r.1.val)

private theorem reservationOwners_nonempty (chosen : (↥owners × Bool × Fin 2) → Fin (3 * n - 1))
    (item : Fin (3 * n - 1)) (h : item ∈ reservedChores chosen) :
    (reservationOwners chosen item).Nonempty := by
  obtain ⟨r, _, he⟩ := Finset.mem_image.mp h
  exact ⟨r.1.val, Finset.mem_image.mpr ⟨r, Finset.mem_filter.mpr ⟨Finset.mem_univ _, he⟩, rfl⟩⟩

private def reservationOwner (chosen : (↥owners × Bool × Fin 2) → Fin (3 * n - 1))
    (item : Fin (3 * n - 1)) (h : item ∈ reservedChores chosen) : Fin n :=
  (reservationOwners chosen item).min' (reservationOwners_nonempty chosen item h)

private theorem reservationOwner_has_request (chosen : (↥owners × Bool × Fin 2) → Fin (3 * n - 1))
    (item : Fin (3 * n - 1)) (h : item ∈ reservedChores chosen) :
    ∃ r, chosen r = item ∧ r.1.val = reservationOwner chosen item h := by
  obtain ⟨r, hr, he⟩ := Finset.mem_image.mp
    ((reservationOwners chosen item).min'_mem (reservationOwners_nonempty chosen item h))
  exact ⟨r, (Finset.mem_filter.mp hr).2, he⟩

private theorem outsideCount (owners : Finset (Fin n)) (pairs : Finset (Finset (Fin (3 * n - 1))))
    (hpairs : pairs.card = n - owners.card) : (ownersᶜ).card = pairs.card := by
  simp [Finset.card_compl, hpairs]

/-- Assign the chosen pairs, computed reservations, and remaining chores in order. -/
def protectedAssignment (tag : Fin n → Fin (3 * n - 1) → Bool) (owners : Finset (Fin n))
    (howners : 0 < owners.card) (pairs : Finset (Finset (Fin (3 * n - 1))))
    (packing : PairPacking (signature tag owners) Finset.univ pairs)
    (hpairs : pairs.card = n - owners.card) (chosen : (↥owners × Bool × Fin 2) → Fin (3 * n - 1))
    (item : Fin (3 * n - 1)) : Fin n :=
  if hu : item ∈ usedItems pairs then
    (orderedPairOwner packing ownersᶜ (outsideCount owners pairs hpairs) (chorePair packing item hu)).val
  else if hr : item ∈ reservedChores chosen then reservationOwner chosen item hr
  else (roundRobin (usedItems pairs ∪ reservedChores chosen)ᶜ owners howners
    ⟨item, Finset.mem_compl.mpr (fun h => (Finset.mem_union.mp h).elim hu hr)⟩).val

/-- The computed assignment preserves the prescribed pairs and the color reservations. -/
theorem protectedAssignment_spec (tag : Fin n → Fin (3 * n - 1) → Bool)
    (owners : Finset (Fin n)) (howners : 0 < owners.card)
    (pairs : Finset (Finset (Fin (3 * n - 1))))
    (packing : PairPacking (signature tag owners) Finset.univ pairs)
    (hpairs : pairs.card = n - owners.card)
    (chosen : (↥owners × Bool × Fin 2) → Fin (3 * n - 1)) (hinj : Function.Injective chosen)
    (hchosen : ∀ r, chosen r ∉ usedItems pairs ∧ tag r.1.val (chosen r) = r.2.1) :
    let assign := protectedAssignment tag owners howners pairs packing hpairs chosen
    (∀ i ∉ owners, ∃ p ∈ pairs, bundle assign i = p) ∧
      (∀ i ∈ owners, HasTwoOfEachColor tag assign i ∧ 4 ≤ (bundle assign i).card ∧
        (bundle assign i).card ≤ 4 + ((n - 1 - 2 * owners.card) ⌈/⌉ owners.card)) ∧
      (∀ r, assign (chosen r) = r.1.val) := by
  classical
  let Item := Fin (3 * n - 1)
  let Requests := ↥owners × Bool × Fin 2
  let used := usedItems pairs
  let reserved := reservedChores chosen
  let remaining := (used ∪ reserved)ᶜ
  let others := ownersᶜ
  have husedCount : used.card = 2 * pairs.card := by
    change (pairs.biUnion (fun p => p)).card = 2 * pairs.card
    rw [Finset.card_biUnion (fun p hp q hq hne => packing.disjoint p hp q hq hne)]
    have hsum : (∑ p ∈ pairs, p.card) = ∑ _p ∈ pairs, (2 : ℕ) := by
      apply Finset.sum_congr rfl
      exact fun p hp => packing.two p hp
    rw [hsum]
    simp [Nat.mul_comm]
  have hreservedCount : reserved.card = 4 * owners.card := by
    unfold reserved reservedChores
    rw [Finset.card_image_of_injective _ hinj]
    simp [Fintype.card_prod, Nat.mul_comm]
  have hdisjoint : Disjoint used reserved := by
    apply Finset.disjoint_left.mpr
    intro item hu hr
    obtain ⟨r, _, rfl⟩ := Finset.mem_image.mp hr
    exact (hchosen r).1 hu
  have hremaining : remaining.card = n - 1 - 2 * owners.card := by
    unfold remaining
    rw [Finset.card_compl, Finset.card_union_of_disjoint hdisjoint, husedCount, hreservedCount, hpairs,
      Fintype.card_fin]
    have hcard : owners.card ≤ n := by simpa using Finset.card_le_univ owners
    omega

  let pairOwner := orderedPairOwner packing others (outsideCount owners pairs hpairs)
  have hpairOwner : Function.Bijective pairOwner := orderedPairOwner_bijective packing others (outsideCount owners pairs hpairs)
  let distribute := roundRobin remaining owners howners
  let assign := protectedAssignment tag owners howners pairs packing hpairs chosen

  have leftover (g : Item) (hu : g ∉ used) (hr : g ∉ reserved) : g ∈ remaining :=
    Finset.mem_compl.mpr (fun h => (Finset.mem_union.mp h).elim hu hr)
  have assignUsed (g : Item) (hg : g ∈ used) : assign g = (pairOwner (chorePair packing g hg)).val := by
    change g ∈ usedItems pairs at hg
    unfold assign protectedAssignment
    rw [dif_pos hg]
  have assignReservation (g : Item) (hu : g ∉ used) (hr : g ∈ reserved) :
      assign g = reservationOwner chosen g hr := by
    change g ∉ usedItems pairs at hu
    change g ∈ reservedChores chosen at hr
    unfold assign protectedAssignment
    rw [dif_neg hu, dif_pos hr]
  have assignRemainder (g : Item) (hu : g ∉ used) (hr : g ∉ reserved) :
      assign g = (distribute ⟨g, leftover g hu hr⟩).val := by
    change g ∉ usedItems pairs at hu
    change g ∉ reservedChores chosen at hr
    unfold assign protectedAssignment
    rw [dif_neg hu, dif_neg hr]
  have outsideUsed (g : Item) (hg : g ∈ used) : assign g ∉ owners := by
    rw [assignUsed g hg]
    exact Finset.mem_compl.mp (pairOwner (chorePair packing g hg)).property
  have insideFree (g : Item) (hg : g ∉ used) : assign g ∈ owners := by
    by_cases hr : g ∈ reserved
    · obtain ⟨r, _, he⟩ := reservationOwner_has_request chosen g hr
      rw [assignReservation g hg hr, ← he]
      exact r.1.property
    · rw [assignRemainder g hg hr]
      exact (distribute ⟨g, leftover g hg hr⟩).property
  have assignReserved (r : Requests) : assign (chosen r) = r.1.val := by
    have hr : chosen r ∈ reserved := Finset.mem_image.mpr ⟨r, Finset.mem_univ _, rfl⟩
    obtain ⟨q, he, hq⟩ := reservationOwner_has_request chosen (chosen r) hr
    have heq := hinj he
    subst q
    rw [assignReservation (chosen r) (hchosen r).1 hr, ← hq]
  refine ⟨?_, ?_, assignReserved⟩
  · intro owner ho
    let i : ↥others := ⟨owner, Finset.mem_compl.mpr ho⟩
    obtain ⟨p, hp⟩ := hpairOwner.2 i
    refine ⟨p.val, p.property, ?_⟩
    ext g
    rw [mem_bundle_iff]
    change assign g = owner ↔ g ∈ p.val
    by_cases hg : g ∈ used
    · rw [assignUsed g hg]
      constructor
      · intro he
        have eqOwner : pairOwner (chorePair packing g hg) = i := Subtype.ext he
        have eqPair : chorePair packing g hg = p := hpairOwner.1 (eqOwner.trans hp.symm)
        simpa only [eqPair] using chorePair_contains packing hg
      · intro hmember
        rw [chorePair_eq packing hg p hmember, hp]
    · have hnopair : g ∉ p.val := fun h => hg (Finset.mem_biUnion.mpr ⟨p.val, p.property, h⟩)
      have hne : assign g ≠ owner := fun eq => ho (eq ▸ insideFree g hg)
      simp [hne, hnopair]
  · intro owner ho
    let i : ↥owners := ⟨owner, ho⟩
    let reservedFor := ((Finset.univ : Finset Requests).filter fun r => r.1 = i).image chosen
    let remainingFor := ((Finset.univ : Finset (↥remaining)).filter fun g => distribute g = i).image Subtype.val
    have fromRemaining (g : ↥remaining) : g.val ∉ used ∧ g.val ∉ reserved := by
      have h := Finset.mem_compl.mp g.property
      exact ⟨fun hu => h (Finset.mem_union.mpr (Or.inl hu)), fun hr => h (Finset.mem_union.mpr (Or.inr hr))⟩
    have remainingAssign (g : ↥remaining) : assign g.val = (distribute g).val := by
      obtain ⟨hu, hr⟩ := fromRemaining g
      exact assignRemainder g.val hu hr
    have hbundle : bundle assign owner = reservedFor ∪ remainingFor := by
      ext g
      rw [mem_bundle_iff, Finset.mem_union]
      constructor
      · intro ha
        have hu : g ∉ used := fun h => outsideUsed g h (ha.symm ▸ ho)
        by_cases hr : g ∈ reserved
        · obtain ⟨r, hval, hreq⟩ := reservationOwner_has_request chosen g hr
          have howner : r.1 = i := Subtype.ext (hreq.trans ((assignReservation g hu hr).symm.trans ha))
          exact Or.inl (Finset.mem_image.mpr ⟨r, Finset.mem_filter.mpr ⟨Finset.mem_univ _, howner⟩, hval⟩)
        · let item : ↥remaining := ⟨g, leftover g hu hr⟩
          have hi : distribute item = i := Subtype.ext ((remainingAssign item).symm.trans ha)
          exact Or.inr (Finset.mem_image.mpr ⟨item, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hi⟩, rfl⟩)
      · rintro (hr | hr)
        · obtain ⟨r, hm, rfl⟩ := Finset.mem_image.mp hr
          rw [assignReserved, (Finset.mem_filter.mp hm).2]
        · obtain ⟨item, hm, rfl⟩ := Finset.mem_image.mp hr
          rw [remainingAssign, (Finset.mem_filter.mp hm).2]
    have hsep : Disjoint reservedFor remainingFor := by
      apply Finset.disjoint_left.mpr
      intro g hr hf
      obtain ⟨item, _, rfl⟩ := Finset.mem_image.mp hf
      obtain ⟨r, _, hval⟩ := Finset.mem_image.mp hr
      apply (fromRemaining item).2
      rw [← hval]
      exact Finset.mem_image.mpr ⟨r, Finset.mem_univ _, rfl⟩
    have hreservedFor : reservedFor.card = 4 := by
      unfold reservedFor
      rw [Finset.card_image_of_injective _ hinj]
      exact chosenOwner_card owners i
    have hremainingFor : remainingFor.card = Fintype.card {g : ↥remaining // distribute g = i} := by
      unfold remainingFor
      rw [Finset.card_image_of_injective _ Subtype.val_injective, Fintype.card_subtype]
    refine ⟨?_, ?_, ?_⟩
    · intro color
      let r0 : Requests := (i, color, 0)
      let r1 : Requests := (i, color, 1)
      refine ⟨chosen r0, mem_bundle_iff.mpr (assignReserved r0), chosen r1,
        mem_bundle_iff.mpr (assignReserved r1), ?_, (hchosen r0).2, (hchosen r1).2⟩
      intro equal
      have hef := congrArg (fun r : Requests => r.2.2) (hinj equal)
      change (0 : Fin 2) = 1 at hef
      exact (by decide : (0 : Fin 2) ≠ 1) hef
    · rw [hbundle, Finset.card_union_of_disjoint hsep, hreservedFor]
      omega
    · rw [hbundle, Finset.card_union_of_disjoint hsep, hreservedFor, hremainingFor]
      have hb : Fintype.card {g : ↥remaining // distribute g = i} ≤ remaining.card ⌈/⌉ owners.card :=
        (roundRobin_load remaining owners howners i).2
      rw [hremaining] at hb
      omega

end TwoColorNullity.Occupancy
