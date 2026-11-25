import Mathlib.Algebra.Order.Floor.Div
import Mathlib.Data.Fintype.EquivFin
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Fintype.Sum
import Mathlib.Logic.Equiv.Fin.Basic

namespace TwoColorNullity

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

/-- Each load lies between the floor and ceiling of the average. -/
theorem balanced_owners (Item Owner : Type*) [Fintype Item] [Fintype Owner] [DecidableEq Owner]
    (howners : 0 < Fintype.card Owner) :
    ∃ assign : Item → Owner, ∀ i : Owner,
      Fintype.card Item / Fintype.card Owner ≤ Fintype.card {item // assign item = i} ∧
      Fintype.card {item // assign item = i} ≤ Fintype.card Item ⌈/⌉ Fintype.card Owner := by
  classical
  let items := Fintype.card Item
  let owners := Fintype.card Owner
  let rounds := items / owners
  let remainder := items % owners
  have hrem : remainder < owners := Nat.mod_lt _ howners
  let slots : Item ≃ ((Fin rounds × Fin owners) ⊕ Fin remainder) :=
    (Fintype.equivFin Item).trans ((finCongr (Nat.div_add_mod' items owners).symm).trans
      (finSumFinEquiv.symm.trans (Equiv.sumCongr finProdFinEquiv.symm (Equiv.refl _))))
  let index := Fintype.equivFin Owner
  let assign (item : Item) : Owner := index.symm (slotOwner hrem (slots item))
  refine ⟨assign, ?_⟩
  intro i
  have hload : Fintype.card {item // assign item = i} =
      rounds + if (index i).val < remainder then 1 else 0 := by
    rw [← slotOwner_count hrem (index i)]
    exact Fintype.card_congr (slots.subtypeEquiv fun item => by
      change index.symm (slotOwner hrem (slots item)) = i ↔ slotOwner hrem (slots item) = index i
      simp [Equiv.symm_apply_eq])
  change rounds ≤ Fintype.card {item // assign item = i} ∧
    Fintype.card {item // assign item = i} ≤ items ⌈/⌉ owners
  rw [hload]
  by_cases hi : (index i).val < remainder
  · rw [if_pos hi]
    exact ⟨by omega, extra_round_le items owners howners (by dsimp [remainder] at hi; omega)⟩
  · simp only [if_neg hi, Nat.add_zero, le_refl, true_and]
    simpa [rounds] using (floorDiv_le_ceilDiv (a := owners) (b := items))

end TwoColorNullity
