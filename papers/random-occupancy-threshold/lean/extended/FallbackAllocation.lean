import ScreenedAllocation

open scoped BigOperators

namespace TwoColorNullity.Occupancy

private theorem floorLog_lt (n : ℕ) (hn : 2 ≤ n) : n.log2 < n :=
  (Nat.log2_lt (by omega)).mpr Nat.lt_two_pow_self

private def fallbackCoordinates (n : ℕ) (hn : 2 ≤ n) : Fin n.log2 ↪ Fin n :=
  Fin.castLEEmb (floorLog_lt n hn).le

private def fallbackOwners (n : ℕ) (hn : 2 ≤ n) : Finset (Fin n) :=
  selectedOwners (fallbackCoordinates n hn)

private theorem fallbackOwners_card (n : ℕ) (hn : 2 ≤ n) : (fallbackOwners n hn).card = n.log2 :=
  selectedOwners_card _

private def fallbackPairs (n : ℕ) (hn : 2 ≤ n) (tag : Fin n → Fin (3 * n - 1) → Bool) :
    Finset (Finset (Fin (3 * n - 1))) :=
  pairSets ((bucketPairs (packedLabel tag (fallbackCoordinates n hn)) (List.finRange (3 * n - 1))).take
    (n - n.log2))

private theorem fallbackPairs_spec (n : ℕ) (hn : 2 ≤ n) (tag : Fin n → Fin (3 * n - 1) → Bool) :
    PairPacking (signature tag (fallbackOwners n hn)) Finset.univ (fallbackPairs n hn tag) ∧
      (fallbackPairs n hn tag).card = n - n.log2 := by
  let coords := fallbackCoordinates n hn
  let records := bucketPairs (packedLabel tag coords) (List.finRange (3 * n - 1))
  have hl : n ≤ records.length := (fixed_item_bucket_run tag hn coords).1
  obtain ⟨packing, hcount⟩ := packed_bucket_pairs tag coords
  obtain ⟨hsub, hsize⟩ := pairSets_prefix_correct records hcount (n - n.log2) (by omega)
  exact ⟨packing.subpacking hsub, hsize⟩

private theorem fallbackOwners_pos (n : ℕ) (hn : 2 ≤ n) : 0 < (fallbackOwners n hn).card := by
  rw [fallbackOwners_card]
  exact (Nat.le_log2 (by omega)).mpr (by omega)

private theorem fallbackOutside_card (n : ℕ) (hn : 2 ≤ n) (tag : Fin n → Fin (3 * n - 1) → Bool) :
    ((fallbackOwners n hn)ᶜ).card = (fallbackPairs n hn tag).card := by
  rw [(fallbackPairs_spec n hn tag).2, Finset.card_compl, Fintype.card_fin, fallbackOwners_card]

/-- Use the first floor-logarithmic coordinates and balance every unpaired chore. -/
def runFallbackAllocation (n : ℕ) (hn : 2 ≤ n) (tag : Fin n → Fin (3 * n - 1) → Bool)
    (item : Fin (3 * n - 1)) : Fin n :=
  let owners := fallbackOwners n hn
  let pairs := fallbackPairs n hn tag
  let packing := (fallbackPairs_spec n hn tag).1
  if h : item ∈ usedItems pairs then
    (orderedPairOwner packing ownersᶜ (fallbackOutside_card n hn tag) (chorePair packing item h)).val
  else (roundRobin (usedItems pairs)ᶜ owners (fallbackOwners_pos n hn) ⟨item, Finset.mem_compl.mpr h⟩).val

/-- The computed fallback always has a finite factor. -/
theorem runFallbackAllocation_valid (n : ℕ) (hn : 2 ≤ n) (tag : Fin n → Fin (3 * n - 1) → Bool) :
    ApproxEFX tag (runFallbackAllocation n hn tag) ((((n - 1) ⌈/⌉ n.log2 : ℕ)) : ℝ) := by
  classical
  let items := Fin (3 * n - 1)
  let owners := fallbackOwners n hn
  let pairs := fallbackPairs n hn tag
  let packing : PairPacking (signature tag owners) Finset.univ pairs := (fallbackPairs_spec n hn tag).1
  let used := usedItems pairs
  let remaining := usedᶜ
  let outside := ownersᶜ
  let pairOwner := orderedPairOwner packing outside (fallbackOutside_card n hn tag)
  let distribute := roundRobin remaining owners (fallbackOwners_pos n hn)
  let assign := runFallbackAllocation n hn tag
  have hpairOwner : Function.Bijective pairOwner := orderedPairOwner_bijective packing outside (fallbackOutside_card n hn tag)
  have hcard : owners.card = n.log2 := fallbackOwners_card n hn
  have hpos : 0 < owners.card := fallbackOwners_pos n hn
  have hlt : owners.card < n := by rw [hcard]; exact floorLog_lt n hn
  have hcards : pairs.card = n - owners.card := by rw [hcard]; exact (fallbackPairs_spec n hn tag).2
  have hused (g : items) (hg : g ∈ used) : assign g = (pairOwner (chorePair packing g hg)).val := by
    change g ∈ usedItems (fallbackPairs n hn tag) at hg
    unfold assign runFallbackAllocation
    rw [dif_pos hg]
  have hfree (g : ↥remaining) : assign g.val = (distribute g).val := by
    have hg : g.val ∉ usedItems (fallbackPairs n hn tag) := Finset.mem_compl.mp g.property
    unfold assign runFallbackAllocation
    rw [dif_neg hg]
  have hp_bundle (i : Fin n) (hi : i ∉ owners) : ∃ p ∈ pairs, bundle assign i = p := by
    let j : ↥outside := ⟨i, Finset.mem_compl.mpr hi⟩
    obtain ⟨p, hp⟩ := hpairOwner.2 j
    refine ⟨p.val, p.property, ?_⟩
    ext g
    rw [mem_bundle_iff]
    by_cases hg : g ∈ used
    · rw [hused g hg]
      constructor
      · intro he
        have he' : pairOwner (chorePair packing g hg) = j := Subtype.ext he
        have hq := hpairOwner.1 (he'.trans hp.symm)
        simpa only [hq] using chorePair_contains packing hg
      · intro hm
        rw [chorePair_eq packing hg p hm, hp]
    · have hnp : g ∉ p.val := fun h => hg (Finset.mem_biUnion.mpr ⟨p.val, p.property, h⟩)
      have hother : assign g ≠ i := by
        rw [hfree ⟨g, Finset.mem_compl.mpr hg⟩]
        exact fun he => hi (he ▸ (distribute ⟨g, Finset.mem_compl.mpr hg⟩).property)
      simp [hother, hnp]
  have hremaining : remaining.card = 2 * owners.card + (n - 1) := by
    have hcount : used.card = 2 * pairs.card := by
      change (pairs.biUnion (fun p => p)).card = 2 * pairs.card
      rw [Finset.card_biUnion (fun p hp q hq hne => packing.disjoint p hp q hq hne)]
      have hsum : (∑ p ∈ pairs, p.card) = ∑ _p ∈ pairs, (2 : ℕ) := by
        apply Finset.sum_congr rfl
        exact fun p hp => packing.two p hp
      rw [hsum]
      simp [Nat.mul_comm]
    change (usedᶜ).card = _
    rw [Finset.card_compl, Fintype.card_fin, hcount, hcards]
    omega
  have hlarge (i : Fin n) (hi : i ∈ owners) : 3 ≤ (bundle assign i).card ∧
      (bundle assign i).card ≤ 2 + ((n - 1) ⌈/⌉ owners.card) := by
    let j : ↥owners := ⟨i, hi⟩
    let given := ((Finset.univ : Finset (↥remaining)).filter fun g => distribute g = j).image Subtype.val
    have heq : bundle assign i = given := by
      ext g
      rw [mem_bundle_iff]
      constructor
      · intro he
        have h : g ∉ used := by
          intro hg
          have hnot := Finset.mem_compl.mp (pairOwner (chorePair packing g hg)).property
          exact hnot (((hused g hg).symm.trans he).symm ▸ hi)
        let item : ↥remaining := ⟨g, Finset.mem_compl.mpr h⟩
        have he' : distribute item = j := Subtype.ext ((hfree item).symm.trans he)
        exact Finset.mem_image.mpr ⟨item, Finset.mem_filter.mpr ⟨Finset.mem_univ _, he'⟩, rfl⟩
      · rintro h
        obtain ⟨item, hm, rfl⟩ := Finset.mem_image.mp h
        rw [hfree, (Finset.mem_filter.mp hm).2]
    have hcount : given.card = Fintype.card {g : ↥remaining // distribute g = j} := by
      unfold given
      rw [Finset.card_image_of_injective _ Subtype.val_injective, Fintype.card_subtype]
    rw [heq, hcount]
    have hloads : remaining.card / owners.card ≤ Fintype.card {g : ↥remaining // distribute g = j} ∧
        Fintype.card {g : ↥remaining // distribute g = j} ≤ remaining.card ⌈/⌉ owners.card :=
      roundRobin_load remaining owners (fallbackOwners_pos n hn) j
    obtain ⟨hb, hu⟩ := hloads
    rw [hremaining] at hb hu
    constructor
    · apply le_trans _ hb
      apply (Nat.le_div_iff_mul_le hpos).mpr
      omega
    · apply hu.trans
      apply (ceilDiv_le_iff_le_mul hpos).mpr
      have hcov : n - 1 ≤ owners.card * ((n - 1) ⌈/⌉ owners.card) :=
        (ceilDiv_le_iff_le_mul hpos).mp le_rfl
      rw [Nat.mul_add, Nat.mul_comm owners.card 2]
      omega
  have hsmall (i : Fin n) (hi : i ∉ owners) : (bundle assign i).card = 2 := by
    obtain ⟨p, hp, he⟩ := hp_bundle i hi
    rw [he, packing.two p hp]
  rw [← hcard]
  apply approxEFX_of_projected_pairing tag assign
  · intro i
    by_cases hi : i ∈ owners
    · exact (by decide : 2 ≤ 3).trans (hlarge i hi).1
    · rw [hsmall i hi]
  · intro i
    by_cases hi : i ∈ owners
    · have h := (hlarge i hi).2
      omega
    · rw [hsmall i hi]
      omega
  · intro i j hi hj a ha b hb
    have hout : j ∉ owners := fun hj' => by have := (hlarge j hj').1; omega
    have hin : i ∈ owners := by by_contra hi'; have := hsmall i hi'; omega
    obtain ⟨p, hp, he⟩ := hp_bundle j hout
    rw [he] at ha hb
    exact congrFun (packing.homogeneous p hp a ha b hb) ⟨i, hin⟩

end TwoColorNullity.Occupancy
