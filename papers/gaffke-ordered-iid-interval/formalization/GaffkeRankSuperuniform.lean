import Mathlib.Data.Real.Archimedean
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Lean.Elab.Tactic.Omega

namespace GaffkeOrderedIidIntervalResearchProof1

theorem rank_grid_superuniform (M : ℕ) (hM : 0<M) (v : ℝ) (h0 : 0≤v) (h1 : v≤1) : ((Finset.Icc 1 M).filter (fun j : ℕ => (j:ℝ)/M≤v)).card = ⌊(M:ℝ)*v⌋₊ := by
  have hMp : (0:ℝ) < M := by exact_mod_cast hM
  have hMv : 0 ≤ (M:ℝ)*v := mul_nonneg hMp.le h0
  let k := ⌊(M:ℝ)*v⌋₊
  have hk : k ≤ M := by
    simpa [k] using Nat.floor_mono (show (M:ℝ)*v ≤ (M:ℝ) from by
      simpa using mul_le_mul_of_nonneg_left h1 hMp.le)
  have he : ((Finset.Icc 1 M).filter (fun j : ℕ => (j:ℝ)/M ≤ v)) = Finset.Icc 1 k := by
    ext j
    simp only [Finset.mem_filter,Finset.mem_Icc]
    rw [div_le_iff₀ hMp, mul_comm v, ← Nat.le_floor_iff hMv]
    change (1 ≤ j ∧ j ≤ M) ∧ j ≤ k ↔ 1 ≤ j ∧ j ≤ k
    omega
  rw [he, Nat.card_Icc]
  omega

end GaffkeOrderedIidIntervalResearchProof1
