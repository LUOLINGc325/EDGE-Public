import RationalAssembly

/-! Operation and storage bounds for the streaming synthesis algorithm.
Arithmetic charges one operation per exact addition, subtraction, multiplication
or division, and one per comparison. Registers store exact rationals. -/

open scoped BigOperators

namespace FiniteFrontier

abbrev SnapshotTable (n : ℕ) := Fin (n + 1) → Fin n → ℝ

/-- Update one table with a precomputed suffix level vector, immediately releasing
the current suffix after the update. -/
noncomputable def addSnapshotTable {n : ℕ} (current next : SnapshotTable n) (gap : ℝ) :
    SnapshotTable n := fun k i => current k i + gap * next k i

noncomputable def streamTables {n : ℕ} (w : ℕ → ℝ) (tab : ℕ → SnapshotTable n) :
    ℕ → SnapshotTable n
  | 0 => fun _ _ => 0
  | j + 1 => addSnapshotTable (streamTables w tab j) (tab j) (w j)

theorem stream_table_entry {n : ℕ} (w : ℕ → ℝ) (tab : ℕ → SnapshotTable n)
    (h : ℕ) (k : Fin (n + 1)) (i : Fin n) :
    streamTables w tab h k i = ∑ j ∈ Finset.range h, w j * tab j k i := by
  induction h with
  | zero => simp [streamTables]
  | succ h ih => rw [streamTables, addSnapshotTable, ih, Finset.sum_range_succ]

theorem stream_partial_height {n : ℕ} (w : ℕ → ℝ) (tab : ℕ → SnapshotTable n)
    (K : ℝ) (hK : 2 ≤ K) (e h : ℕ) (k : Fin (n + 1)) (i : Fin n)
    (hb : ∀ j < h, FractionHeight (w j * tab j k i) (K ^ e)) :
    FractionHeight (streamTables w tab h k i) (K ^ (h * (e + 1))) := by
  rw [stream_table_entry]
  exact FractionHeight.sum_range hK e h hb

noncomputable def suffixAtRank (R : ℝ) {n : ℕ} (hR : baselineRobustness (n : ℝ) ≤ R)
    (j : ℕ) : SnapshotTable n :=
  if hj : j < n then fun k i => (unitSuffixPlan R hR ⟨j, hj⟩).attained k.val i
  else fun _ _ => 0

noncomputable def gapAtRank {n : ℕ} (y : Fin n → ℝ) (j : ℕ) : ℝ :=
  if hj : j < n then predictionGap y ⟨j, hj⟩ else 0

theorem stream_is_synthesis {n : ℕ} (y : Fin n → ℝ) (hy : ∀ i, 0 ≤ y i) (hs : Monotone y)
    (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R) (k : Fin (n + 1)) (i : Fin n) :
    streamTables (gapAtRank y) (suffixAtRank R hR) n k i =
      (synthesizeSorted y hy hs R hR).attained k.val i := by
  rw [stream_table_entry]
  unfold synthesizeSorted
  rw [SnapshotPlan.cast_attained]
  change _ = ∑ j : Fin n, predictionGap y j * (unitSuffixPlan R hR j).attained k.val i
  rw [Finset.sum_fin_eq_sum_range]
  apply Finset.sum_congr rfl
  intro j hj
  have h := Finset.mem_range.mp hj
  simp only [gapAtRank, suffixAtRank, dif_pos h]

/-- A single update uses one multiplication and one addition for each table cell. -/
noncomputable def tableUpdateArithmetic (n : ℕ) : ℕ := 2 * n * (n + 1)

/-- Sorting with a stable quadratic loop, computing sorted gaps, precomputing the current
unit-level vector in one pass, and applying each suffix update. Each rational level uses
at most 20 primitives from the displayed recurrence and its branch test. -/
noncomputable def synthesisArithmetic (n : ℕ) : ℕ :=
  n * n + n + ∑ m ∈ Finset.range n, (20 * (m + 1) + tableUpdateArithmetic n)

noncomputable def synthesisRegisters (n : ℕ) : ℕ :=
  n * (n + 1) + (n + 1) + 2 * n + 16

theorem synthesis_arithmetic_cubic (n : ℕ) :
    synthesisArithmetic n ≤ 32 * (n + 1) ^ 3 := by
  have hsum : (∑ m ∈ Finset.range n, (20 * (m + 1) + tableUpdateArithmetic n)) ≤
      n * (20 * n + tableUpdateArithmetic n) := by
    calc
      _ ≤ ∑ _m ∈ Finset.range n, (20 * n + tableUpdateArithmetic n) := by
        exact Finset.sum_le_sum fun m hm =>
          add_le_add_right (Nat.mul_le_mul_left 20 (Nat.succ_le_of_lt (Finset.mem_range.mp hm))) _
      _ = _ := by simp
  unfold synthesisArithmetic tableUpdateArithmetic at *
  have h := Nat.add_le_add_left hsum (n * n + n)
  have hb : n * n + n + n * (20 * n + 2 * n * (n + 1)) ≤ 32 * (n + 1) ^ 3 := by
    have hreal : (n : ℝ) * n + n + n * (20 * n + 2 * n * (n + 1)) ≤
        32 * ((n : ℝ) + 1) ^ 3 := by
      have hp : 0 ≤ (n : ℝ) ^ 3 := by positivity
      have hn : 0 ≤ (n : ℝ) := by positivity
      nlinarith only [hp, hn, sq_nonneg (n : ℝ)]
    exact_mod_cast hreal
  exact h.trans hb

theorem synthesis_registers_quadratic (n : ℕ) :
    synthesisRegisters n ≤ 24 * (n + 1) ^ 2 := by
  unfold synthesisRegisters
  have h : (n : ℝ) * (n + 1) + (n + 1) + 2 * n + 16 ≤ 24 * ((n : ℝ) + 1) ^ 2 := by
    have hn : 0 ≤ (n : ℝ) := by positivity
    nlinarith only [hn, sq_nonneg (n : ℝ)]
  exact_mod_cast h

end FiniteFrontier
