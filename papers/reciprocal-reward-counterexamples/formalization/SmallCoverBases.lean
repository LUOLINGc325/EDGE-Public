import CoveringGame
import Mathlib.Data.Finset.Powerset
import Mathlib.Tactic.IntervalCases

/-! Small positive covering bases. Finite enumeration here concerns only
antichains of coordinate subsets of `Fin 0` through `Fin 3`. The rows
and real-valued strategy of the actual game are reduced to this classifier. -/

set_option autoImplicit false
open Finset

namespace ReciprocalSearch.SmallBases

def Antichain {E : Type*} (c : Finset (Finset E)) : Prop :=
  (∀ r ∈ c, r.Nonempty) ∧ ∀ s ∈ c, ∀ t ∈ c, s ⊆ t → s = t

noncomputable instance {E : Type*} [Fintype E] [DecidableEq E] (c : Finset (Finset E)) :
    Decidable (Antichain c) := by
  unfold Antichain
  infer_instance

set_option maxRecDepth 4096 in
set_option maxHeartbeats 2000000 in
theorem classify_fin (n : ℕ) (hn : n ≤ 3) :
    ∀ c : Finset (Finset (Fin n)), Antichain c → n ≤ c.card →
      (∀ i : Fin n, {i} ∈ c) ∨
      (n = 3 ∧ ∀ i j : Fin n, i ≠ j → {i, j} ∈ c) := by
  interval_cases n <;> decide

theorem classify {E : Type*} [Fintype E] [DecidableEq E]
    (c : Finset (Finset E)) (hc : Antichain c) (hn : Fintype.card E ≤ 3)
    (hl : Fintype.card E ≤ c.card) :
    (∀ i : E, {i} ∈ c) ∨ (Fintype.card E = 3 ∧ ∀ i j : E, i ≠ j → {i, j} ∈ c) := by
  let f := Fintype.equivFin E
  let lift : Finset E ↪ Finset (Fin (Fintype.card E)) := (Equiv.finsetCongr f).toEmbedding
  let c' := c.map lift
  have hl' : Fintype.card E ≤ c'.card := by simpa [c'] using hl
  have hc' : Antichain c' := by
    constructor
    · intro s hs
      obtain ⟨t, ht, rfl⟩ := mem_map.mp hs
      obtain ⟨i, hi⟩ := hc.1 t ht
      exact ⟨f i, mem_map.mpr ⟨i, hi, rfl⟩⟩
    · intro s hs t ht hst
      obtain ⟨S, hS, rfl⟩ := mem_map.mp hs
      obtain ⟨T, hT, rfl⟩ := mem_map.mp ht
      congr 1
      apply hc.2 S hS T hT
      intro e he
      have hf : f e ∈ lift S := mem_map.mpr ⟨e, he, rfl⟩
      obtain ⟨i, hi, heq⟩ := mem_map.mp (hst hf)
      exact f.injective heq ▸ hi
  rcases classify_fin _ hn c' hc' hl' with h | ⟨hcard, h⟩
  · left
    intro i
    have hi := h (f i)
    have hmap : lift {i} = {f i} := by simp [lift, Equiv.finsetCongr]
    rw [← hmap] at hi
    exact (mem_map' lift).mp hi
  · right
    refine ⟨hcard, fun i j hne => ?_⟩
    have hi := h (f i) (f j) (fun he => hne (f.injective he))
    have hmap : lift {i, j} = {f i, f j} := by simp [lift, Equiv.finsetCongr]
    rw [← hmap] at hi
    exact (mem_map' lift).mp hi

theorem equal_weights {E : Type*} [Fintype E] [DecidableEq E]
    (c : Finset (Finset E)) (hc : Antichain c) (hn : Fintype.card E ≤ 3)
    (hl : Fintype.card E ≤ c.card) (x : E → ℝ)
    (hrow : ∀ r ∈ c, ∑ e ∈ r, x e = 1) :
    (∀ e, x e = 1) ∨ (∀ e, x e = 1 / 2) := by
  rcases classify c hc hn hl with h | ⟨hc3, h⟩
  · exact Or.inl fun e => by simpa using hrow {e} (h e)
  · right
    intro i
    have hnot (s : Finset E) (hs : s.card < 3) : ∃ k, k ∉ s := by
      have hlt : s.card < (univ : Finset E).card := by simpa [hc3] using hs
      obtain ⟨k, _, hk⟩ := exists_mem_not_mem_of_card_lt_card hlt
      exact ⟨k, hk⟩
    obtain ⟨j, hj⟩ := hnot {i} (by simp)
    have hji : j ≠ i := by simpa using hj
    obtain ⟨k, hk⟩ := hnot {i, j} (by rw [card_pair hji.symm]; decide)
    have hki : k ≠ i := fun he => hk (by simp [he])
    have hkj : k ≠ j := fun he => hk (by simp [he])
    have hi := hrow {i, j} (h i j hji.symm)
    have hj' := hrow {j, k} (h j k hkj.symm)
    have hk' := hrow {k, i} (h k i hki)
    simp only [sum_insert, sum_singleton, mem_singleton, hji.symm, hkj.symm, hki, not_false_eq_true] at hi hj' hk'
    linarith

theorem antichain_of_positive_rows {E : Type*} (rows : Finset (Finset E))
    (x : E → ℝ) (hpos : ∀ i, 0 < x i) (hrow : ∀ r ∈ rows, ∑ i ∈ r, x i = 1) :
    Antichain rows := by
  constructor
  · intro r hr
    by_contra! hn
    have he := hrow r hr
    rw [not_nonempty_iff_eq_empty.mp hn, sum_empty] at he
    norm_num at he
  · intro r hr t ht hrt
    by_contra hne
    have hn : ¬t ⊆ r := fun hs => hne (Subset.antisymm hrt hs)
    obtain ⟨a, ha, hnot⟩ := not_subset.mp hn
    have hlt := sum_lt_sum_of_subset hrt ha hnot (hpos a) (fun b _ _ => (hpos b).le)
    rw [hrow r hr, hrow t ht] at hlt
    exact (lt_irrefl _ hlt)

noncomputable def patternMap {E : Type*} (rows : Finset (Finset E)) : (E → ℝ) →ₗ[ℝ] (rows → ℝ) where
  toFun z r := ∑ a ∈ r.val, z a
  map_add' x y := by funext r; simp [sum_add_distrib]
  map_smul' n x := by funext r; simp [mul_sum, smul_eq_mul]

open Classical in
theorem small_positive_binary_basis (n : ℕ) (hn : n ≤ 3) (B : Fin n → Fin n → Bool)
    (hB : Function.Injective (fun x : Fin n → ℝ => fun i : Fin n =>
      ∑ j, if B i j then x j else 0))
    (x : Fin n → ℝ) (hx : ∀ i, 0 < x i)
    (hrow : ∀ i, (∑ j, if B i j then x j else 0) = 1) :
    (∀ i, x i = 1) ∨ (∀ i, x i = 1 / 2) := by
  let r (i : Fin n) := univ.filter fun j : Fin n => B i j
  let rows := univ.image r
  have hrs : ∀ t ∈ rows, ∑ j ∈ t, x j = 1 := by
    intro t ht
    obtain ⟨i, _, rfl⟩ := mem_image.mp ht
    simpa [r, sum_filter] using hrow i
  have hi : Function.Injective (patternMap rows) := by
    intro a b hab
    apply hB
    funext i
    have hmem : r i ∈ rows := mem_image_of_mem r (mem_univ _)
    have h := congrFun hab ⟨r i, hmem⟩
    change (∑ j ∈ r i, a j) = ∑ j ∈ r i, b j at h
    simpa [r, sum_filter] using h
  have hcount := LinearMap.finrank_le_finrank_of_injective hi
  have hc : Fintype.card (Fin n) ≤ rows.card := by
    simpa only [Module.finrank_fintype_fun_eq_card, Fintype.card_coe] using hcount
  exact equal_weights rows (antichain_of_positive_rows rows x hx hrs)
    (by simpa using hn) hc x hrs

end ReciprocalSearch.SmallBases

namespace ReciprocalSearch.RewardGame

open Classical
noncomputable section
variable {A H : Type*} [Fintype A] [Fintype H]

def coverSupport (x : A → ℝ) : Finset A := univ.filter fun a => 0 < x a

def pattern (g : RewardGame A H) (s : Finset A) (h : H) : Finset s :=
  univ.filter fun a => g.safe a h

def tightPatterns (g : RewardGame A H) (s : Finset A) (x : A → ℝ) : Finset (Finset s) :=
  (univ.filter fun h => g.coverage x h = 1).image (g.pattern s)

omit [Fintype H] in
lemma coverage_of_extended (g : RewardGame A H) (s : Finset A) (z : s → ℝ) (h : H) :
    g.coverage (Active.extend s z) h = ∑ a ∈ g.pattern s h, z a := by
  let f : s ↪ A := ⟨Subtype.val, Subtype.val_injective⟩
  have hf : (g.pattern s h).map f = s.filter (fun a => g.safe a h) := by
    ext a
    constructor
    · intro ha
      obtain ⟨b, hb, rfl⟩ := mem_map.mp ha
      exact mem_filter.mpr ⟨b.property, (mem_filter.mp hb).2⟩
    · intro ha
      obtain ⟨hmem, hs⟩ := mem_filter.mp ha
      exact mem_map.mpr ⟨⟨a, hmem⟩, mem_filter.mpr ⟨mem_univ _, hs⟩, rfl⟩
  unfold coverage
  calc
    _ = ∑ a ∈ s.filter (fun a => g.safe a h), Active.extend s z a := by
      symm
      apply sum_subset (filter_subset_filter _ (subset_univ _))
      intro a ha hnot
      have hn : a ∉ s := fun hm => hnot (mem_filter.mpr ⟨hm, (mem_filter.mp ha).2⟩)
      exact Active.extend_of_not_mem s z hn
    _ = _ := by
      rw [← hf, sum_map]
      apply sum_congr rfl
      intro a _
      exact Active.extend_of_mem s z a.property

lemma tight_patterns_card (g : RewardGame A H) (x : A → ℝ)
    (hx : x ∈ g.coverFeasible.extremePoints ℝ) :
    (coverSupport x).card ≤ (g.tightPatterns (coverSupport x) x).card := by
  let s := coverSupport x
  let rows := g.tightPatterns s x
  have hinj : Function.Injective (SmallBases.patternMap rows) := by
    intro u v heq
    have hz : SmallBases.patternMap rows (u - v) = 0 := by rw [map_sub, heq, sub_self]
    have hd := Active.extreme_direction_zero hx (Active.extend s (u - v))
      (fun a ha => by simp [s, coverSupport, Active.extend, ha])
      (fun h hh => by
        change Active.row (g.coverCoeff h) x = -1 at hh
        rw [cover_row] at hh ⊢
        have ht : g.coverage x h = 1 := neg_injective hh
        have hm : g.pattern s h ∈ rows :=
          mem_image.mpr ⟨h, mem_filter.mpr ⟨mem_univ _, ht⟩, rfl⟩
        rw [g.coverage_of_extended]
        have he := congrFun hz ⟨g.pattern s h, hm⟩
        change (∑ a ∈ g.pattern s h, (u - v) a) = 0 at he
        rw [he, neg_zero])
    apply sub_eq_zero.mp
    funext a
    simpa only [Active.extend_of_mem s _ a.property] using congrFun hd a
  have h := LinearMap.finrank_le_finrank_of_injective hinj
  simpa only [Module.finrank_fintype_fun_eq_card, Fintype.card_coe] using h

lemma cover_common_positive_entries (g : RewardGame A H) (x : A → ℝ)
    (hx : x ∈ g.coverFeasible.extremePoints ℝ)
    (hsmall : Fintype.card A ≤ 3 ∨ Fintype.card H ≤ 3) :
    ∃ c : ℝ, 0 < c ∧ ∀ a ∈ coverSupport x, x a = c := by
  let s := coverSupport x
  let rows := g.tightPatterns s x
  let w (a : s) := x a
  have hfeas := (g.cover_feasible_iff x).mp hx.1
  have hw : Active.extend s w = x := by
    funext a
    by_cases ha : a ∈ s
    · exact Active.extend_of_mem s w ha
    · rw [Active.extend_of_not_mem s w ha]
      have hn : ¬0 < x a := fun hp => ha (mem_filter.mpr ⟨mem_univ _, hp⟩)
      linarith [hfeas.1 a, le_of_not_gt hn]
  have hrow : ∀ r ∈ rows, ∑ a ∈ r, w a = 1 := by
    intro r hr
    obtain ⟨h, hh, rfl⟩ := mem_image.mp hr
    rw [← g.coverage_of_extended, hw]
    exact (mem_filter.mp hh).2
  have hpos (a : s) : 0 < w a := (mem_filter.mp a.property).2
  have hanti := SmallBases.antichain_of_positive_rows rows w hpos hrow
  have hdim : Fintype.card s ≤ rows.card := by
    rw [Fintype.card_coe]
    exact g.tight_patterns_card x hx
  have hn : Fintype.card s ≤ 3 := hsmall.elim
    (fun h => by rw [Fintype.card_coe]; exact (card_le_univ s).trans h)
    (fun h => hdim.trans ((card_image_le.trans (card_le_univ _)).trans h))
  rcases SmallBases.equal_weights rows hanti hn hdim w hrow with h | h
  · exact ⟨1, by norm_num, fun a ha => h ⟨a, ha⟩⟩
  · exact ⟨1 / 2, by norm_num, fun a ha => h ⟨a, ha⟩⟩

variable [Nonempty H]

theorem small_game_has_optimal_reciprocal [Nonempty A] (g : RewardGame A H)
    (hsmall : Fintype.card A ≤ 3 ∨ Fintype.card H ≤ 3) :
    ∃ s : Finset A, s.Nonempty ∧ g.guarantee (g.reciprocal s) = g.value := by
  by_cases he : ∃ p, Probability p ∧ 0 < g.guarantee p
  · obtain ⟨p, hp, hg⟩ := he
    obtain ⟨hx, _⟩ := g.cover_from_guarantee p hp _ hg (g.guarantee_le_expected p)
    obtain ⟨x, hx, hmin⟩ := g.exists_extreme_minimum_cover hx
    obtain ⟨_, hv⟩ := g.optimum_from_minimum_cover hx.1 hmin
    obtain ⟨c, hc, hw⟩ := g.cover_common_positive_entries x hx hsmall
    let s := coverSupport x
    have hs : s.Nonempty := by
      by_contra he
      have equalEmpty : s = ∅ := not_nonempty_iff_eq_empty.mp he
      have hp : (0 : ℝ) < g.coverCost x := g.cover_cost_pos hx.1
      have hzero (a : A) : x a = 0 := by
        have hnon := ((g.cover_feasible_iff x).mp hx.1).1 a
        have hnot : ¬0 < x a := fun h => by
          have hm : a ∈ s := mem_filter.mpr ⟨mem_univ _, h⟩
          simp [equalEmpty] at hm
        linarith
      simp [coverCost, Active.row, hzero] at hp
    have hterm (a : A) : (1 / g.reward a) * x a =
        if a ∈ s then c * (1 / g.reward a) else 0 := by
      by_cases ha : a ∈ s
      · rw [if_pos ha, hw a ha, mul_comm]
      · have hp := ((g.cover_feasible_iff x).mp hx.1).1 a
        have hn : x a ≤ 0 := le_of_not_gt (fun h => ha (mem_filter.mpr ⟨mem_univ _, h⟩))
        have hzero : x a = 0 := le_antisymm hn hp
        simp [ha, hzero]
    have hcost : g.coverCost x = c * g.normalizer s := by
      unfold coverCost Active.row normalizer
      simp_rw [hterm]
      rw [← sum_filter, filter_univ_mem, mul_sum]
    have hprob : g.probabilityFromCover x = g.reciprocal s := by
      funext a
      rw [probabilityFromCover, hterm, hcost, reciprocal]
      by_cases ha : a ∈ s
      · simp only [ha, if_true]
        field_simp [hc.ne', (g.normalizer_pos hs).ne', (g.reward_pos a).ne']
        ring
      · simp [ha]
    rw [hprob] at hv
    exact ⟨s, hs, hv⟩
  · obtain ⟨a⟩ := ‹Nonempty A›
    let s : Finset A := {a}
    have hs : s.Nonempty := singleton_nonempty a
    have heq (p : A → ℝ) (hp : Probability p) : g.guarantee p = 0 := by
      apply le_antisymm (le_of_not_gt (fun h => he ⟨p, hp, h⟩))
      apply (g.le_guarantee_iff _ _).mpr
      intro h
      apply sum_nonneg
      intro a _
      apply mul_nonneg (hp.1 a)
      unfold payoff
      split_ifs <;> first | exact le_rfl | exact (g.reward_pos a).le
    have hvalue : g.value = 0 := by
      apply IsGreatest.csSup_eq
      exact ⟨⟨g.reciprocal s, g.reciprocal_probability hs, heq _ (g.reciprocal_probability hs)⟩,
        fun _ ⟨p, hp, ht⟩ => ht ▸ (heq p hp).le⟩
    exact ⟨s, hs, hvalue.symm ▸ heq _ (g.reciprocal_probability hs)⟩

end
end ReciprocalSearch.RewardGame

#print axioms ReciprocalSearch.SmallBases.small_positive_binary_basis
#print axioms ReciprocalSearch.RewardGame.small_game_has_optimal_reciprocal
