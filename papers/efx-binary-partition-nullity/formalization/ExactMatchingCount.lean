import MatchingEncoding
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Perm
import Mathlib.Data.Fintype.Powerset
import Mathlib.Data.Fintype.Sigma
import Mathlib.Logic.Equiv.Sum

open scoped BigOperators

namespace TwoColorNullity

variable {Item : Type*} [Fintype Item] [DecidableEq Item] {r : ℕ}

def UnorderedMatching (Item : Type*) [Fintype Item] [DecidableEq Item] (r : ℕ) :=
  {pairs : Finset (Finset Item) // pairs.card = r ∧ PairPacking (fun _ : Item => ()) Finset.univ pairs}

noncomputable instance : Fintype (UnorderedMatching Item r) := by
  unfold UnorderedMatching
  exact Fintype.ofFinite _

def forgetOrientation (e : (Fin r × Bool) ↪ Item) : UnorderedMatching Item r :=
  ⟨unorderedPairs e, unorderedPairs_card e, unorderedPairs_packing (fun _ => ()) e (fun _ => rfl)⟩

def MatchingOrientation (pairs : Finset (Finset Item)) (r : ℕ) :=
  (Fin r ≃ ↥pairs) × ((p : ↥pairs) → Bool ≃ ↥p.val)

noncomputable instance {pairs : Finset (Finset Item)} : Fintype (MatchingOrientation pairs r) := by
  classical
  unfold MatchingOrientation
  infer_instance

private def orientationEmbedding (matching : UnorderedMatching Item r)
    (oriented : MatchingOrientation matching.val r) : (Fin r × Bool) ↪ Item := {
  toFun := fun index => (oriented.2 (oriented.1 index.1) index.2).val
  inj' := by
    rintro ⟨i, a⟩ ⟨j, b⟩ he
    let x := oriented.1 i
    let y := oriented.1 j
    have hx : (oriented.2 x a).val ∈ x.val := (oriented.2 x a).property
    have hy : (oriented.2 x a).val ∈ y.val := by
      change (oriented.2 x a).val = (oriented.2 y b).val at he
      rw [he]
      exact (oriented.2 y b).property
    have hxy : x = y := by
      apply Subtype.ext
      by_contra hne
      exact Finset.disjoint_left.mp (matching.property.2.disjoint _ x.property _ y.property hne) hx hy
    have hindex : i = j := oriented.1.injective hxy
    subst j
    exact Prod.ext rfl ((oriented.2 (oriented.1 i)).injective (Subtype.ext he))
}

private theorem orientationEmbedding_pair (matching : UnorderedMatching Item r)
    (oriented : MatchingOrientation matching.val r) (k : Fin r) :
    indexedPair (orientationEmbedding matching oriented) k = (oriented.1 k).val := by
  apply Finset.eq_of_subset_of_card_le
  · intro item hitem
    obtain ⟨bit, rfl⟩ := mem_indexedPair.mp hitem
    exact (oriented.2 (oriented.1 k) bit).property
  · rw [indexedPair_card, matching.property.2.two _ (oriented.1 k).property]

private theorem orientationEmbedding_unordered (matching : UnorderedMatching Item r)
    (oriented : MatchingOrientation matching.val r) :
    forgetOrientation (orientationEmbedding matching oriented) = matching := by
  apply Subtype.ext
  ext pair
  change pair ∈ Finset.univ.image (indexedPair (orientationEmbedding matching oriented)) ↔ pair ∈ matching.val
  constructor
  · intro h
    obtain ⟨k, _, rfl⟩ := Finset.mem_image.mp h
    rw [orientationEmbedding_pair]
    exact (oriented.1 k).property
  · intro h
    let p : ↥matching.val := ⟨pair, h⟩
    refine Finset.mem_image.mpr ⟨oriented.1.symm p, Finset.mem_univ _, ?_⟩
    simp [orientationEmbedding_pair, p]

private noncomputable def orientationFiberEquiv (matching : UnorderedMatching Item r) :
    MatchingOrientation matching.val r ≃ {e : (Fin r × Bool) ↪ Item // forgetOrientation e = matching} := by
  classical
  let pack (oriented : MatchingOrientation matching.val r) :
      {e : (Fin r × Bool) ↪ Item // forgetOrientation e = matching} :=
    ⟨orientationEmbedding matching oriented, orientationEmbedding_unordered matching oriented⟩
  refine Equiv.ofBijective pack ⟨?_, ?_⟩
  · intro a b he
    have hab : orientationEmbedding matching a = orientationEmbedding matching b := congrArg Subtype.val he
    have horder : a.1 = b.1 := by
      apply Equiv.ext
      intro k
      apply Subtype.ext
      rw [← orientationEmbedding_pair matching a, ← orientationEmbedding_pair matching b, hab]
    obtain ⟨orderA, orientA⟩ := a
    obtain ⟨orderB, orientB⟩ := b
    change orderA = orderB at horder
    subst orderB
    have horientation : orientA = orientB := by
      funext pair
      obtain ⟨k, rfl⟩ := orderA.surjective pair
      apply Equiv.ext
      intro bit
      apply Subtype.ext
      exact congrArg (fun (e : (Fin r × Bool) ↪ Item) => e (k, bit)) hab
    rw [horientation]
  · rintro ⟨embed, hpack⟩
    have hpairs : unorderedPairs embed = matching.val := congrArg Subtype.val hpack
    let pair_at (k : Fin r) : ↥matching.val :=
      ⟨indexedPair embed k, hpairs ▸ Finset.mem_image.mpr ⟨k, Finset.mem_univ _, rfl⟩⟩
    have hinjective : Function.Injective pair_at := fun _ _ he => indexedPair_injective embed (congrArg Subtype.val he)
    have hsurjective : Function.Surjective pair_at := by
      intro pair
      have hp : pair.val ∈ unorderedPairs embed := hpairs.symm ▸ pair.property
      obtain ⟨k, _, hk⟩ := Finset.mem_image.mp hp
      exact ⟨k, Subtype.ext hk⟩
    let order := Equiv.ofBijective pair_at ⟨hinjective, hsurjective⟩
    have hpair (pair : ↥matching.val) : indexedPair embed (order.symm pair) = pair.val :=
      congrArg Subtype.val (order.apply_symm_apply pair)
    let orient (pair : ↥matching.val) : Bool ≃ ↥pair.val := by
      let point (bit : Bool) : ↥pair.val := ⟨embed (order.symm pair, bit),
        hpair pair ▸ mem_indexedPair.mpr ⟨bit, rfl⟩⟩
      refine Equiv.ofBijective point ⟨?_, ?_⟩
      · intro a b he
        exact congrArg Prod.snd (embed.injective (congrArg Subtype.val he))
      · intro point
        have hp : point.val ∈ indexedPair embed (order.symm pair) := (hpair pair).symm ▸ point.property
        obtain ⟨bit, he⟩ := mem_indexedPair.mp hp
        exact ⟨bit, Subtype.ext he⟩
    refine ⟨⟨order, orient⟩, Subtype.ext ?_⟩
    ext index
    change embed (order.symm (order index.1), index.2) = embed index
    rw [Equiv.symm_apply_apply]

private theorem orientations_card (matching : UnorderedMatching Item r) :
    Fintype.card (MatchingOrientation matching.val r) = r.factorial * 2 ^ r := by
  classical
  have hp (p : ↥matching.val) : Fintype.card (Bool ≃ ↥p.val) = 2 := by
    have he : Fintype.card Bool = Fintype.card (↥p.val) := by
      rw [Fintype.card_bool, Fintype.card_coe, matching.property.2.two _ p.property]
    rw [Fintype.card_equiv (Fintype.equivOfCardEq he), Fintype.card_bool]
    decide
  unfold MatchingOrientation
  rw [Fintype.card_prod, Fintype.card_equiv (Finset.equivFinOfCardEq matching.property.1).symm,
    Fintype.card_fin, Fintype.card_pi]
  simp [hp, matching.property.1]

/-- Every unlabeled matching has exactly r! 2^r ordered, oriented descriptions. -/
theorem unordered_matchings_count_mul (items r : ℕ) :
    Fintype.card (UnorderedMatching (Fin items) r) * (r.factorial * 2 ^ r) = items.descFactorial (2 * r) := by
  classical
  have h := Fintype.card_congr (Equiv.sigmaFiberEquiv (forgetOrientation (Item := Fin items) (r := r)))
  rw [Fintype.card_sigma, indexed_matchings_count] at h
  have fiber (matching : UnorderedMatching (Fin items) r) :
      Fintype.card {e : (Fin r × Bool) ↪ Fin items // forgetOrientation e = matching} = r.factorial * 2 ^ r :=
    (Fintype.card_congr (orientationFiberEquiv matching)).symm.trans (orientations_card matching)
  simpa [fiber, Nat.mul_comm] using h

end TwoColorNullity
