import DoubleCliqueGraph
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Data.Rat.BigOperators
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic.FinCases

open scoped BigOperators

namespace GlauberAnnealing
namespace EightState

abbrev State := Fin 8

def energy : State → ℕ := ![0, 1, 2, 3, 50, 51, 52, 53]

def adjacency : State → State → Bool :=
  ![![false, true,  true,  true,  false, false, false, false],
    ![true,  false, true,  true,  false, false, false, false],
    ![true,  true,  false, false, true,  false, false, false],
    ![true,  true,  false, false, false, true,  false, false],
    ![false, false, true,  false, false, false, true,  true],
    ![false, false, false, true,  false, false, true,  true],
    ![false, false, false, false, true,  true,  false, true],
    ![false, false, false, false, true,  true,  true,  false]]

def Adj (i j : State) : Prop := adjacency i j = true

noncomputable instance : DecidableRel Adj := fun i j =>
  inferInstanceAs (Decidable (adjacency i j = true))

noncomputable def edges : Finset (State × State) :=
  {(0,1), (0,2), (0,3), (1,2), (1,3), (4,6), (4,7), (5,6), (5,7), (6,7), (2,4), (3,5)}

theorem actual_edge_list (i j : State) :
    Adj i j ↔ (i,j) ∈ edges ∨ (j,i) ∈ edges := by
  fin_cases i <;> fin_cases j <;> decide

noncomputable def graph : SimpleGraph State where
  Adj := Adj
  symm := by intro i j; fin_cases i <;> fin_cases j <;> decide
  loopless := by intro i; fin_cases i <;> decide

theorem graph_connected : graph.Connected := by
  have h10 : graph.Reachable 1 0 := (show graph.Adj 1 0 by change Adj 1 0; decide).reachable
  have h20 : graph.Reachable 2 0 := (show graph.Adj 2 0 by change Adj 2 0; decide).reachable
  have h30 : graph.Reachable 3 0 := (show graph.Adj 3 0 by change Adj 3 0; decide).reachable
  have h40 : graph.Reachable 4 0 := (show graph.Adj 4 2 by change Adj 4 2; decide).reachable.trans h20
  have h50 : graph.Reachable 5 0 := (show graph.Adj 5 3 by change Adj 5 3; decide).reachable.trans h30
  have h60 : graph.Reachable 6 0 := (show graph.Adj 6 4 by change Adj 6 4; decide).reachable.trans h40
  have h70 : graph.Reachable 7 0 := (show graph.Adj 7 4 by change Adj 7 4; decide).reachable.trans h40
  have h0 (i : State) : graph.Reachable i 0 := by
    fin_cases i
    · exact SimpleGraph.Reachable.refl 0
    · exact h10
    · exact h20
    · exact h30
    · exact h40
    · exact h50
    · exact h60
    · exact h70
  exact ⟨fun i j => (h0 i).trans (h0 j).symm⟩

theorem graph_regular (j : State) : (neighbors graph j).card = 3 := by
  classical
  have h : neighbors graph j = Finset.univ.filter (Adj j) := by
    ext i
    simp [graph]
  rw [h]
  fin_cases j <;> decide

noncomputable def model : RegularGraph State where
  graph := graph
  degree := 3
  degree_pos := by decide
  card_neighbors := graph_regular

noncomputable def realEnergy (i : State) : ℝ := energy i

theorem energy_injective : Function.Injective realEnergy := by
  intro i j hij
  unfold realEnergy at hij
  have h : energy i = energy j := by exact_mod_cast hij
  revert h
  fin_cases i <;> fin_cases j <;> decide

noncomputable def ratWeight (q : ℚ) (i : State) : ℚ := (q ^ energy i)⁻¹

noncomputable def ratGibbs (q : ℚ) (i : State) : ℚ :=
  ratWeight q i / ∑ j, ratWeight q j

noncomputable def ratEdge (q : ℚ) (i j : State) : ℚ :=
  if Adj i j then q ^ energy j / (3 * (q ^ energy i + q ^ energy j)) else 0

noncomputable def ratExit (q : ℚ) (j : State) : ℚ := ∑ i, ratEdge q i j

noncomputable def ratTransition (q : ℚ) (i j : State) : ℚ :=
  if i = j then 1 - ratExit q j else ratEdge q i j

noncomputable def ratUpdate (q : ℚ) (p : State → ℚ) (i : State) : ℚ :=
  ∑ j, ratTransition q i j * p j

noncomputable def ratActivity (q : ℚ) (p : State → ℚ) : ℚ := ∑ i, ratExit q i * p i

noncomputable def realVector (p : State → ℚ) : State → ℝ := fun i => p i

theorem exp_energy (q : ℝ) (hq : 0 < q) (i : State) :
    Real.exp (Real.log q * realEnergy i) = q ^ energy i := by
  unfold realEnergy
  rw [mul_comm, Real.exp_nat_mul, Real.exp_log hq]

theorem weight_eq_rat (q : ℚ) (hq : 0 < q) (i : State) :
    RegularGraph.weight realEnergy (Real.log (q : ℝ)) i = (ratWeight q i : ℝ) := by
  have hr : (0 : ℝ) < q := by exact_mod_cast hq
  simp only [RegularGraph.weight, neg_mul, Real.exp_neg, exp_energy _ hr, ratWeight,
    Rat.cast_inv, Rat.cast_pow]

theorem gibbs_eq_rat (q : ℚ) (hq : 0 < q) :
    RegularGraph.gibbs realEnergy (Real.log (q : ℝ)) = realVector (ratGibbs q) := by
  funext i
  simp only [RegularGraph.gibbs, weight_eq_rat q hq, realVector, ratGibbs, Rat.cast_div, Rat.cast_sum]

theorem edge_eq_rat (q : ℚ) (hq : 0 < q) (i j : State) :
    model.edgeRate realEnergy (Real.log (q : ℝ)) i j = (ratEdge q i j : ℝ) := by
  have hr : (0 : ℝ) < q := by exact_mod_cast hq
  have hj : (q : ℝ) ^ energy j ≠ 0 := (pow_pos hr _).ne'
  have hs : (q : ℝ) ^ energy i + (q : ℝ) ^ energy j ≠ 0 :=
    (add_pos (pow_pos hr _) (pow_pos hr _)).ne'
  by_cases h : Adj i j
  · rw [model.edgeRate_of_adj realEnergy (Real.log (q : ℝ)) (show model.graph.Adj i j from h)]
    simp only [ratEdge, if_pos h, acceptance, model, Nat.cast_ofNat, mul_sub, Real.exp_sub,
      exp_energy _ hr, Rat.cast_div, Rat.cast_mul, Rat.cast_add, Rat.cast_pow]
    field_simp
    ring
  · rw [model.edgeRate_of_not_adj realEnergy (Real.log (q : ℝ))
      (show ¬model.graph.Adj i j from h)]
    simp [ratEdge, h]

theorem exit_eq_rat (q : ℚ) (hq : 0 < q) (i : State) :
    model.exitRate realEnergy (Real.log (q : ℝ)) i = (ratExit q i : ℝ) := by
  simp only [RegularGraph.exitRate, edge_eq_rat q hq, ratExit, Rat.cast_sum]

theorem transition_eq_rat (q : ℚ) (hq : 0 < q) (i j : State) :
    model.transition realEnergy (Real.log (q : ℝ)) i j = (ratTransition q i j : ℝ) := by
  by_cases h : i = j
  · subst i
    simp [RegularGraph.transition, model.edgeRate_self, ratTransition, exit_eq_rat q hq]
  · rw [model.transition_of_ne realEnergy _ h, edge_eq_rat q hq]
    simp [ratTransition, h]

theorem update_eq_rat (q : ℚ) (hq : 0 < q) (p : State → ℚ) :
    model.update realEnergy (Real.log (q : ℝ)) (realVector p) = realVector (ratUpdate q p) := by
  funext i
  simp only [RegularGraph.update, transition_eq_rat q hq, realVector, ratUpdate,
    Rat.cast_sum, Rat.cast_mul]

theorem activity_eq_rat (q : ℚ) (hq : 0 < q) (p : State → ℚ) :
    model.activity realEnergy (Real.log (q : ℝ)) (realVector p) = (ratActivity q p : ℝ) := by
  simp only [RegularGraph.activity, exit_eq_rat q hq, realVector, ratActivity, Rat.cast_sum, Rat.cast_mul]

end EightState
end GlauberAnnealing
