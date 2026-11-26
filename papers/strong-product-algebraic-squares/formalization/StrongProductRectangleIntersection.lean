import Mathlib.Data.Set.Prod

namespace StrongProductAlgebraicSquaresResearchProof3

/-- Final (nonempty-intersection) part of Lemma 6: if two rectangles intersect,
then each of their coordinate sets intersects, witnessed coordinatewise. -/
theorem common_rectangle_coordinates {V W : Type u} (U₀ U₁ : Set V) (W₀ W₁ : Set W)
    (h : ((U₀ ×ˢ W₀) ∩ (U₁ ×ˢ W₁)).Nonempty) :
    (U₀ ∩ U₁).Nonempty ∧ (W₀ ∩ W₁).Nonempty := by
  obtain ⟨x, hx⟩ := h
  obtain ⟨hx₀, hx₁⟩ := hx
  rw [Set.mem_prod] at hx₀ hx₁
  exact ⟨⟨x.1, hx₀.1, hx₁.1⟩, ⟨x.2, hx₀.2, hx₁.2⟩⟩

end StrongProductAlgebraicSquaresResearchProof3
