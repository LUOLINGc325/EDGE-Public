import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Lean.Elab.Tactic.Omega

namespace NoisyQubitDesignParity

/-!
Source: 单量子比特酉设计偶奇噪声平台的精确判定, §4.

We formalize the explicit numerical comparison that produces the radius-1/4
counterexample.  With p = 1/2 and R = 1/4 we have q = 1/4, x = 1/16,
qx = 1/64.  The paper's functions are
  h_4(x) = 1 + 2x + x^2/5,
  h_5(x) = 1 + (10/3)x + x^2.
The two compared exact values are
  epsilon_4 = G_2 = ((1 - qx)/(1 - x))^2 - 1 = 41/400,
  epsilon_5 = F_5 = 1 - h_5(qx)/h_5(x) = 1965/14896,
and the strict parity gap is 41/400 < 1965/14896.

Scope: this is the exact finite algebraic comparison of §4, not the
full all-order turning-radius theorem of §3.
-/

/-- `h_5(x) = 1 + (10/3)x + x^2`. -/
noncomputable def h5 (x : ℝ) : ℝ := 1 + (10 / 3) * x + x ^ 2

/-- `h_5(1/64) = 12931 / 12288`, hence `h_5(qx)/h_5(x) = 12931/14896`. -/
lemma h5_ratio :
    h5 (1 / 64) / h5 (1 / 16) = (12931 : ℝ) / 14896 := by
  unfold h5
  norm_num

/-- The exact value `epsilon_5 = 1 - h_5(qx)/h_5(x) = 1965/14896`. -/
lemma eps5_value :
    (1 : ℝ) - h5 (1 / 64) / h5 (1 / 16) = 1965 / 14896 := by
  rw [h5_ratio]
  norm_num

/-- The exact value `epsilon_4 = G_2 = ((1-qx)/(1-x))^2 - 1 = 41/400`. -/
lemma eps4_value :
    (((1 : ℝ) - 1 / 64) / (1 - 1 / 16)) ^ 2 - 1 = 41 / 400 := by
  norm_num

/-- Strict parity gap at the paper's radius: `41/400 < 1965/14896`. -/
theorem strict_parity_gap :
    (41 : ℝ) / 400 < 1965 / 14896 := by
  norm_num

/-- Combined exact statement of the §4 numerical counterexample. -/
theorem eps4_lt_eps5 :
    (((1 : ℝ) - 1 / 64) / (1 - 1 / 16)) ^ 2 - 1
      < 1 - h5 (1 / 64) / h5 (1 / 16) := by
  rw [eps4_value, eps5_value]
  exact strict_parity_gap

end NoisyQubitDesignParity
