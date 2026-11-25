import SmallCoverBases

set_option autoImplicit false
open Finset

namespace ReciprocalSearch

open Classical
noncomputable section

def trapChoices (V : Type*) [Fintype V] (k : ℕ) : Finset (Finset V) :=
  (univ : Finset V).powersetCard k

lemma trap_choices_card (V : Type*) [Fintype V] (k : ℕ) :
    (trapChoices V k).card = (Fintype.card V).choose k := by
  simp [trapChoices, card_powersetCard]

lemma trap_choices_nonempty (V : Type*) [Fintype V] (k : ℕ) (hk : k ≤ Fintype.card V) :
    Nonempty (trapChoices V k) := by
  have h : 0 < (trapChoices V k).card := by
    rw [trap_choices_card]
    exact Nat.choose_pos hk
  obtain ⟨t, ht⟩ := card_pos.mp h
  exact ⟨⟨t, ht⟩⟩

noncomputable def hypergraphGame {V : Type*} [Fintype V] (edges : Finset (Finset V)) (k : ℕ)
    (w : V → ℝ) (hw : ∀ v, 0 < w v) (hedge : ∀ e ∈ edges, e.Nonempty) :
    RewardGame edges (trapChoices V k) where
  reward a := ∑ v ∈ a.val, w v
  safe a h := Disjoint a.val h.val
  reward_pos a := sum_pos (fun v _ => hw v) (hedge a.val a.property)

lemma choose_le_three_of_small (n k : ℕ) (hn : n ≤ 3) (hk : k ≤ n) :
    n.choose k ≤ 3 := by
  interval_cases n <;> interval_cases k <;> decide

theorem small_hypergraph_has_optimal_reciprocal {V : Type*} [Fintype V]
    (edges : Finset (Finset V)) (hne : edges.Nonempty) (k : ℕ) (hk : k ≤ Fintype.card V)
    (w : V → ℝ) (hw : ∀ v, 0 < w v) (hedge : ∀ e ∈ edges, e.Nonempty)
    (hs : edges.card ≤ 3 ∨ Fintype.card V ≤ 3) :
    letI : Nonempty (trapChoices V k) := trap_choices_nonempty V k hk
    let g := hypergraphGame edges k w hw hedge
    ∃ s : Finset edges, s.Nonempty ∧ g.guarantee (g.reciprocal s) = g.value := by
  letI : Nonempty edges := ⟨⟨hne.choose, hne.choose_spec⟩⟩
  letI : Nonempty (trapChoices V k) := trap_choices_nonempty V k hk
  apply RewardGame.small_game_has_optimal_reciprocal
  rcases hs with h | h
  · left
    simpa only [Fintype.card_coe] using h
  · right
    rw [Fintype.card_coe, trap_choices_card]
    exact choose_le_three_of_small _ _ h hk

end
end ReciprocalSearch

#print axioms ReciprocalSearch.small_hypergraph_has_optimal_reciprocal
