import Mathlib.Data.Set.Prod

namespace StrongProductAlgebraicSquaresResearchProof1

/-- Lemma 11, complementary coordinate case.

If all first-coordinate sets `U i` lie inside a common set `C ⊆ P`, and the
rectangles `U i × Z i` cover the full product `P × Q` with `Q` nonempty, then
`C` must exhaust `P`.  This is the step in the proof of Lemma 11 where, in the
case "every `U i = C`", the covering property forces `C = P`, giving the
coordinate-interchanged conclusion. -/
theorem shared_first_coordinates_exhaust {V W I : Type u} (P C : Set V) (Q : Set W)
    (U : I → Set V) (Z : I → Set W) (hC : C ⊆ P) (hQ : Q.Nonempty)
    (hsub : ∀ i, U i ⊆ C)
    (hcover : ∀ p ∈ P, ∀ q ∈ Q, ∃ j, p ∈ U j ∧ q ∈ Z j) :
    C = P := by
  apply Set.Subset.antisymm hC
  intro p hp
  obtain ⟨q, hq⟩ := hQ
  obtain ⟨j, hpj, _⟩ := hcover p hp q hq
  exact hsub j hpj

end StrongProductAlgebraicSquaresResearchProof1
