import Mathlib.Analysis.MeanInequalitiesPow
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

namespace EuclideanMedianAllPSharpResearchProof1

/-- Power-difference inequality used in Lemma 1 (equation R6) of the manuscript:
for real `p ≥ 1` and `0 ≤ v ≤ u`, we have `(u - v)^p ≤ u^p - v^p`.

The `v = 0` case is covered: then the claim reduces to `u^p ≤ u^p`.
The case `u = v` is covered: then `(u-v)^p = 0 ≤ u^p - v^p` since `x^p` is
monotone on nonnegative reals. -/
theorem radial_power_gap (u v p : ℝ) (hv : 0 ≤ v) (hvu : v ≤ u) (hp : 1 ≤ p) :
    (u - v) ^ p ≤ u ^ p - v ^ p := by
  have h := Real.add_rpow_le_rpow_add (sub_nonneg.mpr hvu) hv hp
  rw [sub_add_cancel] at h
  exact le_sub_iff_add_le.mpr h

end EuclideanMedianAllPSharpResearchProof1
