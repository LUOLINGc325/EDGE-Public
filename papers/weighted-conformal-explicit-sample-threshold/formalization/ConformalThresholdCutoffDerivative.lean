import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul

universe u
namespace WeightedConformalExplicitSampleThresholdResearchProof1

theorem weighted_cutoff_derivative (t B I h : ℝ) (hh : h < 1) :
         HasDerivAt (fun z : ℝ => (t*(1+(B-1)*z)-I*B*z)/(1-z))
           (B*(t-I)/(1-h)^2) h := by
  have hid : HasDerivAt (fun z : ℝ => z) 1 h := hasDerivAt_id h
  have h1 : HasDerivAt (fun z : ℝ => 1+(B-1)*z) (B-1) h := by
    simpa using HasDerivAt.add (hasDerivAt_const h (1:ℝ)) (hid.const_mul (B-1))
  have hnum := HasDerivAt.sub (h1.const_mul t) (hid.const_mul (I*B))
  have hden : HasDerivAt (fun z : ℝ => 1-z) (-1) h := by
    simpa using HasDerivAt.sub (hasDerivAt_const h (1:ℝ)) hid
  have hp : 0 < 1-h := sub_pos.mpr hh
  have hhderiv := HasDerivAt.div hnum hden (ne_of_gt hp)
  convert hhderiv using 1
  ring

end WeightedConformalExplicitSampleThresholdResearchProof1
