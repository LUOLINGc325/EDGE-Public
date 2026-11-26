import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.Calculus.Deriv.Mul

universe u
namespace WeightedBernoulliEntropyCurvatureResearchProof1

theorem loss_asymmetry_derivative (z : ℝ) (hz : 0 < z) :
         HasDerivAt (fun w : ℝ => Real.log (1+w)-w*Real.log (1+1/w))
           (2/(1+z)-Real.log (1+1/z)) z := by
  have hzn := ne_of_gt hz
  have hpos : 0 < 1+z := by linarith only [hz]
  have hinv : 0 < 1+z⁻¹ := by positivity
  have hid : HasDerivAt (fun w : ℝ => w) 1 z := hasDerivAt_id z
  have hlin : HasDerivAt (fun w : ℝ => 1+w) 1 z := by
    simpa using (hasDerivAt_const z (1:ℝ)).add hid
  have hinvlin : HasDerivAt (fun w : ℝ => 1+w⁻¹) (-(z^2)⁻¹) z := by
    simpa using (hasDerivAt_const z (1:ℝ)).add (hasDerivAt_inv hzn)
  have hlog := hlin.log (ne_of_gt hpos)
  have hloginv := hinvlin.log (ne_of_gt hinv)
  have hd := hlog.sub (hid.mul hloginv)
  convert hd using 1
  · ext w
    simp [one_div]
  · simp only [one_div, one_mul]
    field_simp [hzn, ne_of_gt hpos, ne_of_gt hinv]
    ring

end WeightedBernoulliEntropyCurvatureResearchProof1
