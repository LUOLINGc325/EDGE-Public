import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Data.Real.Archimedean

universe u
namespace OnlineUnboundedKnapsackMinimaxResearchProof1

theorem greedy_residual_capacity (ell x : ℝ) (hell : ell ≤ 1) (hx : 0 < x) :
         let out := ell+x*(⌊(1-ell)/x⌋ : ℝ)
         ell ≤ out ∧ out ≤ 1 ∧ 1-x < out := by
  let r := (1-ell)/x
  let n : ℤ := ⌊r⌋
  have hr : 0 ≤ r := div_nonneg (sub_nonneg.mpr hell) hx.le
  have hn : 0 ≤ (n:ℝ) := by exact_mod_cast Int.floor_nonneg.mpr hr
  have hfloor : (n:ℝ) ≤ r := Int.floor_le r
  have hnext : r < (n:ℝ)+1 := Int.lt_floor_add_one r
  have hrx : x*r = 1-ell := by
    dsimp [r]
    field_simp [ne_of_gt hx]
  change ell ≤ ell+x*(n:ℝ) ∧ ell+x*(n:ℝ) ≤ 1 ∧ 1-x < ell+x*(n:ℝ)
  exact ⟨by linarith only [mul_nonneg hx.le hn],
    by linarith only [mul_le_mul_of_nonneg_left hfloor hx.le, hrx],
    by nlinarith only [mul_lt_mul_of_pos_left hnext hx, hrx]⟩

end OnlineUnboundedKnapsackMinimaxResearchProof1
