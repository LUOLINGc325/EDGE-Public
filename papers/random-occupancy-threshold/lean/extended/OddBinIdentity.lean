import BucketAllocation
import InstanceBounds

open scoped BigOperators

namespace TwoColorNullity.Occupancy

variable {Item Label : Type*} [Fintype Item] [Fintype Label] [DecidableEq Label]

/-- Number of items in a projection bin. -/
def binOccupancy (bins : Item → Label) (label : Label) : ℕ :=
  (Finset.univ.filter fun item => bins item = label).card

/-- Number of projection bins with odd occupancy. -/
def oddBinCount (bins : Item → Label) : ℕ :=
  ∑ label : Label, binOccupancy bins label % 2

theorem sum_binOccupancy (bins : Item → Label) :
    ∑ label : Label, binOccupancy bins label = Fintype.card Item := by
  simpa [binOccupancy] using
    (Finset.card_eq_sum_card_fiberwise (s := (Finset.univ : Finset Item))
      (t := (Finset.univ : Finset Label)) (f := bins) (fun _ _ => Finset.mem_univ _)).symm

theorem oddBinCount_eq_card (bins : Item → Label) :
    oddBinCount bins = (Finset.univ.filter fun label => binOccupancy bins label % 2 = 1).card := by
  unfold oddBinCount
  calc
    _ = ∑ label : Label, (if binOccupancy bins label % 2 = 1 then 1 else 0 : ℕ) := by
      apply Finset.sum_congr rfl
      intro label _
      split <;> omega
    _ = _ := by
      exact_mod_cast (Finset.sum_boole (R := ℕ) (fun label => binOccupancy bins label % 2 = 1) Finset.univ)

theorem twice_pairCapacity_add_odd (bins : Item → Label) :
    2 * projectedPairCount bins Finset.univ + oddBinCount bins = Fintype.card Item := by
  rw [← sum_binOccupancy bins]
  unfold projectedPairCount oddBinCount
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro label _
  change 2 * (binOccupancy bins label / 2) + binOccupancy bins label % 2 = binOccupancy bins label
  exact Nat.div_add_mod (binOccupancy bins label) 2

theorem projectedPairCount_eq_half_sub_odd (bins : Item → Label) :
    projectedPairCount bins Finset.univ = (Fintype.card Item - oddBinCount bins) / 2 := by
  have h := twice_pairCapacity_add_odd bins
  omega

theorem oddBinCount_le_labels (bins : Item → Label) :
    oddBinCount bins ≤ Fintype.card Label := by
  rw [oddBinCount_eq_card]
  exact Finset.card_le_univ _

theorem fixed_items_feasible_iff_odd (tag : Fin n → Fin (3 * n - 1) → Bool)
    (owners : Finset (Fin n)) (hpos : 0 < owners.card) (hlt : owners.card < n) :
    FeasibleOwners tag owners ↔
      oddBinCount (signature tag owners) ≤ n + 2 * owners.card - 1 := by
  classical
  have identity := twice_pairCapacity_add_odd (signature tag owners)
  have hi : 2 * pairCapacity tag owners + oddBinCount (signature tag owners) = 3 * n - 1 := by
    simpa [pairCapacity] using identity
  unfold FeasibleOwners
  constructor
  · intro h
    have h' := h.2.2
    omega
  · intro h
    exact ⟨hpos, hlt, by omega⟩

end TwoColorNullity.Occupancy
