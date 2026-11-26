import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Data.Int.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

namespace SubsampledMaxPowerLqrt

/-- Construct the actual nearest integer on the paper's power grid and obtain
the Gaussian exponent lower bound in Equation (3). -/
theorem grid_exponent_bound (L : ℕ) (z z' : ℝ) (hz : 1 ≤ z) (hzL : z ≤ L)
    (hz' : 1 ≤ z') (hz'upper : z' ≤ 3/2) :
    ∃ j : ℤ, 1 ≤ j ∧ j ≤ (L : ℤ)+1 ∧
      Real.exp (z^2/2-9/32) ≤ Real.exp ((j : ℝ)*z'*z-((j : ℝ)*z')^2/2) := by
  have hp : 0 < z' := lt_of_lt_of_le zero_lt_one hz'
  let j : ℤ := ⌊z/z' + 1/2⌋
  have hjl : (j : ℝ) ≤ z/z'+1/2 := Int.floor_le _
  have hju : z/z'+1/2 < (j : ℝ)+1 := Int.lt_floor_add_one _
  have hzlow : (1/2 : ℝ) ≤ z/z' := (le_div_iff₀ hp).2 (by linarith)
  have hratio : z/z' ≤ (L : ℝ) := (div_le_iff₀ hp).2 (by
    have h := mul_le_mul_of_nonneg_left hz' (Nat.cast_nonneg (α := ℝ) L)
    linarith)
  have hj1 : (1 : ℤ) ≤ j := Int.le_floor.2 (by push_cast; linarith)
  have hjL : j ≤ (L : ℤ)+1 := by
    have h : (j : ℝ) ≤ (L : ℝ)+1 := by linarith
    exact_mod_cast h
  have ha : |(j : ℝ)-z/z'| ≤ 1/2 := abs_le.2 ⟨by linarith,by linarith⟩
  have hf : (j : ℝ)*z'-z = z'*((j : ℝ)-z/z') := by
    field_simp [ne_of_gt hp]
  have hs : |(j : ℝ)*z'-z| ≤ 3/4 := by
    rw [hf,abs_mul,abs_of_pos hp]
    exact (mul_le_mul_of_nonneg_left ha hp.le).trans (by linarith)
  have hsq : ((j : ℝ)*z'-z)^2 ≤ 9/16 := by
    have h := mul_le_mul hs hs (abs_nonneg _) (by norm_num : 0 ≤ (3/4 : ℝ))
    rw [← pow_two,sq_abs,← pow_two] at h
    norm_num at h
    exact h
  refine ⟨j,hj1,hjL,Real.exp_le_exp.mpr ?_⟩
  have heq : z^2/2-((j : ℝ)*z'*z-((j : ℝ)*z')^2/2) = ((j : ℝ)*z'-z)^2/2 := by ring
  linarith

end SubsampledMaxPowerLqrt
