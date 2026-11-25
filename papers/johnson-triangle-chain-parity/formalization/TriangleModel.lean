import JohnsonCore

namespace Review15Johnson
open Finset
variable {α : Type*} [DecidableEq α]

/-- The square of a path on n chain vertices, with one extra vertex adjacent
    exactly to the two endpoints. Chain indices are 0,...,n-1. Values outside
    this range are immaterial. The structure states exactly a finite uniform
    set representation, including injectivity and both edge/nonedge directions. -/
structure ClosedChainRep (n : ℕ) (α : Type*) [DecidableEq α] where
  k : ℕ
  k_pos : 0 < k
  chain : ℕ → Finset α
  extra : Finset α
  card_chain : ∀ j, j < n → (chain j).card = k
  card_extra : extra.card = k
  injective_chain : ∀ i j, i < n → j < n → chain i = chain j → i = j
  extra_distinct : ∀ j, j < n → extra ≠ chain j
  chain_adj : ∀ i j, i < n → j < n →
    (Adj (chain i) (chain j) ↔ i ≠ j ∧ i ≤ j + 2 ∧ j ≤ i + 2)
  extra_adj : ∀ j, j < n → (Adj extra (chain j) ↔ j = 0 ∨ j + 1 = n)

/-- This is the intersection-cardinality convention in the manuscript; the
    difference formulation of Adj is equivalent when the common size is positive. -/
theorem adj_iff_inter_card {X Y : Finset α} {k : ℕ}
    (hk : 0 < k) (hx : X.card = k) (hy : Y.card = k) :
    Adj X Y ↔ (X ∩ Y).card = k - 1 := by
  have h1 := card_sdiff_add_card_inter X Y
  have h2 := card_sdiff_add_card_inter Y X
  rw [inter_comm Y X] at h2
  constructor
  · intro h
    rcases h with ⟨ha,hb⟩
    omega
  · intro h
    constructor <;> omega

end Review15Johnson
