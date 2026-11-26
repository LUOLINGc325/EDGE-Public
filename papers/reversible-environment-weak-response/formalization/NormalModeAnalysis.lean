import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Tactic.Ring

namespace ReversibleMarkovWeakResponse

/-- A normal mode's real resolvent coefficient. -/
noncomputable def normalModeResponse (a b x : ℝ) : ℝ :=
  (a + x) / ((a + x)^2 + b^2)

/-- Derivative of the scalar coefficient for a transverse normal mode. -/
theorem normal_mode_hasDerivAt (a b x : ℝ) (hx : 0 < a + x) :
    HasDerivAt (normalModeResponse a b)
      ((b^2 - (a + x)^2) / (((a + x)^2 + b^2)^2)) x := by
  have hlinear : HasDerivAt (fun y : ℝ => a + y) 1 x :=
    (hasDerivAt_id x).const_add a
  have hsquare : HasDerivAt (fun y : ℝ => (a + y)^2) (2 * (a + x)) x := by
    simpa using hlinear.pow 2
  have hden : HasDerivAt (fun y : ℝ => (a + y)^2 + b^2) (2 * (a + x)) x :=
    hsquare.add_const (b^2)
  have hpos : 0 < (a + x)^2 + b^2 :=
    add_pos_of_pos_of_nonneg (pow_pos hx _) (sq_nonneg b)
  unfold normalModeResponse
  convert hlinear.div hden hpos.ne' using 1
  ring

end ReversibleMarkovWeakResponse
