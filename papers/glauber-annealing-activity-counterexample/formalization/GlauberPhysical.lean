import GlauberCounterexample
import Mathlib.Combinatorics.SimpleGraph.Path
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Data.Rat.BigOperators
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

/-!
# Identification with the finite-temperature physical Glauber model

The rational certificate is connected here to the actual exponential transition
rule and normalized Gibbs distribution at β = log q.  This file also checks the
graph's connectivity and the strictly decreasing physical temperatures.
-/

set_option autoImplicit false
set_option maxHeartbeats 2000000

open Finset

namespace GlauberCounterexample

noncomputable def graph : SimpleGraph State where
  Adj := Adj
  symm := fun _ _ h => (adjacency_symmetric _ _).mp h
  loopless := adjacency_irreflexive

noncomputable instance : DecidableRel graph.Adj := adjacencyDecidable

theorem graph_three_regular (j : State) : (graph.neighborFinset j).card = 3 := by
  have heq : graph.neighborFinset j = univ.filter (fun i => Adj i j) := by
    ext i
    simp only [SimpleGraph.mem_neighborFinset, Finset.mem_filter, Finset.mem_univ, true_and]
    exact adjacency_symmetric j i
  rw [heq]
  exact three_regular j

theorem graph_connected : graph.Connected := by
  apply (SimpleGraph.connected_iff_exists_forall_reachable graph).mpr
  refine ⟨0, ?_⟩
  have h02 : graph.Reachable 0 2 := SimpleGraph.Adj.reachable (by decide)
  have h03 : graph.Reachable 0 3 := SimpleGraph.Adj.reachable (by decide)
  have h04 : graph.Reachable 0 4 := SimpleGraph.Adj.reachable (by decide)
  have h21 : graph.Reachable 2 1 := SimpleGraph.Adj.reachable (by decide)
  have h49 : graph.Reachable 4 9 := SimpleGraph.Adj.reachable (by decide)
  have h95 : graph.Reachable 9 5 := SimpleGraph.Adj.reachable (by decide)
  have h96 : graph.Reachable 9 6 := SimpleGraph.Adj.reachable (by decide)
  have h57 : graph.Reachable 5 7 := SimpleGraph.Adj.reachable (by decide)
  have h58 : graph.Reachable 5 8 := SimpleGraph.Adj.reachable (by decide)
  intro i
  fin_cases i
  · exact SimpleGraph.Reachable.refl _
  · exact h02.trans h21
  · exact h02
  · exact h03
  · exact h04
  · exact (h04.trans h49).trans h95
  · exact (h04.trans h49).trans h96
  · exact ((h04.trans h49).trans h95).trans h57
  · exact ((h04.trans h49).trans h95).trans h58
  · exact h04.trans h49

noncomputable def physicalWeight (β : ℝ) (i : State) : ℝ :=
  Real.exp (-β * (energy i : ℝ))

noncomputable def physicalGibbs (β : ℝ) (i : State) : ℝ :=
  physicalWeight β i / ∑ j : State, physicalWeight β j

noncomputable def physicalEdgeRate (β : ℝ) (i j : State) : ℝ :=
  if Adj i j then 1 / (3 * (1 + Real.exp (β * ((energy i : ℝ) - energy j)))) else 0

noncomputable def physicalExit (β : ℝ) (j : State) : ℝ :=
  ∑ i : State, physicalEdgeRate β i j

noncomputable def physicalTransition (β : ℝ) (i j : State) : ℝ :=
  if i = j then 1 - physicalExit β j else physicalEdgeRate β i j

noncomputable def physicalUpdate (β : ℝ) (p : State → ℝ) (i : State) : ℝ :=
  ∑ j : State, physicalTransition β i j * p j

noncomputable def physicalActivity (β : ℝ) (p : State → ℝ) : ℝ :=
  ∑ j : State, physicalExit β j * p j

noncomputable def realVector (p : State → ℚ) : State → ℝ := fun i => (p i : ℝ)

theorem exp_energy (q : ℝ) (hq : 0 < q) (i : State) :
    Real.exp (Real.log q * (energy i : ℝ)) = q ^ energy i := by
  rw [mul_comm, Real.exp_nat_mul, Real.exp_log hq]

theorem physical_weight_eq (q : ℚ) (hq : 0 < q) (i : State) :
    physicalWeight (Real.log (q : ℝ)) i = (weight q i : ℝ) := by
  have hqR : (0 : ℝ) < q := by exact_mod_cast hq
  simp only [physicalWeight, neg_mul, Real.exp_neg, exp_energy _ hqR, weight,
    Rat.cast_inv, Rat.cast_pow]

theorem physical_gibbs_eq (q : ℚ) (hq : 0 < q) :
    physicalGibbs (Real.log (q : ℝ)) = realVector (gibbs q) := by
  funext i
  simp only [physicalGibbs, physical_weight_eq q hq, realVector, gibbs,
    Rat.cast_div, Rat.cast_sum]

theorem physical_edge_eq (q : ℚ) (hq : 0 < q) (i j : State) :
    physicalEdgeRate (Real.log (q : ℝ)) i j = (edgeRate q i j : ℝ) := by
  have hqR : (0 : ℝ) < q := by exact_mod_cast hq
  have hj : (q : ℝ) ^ energy j ≠ 0 := (pow_pos hqR _).ne'
  have hs : (q : ℝ) ^ energy i + (q : ℝ) ^ energy j ≠ 0 :=
    (add_pos (pow_pos hqR _) (pow_pos hqR _)).ne'
  by_cases h : Adj i j
  · simp only [physicalEdgeRate, edgeRate, if_pos h, mul_sub, Real.exp_sub,
      exp_energy _ hqR, Rat.cast_div, Rat.cast_mul, Rat.cast_ofNat, Rat.cast_add,
      Rat.cast_pow]
    field_simp
    ring
  · simp [physicalEdgeRate, edgeRate, h]

theorem physical_exit_eq (q : ℚ) (hq : 0 < q) (j : State) :
    physicalExit (Real.log (q : ℝ)) j = (exitRate q j : ℝ) := by
  simp only [physicalExit, physical_edge_eq q hq, exitRate, Rat.cast_sum]

theorem physical_transition_eq (q : ℚ) (hq : 0 < q) (i j : State) :
    physicalTransition (Real.log (q : ℝ)) i j = (transition q i j : ℝ) := by
  by_cases h : i = j
  · simp [physicalTransition, transition, h, physical_exit_eq q hq]
  · simp [physicalTransition, transition, h, physical_edge_eq q hq]

theorem physical_update_eq (q : ℚ) (hq : 0 < q) (p : State → ℚ) :
    physicalUpdate (Real.log (q : ℝ)) (realVector p) = realVector (update q p) := by
  funext i
  simp only [physicalUpdate, physical_transition_eq q hq, realVector, update,
    Rat.cast_sum, Rat.cast_mul]

theorem physical_activity_eq (q : ℚ) (hq : 0 < q) (p : State → ℚ) :
    physicalActivity (Real.log (q : ℝ)) (realVector p) = (activity q p : ℝ) := by
  simp only [physicalActivity, physical_exit_eq q hq, realVector, activity,
    Rat.cast_sum, Rat.cast_mul]

noncomputable def β0 : ℝ := Real.log (q0 : ℝ)
noncomputable def β1 : ℝ := Real.log (q1 : ℝ)
noncomputable def β2 : ℝ := Real.log (q2 : ℝ)

theorem inverse_temperature_order : 0 < β0 ∧ β0 < β1 ∧ β1 < β2 := by
  have h0 : (1 : ℝ) < q0 := by exact_mod_cast parameter_order.1
  have h01 : (q0 : ℝ) < q1 := by exact_mod_cast parameter_order.2.1
  have h12 : (q1 : ℝ) < q2 := by exact_mod_cast parameter_order.2.2
  exact ⟨Real.log_pos h0, Real.log_lt_log (lt_trans zero_lt_one h0) h01,
    Real.log_lt_log ((lt_trans zero_lt_one h0).trans h01) h12⟩

theorem physical_temperature_order :
    0 < 1 / β2 ∧ 1 / β2 < 1 / β1 ∧ 1 / β1 < 1 / β0 := by
  obtain ⟨h0, h01, h12⟩ := inverse_temperature_order
  exact ⟨one_div_pos.mpr ((h0.trans h01).trans h12),
    one_div_lt_one_div_of_lt (h0.trans h01) h12,
    one_div_lt_one_div_of_lt h0 h01⟩

noncomputable def physicalP0 : State → ℝ := physicalGibbs β0
noncomputable def physicalP1 : State → ℝ := physicalUpdate β1 physicalP0
noncomputable def physicalP2 : State → ℝ := physicalUpdate β2 physicalP1

theorem physical_p0_eq : physicalP0 = realVector p0 :=
  physical_gibbs_eq q0 (by norm_num [q0])

theorem physical_p1_eq : physicalP1 = realVector p1 := by
  rw [physicalP1, physical_p0_eq]
  exact physical_update_eq q1 (by norm_num [q1]) p0

theorem physical_p2_eq : physicalP2 = realVector p2 := by
  rw [physicalP2, physical_p1_eq]
  exact physical_update_eq q2 (by norm_num [q2]) p1

def RealProbabilityVector (p : State → ℝ) : Prop := (∀ i, 0 < p i) ∧ ∑ i, p i = 1

theorem real_probability_of_rational {p : State → ℚ} (hp : ProbabilityVector p) :
    RealProbabilityVector (realVector p) := by
  constructor
  · intro i
    exact Rat.cast_pos.mpr (hp.1 i)
  · simpa only [realVector, ← Rat.cast_sum, Rat.cast_one] using congrArg (fun x : ℚ => (x : ℝ)) hp.2

theorem physical_run_probabilities :
    RealProbabilityVector physicalP0 ∧ RealProbabilityVector physicalP1 ∧
      RealProbabilityVector physicalP2 := by
  rw [physical_p0_eq, physical_p1_eq, physical_p2_eq]
  exact ⟨real_probability_of_rational initial_probability,
    real_probability_of_rational first_updated_probability,
    real_probability_of_rational second_updated_probability⟩

def RealStochastic (P : State → State → ℝ) : Prop :=
  (∀ i j, 0 ≤ P i j) ∧ (∀ j, ∑ i, P i j = 1)

theorem physical_stochastic_of_rational (q : ℚ) (hq : 0 < q)
    (hP : Stochastic (transition q)) :
    RealStochastic (physicalTransition (Real.log (q : ℝ))) := by
  constructor
  · intro i j
    rw [physical_transition_eq q hq]
    exact_mod_cast hP.1 i j
  · intro j
    simp only [physical_transition_eq q hq, ← Rat.cast_sum]
    exact_mod_cast hP.2 j

theorem physical_run_stochastic :
    RealStochastic (physicalTransition β1) ∧ RealStochastic (physicalTransition β2) :=
  ⟨physical_stochastic_of_rational q1 (by norm_num [q1]) first_transition_stochastic,
    physical_stochastic_of_rational q2 (by norm_num [q2]) second_transition_stochastic⟩

theorem physical_exit_is_change_probability (β : ℝ) (j : State) :
    physicalExit β j = 1 - physicalTransition β j j := by
  simp [physicalTransition]

theorem physical_second_activity_margin :
    (1 / 2 + 1 / 400 : ℝ) < physicalActivity β2 physicalP1 := by
  rw [physical_p1_eq]
  change (1 / 2 + 1 / 400 : ℝ) < physicalActivity (Real.log (q2 : ℝ)) (realVector p1)
  rw [physical_activity_eq q2 (by norm_num [q2])]
  have h : (((1 / 2 + 1 / 400 : ℚ) : ℝ)) < (activity q2 p1 : ℝ) :=
    Rat.cast_lt.mpr second_activity_margin
  simpa only [Rat.cast_add, Rat.cast_div, Rat.cast_one, Rat.cast_ofNat] using h

theorem physical_average_activity_margin :
    (1 / 2 + 3 / 3200 : ℝ) <
      (physicalActivity β1 physicalP0 + physicalActivity β2 physicalP1) / 2 := by
  rw [physical_p0_eq, physical_p1_eq]
  change (1 / 2 + 3 / 3200 : ℝ) <
    (physicalActivity (Real.log (q1 : ℝ)) (realVector p0) +
      physicalActivity (Real.log (q2 : ℝ)) (realVector p1)) / 2
  rw [physical_activity_eq q1 (by norm_num [q1]), physical_activity_eq q2 (by norm_num [q2])]
  have h : (((1 / 2 + 3 / 3200 : ℚ) : ℝ)) <
      (((activity q1 p0 + activity q2 p1) / 2 : ℚ) : ℝ) :=
    Rat.cast_lt.mpr average_activity_margin
  simpa only [Rat.cast_add, Rat.cast_div, Rat.cast_one, Rat.cast_ofNat] using h

/-- The finite graph, finite positive temperatures, genuine Gibbs start,
probability-preserving updates and both strict violations in one declaration. -/
theorem finite_physical_counterexample :
    graph.Connected ∧ (∀ j, (graph.neighborFinset j).card = 3) ∧
    (0 < β0 ∧ β0 < β1 ∧ β1 < β2) ∧
    (0 < 1 / β2 ∧ 1 / β2 < 1 / β1 ∧ 1 / β1 < 1 / β0) ∧
    (RealProbabilityVector physicalP0 ∧ RealProbabilityVector physicalP1 ∧
      RealProbabilityVector physicalP2) ∧
    (RealStochastic (physicalTransition β1) ∧ RealStochastic (physicalTransition β2)) ∧
    (1 / 2 + 1 / 400 : ℝ) < physicalActivity β2 physicalP1 ∧
    (1 / 2 + 3 / 3200 : ℝ) <
      (physicalActivity β1 physicalP0 + physicalActivity β2 physicalP1) / 2 :=
  ⟨graph_connected, graph_three_regular, inverse_temperature_order, physical_temperature_order,
    physical_run_probabilities, physical_run_stochastic,
    physical_second_activity_margin, physical_average_activity_margin⟩

#print axioms GlauberCounterexample.finite_physical_counterexample
#print axioms GlauberCounterexample.physical_temperature_order

end GlauberCounterexample
