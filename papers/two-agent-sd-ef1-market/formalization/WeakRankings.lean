import Padding
import Mathlib.Data.Finset.Sort
import Mathlib.Data.Prod.Lex

open Finset
open scoped BigOperators

namespace MarketFairDivision

variable {Goods : Type*} [Fintype Goods] [DecidableEq Goods] {m : ℕ}

def Refines (r : Goods ≃ Fin m) (u : Goods → ℝ) : Prop :=
  ∀ x y, u y < u x → (r x).val < (r y).val

omit [Fintype Goods] [DecidableEq Goods] in
theorem ranked_utility_antitone (r : Goods ≃ Fin m) {u : Goods → ℝ}
    (hu : Refines r u) {x y : Goods} (h : (r x).val ≤ (r y).val) : u y ≤ u x := by
  by_contra! hs
  exact (Nat.not_lt_of_ge h) (hu y x hs)

omit [DecidableEq Goods] in
theorem exists_strict_refinement (u : Goods → ℝ) :
    ∃ r : Goods ≃ Fin (Fintype.card Goods), Refines r u := by
  classical
  let identityRank := Fintype.equivFin Goods
  let key : Goods → Lex (ℝ × Fin (Fintype.card Goods)) := fun x => toLex (-u x, identityRank x)
  have hkey : Function.Injective key := by
    intro x y h
    exact identityRank.injective (congrArg Prod.snd (toLex.injective h))
  letI : LinearOrder Goods := LinearOrder.lift' key hkey
  let ranking := (Fintype.orderIsoFinOfCardEq Goods rfl).symm
  refine ⟨ranking.toEquiv, fun x y h => ?_⟩
  have hxy : x < y := by
    change key x < key y
    exact Prod.Lex.toLex_lt_toLex.mpr (Or.inl (neg_lt_neg h))
  exact ranking.strictMono hxy

noncomputable def contour (u : Goods → ℝ) (level : ℝ) : Finset Goods :=
  open Classical in Finset.univ.filter fun x => level ≤ u x

omit [DecidableEq Goods] in
@[simp] theorem mem_contour (u : Goods → ℝ) (level : ℝ) (x : Goods) :
    x ∈ contour u level ↔ level ≤ u x := by
  classical
  simp [contour]

omit [DecidableEq Goods] in
theorem contour_is_prefix (r : Goods ≃ Fin m) (u : Goods → ℝ) (hu : Refines r u)
    (level : ℝ) : ∃ l ≤ m, contour u level = rankPrefix r l := by
  classical
  let H := contour u level
  by_cases hH : H.Nonempty
  · obtain ⟨last, hlast, hmax⟩ := Finset.exists_max_image H (fun x => (r x).val) hH
    refine ⟨(r last).val + 1, (r last).isLt, ?_⟩
    ext x
    rw [mem_prefix]
    constructor
    · intro hx
      exact Nat.lt_succ_of_le (hmax x hx)
    · intro hx
      have hux := ranked_utility_antitone r hu (Nat.le_of_lt_succ hx)
      exact (mem_contour u level x).mpr (((mem_contour u level last).mp hlast).trans hux)
  · exact ⟨0, Nat.zero_le _, by simpa using Finset.not_nonempty_iff_eq_empty.mp hH⟩

def WeakEF1 (u : Goods → ℝ) (A B : Finset Goods) : Prop :=
  B = ∅ ∨ ∃ g ∈ B, ∀ t : ℝ, ((B.erase g) ∩ contour u t).card ≤ (A ∩ contour u t).card

theorem refined_witness (r : Goods ≃ Fin m) (u : Goods → ℝ) (hu : Refines r u)
    {A B : Finset Goods} (h : RankEF1 r A B) : WeakEF1 u A B := by
  rcases h with he | ⟨g, hg, hg'⟩
  · exact Or.inl he
  · right
    refine ⟨g, hg, fun t => ?_⟩
    obtain ⟨l, hl, hprefix⟩ := contour_is_prefix r u hu t
    rw [hprefix]
    exact hg' l hl

noncomputable def rankedUtility (r : Goods ≃ Fin m) (u : Goods → ℝ) (i : ℕ) : ℝ :=
  if hi : i < m then u (r.symm ⟨i, hi⟩) else 0

omit [Fintype Goods] [DecidableEq Goods] in
theorem rankedUtility_at (r : Goods ≃ Fin m) (u : Goods → ℝ) (x : Goods) :
    rankedUtility r u (r x).val = u x := by simp [rankedUtility, (r x).isLt]

omit [Fintype Goods] [DecidableEq Goods] in
theorem rankedUtility_step_nonneg (r : Goods ≃ Fin m) (u : Goods → ℝ)
    (hu : Refines r u) (hn : ∀ x, 0 ≤ u x) (i : ℕ) :
    0 ≤ rankedUtility r u i - rankedUtility r u (i + 1) := by
  unfold rankedUtility
  by_cases h₁ : i < m
  · rw [dif_pos h₁]
    by_cases h₂ : i + 1 < m
    · rw [dif_pos h₂]
      apply sub_nonneg.mpr
      apply ranked_utility_antitone r hu
      simp
    · rw [dif_neg h₂, sub_zero]
      exact hn _
  · rw [dif_neg h₁, dif_neg (by omega : ¬ i + 1 < m), sub_self]

omit [Fintype Goods] [DecidableEq Goods] in
theorem individual_summation_by_parts (r : Goods ≃ Fin m) (u : Goods → ℝ) (x : Goods)
    (n : ℕ) :
    (∑ i ∈ Finset.range n,
      if (r x).val ≤ i then rankedUtility r u i - rankedUtility r u (i + 1) else 0) =
    if (r x).val < n then u x - rankedUtility r u n else 0 := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ih]
    by_cases h : (r x).val < n
    · rw [if_pos h, if_pos (Nat.le_of_lt h), if_pos (h.trans (Nat.lt_succ_self n))]
      linarith
    · rw [if_neg h]
      by_cases he : (r x).val = n
      · have hh : (r x).val < n + 1 := by omega
        rw [if_pos he.le, if_pos hh, zero_add]
        rw [← he, rankedUtility_at]
      · have hn : n < (r x).val := by omega
        rw [if_neg (Nat.not_le.mpr hn), if_neg (by omega : ¬ (r x).val < n + 1), zero_add]

theorem bundle_summation_by_parts (r : Goods ≃ Fin m) (u : Goods → ℝ) (A : Finset Goods) :
    value u A = ∑ i ∈ Finset.range m,
      (rankedUtility r u i - rankedUtility r u (i + 1)) *
        ((A ∩ rankPrefix r (i + 1)).card : ℝ) := by
  classical
  let delta (i : ℕ) := rankedUtility r u i - rankedUtility r u (i + 1)
  have hrow (x : Goods) : (∑ i ∈ Finset.range m, if (r x).val ≤ i then delta i else 0) = u x := by
    simpa [delta, (r x).isLt, rankedUtility] using individual_summation_by_parts r u x m
  have hcol (i : ℕ) :
      (∑ x ∈ A, if (r x).val ≤ i then delta i else 0) =
        delta i * ((A ∩ rankPrefix r (i + 1)).card : ℝ) := by
    rw [← Finset.sum_filter]
    have he : A.filter (fun x => (r x).val ≤ i) = A ∩ rankPrefix r (i + 1) := by
      ext x
      simp [Nat.lt_succ_iff]
    rw [he, Finset.sum_const, nsmul_eq_mul, mul_comm]
  calc
    value u A = ∑ x ∈ A, ∑ i ∈ Finset.range m, if (r x).val ≤ i then delta i else 0 := by
      simp [value, hrow]
    _ = ∑ i ∈ Finset.range m, ∑ x ∈ A, if (r x).val ≤ i then delta i else 0 :=
      Finset.sum_comm
    _ = _ := Finset.sum_congr rfl fun i _ => hcol i

theorem ordinal_witness_is_additive (r : Goods ≃ Fin m) (u : Goods → ℝ)
    (hu : Refines r u) (hn : ∀ x, 0 ≤ u x) {A B : Finset Goods}
    (h : RankEF1 r A B) : AdditiveEF1 u A B := by
  rcases h with he | ⟨g, hg, hgood⟩
  · exact Or.inl he
  · refine Or.inr ⟨g, hg, ?_⟩
    rw [bundle_summation_by_parts r, bundle_summation_by_parts r]
    apply Finset.sum_le_sum
    intro i hi
    exact mul_le_mul_of_nonneg_left
      (Nat.cast_le.mpr (hgood (i + 1) (Finset.mem_range.mp hi)))
      (rankedUtility_step_nonneg r u hu hn i)

theorem simultaneous_fair_all_finite
    (u v w : Goods → ℝ) (hu : ∀ x, 0 ≤ u x) (hv : ∀ x, 0 ≤ v x) (hw : ∀ x, 0 ≤ w x) :
    ∃ A, Balanced A (other A) ∧ WeakEF1 u A (other A) ∧ WeakEF1 v (other A) A ∧
      AdditiveEF1 u A (other A) ∧ AdditiveEF1 v (other A) A ∧ MarketEF1 w A := by
  obtain ⟨p, hp⟩ := exists_strict_refinement u
  obtain ⟨q, hq⟩ := exists_strict_refinement v
  obtain ⟨A, hA, hpA, hqA, hM⟩ := simultaneous_strict w hw p q
  exact ⟨A, hA, refined_witness p u hp hpA, refined_witness q v hq hqA,
    ordinal_witness_is_additive p u hp hu hpA, ordinal_witness_is_additive q v hq hv hqA, hM⟩

end MarketFairDivision
