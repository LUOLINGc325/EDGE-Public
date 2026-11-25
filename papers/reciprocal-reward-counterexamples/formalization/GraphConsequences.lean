import GraphGuarantee
import FiveVertexGraph
import SmallSimpleGraphs

set_option autoImplicit false
open Finset
open scoped Sym2

namespace ReciprocalSearch.SimpleEdges
noncomputable section
open Classical
variable {E V : Type*} [Fintype E] [Fintype V] [Nonempty E] [Nonempty V]

omit [Fintype V] [Nonempty V] in
lemma matching_number_ge_one (g : SimpleEdges E V) : 1 ≤ g.matchingNumber := by
  obtain ⟨x, hx, hmax⟩ := g.exists_extreme_maximum_matching
  rw [g.matching_number_of_maximal hx.1 hmax]
  obtain ⟨e⟩ := ‹Nonempty E›
  simpa [total] using hmax _ (g.matching_single e)

theorem optimal_probability_iff_maximum_matching (g : SimpleEdges E V) (p : E → ℝ)
    (hp : RewardGame.Probability p) :
    g.searchGame.guarantee p = g.searchGame.value ↔
      ∃ x ∈ g.matchingFeasible, total x = g.matchingNumber ∧
        p = fun e => x e / g.matchingNumber := by
  have hν : 0 < g.matchingNumber := (by norm_num : (0 : ℝ) < 1).trans_le g.matching_number_ge_one
  constructor
  · intro he
    have hL : g.maxLoad p = 1 / g.matchingNumber := by
      rw [g.guarantee_of_probability p hp, g.graph_value_formula] at he
      linarith
    refine ⟨fun e => p e / g.maxLoad p, g.scaled_probability_is_matching p hp, ?_, ?_⟩
    · rw [total, ← sum_div, hp.2, hL, one_div_one_div]
    · funext e
      rw [hL]
      field_simp [hν.ne']
  · rintro ⟨x, hx, htotal, rfl⟩
    apply le_antisymm (g.searchGame.guarantee_le_value _ hp)
    rw [g.graph_value_formula, g.guarantee_of_probability _ hp]
    obtain ⟨v, hv⟩ := g.exists_max_load_vertex (fun e => x e / g.matchingNumber)
    rw [hv, g.load_div]
    have hload : g.load x v ≤ 1 := (g.matching_mem x).mp hx |>.2 v
    linarith [div_le_div_of_nonneg_right hload hν.le]

theorem regular_support_criterion (g : SimpleEdges E V)
    (hperfect : g.matchingNumber = (Fintype.card V : ℝ) / 2) :
    (∃ s : Finset E, s.Nonempty ∧ g.searchGame.guarantee (g.searchGame.reciprocal s) = g.searchGame.value) ↔
      ∃ (s : Finset E) (d : ℕ), 0 < d ∧ ∀ v, g.degree s v = d := by
  have hV : (0 : ℝ) < Fintype.card V := by exact_mod_cast Fintype.card_pos
  constructor
  · rintro ⟨s, hs, he⟩
    have hsc : (0 : ℝ) < s.card := by exact_mod_cast card_pos.mpr hs
    have hd := g.maxDegree_pos s hs
    have hbal : (g.maxDegree s : ℝ) / s.card = 2 / Fintype.card V := by
      rw [g.reciprocal_guarantee_formula s hs, g.graph_value_formula, hperfect, one_div_div] at he
      linarith
    have hbal' : 2 * s.card = Fintype.card V * g.maxDegree s := by
      have heq := (div_eq_div_iff hsc.ne' hV.ne').mp hbal
      exact_mod_cast (show 2 * (s.card : ℝ) = (Fintype.card V : ℝ) * g.maxDegree s by linarith)
    refine ⟨s, g.maxDegree s, hd, fun v => ?_⟩
    by_contra hn
    have hlt := sum_lt_sum
      (fun u _ => g.degree_le_maxDegree s u)
      ⟨v, mem_univ _, lt_of_le_of_ne (g.degree_le_maxDegree s v) hn⟩
    rw [g.sum_degree, sum_const, card_univ, nsmul_eq_mul, hbal'] at hlt
    exact (lt_irrefl _ hlt)
  · rintro ⟨s, d, hd, h⟩
    obtain ⟨v⟩ := ‹Nonempty V›
    have hpos : 0 < g.degree s v := by rwa [h]
    obtain ⟨e, he⟩ := card_pos.mp hpos
    have hs : s.Nonempty := ⟨e, (mem_filter.mp he).1⟩
    have hsc : (0 : ℝ) < s.card := by exact_mod_cast card_pos.mpr hs
    have hmax : g.maxDegree s = d := by
      apply le_antisymm (Finset.sup_le (fun u _ => (h u).le))
      simpa only [h v] using g.degree_le_maxDegree s v
    have hsum : (Fintype.card V) * d = 2 * s.card := by
      simpa [h, nsmul_eq_mul] using g.sum_degree s
    have hratio : (d : ℝ) / s.card = 2 / Fintype.card V := by
      apply (div_eq_div_iff hsc.ne' hV.ne').2
      exact_mod_cast ((Nat.mul_comm d (Fintype.card V)).trans hsum)
    refine ⟨s, hs, ?_⟩
    rw [g.reciprocal_guarantee_formula s hs, hmax, hratio,
      g.graph_value_formula, hperfect, one_div_div]

def ofSimpleGraph (G : SimpleGraph V) : SimpleEdges G.edgeSet V where
  ends e := univ.filter fun v => v ∈ e.val
  card_ends e := by
    obtain ⟨e, he⟩ := e
    revert he
    refine Sym2.inductionOn e fun u v h => ?_
    have huv : u ≠ v := fun he => G.not_isDiag_of_mem_edgeSet h (Sym2.mk_isDiag_iff.mpr he)
    have hs : univ.filter (fun w : V => w ∈ s(u, v)) = {u, v} := by
      ext w
      simp [Sym2.mem_iff]
    rw [hs, card_pair huv]
  ends_injective := by
    intro e f he
    apply Subtype.ext
    apply Sym2.ext
    intro v
    have h := Finset.ext_iff.mp he v
    simpa using h

theorem simple_graph_five_sixths (G : SimpleGraph V) [Fintype G.edgeSet]
    (h : G.edgeSet.Nonempty) :
    (5 / 6 : ℝ) * (ofSimpleGraph G).searchGame.value ≤ (ofSimpleGraph G).searchGame.reciprocalValue := by
  letI : Nonempty G.edgeSet := ⟨⟨h.choose, h.choose_spec⟩⟩
  exact graph_five_sixths (ofSimpleGraph G)

theorem simple_graph_at_most_four_vertices (G : SimpleGraph V) [Fintype G.edgeSet]
    (h : G.edgeSet.Nonempty) (hc : Fintype.card V ≤ 4) :
    let g := (ofSimpleGraph G).searchGame
    ∃ s : Finset G.edgeSet, s.Nonempty ∧ g.guarantee (g.reciprocal s) = g.value := by
  letI : Nonempty G.edgeSet := ⟨⟨h.choose, h.choose_spec⟩⟩
  exact small_graph_has_optimal_reciprocal (ofSimpleGraph G) hc
end
end ReciprocalSearch.SimpleEdges

namespace ReciprocalSearch.FiveVertex
noncomputable section

def graphPresentation : SimpleEdges Action Vertex where
  ends := edge
  card_ends := graph_edges_have_two_vertices
  ends_injective :=
    (by decide : ∀ (a b : Action), edge a = edge b → a = b)

lemma presentation_expected (p : Action → ℝ) (v : Vertex) :
    graphPresentation.searchGame.expected p v = expected p v := by
  classical
  unfold RewardGame.expected expected
  apply sum_congr rfl
  intro a _
  by_cases h : v ∈ edge a <;>
    simp [SimpleEdges.searchGame, graphPresentation, RewardGame.payoff, payoff, h, reward_formula]

lemma presentation_guarantee (p : Action → ℝ) :
    graphPresentation.searchGame.guarantee p = guarantee p := by
  apply le_antisymm
  · apply (le_guarantee_iff p _).mpr
    intro v
    rw [← presentation_expected]
    exact graphPresentation.searchGame.guarantee_le_expected p v
  · apply (graphPresentation.searchGame.le_guarantee_iff p _).mpr
    intro v
    rw [presentation_expected]
    exact (le_guarantee_iff p _).mp le_rfl v

lemma presentation_normalizer (s : Finset Action) :
    graphPresentation.searchGame.normalizer s = normalizer s := by
  classical
  unfold RewardGame.normalizer normalizer inverseWeight
  rw [← sum_filter, filter_univ_mem]
  simp only [SimpleEdges.searchGame, reward_formula]

lemma presentation_reciprocal (s : Finset Action) :
    graphPresentation.searchGame.reciprocal s = reciprocal s := by
  funext a
  simp only [RewardGame.reciprocal, reciprocal, inverseWeight, presentation_normalizer, reward_formula]
  split_ifs <;> simp [SimpleEdges.searchGame]

theorem connected_graph_sharpness :
    graph.Connected ∧ graphPresentation.searchGame.value = 6/5 ∧
      graphPresentation.searchGame.reciprocalValue = 1 := by
  refine ⟨graph_connected, ?_, ?_⟩
  · have h : graphPresentation.searchGame.value = gameValue := by
      unfold RewardGame.value gameValue
      simp only [presentation_guarantee]
      rfl
    rw [h, gameValue_exact]
  · have h : graphPresentation.searchGame.reciprocalValue = reciprocalValue := by
      unfold RewardGame.reciprocalValue reciprocalValue
      simp only [presentation_reciprocal, presentation_guarantee]
    rw [h, reciprocalValue_exact]

theorem bridge_removed_values :
    IsGreatest {t : ℝ | ∃ p : Action → ℝ, Probability p ∧ p 3 = 0 ∧ guarantee p = t} (6 / 5) ∧
      IsGreatest {t : ℝ | ∃ s : Finset Action, s.Nonempty ∧ 3 ∉ s ∧ guarantee (reciprocal s) = t} 1 := by
  constructor
  · have hzero : searcherStar 3 = 0 := by
      rw [searcherStar, if_pos (show (3 : Action).val = 3 by decide)]
    refine ⟨⟨searcherStar, searcherStar_probability, hzero, searcherStar_guarantee⟩, ?_⟩
    rintro _ ⟨p, hp, _, rfl⟩
    exact all_searchers_upper_bound p hp
  · refine ⟨⟨attainingSupport, attainingSupport_nonempty, by decide, reciprocal_attainment⟩, ?_⟩
    rintro _ ⟨s, _, _, rfl⟩
    exact all_reciprocal_supports_bound s
end
end ReciprocalSearch.FiveVertex

#print axioms ReciprocalSearch.SimpleEdges.optimal_probability_iff_maximum_matching
#print axioms ReciprocalSearch.SimpleEdges.regular_support_criterion
#print axioms ReciprocalSearch.SimpleEdges.simple_graph_five_sixths
#print axioms ReciprocalSearch.SimpleEdges.simple_graph_at_most_four_vertices
#print axioms ReciprocalSearch.FiveVertex.connected_graph_sharpness
#print axioms ReciprocalSearch.FiveVertex.bridge_removed_values
