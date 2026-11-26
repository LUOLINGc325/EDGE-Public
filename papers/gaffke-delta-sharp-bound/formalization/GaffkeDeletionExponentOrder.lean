import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Analysis.SpecialFunctions.Pow.Real

namespace GaffkeDeltaSharpBoundResearchProof1

/-- Scalar comparison underlying inequality (2) of the manuscript.

If `r+1 ≤ n` with `0 < n` and `0 < D ≤ 1`, then
`D^(1 - 1/n) ≤ D^(r/(r+1))`.  Since `1/(r+1) ≤ 1/n`, the exponent
`1 - 1/n = 1 - 1/n` is at most `1 - 1/(r+1) = r/(r+1)`; because `D ≤ 1`,
`Real.rpow_le_rpow_of_exponent_le` gives the claim. -/
theorem deletion_exponent_order (D : ℝ) (r n : ℕ)
    (hD : 0 < D) (hD1 : D ≤ 1) (hn : 0 < n) (hr : r+1 ≤ n) :
    Real.rpow D (1-1/(n : ℝ)) ≤ Real.rpow D ((r : ℝ)/(r+1)) := by
  have hrle : (r : ℝ) + 1 ≤ (n : ℝ) := by exact_mod_cast hr
  have hn' : 0 < (n : ℝ) := Nat.cast_pos.mpr hn
  have hr' : 0 < (r : ℝ) + 1 := by positivity
  have hinv : 1/(n : ℝ) ≤ 1/((r : ℝ)+1) := one_div_le_one_div_of_le hr' hrle
  apply Real.rpow_le_rpow_of_exponent_ge hD hD1
  calc ((r : ℝ)/((r : ℝ)+1)) = 1-1/((r : ℝ)+1) := by field_simp
    _ ≤ 1-1/(n : ℝ) := sub_le_sub_left hinv 1

end GaffkeDeltaSharpBoundResearchProof1
