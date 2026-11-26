import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Data.Matrix.Notation
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

namespace StroboscopicThreeStateEntropyRangeResearchProof1

/-- Literal three-state characteristic determinant (19) for `vI - Q(x,y,z,c)`,
where `Q(x,y,z,c)` is the matrix of (18). No rate conditions, no exponential,
no entropy-sector claims. -/
theorem generator_characteristic_polynomial (x y z c v : ℝ) :
         Matrix.det (!![v+x+z, -(x+c), -(z-c); -(x-c), v+x+y, -(y+c); -(z+c), -(y-c), v+y+z] : Matrix (Fin 3) (Fin 3) ℝ)
         = v*((v+x+y+z)^2-(x^2+y^2+z^2-x*y-y*z-z*x)+3*c^2) := by
  rw [Matrix.det_fin_three]
  simp only [Matrix.of_apply, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons]
  ring

end StroboscopicThreeStateEntropyRangeResearchProof1
