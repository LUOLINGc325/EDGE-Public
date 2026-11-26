import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

open scoped BigOperators

namespace ProcessingOracleTwoPhaseResearchProof1

theorem physical_suffix_rounding (x n q : ℝ) (hx : 2 ≤ x) (herr : |q-2*n/x| ≤ 1/2) : n*(n-q)+x*q^2/4 ≤ (1-1/x)*n^2+x/16 := by
  have hx0 : 0 < x := by linarith
  have hsq : (q - 2*n/x)^2 ≤ (1/2:ℝ)^2 := by
    exact sq_le_sq' (abs_le.mp herr).1 (abs_le.mp herr).2
  have hm := mul_le_mul_of_nonneg_left hsq (show 0 ≤ x/4 by positivity)
  have he :
      n*(n-q)+x*q^2/4 = (1-1/x)*n^2 + x/4*(q-2*n/x)^2 := by
    field_simp
    ring
  rw [he]
  linarith

end ProcessingOracleTwoPhaseResearchProof1
