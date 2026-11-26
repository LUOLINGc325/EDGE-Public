import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

universe u
namespace CommonLawLqrAffineBoundaryResearchProof1

theorem affine_stage_square_gap (t x v a : ℝ) (ht : 0 < t) (hx : 0 < x) (hv : 0 < v) :
         x*(1-a)^2+(v/t)*a^2-x*v/(v+t*x) = (x+v/t)*(a-t*x/(v+t*x))^2 := by
  have hs : 0 < v + t*x := by positivity
  field_simp [ne_of_gt ht, ne_of_gt hs]
  ring

end CommonLawLqrAffineBoundaryResearchProof1
