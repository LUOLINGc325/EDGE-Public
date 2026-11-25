import FeasibleExchange
import Mathlib.Combinatorics.SimpleGraph.Path

open Finset

namespace MarketFairDivision

variable {Goods : Type*} [DecidableEq Goods]

theorem exchange_distance_le {A B T : Finset Goods} (h : SingleExchange A B) :
    (A \ T).card ≤ (B \ T).card + 1 := by
  obtain ⟨a, _, g, _, rfl⟩ := h
  have hsub : (A \ T).erase a ⊆ (exchange A a g) \ T := by
    intro x hx
    obtain ⟨hxa, hx'⟩ := mem_erase.mp hx
    obtain ⟨hxA, hxT⟩ := mem_sdiff.mp hx'
    exact mem_sdiff.mpr ⟨mem_insert.mpr (Or.inr (mem_erase.mpr ⟨hxa, hxA⟩)), hxT⟩
  have hc := Finset.card_le_card hsub
  by_cases ha : a ∈ A \ T
  · have he := Finset.card_erase_add_one ha
    omega
  · rw [Finset.erase_eq_of_not_mem ha] at hc
    omega

inductive ExchangePath (eligible : Finset Goods → Prop) : ℕ → Finset Goods → Finset Goods → Prop
  | nil (A : Finset Goods) : eligible A → ExchangePath eligible 0 A A
  | step {n : ℕ} {A B C : Finset Goods} :
      eligible A → SingleExchange A B → ExchangePath eligible n B C →
        ExchangePath eligible (n + 1) A C

namespace ExchangePath

variable {eligible : Finset Goods → Prop} {A B C T : Finset Goods} {n m : ℕ}

theorem start (h : ExchangePath eligible n A B) : eligible A := by
  cases h with
  | nil _ hA => exact hA
  | step hA _ _ => exact hA

theorem finish (h : ExchangePath eligible n A B) : eligible B := by
  induction h with
  | nil _ hA => exact hA
  | step _ _ _ ih => exact ih

theorem append (h₁ : ExchangePath eligible n A B) (h₂ : ExchangePath eligible m B C) :
    ExchangePath eligible (n + m) A C := by
  induction h₁ with
  | nil _ _ => simpa using h₂
  | step hA hex _ ih =>
    simpa [Nat.add_assoc, Nat.add_left_comm, Nat.add_comm] using step hA hex (ih h₂)

theorem reverse (h : ExchangePath eligible n A B) : ExchangePath eligible n B A := by
  induction h with
  | nil A hA => exact nil A hA
  | step hA hswap tail ih =>
    have hone := step tail.start hswap.reverse (nil _ hA)
    exact ih.append hone

theorem distance_le (h : ExchangePath eligible n A B) :
    (A \ T).card ≤ (B \ T).card + n := by
  induction h with
  | nil _ _ => simp
  | step _ hswap _ ih =>
    have hs := exchange_distance_le (T := T) hswap
    omega

theorem shortest_lower_bound (h : ExchangePath eligible n A B) : (A \ B).card ≤ n := by
  simpa using h.distance_le (T := B)

end ExchangePath

variable [Fintype Goods] {k : ℕ}

abbrev OrdinalPath (p q : Goods ≃ Fin (2 * k)) := ExchangePath (OrdinalFeasible p q)

inductive GreedyTrace (p q : Goods ≃ Fin (2 * k)) : ℕ → Finset Goods → Prop
  | done : OrdinalFeasible p q (greedy p q) → GreedyTrace p q 0 (greedy p q)
  | step {n : ℕ} {A : Finset Goods} {a g : Goods} {s : ℕ} :
      OrdinalFeasible p q A → GreedyChoice p q A a g s →
      GreedyTrace p q n (exchange A a g) → GreedyTrace p q (n + 1) A

theorem GreedyTrace.toOrdinalPath {p q : Goods ≃ Fin (2 * k)} {n : ℕ} {A : Finset Goods}
    (h : GreedyTrace p q n A) : OrdinalPath p q n A (greedy p q) := by
  induction h with
  | done hG => exact ExchangePath.nil _ hG
  | step hA hchosen _ ih => exact ExchangePath.step hA hchosen.singleExchange ih

theorem algorithm_reaches_greedy (p q : Goods ≃ Fin (2 * k)) {A : Finset Goods}
    (hA : OrdinalFeasible p q A) :
    GreedyTrace p q (A \ greedy p q).card A := by
  let G := greedy p q
  have hGcard : G.card = k := greedy_card p q
  have step (n : ℕ) : ∀ A : Finset Goods, (A \ G).card = n →
      OrdinalFeasible p q A → GreedyTrace p q n A := by
    induction n with
    | zero =>
      intro A hzero hA
      have hs : A ⊆ G := Finset.sdiff_eq_empty_iff_subset.mp (Finset.card_eq_zero.mp hzero)
      have he : A = G := Finset.eq_of_subset_of_card_le hs
        (by rw [hGcard, feasible_card_eq p q hA])
      subst A
      exact GreedyTrace.done hA
    | succ n ih =>
      intro A hcount hA
      have hne : A ≠ G := by
        intro he
        subst A
        simp at hcount
      obtain ⟨a, g, s, hchoice, hB, hless⟩ := actual_greedy_step p q hA hne
      have hb : (exchange A a g \ G).card = n := by
        change (exchange A a g \ G).card + 1 = (A \ G).card at hless
        omega
      exact GreedyTrace.step hA hchoice (ih _ hb hB)
  exact step _ A rfl hA

theorem path_to_greedy (p q : Goods ≃ Fin (2 * k)) {A : Finset Goods}
    (hA : OrdinalFeasible p q A) :
    OrdinalPath p q (A \ greedy p q).card A (greedy p q) :=
  (algorithm_reaches_greedy p q hA).toOrdinalPath

theorem greedy_feasible (p q : Goods ≃ Fin (2 * k)) : OrdinalFeasible p q (greedy p q) := by
  obtain ⟨A, hA, _⟩ := complementary_ordinal_seed p q
  exact (path_to_greedy p q hA).finish

theorem feasible_paths_connect (p q : Goods ≃ Fin (2 * k)) {A B : Finset Goods}
    (hA : OrdinalFeasible p q A) (hB : OrdinalFeasible p q B) :
    ∃ n, OrdinalPath p q n A B :=
  ⟨_, (path_to_greedy p q hA).append (path_to_greedy p q hB).reverse⟩

noncomputable def feasibleGraph (p q : Goods ≃ Fin (2 * k)) :
    SimpleGraph {A : Finset Goods // OrdinalFeasible p q A} where
  Adj A B := SingleExchange A.1 B.1
  symm := by
    intro A B h
    exact h.reverse
  loopless := by
    intro A h
    obtain ⟨a, _, g, hg, he⟩ := h
    exact hg (by rw [he]; simp [exchange])

private theorem ExchangePath.reachable {p q : Goods ≃ Fin (2 * k)} {A B : Finset Goods} {n : ℕ}
    (h : OrdinalPath p q n A B) :
    (feasibleGraph p q).Reachable ⟨A, h.start⟩ ⟨B, h.finish⟩ := by
  induction h with
  | nil A hA => exact SimpleGraph.Reachable.refl (G := feasibleGraph p q) ⟨A, hA⟩
  | step hA hex tail ih =>
    have hstep : (feasibleGraph p q).Adj ⟨_, hA⟩ ⟨_, tail.start⟩ := hex
    exact hstep.reachable.trans ih

theorem feasible_graph_connected (p q : Goods ≃ Fin (2 * k)) :
    (feasibleGraph p q).Connected := by
  obtain ⟨S, hS, _⟩ := complementary_ordinal_seed p q
  letI : Nonempty {A : Finset Goods // OrdinalFeasible p q A} := ⟨⟨S, hS⟩⟩
  refine ⟨?_⟩
  intro A B
  obtain ⟨n, h⟩ := feasible_paths_connect p q A.2 B.2
  exact h.reachable

theorem complementary_path_exact (p q : Goods ≃ Fin (2 * k)) {A : Finset Goods}
    (hA : OrdinalFeasible p q A) (hB : OrdinalFeasible p q (other A)) :
    OrdinalPath p q k A (other A) := by
  let G := greedy p q
  have hgcard : G.card = k := greedy_card p q
  have hg := card_allocation G
  rw [card_goods p, hgcard] at hg
  have hother : (other G).card = k := by omega
  have he (X : Finset Goods) : X ∩ other G = X \ G := by
    ext x
    simp
  have hsum := card_partition A (other G)
  rw [he A, he (other A), hother] at hsum
  have h := (path_to_greedy p q hA).append (path_to_greedy p q hB).reverse
  change OrdinalPath p q ((A \ G).card + (other A \ G).card) A (other A) at h
  rwa [hsum] at h

theorem complementary_path_shortest {eligible : Finset Goods → Prop} {A : Finset Goods} {n : ℕ}
    (hA : A.card = k) (h : ExchangePath eligible n A (other A)) : k ≤ n := by
  have he : A \ other A = A := by
    ext x
    simp
  have hs := h.shortest_lower_bound
  rw [he, hA] at hs
  exact hs

theorem exchange_corrects_at_minimum {A B T : Finset Goods} (h : SingleExchange A B)
    (hmin : (B \ T).card + 1 = (A \ T).card) :
    ∃ a ∈ A \ T, ∃ g ∈ T \ A, B = exchange A a g := by
  obtain ⟨a, ha, g, hg, rfl⟩ := h
  have hd (S : Finset Goods) : S ∩ other T = S \ T := by ext x; simp
  have hc := exchange_card_prefix A (other T) (a := a) hg
  rw [hd, hd] at hc
  by_cases haT : a ∈ T <;> by_cases hgT : g ∈ T
  · simp [haT, hgT] at hc
    omega
  · simp [haT, hgT] at hc
    omega
  · exact ⟨a, mem_sdiff.mpr ⟨ha, haT⟩, g, mem_sdiff.mpr ⟨hgT, hg⟩, rfl⟩
  · simp [haT, hgT, ha] at hc
    omega

/-- A minimum-length path only removes items outside its target and inserts
items inside it. For complementary endpoints this removes each old item once. -/
inductive CorrectingPath (T : Finset Goods) : ℕ → Finset Goods → Finset Goods → Prop
  | nil (A : Finset Goods) : CorrectingPath T 0 A A
  | step {n : ℕ} {A B C : Finset Goods} {a g : Goods} :
      a ∈ A \ T → g ∈ T \ A → B = exchange A a g →
      CorrectingPath T n B C → CorrectingPath T (n + 1) A C

theorem ExchangePath.correcting_at_minimum {eligible : Finset Goods → Prop}
    {n : ℕ} {A B T : Finset Goods} (h : ExchangePath eligible n A B)
    (hend : (B \ T).card = 0) (hstart : (A \ T).card = n) :
    CorrectingPath T n A B := by
  induction h with
  | nil A _ => exact CorrectingPath.nil A
  | @step n A B C _ hAB tail ih =>
    have hlower := exchange_distance_le (T := T) hAB
    have hupper := tail.distance_le (T := T)
    have hb : (B \ T).card = n := by omega
    obtain ⟨a, ha, g, hg, he⟩ :=
      exchange_corrects_at_minimum (T := T) hAB (by omega)
    exact CorrectingPath.step ha hg he (ih hend hb)

theorem complementary_path_no_repeated_items {eligible : Finset Goods → Prop}
    {A : Finset Goods} (hA : A.card = k) (h : ExchangePath eligible k A (other A)) :
    CorrectingPath (other A) k A (other A) := by
  have he : A \ other A = A := by ext x; simp
  exact h.correcting_at_minimum (by simp) (he.symm ▸ hA)

end MarketFairDivision
