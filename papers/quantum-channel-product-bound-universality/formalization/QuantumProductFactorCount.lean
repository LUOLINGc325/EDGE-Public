import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.Order.Floor.Ring

namespace QuantumChannelProductBoundUniversalityResearchProof1

/-- The floor-to-square-root bridge in Corollary 2: for `d ≥ 2`,
`k₀(d) = ⌊(√(2d) - 1)²⌋` satisfies `1 ≤ k₀(d)` and
`√(k₀(d)) + 1 ≤ √(2d)`. -/
theorem factor_count_floor (d : ℕ) (hd : 2 ≤ d) :
    let k := Nat.floor ((Real.sqrt (2*(d:ℝ))-1)^2)
    1 ≤ k ∧ Real.sqrt (k:ℝ)+1 ≤ Real.sqrt (2*(d:ℝ)) := by
  intro k
  have hdR : (2 : ℝ) ≤ (d : ℝ) := by exact_mod_cast hd
  have hdpos : (0 : ℝ) < (d : ℝ) := by linarith
  set x : ℝ := Real.sqrt (2 * (d : ℝ)) with hx
  have hx2 : x ^ 2 = 2 * (d : ℝ) := by
    rw [hx]
    exact Real.sq_sqrt (by positivity)
  have hxnn : 0 ≤ x := by
    rw [hx]; exact Real.sqrt_nonneg _
  -- `x ≥ 2` since `x² = 2d ≥ 4`.
  have hx4 : 4 ≤ x ^ 2 := by rw [hx2]; linarith
  have hx2' : (2 : ℝ) ≤ x := by nlinarith
  -- The real number `y = (x - 1)²` is at least `1`.
  set y : ℝ := (x - 1) ^ 2 with hy
  have hyr : Real.sqrt y = x - 1 := by
    rw [hy]
    rw [Real.sqrt_sq (by linarith)]
  have hy1 : 1 ≤ y := by
    rw [hy]
    nlinarith [sq_nonneg (x - 1), hx2']
  have hk1 : 1 ≤ k := by
    unfold k
    apply Nat.le_floor
    push_cast
    exact hy1
  -- Square-root inequality: `√k + 1 ≤ x` from `k ≤ y` and `√y = x - 1`.
  have hk_le : (k : ℝ) ≤ y := by
    unfold k
    exact Nat.floor_le (by positivity)
  have hk_nonneg : (0 : ℝ) ≤ (k : ℝ) := by positivity
  have hsq : Real.sqrt (k : ℝ) ≤ Real.sqrt y := Real.sqrt_le_sqrt hk_le
  have hfinal : Real.sqrt (k : ℝ) + 1 ≤ x := by
    have := hsq
    rw [hyr] at this
    linarith
  exact ⟨hk1, hfinal⟩

end QuantumChannelProductBoundUniversalityResearchProof1
