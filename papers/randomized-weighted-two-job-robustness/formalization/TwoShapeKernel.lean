import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Lean.Elab.Tactic.Omega

namespace RandomizedTwoJobRobustness

open Real

/-- The reciprocal kernel of Section 4. -/
noncomputable def K (s : ℝ) : ℝ :=
  (1 / max s ((1 - s) / 3) + 1 / max (s / 3) (1 - s)) / 2

/-- Reciprocal kernel value on the left interval. -/
theorem K_of_le (s : ℝ) (h : s ≤ 1 / 4) :
    K s = 2 / (1 - s) := by
  have h1 : s ≤ (1 - s) / 3 := by linarith
  have h2 : s / 3 ≤ 1 - s := by linarith
  have h3 : max s ((1 - s) / 3) = (1 - s) / 3 := max_eq_right h1
  have h4 : max (s / 3) (1 - s) = 1 - s := max_eq_right h2
  have hden : (1 - s) ≠ 0 := by linarith
  have hs3 : s / 3 ≠ 0 → (1 - s) ≠ 0 := by
    intro _; linarith
  rw [K, h3, h4]
  field_simp
  ring

/-- Reciprocal kernel value on the right interval. -/
theorem K_of_ge (s : ℝ) (h : 3 / 4 ≤ s) :
    K s = 2 / s := by
  have h1 : (1 - s) / 3 ≤ s := by linarith
  have h2 : 1 - s ≤ s / 3 := by linarith
  have h3 : max s ((1 - s) / 3) = s := max_eq_left h1
  have h4 : max (s / 3) (1 - s) = s / 3 := max_eq_left h2
  have hs : s ≠ 0 := by linarith
  rw [K, h3, h4]
  field_simp
  ring

/-- Reciprocal kernel value in the center interval. -/
theorem K_of_center (s : ℝ) (h1 : 1 / 4 ≤ s) (h2 : s ≤ 3 / 4) :
    K s = 1 / (2 * s * (1 - s)) := by
  have ha : (1 - s) / 3 ≤ s := by linarith
  have hc : s / 3 ≤ 1 - s := by linarith
  have h3 : max s ((1 - s) / 3) = s := max_eq_left ha
  have h4 : max (s / 3) (1 - s) = 1 - s := max_eq_right hc
  have hs : s ≠ 0 := by linarith
  have hs1 : (1 - s) ≠ 0 := by linarith
  rw [K, h3, h4]
  field_simp
  ring

/-- Main lower bound: `K s ≥ 2` on `[0,1]`. -/
theorem K_ge_two (s : ℝ) (hs0 : 0 ≤ s) (hs1 : s ≤ 1) : 2 ≤ K s := by
  rcases le_or_lt s (1 / 4) with h | h
  · rw [K_of_le s h]
    have h1 : (0 : ℝ) < 1 - s := by linarith
    rw [le_div_iff₀ h1]
    nlinarith
  · rcases le_or_lt (3 / 4) s with h2 | h2
    · rw [K_of_ge s h2]
      have hsm : (0 : ℝ) < s := by linarith
      rw [le_div_iff₀ hsm]
      nlinarith
    · have hh1 : 1 / 4 ≤ s := le_of_lt h
      have hh2 : s ≤ 3 / 4 := le_of_lt h2
      rw [K_of_center s hh1 hh2]
      have hsm : (0 : ℝ) < s := by linarith
      have hs1' : (0 : ℝ) < 1 - s := by linarith
      have hden : (0 : ℝ) < 2 * s * (1 - s) := by positivity
      rw [le_div_iff₀ hden]
      nlinarith [sq_nonneg (2 * s - 1)]

/-- Equality characterization for the lower bound on `[0,1]`. -/
theorem K_eq_two_iff (s : ℝ) (hs0 : 0 ≤ s) (hs1 : s ≤ 1) :
    K s = 2 ↔ s = 0 ∨ s = 1 / 2 ∨ s = 1 := by
  constructor
  · intro hK
    rcases lt_or_ge s (1 / 4) with h | h
    · rw [K_of_le s h.le] at hK
      have h1 : (0 : ℝ) < 1 - s := by linarith
      rw [div_eq_iff h1.ne'] at hK
      left; linarith
    · rcases lt_or_ge (3 / 4) s with h2 | h2
      · rw [K_of_ge s h2.le] at hK
        have hsm : (0 : ℝ) < s := by linarith
        rw [div_eq_iff hsm.ne'] at hK
        right; right; linarith
      · rw [K_of_center s h h2] at hK
        have hsm : (0 : ℝ) < s := by linarith
        have hs1' : (0 : ℝ) < 1 - s := by linarith
        have hden : (0 : ℝ) < 2 * s * (1 - s) := by positivity
        rw [div_eq_iff hden.ne'] at hK
        right; left
        have hsq : (2 * s - 1) ^ 2 = 1 - 4 * s * (1 - s) := by ring
        have hz : (2 * s - 1) ^ 2 = 0 := by nlinarith
        have hzero : 2 * s - 1 = 0 := by
          rwa [sq_eq_zero_iff] at hz
        linarith
  · intro h
    rcases h with h | h | h
    · subst h
      rw [K_of_le 0 (by norm_num)]
      norm_num
    · subst h
      rw [K_of_center (1 / 2) (by norm_num) (by norm_num)]
      norm_num
    · subst h
      rw [K_of_ge 1 (by norm_num)]
      norm_num

/-- The exact reciprocal-kernel minimum and its equality characterization. -/
theorem K_min_and_eq (s : ℝ) (hs0 : 0 ≤ s) (hs1 : s ≤ 1) :
    2 ≤ K s ∧ (K s = 2 ↔ s = 0 ∨ s = 1 / 2 ∨ s = 1) :=
  ⟨K_ge_two s hs0 hs1, K_eq_two_iff s hs0 hs1⟩

end RandomizedTwoJobRobustness
