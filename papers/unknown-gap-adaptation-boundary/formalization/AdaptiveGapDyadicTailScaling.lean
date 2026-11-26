import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Topology.Algebra.InfiniteSum.Real
import Mathlib.Topology.Algebra.InfiniteSum.Ring

namespace UnknownGapAdaptationBoundaryResearchProof2

theorem dyadic_tail_scaling (delta : ℝ) (f : ℕ → ℝ)
         (hdelta : 0 < delta) (hs : Summable f)
         (hb : (∑' k, f k) ≤ (Real.exp 1-2)⁻¹) :
         (∑' k, (8/delta^2)*f k) ≤ 8/((Real.exp 1-2)*delta^2) := by
  rw [hs.tsum_mul_left]
  calc
    (8/delta^2)*(∑' k, f k) ≤ (8/delta^2)*(Real.exp 1-2)⁻¹ :=
      mul_le_mul_of_nonneg_left hb (by positivity)
    _ = 8/((Real.exp 1-2)*delta^2) := by
      have he : Real.exp 1 - 2 ≠ 0 := by
        linarith [Real.add_one_lt_exp (one_ne_zero : (1 : ℝ) ≠ 0)]
      field_simp [he, hdelta.ne']
      exact mul_comm _ _

end UnknownGapAdaptationBoundaryResearchProof2
