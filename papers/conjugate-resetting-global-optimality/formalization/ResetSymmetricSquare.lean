import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace ConjugateResettingGlobalOptimalityResearchProof1

theorem reset_symmetric_square (fx fy gx gy : ℝ) (hx : 0 < fx) (hy : 0 < fy) :
    (gx^2*(fy/fx)+gy^2*(fx/fy))/2 = gx*gy+(gx*fy-gy*fx)^2/(2*fx*fy) := by
  have hfx : fx ≠ 0 := ne_of_gt hx
  have hfy : fy ≠ 0 := ne_of_gt hy
  field_simp
  ring

end ConjugateResettingGlobalOptimalityResearchProof1
