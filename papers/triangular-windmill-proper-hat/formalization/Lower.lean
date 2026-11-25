import Core
import Mathlib.Data.Fintype.Basic

set_option autoImplicit false
set_option maxRecDepth 100000
set_option maxHeartbeats 0
set_option synthInstance.maxSize 100000
set_option maxSynthPendingDepth 1000

namespace ProperHats

/-- Five-color one-triangle leaf table. This is the known complete-graph case. -/
noncomputable def tableFive (z : Fin 5) : Fin 5 :=
  match z.val with
  | 0 => 0
  | 1 => 2
  | 2 => 4
  | 3 => 1
  | _ => 3

/-- The first six-color blade separates root differences ±2. -/
noncomputable def tableSixA (z : Fin 6) : Fin 6 :=
  match z.val with
  | 0 => 0
  | 1 => 2
  | 2 => 3
  | _ => 1

/-- The second six-color blade separates root differences ±1 and 3. -/
noncomputable def tableSixB (z : Fin 6) : Fin 6 :=
  match z.val with
  | 0 => 0
  | 1 => 2
  | 2 => 4
  | 3 => 4
  | 4 => 1
  | _ => 2

/-- Seven-color blade separating root differences ±1. -/
noncomputable def tableSevenA (z : Fin 7) : Fin 7 :=
  match z.val with
  | 0 => 0
  | 1 => 3
  | 2 => 5
  | 3 => 2
  | 4 => 5
  | 5 => 3
  | _ => 2

/-- Seven-color blade separating root differences ±2. -/
noncomputable def tableSevenB (z : Fin 7) : Fin 7 :=
  match z.val with
  | 0 => 0
  | 1 => 3
  | 2 => 6
  | 3 => 6
  | 4 => 3
  | _ => 4

/-- Seven-color blade separating root differences ±3. -/
noncomputable def tableSevenC (z : Fin 7) : Fin 7 :=
  match z.val with
  | 0 => 0
  | 1 => 2
  | 2 => 6
  | 3 => 2
  | 4 => 6
  | _ => 1

/-- Both leaves use a translated copy of the same table in their blade. -/
noncomputable def leafFive (_i : Fin 1) (c u : Fin 5) : Fin 5 :=
  c + tableFive (u - c)

noncomputable def leafSix (i : Fin 2) (c u : Fin 6) : Fin 6 :=
  c + (if i.val = 0 then tableSixA (u - c) else tableSixB (u - c))

noncomputable def leafSeven (i : Fin 3) (c u : Fin 7) : Fin 7 :=
  c + (match i.val with
    | 0 => tableSevenA (u - c)
    | 1 => tableSevenB (u - c)
    | _ => tableSevenC (u - c))

/-- Every two distinct root colors are separated in the five-color witness. -/
theorem pair_cover_five : PairCover leafFive leafFive := by
  unfold PairCover Separates
  decide

/-- Every two distinct root colors are separated by one of the two six-color blades. -/
theorem pair_cover_six : PairCover leafSix leafSix := by
  unfold PairCover Separates
  decide

/-- Every two distinct root colors are separated by one of the three seven-color blades. -/
theorem pair_cover_seven : PairCover leafSeven leafSeven := by
  unfold PairCover Separates
  decide

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
