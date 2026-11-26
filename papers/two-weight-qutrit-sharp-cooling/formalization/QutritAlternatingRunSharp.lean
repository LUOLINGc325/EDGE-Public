import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum
import Mathlib.Data.Real.Sqrt

namespace TwoWeightQutritSharpCoolingResearchProof1

theorem alternating_run_bound (A B u v : ℝ) (hA : 0<A) (hB : 0<B) : 2*Real.sqrt (A*B)*|u*v| ≤ A*u^2+B*v^2 := by
  have heq : (Real.sqrt A * |u| - Real.sqrt B * |v|)^2 =
      A*u^2+B*v^2 - 2*Real.sqrt (A*B)*|u*v| := by
    calc
      _ = (Real.sqrt A)^2 * |u|^2 + (Real.sqrt B)^2 * |v|^2 -
          2 * (Real.sqrt A * Real.sqrt B) * (|u| * |v|) := by ring
      _ = _ := by rw [Real.sq_sqrt hA.le, Real.sq_sqrt hB.le, sq_abs, sq_abs,
        ← Real.sqrt_mul hA.le, ← abs_mul]
  linarith only [heq, sq_nonneg (Real.sqrt A * |u| - Real.sqrt B * |v|)]

end TwoWeightQutritSharpCoolingResearchProof1
