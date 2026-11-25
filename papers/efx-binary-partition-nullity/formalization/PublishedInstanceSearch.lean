import Mathlib.Data.Nat.Bitwise

namespace TwoColorNullity.PublishedInstance

def searchedWords : List ℕ :=
  [129230, 258460, 254777, 247411, 232679, 203215, 144287, 26431, 52862,
    105724, 211448, 160753, 59363, 118726, 237452, 212761, 163379, 64615,
    122009, 244018, 225893, 189643, 117143, 234286, 206429, 150715, 39287,
    78574, 157148, 52153, 104306, 208612, 155081, 48019, 96038, 192076,
    21935, 43870, 87740, 175480, 88817, 177634, 93125, 186250, 110357,
    220714, 179285, 96427, 192854, 123565, 247130, 232117, 202091]

/-- Extend the table to the empty and full coordinate sets. -/
def sizeBound (size : ℕ) : ℕ :=
  (#[26, 26, 26, 26, 25, 23, 20, 14, 10, 7, 4, 3, 2, 1, 0, 0, 0, 0, 0][size]?).getD 0

def bucketScore (buckets : List (List ℕ)) : ℕ :=
  (buckets.map fun bucket => bucket.length / 2).sum

def keepPaired (bucket : List ℕ) : List (List ℕ) :=
  if 2 ≤ bucket.length then [bucket] else []

def refineBuckets (coordinate : Fin 18) (buckets : List (List ℕ)) : List (List ℕ) :=
  buckets.flatMap fun bucket =>
    let children := bucket.partition (fun word => word.testBit coordinate.val)
    keepPaired children.1 ++ keepPaired children.2

/-- Accept all completions when the current score is at most the bound for the largest completion. -/
def checkBounds : List (Fin 18) → ℕ → List (List ℕ) → Bool
  | [], selected, buckets => decide (bucketScore buckets ≤ sizeBound selected)
  | coordinate :: next, selected, buckets =>
      if bucketScore buckets ≤ sizeBound (selected + next.length + 1) then true
      else checkBounds next selected buckets &&
        checkBounds next (selected + 1) (refineBuckets coordinate buckets)

theorem checkBounds_from_children (coordinate : Fin 18) (next : List (Fin 18))
    (selected : ℕ) (buckets : List (List ℕ))
    (exclude : checkBounds next selected buckets = true)
    (includeBit : checkBounds next (selected + 1) (refineBuckets coordinate buckets) = true) :
    checkBounds (coordinate :: next) selected buckets = true := by
  simp [checkBounds, exclude, includeBit]

/-- Refine along selected coordinates in their original order. -/
def refineAlong : List (Fin 18) → List (List ℕ) → List (List ℕ)
  | [], buckets => buckets
  | coordinate :: next, buckets => refineAlong next (refineBuckets coordinate buckets)

end TwoColorNullity.PublishedInstance
