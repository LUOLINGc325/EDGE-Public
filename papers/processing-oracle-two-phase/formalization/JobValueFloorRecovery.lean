import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Data.Real.Archimedean
import Lean.Elab.Tactic.Omega
import Mathlib.Tactic.NormNum

namespace ProcessingOracleTwoPhaseResearchProof2

theorem floor_recovery_three (n : ℕ) : Int.ceil (2*(n:ℝ)^2/3-3/4) = Int.floor (2*(n:ℝ)^2/3) := by
  let m : ℕ := (2 * n^2) / 3
  let r : ℕ := (2 * n^2) % 3
  have hmod : 2 * n^2 = 3*m + r := by
    dsimp [m,r]
    omega
  have hr : r = 0 ∨ r = 2 := by
    change (2 * n^2) % 3 = 0 ∨ (2 * n^2) % 3 = 2
    rw [Nat.mul_mod, Nat.pow_mod]
    have hcases : n % 3 = 0 ∨ n % 3 = 1 ∨ n % 3 = 2 := by omega
    rcases hcases with h | h | h <;> simp [h]
  have hm : 2*(n:ℝ)^2 = 3*(m:ℝ)+(r:ℝ) := by exact_mod_cast hmod
  have hf : Int.floor (2*(n:ℝ)^2/3) = (m:ℤ) := by
    apply Int.floor_eq_iff.mpr
    push_cast
    rcases hr with h | h <;> (rw [h] at hm; push_cast at hm; constructor <;> linarith)
  rw [hf]
  apply Int.ceil_eq_iff.mpr
  push_cast
  rcases hr with h | h <;> (rw [h] at hm; push_cast at hm; constructor <;> linarith)

end ProcessingOracleTwoPhaseResearchProof2
