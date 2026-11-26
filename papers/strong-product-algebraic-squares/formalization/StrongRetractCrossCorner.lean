import Mathlib.Combinatorics.SimpleGraph.Basic

universe u
namespace StrongProductAlgebraicSquaresResearchProof2

theorem fixed_cross_corner {V W : Type u} (G : SimpleGraph V) (H : SimpleGraph W)
         (r : V × W → V × W) (a b : V) (x y : W) (hab : G.Adj a b) (hxy : H.Adj x y)
         (hfix₁ : r (a,x) = (a,x)) (hfix₂ : r (b,y) = (b,y))
         (hid : ∀ p, r (r p) = r p)
         (hpres : ∀ p q : V × W, p ≠ q →
           (p.1 = q.1 ∨ G.Adj p.1 q.1) → (p.2 = q.2 ∨ H.Adj p.2 q.2) →
           r p ≠ r q ∧ ((r p).1 = (r q).1 ∨ G.Adj (r p).1 (r q).1)
             ∧ ((r p).2 = (r q).2 ∨ H.Adj (r p).2 (r q).2)) :
         r (b,x) = (b,x) := by
  have hdistinct₁ : (b,x) ≠ (a,x) :=
    fun heq => (G.ne_of_adj hab) (congrArg Prod.fst heq).symm
  have hdistinct₂ : (b,x) ≠ (b,y) :=
    fun heq => (H.ne_of_adj hxy) (congrArg Prod.snd heq)
  have hright := hpres (b,x) (a,x) hdistinct₁ (Or.inr (G.symm hab)) (Or.inl rfl)
  have hleft := hpres (b,x) (b,y) hdistinct₂ (Or.inl rfl) (Or.inr hxy)
  rw [hfix₁] at hright
  rw [hfix₂] at hleft
  by_contra hne
  have himage := hpres (r (b,x)) (b,x) hne hleft.2.1 hright.2.2
  exact himage.1 (hid (b,x))

end StrongProductAlgebraicSquaresResearchProof2
