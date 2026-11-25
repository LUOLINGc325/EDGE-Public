import OptimalFactor
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic.FinCases

namespace TwoColorNullity.PublishedInstance

/-- Rotate an 18-bit signature left, with coordinate zero at the low bit. -/
def rotate (word offset : ℕ) : ℕ :=
  (word * 2 ^ offset) % (2 ^ 18) + word / 2 ^ (18 - offset)

/-- The first two seeds use all rotations. The third omits offset zero. -/
def word (item : Fin 53) : ℕ :=
  if item.val < 18 then rotate 129230 item.val
  else if item.val < 36 then rotate 122009 (item.val - 18)
  else rotate 142039 (item.val - 35)

def tags (agent : Fin 18) (item : Fin 53) : Bool := (word item).testBit agent.val

/-- The inverse ownership map of the table in the frozen manuscript. -/
def assign : Fin 53 → Fin 18 :=
  ![0, 0, 2, 0, 3, 0, 6, 7, 1, 1, 1, 8, 0, 1, 4, 11, 7, 12, 4, 4, 13, 4, 5, 15,
    11, 5, 5, 15, 5, 8, 9, 9, 9, 6, 17, 9, 12, 10, 10, 10, 2, 10, 14, 14, 14, 17,
    14, 16, 16, 13, 16, 16, 3]

theorem words_distinct : Function.Injective word := by
  intro g h he
  revert h he
  fin_cases g <;> decide

set_option maxRecDepth 8192 in
set_option maxHeartbeats 2500000 in
theorem assignment_natural_checks (i : Fin 18) : ∀ j : Fin 18, ∀ g : Fin 53,
    g ∈ bundle assign i → cost tags i ((bundle assign i).erase g) ≤ 2 * cost tags i (bundle assign j) := by
  fin_cases i <;> decide

theorem assignment_two_EFX : ApproxEFX tags assign 2 := by
  intro i j g hg
  exact_mod_cast assignment_natural_checks i j g hg

theorem optimum_at_most_two : optimalFactor tags ≤ 2 :=
  optimalFactor_le tags 2 (by norm_num) assignment_two_EFX

end TwoColorNullity.PublishedInstance
