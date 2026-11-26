import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Add

universe u
namespace CiScoreQuadraticRigidityResearchProof1

theorem binary_curvature_derivatives (l s r : ℝ) :
         HasDerivAt (fun t : ℝ => l*t*(1-t)-s*t^2*(1-t)^2)
           (l*(1-2*r)-2*s*r*(1-r)*(1-2*r)) r ∧
         HasDerivAt (fun t : ℝ => l*(1-2*t)-2*s*t*(1-t)*(1-2*t))
           (-2*l-2*s+12*s*r*(1-r)) r := by
  have hid : HasDerivAt (fun t : ℝ => t) 1 r := hasDerivAt_id r
  have h1minus : HasDerivAt (fun t : ℝ => 1-t) (-1) r := by
    simpa using HasDerivAt.sub (hasDerivAt_const r (1:ℝ)) hid
  have h1minus2 : HasDerivAt (fun t : ℝ => 1-2*t) (-2) r := by
    simpa using HasDerivAt.sub (hasDerivAt_const r (1:ℝ)) (hid.const_mul 2)
  have hfirst := (hid.mul h1minus).const_mul l
  have hsecond := ((hid.pow 2).mul (h1minus.pow 2)).const_mul s
  have hderiv1 := HasDerivAt.sub hfirst hsecond
  have hrepeated := ((hid.mul h1minus).mul h1minus2).const_mul (2*s)
  have hderiv2 := HasDerivAt.sub (h1minus2.const_mul l) hrepeated
  constructor
  · convert hderiv1 using 1
    all_goals first | funext t; ring | ring
  · convert hderiv2 using 1
    all_goals first | funext t; ring | ring

end CiScoreQuadraticRigidityResearchProof1
