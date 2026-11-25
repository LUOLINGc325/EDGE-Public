import ExactMatchingCount
import FiniteProbability
import OptimalFactor
import Mathlib.Order.Interval.Finset.Nat

open scoped BigOperators

namespace TwoColorNullity

abbrev BitProfile (n m : ℕ) := (Fin n × Fin m) → Bool

def profileTag {n m : ℕ} (bits : BitProfile n m) (i : Fin n) (g : Fin m) : Bool := bits (i, g)

def MatchingAgrees {n m r : ℕ} (owners : Finset (Fin n))
    (matching : UnorderedMatching (Fin m) r) (bits : BitProfile n m) : Prop :=
  ∀ p ∈ matching.val, ∀ a ∈ p, ∀ b ∈ p, signature (profileTag bits) owners a = signature (profileTag bits) owners b

theorem matching_agreement_probability {n m r : ℕ} (owners : Finset (Fin n))
    (matching : UnorderedMatching (Fin m) r) :
    finiteProbability (MatchingAgrees owners matching) = ((1 : ℝ) / 2) ^ (r * owners.card) := by
  classical
  obtain ⟨embed, hpair, _⟩ := matching.property.2.exists_indexing matching.property.1
  have agreement (bits : BitProfile n m) : MatchingAgrees owners matching bits ↔
      (∀ i : ↥owners, ∀ k : Fin r, bits (i.val, embed (k, true)) = bits (i.val, embed (k, false))) := by
    constructor
    · intro h i k
      have hm : indexedPair embed k ∈ matching.val := hpair ▸ Finset.mem_image.mpr ⟨k, Finset.mem_univ _, rfl⟩
      have hs := h (indexedPair embed k) hm (embed (k, true)) (mem_indexedPair.mpr ⟨true, rfl⟩)
        (embed (k, false)) (mem_indexedPair.mpr ⟨false, rfl⟩)
      exact congrFun hs i
    · intro h
      have pack := unorderedPairs_packing (signature (profileTag bits) owners) embed
        (fun k => funext fun i => (h i k).symm)
      rw [hpair] at pack
      exact pack.homogeneous
  rw [show MatchingAgrees owners matching = _ from funext fun bits => propext (agreement bits)]
  exact disjoint_pairs_agreement_probability owners r embed

theorem feasibleOwner_matching {n m : ℕ} (bits : BitProfile n m) (owners : Finset (Fin n))
    (h : FeasibleOwners (profileTag bits) owners) :
    ∃ matching : UnorderedMatching (Fin m) (n - owners.card), MatchingAgrees owners matching bits := by
  obtain ⟨pairs, packing, hcard⟩ := pairCapacity_choose (profileTag bits) owners _ h.2.2
  let matching : UnorderedMatching (Fin m) (n - owners.card) :=
    ⟨pairs, hcard, packing.two, packing.inside, fun _ _ _ _ _ _ => rfl, packing.disjoint⟩
  exact ⟨matching, packing.homogeneous⟩

theorem fixed_owner_set_bound {n m r : ℕ} (owners : Finset (Fin n)) :
    finiteProbability (fun bits : BitProfile n m =>
        ∃ matching : UnorderedMatching (Fin m) r, MatchingAgrees owners matching bits) ≤
      (Fintype.card (UnorderedMatching (Fin m) r) : ℝ) * ((1 : ℝ) / 2) ^ (r * owners.card) := by
  classical
  have bound := finiteProbability_union_bound
    (witnesses := (Finset.univ : Finset (UnorderedMatching (Fin m) r))) (MatchingAgrees owners)
  simpa only [Finset.mem_univ, true_and, matching_agreement_probability, Finset.sum_const,
    Finset.card_univ, nsmul_eq_mul] using bound

theorem fixed_sizes_bound {n m : ℕ} (s r : ℕ) :
    finiteProbability (fun bits : BitProfile n m =>
        ∃ owners : Finset (Fin n), owners.card = s ∧
          ∃ matching : UnorderedMatching (Fin m) r, MatchingAgrees owners matching bits) ≤
      (n.choose s : ℝ) * (Fintype.card (UnorderedMatching (Fin m) r) : ℝ) * ((1 : ℝ) / 2) ^ (r * s) := by
  classical
  let sets := (Finset.univ : Finset (Fin n)).powersetCard s
  have eventEq (bits : BitProfile n m) :
      (∃ owners : Finset (Fin n), owners.card = s ∧
        ∃ matching : UnorderedMatching (Fin m) r, MatchingAgrees owners matching bits) ↔
      (∃ owners ∈ sets, ∃ matching : UnorderedMatching (Fin m) r, MatchingAgrees owners matching bits) := by
    simp [sets, Finset.mem_powersetCard]
  rw [show (fun bits => ∃ owners : Finset (Fin n), owners.card = s ∧
      ∃ matching : UnorderedMatching (Fin m) r, MatchingAgrees owners matching bits) = _ from
    funext fun bits => propext (eventEq bits)]
  refine (finiteProbability_union_bound (witnesses := sets) _).trans ?_
  calc
    _ ≤ ∑ _ ∈ sets, (Fintype.card (UnorderedMatching (Fin m) r) : ℝ) * ((1 : ℝ) / 2) ^ (r * s) := by
      apply Finset.sum_le_sum
      intro owners hmem
      have hs := (Finset.mem_powersetCard.mp hmem).2
      simpa only [hs] using (fixed_owner_set_bound (r := r) owners)
    _ = _ := by simp [sets, Finset.card_powersetCard, mul_assoc]

/-- The exact finite union bound for the largest feasible owner set. -/
theorem finite_large_set_tail (n u : ℕ) (hn : 2 ≤ n) :
    finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      u ≤ maximumFeasibleOwners (profileTag bits)) ≤
      ∑ s ∈ Finset.Icc u (n - 1),
        (n.choose s : ℝ) * (Fintype.card (UnorderedMatching (Fin (3 * n - 1)) (n - s)) : ℝ) *
          ((1 : ℝ) / 2) ^ ((n - s) * s) := by
  classical
  let event (s : ℕ) (bits : BitProfile n (3 * n - 1)) :=
    ∃ owners : Finset (Fin n), owners.card = s ∧
      ∃ matching : UnorderedMatching (Fin (3 * n - 1)) (n - s), MatchingAgrees owners matching bits
  have subset (bits : BitProfile n (3 * n - 1)) (h : u ≤ maximumFeasibleOwners (profileTag bits)) :
      ∃ s ∈ Finset.Icc u (n - 1), event s bits := by
    obtain ⟨owners, feasible, heq⟩ := maximumFeasibleOwners_attained (profileTag bits) hn
    have hp := feasible.2.1
    rw [heq] at h
    exact ⟨owners.card, Finset.mem_Icc.mpr ⟨h, by omega⟩, owners, rfl, feasibleOwner_matching bits owners feasible⟩
  exact (finiteProbability_mono subset).trans ((finiteProbability_union_bound event).trans
    (Finset.sum_le_sum fun s _ => fixed_sizes_bound (n := n) (m := 3 * n - 1) s (n - s)))

end TwoColorNullity
