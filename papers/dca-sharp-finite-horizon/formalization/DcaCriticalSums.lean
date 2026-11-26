import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Ring
import Lean.Elab.Tactic.Omega

namespace DCASharpResidual

open Finset

/-- The partial sum `E_j(t) = ∑_{ℓ=1}^{2j} t^{-ℓ}` of equation (2). -/
noncomputable def E (n : ℕ) (t : ℝ) : ℝ :=
  ∑ i ∈ range (2 * n), (t⁻¹) ^ (i + 1)

/-- The finite increment identity for `E`: adding the next horizon contributes
the two new powers `t^{-(2n+1)}` and `t^{-(2n+2)}`. -/
theorem E_succ (n : ℕ) (t : ℝ) :
    E (n + 1) t = E n t + (t⁻¹) ^ (2 * n + 1) + (t⁻¹) ^ (2 * n + 2) := by
  have h : 2 * (n + 1) = (2 * n + 1) + 1 := by omega
  unfold E
  rw [h, Finset.sum_range_succ, Finset.sum_range_succ]

/-- At `t = 1` each summand equals one, so `E_j(1) = 2j`. -/
theorem E_one (n : ℕ) : E n 1 = 2 * (n : ℝ) := by
  simp [E, Nat.cast_mul]

/-- The manuscript quantity `T_j = E_j(e) - E_j(r)`. -/
noncomputable def T (n : ℕ) (e r : ℝ) : ℝ := E n e - E n r

/-- Exact expansion of the `(j+1)`-th increment of `T` in terms of the two
increment terms of `E`. -/
theorem T_succ_sub (n : ℕ) (e r : ℝ) :
    T (n + 1) e r - T n e r
      = ((e⁻¹) ^ (2 * n + 1) + (e⁻¹) ^ (2 * n + 2))
        - ((r⁻¹) ^ (2 * n + 1) + (r⁻¹) ^ (2 * n + 2)) := by
  unfold T
  rw [E_succ n e, E_succ n r]
  ring

/-- `T_j(1, r)` has the expected value `E_j(1) - E_j(r)`. -/
theorem T_one (n : ℕ) (r : ℝ) : T n 1 r = 2 * (n : ℝ) - E n r := by
  unfold T
  rw [E_one n]

end DCASharpResidual
