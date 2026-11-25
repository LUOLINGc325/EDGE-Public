import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

/-! Algebraic consequences of the four-cycle partition-count table in §3. -/

namespace ChernSimonsCycleAllLevels

open Real

/-- The full four-partition entropy `S₄` per the §3 table:
`S₄ / log k = 2 + 1/n²`. -/
noncomputable def S4 (k : ℕ) (n : ℕ) : ℝ := (2 + 1 / (n : ℝ) ^ 2) * log (k : ℝ)

/-- Sum over the six three-partitions obtained by merging one pair:
`(Σ S_{211}) / log k = 10 + 2/n`. -/
noncomputable def sumS211 (k : ℕ) (n : ℕ) : ℝ :=
  (10 + 2 / (n : ℝ)) * log (k : ℝ)

/-- Sum over the four `3:1` bipartitions: `(Σ S_{31}) / log k = 4`. -/
noncomputable def sumS31 (k : ℕ) (_n : ℕ) : ℝ := 4 * log (k : ℝ)

/-- Sum over the three `2:2` bipartitions: `(Σ S_{22}) / log k = 5`. -/
noncomputable def sumS22 (k : ℕ) (_n : ℕ) : ℝ := 5 * log (k : ℝ)

/-- The tripartite mutual information `I_{3,n} = Σ S31 - Σ S22`. -/
noncomputable def I3 (k : ℕ) (n : ℕ) : ℝ := sumS31 k n - sumS22 k n

/-- `GM_{a=0} = S₄ - (1/3) Σ S211 + (1/3) Σ S31`. -/
noncomputable def GM (k : ℕ) (n : ℕ) : ℝ :=
  S4 k n - (1 / 3) * sumS211 k n + (1 / 3) * sumS31 k n

/-- `Δₙ = GM_{a=0} - ((n²-3n+3)/(3n²)) I_{3,n}`. -/
noncomputable def Delta (k : ℕ) (n : ℕ) : ℝ :=
  GM k n - ((n : ℝ) ^ 2 - 3 * (n : ℝ) + 3) / (3 * (n : ℝ) ^ 2) * I3 k n

/-- **Identity 1** (`I_{3,n} = -log k`) for `k ≥ 2`, `n ≥ 2`. -/
theorem hI3 (k n : ℕ) (_hk : 2 ≤ k) (_hn : 2 ≤ n) : I3 k n = -log (k : ℝ) := by
  unfold I3 sumS31 sumS22
  ring

/-- **Identity 2** (`GM_{a=0} = (1/n² - 2/(3n)) log k`). -/
theorem hGM (k n : ℕ) (_hk : 2 ≤ k) (hn : 2 ≤ n) :
    GM k n = (1 / (n : ℝ) ^ 2 - 2 / (3 * (n : ℝ))) * log (k : ℝ) := by
  unfold GM S4 sumS211 sumS31
  have hn0 : (n : ℝ) ≠ 0 := by
    have : (2 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
    linarith
  field_simp
  ring

/-- **Identity 3** (`Δₙ = ((n-2)(n-3)/(3n²)) log k`). -/
theorem hDelta (k n : ℕ) (hk : 2 ≤ k) (hn : 2 ≤ n) :
    Delta k n = (((n : ℝ) - 2) * ((n : ℝ) - 3) / (3 * (n : ℝ) ^ 2)) * log (k : ℝ) := by
  unfold Delta
  rw [hGM k n hk hn, hI3 k n hk hn]
  have hn0 : (n : ℝ) ≠ 0 := by
    have : (2 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
    linarith
  field_simp
  ring

/-- The three entropy identities obtained by substituting the §3 table. -/
theorem collapse_identities (k n : ℕ) (hk : 2 ≤ k) (hn : 2 ≤ n) :
    I3 k n = -log (k : ℝ) ∧
    GM k n = (1 / (n : ℝ) ^ 2 - 2 / (3 * (n : ℝ))) * log (k : ℝ) ∧
    Delta k n = (((n : ℝ) - 2) * ((n : ℝ) - 3) / (3 * (n : ℝ) ^ 2)) * log (k : ℝ) :=
  ⟨hI3 k n hk hn, hGM k n hk hn, hDelta k n hk hn⟩

/-- Consequence recorded in the manuscript: `n = 3` gives zero `Δ`. -/
theorem Delta_eq_zero_of_n_eq_three (k : ℕ) (hk : 2 ≤ k) :
    Delta k 3 = 0 := by
  rw [hDelta k 3 hk (by norm_num)]
  norm_num

/-- Consequence recorded in the manuscript: `Δ = 0` at `n = 2`. -/
theorem Delta_eq_zero_of_n_eq_two (k : ℕ) (hk : 2 ≤ k) :
    Delta k 2 = 0 := by
  rw [hDelta k 2 hk (by norm_num)]
  norm_num

theorem collapse_violation (k n : ℕ) (hk : 2 ≤ k) (hn : 4 ≤ n) :
    0 < Delta k n := by
  rw [hDelta k n hk (by omega)]
  have hn' : (4 : ℝ) ≤ n := by exact_mod_cast hn
  have hk' : (2 : ℝ) ≤ k := by exact_mod_cast hk
  have hlog : 0 < log (k : ℝ) := Real.log_pos (by linarith)
  exact mul_pos (div_pos (mul_pos (by linarith) (by linarith)) (by positivity)) hlog

end ChernSimonsCycleAllLevels
