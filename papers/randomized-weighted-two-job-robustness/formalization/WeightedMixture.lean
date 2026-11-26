import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Lean.Elab.Tactic.Omega

namespace RandomizedTwoJobRobustness

/-- Virtual-progress cost coordinates: `u = w₂ x₁`, `v = w₁ x₂`. -/
noncomputable def D (A B : ℝ) : ℝ := 2 * (A + B) + 1

noncomputable def m (u v : ℝ) : ℝ := min u v

noncomputable def OPT (A B u v : ℝ) : ℝ := A * u + B * v + m u v

noncomputable def pB (A B : ℝ) : ℝ := B / D A B

noncomputable def pA (A B : ℝ) : ℝ := A / D A B

noncomputable def pS (A B : ℝ) : ℝ := (A + B + 1) / D A B

/-- The mixed first virtual time with shares `0, 1, 1/2`. -/
noncomputable def mixedTau (A B u v : ℝ) : ℝ :=
  pB A B * v + pA A B * u + pS A B * (2 * m u v)

theorem D_pos {A B : ℝ} (hA : 0 < A) (hB : 0 < B) : 0 < D A B := by
  unfold D
  linarith

theorem OPT_pos {A B u v : ℝ} (hA : 0 < A) (hB : 0 < B) (hu : 0 < u) (hv : 0 < v) :
    0 < OPT A B u v := by
  unfold OPT m
  have hm : 0 < min u v := lt_min hu hv
  nlinarith [mul_pos hA hu, mul_pos hB hv]

theorem pB_nonneg {A B : ℝ} (hA : 0 < A) (hB : 0 < B) : 0 ≤ pB A B := by
  unfold pB
  exact div_nonneg hB.le (D_pos hA hB).le

theorem pA_nonneg {A B : ℝ} (hA : 0 < A) (hB : 0 < B) : 0 ≤ pA A B := by
  unfold pA
  exact div_nonneg hA.le (D_pos hA hB).le

theorem pS_nonneg {A B : ℝ} (hA : 0 < A) (hB : 0 < B) : 0 ≤ pS A B := by
  unfold pS
  apply div_nonneg
  linarith
  exact (D_pos hA hB).le

theorem probs_sum_one {A B : ℝ} (hA : 0 < A) (hB : 0 < B) :
    pB A B + pA A B + pS A B = 1 := by
  have hD : D A B ≠ 0 := (D_pos hA hB).ne'
  unfold pB pA pS
  field_simp
  unfold D
  ring

/-- Section 3's attaining weighted mixture in virtual-progress cost coordinates. -/
theorem mixed_ratio_eq {A B u v : ℝ} (hA : 0 < A) (hB : 0 < B)
    (hu : 0 < u) (hv : 0 < v) :
    (A * u + B * v + pB A B * v + pA A B * u + pS A B * (2 * m u v))
      / OPT A B u v = 1 + 1 / D A B := by
  have hD : D A B ≠ 0 := (D_pos hA hB).ne'
  have hO : OPT A B u v ≠ 0 := (OPT_pos hA hB hu hv).ne'
  unfold pB pA pS OPT m D at *
  field_simp
  ring

end RandomizedTwoJobRobustness
