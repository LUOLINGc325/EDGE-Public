import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace DelayedNewtonPreparation

open Filter Set
open scoped Topology

/-- Initial two pieces of the delayed response in Section 2. -/
noncomputable def firstTwoDelayPieces (tau t : ℝ) : ℝ :=
  if t < 0 then 0 else if t ≤ tau then 1 else 1+tau-t

/-- The equation on the first open delay interval. -/
theorem first_delay_equation (tau t : ℝ) (ht0 : 0 < t) (htt : t < tau) :
    HasDerivAt (firstTwoDelayPieces tau) (-firstTwoDelayPieces tau (t-tau)) t := by
  have localEq : firstTwoDelayPieces tau =ᶠ[𝓝 t] (fun _ => (1:ℝ)) := by
    filter_upwards [Ioo_mem_nhds ht0 htt] with y hy
    simp [firstTwoDelayPieces, not_lt.mpr hy.1.le, hy.2.le]
  have d := (hasDerivAt_const t (1:ℝ)).congr_of_eventuallyEq localEq
  have lag : firstTwoDelayPieces tau (t-tau) = 0 := by
    simp [firstTwoDelayPieces, sub_neg.mpr htt]
  simpa [lag] using d

/-- The same equation on the second open delay interval. -/
theorem second_delay_equation (tau t : ℝ) (htau : 0 < tau) (hleft : tau < t)
    (hright : t < 2*tau) :
    HasDerivAt (firstTwoDelayPieces tau) (-firstTwoDelayPieces tau (t-tau)) t := by
  have localEq : firstTwoDelayPieces tau =ᶠ[𝓝 t] (fun y => 1+tau-y) := by
    filter_upwards [Ioi_mem_nhds hleft] with y hy
    have hylt : tau < y := hy
    have hypos : 0 < y := htau.trans hylt
    simp [firstTwoDelayPieces, not_lt.mpr hypos.le, not_le.mpr hylt]
  have d : HasDerivAt (fun y : ℝ => 1+tau-y) (-1) t := by
    simpa using (hasDerivAt_const t (1+tau)).sub (hasDerivAt_id' t)
  have hLag : t-tau ≤ tau := by linarith
  have lag : firstTwoDelayPieces tau (t-tau) = 1 := by
    simp [firstTwoDelayPieces, not_lt.mpr (sub_nonneg.mpr hleft.le), hLag]
  simpa [lag] using d.congr_of_eventuallyEq localEq

end DelayedNewtonPreparation
