import FeasibilityIndependentBlocks
import FiniteBoundedDifferences

namespace TwoColorNullity.Occupancy

theorem owner_occupancy_law (owners : Finset (Fin n)) (m : ℕ) (event : ℕ → Prop) :
    finiteProbability (fun bits : BitProfile n m => event (oddBinCount (signature (profileTag bits) owners))) =
      finiteProbability (fun draws : Fin m → Fin (2 ^ owners.card) => event (oddBinCount draws)) := by
  classical
  let e : (↥owners → Bool) ≃ Fin (2 ^ owners.card) :=
    (Fintype.equivFin _).trans (finCongr (by simp))
  let h := Equiv.arrowCongr (Equiv.refl (Fin m)) e
  let graded (draws : Fin m → Fin (2 ^ owners.card)) := event (oddBinCount draws)
  rw [projectedWords_uniform_probability owners m (fun draws => event (oddBinCount draws))]
  have heq : (fun draws : Fin m → (↥owners → Bool) => event (oddBinCount draws)) = graded ∘ h := by
    funext draws
    change event (oddBinCount draws) = event (oddBinCount (e ∘ draws))
    rw [oddBinCount_relabel]
  rw [heq, finiteProbability_comp_equiv]

theorem owner_feasibility_law (n : ℕ) (owners : Finset (Fin n))
    (hpos : 0 < owners.card) (hsize : owners.card < n) :
    finiteProbability (fun bits : BitProfile n (3 * n - 1) => FeasibleOwners (profileTag bits) owners) =
      finiteProbability (fun draws : Fin (3 * n - 1) → Fin (2 ^ owners.card) =>
        oddBinCount draws ≤ n + 2 * owners.card - 1) := by
  have hf :
      (fun bits : BitProfile n (3 * n - 1) => FeasibleOwners (profileTag bits) owners) =
      (fun bits : BitProfile n (3 * n - 1) =>
        oddBinCount (signature (profileTag bits) owners) ≤ n + 2 * owners.card - 1) :=
    funext fun bits => propext (fixed_items_feasible_iff_odd (profileTag bits) owners hpos hsize)
  rw [hf]
  exact owner_occupancy_law owners (3 * n - 1) (fun count => count ≤ n + 2 * owners.card - 1)

/-- Fixed-group feasibility bounded by a downward deviation from its mean. -/
theorem owner_feasibility_tail (n : ℕ) (owners : Finset (Fin n)) (hpos : 0 < owners.card) (hsize : owners.card < n)
    (gap : ℝ) (hgap : 0 ≤ gap)
    (hmean : ((n + 2 * owners.card - 1 : ℕ) : ℝ) + gap ≤
      finiteMean (fun draws : Fin (3 * n - 1) → Fin (2 ^ owners.card) => (oddBinCount draws : ℝ))) :
    finiteProbability (fun bits : BitProfile n (3 * n - 1) => FeasibleOwners (profileTag bits) owners) ≤
      Real.exp (-(gap ^ 2) / (2 * ((3 * n - 1 : ℕ) : ℝ))) := by
  let m := 3 * n - 1
  let k := 2 ^ owners.card
  letI : NeZero k := ⟨by dsimp [k]; positivity⟩
  let f (draws : Fin m → Fin k) := (oddBinCount draws : ℝ)
  rw [owner_feasibility_law n owners hpos hsize]
  refine (finiteProbability_mono (fun draws h => ?_)).trans
    (finiteMean_boundedDifferences_lowerTail m f oddBinCount_bounded_difference gap hgap)
  have hcast : (oddBinCount draws : ℝ) ≤ ((n + 2 * owners.card - 1 : ℕ) : ℝ) := by exact_mod_cast h
  change gap ≤ -(f draws - finiteMean f)
  change f draws ≤ ((n + 2 * owners.card - 1 : ℕ) : ℝ) at hcast
  change ((n + 2 * owners.card - 1 : ℕ) : ℝ) + gap ≤ finiteMean f at hmean
  linarith only [hmean, hcast]

end TwoColorNullity.Occupancy
