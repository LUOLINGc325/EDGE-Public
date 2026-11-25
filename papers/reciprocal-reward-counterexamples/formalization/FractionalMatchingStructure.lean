import GraphSearch

/-! The residual support of an extreme fractional matching. Degree counting
and the injective active incidence map force residual loads to be half-integral. -/

set_option autoImplicit false
open Finset Set

namespace ReciprocalSearch.SimpleEdges

variable {E V : Type*} [Fintype E]

noncomputable section
open Classical

def residualEdges (x : E → ℝ) : Finset E :=
  univ.filter fun e => 0 < x e ∧ x e < 1

def unitEdges (x : E → ℝ) : Finset E :=
  univ.filter fun e => x e = 1

def supportedEdges (x : E → ℝ) : Finset E :=
  univ.filter fun e => 0 < x e

lemma unit_excludes_other (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible) {a b : E} (hab : a ≠ b)
    (ha : x a = 1) (hb : 0 < x b) :
    Disjoint (g.ends a) (g.ends b) := by
  apply Finset.disjoint_left.mpr
  intro v h₁ h₂
  let f e := if v ∈ g.ends e then x e else 0
  have hsum : g.load x v = ∑ e, f e := g.load_eq_sum x v
  have hone := sum_erase_add univ f (mem_univ a)
  have hle : f b ≤ ∑ e ∈ univ.erase a, f e :=
    single_le_sum (fun e _ => by
      by_cases he : v ∈ g.ends e <;> simp [f, he, hx.1 e])
      (mem_erase.mpr ⟨hab.symm, mem_univ b⟩)
  have ht := hx.2 v
  change g.load x v ≤ 1 at ht
  rw [hsum] at ht
  have hva : f a = 1 := by simp [f, h₁, ha]
  have hvb : f b = x b := by simp [f, h₂]
  linarith

lemma residual_vertex_no_unit (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible) {v : V} (hv : 0 < g.degree (residualEdges x) v)
    {e : E} (he : x e = 1) : v ∉ g.ends e := by
  obtain ⟨f, hf⟩ := card_pos.mp hv
  obtain ⟨hfR, hvf⟩ := mem_filter.mp hf
  have hfx := (mem_filter.mp hfR).2
  have hne : e ≠ f := by intro heq; subst e; linarith [hfx.2]
  exact fun hve => (Finset.disjoint_left.mp (g.unit_excludes_other x hx hne he hfx.1)) hve hvf

lemma residual_load_eq (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible) (v : V) (hv : 0 < g.degree (residualEdges x) v) :
    g.load x v = ∑ e ∈ (residualEdges x).filter (fun e => v ∈ g.ends e), x e := by
  rw [g.load_eq_sum, ← sum_filter]
  symm
  apply sum_subset (filter_subset_filter _ (subset_univ _))
  intro e he hne
  have hve := (mem_filter.mp he).2
  have hnon : e ∉ residualEdges x := fun hr => hne (mem_filter.mpr ⟨hr, hve⟩)
  have hxlt : x e < 1 := lt_of_le_of_ne (g.matching_weight_le_one x hx e)
    (fun h => g.residual_vertex_no_unit x hx hv h hve)
  by_contra hzero
  have hxpos : 0 < x e := lt_of_le_of_ne (hx.1 e) (Ne.symm hzero)
  exact hnon (mem_filter.mpr ⟨mem_univ _, hxpos, hxlt⟩)

lemma tight_residual_degree_ge_two (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible) (v : V) (hv : 0 < g.degree (residualEdges x) v)
    (ht : g.load x v = 1) : 2 ≤ g.degree (residualEdges x) v := by
  by_contra! hn
  have hd : g.degree (residualEdges x) v = 1 := by omega
  obtain ⟨e, he⟩ := card_eq_one.mp hd
  rw [g.residual_load_eq x hx v hv, he, sum_singleton] at ht
  have hr : e ∈ residualEdges x := (mem_filter.mp (by rw [he]; simp)).1
  exact ((mem_filter.mp hr).2.2.ne) ht

variable [Fintype V]

theorem extreme_residual_degrees (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible.extremePoints ℝ) :
    ∀ v, g.degree (residualEdges x) v = 0 ∨
      g.degree (residualEdges x) v = 2 ∧ g.load x v = 1 := by
  let R := residualEdges x
  let T : Finset V := univ.filter fun v => g.load x v = 1 ∧ 0 < g.degree R v
  have hbound : R.card ≤ T.card := by
    apply Active.active_card_le hx R T
    · intro e he
      exact ((mem_filter.mp he).2.1).ne'
    · intro v hv hvT e he
      unfold incidence
      have hnot : v ∉ g.ends e := by
        intro hve
        have hp : 0 < g.degree R v := card_pos.mpr ⟨e, mem_filter.mpr ⟨he, hve⟩⟩
        exact hvT (mem_filter.mpr ⟨mem_univ _, hv, hp⟩)
      simp [hnot]
  have hpoint (v : V) : (if v ∈ T then 2 else 0) ≤ g.degree R v := by
    by_cases h : v ∈ T
    · rw [if_pos h]
      exact g.tight_residual_degree_ge_two x hx.1 v (mem_filter.mp h).2.2 (mem_filter.mp h).2.1
    · simp [h]
  have hsum : (∑ v : V, if v ∈ T then 2 else 0) = 2 * T.card := by
    rw [← sum_filter, filter_univ_mem]
    simp [mul_comm]
  have hdeg := g.sum_degree R
  have hge : 2 * T.card ≤ 2 * R.card := by
    rw [← hsum, ← hdeg]
    exact sum_le_sum fun v _ => hpoint v
  have hcards : R.card = T.card := by omega
  intro v
  have hd : (if v ∈ T then 2 else 0) = g.degree R v := by
    by_contra hn
    have hstrict := sum_lt_sum (fun i _ => hpoint i)
      ⟨v, mem_univ _, lt_of_le_of_ne (hpoint v) hn⟩
    rw [hsum, hdeg, hcards] at hstrict
    exact (lt_irrefl _ hstrict)
  by_cases h : v ∈ T
  · exact Or.inr ⟨by simpa [h] using hd.symm, (mem_filter.mp h).2.1⟩
  · exact Or.inl (by simpa [h] using hd.symm)

theorem extreme_residual_weight_half (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible.extremePoints ℝ) {e : E} (he : e ∈ residualEdges x) :
    x e = 1 / 2 := by
  let R := residualEdges x
  let δ : E → ℝ := fun a => if a ∈ R then x a - 1/2 else 0
  have hz := Active.extreme_direction_zero hx δ
    (fun a ha => by simp [δ, R, residualEdges, ha])
    (fun v hv => by
      change g.load δ v = 0
      rw [g.load_eq_sum, ← sum_filter]
      unfold δ
      rw [← sum_filter]
      have hset : ({a ∈ (univ : Finset E) | v ∈ g.ends a}.filter (fun a => a ∈ R)) =
          R.filter (fun a => v ∈ g.ends a) := by
        ext a; simp [and_comm]
      rw [hset, sum_sub_distrib, sum_const, nsmul_eq_mul]
      rcases g.extreme_residual_degrees x hx v with hv0 | ⟨hv2, _⟩
      · have hnil : (R.filter (fun a => v ∈ g.ends a)) = ∅ := card_eq_zero.mp hv0
        simp [hnil]
      · change (∑ a ∈ R.filter (fun a => v ∈ g.ends a), x a) -
          (g.degree R v : ℝ) * (1 / 2) = 0
        rw [← g.residual_load_eq x hx.1 v (by omega), hv2]
        change g.load x v = 1 at hv
        rw [hv]
        norm_num)
  have h := congrFun hz e
  apply sub_eq_zero.mp
  simpa [δ, R, he] using h

end
end ReciprocalSearch.SimpleEdges
