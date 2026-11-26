import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith

namespace EvenCycleReplicaBranchSeparationResearchProof1

/-- The positive quantity ruling the increment `T_{k+1} - T_k` at `k = 2`:
manuscript states it is `2 n (n-3) (n-1)^2 (n^2-3n+1)`.  We isolate this factor
so the sign is transparent. -/
noncomputable def incrementFactor (n : ℝ) : ℝ :=
  n * (n - 3) * (n - 1) ^ 2 * (n ^ 2 - 3 * n + 1)

/-- The quadratic `n^2 - 3n + 1` decomposes as `(n - 1)^2 - n`, which is
positive for `n > 3`; equivalently it is the given explicit polynomial. -/
lemma sq_sub_three_add_one_decomp (n : ℝ) :
    n ^ 2 - 3 * n + 1 = (n - 1) ^ 2 - n := by
  ring

/-- For `n > 3`, `n ^ 2 - 3 * n + 1 > 0`.  Manuscript asks for an explicit
decomposition; we use `n^2 - 3n + 1 = n(n-3) + 1` and positivity. -/
lemma quad_pos_of_three_lt {n : ℝ} (hn : 3 < n) : 0 < n ^ 2 - 3 * n + 1 := by
  have h : n ^ 2 - 3 * n + 1 = n * (n - 3) + 1 := by ring
  rw [h]
  have hnpos : (0 : ℝ) < n := by linarith
  have hn3 : (0 : ℝ) < n - 3 := by linarith
  nlinarith [mul_pos hnpos hn3]

/-- The explicit positivity factors promised by the manuscript:
`n > 0`, `n - 3 > 0`, `(n - 1)^2 > 0`, and `n^2 - 3n + 1 > 0`. -/
lemma incrementFactor_pos {n : ℝ} (hn : 3 < n) : 0 < incrementFactor n := by
  unfold incrementFactor
  have hnpos : (0 : ℝ) < n := by linarith
  have hn3 : (0 : ℝ) < n - 3 := by linarith
  have hn1 : (0 : ℝ) < n - 1 := by linarith
  have hsq : (0 : ℝ) < (n - 1) ^ 2 := by positivity
  have hquad : (0 : ℝ) < n ^ 2 - 3 * n + 1 := quad_pos_of_three_lt hn
  exact mul_pos (mul_pos (mul_pos hnpos hn3) hsq) hquad

/-- The increment factor is nonnegative for `n ≥ 3`; at `n = 3` it vanishes
(because of the factor `n - 3`), so this is the threshold case. -/
lemma incrementFactor_nonneg {n : ℝ} (hn : 3 ≤ n) : 0 ≤ incrementFactor n := by
  unfold incrementFactor
  have hnpos : (0 : ℝ) ≤ n := by linarith
  have hn3 : (0 : ℝ) ≤ n - 3 := by linarith
  have hsq : (0 : ℝ) ≤ (n - 1) ^ 2 := by positivity
  have hquad : (0 : ℝ) ≤ n ^ 2 - 3 * n + 1 := by
    have hn0 : (0 : ℝ) < n := by linarith
    have h : 0 ≤ n * (n - 3) := mul_nonneg (le_of_lt hn0) hn3
    have e : n ^ 2 - 3 * n + 1 = n * (n - 3) + 1 := by ring
    rw [e]; linarith
  exact mul_nonneg (mul_nonneg (mul_nonneg hnpos hn3) hsq) hquad

/-- At the threshold `n = 3`, the increment factor vanishes. -/
lemma incrementFactor_at_three : incrementFactor 3 = 0 := by
  unfold incrementFactor
  norm_num

/-- The numerator factor from the base increment vanishes at 3 and is positive above 3. -/
theorem incrementFactor_threshold_and_sign :
    (∀ n : ℝ, 3 < n → 0 < incrementFactor n) ∧
    incrementFactor 3 = 0 := by
  refine ⟨?_, incrementFactor_at_three⟩
  intro n hn
  exact incrementFactor_pos hn

/-- The polynomial decomposition requested in the assignment:
`n^2 - 3n + 1 = (n - 1)^2 - n`, stated exactly as real identity. -/
theorem quad_decomposition (n : ℝ) :
    n ^ 2 - 3 * n + 1 = (n - 1) ^ 2 - n :=
  sq_sub_three_add_one_decomp n

end EvenCycleReplicaBranchSeparationResearchProof1
