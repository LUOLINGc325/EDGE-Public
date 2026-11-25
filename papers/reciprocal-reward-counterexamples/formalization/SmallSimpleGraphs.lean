import GraphSearch

set_option autoImplicit false
open Finset

namespace ReciprocalSearch.SimpleEdges
noncomputable section
open Classical
variable {E V : Type*}

lemma ends_pair_at (g : SimpleEdges E V) (e : E) {v : V} (hv : v ∈ g.ends e) :
    ∃ w, v ≠ w ∧ g.ends e = {v, w} := by
  have hcard : 1 < (g.ends e).card := by rw [g.card_ends]; decide
  obtain ⟨w, hw, hn⟩ := exists_ne_of_one_lt_card hcard v
  have hsub : {v, w} ⊆ g.ends e := by simp [insert_subset_iff, hv, hw]
  exact ⟨w, hn.symm, (eq_of_subset_of_card_le hsub (by rw [card_pair hn.symm, g.card_ends])).symm⟩

lemma star_or_triangle [Nonempty E] (g : SimpleEdges E V)
    (h : ∀ e f, ¬Disjoint (g.ends e) (g.ends f)) :
    (∃ v, ∀ e, v ∈ g.ends e) ∨
      ∃ (u v w : V) (a b c : E), u ≠ v ∧ u ≠ w ∧ v ≠ w ∧
        g.ends a = {u,v} ∧ g.ends b = {u,w} ∧ g.ends c = {v,w} ∧
        ∀ e, e = a ∨ e = b ∨ e = c := by
  obtain ⟨a⟩ := ‹Nonempty E›
  by_cases hs : ∃ v, ∀ e, v ∈ g.ends e
  · exact Or.inl hs
  right
  have hns (v : V) : ∃ e, v ∉ g.ends e := by
    by_contra! hn
    exact hs ⟨v, hn⟩
  have hpair (e f : E) : ∃ z, z ∈ g.ends e ∧ z ∈ g.ends f :=
    not_disjoint_iff.mp (h e f)
  obtain ⟨v, hv, _⟩ := hpair a a
  obtain ⟨b, hvb⟩ := hns v
  obtain ⟨u, hua, hub⟩ := hpair a b
  have huv : u ≠ v := fun h => hvb (h ▸ hub)
  have ha : g.ends a = {u,v} := by
    symm
    apply eq_of_subset_of_card_le (by simp [insert_subset_iff, hua, hv])
    rw [card_pair huv, g.card_ends]
  obtain ⟨w, huw, hb⟩ := g.ends_pair_at b hub
  have hvw : v ≠ w := fun h => hvb (by simp [hb, h])
  obtain ⟨c, huc⟩ := hns u
  have hit (e f : E) (x y : V) (hf : g.ends f = {x,y}) (hxe : x ∉ g.ends e) :
      y ∈ g.ends e := by
    obtain ⟨z, hz, hz'⟩ := hpair f e
    rw [hf, mem_insert, mem_singleton] at hz
    rcases hz with rfl | rfl
    · exact (hxe hz').elim
    · exact hz'
  have hvc := hit c a u v ha huc
  have hwc := hit c b u w hb huc
  have eq_pair (e : E) (x y : V) (hxy : x ≠ y)
      (hx : x ∈ g.ends e) (hy : y ∈ g.ends e) : g.ends e = {x,y} := by
    symm
    apply eq_of_subset_of_card_le (by simp [insert_subset_iff, hx, hy])
    rw [card_pair hxy, g.card_ends]
  have hc := eq_pair c v w hvw hvc hwc
  refine ⟨u, v, w, a, b, c, huv, huw, hvw, ha, hb, hc, ?_⟩
  intro e
  by_cases hU : u ∈ g.ends e
  · obtain ⟨z, hz, hz'⟩ := hpair c e
    rw [hc, mem_insert, mem_singleton] at hz
    rcases hz with hz | hz
    · exact Or.inl (g.ends_injective ((eq_pair e u v huv hU (hz ▸ hz')).trans ha.symm))
    · exact Or.inr (Or.inl (g.ends_injective ((eq_pair e u w huw hU (hz ▸ hz')).trans hb.symm)))
  · exact Or.inr (Or.inr (g.ends_injective
      ((eq_pair e v w hvw (hit e a u v ha hU) (hit e b u w hb hU)).trans hc.symm)))

variable [Fintype E] [Fintype V] [Nonempty E] [Nonempty V]

omit [Nonempty E] in
lemma load_sum_le_card_mul_max (g : SimpleEdges E V) (p : E → ℝ)
    (hp : RewardGame.Probability p) (s : Finset V)
    (hs : ∀ e, g.ends e ⊆ s) :
    2 ≤ (s.card : ℝ) * g.maxLoad p := by
  have hsum : 2 = ∑ v ∈ s, g.load p v := by
    calc
      2 = ∑ v, g.load p v := by rw [g.sum_load, total, hp.2, mul_one]
      _ = _ := by
        symm
        apply sum_subset (subset_univ _)
        intro v _ hv
        rw [g.load_eq_sum]
        exact sum_eq_zero fun e _ => if_neg (fun h => hv (hs e h))
  rw [hsum, ← nsmul_eq_mul, ← sum_const]
  exact sum_le_sum fun v _ => g.load_le_maxLoad p v

omit [Nonempty E] in
lemma all_guarantees_at_most_one (g : SimpleEdges E V) (hc : Fintype.card V ≤ 4)
    (p : E → ℝ) (hp : RewardGame.Probability p) : g.searchGame.guarantee p ≤ 1 := by
  have hL := g.maxLoad_pos p hp
  have hh := g.load_sum_le_card_mul_max p hp univ (fun _ => subset_univ _)
  rw [card_univ] at hh
  have hcr : (Fintype.card V : ℝ) ≤ 4 := by exact_mod_cast hc
  have h := mul_le_mul_of_nonneg_right hcr hL.le
  rw [g.guarantee_of_probability p hp]
  linarith

theorem small_graph_has_optimal_reciprocal (g : SimpleEdges E V) (hc : Fintype.card V ≤ 4) :
    ∃ s : Finset E, s.Nonempty ∧ g.searchGame.guarantee (g.searchGame.reciprocal s) = g.searchGame.value := by
  suffices key : ∃ (s : Finset E) (v : ℝ), s.Nonempty ∧
      g.searchGame.guarantee (g.searchGame.reciprocal s) = v ∧
      ∀ p, RewardGame.Probability p → g.searchGame.guarantee p ≤ v by
    obtain ⟨s, v, hs, he, hu⟩ := key
    refine ⟨s, hs, ?_⟩
    have hv : g.searchGame.value = v := by
      apply IsGreatest.csSup_eq
      refine ⟨⟨_, g.searchGame.reciprocal_probability hs, he⟩, ?_⟩
      rintro t ⟨p, hp, heq⟩
      exact heq ▸ hu p hp
    exact he.trans hv.symm
  by_cases hd : ∃ a b, Disjoint (g.ends a) (g.ends b)
  · obtain ⟨a,b,h⟩ := hd
    have hne : a ≠ b := by
      intro he
      subst b
      have hp : (g.ends a).Nonempty := by rw [← card_pos, g.card_ends]; decide
      obtain ⟨v, hv⟩ := hp
      exact (Finset.disjoint_left.mp h) hv hv
    let s : Finset E := {a,b}
    have hs : s.Nonempty := ⟨a, by simp [s]⟩
    have hdeg : g.maxDegree s = 1 := by
      apply le_antisymm _ (g.maxDegree_pos s hs)
      apply Finset.sup_le
      intro v _
      unfold degree
      by_cases ha : v ∈ g.ends a
      · have hb : v ∉ g.ends b := (Finset.disjoint_left.mp h) ha
        simp [s, filter_insert, filter_singleton, ha, hb, hne]
      · by_cases hb : v ∈ g.ends b <;> simp [s, filter_insert, filter_singleton, ha, hb, hne]
    refine ⟨s, 1, hs, ?_, g.all_guarantees_at_most_one hc⟩
    rw [g.reciprocal_guarantee_formula s hs, hdeg, show s.card = 2 from card_pair hne]
    norm_num
  · push_neg at hd
    rcases g.star_or_triangle hd with ⟨v, hv⟩ |
      ⟨u,v,w,a,b,c,huv,huw,hvw,ha,hb,hc',hall⟩
    · obtain ⟨a⟩ := ‹Nonempty E›
      let s : Finset E := {a}
      have hsn : s.Nonempty := singleton_nonempty a
      have hupper (p : E → ℝ) : g.searchGame.guarantee p ≤ 0 := by
        apply (g.searchGame.guarantee_le_expected p v).trans
        simp [RewardGame.expected, searchGame, RewardGame.payoff, hv]
      refine ⟨s, 0, hsn, le_antisymm (hupper _) ?_, fun p _ => hupper p⟩
      apply (g.searchGame.le_guarantee_iff _ _).mpr
      intro z
      rw [RewardGame.reciprocal_expected]
      exact div_nonneg (Nat.cast_nonneg _) (g.searchGame.normalizer_pos hsn).le
    · let s : Finset E := {a,b,c}
      let W : Finset V := {u,v,w}
      have hneAB : a ≠ b := by
        intro he
        have hi : v ∈ g.ends b := he ▸ (by simp [ha])
        simp [hb, huv.symm, hvw] at hi
      have hneAC : a ≠ c := by
        intro he
        have hi : u ∈ g.ends c := he ▸ (by simp [ha])
        simp [hc', huv, huw] at hi
      have hneBC : b ≠ c := by
        intro he
        have hi : u ∈ g.ends c := he ▸ (by simp [hb])
        simp [hc', huv, huw] at hi
      have hsc : s.card = 3 := by simp [s, hneAB, hneAC, hneBC]
      have hw : W.card = 3 := by simp [W, huv, huw, hvw]
      have hsn : s.Nonempty := ⟨a, by simp [s]⟩
      have hsub (e : E) : g.ends e ⊆ W := by
        rcases hall e with rfl | rfl | rfl <;> simp [W, ha, hb, hc', insert_subset_iff]
      refine ⟨s, 2 / 3, hsn, ?_, ?_⟩
      · have hdeg (z : V) : g.degree s z ≤ 2 := by
          by_cases hu : z = u
          · subst z; simp [degree, s, filter_insert, filter_singleton, ha, hb, hc', huv, huw,
              hvw, hneAB, hneAC, hneBC]
          by_cases hv : z = v
          · subst z; simp [degree, s, filter_insert, filter_singleton, ha, hb, hc', huv.symm,
              hvw, hneAB, hneAC, hneBC]
          by_cases hW : z = w
          · subst z; simp [degree, s, filter_insert, filter_singleton, ha, hb, hc', huw.symm,
              hvw.symm, hneAB, hneAC, hneBC]
          simp [degree, s, filter_insert, filter_singleton, ha, hb, hc', hu, hv, hW]
        have hm : g.maxDegree s = 2 := by
          apply le_antisymm (Finset.sup_le (fun z _ => hdeg z))
          have hdu : g.degree s u = 2 := by
            simp [degree, s, filter_insert, filter_singleton, ha, hb, hc', huv, huw, hneAB]
          rw [← hdu]
          exact g.degree_le_maxDegree s u
        rw [g.reciprocal_guarantee_formula s hsn, hm, hsc]
        norm_num
      · intro p hp
        have hl := g.load_sum_le_card_mul_max p hp W hsub
        rw [hw] at hl
        rw [g.guarantee_of_probability p hp]
        norm_num at hl ⊢
        linarith

end
end ReciprocalSearch.SimpleEdges
