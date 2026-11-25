import Mathlib.Data.Rat.Cast.Order
import Mathlib.Data.Fin.VecNotation
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FinCases

/-!
# A finite Glauber annealing counterexample

The certificate is computed from the graph, its integer energies, the exact
Gibbs initial distribution, and the two column-stochastic updates.  No numeric
activity value is introduced as an assumption or a disconnected constant.
-/

set_option autoImplicit false
set_option maxRecDepth 100000
set_option maxHeartbeats 20000000

open Finset

namespace GlauberCounterexample

abbrev State := Fin 10

def energy : State → ℕ := ![0, 0, 0, 0, 1, 11, 11, 11, 11, 10]

noncomputable def edges : List (State × State) :=
  [(0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (0, 4), (1, 4),
   (5, 7), (5, 8), (6, 7), (6, 8), (7, 8), (5, 9), (6, 9), (4, 9)]

def adjacency : State → State → Bool := ![
  ![false, false, true, true, true, false, false, false, false, false],
  ![false, false, true, true, true, false, false, false, false, false],
  ![true, true, false, true, false, false, false, false, false, false],
  ![true, true, true, false, false, false, false, false, false, false],
  ![true, true, false, false, false, false, false, false, false, true],
  ![false, false, false, false, false, false, false, true, true, true],
  ![false, false, false, false, false, false, false, true, true, true],
  ![false, false, false, false, false, true, true, false, true, false],
  ![false, false, false, false, false, true, true, true, false, false],
  ![false, false, false, false, true, true, true, false, false, false]]

def Adj (i j : State) : Prop := adjacency i j = true

noncomputable instance adjacencyDecidable : DecidableRel Adj := fun i j =>
  inferInstanceAs (Decidable (adjacency i j = true))

theorem adjacency_symmetric (i j : State) : Adj i j ↔ Adj j i := by
  fin_cases i <;> fin_cases j <;> decide

theorem adjacency_irreflexive : ∀ i : State, ¬Adj i i := by
  intro i
  fin_cases i <;> decide

theorem three_regular : ∀ j : State, (univ.filter (fun i => Adj i j)).card = 3 := by
  intro j
  fin_cases j <;> norm_num [Adj, adjacency, Fin.card_filter_univ_succ]

theorem fifteen_edges : edges.length = 15 := rfl

theorem edges_distinct : edges.Nodup := by decide

theorem adjacency_eq_edge_list (i j : State) :
    Adj i j ↔ (i, j) ∈ edges ∨ (j, i) ∈ edges := by
  fin_cases i <;> fin_cases j <;> decide

noncomputable def weight (q : ℚ) (i : State) : ℚ := (q ^ energy i)⁻¹

noncomputable def gibbs (q : ℚ) (i : State) : ℚ := weight q i / ∑ j : State, weight q j

/-- Off-diagonal edge transition, with the source state in the second index. -/
noncomputable def edgeRate (q : ℚ) (i j : State) : ℚ :=
  if Adj i j then q ^ energy j / (3 * (q ^ energy i + q ^ energy j)) else 0

noncomputable def exitRate (q : ℚ) (j : State) : ℚ := ∑ i : State, edgeRate q i j

noncomputable def transition (q : ℚ) (i j : State) : ℚ :=
  if i = j then 1 - exitRate q j else edgeRate q i j

noncomputable def update (q : ℚ) (p : State → ℚ) (i : State) : ℚ :=
  ∑ j : State, transition q i j * p j

noncomputable def activity (q : ℚ) (p : State → ℚ) : ℚ :=
  ∑ j : State, exitRate q j * p j

noncomputable def q0 : ℚ := 10001 / 10000
noncomputable def q1 : ℚ := 5 / 4
noncomputable def q2 : ℚ := 100

noncomputable def p0 : State → ℚ := gibbs q0
noncomputable def p1 : State → ℚ := update q1 p0
noncomputable def p2 : State → ℚ := update q2 p1

def ProbabilityVector (p : State → ℚ) : Prop := (∀ i, 0 < p i) ∧ ∑ i, p i = 1

def Stochastic (P : State → State → ℚ) : Prop :=
  (∀ i j, 0 ≤ P i j) ∧ (∀ j, ∑ i, P i j = 1)

theorem parameter_order : 1 < q0 ∧ q0 < q1 ∧ q1 < q2 := by norm_num [q0, q1, q2]

theorem edge_rates_1 : edgeRate q1 = ![
  ![0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (5 / 27 : ℚ), 0, 0, 0, 0, 0],
  ![0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (5 / 27 : ℚ), 0, 0, 0, 0, 0],
  ![(1 / 6 : ℚ), (1 / 6 : ℚ), 0, (1 / 6 : ℚ), 0, 0, 0, 0, 0, 0],
  ![(1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 6 : ℚ), 0, 0, 0, 0, 0, 0, 0],
  ![(4 / 27 : ℚ), (4 / 27 : ℚ), 0, 0, 0, 0, 0, 0, 0, (1953125 / 6645807 : ℚ)],
  ![0, 0, 0, 0, 0, 0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (4 / 27 : ℚ)],
  ![0, 0, 0, 0, 0, 0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (4 / 27 : ℚ)],
  ![0, 0, 0, 0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), 0, (1 / 6 : ℚ), 0],
  ![0, 0, 0, 0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 6 : ℚ), 0, 0],
  ![0, 0, 0, 0, (262144 / 6645807 : ℚ), (5 / 27 : ℚ), (5 / 27 : ℚ), 0, 0, 0]] := by
  funext i j
  fin_cases i <;> fin_cases j <;> norm_num [edgeRate, q1, Adj, adjacency, energy]

theorem exits_1 : exitRate q1 = ![(13 / 27 : ℚ), (13 / 27 : ℚ), (1 / 2 : ℚ), (1 / 2 : ℚ), (2723554 / 6645807 : ℚ), (14 / 27 : ℚ), (14 / 27 : ℚ), (1 / 2 : ℚ), (1 / 2 : ℚ), (3922253 / 6645807 : ℚ)] := by
  funext j
  fin_cases j <;> norm_num [exitRate, edge_rates_1, Fin.sum_univ_succ]

theorem transition_1 : transition q1 = ![
  ![(14 / 27 : ℚ), 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (5 / 27 : ℚ), 0, 0, 0, 0, 0],
  ![0, (14 / 27 : ℚ), (1 / 6 : ℚ), (1 / 6 : ℚ), (5 / 27 : ℚ), 0, 0, 0, 0, 0],
  ![(1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 2 : ℚ), (1 / 6 : ℚ), 0, 0, 0, 0, 0, 0],
  ![(1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 2 : ℚ), 0, 0, 0, 0, 0, 0],
  ![(4 / 27 : ℚ), (4 / 27 : ℚ), 0, 0, (3922253 / 6645807 : ℚ), 0, 0, 0, 0, (1953125 / 6645807 : ℚ)],
  ![0, 0, 0, 0, 0, (13 / 27 : ℚ), 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (4 / 27 : ℚ)],
  ![0, 0, 0, 0, 0, 0, (13 / 27 : ℚ), (1 / 6 : ℚ), (1 / 6 : ℚ), (4 / 27 : ℚ)],
  ![0, 0, 0, 0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 2 : ℚ), (1 / 6 : ℚ), 0],
  ![0, 0, 0, 0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 2 : ℚ), 0],
  ![0, 0, 0, 0, (262144 / 6645807 : ℚ), (5 / 27 : ℚ), (5 / 27 : ℚ), 0, 0, (2723554 / 6645807 : ℚ)]] := by
  funext i j
  fin_cases i <;> fin_cases j <;> norm_num [transition, exits_1, edge_rates_1]

theorem edge_rates_2 : edgeRate q2 = ![
  ![0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (100 / 303 : ℚ), 0, 0, 0, 0, 0],
  ![0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (100 / 303 : ℚ), 0, 0, 0, 0, 0],
  ![(1 / 6 : ℚ), (1 / 6 : ℚ), 0, (1 / 6 : ℚ), 0, 0, 0, 0, 0, 0],
  ![(1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 6 : ℚ), 0, 0, 0, 0, 0, 0, 0],
  ![(1 / 303 : ℚ), (1 / 303 : ℚ), 0, 0, 0, 0, 0, 0, 0, (1000000000000000000 / 3000000000000000003 : ℚ)],
  ![0, 0, 0, 0, 0, 0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 303 : ℚ)],
  ![0, 0, 0, 0, 0, 0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 303 : ℚ)],
  ![0, 0, 0, 0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), 0, (1 / 6 : ℚ), 0],
  ![0, 0, 0, 0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 6 : ℚ), 0, 0],
  ![0, 0, 0, 0, (1 / 3000000000000000003 : ℚ), (100 / 303 : ℚ), (100 / 303 : ℚ), 0, 0, 0]] := by
  funext i j
  fin_cases i <;> fin_cases j <;> norm_num [edgeRate, q2, Adj, adjacency, energy]

theorem exits_2 : exitRate q2 = ![(34 / 101 : ℚ), (34 / 101 : ℚ), (1 / 2 : ℚ), (1 / 2 : ℚ), (660066006600660067 / 1000000000000000001 : ℚ), (67 / 101 : ℚ), (67 / 101 : ℚ), (1 / 2 : ℚ), (1 / 2 : ℚ), (339933993399339934 / 1000000000000000001 : ℚ)] := by
  funext j
  fin_cases j <;> norm_num [exitRate, edge_rates_2, Fin.sum_univ_succ]

theorem transition_2 : transition q2 = ![
  ![(67 / 101 : ℚ), 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (100 / 303 : ℚ), 0, 0, 0, 0, 0],
  ![0, (67 / 101 : ℚ), (1 / 6 : ℚ), (1 / 6 : ℚ), (100 / 303 : ℚ), 0, 0, 0, 0, 0],
  ![(1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 2 : ℚ), (1 / 6 : ℚ), 0, 0, 0, 0, 0, 0],
  ![(1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 2 : ℚ), 0, 0, 0, 0, 0, 0],
  ![(1 / 303 : ℚ), (1 / 303 : ℚ), 0, 0, (339933993399339934 / 1000000000000000001 : ℚ), 0, 0, 0, 0, (1000000000000000000 / 3000000000000000003 : ℚ)],
  ![0, 0, 0, 0, 0, (34 / 101 : ℚ), 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 303 : ℚ)],
  ![0, 0, 0, 0, 0, 0, (34 / 101 : ℚ), (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 303 : ℚ)],
  ![0, 0, 0, 0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 2 : ℚ), (1 / 6 : ℚ), 0],
  ![0, 0, 0, 0, 0, (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 6 : ℚ), (1 / 2 : ℚ), 0],
  ![0, 0, 0, 0, (1 / 3000000000000000003 : ℚ), (100 / 303 : ℚ), (100 / 303 : ℚ), 0, 0, (660066006600660067 / 1000000000000000001 : ℚ)]] := by
  funext i j
  fin_cases i <;> fin_cases j <;> norm_num [transition, exits_2, edge_rates_2]

theorem p0_values : p0 = ![(100110055016503300462046203300165005500110001 / 1000550265078015302100205814400705023000450004 : ℚ), (100110055016503300462046203300165005500110001 / 1000550265078015302100205814400705023000450004 : ℚ), (100110055016503300462046203300165005500110001 / 1000550265078015302100205814400705023000450004 : ℚ), (100110055016503300462046203300165005500110001 / 1000550265078015302100205814400705023000450004 : ℚ), (25025011253000525063005250300011250250002500 / 250137566269503825525051453600176255750112501 : ℚ), (25000000000000000000000000000000000000000000 / 250137566269503825525051453600176255750112501 : ℚ), (25000000000000000000000000000000000000000000 / 250137566269503825525051453600176255750112501 : ℚ), (25000000000000000000000000000000000000000000 / 250137566269503825525051453600176255750112501 : ℚ), (25000000000000000000000000000000000000000000 / 250137566269503825525051453600176255750112501 : ℚ), (25002500000000000000000000000000000000000000 / 250137566269503825525051453600176255750112501 : ℚ)] := by
  funext i
  fin_cases i <;> norm_num [p0, gibbs, weight, q0, energy, Fin.sum_univ_succ]

theorem p1_values : p1 = ![(934343830146528803962389227301340043834193341 / 9004952385702137718901852329606345207004050036 : ℚ), (934343830146528803962389227301340043834193341 / 9004952385702137718901852329606345207004050036 : ℚ), (100110055016503300462046203300165005500110001 / 1000550265078015302100205814400705023000450004 : ℚ), (100110055016503300462046203300165005500110001 / 1000550265078015302100205814400705023000450004 : ℚ), (51920634491621806790084982803235990466198438 / 439757374268014750109363744959901888952612663 : ℚ), (216670000000000000000000000000000000000000000 / 2251238096425534429725463082401586301751012509 : ℚ), (216670000000000000000000000000000000000000000 / 2251238096425534429725463082401586301751012509 : ℚ), (25000000000000000000000000000000000000000000 / 250137566269503825525051453600176255750112501 : ℚ), (25000000000000000000000000000000000000000000 / 250137566269503825525051453600176255750112501 : ℚ), (12009193670378788789142240271993997230080000 / 146585791422671583369787914986633962984204221 : ℚ)] := by
  funext i
  fin_cases i <;> norm_num [p1, update, transition_1, p0_values, Fin.sum_univ_succ]

theorem initial_probability : ProbabilityVector p0 := by
  constructor
  · intro i
    fin_cases i <;> norm_num [p0_values]
  · norm_num [p0_values, Fin.sum_univ_succ]

theorem first_transition_stochastic : Stochastic (transition q1) := by
  constructor
  · intro i j
    fin_cases i <;> fin_cases j <;> norm_num [transition_1]
  · intro j
    fin_cases j <;> norm_num [transition_1, Fin.sum_univ_succ]

theorem second_transition_stochastic : Stochastic (transition q2) := by
  constructor
  · intro i j
    fin_cases i <;> fin_cases j <;> norm_num [transition_2]
  · intro j
    fin_cases j <;> norm_num [transition_2, Fin.sum_univ_succ]

theorem first_holding_positive : ∀ i : State, 0 < transition q1 i i := by
  intro i
  fin_cases i <;> norm_num [transition_1]

theorem second_holding_positive : ∀ i : State, 0 < transition q2 i i := by
  intro i
  fin_cases i <;> norm_num [transition_2]

theorem update_probability {q : ℚ} {p : State → ℚ}
    (hP : Stochastic (transition q)) (hd : ∀ i, 0 < transition q i i)
    (hp : ProbabilityVector p) : ProbabilityVector (update q p) := by
  constructor
  · intro i
    exact (mul_pos (hd i) (hp.1 i)).trans_le
      (Finset.single_le_sum (fun j _ => mul_nonneg (hP.1 i j) (hp.1 j).le) (mem_univ i))
  · unfold update
    rw [Finset.sum_comm]
    simp_rw [← Finset.sum_mul, hP.2, one_mul]
    exact hp.2

theorem first_updated_probability : ProbabilityVector p1 :=
  update_probability first_transition_stochastic first_holding_positive initial_probability

theorem second_updated_probability : ProbabilityVector p2 :=
  update_probability second_transition_stochastic second_holding_positive first_updated_probability

theorem first_activity_lt_half : activity q1 p0 < 1 / 2 := by
  norm_num [activity, exits_1, p0_values, Fin.sum_univ_succ]

theorem second_activity_margin : (1 / 2 + 1 / 400 : ℚ) < activity q2 p1 := by
  norm_num [activity, exits_2, p1_values, Fin.sum_univ_succ]

theorem average_activity_margin :
    (1 / 2 + 3 / 3200 : ℚ) < (activity q1 p0 + activity q2 p1) / 2 := by
  norm_num [activity, exits_1, exits_2, p0_values, p1_values, Fin.sum_univ_succ]

end GlauberCounterexample
