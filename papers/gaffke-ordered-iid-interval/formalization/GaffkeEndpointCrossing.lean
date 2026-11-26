import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

namespace GaffkeOrderedIidIntervalResearchProof2

theorem endpoint_crossing (a P V m : ℝ) (n : ℕ) (hn : 0<n) (ha : 0<a) (hP : 0<P) (hV : 0<V) (hm : 0<m) : V*m^n/P≤a ↔ m≤(a*P/V)^((n:ℝ)⁻¹) := by
  have hnpos : (0:ℝ) < n := by exact_mod_cast hn
  have hbase : 0 ≤ a*P/V := div_nonneg (mul_nonneg ha.le hP.le) hV.le
  have hb : 0 ≤ (a*P/V)^((n:ℝ)⁻¹) := Real.rpow_nonneg hbase _
  have hpow : ((a*P/V)^((n:ℝ)⁻¹))^n = a*P/V := by
    rw [← Real.rpow_natCast, ← Real.rpow_mul hbase, inv_mul_cancel₀ hnpos.ne', Real.rpow_one]
  rw [← pow_le_pow_iff_left₀ hm.le hb hn.ne', hpow, div_le_iff₀ hP, le_div_iff₀ hV, mul_comm V]

end GaffkeOrderedIidIntervalResearchProof2
