import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

namespace RecordConstrainedProphetGapResearchProof3

/-- Strict positivity of each label mass in (8): for `0 ≤ j < m` and `n > 0`,
the mass `((j+1)/m)^n - (j/m)^n` is strictly positive. -/
theorem maximum_label_mass_positive (m n j : ℕ) (hm : 0 < m)
         (hn : 0 < n) (hj : j < m) :
         0 < ((((j : ℝ)+1)/m)^n - ((j : ℝ)/m)^n) := by
  have _ := hj
  have hmR : (0 : ℝ) < (m : ℝ) := by exact_mod_cast hm
  have hn0 : n ≠ 0 := Nat.pos_iff_ne_zero.mp hn
  have hlt : (j : ℝ) / (m : ℝ) < ((j : ℝ) + 1) / (m : ℝ) := by
    apply div_lt_div_of_pos_right _ hmR
    linarith
  have hbase : (0 : ℝ) ≤ (j : ℝ) / (m : ℝ) := by positivity
  have hpow : ((j : ℝ) / (m : ℝ)) ^ n < (((j : ℝ) + 1) / (m : ℝ)) ^ n :=
    pow_lt_pow_left₀ hlt hbase hn0
  exact sub_pos.mpr hpow

end RecordConstrainedProphetGapResearchProof3
