import Mathlib.Logic.Function.Basic
import Mathlib.Tactic.Ring

namespace PreciseMergersWithoutSymmetry

open Function

variable {ι : Type*} [DecidableEq ι]
variable {R : Type*} [CommRing R]

/-- The paper's coordinate projection operator. -/
def Pi (i : ι) (F : (ι → R) → R) (x : ι → R) : R :=
  F x - (x i - 1) * (F (Function.update x i 2) - F (Function.update x i 1))

/-- The coordinate projection operators commute. -/
theorem Pi_comm (i j : ι) (hij : i ≠ j) (F : (ι → R) → R) (x : ι → R) :
    Pi i (Pi j F) x = Pi j (Pi i F) x := by
  simp only [Pi, Function.update_of_ne hij, Function.update_of_ne hij.symm,
    Function.update_comm hij]
  ring

end PreciseMergersWithoutSymmetry
