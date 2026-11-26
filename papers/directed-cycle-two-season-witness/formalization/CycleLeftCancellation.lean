import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace DirectedCycleTwoSeasonWitnessResearchProof1

/-- Exact component cancellation for the left Perron vector `ℓ_i(v) = (w_i / v_{i-1}) / s`
with `w_i = 1 / a_{i-1}`, as in equation (1) of the manuscript.  The `i`-th component
of `ℓ(v)ᵀ A(v)` is `-a_{i-1}(v_{i-1}/v_i) ℓ_i(v) + a_i ℓ_{i+1}(v)`, and the two terms
cancel because `ℓ_i(v) = 1/(a_{i-1} v_{i-1} s)` and `ℓ_{i+1}(v) = 1/(a_i v_i s)`. -/
theorem left_row_cancellation (aPrev a vPrev v s : ℝ) (haPrev : 0 < aPrev) (ha : 0 < a)
    (hvPrev : 0 < vPrev) (hv : 0 < v) (hs : 0 < s) :
    -(aPrev * (vPrev / v)) * ((1 / aPrev / vPrev) / s) + a * ((1 / a / v) / s) = 0 := by
  have haPrev' : aPrev ≠ 0 := ne_of_gt haPrev
  have ha' : a ≠ 0 := ne_of_gt ha
  have hvPrev' : vPrev ≠ 0 := ne_of_gt hvPrev
  have hv' : v ≠ 0 := ne_of_gt hv
  have hs' : s ≠ 0 := ne_of_gt hs
  field_simp
  ring

end DirectedCycleTwoSeasonWitnessResearchProof1
