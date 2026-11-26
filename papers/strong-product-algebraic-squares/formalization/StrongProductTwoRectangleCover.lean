import Mathlib.Data.Set.Prod

universe u
namespace StrongProductAlgebraicSquaresResearchProof3

theorem two_rectangle_cover {V W : Type u} (P U₀ U₁ : Set V) (Q W₀ W₁ : Set W)
         (hU0 : U₀ ⊆ P) (hU1 : U₁ ⊆ P) (hW0 : W₀ ⊆ Q) (hW1 : W₁ ⊆ Q)
         (proper0 : U₀ ×ˢ W₀ ≠ P ×ˢ Q) (proper1 : U₁ ×ˢ W₁ ≠ P ×ˢ Q)
         (cover : (U₀ ×ˢ W₀) ∪ (U₁ ×ˢ W₁) = P ×ˢ Q) :
         (W₀ = Q ∧ W₁ = Q ∧ U₀ ∪ U₁ = P) ∨
         (U₀ = P ∧ U₁ = P ∧ W₀ ∪ W₁ = Q) := by
  have missing {ι : Type u} {A B : Set ι} (hAB : A ⊆ B) (hne : A ≠ B) :
      ∃ i ∈ B, i ∉ A := Set.not_subset.mp (fun hBA => hne (Set.Subset.antisymm hAB hBA))
  have from_cover (p : V) (q : W) (hp : p ∈ P) (hq : q ∈ Q) :
      (p ∈ U₀ ∧ q ∈ W₀) ∨ (p ∈ U₁ ∧ q ∈ W₁) := by
    change (p,q) ∈ (U₀ ×ˢ W₀) ∪ (U₁ ×ˢ W₁)
    rw [cover]
    exact ⟨hp,hq⟩
  by_cases hu : U₀ = P
  · have hw : W₀ ≠ Q := fun heq => proper0 (by rw [hu, heq])
    obtain ⟨w, hwQ, hw0⟩ := missing hW0 hw
    have hU₁eq : U₁ = P := Set.Subset.antisymm hU1 (fun p hp =>
      ((from_cover p w hp hwQ).resolve_left (fun h => hw0 h.2)).1)
    have hP : ∃ p, p ∈ P := by
      obtain ⟨z,hz,_⟩ := missing (Set.prod_mono hU0 hW0) proper0
      exact ⟨z.1, hz.1⟩
    right
    refine ⟨hu, hU₁eq, Set.Subset.antisymm (Set.union_subset hW0 hW1) ?_⟩
    obtain ⟨p,hp⟩ := hP
    intro q hq
    exact (from_cover p q hp hq).elim (fun hm => Or.inl hm.2) (fun hm => Or.inr hm.2)
  · obtain ⟨p,hpP,hp0⟩ := missing hU0 hu
    have hw1 : W₁ = Q := Set.Subset.antisymm hW1 (fun q hq =>
      ((from_cover p q hpP hq).resolve_left (fun h => hp0 h.1)).2)
    have hu1 : U₁ ≠ P := fun heq => proper1 (by rw [hw1,heq])
    obtain ⟨p',hpP',hp1⟩ := missing hU1 hu1
    have hw0 : W₀ = Q := Set.Subset.antisymm hW0 (fun q hq =>
      ((from_cover p' q hpP' hq).resolve_right (fun h => hp1 h.1)).2)
    have hQ : ∃ q, q ∈ Q := by
      obtain ⟨z,hz,_⟩ := missing (Set.prod_mono hU0 hW0) proper0
      exact ⟨z.2, hz.2⟩
    left
    refine ⟨hw0,hw1, Set.Subset.antisymm (Set.union_subset hU0 hU1) ?_⟩
    obtain ⟨q,hq⟩ := hQ
    intro v hv
    exact (from_cover v q hv hq).elim (fun hm => Or.inl hm.1) (fun hm => Or.inr hm.1)

end StrongProductAlgebraicSquaresResearchProof3
