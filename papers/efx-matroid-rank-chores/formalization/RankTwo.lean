import TwoColor

namespace RankTwo

variable {n m : ℕ}

abbrev Costs (n m : ℕ) := Fin n → Finset (Fin m) → ℕ

def EFX (cost : Costs n m) (x : Fin m → Fin n) : Prop :=
  ∀ i j, ∀ g ∈ TwoColor.bundle x i,
    cost i ((TwoColor.bundle x i).erase g) ≤ cost i (TwoColor.bundle x j)

private theorem efx_of_small_bundle {cost : Finset (Fin m) → ℕ}
    (mono : Monotone cost) (hZero : cost ∅ = 0)
    (single : ∃ v, ∀ g, cost {g} = v)
    {own other : Finset (Fin m)} (hsize : own.card ≤ 2) (hother : other.Nonempty)
    {g : Fin m} (hg : g ∈ own) :
    cost (own.erase g) ≤ cost other := by
  classical
  obtain ⟨v, hv⟩ := single
  have hcard : (own.erase g).card ≤ 1 := by
    rw [Finset.card_erase_of_mem hg]
    omega
  obtain ⟨q, hq⟩ := hother
  by_cases hnonempty : (own.erase g).Nonempty
  · obtain ⟨a, ha⟩ := hnonempty
    have heq : own.erase g = {a} := by
      apply Finset.Subset.antisymm
      · intro z hz
        exact Finset.mem_singleton.mpr (Finset.card_le_one.mp hcard z hz a ha)
      · exact Finset.singleton_subset_iff.mpr ha
    rw [heq, hv]
    have hq' := mono (Finset.singleton_subset_iff.mpr hq)
    rwa [hv] at hq'
  · rw [Finset.not_nonempty_iff_eq_empty.mp hnonempty, hZero]
    exact Nat.zero_le _

/-- Equal singleton prices make bundles of size at most two EFX among
nonempty bundles. A distinguished agent also satisfies EFX if their
whole-bundle cost is dominated by each bundle in their own valuation. -/
theorem efx_of_small_others (cost : Costs n m) (x : Fin m → Fin n) (p : Fin n)
    (mono : ∀ i, Monotone (cost i)) (zero : ∀ i, cost i ∅ = 0)
    (single : ∀ i, ∃ v, ∀ g, cost i {g} = v)
    (nonempty : ∀ i, (TwoColor.bundle x i).Nonempty)
    (size : ∀ i, i ≠ p → (TwoColor.bundle x i).card ≤ 2)
    (distinguished : ∀ j, cost p (TwoColor.bundle x p) ≤ cost p (TwoColor.bundle x j)) :
    EFX cost x := by
  intro i j g hg
  classical
  by_cases hi : i = p
  · subst i
    exact (mono p (Finset.erase_subset _ _)).trans (distinguished j)
  · exact efx_of_small_bundle (mono i) (zero i) (single i) (size i hi) (nonempty j) hg

/-- First allocation branch: every nondistinguished agent receives a pair
that reaches the distinguished agent's global cost cap. -/
theorem efx_of_maximal_pairs (cost : Costs n m) (x : Fin m → Fin n) (p : Fin n)
    (mono : ∀ i, Monotone (cost i)) (zero : ∀ i, cost i ∅ = 0)
    (single : ∀ i, ∃ v, ∀ g, cost i {g} = v)
    (nonempty : ∀ i, (TwoColor.bundle x i).Nonempty)
    (size : ∀ i, i ≠ p → (TwoColor.bundle x i).card ≤ 2)
    (cap : ∀ s, cost p s ≤ 2)
    (pairs : ∀ j, j ≠ p → cost p (TwoColor.bundle x j) = 2) :
    EFX cost x := by
  apply efx_of_small_others cost x p mono zero single nonempty size
  intro j
  by_cases hj : j = p
  · simp [hj]
  · rw [pairs j hj]
    exact cap _

/-- Second allocation branch: the nondistinguished bundles are singletons
and the distinguished bundle has the same cost as her singletons. -/
theorem efx_of_singletons_and_equal_cost (cost : Costs n m) (x : Fin m → Fin n) (p : Fin n)
    (mono : ∀ i, Monotone (cost i)) (zero : ∀ i, cost i ∅ = 0)
    (single : ∀ i, ∃ v, ∀ g, cost i {g} = v)
    (nonempty : ∀ i, (TwoColor.bundle x i).Nonempty)
    (size : ∀ i, i ≠ p → (TwoColor.bundle x i).card ≤ 1)
    (same : ∀ g, cost p (TwoColor.bundle x p) ≤ cost p {g}) :
    EFX cost x := by
  apply efx_of_small_others cost x p mono zero single nonempty
  · intro i hi
    exact (size i hi).trans (by decide)
  · intro j
    obtain ⟨g, hg⟩ := nonempty j
    exact (same g).trans (mono p (Finset.singleton_subset_iff.mpr hg))

/-- A universal anchor is a chore with singleton cost one to every agent. -/
def UniversalAnchor (cost : Costs n m) (g : Fin m) : Prop :=
  ∀ i, cost i {g} = 1

private theorem efx_of_anchor {cost : Finset (Fin m) → ℕ}
    (mono : Monotone cost) (zero : cost ∅ = 0)
    (single : ∀ g, cost {g} ≤ 1)
    {own other : Finset (Fin m)} (hsize : own.card ≤ 2)
    (anchor : ∃ q ∈ other, cost {q} = 1)
    {g : Fin m} (hg : g ∈ own) :
    cost (own.erase g) ≤ cost other := by
  classical
  have hcard : (own.erase g).card ≤ 1 := by
    rw [Finset.card_erase_of_mem hg]
    omega
  obtain ⟨q, hq, hanchor⟩ := anchor
  by_cases hnonempty : (own.erase g).Nonempty
  · obtain ⟨a, ha⟩ := hnonempty
    have heq : own.erase g = {a} := by
      apply Finset.Subset.antisymm
      · intro z hz
        exact Finset.mem_singleton.mpr (Finset.card_le_one.mp hcard z hz a ha)
      · exact Finset.singleton_subset_iff.mpr ha
    rw [heq]
    have hq' := mono (Finset.singleton_subset_iff.mpr hq)
    rw [hanchor] at hq'
    exact (single a).trans hq'
  · rw [Finset.not_nonempty_iff_eq_empty.mp hnonempty, zero]
    exact Nat.zero_le _

/-- EFX witness allowing heterogeneous loops. Each bundle contains a
universal anchor, nondistinguished bundles have size at most two,
and the distinguished bundle has cost at most one or receives
no envy in the distinguished agent's own comparisons. -/
theorem efx_of_universal_anchors (cost : Costs n m) (x : Fin m → Fin n) (p : Fin n)
    (mono : ∀ i, Monotone (cost i)) (zero : ∀ i, cost i ∅ = 0)
    (single : ∀ i g, cost i {g} ≤ 1)
    (anchors : ∀ j, ∃ g ∈ TwoColor.bundle x j, UniversalAnchor cost g)
    (size : ∀ i, i ≠ p → (TwoColor.bundle x i).card ≤ 2)
    (distinguished : (cost p (TwoColor.bundle x p) ≤ 1) ∨
      (∀ j, cost p (TwoColor.bundle x p) ≤ cost p (TwoColor.bundle x j))) :
    EFX cost x := by
  intro i j g hg
  obtain ⟨q, hq, hanchor⟩ := anchors j
  by_cases hi : i = p
  · subst i
    apply (mono p (Finset.erase_subset _ _)).trans
    rcases distinguished with h | h
    · apply h.trans
      have hq' := mono p (Finset.singleton_subset_iff.mpr hq)
      rwa [hanchor p] at hq'
    · exact h j
  · exact efx_of_anchor (mono i) (zero i) (single i) (size i hi)
      ⟨q, hq, hanchor i⟩ hg

/-- General anchor comparison. A core of cost at least `t` in
every bundle controls comparisons from agents with at most `t+1`
chores, whenever their cost is bounded by bundle cardinality. The
distinguished agent may instead be protected by a direct comparison. -/
theorem efx_of_rank_anchors (cost : Costs n m) (x : Fin m → Fin n) (p : Fin n) (t : ℕ)
    (mono : ∀ i, Monotone (cost i))
    (card_bound : ∀ i s, cost i s ≤ s.card)
    (anchors : ∀ j, ∃ a ⊆ TwoColor.bundle x j, ∀ i, t ≤ cost i a)
    (size : ∀ i, i ≠ p → (TwoColor.bundle x i).card ≤ t + 1)
    (distinguished : (cost p (TwoColor.bundle x p) ≤ t) ∨
      (∀ j, cost p (TwoColor.bundle x p) ≤ cost p (TwoColor.bundle x j))) :
    EFX cost x := by
  intro i j g hg
  obtain ⟨a, ha, ht⟩ := anchors j
  have hfloor : t ≤ cost i (TwoColor.bundle x j) := (ht i).trans (mono i ha)
  by_cases hi : i = p
  · subst i
    apply (mono p (Finset.erase_subset _ _)).trans
    rcases distinguished with h | h
    · exact h.trans hfloor
    · exact h j
  · apply (card_bound i _).trans
    apply le_trans _ hfloor
    rw [Finset.card_erase_of_mem hg]
    have h := size i hi
    omega

/-- Diminishing returns makes a collection of single-element
extensions of marginal zero jointly have marginal zero. -/
theorem cost_union_eq_of_zero_marginals (c : Finset (Fin m) → ℕ)
    (mono : Monotone c)
    (dr : ∀ ⦃a b : Finset (Fin m)⦄, a ⊆ b →
      ∀ e, c (insert e b) + c a ≤ c (insert e a) + c b)
    (base extras : Finset (Fin m))
    (he : ∀ e ∈ extras, c (insert e base) = c base) :
    c (base ∪ extras) = c base := by
  classical
  induction extras using Finset.induction_on with
  | empty => simp
  | @insert e extras _ ih =>
    have he₀ : c (insert e base) = c base := he e (Finset.mem_insert_self _ _)
    have he₁ : c (base ∪ extras) = c base := ih
      (fun f hf => he f (Finset.mem_insert_of_mem hf))
    have he₂ := dr (Finset.subset_union_left : base ⊆ base ∪ extras) e
    rw [he₀, he₁] at he₂
    rw [Finset.union_insert]
    apply le_antisymm (by omega)
    exact mono (fun _ h => Finset.mem_insert_of_mem (Finset.mem_union_left _ h))

/-- The two stopping conditions of the greedy anchor construction
suffice for EFX and protect the pivot against all envy. This verifies
the cost inequalities from the supplied allocation and its stopping
condition. -/
theorem efx_and_pivot_ef_of_rank_anchor_stopping_condition
    (cost : Costs n m) (x : Fin m → Fin n) (p : Fin n) (t : ℕ)
    (mono : ∀ i, Monotone (cost i))
    (card_bound : ∀ i s, cost i s ≤ s.card)
    (anchors : ∀ j, ∃ a ⊆ TwoColor.bundle x j, ∀ i, t ≤ cost i a)
    (size : ∀ i, i ≠ p → (TwoColor.bundle x i).card ≤ t + 1)
    (cap : cost p (TwoColor.bundle x p) ≤ t + 1)
    (dr : ∀ ⦃a b : Finset (Fin m)⦄, a ⊆ b →
      ∀ e, cost p (insert e b) + cost p a ≤ cost p (insert e a) + cost p b)
    (stop :
      (∀ j, j ≠ p → t + 1 ≤ cost p (TwoColor.bundle x j)) ∨
      (∃ a e : Finset (Fin m), TwoColor.bundle x p = a ∪ e ∧
        cost p a = t ∧ ∀ g ∈ e, cost p (insert g a) = cost p a)) :
    EFX cost x ∧
      ∀ j, cost p (TwoColor.bundle x p) ≤ cost p (TwoColor.bundle x j) := by
  have hp : ∀ j, cost p (TwoColor.bundle x p) ≤ cost p (TwoColor.bundle x j) := by
    intro j
    rcases stop with h | ⟨a, e, hb, ha, he⟩
    · by_cases hj : j = p
      · simp [hj]
      · exact cap.trans (h j hj)
    · rw [hb, cost_union_eq_of_zero_marginals (cost p) (mono p) dr a e he, ha]
      obtain ⟨a', ha', ht⟩ := anchors j
      exact (ht p).trans (mono p ha')
  exact ⟨efx_of_rank_anchors cost x p t mono card_bound anchors size (Or.inr hp), hp⟩

#print axioms efx_of_rank_anchors
#print axioms efx_and_pivot_ef_of_rank_anchor_stopping_condition
#print axioms efx_of_universal_anchors
#print axioms efx_of_maximal_pairs
#print axioms efx_of_singletons_and_equal_cost

end RankTwo
