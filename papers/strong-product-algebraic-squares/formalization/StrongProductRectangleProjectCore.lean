import Mathlib.Data.Set.Prod

namespace StrongProductAlgebraicSquaresResearchProof1

theorem rectangle_intersection_core {V W : Type u} (U₀ U₁ : Set V) (W₀ W₁ : Set W) :
    (U₀ ×ˢ W₀) ∩ (U₁ ×ˢ W₁) = (U₀ ∩ U₁) ×ˢ (W₀ ∩ W₁) := by
  ext p
  simp only [Set.mem_inter_iff, Set.mem_prod, Set.mem_setOf_eq]
  constructor
  · rintro ⟨⟨hp₀₁, hp₀₂⟩, hp₁₁, hp₁₂⟩
    exact ⟨⟨hp₀₁, hp₁₁⟩, ⟨hp₀₂, hp₁₂⟩⟩
  · rintro ⟨⟨hp₀₁, hp₁₁⟩, ⟨hp₀₂, hp₁₂⟩⟩
    exact ⟨⟨hp₀₁, hp₀₂⟩, ⟨hp₁₁, hp₁₂⟩⟩

end StrongProductAlgebraicSquaresResearchProof1
