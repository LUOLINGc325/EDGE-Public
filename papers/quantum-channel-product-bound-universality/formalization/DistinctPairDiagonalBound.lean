import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Prod
import Lean.Elab.Tactic.Omega

namespace QuantumChannelProductBoundUniversalityResearchProof2

theorem diagonal_incidence {ι : Type*} [DecidableEq ι] (S : Finset (ι × ι)) (i : ι) : (S.filter (fun t => t.1=i)).card+(S.filter (fun t => t.2=i)).card ≤ S.card+1 := by
  let A := S.filter (fun t => t.1 = i)
  let B := S.filter (fun t => t.2 = i)
  change A.card + B.card ≤ S.card + 1
  have hunion : A ∪ B ⊆ S := Finset.union_subset (Finset.filter_subset _ _) (Finset.filter_subset _ _)
  have hinter : A ∩ B ⊆ {(i,i)} := by
    intro t ht
    simp only [A, B, Finset.mem_inter, Finset.mem_filter, Finset.mem_singleton] at ht ⊢
    exact Prod.ext ht.1.2 ht.2.2
  have hc : (A ∩ B).card ≤ 1 := by simpa using Finset.card_le_card hinter
  rw [← Finset.card_union_add_card_inter]
  exact Nat.add_le_add (Finset.card_le_card hunion) hc

end QuantumChannelProductBoundUniversalityResearchProof2
