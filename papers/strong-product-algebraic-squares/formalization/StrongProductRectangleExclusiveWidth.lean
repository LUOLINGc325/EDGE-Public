import Mathlib.Data.Set.Prod

namespace StrongProductAlgebraicSquaresResearchProof1

theorem exclusive_width_forces_full_height {V W I : Type u} (P : Set V) (Q : Set W)
    (U : I → Set V) (Z : I → Set W) (i : I) (w : W)
    (hw : w ∈ Q) (hex : ∀ j, j ≠ i → w ∉ Z j) (hsub : U i ⊆ P)
    (hcover : ∀ p ∈ P, ∀ q ∈ Q, ∃ j, p ∈ U j ∧ q ∈ Z j) :
    U i = P := by
  apply Set.Subset.antisymm hsub
  intro p hp
  obtain ⟨j, hp', hw'⟩ := hcover p hp w hw
  have hj : j = i := by
    by_contra hne
    exact hex j hne hw'
  simpa [hj] using hp'

end StrongProductAlgebraicSquaresResearchProof1
