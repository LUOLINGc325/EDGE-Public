import Init.Data.List.Lemmas

universe u

namespace TransitiveCompositionLiftComplexityResearchProof1

/-- Concatenating two compatible word certificates preserves the endpoint identity.

This is the induction step for successive edge substitutions in Lemma 5.1 (5.1):
from `u ++ p = x ++ v` and `v ++ q = y ++ w` we obtain
`u ++ (p ++ q) = (x ++ y) ++ w`, for an arbitrary alphabet and arbitrary labels. -/
theorem compose_word_certificates {α : Type u} (u v w p q x y : List α)
    (h₁ : u ++ p = x ++ v) (h₂ : v ++ q = y ++ w) :
    u ++ (p ++ q) = (x ++ y) ++ w := by
  calc
    u ++ (p ++ q) = (u ++ p) ++ q := (List.append_assoc u p q).symm
    _ = (x ++ v) ++ q := congrArg (· ++ q) h₁
    _ = x ++ (v ++ q) := List.append_assoc x v q
    _ = x ++ (y ++ w) := congrArg (x ++ ·) h₂
    _ = (x ++ y) ++ w := (List.append_assoc x y w).symm

end TransitiveCompositionLiftComplexityResearchProof1
