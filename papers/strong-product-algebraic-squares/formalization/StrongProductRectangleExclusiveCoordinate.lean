import Mathlib.Data.Set.Prod

namespace StrongProductAlgebraicSquaresResearchProof1

/-- Line-cover lemma from Lemma 11: if a rectangle index `i` has a coordinate `p`
exclusive to it in the `U`-direction, then its `Z`-set must be all of `Q`, and every
other `Z`-set meets `Q` in the common width intersection `D`.

The proof is the paper's line-cover argument: the whole vertical line `{p} × Q`
must be covered, but by exclusivity only the `i`-th rectangle can cover it. -/
theorem exclusive_coordinate_forces_full_width {V W I : Type u} (P : Set V) (Q D : Set W)
    (U : I → Set V) (Z : I → Set W) (i : I) (p : V)
    (hp : p ∈ P) (excl : ∀ j, j ≠ i → p ∉ U j)
    (sub : Z i ⊆ Q)
    (cover : ∀ a ∈ P, ∀ b ∈ Q, ∃ j, a ∈ U j ∧ b ∈ Z j)
    (pairs : ∀ j, j ≠ i → Z i ∩ Z j = D) :
    Z i = Q ∧ ∀ j, j ≠ i → Z j ∩ Q = D := by
  -- Covering the line `{p} × Q` forces every `b ∈ Q` into `Z i`.
  have hfull : Q ⊆ Z i := by
    intro b hb
    obtain ⟨j, hpj, hbj⟩ := cover p hp b hb
    by_cases hji : j = i
    · subst hji; exact hbj
    · exact absurd hpj (excl j hji)
  refine ⟨Set.Subset.antisymm sub hfull, ?_⟩
  -- Since `Z i = Q`, the intersection `Z i ∩ Z j` is `Q ∩ Z j = Z j ∩ Q`.
  have hZi : Z i = Q := Set.Subset.antisymm sub hfull
  intro j hj
  rw [← pairs j hj, hZi]
  ext x
  constructor
  · rintro ⟨hxj, hxQ⟩; exact ⟨hxQ, hxj⟩
  · rintro ⟨hxQ, hxj⟩; exact ⟨hxj, hxQ⟩

end StrongProductAlgebraicSquaresResearchProof1
