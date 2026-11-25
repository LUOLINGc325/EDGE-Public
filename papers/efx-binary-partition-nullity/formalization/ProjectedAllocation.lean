import BalancedAllocation
import NullityCosts
import ProjectedMatching
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Pi

open scoped BigOperators

namespace TwoColorNullity

variable {n m : ℕ}

@[simp] theorem mem_bundle_iff {assign : Fin m → Fin n} {i : Fin n} {g : Fin m} :
    g ∈ bundle assign i ↔ assign g = i := by
  simp [bundle]

def signature (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n)) (item : Fin m)
    (i : ↥owners) : Bool := tag i.val item

noncomputable def pairCapacity (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n)) : ℕ := by
  classical
  exact projectedPairCount (signature tag owners) Finset.univ

theorem pairCapacity_lower (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n)) :
    m ≤ 2 * pairCapacity tag owners + 2 ^ owners.card := by
  classical
  have lower := projectedPairCount_lower (signature tag owners) Finset.univ
  simpa [pairCapacity, Fintype.card_fun] using lower

theorem PairPacking.subpacking {Item Label : Type*} [DecidableEq Item]
    {label : Item → Label} {available : Finset Item} {pairs somePairs : Finset (Finset Item)}
    (packing : PairPacking label available pairs) (hs : somePairs ⊆ pairs) :
    PairPacking label available somePairs :=
  ⟨fun p hp => packing.two p (hs hp), fun p hp => packing.inside p (hs hp),
    fun p hp => packing.homogeneous p (hs hp),
    fun p hp q hq hne => packing.disjoint p (hs hp) q (hs hq) hne⟩

theorem pairCapacity_choose (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n))
    (k : ℕ) (hk : k ≤ pairCapacity tag owners) :
    ∃ pairs, PairPacking (signature tag owners) Finset.univ pairs ∧ pairs.card = k := by
  classical
  obtain ⟨allPairs, packing, hsize⟩ := projectedPairCount_attained (signature tag owners) Finset.univ
  change allPairs.card = pairCapacity tag owners at hsize
  have hk' : k ≤ allPairs.card := by simpa [hsize] using hk
  obtain ⟨pairs, hs, hp⟩ := Finset.exists_subset_card_eq hk'
  exact ⟨pairs, packing.subpacking hs, hp⟩

/-- Assign the prescribed pairs to the other owners, then allocate the rest evenly. -/
theorem allocate_prescribed_pairs (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n))
    (howners : 0 < owners.card) (pairs : Finset (Finset (Fin m)))
    (packing : PairPacking (signature tag owners) Finset.univ pairs)
    (hpairs : pairs.card = n - owners.card) :
    ∃ assign : Fin m → Fin n,
      (∀ i ∉ owners, ∃ p ∈ pairs, bundle assign i = p) ∧
      (∀ i ∈ owners,
        (m - 2 * (n - owners.card)) / owners.card ≤ (bundle assign i).card ∧
        (bundle assign i).card ≤ (m - 2 * (n - owners.card)) ⌈/⌉ owners.card) := by
  classical
  let used := pairs.biUnion (fun p => p)
  let free := usedᶜ
  let others := ownersᶜ
  have covered : used.card = 2 * pairs.card := by
    dsimp only [used]
    rw [Finset.card_biUnion (fun p hp q hq hne => packing.disjoint p hp q hq hne)]
    calc
      (∑ p ∈ pairs, p.card) = ∑ _ ∈ pairs, (2 : ℕ) := by
        apply Finset.sum_congr rfl
        exact fun p hp => packing.two p hp
      _ = _ := by simp [Nat.mul_comm]
  have free_count : free.card = m - 2 * (n - owners.card) := by
    simp [free, Finset.card_compl, covered, hpairs]
  have other_count : others.card = pairs.card := by simp [others, Finset.card_compl, hpairs]
  let pairOwner : ↥pairs ≃ ↥others := Finset.equivOfCardEq other_count.symm
  obtain ⟨distribute, balanced⟩ := balanced_owners (↥free) (↥owners) (by simpa using howners)
  let pairFor (g : Fin m) (hg : g ∈ used) : ↥pairs :=
    ⟨(Finset.mem_biUnion.mp hg).choose, (Finset.mem_biUnion.mp hg).choose_spec.1⟩
  have within (g : Fin m) (hg : g ∈ used) : g ∈ (pairFor g hg).val :=
    (Finset.mem_biUnion.mp hg).choose_spec.2
  have samePair {g : Fin m} (hg : g ∈ used) (pair : ↥pairs) (hp : g ∈ pair.val) :
      pairFor g hg = pair := by
    apply Subtype.ext
    by_contra hne
    exact Finset.disjoint_left.mp
      (packing.disjoint _ (pairFor g hg).property _ pair.property hne) (within g hg) hp
  let assign (g : Fin m) : Fin n :=
    if hg : g ∈ used then (pairOwner (pairFor g hg)).val
    else (distribute ⟨g, Finset.mem_compl.mpr hg⟩).val
  refine ⟨assign, ?_, ?_⟩
  · intro i hi
    let i' : ↥others := ⟨i, Finset.mem_compl.mpr hi⟩
    let pair := pairOwner.symm i'
    refine ⟨pair.val, pair.property, ?_⟩
    ext g
    rw [mem_bundle_iff]
    by_cases hg : g ∈ used
    · rw [show assign g = (pairOwner (pairFor g hg)).val by simp [assign, hg]]
      constructor
      · intro he
        have howner : pairOwner (pairFor g hg) = i' := Subtype.ext he
        have hpair : pairFor g hg = pair := pairOwner.injective (by simpa [pair] using howner)
        simpa only [hpair] using within g hg
      · intro member
        simp [samePair hg pair member, pair, i']
    · have hnopair : g ∉ pair.val := fun hm => hg (Finset.mem_biUnion.mpr ⟨pair.val, pair.property, hm⟩)
      have hnoowner : assign g ≠ i := fun he => hi (he ▸ (by simp [assign, hg] : assign g ∈ owners))
      simp [hnoowner, hnopair]
  · intro i hi
    let i' : ↥owners := ⟨i, hi⟩
    have hfree (g : ↥(bundle assign i)) : g.val ∈ free := by
      apply Finset.mem_compl.mpr
      intro hg
      have he : (pairOwner (pairFor g.val hg)).val = i := by
        simpa [assign, hg] using mem_bundle_iff.mp g.property
      exact (Finset.mem_compl.mp (pairOwner (pairFor g.val hg)).property) (he.symm ▸ hi)
    let fiber : ↥(bundle assign i) ≃ {g : ↥free // distribute g = i'} := {
      toFun := fun g => ⟨⟨g.val, hfree g⟩, by
        apply Subtype.ext
        simpa [assign, Finset.mem_compl.mp (hfree g)] using mem_bundle_iff.mp g.property⟩
      invFun := fun g => ⟨g.val.val, mem_bundle_iff.mpr (by
        have he := congrArg Subtype.val g.property
        simpa [assign, Finset.mem_compl.mp g.val.property, i'] using he)⟩
      left_inv := fun _ => Subtype.ext rfl
      right_inv := fun _ => Subtype.ext (Subtype.ext rfl)
    }
    have hcard : (bundle assign i).card = Fintype.card {g : ↥free // distribute g = i'} := by
      rw [← Fintype.card_coe (bundle assign i)]
      exact Fintype.card_congr fiber
    rw [hcard]
    simpa [Finset.card_univ, free_count] using balanced i'

/-- Use the supplied disjoint pairs in the middle-range allocation. -/
theorem approxEFX_from_prescribed_pairs (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n))
    (d : ℕ) (hm : m = 2 * n + d) (howners : 0 < owners.card) (hd : owners.card ≤ d)
    (pairs : Finset (Finset (Fin m))) (packing : PairPacking (signature tag owners) Finset.univ pairs)
    (hcount : pairs.card = n - owners.card) :
    ∃ assign, ApproxEFX tag assign ((d ⌈/⌉ owners.card : ℕ) : ℝ) ∧
      (∀ i ∉ owners, ∃ p ∈ pairs, bundle assign i = p) := by
  classical
  obtain ⟨assign, outside, inside⟩ := allocate_prescribed_pairs tag owners howners pairs packing hcount
  have hsize : owners.card ≤ n := by simpa using Finset.card_le_univ owners
  have hremain : m - 2 * (n - owners.card) = 2 * owners.card + d := by omega
  have min_large (i : Fin n) (hi : i ∈ owners) : 3 ≤ (bundle assign i).card := by
    apply le_trans _ (inside i hi).1
    apply (Nat.le_div_iff_mul_le howners).mpr
    rw [hremain]
    omega
  have upper_large (i : Fin n) (hi : i ∈ owners) :
      (bundle assign i).card ≤ (d ⌈/⌉ owners.card) + 2 := by
    apply le_trans (inside i hi).2
    apply (ceilDiv_le_iff_le_mul howners).mpr
    have hcover : d ≤ owners.card * (d ⌈/⌉ owners.card) := (ceilDiv_le_iff_le_mul howners).mp le_rfl
    rw [hremain, Nat.mul_add]
    omega
  have small (i : Fin n) (hi : i ∉ owners) : (bundle assign i).card = 2 := by
    obtain ⟨p, hp, he⟩ := outside i hi
    rw [he, packing.two p hp]
  refine ⟨assign, approxEFX_of_projected_pairing tag assign _ ?_ ?_ ?_, outside⟩
  · intro i
    by_cases hi : i ∈ owners
    · exact le_trans (by decide) (min_large i hi)
    · rw [small i hi]
  · intro i
    by_cases hi : i ∈ owners
    · exact upper_large i hi
    · rw [small i hi]
      omega
  · intro i j hi hj g hg h hh
    have hi' : i ∈ owners := by by_contra hn; have := small i hn; omega
    have hj' : j ∉ owners := fun hjin => by have := min_large j hjin; omega
    obtain ⟨p, hp, he⟩ := outside j hj'
    rw [he] at hg hh
    exact congrFun (packing.homogeneous p hp g hg h hh) ⟨i, hi'⟩

/-- The constructive middle branch for item counts of the form 2n + d. -/
theorem approxEFX_from_pairCapacity (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n))
    (d : ℕ) (hm : m = 2 * n + d) (howners : 0 < owners.card)
    (hd : owners.card ≤ d) (hcapacity : n - owners.card ≤ pairCapacity tag owners) :
    ∃ assign, ApproxEFX tag assign ((d ⌈/⌉ owners.card : ℕ) : ℝ) := by
  obtain ⟨pairs, packing, hcount⟩ := pairCapacity_choose tag owners _ hcapacity
  obtain ⟨assign, hfactor, _⟩ := approxEFX_from_prescribed_pairs tag owners d hm howners hd pairs packing hcount
  exact ⟨assign, hfactor⟩

end TwoColorNullity
