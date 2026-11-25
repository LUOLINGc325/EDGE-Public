import Lean.Elab.Command
import Lean.Util.CollectAxioms
import Lean.Data.Json

set_option autoImplicit false

namespace ProperHats

/-- The root sees the ordered pair of colors on each triangle's two leaves. -/
abbrev Views (r q : Nat) := Fin r → Fin q × Fin q

/-- Every leaf sees only the root and its partner. The root sees all leaves. -/
structure Strategy (r q : Nat) where
  left : Fin r → Fin q → Fin q → Fin q
  right : Fin r → Fin q → Fin q → Fin q
  center : Views r q → Fin q

/-- Exactly the proper-coloring constraints on the triangular windmill. -/
def Proper {r q : Nat} (c : Fin q) (x : Views r q) : Prop :=
  ∀ i, c ≠ (x i).1 ∧ c ≠ (x i).2 ∧ (x i).1 ≠ (x i).2

def Wins {r q : Nat} (s : Strategy r q) : Prop :=
  ∀ c x, Proper c x → s.center x = c ∨
    ∃ i, s.left i c (x i).2 = (x i).1 ∨ s.right i c (x i).1 = (x i).2

def Solvable (r q : Nat) : Prop := ∃ s : Strategy r q, Wins s

/-- A single leaf pair rules out simultaneous failure under two root colors. -/
def Separates {r q : Nat}
    (A B : Fin r → Fin q → Fin q → Fin q) (c d : Fin q) : Prop :=
  ∃ i, ∀ a b, c ≠ a → c ≠ b → d ≠ a → d ≠ b → a ≠ b →
    A i c b = a ∨ B i c a = b ∨ A i d b = a ∨ B i d a = b

def PairCover {r q : Nat} (A B : Fin r → Fin q → Fin q → Fin q) : Prop :=
  ∀ c d, c ≠ d → Separates A B c d

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
