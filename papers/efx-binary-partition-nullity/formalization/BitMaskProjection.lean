import Mathlib.Data.Finset.Card
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Nat.Bitwise

namespace TwoColorNullity

def maskCoordinates (n mask : ℕ) : Finset (Fin n) :=
  Finset.univ.filter fun i => mask.testBit i.val = true

@[simp] theorem mem_maskCoordinates {n mask : ℕ} {i : Fin n} :
    i ∈ maskCoordinates n mask ↔ mask.testBit i.val = true := by
  simp [maskCoordinates]

end TwoColorNullity
