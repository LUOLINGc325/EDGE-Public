import TriangleModel

namespace Review15Johnson
open Finset
variable {α : Type*} [DecidableEq α]

/-- A single coordinate alternates on every chain vertex. The induction is
    unbounded in n and starts from the proved triangle lemma. -/
theorem chain_alternating_coordinate {n : ℕ} (R : ClosedChainRep n α) (hn : 3 ≤ n) :
    ∃ b : α, ∀ j, j < n → (b ∈ R.chain j ↔ (j % 2 = 0 ↔ b ∈ R.chain 0)) := by
  have h01 : Adj (R.chain 0) (R.chain 1) :=
    (R.chain_adj 0 1 (by omega) (by omega)).2 (by omega)
  have h02 : Adj (R.chain 0) (R.chain 2) :=
    (R.chain_adj 0 2 (by omega) (by omega)).2 (by omega)
  have h12 : Adj (R.chain 1) (R.chain 2) :=
    (R.chain_adj 1 2 (by omega) (by omega)).2 (by omega)
  obtain ⟨b,hb⟩ := triangle_alternating_element h01 h02 h12
  refine ⟨b,?_⟩
  intro j
  induction j using Nat.strong_induction_on with
  | h j ih =>
    intro hjn
    by_cases hj0 : j = 0
    · subst j; simp
    by_cases hj1 : j = 1
    · subst j
      rcases hb with hh | hh <;> simp_all
    by_cases hj2 : j = 2
    · subst j
      rcases hb with hh | hh <;> simp_all
    have hj : 3 ≤ j := by omega
    have ha := ih (j-3) (by omega) (by omega)
    have hb' := ih (j-2) (by omega) (by omega)
    have hab : Adj (R.chain (j-3)) (R.chain (j-2)) :=
      (R.chain_adj (j-3) (j-2) (by omega) (by omega)).2 (by omega)
    have hbd : Adj (R.chain (j-2)) (R.chain j) :=
      (R.chain_adj (j-2) j (by omega) hjn).2 (by omega)
    have hne : R.chain (j-3) ≠ R.chain j := by
      intro he
      have hh := R.injective_chain (j-3) j (by omega) hjn he
      omega
    have hnadj : ¬ Adj (R.chain (j-3)) (R.chain j) := by
      rw [R.chain_adj (j-3) j (by omega) hjn]
      omega
    have hc : ¬ (b ∈ R.chain (j-3) ↔ b ∈ R.chain (j-2)) := by
      intro he
      have hh := ha.symm.trans (he.trans hb')
      have hp : ¬ ((j-3)%2 = 0 ↔ (j-2)%2 = 0) := by omega
      by_cases hp1 : (j-3)%2 = 0 <;> by_cases hp2 : (j-2)%2 = 0 <;>
        by_cases hm : b ∈ R.chain 0 <;> simp_all
    have hd := diamond_coordinate hab hbd hne hnadj hc
    have hmod : (j-2)%2 = j%2 := by omega
    simpa [hmod] using hd.trans hb'

/-- No positive even triangle chain can be represented, over any ground type
    and for any finite-set cardinality. n is the number of chain vertices. -/
theorem even_chain_not_representable {n : ℕ} (hn : 4 ≤ n) (heven : n % 2 = 0)
    (R : ClosedChainRep n α) : False := by
  obtain ⟨b,hb⟩ := chain_alternating_coordinate R (by omega)
  have hs : b ∈ R.chain 1 ↔ b ∉ R.chain 0 := by
    simpa using hb 1 (by omega)
  have hmod1 : (n-1)%2 = 1 := by omega
  have hmod2 : (n-2)%2 = 0 := by omega
  have he : b ∈ R.chain (n-1) ↔ b ∉ R.chain 0 := by
    simpa [hmod1] using hb (n-1) (by omega)
  have hp : b ∈ R.chain (n-2) ↔ b ∈ R.chain 0 := by
    simpa [hmod2] using hb (n-2) (by omega)
  by_cases ht : b ∈ R.extra ↔ b ∈ R.chain 0
  · have htx : Adj (R.chain (n-1)) R.extra := adj_symm
      ((R.extra_adj (n-1) (by omega)).2 (by omega))
    have hpx : Adj (R.chain (n-1)) (R.chain (n-2)) :=
      (R.chain_adj (n-1) (n-2) (by omega) (by omega)).2 (by omega)
    have hc : (b ∉ R.chain (n-1) ∧ b ∈ R.extra ∧ b ∈ R.chain (n-2)) ∨
        (b ∈ R.chain (n-1) ∧ b ∉ R.extra ∧ b ∉ R.chain (n-2)) := by
      by_cases hm : b ∈ R.chain 0 <;> simp_all
    rcases common_changed_coordinate htx hpx hc with hEq | hAdj
    · exact R.extra_distinct (n-2) (by omega) hEq
    · have hh := (R.extra_adj (n-2) (by omega)).1 hAdj
      omega
  · have htx : Adj (R.chain 0) R.extra := adj_symm
      ((R.extra_adj 0 (by omega)).2 (Or.inl rfl))
    have hsx : Adj (R.chain 0) (R.chain 1) :=
      (R.chain_adj 0 1 (by omega) (by omega)).2 (by omega)
    have hc : (b ∉ R.chain 0 ∧ b ∈ R.extra ∧ b ∈ R.chain 1) ∨
        (b ∈ R.chain 0 ∧ b ∉ R.extra ∧ b ∉ R.chain 1) := by
      by_cases hm : b ∈ R.chain 0 <;> by_cases ht' : b ∈ R.extra <;> simp_all
    rcases common_changed_coordinate htx hsx hc with hEq | hAdj
    · exact R.extra_distinct 1 (by omega) hEq
    · have hh := (R.extra_adj 1 (by omega)).1 hAdj
      omega

theorem singleton_labels_adj {X Y : Finset α}
    (hx : X.card = 1) (hy : Y.card = 1) (hne : X ≠ Y) : Adj X Y := by
  obtain ⟨x,rfl⟩ := card_eq_one.mp hx
  obtain ⟨y,rfl⟩ := card_eq_one.mp hy
  have hxy : x ≠ y := by intro hh; subst y; exact hne rfl
  have h1 : ({x} : Finset α) \ {y} = {x} := by
    ext a; simp only [mem_sdiff,mem_singleton]; aesop
  have h2 : ({y} : Finset α) \ {x} = {y} := by
    ext a; simp only [mem_sdiff,mem_singleton]; aesop
  simp [Adj,h1,h2]

/-- All closed chains need at least two elements in each label. -/
theorem closed_chain_rank_ge_two {n : ℕ} (R : ClosedChainRep n α) (hn : 3 ≤ n) :
    2 ≤ R.k := by
  have hkpos := R.k_pos
  by_contra h
  have hk : R.k = 1 := by omega
  have ht : R.extra.card = 1 := by rw [R.card_extra,hk]
  have hc : (R.chain 1).card = 1 := by rw [R.card_chain 1 (by omega),hk]
  have ha := singleton_labels_adj ht hc (R.extra_distinct 1 (by omega))
  have hh := (R.extra_adj 1 (by omega)).1 ha
  omega

theorem two_labels_sharing_element_adj {X Y : Finset α} {b : α}
    (hx : X.card = 2) (hy : Y.card = 2) (hne : X ≠ Y)
    (hbx : b ∈ X) (hby : b ∈ Y) : Adj X Y := by
  have hi : 0 < (X ∩ Y).card := card_pos.mpr ⟨b,mem_inter.mpr ⟨hbx,hby⟩⟩
  have hnot : ¬ X ⊆ Y := by
    intro hsub
    exact hne (eq_of_subset_of_card_le hsub (by omega))
  have hp : 0 < (X \ Y).card := by
    apply card_pos.mpr
    exact sdiff_nonempty.mpr hnot
  have h1 := card_sdiff_add_card_inter X Y
  have h2 := card_sdiff_add_card_inter Y X
  rw [inter_comm Y X] at h2
  constructor <;> omega

/-- This bound is proved for every n >= 6, so in particular it covers every
    odd triangle count i >= 5 (n = i+2), with no finite-size enumeration. -/
theorem closed_chain_rank_ge_three {n : ℕ} (R : ClosedChainRep n α) (hn : 6 ≤ n) :
    3 ≤ R.k := by
  have hk2 := closed_chain_rank_ge_two R (by omega)
  by_contra h
  have hk : R.k = 2 := by omega
  obtain ⟨b,hb⟩ := chain_alternating_coordinate R (by omega)
  by_cases hm : b ∈ R.chain 0
  · have h4 : b ∈ R.chain 4 := by simpa [hm] using hb 4 (by omega)
    have hne : R.chain 0 ≠ R.chain 4 := by
      intro he
      have hh := R.injective_chain 0 4 (by omega) (by omega) he
      omega
    have ha := two_labels_sharing_element_adj
      (by rw [R.card_chain 0 (by omega),hk])
      (by rw [R.card_chain 4 (by omega),hk]) hne hm h4
    have hh := (R.chain_adj 0 4 (by omega) (by omega)).1 ha
    omega
  · have h1 : b ∈ R.chain 1 := by simpa [hm] using hb 1 (by omega)
    have h5 : b ∈ R.chain 5 := by simpa [hm] using hb 5 (by omega)
    have hne : R.chain 1 ≠ R.chain 5 := by
      intro he
      have hh := R.injective_chain 1 5 (by omega) (by omega) he
      omega
    have ha := two_labels_sharing_element_adj
      (by rw [R.card_chain 1 (by omega),hk])
      (by rw [R.card_chain 5 (by omega),hk]) hne h1 h5
    have hh := (R.chain_adj 1 5 (by omega) (by omega)).1 ha
    omega

#print axioms chain_alternating_coordinate
#print axioms even_chain_not_representable
#print axioms closed_chain_rank_ge_two
#print axioms closed_chain_rank_ge_three
end Review15Johnson
