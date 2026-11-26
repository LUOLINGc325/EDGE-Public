import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace RecordConstrainedProphetGapResearchProof2

theorem maximum_label_mass_total (m n : ℕ) (hm : 0<m) (hn : 0<n) : (∑ j ∈ Finset.range m, ((((j:ℝ)+1)/m)^n-((j:ℝ)/m)^n))=1 := by
  have hmr : (m : ℝ) ≠ 0 := by exact_mod_cast hm.ne'
  simpa only [Nat.cast_add, Nat.cast_one, Nat.cast_zero, div_self hmr, zero_div, one_pow,
    zero_pow hn.ne', sub_zero] using
    Finset.sum_range_sub (fun j : ℕ => ((j : ℝ) / m)^n) m

end RecordConstrainedProphetGapResearchProof2
