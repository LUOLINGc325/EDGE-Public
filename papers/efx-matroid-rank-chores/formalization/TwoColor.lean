import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Fintype.Pigeonhole
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Finset.Card
import Mathlib.Logic.Function.Basic
import Mathlib.Tactic.Push

namespace TwoColor

open Function
open scoped BigOperators

variable {n m : ℕ}

def bundle (x : Fin m → Fin n) (i : Fin n) : Finset (Fin m) :=
  Finset.univ.filter fun g => x g = i

def cost (tag : Fin n → Fin m → Bool) (x : Fin m → Fin n) (i j : Fin n) : ℕ :=
  ((bundle x j).image (tag i)).card

def EnvyFree (tag : Fin n → Fin m → Bool) (x : Fin m → Fin n) : Prop :=
  ∀ i j, cost tag x i i ≤ cost tag x i j

def EFX (tag : Fin n → Fin m → Bool) (x : Fin m → Fin n) : Prop :=
  ∀ i j, ∀ g ∈ bundle x i,
    (((bundle x i).erase g).image (tag i)).card ≤ cost tag x i j

private def monochrome (tag : Fin n → Fin m → Bool) (x : Fin m → Fin n) : Prop :=
  ∀ i g h, x g = i → x h = i → tag i g = tag i h

private theorem monochrome_surjective (tag : Fin n → Fin m → Bool) (hm : n ≤ m)
    (x : Fin m → Fin n) (hx : monochrome tag x) :
    ∃ y : Fin m → Fin n, monochrome tag y ∧ Surjective y := by
  classical
  let missing (z : Fin m → Fin n) := n - (Finset.univ.image z).card
  suffices ∀ k (z : Fin m → Fin n), missing z = k → monochrome tag z →
      ∃ y : Fin m → Fin n, monochrome tag y ∧ Surjective y from
    this _ x rfl hx
  intro k
  induction k using Nat.strong_induction_on with
  | h k ih =>
    intro z hmissing hz
    by_cases hsur : Surjective z
    · exact ⟨z, hz, hsur⟩
    unfold Surjective at hsur
    push_neg at hsur
    obtain ⟨i, hi⟩ := hsur
    have hi' : i ∉ Finset.univ.image z := by simpa [Finset.mem_image, eq_comm] using hi
    have hCard : (Finset.univ.image z).card < n := by
      have hproper : Finset.univ.image z ⊂ Finset.univ :=
        Finset.ssubset_univ_iff.mpr (fun e => hi' (e.symm ▸ Finset.mem_univ i))
      simpa using Finset.card_lt_card hproper
    have hnotinj : ¬Injective z := by
      intro hj
      have hr : (Finset.univ.image z).card = m := by
        simpa using Finset.card_image_of_injective Finset.univ hj
      omega
    obtain ⟨g, h, hghz, hgh⟩ := not_injective_iff.mp hnotinj
    let z' := Function.update z g i
    have hset : Finset.univ.image z' = insert i (Finset.univ.image z) := by
      ext j
      simp only [Finset.mem_image, Finset.mem_univ, true_and, Finset.mem_insert]
      constructor
      · rintro ⟨a, rfl⟩
        by_cases ha : a = g
        · subst a
          exact Or.inl (Function.update_self g i z)
        · exact Or.inr ⟨a, Function.update_of_ne ha i z |>.symm⟩
      · rintro (hji | ⟨a, rfl⟩)
        · exact ⟨g, (Function.update_self g i z).trans hji.symm⟩
        · by_cases ha : a = g
          · subst a
            exact ⟨h, (Function.update_of_ne (Ne.symm hgh) i z).trans hghz.symm⟩
          · exact ⟨a, Function.update_of_ne ha i z⟩
    have hmono : monochrome tag z' := by
      intro j a b ha hb
      by_cases hag : a = g <;> by_cases hbg : b = g
      · simp [hag, hbg]
      · subst a
        have hj : j = i := ha.symm.trans (Function.update_self g i z)
        exact (hi b ((Function.update_of_ne hbg i z).symm.trans (hb.trans hj))).elim
      · subst b
        have hj : j = i := hb.symm.trans (Function.update_self g i z)
        exact (hi a ((Function.update_of_ne hag i z).symm.trans (ha.trans hj))).elim
      · exact hz j a b ((Function.update_of_ne hag i z).symm.trans ha)
          ((Function.update_of_ne hbg i z).symm.trans hb)
    apply ih (missing z') _ z' rfl hmono
    dsimp [missing] at *
    rw [hset, Finset.card_insert_of_notMem hi']
    omega

private theorem envyFree_of_mono (tag : Fin n → Fin m → Bool) (x : Fin m → Fin n)
    (hm : monochrome tag x) (hs : Surjective x) : EnvyFree tag x := by
  intro i j
  obtain ⟨g, hg⟩ := hs i
  obtain ⟨h, hh⟩ := hs j
  have hcard : ((bundle x i).image (tag i)).card ≤ 1 := by
    apply Finset.card_le_one.mpr
    intro a ha b hb
    obtain ⟨a', ha', rfl⟩ := Finset.mem_image.mp ha
    obtain ⟨b', hb', rfl⟩ := Finset.mem_image.mp hb
    exact hm i a' b' ((Finset.mem_filter.mp ha').2) ((Finset.mem_filter.mp hb').2)
  have hc : 0 < cost tag x i j := by
    apply Finset.card_pos.mpr
    exact ⟨tag i h, Finset.mem_image_of_mem _ (by simpa [bundle] using hh)⟩
  exact le_trans hcard hc

/-- If every pattern occurs, any specified agent can be the sole agent
whose own bundle uses both colors in a complete envy-free allocation. -/
theorem exists_envyFree_with_one_bichromatic
    (tag : Fin n → Fin m → Bool) (p : Fin n)
    (hfull : ∀ s : Fin n → Bool, ∃ g, ∀ i, tag i g = s i) :
    ∃ x : Fin m → Fin n, Surjective x ∧ EnvyFree tag x ∧
      ∀ i, cost tag x i i = if i = p then 2 else 1 := by
  classical
  let eligible (g : Fin m) (i : Fin n) := i ≠ p ∧ tag i g = true
  let x (g : Fin m) : Fin n :=
    if h : ∃ i, eligible g i then h.choose else p
  have gets (j : Fin n) (b : Bool) :
      ∃ g, x g = j ∧ tag p g = b := by
    let s (i : Fin n) : Bool := if i = p then b else decide (i = j)
    obtain ⟨g, hg⟩ := hfull s
    have huniq (i : Fin n) (hi : eligible g i) : i = j := by
      obtain ⟨hnp, htrue⟩ := hi
      simpa [hg i, s, hnp] using htrue
    refine ⟨g, ?_, by simpa [s] using hg p⟩
    unfold x
    split
    · rename_i h
      exact huniq h.choose h.choose_spec
    · rename_i h
      by_contra hne
      have hj : j ≠ p := Ne.symm hne
      exact h ⟨j, hj, by simp [hg j, s, hj]⟩
  have hsur : Surjective x := fun j =>
    let ⟨g, hx, _⟩ := gets j false
    ⟨g, hx⟩
  have hp (j : Fin n) : cost tag x p j = 2 := by
    have hi : (bundle x j).image (tag p) = Finset.univ := by
      apply Finset.eq_univ_of_forall
      intro b
      obtain ⟨g, hx, hb⟩ := gets j b
      exact Finset.mem_image.mpr
        ⟨g, by simpa [bundle] using hx, hb⟩
    simp [cost, hi]
  have positive (i j : Fin n) : 1 ≤ cost tag x i j := by
    obtain ⟨g, hg⟩ := hsur j
    exact Finset.card_pos.mpr
      ⟨tag i g, Finset.mem_image_of_mem _ (by simpa [bundle] using hg)⟩
  have hn (i : Fin n) (hi : i ≠ p) : cost tag x i i = 1 := by
    have htag (g : Fin m) (hg : x g = i) : tag i g = true := by
      unfold x at hg
      split at hg
      · rename_i h
        rw [← hg]
        exact h.choose_spec.2
      · exact (hi hg.symm).elim
    apply le_antisymm _ (positive i i)
    apply Finset.card_le_one.mpr
    intro a ha b hb
    obtain ⟨g, hg, rfl⟩ := Finset.mem_image.mp ha
    obtain ⟨g', hg', rfl⟩ := Finset.mem_image.mp hb
    exact (htag g (Finset.mem_filter.mp hg).2).trans
      (htag g' (Finset.mem_filter.mp hg').2).symm
  refine ⟨x, hsur, ?_, ?_⟩
  · intro i j
    by_cases hi : i = p
    · subst i
      simp [hp]
    · rw [hn i hi]
      exact positive i j
  · intro i
    split
    · rename_i hi
      subst i
      exact hp p
    · rename_i hi
      exact hn i hi

/-- If every pattern occurs, any complete allocation with nonempty
bundles has an agent whose own bundle uses both colors. -/
theorem exists_bichromatic_of_full
    (tag : Fin n → Fin m → Bool) (x : Fin m → Fin n) (hsur : Surjective x)
    (hfull : ∀ s : Fin n → Bool, ∃ g, ∀ i, tag i g = s i) :
    ∃ i, cost tag x i i = 2 := by
  classical
  choose rep hrep using hsur
  obtain ⟨g, hg⟩ := hfull (fun i => !(tag i (rep i)))
  let i := x g
  refine ⟨i, ?_⟩
  have hne : tag i g ≠ tag i (rep i) := by
    have h := hg i
    cases h' : tag i (rep i) <;> simp_all
  have hi : (bundle x i).image (tag i) = Finset.univ := by
    apply Finset.eq_univ_of_forall
    intro b
    have heq : b = tag i g ∨ b = tag i (rep i) := by
      cases h' : tag i g <;> cases h'' : tag i (rep i) <;> cases b <;> simp_all
    rcases heq with rfl | rfl
    · exact Finset.mem_image_of_mem _ (by simp [bundle, i])
    · exact Finset.mem_image_of_mem _ (by simp [bundle, hrep])
  simp [cost, hi]

/-- If a signature is missing and there are at least as many chores
as agents, all agents can have own cost one in an envy-free allocation. -/
theorem exists_envyFree_with_all_monochromatic (tag : Fin n → Fin m → Bool) (hm : n ≤ m)
    (hmissing : ∃ s : Fin n → Bool, ∀ g, ∃ i, tag i g ≠ s i) :
    ∃ x : Fin m → Fin n, Surjective x ∧ EnvyFree tag x ∧
      ∀ i, cost tag x i i = 1 := by
  classical
  obtain ⟨s, hs⟩ := hmissing
  choose x hx using hs
  have hmono : monochrome tag x := by
    intro i g h hg hh
    have h1 := hx g
    have h2 := hx h
    rw [hg] at h1
    rw [hh] at h2
    cases hs : s i <;> cases htg : tag i g <;> cases hth : tag i h <;> simp_all
  obtain ⟨y, hy, hsur⟩ := monochrome_surjective tag hm x hmono
  refine ⟨y, hsur, envyFree_of_mono tag y hy hsur, ?_⟩
  intro i
  obtain ⟨g, hg⟩ := hsur i
  have hset : (bundle y i).image (tag i) = {tag i g} := by
    apply Finset.Subset.antisymm
    · rintro c hc
      obtain ⟨h, hh, rfl⟩ := Finset.mem_image.mp hc
      exact Finset.mem_singleton.mpr (hy i h g (Finset.mem_filter.mp hh).2 hg)
    · exact Finset.singleton_subset_iff.mpr
        (Finset.mem_image_of_mem _ (by simpa [bundle] using hg))
  simp [cost, hset]

/-- If there is at least one agent and at least as many chores as agents,
there is a complete envy-free allocation of two-color rank chores. -/
theorem exists_envyFree (tag : Fin n → Fin m → Bool) (hn : 0 < n) (hm : n ≤ m) :
    ∃ x : Fin m → Fin n, EnvyFree tag x := by
  classical
  by_cases hfull : ∀ s : Fin n → Bool, ∃ g, ∀ i, tag i g = s i
  · obtain ⟨x, _, hx, _⟩ := exists_envyFree_with_one_bichromatic tag ⟨0, hn⟩ hfull
    exact ⟨x, hx⟩
  · push_neg at hfull
    obtain ⟨x, _, hx, _⟩ := exists_envyFree_with_all_monochromatic tag hm hfull
    exact ⟨x, hx⟩

/-- The minimum total own cost among surjective allocations is
`n + 1` when every signature occurs and `n` otherwise. In either case
that minimum is attained by an envy-free allocation. -/
theorem exact_minimum_own_cost (tag : Fin n → Fin m → Bool) (hn : 0 < n) (hm : n ≤ m) :
    letI := Classical.propDecidable
    let full := ∀ s : Fin n → Bool, ∃ g, ∀ i, tag i g = s i
    ∃ x : Fin m → Fin n, Surjective x ∧ EnvyFree tag x ∧
      (∑ i, cost tag x i i) = (if full then n + 1 else n) ∧
      ∀ y : Fin m → Fin n, Surjective y → (∑ i, cost tag x i i) ≤ ∑ i, cost tag y i i := by
  classical
  dsimp only
  have one_le_cost (x : Fin m → Fin n) (hx : Surjective x) (i : Fin n) :
      1 ≤ cost tag x i i := by
    obtain ⟨g, hg⟩ := hx i
    exact Finset.card_pos.mpr
      ⟨tag i g, Finset.mem_image_of_mem _ (by simpa [bundle] using hg)⟩
  have sum_at_pivot (p : Fin n) :
      (∑ i : Fin n, if i = p then 2 else 1) = n + 1 := by
    have h (i : Fin n) : (if i = p then 2 else 1) = 1 + (if i = p then 1 else 0) := by
      split <;> simp_all
    simp [h, Finset.sum_add_distrib, Finset.sum_ite_eq']
  by_cases hfull : ∀ s : Fin n → Bool, ∃ g, ∀ i, tag i g = s i
  · let p : Fin n := ⟨0, hn⟩
    obtain ⟨x, hx, hef, hcost⟩ := exists_envyFree_with_one_bichromatic tag p hfull
    have hs : (∑ i, cost tag x i i) = n + 1 := by simpa only [hcost] using sum_at_pivot p
    refine ⟨x, hx, hef, by simpa [hfull] using hs, ?_⟩
    intro y hy
    obtain ⟨q, hq⟩ := exists_bichromatic_of_full tag y hy hfull
    rw [hs, ← sum_at_pivot q]
    apply Finset.sum_le_sum
    intro i _
    by_cases hi : i = q
    · simp [hi, hq]
    · simpa [hi] using one_le_cost y hy i
  · have hmissing : ∃ s : Fin n → Bool, ∀ g, ∃ i, tag i g ≠ s i := by
      push_neg at hfull
      exact hfull
    obtain ⟨x, hx, hef, hcost⟩ := exists_envyFree_with_all_monochromatic tag hm hmissing
    refine ⟨x, hx, hef, by simp [hfull, hcost], ?_⟩
    intro y hy
    exact Finset.sum_le_sum (fun i _ => (hcost i).symm ▸ one_le_cost y hy i)

/-- With at least one agent, a complete EFX allocation always exists. -/
theorem exists_EFX (tag : Fin n → Fin m → Bool) (hn : 0 < n) :
    ∃ x : Fin m → Fin n, EFX tag x := by
  classical
  by_cases hm : n ≤ m
  · obtain ⟨x, hx⟩ := exists_envyFree tag hn hm
    refine ⟨x, fun i j g _ => ?_⟩
    exact le_trans
      (Finset.card_le_card (Finset.image_subset_image (Finset.erase_subset _ _)))
      (hx i j)
  · let x : Fin m → Fin n := Fin.castLE (by omega)
    have hx : Injective x := fun _ _ h => Fin.ext (congrArg (fun j : Fin n => j.val) h)
    refine ⟨x, fun i j g hg => ?_⟩
    have hEmpty : (bundle x i).erase g = ∅ := by
      apply Finset.eq_empty_iff_forall_notMem.mpr
      intro a ha
      exact (Finset.mem_erase.mp ha).1
        (hx (((Finset.mem_filter.mp (Finset.mem_erase.mp ha).2).2).trans
          ((Finset.mem_filter.mp hg).2).symm))
    simp [hEmpty]

#print axioms exists_envyFree
#print axioms exact_minimum_own_cost
#print axioms exists_envyFree_with_all_monochromatic
#print axioms exists_envyFree_with_one_bichromatic
#print axioms exists_bichromatic_of_full
#print axioms exists_EFX

end TwoColor
