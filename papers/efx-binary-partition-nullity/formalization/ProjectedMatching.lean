import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Finset.Card
import Mathlib.Data.Fintype.Card

open scoped BigOperators

namespace TwoColorNullity

variable {Item Label : Type*} [DecidableEq Item] [DecidableEq Label] [Fintype Label]

/-- A family of disjoint two-item sets whose members share a label. -/
structure PairPacking (label : Item → Label) (available : Finset Item)
    (pairs : Finset (Finset Item)) : Prop where
  two : ∀ p ∈ pairs, p.card = 2
  inside : ∀ p ∈ pairs, p ⊆ available
  homogeneous : ∀ p ∈ pairs, ∀ x ∈ p, ∀ y ∈ p, label x = label y
  disjoint : ∀ p ∈ pairs, ∀ q ∈ pairs, p ≠ q → Disjoint p q

def projectedPairCount (label : Item → Label) (available : Finset Item) : ℕ :=
  ∑ v, (available.filter fun item => label item = v).card / 2

theorem projectedPairCount_remove_pair (label : Item → Label) (available pair : Finset Item)
    (hsize : pair.card = 2) (hinside : pair ⊆ available)
    (hsame : ∀ x ∈ pair, ∀ y ∈ pair, label x = label y) :
    projectedPairCount label available = projectedPairCount label (available \ pair) + 1 := by
  obtain ⟨first, hfirst⟩ := Finset.card_pos.mp (show 0 < pair.card by omega)
  have fiber (v : Label) :
      ((available \ pair).filter fun item => label item = v) =
        (available.filter fun item => label item = v) \ pair := by
    ext item
    simp only [Finset.mem_filter, Finset.mem_sdiff]
    exact ⟨fun ⟨⟨ha, hb⟩, hc⟩ => ⟨⟨ha, hc⟩, hb⟩,
      fun ⟨⟨ha, hc⟩, hb⟩ => ⟨⟨ha, hb⟩, hc⟩⟩
  have contribution (v : Label) :
      (available.filter fun item => label item = v).card / 2 =
        ((available \ pair).filter fun item => label item = v).card / 2 +
          if v = label first then 1 else 0 := by
    rw [fiber]
    by_cases hv : v = label first
    · subst v
      have hs : pair ⊆ available.filter (fun item => label item = label first) := by
        intro item hitem
        exact Finset.mem_filter.mpr ⟨hinside hitem, hsame item hitem first hfirst⟩
      have hc := Finset.card_sdiff_add_card_eq_card hs
      simp only [if_true]
      omega
    · have hd : Disjoint (available.filter fun item => label item = v) pair := by
        refine Finset.disjoint_left.mpr ?_
        intro item hitem hp
        exact hv ((Finset.mem_filter.mp hitem).2.symm.trans (hsame item hp first hfirst))
      rw [Finset.sdiff_eq_self_iff_disjoint.mpr hd]
      simp [hv]
  unfold projectedPairCount
  simp_rw [contribution]
  rw [Finset.sum_add_distrib]
  simp

/-- Every packing uses at most the sum of the half-bucket counts. -/
theorem PairPacking.card_le {label : Item → Label} {available : Finset Item}
    {pairs : Finset (Finset Item)} (packing : PairPacking label available pairs) :
    pairs.card ≤ projectedPairCount label available := by
  classical
  induction pairs using Finset.induction_on generalizing available with
  | empty => simp
  | @insert pair earlier hnot ih =>
      have hp : pair ∈ insert pair earlier := Finset.mem_insert_self _ _
      have hstep := projectedPairCount_remove_pair label available pair
        (packing.two pair hp) (packing.inside pair hp) (packing.homogeneous pair hp)
      have remaining : PairPacking label (available \ pair) earlier := by
        refine ⟨?_, ?_, ?_, ?_⟩
        · intro p hp
          exact packing.two p (Finset.mem_insert_of_mem hp)
        · intro p hp item hitem
          have hp' : p ∈ insert pair earlier := Finset.mem_insert_of_mem hp
          have hpne : p ≠ pair := fun he => hnot (he ▸ hp)
          exact Finset.mem_sdiff.mpr ⟨packing.inside p hp' hitem,
            Finset.disjoint_left.mp (packing.disjoint p hp' pair (Finset.mem_insert_self _ _) hpne) hitem⟩
        · intro p hp
          exact packing.homogeneous p (Finset.mem_insert_of_mem hp)
        · intro p hp q hq hpq
          exact packing.disjoint p (Finset.mem_insert_of_mem hp) q (Finset.mem_insert_of_mem hq) hpq
      have hle := ih remaining
      rw [Finset.card_insert_of_notMem hnot, hstep]
      omega

/-- Pairing within classes attains the half-bucket count. -/
theorem projectedPairCount_attained (label : Item → Label) (available : Finset Item) :
    ∃ pairs, PairPacking label available pairs ∧ pairs.card = projectedPairCount label available := by
  classical
  refine available.strongInductionOn (p := fun available =>
    ∃ pairs, PairPacking label available pairs ∧ pairs.card = projectedPairCount label available) ?_
  intro available ih
  by_cases hex : ∃ pair : Finset Item, pair.card = 2 ∧ pair ⊆ available ∧
      ∀ x ∈ pair, ∀ y ∈ pair, label x = label y
  · obtain ⟨pair, hsize, hinside, hsame⟩ := hex
    obtain ⟨first, hfirst⟩ := Finset.card_pos.mp (show 0 < pair.card by omega)
    have hsmall : available \ pair ⊂ available := Finset.sdiff_ssubset hinside ⟨first, hfirst⟩
    obtain ⟨earlier, packing, hcount⟩ := ih (available \ pair) hsmall
    have hnot : pair ∉ earlier := fun hp =>
      (Finset.mem_sdiff.mp (packing.inside pair hp hfirst)).2 hfirst
    have noOverlap (q : Finset Item) (hq : q ∈ earlier) : Disjoint pair q :=
      Finset.disjoint_left.mpr fun item hitem hqitem =>
        (Finset.mem_sdiff.mp (packing.inside q hq hqitem)).2 hitem
    refine ⟨insert pair earlier, ⟨?_, ?_, ?_, ?_⟩, ?_⟩
    · intro p hp
      rcases Finset.mem_insert.mp hp with rfl | hp
      · exact hsize
      · exact packing.two p hp
    · intro p hp
      rcases Finset.mem_insert.mp hp with rfl | hp
      · exact hinside
      · exact (packing.inside p hp).trans Finset.sdiff_subset
    · intro p hp
      rcases Finset.mem_insert.mp hp with rfl | hp
      · exact hsame
      · exact packing.homogeneous p hp
    · intro p hp q hq hpq
      rcases Finset.mem_insert.mp hp with hpEq | hpOld
      · subst p
        rcases Finset.mem_insert.mp hq with hqEq | hqOld
        · exact (hpq hqEq.symm).elim
        · exact noOverlap q hqOld
      · rcases Finset.mem_insert.mp hq with hqEq | hqOld
        · subst q
          exact (noOverlap p hpOld).symm
        · exact packing.disjoint p hpOld q hqOld hpq
    · rw [Finset.card_insert_of_notMem hnot, hcount,
        projectedPairCount_remove_pair label available pair hsize hinside hsame]
  · have hsmall (v : Label) : (available.filter fun item => label item = v).card ≤ 1 := by
      apply Finset.card_le_one.mpr
      intro x hx y hy
      by_contra hne
      refine hex ⟨{x, y}, by simp [hne], ?_, ?_⟩
      · intro p hp
        rcases Finset.mem_insert.mp hp with rfl | hp
        · exact (Finset.mem_filter.mp hx).1
        · simpa only [Finset.mem_singleton.mp hp] using (Finset.mem_filter.mp hy).1
      · have label_eq (p : Item) (hp : p ∈ ({x, y} : Finset Item)) : label p = v := by
          rcases Finset.mem_insert.mp hp with rfl | hp
          · exact (Finset.mem_filter.mp hx).2
          · simpa only [Finset.mem_singleton.mp hp] using (Finset.mem_filter.mp hy).2
        exact fun p hp q hq => (label_eq p hp).trans (label_eq q hq).symm
    have hz (v : Label) : (available.filter fun item => label item = v).card / 2 = 0 := by
      have := hsmall v
      omega
    exact ⟨∅, ⟨by simp, by simp, by simp, by simp⟩, by simp [projectedPairCount, hz]⟩

omit [DecidableEq Item] in
/-- At most one item per class remains unpaired. -/
theorem projectedPairCount_lower (label : Item → Label) (available : Finset Item) :
    available.card ≤ 2 * projectedPairCount label available + Fintype.card Label := by
  have hsum := Finset.card_eq_sum_card_fiberwise (s := available)
    (t := (Finset.univ : Finset Label)) (f := label) (fun _ _ => Finset.mem_univ _)
  rw [hsum]
  calc
    _ ≤ ∑ v : Label, (2 * ((available.filter fun item => label item = v).card / 2) + 1) := by
      apply Finset.sum_le_sum
      intro v _
      omega
    _ = _ := by simp [projectedPairCount, Finset.sum_add_distrib, Finset.mul_sum]

end TwoColorNullity
