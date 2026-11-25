import FiniteRewardGame
import ActiveConstraints
import Mathlib.Analysis.Convex.Topology
import Mathlib.Combinatorics.SimpleGraph.Finite
import Mathlib.Tactic.Linarith

/-!
# Graph search and fractional matching

Edges are indexed by a finite type, with two distinct endpoints per edge and
an injective endpoints map. This is the finite simple graph edge presentation.
-/

set_option autoImplicit false
open Finset Set

namespace ReciprocalSearch

structure SimpleEdges (E V : Type*) where
  ends : E → Finset V
  card_ends : ∀ e, (ends e).card = 2
  ends_injective : Function.Injective ends

namespace SimpleEdges

variable {E V : Type*} [Fintype E] [Fintype V]

noncomputable section
open Classical

noncomputable def searchGame (g : SimpleEdges E V) : RewardGame E V where
  reward _ := 2
  safe e v := v ∉ g.ends e
  reward_pos _ := by norm_num

def incidence (g : SimpleEdges E V) (v : V) (e : E) : ℝ :=
  if v ∈ g.ends e then 1 else 0

def load (g : SimpleEdges E V) (p : E → ℝ) (v : V) : ℝ :=
  Active.row (g.incidence v) p

noncomputable def total (p : E → ℝ) : ℝ := ∑ e, p e

def matchingFeasible (g : SimpleEdges E V) : Set (E → ℝ) :=
  Active.feasible g.incidence fun _ => 1

omit [Fintype V] in
lemma matching_mem (g : SimpleEdges E V) (x : E → ℝ) :
    x ∈ g.matchingFeasible ↔ (∀ e, 0 ≤ x e) ∧ ∀ v, g.load x v ≤ 1 := Iff.rfl

omit [Fintype V] in
lemma load_eq_sum (g : SimpleEdges E V) (p : E → ℝ) (v : V) :
    g.load p v = ∑ e, if v ∈ g.ends e then p e else 0 := by
  unfold load Active.row incidence
  simp only [ite_mul, one_mul, zero_mul]

lemma sum_load (g : SimpleEdges E V) (p : E → ℝ) :
    ∑ v, g.load p v = 2 * total p := by
  simp only [load_eq_sum]
  rw [sum_comm, total, mul_sum]
  apply sum_congr rfl
  intro e _
  rw [← sum_filter, filter_univ_mem]
  simp [g.card_ends]

omit [Fintype V] in
lemma weight_le_load (g : SimpleEdges E V) (x : E → ℝ) (hx : ∀ e, 0 ≤ x e)
    (e : E) (v : V) (hv : v ∈ g.ends e) : x e ≤ g.load x v := by
  rw [load_eq_sum]
  have h := single_le_sum (s := univ) (f := fun a => if v ∈ g.ends a then x a else 0)
    (fun a _ => by by_cases h : v ∈ g.ends a <;> simp [h, hx a]) (mem_univ e)
  simpa only [if_pos hv] using h

omit [Fintype V] in
lemma matching_weight_le_one (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible) (e : E) : x e ≤ 1 := by
  have hne : (g.ends e).Nonempty := by rw [← card_pos, g.card_ends]; decide
  obtain ⟨v, hv⟩ := hne
  exact (g.weight_le_load x hx.1 e v hv).trans (hx.2 v)

omit [Fintype V] in
lemma matching_feasible_compact (g : SimpleEdges E V) : IsCompact g.matchingFeasible := by
  apply (isCompact_Icc (a := (0 : E → ℝ)) (b := 1)).of_isClosed_subset
  · exact Active.feasible_closed _ _
  · intro x hx
    exact ⟨hx.1, g.matching_weight_le_one x hx⟩

omit [Fintype V] in
lemma matching_zero (g : SimpleEdges E V) : (0 : E → ℝ) ∈ g.matchingFeasible := by
  constructor
  · simp
  · intro v
    change g.load (0 : E → ℝ) v ≤ 1
    simp [load_eq_sum]

omit [Fintype V] in
lemma matching_single (g : SimpleEdges E V) (e : E) :
    (fun a => if a = e then (1 : ℝ) else 0) ∈ g.matchingFeasible := by
  constructor
  · intro a
    by_cases h : a = e <;> simp [h]
  · intro v
    change g.load (fun a => if a = e then (1 : ℝ) else 0) v ≤ 1
    rw [load_eq_sum]
    have he : (∑ a : E, if v ∈ g.ends a then if a = e then (1 : ℝ) else 0 else 0) =
        if v ∈ g.ends e then 1 else 0 := by
      rw [sum_eq_single e]
      · simp
      · intro a _ ha; simp [ha]
      · simp
    rw [he]
    split_ifs <;> simp

omit [Fintype V] in
/-- A maximum exists and can be chosen extreme in the original matching polytope. -/
theorem exists_extreme_maximum_matching (g : SimpleEdges E V) :
    ∃ x ∈ g.matchingFeasible.extremePoints ℝ,
      ∀ y ∈ g.matchingFeasible, total y ≤ total x := by
  let l := Active.rowFunctional (fun _ : E => 1)
  have hl (x : E → ℝ) : l x = total x := by simp [l, Active.rowFunctional_apply, Active.row, total]
  have hc : IsCompact {x ∈ g.matchingFeasible | l 0 ≤ l x} :=
    (g.matching_feasible_compact).inter_right (isClosed_le continuous_const l.continuous)
  obtain ⟨x, hx, hy⟩ := Active.extreme_maximizer_of_compact_superlevel l g.matching_zero hc
  exact ⟨x, hx, fun y h => by simpa only [hl] using hy y h⟩

def matchingNumber (g : SimpleEdges E V) : ℝ :=
  sSup {t | ∃ x ∈ g.matchingFeasible, total x = t}

omit [Fintype V] in
theorem matching_number_of_maximal (g : SimpleEdges E V) {x : E → ℝ}
    (hx : x ∈ g.matchingFeasible) (hmax : ∀ y ∈ g.matchingFeasible, total y ≤ total x) :
    g.matchingNumber = total x := by
  apply IsGreatest.csSup_eq
  exact ⟨⟨x, hx, rfl⟩, fun t ⟨y, hy, he⟩ => he ▸ hmax y hy⟩

variable [Nonempty V]

def maxLoad (g : SimpleEdges E V) (p : E → ℝ) : ℝ :=
  univ.sup' univ_nonempty (g.load p)

lemma load_le_maxLoad (g : SimpleEdges E V) (p : E → ℝ) (v : V) :
    g.load p v ≤ g.maxLoad p :=
  le_sup' (g.load p) (mem_univ v)

lemma exists_max_load_vertex (g : SimpleEdges E V) (p : E → ℝ) :
    ∃ v, g.maxLoad p = g.load p v := by
  obtain ⟨v, _, hv⟩ := exists_mem_eq_sup' univ_nonempty (g.load p)
  exact ⟨v, hv⟩

lemma maxLoad_pos (g : SimpleEdges E V) (p : E → ℝ) (hp : RewardGame.Probability p) :
    0 < g.maxLoad p := by
  by_contra! hn
  have h := sum_nonpos (s := univ) (f := g.load p) (fun v _ => (g.load_le_maxLoad p v).trans hn)
  rw [g.sum_load, total, hp.2] at h
  norm_num at h

omit [Fintype V] [Nonempty V] in
lemma expected_of_probability (g : SimpleEdges E V) (p : E → ℝ)
    (hp : RewardGame.Probability p) (v : V) :
    g.searchGame.expected p v = 2 * (1 - g.load p v) := by
  rw [g.load_eq_sum, ← hp.2, ← sum_sub_distrib, mul_sum]
  unfold RewardGame.expected
  apply sum_congr rfl
  intro e _
  by_cases he : v ∈ g.ends e <;> simp [searchGame, RewardGame.payoff, he, mul_comm]

theorem guarantee_of_probability (g : SimpleEdges E V) (p : E → ℝ)
    (hp : RewardGame.Probability p) :
    g.searchGame.guarantee p = 2 * (1 - g.maxLoad p) := by
  apply le_antisymm
  · obtain ⟨v, hv⟩ := g.exists_max_load_vertex p
    rw [hv, ← g.expected_of_probability p hp]
    exact g.searchGame.guarantee_le_expected p v
  · apply (g.searchGame.le_guarantee_iff _ _).mpr
    intro v
    rw [g.expected_of_probability p hp]
    linarith [g.load_le_maxLoad p v]

omit [Fintype V] [Nonempty V] in
lemma load_div (g : SimpleEdges E V) (x : E → ℝ) (d : ℝ) (v : V) :
    g.load (fun e => x e / d) v = g.load x v / d := by
  have he : (fun e => x e / d) = d⁻¹ • x := by
    funext e
    simp [div_eq_mul_inv, mul_comm]
  rw [he, load, Active.row_smul, ← load, div_eq_mul_inv, mul_comm]

lemma scaled_probability_is_matching (g : SimpleEdges E V) (p : E → ℝ)
    (hp : RewardGame.Probability p) :
    (fun e => p e / g.maxLoad p) ∈ g.matchingFeasible := by
  have hL := g.maxLoad_pos p hp
  constructor
  · intro e
    exact div_nonneg (hp.1 e) hL.le
  · intro v
    change g.load (fun e => p e / g.maxLoad p) v ≤ 1
    rw [g.load_div, div_le_one hL]
    exact g.load_le_maxLoad p v

omit [Fintype V] [Nonempty V] in
lemma normalized_matching_probability (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible) (ht : 0 < total x) :
    RewardGame.Probability (fun e => x e / total x) := by
  exact ⟨fun e => div_nonneg (hx.1 e) ht.le, by rw [← sum_div, ← total, div_self ht.ne']⟩

theorem graph_value_formula [Nonempty E] (g : SimpleEdges E V) :
    g.searchGame.value = 2 * (1 - 1 / g.matchingNumber) := by
  obtain ⟨x, hx, hmax⟩ := g.exists_extreme_maximum_matching
  have hfit := hx.1
  have hq := g.matching_number_of_maximal hfit hmax
  have h1 : 1 ≤ total x := by
    obtain ⟨e⟩ := ‹Nonempty E›
    simpa [total] using hmax _ (g.matching_single e)
  have hxpos : 0 < total x := by linarith
  rw [hq]
  apply le_antisymm
  · apply csSup_le
    · exact ⟨_, _, g.normalized_matching_probability x hfit hxpos, rfl⟩
    · rintro t ⟨p, hp, rfl⟩
      have hLp := g.maxLoad_pos p hp
      have hmx := hmax _ (g.scaled_probability_is_matching p hp)
      rw [total, ← sum_div, hp.2] at hmx
      have hi := one_div_le_one_div_of_le (one_div_pos.mpr hLp) hmx
      rw [one_div_one_div] at hi
      rw [g.guarantee_of_probability p hp]
      linarith
  · let p e := x e / total x
    have hp := g.normalized_matching_probability x hfit hxpos
    apply le_trans _ (g.searchGame.guarantee_le_value p hp)
    rw [g.guarantee_of_probability p hp]
    obtain ⟨v, hv⟩ := g.exists_max_load_vertex p
    rw [hv, g.load_div]
    have hload : g.load x v ≤ 1 := hfit.2 v
    linarith [div_le_div_of_nonneg_right hload hxpos.le]

def degree (g : SimpleEdges E V) (s : Finset E) (v : V) : ℕ :=
  (s.filter fun e => v ∈ g.ends e).card

def maxDegree (g : SimpleEdges E V) (s : Finset E) : ℕ :=
  univ.sup (g.degree s)

omit [Fintype E] [Nonempty V] in
lemma degree_le_maxDegree (g : SimpleEdges E V) (s : Finset E) (v : V) :
    g.degree s v ≤ g.maxDegree s :=
  le_sup (f := g.degree s) (mem_univ v)

omit [Fintype E] [Nonempty V] in
lemma maxDegree_pos (g : SimpleEdges E V) (s : Finset E) (hs : s.Nonempty) :
    0 < g.maxDegree s := by
  obtain ⟨e, he⟩ := hs
  have hp : (g.ends e).Nonempty := by rw [← card_pos, g.card_ends]; decide
  obtain ⟨v, hv⟩ := hp
  have hd : 0 < g.degree s v := card_pos.mpr ⟨e, mem_filter.mpr ⟨he, hv⟩⟩
  exact hd.trans_le (g.degree_le_maxDegree s v)

omit [Fintype E] [Nonempty V] in
lemma maxDegree_le_card (g : SimpleEdges E V) (s : Finset E) :
    g.maxDegree s ≤ s.card := Finset.sup_le fun _ _ => card_filter_le _ _

omit [Fintype V] [Nonempty V] in
lemma degree_eq_load_indicator (g : SimpleEdges E V) (s : Finset E) (v : V) :
    (g.degree s v : ℝ) = g.load (fun e => if e ∈ s then 1 else 0) v := by
  rw [g.load_eq_sum]
  change ((s.filter _).card : ℝ) = _
  rw [← sum_filter]
  have he : (∑ e ∈ {e ∈ univ | v ∈ g.ends e}, (if e ∈ s then (1 : ℝ) else 0)) =
      (∑ e ∈ s.filter (fun e => v ∈ g.ends e), (1 : ℝ)) := by
    rw [← sum_filter]
    congr 1
    ext e
    simp [and_comm]
  rw [he]
  simp

omit [Nonempty V] in
lemma sum_degree (g : SimpleEdges E V) (s : Finset E) :
    ∑ v, g.degree s v = 2 * s.card := by
  have h := g.sum_load (fun e => if e ∈ s then 1 else 0)
  simp_rw [← g.degree_eq_load_indicator] at h
  unfold total at h
  rw [← sum_filter, filter_univ_mem] at h
  norm_num at h
  exact_mod_cast h

theorem reciprocal_guarantee_formula (g : SimpleEdges E V) (s : Finset E) (hs : s.Nonempty) :
    g.searchGame.guarantee (g.searchGame.reciprocal s) =
      2 * (1 - (g.maxDegree s : ℝ) / s.card) := by
  have hcard : (0 : ℝ) < s.card := by exact_mod_cast card_pos.mpr hs
  have he v : g.searchGame.expected (g.searchGame.reciprocal s) v =
      2 * (1 - (g.degree s v : ℝ) / s.card) := by
    rw [RewardGame.reciprocal_expected]
    have hn : g.searchGame.normalizer s = (s.card : ℝ) / 2 := by
      simp [RewardGame.normalizer, searchGame, div_eq_mul_inv]
    rw [hn]
    have h := filter_card_add_filter_neg_card_eq_card (s := s)
      (fun e => v ∈ g.ends e)
    have hc : ((s.filter (fun e => v ∉ g.ends e)).card : ℝ) + (g.degree s v : ℝ) = s.card := by
      exact_mod_cast (show (s.filter (fun e => v ∉ g.ends e)).card + g.degree s v = s.card by
        simpa only [degree, add_comm] using h)
    have hf : (s.filter (fun a => g.searchGame.safe a v)) =
        s.filter (fun a => v ∉ g.ends a) := by
      ext a
      simp [searchGame]
    rw [hf]
    field_simp [hcard.ne']
    linarith
  apply le_antisymm
  · obtain ⟨v, _, hv⟩ := exists_mem_eq_sup univ univ_nonempty (g.degree s)
    rw [maxDegree, hv, ← he]
    exact g.searchGame.guarantee_le_expected _ _
  · apply (g.searchGame.le_guarantee_iff _ _).mpr
    intro v
    rw [he]
    have hd : (g.degree s v : ℝ) ≤ g.maxDegree s := by exact_mod_cast g.degree_le_maxDegree s v
    linarith [div_le_div_of_nonneg_right hd hcard.le]

def density (g : SimpleEdges E V) (s : Finset E) : ℝ :=
  (s.card : ℝ) / g.maxDegree s

def densityNumber (g : SimpleEdges E V) : ℝ :=
  sSup {r | ∃ s : Finset E, s.Nonempty ∧ g.density s = r}

omit [Fintype E] [Nonempty V] in
lemma density_pos (g : SimpleEdges E V) (s : Finset E) (hs : s.Nonempty) :
    0 < g.density s := by
  exact div_pos (by exact_mod_cast card_pos.mpr hs) (by exact_mod_cast g.maxDegree_pos s hs)

omit [Nonempty V] in
lemma exists_maximum_density [Nonempty E] (g : SimpleEdges E V) :
    ∃ s : Finset E, s.Nonempty ∧ g.densityNumber = g.density s ∧
      ∀ f : Finset E, f.Nonempty → g.density f ≤ g.density s := by
  let supports := (univ : Finset (Finset E)).filter Finset.Nonempty
  have hs : supports.Nonempty := by
    obtain ⟨e⟩ := ‹Nonempty E›
    exact ⟨{e}, mem_filter.mpr ⟨mem_univ _, singleton_nonempty _⟩⟩
  obtain ⟨s, hmem, hmax⟩ := exists_max_image supports g.density hs
  have hsn := (mem_filter.mp hmem).2
  have hh f (hf : f.Nonempty) : g.density f ≤ g.density s :=
    hmax f (mem_filter.mpr ⟨mem_univ _, hf⟩)
  refine ⟨s, hsn, ?_, hh⟩
  apply IsGreatest.csSup_eq
  refine ⟨⟨s, hsn, rfl⟩, ?_⟩
  rintro t ⟨f, hf, rfl⟩
  exact hh f hf

theorem reciprocal_value_formula [Nonempty E] (g : SimpleEdges E V) :
    g.searchGame.reciprocalValue = 2 * (1 - 1 / g.densityNumber) := by
  obtain ⟨s, hs, hβ, hmax⟩ := g.exists_maximum_density
  have he (f : Finset E) (hf : f.Nonempty) :
      g.searchGame.guarantee (g.searchGame.reciprocal f) = 2 * (1 - 1 / g.density f) := by
    rw [g.reciprocal_guarantee_formula f hf, density, one_div_div]
  rw [hβ]
  apply IsGreatest.csSup_eq
  constructor
  · exact ⟨s, hs, he s hs⟩
  · rintro r ⟨f, hf, rfl⟩
    rw [he f hf]
    linarith [one_div_le_one_div_of_le (g.density_pos f hf) (hmax f hf)]

end
end SimpleEdges
end ReciprocalSearch
