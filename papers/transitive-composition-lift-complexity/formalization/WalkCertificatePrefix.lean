import Init.Data.List.TakeDrop

/-!
Frozen source: cases/transitive-composition-lift-complexity/paper.md at
 ef48cab17a4694cda69dea04d7a488bc01c1aa67, lines 536–548, Lemma 5.1.
-/

namespace TransitiveCompositionLiftComplexityResearchProof1

universe u

/-- The forced prefix from the walk identity (5.1), including an empty label list. -/
theorem forced_prefix {α : Type u} (u p labels v : List α)
    (h : u ++ p = labels ++ v) (hL : labels.length ≤ u.length) :
    u.take labels.length = labels := by
  calc
    u.take labels.length = (u ++ p).take labels.length :=
      (List.take_append_of_le_length hL).symm
    _ = (labels ++ v).take labels.length := congrArg (List.take labels.length) h
    _ = labels := List.take_left

end TransitiveCompositionLiftComplexityResearchProof1
