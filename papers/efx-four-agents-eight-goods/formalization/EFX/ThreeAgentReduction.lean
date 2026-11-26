import EFX.D2
import Mathlib.Data.Finset.Powerset

/-!
# Obtaining a nonempty three-agent EFX partition

On the finite powerset, count the bundles strictly below a bundle's value.
Reserve one more than the number of goods for each rank step, and use
cardinality to break ties. This preserves strict utility comparisons and
gives all nonempty bundles positive score. It is a finite alternative to
taking a limit of cardinality perturbations.
-/

namespace EFXResearch

universe u v
variable {Value : Type u} {G : Type v}

def natValueOrder : ValueOrder Nat where
  le := (· ≤ ·)
  refl := Nat.le_refl
  trans := Nat.le_trans
  total := Nat.le_total

/-- The normalized natural-valued case of Akrami et al.'s three-agent
existence theorem, restricted to the given goods. Empty bundles are allowed. -/
def ThreeAgentExistence [DecidableEq G] (S : Finset G) : Prop :=
  ∀ w : FourValues G Nat, (∀ i, w i ∅ = 0) →
    (∀ i, FiniteMonotone natValueOrder (w i)) →
    ∃ A, ThreeEFXAllocation natValueOrder w S A

private noncomputable def lowerBundles (O : ValueOrder Value) (v : Finset G → Value)
    (goods S : Finset G) : Finset (Finset G) := by
  classical
  exact goods.powerset.filter (fun T => ¬ O.le (v S) (v T))

private theorem mem_lowerBundles {O : ValueOrder Value} {v : Finset G → Value}
    {goods S T : Finset G} :
    T ∈ lowerBundles O v goods S ↔ T ⊆ goods ∧ ¬ O.le (v S) (v T) := by
  classical
  simp [lowerBundles]

private theorem lowerBundles_mono {O : ValueOrder Value} {v : Finset G → Value}
    {goods S T : Finset G} (h : O.le (v S) (v T)) :
    lowerBundles O v goods S ⊆ lowerBundles O v goods T := by
  intro X hx
  obtain ⟨hX, hSX⟩ := mem_lowerBundles.mp hx
  exact mem_lowerBundles.mpr ⟨hX, fun hTX => hSX (O.trans h hTX)⟩

private noncomputable def score (O : ValueOrder Value) (v : Finset G → Value)
    (goods S : Finset G) : Nat :=
  (lowerBundles O v goods S).card * (goods.card + 1) + S.card

private theorem score_empty {O : ValueOrder Value} {v : Finset G → Value}
    (goods : Finset G) (hv : FiniteMonotone O v) :
    score O v goods ∅ = 0 := by
  have hn : lowerBundles O v goods ∅ = ∅ := by
    apply Finset.eq_empty_iff_forall_notMem.mpr
    intro X hX
    exact (mem_lowerBundles.mp hX).2 (hv (Finset.empty_subset X))
  simp [score, hn]

private theorem score_mono {O : ValueOrder Value} {v : Finset G → Value}
    (goods : Finset G) (hv : FiniteMonotone O v) :
    FiniteMonotone natValueOrder (score O v goods) := by
  intro S T h
  exact Nat.add_le_add
    (Nat.mul_le_mul_right _ (Finset.card_le_card (lowerBundles_mono (hv h))))
    (Finset.card_le_card h)

private theorem le_of_score_le {O : ValueOrder Value} {v : Finset G → Value}
    {goods S T : Finset G} (hT : T ⊆ goods) (h : score O v goods S ≤ score O v goods T) :
    O.le (v S) (v T) := by
  by_contra hn
  have hsub : lowerBundles O v goods T ⊆ lowerBundles O v goods S :=
    lowerBundles_mono ((O.total _ _).resolve_left hn)
  have hin : T ∈ lowerBundles O v goods S := mem_lowerBundles.mpr ⟨hT, hn⟩
  have hout : T ∉ lowerBundles O v goods T :=
    fun hmem => (mem_lowerBundles.mp hmem).2 (O.refl _)
  have hlt : (lowerBundles O v goods T).card < (lowerBundles O v goods S).card :=
    Finset.card_lt_card (Finset.ssubset_iff_subset_ne.mpr
      ⟨hsub, fun heq => hout (heq.symm ▸ hin)⟩)
  have hscaled := Nat.mul_le_mul_right (goods.card + 1) (Nat.succ_le_of_lt hlt)
  rw [Nat.succ_mul] at hscaled
  have hcard := Finset.card_le_card hT
  unfold score at h
  omega

variable [DecidableEq G]

/-- On seven goods, any three-agent EFX allocation for the strictly positive
scores gives a nonempty EFX allocation for the original preorder-valued utilities. -/
theorem nonempty_of_threeAgentExistence (O : ValueOrder Value) (v : FourValues G Value)
    (hm : ∀ i, FiniteMonotone O (v i)) {S : Finset G} (hcard : S.card = 7)
    (hexists : ThreeAgentExistence S) :
    ThreeEFXInput O v S := by
  let w : FourValues G Nat := fun i => score O (v i) S
  obtain ⟨A, hA⟩ := hexists w (fun i => score_empty S (hm i))
    (fun i => score_mono S (hm i))
  have hsub (i : Fin 4) (hi : i ≠ 0) : A i ⊆ S :=
    fun _ hx => (hA.cover _).mpr ⟨i, hi, hx⟩
  have hbig : ∃ j : Fin 4, j ≠ 0 ∧ 2 ≤ (A j).card := by
    by_contra h
    have hsmall (j : Fin 4) (hj : j ≠ 0) : (A j).card ≤ 1 := by
      by_contra hn
      exact h ⟨j, hj, by omega⟩
    have hcover : A 1 ∪ A 2 ∪ A 3 = S := by
      ext x
      rw [hA.cover]
      simp only [Finset.mem_union]
      constructor
      · rintro ((hx | hx) | hx)
        · exact ⟨1, by decide, hx⟩
        · exact ⟨2, by decide, hx⟩
        · exact ⟨3, by decide, hx⟩
      · rintro ⟨i, hi, hx⟩
        fin_cases i
        · contradiction
        · exact Or.inl (Or.inl hx)
        · exact Or.inl (Or.inr hx)
        · exact Or.inr hx
    have hbound12 := Finset.card_union_le (A 1) (A 2)
    have hbound123 := Finset.card_union_le (A 1 ∪ A 2) (A 3)
    rw [hcover, hcard] at hbound123
    have h1 := hsmall 1 (by decide)
    have h2 := hsmall 2 (by decide)
    have h3 := hsmall 3 (by decide)
    omega
  obtain ⟨j, hj, hsize⟩ := hbig
  refine ⟨A, ⟨hA.cover, hA.disjoint, ?_⟩, ?_⟩
  · intro i k hi hk x hx
    exact le_of_score_le (hsub i hi) (hA.fair i k hi hk hx)
  · intro i hi
    by_contra h
    have hemp : A i = ∅ := Finset.not_nonempty_iff_eq_empty.mp h
    obtain ⟨x, hx⟩ := Finset.card_pos.mp (by omega : 0 < (A j).card)
    have hcount := Finset.card_erase_add_one hx
    have hfair := hA.fair i j hi hj hx
    change score O (v i) S ((A j).erase x) ≤ score O (v i) S (A i) at hfair
    rw [hemp, score_empty S (hm i)] at hfair
    unfold score at hfair
    omega

/-- D2 under the explicit existing three-agent existence theorem for normalized
natural-valued monotone valuations. The formal proof also handles zero-valued
nonempty bundles and constructs the nonempty input to the repair. -/
theorem common_pair_dominant (O : ValueOrder Value) (v : FourValues G Value)
    (hm : ∀ i, FiniteMonotone O (v i)) {U : Finset G} {g : G}
    (hg : g ∈ U) (hU : U.card = 8) (hd : PairDominates O v U g)
    (hexists : ThreeAgentExistence (U.erase g)) :
    FourEFX O v U := by
  have hcount := Finset.card_erase_add_one hg
  exact d2_of_three O v hm hg hU hd
    (nonempty_of_threeAgentExistence O v hm (by omega) hexists)

end EFXResearch

#print axioms EFXResearch.nonempty_of_threeAgentExistence
#print axioms EFXResearch.common_pair_dominant
