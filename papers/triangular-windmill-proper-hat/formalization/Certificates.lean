import Lower
import Mathlib.Tactic.NormNum

set_option autoImplicit false
set_option maxRecDepth 100000
set_option maxHeartbeats 0
set_option synthInstance.maxSize 100000
set_option maxSynthPendingDepth 1000

namespace ProperHats

/-- Success of at least one leaf when both use the same modular lookup rule. -/
def TableHit {q : Nat} (T : Fin q → Fin q) (c a b : Fin q) : Prop :=
  c + T (b - c) = a ∨ c + T (a - c) = b

def Edge {q : Nat} (a b u v : Fin q) : Prop :=
  (a = u ∧ b = v) ∨ (a = v ∧ b = u)

/-- The five-color witness also has the closed-form center guess 3(a+b). -/
theorem five_linear_decoder : ∀ c a b : Fin 5,
    c ≠ a → c ≠ b → a ≠ b →
    3 * (a + b) = c ∨ TableHit tableFive c a b := by
  simp only [TableHit, Edge]
  decide

/-- Intermediate finite algebra used by the self-contained five-color argument. -/
theorem five_table_affine : ∀ z : Fin 5, tableFive z = 2 * z := by
  decide

theorem five_hit_roots : ∀ c a b : Fin 5,
    TableHit tableFive c a b ↔ c = 2 * b - a ∨ c = 2 * a - b := by
  simp only [TableHit, Edge]
  decide

theorem five_success_roots_distinct : ∀ a b : Fin 5, a ≠ b →
    (2 * b - a ≠ a) ∧ (2 * b - a ≠ b) ∧
    (2 * a - b ≠ a) ∧ (2 * a - b ≠ b) ∧
    (2 * b - a ≠ 2 * a - b) := by
  decide

theorem five_remaining_root : ∀ c a b : Fin 5,
    a ≠ b → c ≠ a → c ≠ b →
    (c ≠ 2 * b - a ∧ c ≠ 2 * a - b ↔ c = 3 * (a + b)) := by
  decide

/-- Exact difference classes used by the first six-color blade. -/
theorem six_A_difference_cover : ∀ c d : Fin 6,
    (d - c = 2 ∨ d - c = 4) → ∀ a b : Fin 6,
    c ≠ a → c ≠ b → d ≠ a → d ≠ b → a ≠ b →
    TableHit tableSixA c a b ∨ TableHit tableSixA d a b := by
  simp only [TableHit, Edge]
  decide

theorem six_B_difference_cover : ∀ c d : Fin 6,
    (d - c = 1 ∨ d - c = 5 ∨ d - c = 3) → ∀ a b : Fin 6,
    c ≠ a → c ≠ b → d ≠ a → d ≠ b → a ≠ b →
    TableHit tableSixB c a b ∨ TableHit tableSixB d a b := by
  simp only [TableHit, Edge]
  decide

theorem seven_A_difference_cover : ∀ c d : Fin 7,
    (d - c = 1 ∨ d - c = 6) → ∀ a b : Fin 7,
    c ≠ a → c ≠ b → d ≠ a → d ≠ b → a ≠ b →
    TableHit tableSevenA c a b ∨ TableHit tableSevenA d a b := by
  simp only [TableHit, Edge]
  decide

theorem seven_B_difference_cover : ∀ c d : Fin 7,
    (d - c = 2 ∨ d - c = 5) → ∀ a b : Fin 7,
    c ≠ a → c ≠ b → d ≠ a → d ≠ b → a ≠ b →
    TableHit tableSevenB c a b ∨ TableHit tableSevenB d a b := by
  simp only [TableHit, Edge]
  decide

theorem seven_C_difference_cover : ∀ c d : Fin 7,
    (d - c = 3 ∨ d - c = 4) → ∀ a b : Fin 7,
    c ≠ a → c ≠ b → d ≠ a → d ≠ b → a ≠ b →
    TableHit tableSevenC c a b ∨ TableHit tableSevenC d a b := by
  simp only [TableHit, Edge]
  decide

/-- Exact finite identities behind the two color-scaled tables. -/
theorem seven_scaled_B : ∀ z : Fin 7, tableSevenB z = 2 * tableSevenA (4 * z) := by
  decide

theorem seven_scaled_C : ∀ z : Fin 7, tableSevenC z = 3 * tableSevenA (5 * z) := by
  decide

/-- The hand-checkable K4 edge lists, with no unlisted edges on the legal domain. -/
theorem six_A_edges_zero_two : ∀ a b : Fin 6,
    0 ≠ a → 0 ≠ b → 2 ≠ a → 2 ≠ b → a ≠ b →
    (TableHit tableSixA 0 a b ↔ Edge a b 1 3 ∨ Edge a b 1 4 ∨ Edge a b 1 5) ∧
    (TableHit tableSixA 2 a b ↔ Edge a b 1 3 ∨ Edge a b 3 4 ∨ Edge a b 4 5 ∨ Edge a b 3 5) := by
  simp only [TableHit, Edge]
  decide

theorem six_B_edges_zero_one : ∀ a b : Fin 6,
    0 ≠ a → 0 ≠ b → 1 ≠ a → 1 ≠ b → a ≠ b →
    (TableHit tableSixB 0 a b ↔ Edge a b 2 4 ∨ Edge a b 3 4 ∨ Edge a b 2 5) ∧
    (TableHit tableSixB 1 a b ↔ Edge a b 2 3 ∨ Edge a b 3 5 ∨ Edge a b 4 5 ∨ Edge a b 2 5) := by
  simp only [TableHit, Edge]
  decide

theorem six_B_edges_zero_three : ∀ a b : Fin 6,
    0 ≠ a → 0 ≠ b → 3 ≠ a → 3 ≠ b → a ≠ b →
    (TableHit tableSixB 0 a b ↔ Edge a b 1 2 ∨ Edge a b 2 4 ∨ Edge a b 1 4 ∨ Edge a b 2 5) ∧
    (TableHit tableSixB 3 a b ↔ Edge a b 1 4 ∨ Edge a b 2 5 ∨ Edge a b 4 5 ∨ Edge a b 1 5) := by
  simp only [TableHit, Edge]
  decide

/-- The two five-edge lists partition the legal K5 edges for roots zero and one. -/
theorem seven_edge_partition : ∀ a b : Fin 7,
    0 ≠ a → 0 ≠ b → 1 ≠ a → 1 ≠ b → a ≠ b →
    (TableHit tableSevenA 0 a b ↔
      Edge a b 2 5 ∨ Edge a b 2 3 ∨ Edge a b 4 5 ∨ Edge a b 3 5 ∨ Edge a b 2 6) ∧
    (TableHit tableSevenA 1 a b ↔
      Edge a b 2 4 ∨ Edge a b 3 6 ∨ Edge a b 3 4 ∨ Edge a b 5 6 ∨ Edge a b 4 6) ∧
    (TableHit tableSevenA 0 a b ∨ TableHit tableSevenA 1 a b) ∧
    ¬ (TableHit tableSevenA 0 a b ∧ TableHit tableSevenA 1 a b) := by
  simp only [TableHit, Edge]
  decide

/-- Arithmetic totals reported for the finite enumeration domains. -/
theorem enumeration_domain_arithmetic :
    (5 * ((5 - 1) * (5 - 2)) ^ 1 = 60) ∧
    (6 * ((6 - 1) * (6 - 2)) ^ 2 = 2400) ∧
    (7 * ((7 - 1) * (7 - 2)) ^ 3 = 189000) ∧
    ((6 * 5) ^ 2 = 900) ∧ ((7 * 6) ^ 3 = 74088) ∧
    (60 + 2400 + 189000 = (191460 : Nat)) := by norm_num

end ProperHats

-- Audit every declaration created in this module, including compiler auxiliaries.
open Lean in
run_cmd do
  let env ← getEnv
  let mut entries : Array (String × Array String) := #[]
  for (name, _) in env.constants.map₂.toList do
    let axioms ← Lean.collectAxioms name
    entries := entries.push (name.toString, axioms.map Name.toString)
  logInfo m!"EDEG_KERNEL_AXIOMS: {(toJson entries).compress}"
