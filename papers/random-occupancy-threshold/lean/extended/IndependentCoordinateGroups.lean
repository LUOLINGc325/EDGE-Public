import UniformMeanMeasure
import Mathlib.Logic.Equiv.Fin.Basic

open scoped BigOperators

namespace TwoColorNullity.Occupancy

theorem finiteProbability_comp_equiv {Sample Target : Type*} [Fintype Sample] [Fintype Target]
    (e : Sample ≃ Target) (event : Target → Prop) :
    finiteProbability (event ∘ e) = finiteProbability event := by
  classical
  rw [finiteProbability_eq_mean_indicator, finiteProbability_eq_mean_indicator]
  exact finiteMean_comp_equiv e (fun x => if event x then (1 : ℝ) else 0)

theorem finiteProbability_not {Sample : Type*} [Fintype Sample] [Nonempty Sample]
    (event : Sample → Prop) :
    finiteProbability (fun x => ¬ event x) = 1 - finiteProbability event := by
  classical
  rw [finiteProbability_eq_mean_indicator, finiteProbability_eq_mean_indicator]
  have hindicator (x : Sample) :
      (if ¬ event x then (1 : ℝ) else 0) = 1 - (if event x then 1 else 0) := by
    by_cases h : event x <;> simp [h]
  simp only [hindicator, finiteMean_sub, finiteMean_const]

/-- Independent finite coordinate events have exactly the product probability. -/
theorem finiteProbability_all_coordinate_events {Group Sample : Type*}
    [Fintype Group] [DecidableEq Group] [Fintype Sample] (event : Group → Sample → Prop) :
    finiteProbability (fun data : Group → Sample => ∀ group, event group (data group)) =
      ∏ group : Group, finiteProbability (event group) := by
  classical
  simp_rw [finiteProbability_eq_mean_indicator]
  have h (data : Group → Sample) :
      (if ∀ group, event group (data group) then (1 : ℝ) else 0) =
        ∏ group : Group, (if event group (data group) then 1 else 0) := by
    by_cases hall : ∀ group, event group (data group)
    · simp [hall]
    · rw [if_neg hall]
      simp only [not_forall] at hall
      obtain ⟨group, hfail⟩ := hall
      exact (Finset.prod_eq_zero (Finset.mem_univ group) (by simp [hfail])).symm
  let indicator (group : Group) (value : Sample) : ℝ :=
    if event group value then 1 else 0
  have heq : (fun data : Group → Sample => if ∀ group, event group (data group) then (1 : ℝ) else 0) =
      (fun data : Group → Sample => ∏ group : Group, indicator group (data group)) := funext h
  rw [heq]
  exact finiteMean_product_coordinates indicator

noncomputable def ownerImageEquiv {Index : Type*} [Fintype Index] (coords : Index ↪ Fin n) :
    Index ≃ ↥(Finset.univ.map coords) :=
  Equiv.ofBijective (fun i => ⟨coords i, Finset.mem_map.mpr ⟨i, Finset.mem_univ _, rfl⟩⟩) (by
    constructor
    · intro a b he
      exact coords.injective (congrArg Subtype.val he)
    · intro i
      obtain ⟨j, _, he⟩ := Finset.mem_map.mp i.property
      exact ⟨j, Subtype.ext he⟩)

private noncomputable def wordsPartitionEquiv {Group Width : Type*} [Fintype Group] [Fintype Width]
    (coords : (Group × Width) ↪ Fin n) (m : ℕ) :
    (Fin m → ↥(Finset.univ.map coords) → Bool) ≃ (Group → Fin m → Width → Bool) where
  toFun words group item w := words item (ownerImageEquiv coords (group, w))
  invFun data item owner :=
    data ((ownerImageEquiv coords).symm owner).1 item ((ownerImageEquiv coords).symm owner).2
  left_inv := by intro words; funext item owner; simp
  right_inv := by intro data; funext group item w; simp

def groupedWords {Group Width : Type*} (coords : (Group × Width) ↪ Fin n)
    (bits : BitProfile n m) (group : Group) (item : Fin m) (coord : Width) : Bool :=
  bits (coords (group, coord), item)

theorem groupedWords_uniform {Group Width : Type*} [Fintype Group] [DecidableEq Group]
    [Fintype Width] [DecidableEq Width] (coords : (Group × Width) ↪ Fin n) (m : ℕ)
    (event : (Group → Fin m → Width → Bool) → Prop) :
    finiteProbability (fun bits : BitProfile n m => event (groupedWords coords bits)) =
      finiteProbability event := by
  let owners := Finset.univ.map coords
  let e := wordsPartitionEquiv coords m
  change finiteProbability (fun bits : BitProfile n m => (event ∘ e) (signature (profileTag bits) owners)) = _
  rw [projectedWords_uniform_probability owners m (event ∘ e), finiteProbability_comp_equiv]

theorem groupedWords_independent {Group Width : Type*} [Fintype Group] [DecidableEq Group]
    [Fintype Width] [DecidableEq Width] (coords : (Group × Width) ↪ Fin n) (m : ℕ)
    (event : Group → (Fin m → Width → Bool) → Prop) :
    finiteProbability (fun bits : BitProfile n m => ∀ group, event group (groupedWords coords bits group)) =
      ∏ group : Group, finiteProbability (event group) := by
  rw [groupedWords_uniform coords m (fun data => ∀ group, event group (data group)),
    finiteProbability_all_coordinate_events]

theorem groupedWords_none_le {Group Width : Type*} [Fintype Group] [DecidableEq Group]
    [Fintype Width] [DecidableEq Width] (coords : (Group × Width) ↪ Fin n) (m : ℕ)
    (event : Group → (Fin m → Width → Bool) → Prop) (p : ℝ)
    (hlower : ∀ group, p ≤ finiteProbability (event group)) :
    finiteProbability (fun bits : BitProfile n m => ∀ group, ¬ event group (groupedWords coords bits group)) ≤
      (1 - p) ^ Fintype.card Group := by
  rw [groupedWords_independent coords m (fun group data => ¬ event group data), ← Finset.card_univ, ← Finset.prod_const]
  apply Finset.prod_le_prod
  · intro group _
    unfold finiteProbability
    positivity
  · intro group _
    rw [finiteProbability_not]
    exact sub_le_sub_left (hlower group) _

theorem oddBinCount_relabel {Item Label Target : Type*} [Fintype Item]
    [Fintype Label] [DecidableEq Label] [Fintype Target] [DecidableEq Target]
    (bins : Item → Label) (e : Label ≃ Target) :
    oddBinCount (e ∘ bins) = oddBinCount bins := by
  unfold oddBinCount
  symm
  apply Fintype.sum_equiv e
  intro label
  simp [binOccupancy, e.injective.eq_iff]

/-- All complete size-\(s\) blocks of consecutive coordinates, with the final short block omitted. -/
def disjointCoordinateBlocks (n s : ℕ) : (Fin (n / s) × Fin s) ↪ Fin n :=
  finProdFinEquiv.toEmbedding.trans (Fin.castLEEmb (Nat.div_mul_le_self n s))

end TwoColorNullity.Occupancy
