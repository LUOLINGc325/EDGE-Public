import Lean
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.Fin
import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Sum
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Option.Basic
import Mathlib.Order.Monotone.Basic

set_option autoImplicit false

namespace Subcubic

universe u v w

structure Graph (V : Type u) where
  edge : V → V → Bool
  symmetric : ∀ x y, edge x y = edge y x
  loopless : ∀ x, edge x x = false

abbrev Adj {V : Type u} (G : Graph V) (x y : V) : Prop := G.edge x y = true

abbrev Coloring (V : Type u) (C : Type v) := V → Option C

variable {V : Type u} {C : Type v} {A : Type w}
variable [Fintype V] [DecidableEq V] [Fintype C] [DecidableEq C]

noncomputable def neighbors (G : Graph V) (x : V) : Finset V :=
  Finset.univ.filter (fun y => Adj G x y)

noncomputable def degree (G : Graph V) (x : V) : Nat := (neighbors G x).card

noncomputable def holes (q : Coloring V C) : Finset V :=
  Finset.univ.filter (fun x => q x = none)

noncomputable def neighborColors (G : Graph V) (q : Coloring V C) (x : V) : Finset C :=
  Finset.univ.filter (fun c => ∃ y : V, Adj G x y ∧ q y = some c)

noncomputable def tau (G : Graph V) (q : Coloring V C) (x : V) : Nat :=
  (neighborColors G q x).card

noncomputable def utility (G : Graph V) (q : Coloring V C) (c : C) (x : V) : Nat :=
  ((neighborColors G q x).erase c).card

noncomputable def sameNeighbors (G : Graph V) (q : Coloring V C) (c : C) (x : V) : Finset V :=
  (neighbors G x).filter (fun y => q y = some c)

noncomputable def alienNeighbors (G : Graph V) (q : Coloring V C) (c : C) (x : V) : Finset V :=
  (neighbors G x).filter (fun y => q y ≠ none ∧ q y ≠ some c)

noncomputable def sameCount (G : Graph V) (q : Coloring V C) (c : C) (x : V) : Nat :=
  (sameNeighbors G q c x).card

noncomputable def alienCount (G : Graph V) (q : Coloring V C) (c : C) (x : V) : Nat :=
  (alienNeighbors G q c x).card

noncomputable def put (q : Coloring V C) (x : V) (c : C) : Coloring V C :=
  Function.update q x (some c)

noncomputable def erase (q : Coloring V C) (x : V) : Coloring V C :=
  Function.update q x none

noncomputable def TE (G : Graph V) (q : Coloring V C) : Nat :=
  ∑ x ∈ holes q, tau G q x

noncomputable def D (G : Graph V) (q : Coloring V C) : Nat :=
  ∑ x ∈ holes q, degree G x

noncomputable def monoTerm (G : Graph V) (q : Coloring V C) (x y : V) : Nat :=
  if Adj G x y ∧ q x ≠ none ∧ q x = q y then 1 else 0

noncomputable def monoArcs (G : Graph V) (q : Coloring V C) : Nat :=
  ∑ x : V, ∑ y : V, monoTerm G q x y

noncomputable def emptyTerm (G : Graph V) (q : Coloring V C) (x y : V) : Nat :=
  if Adj G x y ∧ q x = none ∧ q y = none then 1 else 0

noncomputable def emptyArcs (G : Graph V) (q : Coloring V C) : Nat :=
  ∑ x : V, ∑ y : V, emptyTerm G q x y

/-- The manuscript potential Ψ, expressed using ordered edge counts. -/
noncomputable def potential (G : Graph V) (q : Coloring V C) : Nat :=
  8 * TE G q + 4 * monoArcs G q + emptyArcs G q + 4 * D G q

/-- The larger raw-color state space. Agent identities are reintroduced by the final projection. -/
noncomputable def Improves (G : Graph V) (q q' : Coloring V C) : Prop :=
  ∃ s d : V, ∃ c : C,
    q s = some c ∧ q d = none ∧
    q' = put (erase q s) d c ∧ utility G q c s < utility G q' c d

noncomputable def MaxDegreeThree (G : Graph V) : Prop := ∀ x : V, degree G x ≤ 3

noncomputable def FiniteImprovementProperty (G : Graph V) : Prop :=
  ¬ ∃ q : Nat → Coloring V C, (holes (q 0)).card = 2 ∧
    ∀ t : Nat, Improves G (q t) (q (t + 1))

noncomputable def Equilibrium (G : Graph V) (q : Coloring V C) : Prop :=
  ∀ q', ¬ Improves G q q'

noncomputable def project (typeOf : A → C) (q : V → Option A) : Coloring V C :=
  fun x => (q x).map typeOf

noncomputable def WellFormed (q : V → Option A) : Prop :=
  ∀ a : A, ∃! x : V, q x = some a

noncomputable def LabelledImproves (G : Graph V) (typeOf : A → C)
    (q q' : V → Option A) : Prop :=
  ∃ s d : V, ∃ a : A,
    q s = some a ∧ q d = none ∧
    q' = Function.update (Function.update q s none) d (some a) ∧
    utility G (project typeOf q) (typeOf a) s <
      utility G (project typeOf q') (typeOf a) d

end Subcubic
