import BalancedAllocation
import Mathlib.Data.Finset.Sort

namespace TwoColorNullity.Occupancy

/-- Each full round supplies one slot to every owner. The remainder uses an initial segment. -/
private def slotOwner {rounds owners remainder : ℕ} (hr : remainder < owners) :
    (Fin rounds × Fin owners) ⊕ Fin remainder → Fin owners :=
  Sum.elim Prod.snd fun slot => ⟨slot.val, slot.isLt.trans hr⟩

private theorem slotOwner_count {rounds owners remainder : ℕ} (hr : remainder < owners)
    (i : Fin owners) :
    Fintype.card {slot : (Fin rounds × Fin owners) ⊕ Fin remainder // slotOwner hr slot = i} =
      rounds + if i.val < remainder then 1 else 0 := by
  classical
  let main : {slot : Fin rounds × Fin owners // slot.2 = i} ≃ Fin rounds := {
    toFun := fun slot => slot.val.1
    invFun := fun round => ⟨(round, i), rfl⟩
    left_inv := by rintro ⟨⟨round, j⟩, h⟩; cases h; rfl
    right_inv := fun _ => rfl
  }
  rw [Fintype.card_congr Equiv.subtypeSum, Fintype.card_sum]
  change Fintype.card {slot : Fin rounds × Fin owners // slot.2 = i} +
    Fintype.card {slot : Fin remainder // (⟨slot.val, slot.isLt.trans hr⟩ : Fin owners) = i} = _
  rw [Fintype.card_congr main, Fintype.card_fin]
  by_cases hi : i.val < remainder
  · have eq_slot (slot : Fin remainder) :
        (⟨slot.val, slot.isLt.trans hr⟩ : Fin owners) = i ↔ slot = ⟨i.val, hi⟩ := by
      constructor
      · exact fun he => Fin.ext (congrArg (fun x : Fin owners => x.val) he)
      · exact fun he => Fin.ext (congrArg (fun x : Fin remainder => x.val) he)
    rw [Fintype.card_congr (Equiv.subtypeEquivRight eq_slot), Fintype.card_subtype_eq, if_pos hi]
  · let noSlot : IsEmpty {slot : Fin remainder //
        (⟨slot.val, slot.isLt.trans hr⟩ : Fin owners) = i} :=
      ⟨fun ⟨slot, h⟩ => hi (congrArg Fin.val h ▸ slot.isLt)⟩
    rw [Fintype.card_eq_zero_iff.mpr noSlot, if_neg hi]

private theorem extra_round_le (items owners : ℕ) (howners : 0 < owners) (hrem : items % owners ≠ 0) :
    items / owners + 1 ≤ items ⌈/⌉ owners := by
  have hcoverage : items ≤ owners * (items ⌈/⌉ owners) := (ceilDiv_le_iff_le_mul howners).mp le_rfl
  by_contra hbad
  have hfloor : items ⌈/⌉ owners ≤ items / owners := by omega
  have hle := hcoverage.trans (Nat.mul_le_mul_left owners hfloor)
  have htotal := Nat.div_add_mod items owners
  omega

private def roundRobinSlots {Item : Type*} [LinearOrder Item] (available : Finset Item) (owners : ℕ) :
    ↥available ≃ ((Fin (available.card / owners) × Fin owners) ⊕ Fin (available.card % owners)) :=
  (available.orderIsoOfFin rfl).symm.toEquiv.trans
    ((finCongr (Nat.div_add_mod' available.card owners).symm).trans
      (finSumFinEquiv.symm.trans (Equiv.sumCongr finProdFinEquiv.symm (Equiv.refl _))))

/-- Traverse the remaining chores and owners in increasing order. Each completed round serves all owners. -/
def roundRobin {Item Owner : Type*} [LinearOrder Item] [LinearOrder Owner]
    (available : Finset Item) (owners : Finset Owner) (howners : 0 < owners.card)
    (item : ↥available) : ↥owners :=
  owners.orderIsoOfFin rfl (slotOwner (Nat.mod_lt _ howners) (roundRobinSlots available owners.card item))

theorem roundRobin_load {Item Owner : Type*} [LinearOrder Item] [LinearOrder Owner]
    (available : Finset Item) (owners : Finset Owner) (howners : 0 < owners.card) (i : ↥owners) :
    available.card / owners.card ≤ Fintype.card {item : ↥available // roundRobin available owners howners item = i} ∧
      Fintype.card {item : ↥available // roundRobin available owners howners item = i} ≤
        available.card ⌈/⌉ owners.card := by
  let items := available.card
  let ownerCount := owners.card
  let rounds := items / ownerCount
  let remainder := items % ownerCount
  have hrem : remainder < ownerCount := Nat.mod_lt _ howners
  let slots := roundRobinSlots available ownerCount
  let index := (owners.orderIsoOfFin rfl).symm.toEquiv
  have hload : Fintype.card {item // roundRobin available owners howners item = i} =
      rounds + if (index i).val < remainder then 1 else 0 := by
    rw [← slotOwner_count hrem (index i)]
    exact Fintype.card_congr (slots.subtypeEquiv fun item => by
      change index.symm (slotOwner hrem (slots item)) = i ↔ slotOwner hrem (slots item) = index i
      simp [Equiv.symm_apply_eq])
  change rounds ≤ Fintype.card {item : ↥available // roundRobin available owners howners item = i} ∧
    Fintype.card {item : ↥available // roundRobin available owners howners item = i} ≤ items ⌈/⌉ ownerCount
  rw [hload]
  by_cases hi : (index i).val < remainder
  · rw [if_pos hi]
    exact ⟨by omega, extra_round_le items ownerCount howners (by dsimp [remainder] at hi; omega)⟩
  · simp only [if_neg hi, Nat.add_zero, le_refl, true_and]
    simpa [rounds] using (floorDiv_le_ceilDiv (a := ownerCount) (b := items))

end TwoColorNullity.Occupancy
