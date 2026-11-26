import IndependentCoordinateGroups

namespace TwoColorNullity.Occupancy

def coordinateSlice {Group Width : Type*} (coords : (Group × Width) ↪ Fin n) (group : Group) :
    Width ↪ Fin n :=
  ⟨fun w => coords (group, w), fun _ _ he => congrArg Prod.snd (coords.injective he)⟩

def blockOwners {Group Width : Type*} [Fintype Width] (coords : (Group × Width) ↪ Fin n)
    (group : Group) : Finset (Fin n) :=
  Finset.univ.map (coordinateSlice coords group)

@[simp] theorem blockOwners_card {Group Width : Type*} [Fintype Width]
    (coords : (Group × Width) ↪ Fin n) (group : Group) :
    (blockOwners coords group).card = Fintype.card Width := by simp [blockOwners]

theorem block_occupancy_exact {Group Width : Type*} [Fintype Width] [DecidableEq Width]
    (coords : (Group × Width) ↪ Fin n) (bits : BitProfile n m) (group : Group) :
    oddBinCount (groupedWords coords bits group) =
      oddBinCount (signature (profileTag bits) (blockOwners coords group)) := by
  classical
  let e : (↥(blockOwners coords group) → Bool) ≃ (Width → Bool) :=
    Equiv.arrowCongr (ownerImageEquiv (coordinateSlice coords group)).symm (Equiv.refl Bool)
  have heq : (e ∘ signature (profileTag bits) (blockOwners coords group)) = groupedWords coords bits group := by
    funext item w
    change signature (profileTag bits) (blockOwners coords group) item
      ((ownerImageEquiv (coordinateSlice coords group)).symm.symm w) = _
    rw [Equiv.symm_symm]
    rfl
  rw [← heq, oddBinCount_relabel]

theorem binary_words_occupancy_uniform (s m : ℕ) (threshold : ℕ) :
    finiteProbability (fun data : Fin m → (Fin s → Bool) => oddBinCount data ≤ threshold) =
      finiteProbability (fun data : Fin m → Fin (2 ^ s) => oddBinCount data ≤ threshold) := by
  classical
  let e : (Fin s → Bool) ≃ Fin (2 ^ s) :=
    (Fintype.equivFin _).trans (finCongr (by simp))
  let profiles := Equiv.arrowCongr (Equiv.refl (Fin m)) e
  have hdata (data : Fin m → (Fin s → Bool)) :
      oddBinCount (profiles data) = oddBinCount data :=
    oddBinCount_relabel data e
  let good (data : Fin m → Fin (2 ^ s)) : Prop := oddBinCount data ≤ threshold
  have h : (fun data : Fin m → (Fin s → Bool) => oddBinCount data ≤ threshold) =
      good ∘ profiles := by
    funext data
    change (oddBinCount data ≤ threshold) = (oddBinCount (profiles data) ≤ threshold)
    rw [hdata]
  rw [h, finiteProbability_comp_equiv]

/-- A failed global feasibility test forces all the disjoint groups to fail. -/
theorem probability_sStar_below_from_independent_blocks (n s : ℕ) (hpos : 0 < s) (hlt : s < n) (p : ℝ)
    (hp : p ≤ finiteProbability (fun draws : Fin (3 * n - 1) → Fin (2 ^ s) =>
      oddBinCount draws ≤ n + 2 * s - 1)) :
    finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      maximumFeasibleOwners (profileTag bits) < s) ≤ (1 - p) ^ (n / s) := by
  let coords := disjointCoordinateBlocks n s
  let good (_ : Fin (n / s)) (data : Fin (3 * n - 1) → (Fin s → Bool)) :=
    oddBinCount data ≤ n + 2 * s - 1
  have hblock :
      finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
          maximumFeasibleOwners (profileTag bits) < s) ≤
        finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
          ∀ group, ¬ good group (groupedWords coords bits group)) := by
    apply finiteProbability_mono
    intro bits hbad group hgood
    let owners := blockOwners coords group
    have hsize : owners.card = s := by simp [owners]
    have hcut : oddBinCount (signature (profileTag bits) owners) ≤ n + 2 * owners.card - 1 := by
      rw [hsize, ← block_occupancy_exact coords bits group]
      exact hgood
    have hf := (fixed_items_feasible_iff_odd (profileTag bits) owners (by omega) (by omega)).mpr hcut
    have hm := hf.le_maximum
    omega
  have h := groupedWords_none_le coords (3 * n - 1) good p (fun i => by
    unfold good
    rw [binary_words_occupancy_uniform]
    exact hp)
  simpa only [Fintype.card_fin] using hblock.trans h

end TwoColorNullity.Occupancy
