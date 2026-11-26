import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Data.Real.Sqrt

namespace UnknownGapAdaptationBoundaryResearchProof3

/-- Numeric core of Lemma 5: with `E` standing for `e^(1/8)` and `P` for `π`,
`E * sqrt (2 * P) < 3`, obtained from `E ≤ 8/7`, `P < 22/7` and
`(8/7)^2 * (44/7) = 2816/343 < 9`. -/
theorem gaussian_overshoot_numeric (E P : ℝ) (hE : 0 ≤ E) (hEmax : E ≤ 8/7)
    (hP : 0 ≤ P) (hPmax : P < 22/7) : E * Real.sqrt (2 * P) < 3 := by
  have hE8 : E ^ 2 ≤ (8 / 7) ^ 2 := by
    have h1 : (0 : ℝ) ≤ 8 / 7 := by norm_num
    have : E * E ≤ (8 / 7) * (8 / 7) :=
      mul_le_mul hEmax hEmax hE h1
    calc E ^ 2 = E * E := by ring
      _ ≤ (8 / 7) * (8 / 7) := this
      _ = (8 / 7) ^ 2 := by ring
  have hP44 : 2 * P < 44 / 7 := by linarith
  have h2P : (0 : ℝ) ≤ 2 * P := by linarith
  have hsq : (E * Real.sqrt (2 * P)) ^ 2 ≤ 2816 / 343 := by
    have h := Real.sq_sqrt h2P
    have hsqSqrt : Real.sqrt (2 * P) ^ 2 = 2 * P := h
    have h1 : (E * Real.sqrt (2 * P)) ^ 2 = E ^ 2 * (2 * P) := by
      rw [mul_pow, hsqSqrt]
    have h2 : E ^ 2 * (2 * P) ≤ (8 / 7) ^ 2 * (44 / 7) := by
      apply mul_le_mul hE8 hP44.le h2P
      positivity
    have h3 : (8 / 7 : ℝ) ^ 2 * (44 / 7) = 2816 / 343 := by
      norm_num
    rw [h1]
    linarith
  have hnonneg : 0 ≤ E * Real.sqrt (2 * P) := by positivity
  have h9 : (2816 / 343 : ℝ) < 9 := by norm_num
  nlinarith

end UnknownGapAdaptationBoundaryResearchProof3
