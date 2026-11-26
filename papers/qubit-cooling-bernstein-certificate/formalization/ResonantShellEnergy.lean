import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

open scoped BigOperators

namespace QubitCoolingBernsteinCertificate

/-- Combine the two equal-weight label classes of one resonant shell. -/
theorem shell_energy_eq {w a n m : ℝ} (hw : 0 < w) (hn : 0 < n) (hm : 0 < m) :
    a^2/(w*n)+a^2/(w*m) = a^2/(w*(n*m/(n+m))) := by
  have hsum : 0 < n+m := add_pos hn hm
  field_simp [hw.ne',hn.ne',hm.ne',hsum.ne']
  ring

/-- The second Cauchy–Schwarz bound in §3 for nonempty mixed shells. -/
theorem total_transfer_le_shell_energy {ι : Type*} (shells : Finset ι)
    (hne : shells.Nonempty) (a weight : ι → ℝ) (hw : ∀ i ∈ shells, 0 < weight i) :
    0 < (∑ i ∈ shells, weight i) ∧
      (∑ i ∈ shells, a i)^2/(∑ i ∈ shells, weight i) ≤
        ∑ i ∈ shells, (a i)^2/weight i :=
  ⟨Finset.sum_pos hw hne, Finset.sq_sum_div_le_sum_sq_div shells a hw⟩

end QubitCoolingBernsteinCertificate
