import GlauberRobust
import GlauberPhysical
import Mathlib.Combinatorics.SimpleGraph.DegreeSum

open Filter Topology
open scoped BigOperators

namespace GlauberAnnealing

variable {V : Type*} [Fintype V] {M : RegularGraph V}

namespace BridgeCut

theorem degree_odd (C : BridgeCut M) : Odd M.degree := by
  classical
  let S : Set V := {v | C.low v}
  let u : S := ⟨C.source, C.low_source⟩
  let H := M.graph.induce S
  have hneighbors (v : S) :
      (H.neighborFinset v).map (Function.Embedding.subtype S) =
        if v = u then (neighbors M.graph (v : V)).erase C.target
        else neighbors M.graph (v : V) := by
    change ((M.graph.induce S).neighborFinset v).map _ = _
    rw [SimpleGraph.map_neighborFinset_induce]
    ext j
    simp only [Finset.mem_inter, SimpleGraph.mem_neighborFinset, Set.mem_toFinset, S,
      Set.mem_setOf_eq]
    by_cases hv : v = u
    · subst v
      rw [if_pos rfl, Finset.mem_erase, mem_neighbors]
      change (M.graph.Adj C.source j ∧ C.low j) ↔ (j ≠ C.target ∧ M.graph.Adj C.source j)
      constructor
      · rintro ⟨ha, hl⟩
        exact ⟨fun ht => C.high_target (ht ▸ hl), ha⟩
      · rintro ⟨ht, ha⟩
        by_cases hl : C.low j
        · exact ⟨ha, hl⟩
        · exact (ht (C.unique_crossing C.low_source hl ha).2).elim
    · rw [if_neg hv, mem_neighbors]
      refine ⟨And.left, fun ha => ⟨ha, ?_⟩⟩
      by_cases hl : C.low j
      · exact hl
      · exact (hv (Subtype.ext (C.unique_crossing v.property hl ha).1)).elim
  have hdegree (v : S) : H.degree v + (if v = u then 1 else 0) = M.degree := by
    rw [← SimpleGraph.card_neighborFinset_eq_degree,
      ← Finset.card_map (f := Function.Embedding.subtype S), hneighbors v]
    by_cases hv : v = u
    · subst v
      rw [if_pos rfl, if_pos rfl, Finset.card_erase_add_one C.endpoint_mem_neighbors,
        M.card_neighbors]
    · rw [if_neg hv, if_neg hv, add_zero, M.card_neighbors]
  have hh : (∑ v : S, (H.degree v + if v = u then 1 else 0)) = ∑ _ : S, M.degree :=
    Finset.sum_congr rfl (fun v _ => hdegree v)
  rw [Finset.sum_add_distrib, H.sum_degrees_eq_twice_card_edges] at hh
  simp only [Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true,
    Finset.sum_const, Finset.card_univ, nsmul_eq_mul] at hh
  have hod : Odd ((Fintype.card S) * M.degree) := ⟨H.edgeFinset.card, hh.symm⟩
  exact (Nat.odd_mul.mp hod).2

end BridgeCut

namespace RegularGraph

theorem transition_pos_iff [DecidableEq V] (M : RegularGraph V) (E : V → ℝ) (β : ℝ)
    (i j : V) : 0 < M.transition E β i j ↔ i = j ∨ M.graph.Adj i j := by
  by_cases h : i = j
  · subst j
    simp [M.transition_diagonal_pos E β i]
  simp only [M.transition_of_ne E β h, h, false_or]
  exact ⟨fun hp => by_contra fun ha => (ne_of_gt hp) (M.edgeRate_of_not_adj E β ha),
    M.edgeRate_pos E β⟩

end RegularGraph

namespace TenState

open GlauberCounterexample

noncomputable def model : RegularGraph State where
  graph := graph
  degree := 3
  degree_pos := by decide
  card_neighbors j := by
    classical
    have h : neighbors graph j = graph.neighborFinset j := by
      ext i
      simp
    rw [h, graph_three_regular]

noncomputable def realEnergy (i : State) : ℝ := energy i

theorem gibbs_eq (β : ℝ) : RegularGraph.gibbs realEnergy β = physicalGibbs β :=
  rfl

theorem edge_eq (β : ℝ) (i j : State) :
    model.edgeRate realEnergy β i j = physicalEdgeRate β i j := by
  by_cases h : Adj i j
  · have hg : model.graph.Adj i j := h
    rw [model.edgeRate_of_adj realEnergy β hg]
    simp only [physicalEdgeRate, if_pos h, acceptance, model, Nat.cast_ofNat, realEnergy]
    rw [div_div, mul_comm (1 + _ : ℝ) 3]
  · have hg : ¬model.graph.Adj i j := h
    rw [model.edgeRate_of_not_adj realEnergy β hg, physicalEdgeRate, if_neg h]

theorem exit_eq (β : ℝ) (j : State) :
    model.exitRate realEnergy β j = physicalExit β j := by
  unfold RegularGraph.exitRate physicalExit
  simp_rw [edge_eq]

theorem transition_eq (β : ℝ) (i j : State) :
    model.transition realEnergy β i j = physicalTransition β i j := by
  by_cases h : i = j
  · subst j
    simp [RegularGraph.transition, model.edgeRate_self, physicalTransition, exit_eq]
  rw [model.transition_of_ne realEnergy β h, edge_eq, physicalTransition, if_neg h]

theorem update_eq (β : ℝ) (p : State → ℝ) :
    model.update realEnergy β p = physicalUpdate β p := by
  funext i
  unfold RegularGraph.update physicalUpdate
  simp_rw [transition_eq]

theorem activity_eq (β : ℝ) (p : State → ℝ) :
    model.activity realEnergy β p = physicalActivity β p := by
  unfold RegularGraph.activity physicalActivity
  simp_rw [exit_eq]

theorem second_activity_exact : physicalActivity β2 physicalP1 =
    (5902774591859117272939967982483087445482386027746372473407417552821 : ℝ) /
      11727449656979417367643962007570080930504786847474663574588274496884 := by
  have h : activity q2 p1 =
      (5902774591859117272939967982483087445482386027746372473407417552821 : ℚ) /
        11727449656979417367643962007570080930504786847474663574588274496884 := by
    norm_num [activity, exits_2, p1_values, Fin.sum_univ_succ]
  rw [physical_p1_eq]
  change physicalActivity (Real.log (q2 : ℝ)) (realVector p1) = _
  rw [physical_activity_eq q2 (by norm_num [q2])]
  simpa only [Rat.cast_div, Rat.cast_ofNat] using congrArg (fun r : ℚ => (r : ℝ)) h

noncomputable def meanEnergy (p : State → ℝ) : ℝ := ∑ i, realEnergy i * p i

theorem mean_energy_strict_descent :
    meanEnergy physicalP2 < meanEnergy physicalP1 ∧ meanEnergy physicalP1 < meanEnergy physicalP0 := by
  let μ : (State → ℚ) → ℚ := fun p => ∑ i, (energy i : ℚ) * p i
  have h01 : μ p1 < μ p0 := by
    simp only [μ, p0_values, p1_values, energy, Fin.sum_univ_succ, Fin.sum_univ_zero,
      Matrix.cons_val_zero, Matrix.cons_val_succ]
    norm_num
  have h12 : μ p2 < μ p1 := by
    simp only [μ, p2, update, transition_2, p1_values, energy, Fin.sum_univ_succ,
      Fin.sum_univ_zero, Matrix.cons_val_zero, Matrix.cons_val_succ]
    norm_num
  have hcast (p : State → ℚ) : meanEnergy (realVector p) = (μ p : ℝ) := by
    simp [meanEnergy, realEnergy, realVector, μ]
  rw [physical_p0_eq, physical_p1_eq, physical_p2_eq, hcast, hcast, hcast]
  exact ⟨Rat.cast_lt.mpr h12, Rat.cast_lt.mpr h01⟩

theorem specified_bridge : model.graph.IsBridge s((4 : State), (9 : State)) := by
  classical
  let H := model.graph \ SimpleGraph.fromEdgeSet {s((4 : State), (9 : State))}
  have ha : model.graph.Adj 4 9 := by change Adj 4 9; decide
  refine SimpleGraph.isBridge_iff.mpr ⟨ha, ?_⟩
  intro hreach
  have hsep {i j : State} (h : H.Adj i j) : i.val < 5 ↔ j.val < 5 := by
    obtain ⟨hij, hn⟩ := (SimpleGraph.sdiff_adj _ _ _ _).mp h
    have hn' : s(i, j) ≠ s((4 : State), (9 : State)) := by
      intro hEq
      exact hn ((SimpleGraph.fromEdgeSet_adj _).mpr ⟨by simp [hEq], hij.ne⟩)
    change Adj i j at hij
    have hp : ¬(i = 4 ∧ j = 9 ∨ i = 9 ∧ j = 4) := fun hEq => hn' (Sym2.eq_iff.mpr hEq)
    revert hij hp
    fin_cases i <;> fin_cases j <;> decide
  have hpath {i j : State} (w : H.Walk i j) : i.val < 5 ↔ j.val < 5 := by
    induction w with
    | nil => rfl
    | cons h _ ih => exact (hsep h).trans ih
  obtain ⟨w⟩ := hreach
  exact (by decide : ¬(9 : State).val < 5) ((hpath w).mp (by decide))

theorem exact_ten_state_violation : (realEnergy, β0, β1, β2) ∈ model.violationRegion := by
  have h₁ : (1 / 2 : ℝ) < physicalActivity β2 physicalP1 :=
    lt_trans (by norm_num) physical_second_activity_margin
  have h₂ : (1 / 2 : ℝ) < (physicalActivity β1 physicalP0 +
      physicalActivity β2 physicalP1) / 2 :=
    lt_trans (by norm_num) physical_average_activity_margin
  exact ⟨inverse_temperature_order,
    by simpa [RegularGraph.secondActivity, update_eq, gibbs_eq, activity_eq, physicalP0,
      physicalP1] using h₁,
    by simpa [RegularGraph.averageActivity, RegularGraph.firstActivity, RegularGraph.secondActivity,
      update_eq, gibbs_eq, activity_eq, physicalP0, physicalP1] using h₂⟩

theorem ten_state_robust :
    ∀ᶠ p in 𝓝 ((realEnergy, β0, β1, β2) : (State → ℝ) × ℝ × ℝ × ℝ),
      p ∈ model.violationRegion :=
  model.isOpen_violationRegion.mem_nhds exact_ten_state_violation

end TenState
end GlauberAnnealing
