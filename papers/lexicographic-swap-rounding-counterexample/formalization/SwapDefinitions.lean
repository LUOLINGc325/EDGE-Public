import Std

/-!
Executable CVZ MergeBases for the uniform matroid U(3,6).
Coordinates in this file are zero-based; a basis is its six-bit Nat mask.
The probability type is generic: the same algorithm is instantiated with
rationals for the finite kernel certificate and reals for the parameter family.
Explicit noncomputable definition modifiers suppress unused native implementations;
all definitions remain transparent and all finite certificates reduce them in
Lean's kernel.  No compiled/native result is used as a proof.
-/

namespace SwapRounding

noncomputable section

abbrev Base := Nat
abbrev Law (α : Type) := List (Base × α)

noncomputable def member (s i : Nat) : Bool := s / 2 ^ i % 2 == 1

noncomputable def isBase (s : Base) : Bool :=
  (s < 64) && ((List.range 6).filter (member s)).length == 3

noncomputable def replace (s i j : Nat) : Nat := s - 2 ^ i + 2 ^ j

/-- Minimum left-only element, then minimum legal right-only exchange. -/
noncomputable def exchange (left right : Base) : Option (Nat × Nat) := do
  let i ← (List.range 6).find? (fun i => member left i && !member right i)
  let j ← (List.range 6).find? (fun j =>
    member right j && !member left j &&
      isBase (replace left i j) && isBase (replace right j i))
  return (i, j)

inductive MergeTree (α : Type) where
  | done (basis : Base)
  | failure (left right : Base)
  | branch (left right i j : Nat) (pLeft pRight : α)
      (childLeft childRight : MergeTree α)

/--
CVZ's weights are fixed throughout each MergeBases call.
With probability b/(a+b), modify the left base; with probability a/(a+b),
modify the right base.  Fuel exhaustion is an explicit failure, not a leaf.
-/
noncomputable def merge {α : Type} [Add α] [Div α]
    (fuel : Nat) (a b : α) (left right : Base) : MergeTree α :=
  if left == right then .done left
  else match fuel with
    | 0 => .failure left right
    | k + 1 => match exchange left right with
      | none => .failure left right
      | some (i, j) =>
        .branch left right i j (b / (a + b)) (a / (a + b))
          (merge k a b (replace left i j) right)
          (merge k a b left (replace right j i))

noncomputable def scaleLaw {α : Type} [Mul α] (p : α) (law : Law α) : Law α :=
  law.map (fun (s, q) => (s, p * q))

noncomputable def treeLaw {α : Type} [OfNat α 1] [Mul α] : MergeTree α → Law α
  | .done s => [(s, 1)]
  | .failure _ _ => []
  | .branch _ _ _ _ p q l r => scaleLaw p (treeLaw l) ++ scaleLaw q (treeLaw r)

noncomputable def expectLaw {α : Type} [Zero α] [Add α] [Mul α]
    (law : Law α) (f : Base → α) : α :=
  (law.map (fun (s, p) => p * f s)).foldr (· + ·) 0

noncomputable def expect {α : Type} [Zero α] [Add α] [Mul α] [OfNat α 1]
    (tree : MergeTree α) (f : Base → α) : α :=
  expectLaw (treeLaw tree) f

noncomputable def bindLaw {α : Type} [Mul α] (law : Law α) (k : Base → Law α) : Law α :=
  law.flatMap (fun (s, p) => scaleLaw p (k s))

noncomputable def firstBase : Base := 7
noncomputable def secondBase : Base := 11
noncomputable def thirdBase : Base := 52

/-- Ordered decomposition: {1,2,3}, then {1,2,4}, then {3,5,6}. -/
noncomputable def swapLaw {α : Type} [Add α] [Div α] [Mul α] [OfNat α 1]
    (a b c : α) : Law α :=
  bindLaw (treeLaw (merge 6 a b firstBase secondBase))
    (fun first => treeLaw (merge 6 (a + b) c first thirdBase))

noncomputable def swapExpected {α : Type} [Zero α] [Add α] [Div α] [Mul α] [OfNat α 1]
    (a b c : α) (f : Base → α) : α :=
  expectLaw (swapLaw a b c) f

noncomputable def coordinate {α : Type} [Zero α] [OfNat α 1] (i : Nat) (s : Base) : α :=
  if member s i then 1 else 0

/-- The increasing event X₂ = X₅ = 1, in one-based mathematical notation. -/
noncomputable def witnessEvent (s : Base) : Bool := member s 1 && member s 4

noncomputable def eventIndicator {α : Type} [Zero α] [OfNat α 1] (s : Base) : α :=
  if witnessEvent s then 1 else 0

noncomputable def jointIndicator {α : Type} [Zero α] [OfNat α 1] (s : Base) : α :=
  if member s 2 && witnessEvent s then 1 else 0

noncomputable def maskSubset (s t : Base) : Bool :=
  (List.range 6).all (fun i => !member s i || member t i)

noncomputable def sameOutside (i : Nat) (s t : Base) : Bool :=
  (List.range 6).all (fun j => j == i || member s j == member t j)

theorem event_upset : ∀ s t : Fin 64,
    maskSubset s.val t.val = true → witnessEvent s.val = true → witnessEvent t.val = true := by
  decide +kernel

theorem event_ignores_third : ∀ s t : Fin 64,
    sameOutside 2 s.val t.val = true → witnessEvent s.val = witnessEvent t.val := by
  decide +kernel

/--
Structural audit independent of probabilities.  It rejects every failure,
checks the incoming states, legal minimum exchange, and every child state,
and accepts a terminal only when both bases have genuinely coalesced.
-/
noncomputable def certifiesMerge {α : Type} (left right : Base) : MergeTree α → Bool
  | .done s => left == right && s == left && isBase s
  | .failure _ _ => false
  | .branch l r i j _ _ childLeft childRight =>
    left == l && right == r && left != right &&
    isBase left && isBase right && exchange left right == some (i, j) &&
    certifiesMerge (replace left i j) right childLeft &&
    certifiesMerge left (replace right j i) childRight

theorem first_merge_valid {α : Type} [Add α] [Div α] (a b : α) :
    certifiesMerge firstBase secondBase (merge 6 a b firstBase secondBase) = true := by
  rfl

theorem second_merge_from_first_valid {α : Type} [Add α] [Div α] (s c : α) :
    certifiesMerge firstBase thirdBase (merge 6 s c firstBase thirdBase) = true := by
  rfl

theorem second_merge_from_second_valid {α : Type} [Add α] [Div α] (s c : α) :
    certifiesMerge secondBase thirdBase (merge 6 s c secondBase thirdBase) = true := by
  rfl

end

end SwapRounding
