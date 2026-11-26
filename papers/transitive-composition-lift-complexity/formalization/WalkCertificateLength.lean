import Init.Data.List.Lemmas

/-!
Frozen source: cases/transitive-composition-lift-complexity/paper.md at
 ef48cab17a4694cda69dea04d7a488bc01c1aa67, lines 536–548, Lemma 5.1.
-/

namespace TransitiveCompositionLiftComplexityResearchProof1

universe u

/-- The length bound obtained from the walk identity (5.1). -/
theorem length_bound {α : Type u} (u p labels v : List α)
    (h : u ++ p = labels ++ v) : u.length ≤ labels.length + v.length := by
  have lengths : u.length + p.length = labels.length + v.length := by
    simpa only [List.length_append] using congrArg List.length h
  calc
    u.length ≤ u.length + p.length := Nat.le_add_right _ _
    _ = labels.length + v.length := lengths

end TransitiveCompositionLiftComplexityResearchProof1
