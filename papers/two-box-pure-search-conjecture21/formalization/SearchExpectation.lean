import CandidateRigidity
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Topology.Algebra.InfiniteSum.Real

/-!
# Expected search time and the actual residual-budget process

The visit count is computed from the infinite deterministic search word. Costs
are extended nonnegative infinite sums, so schedules that fail to find a target
are not silently assigned a zero cost. The finite-prefix identities below link
this model to the recursively defined budgets in BudgetRigidity.
-/

set_option autoImplicit false

open Finset Filter Topology
open scoped ENNReal

namespace PureSearch

def visits (schedule : ℕ → Bool) (box : Bool) : ℕ → ℕ
  | 0 => 0
  | n + 1 => visits schedule box n + if schedule n = box then 1 else 0

noncomputable def survival (m : ℝ) (schedule : ℕ → Bool) (box : Bool) (n : ℕ) : ℝ :=
  (1 / m) ^ visits schedule box n

noncomputable def prefixCost (m : ℝ) (schedule : ℕ → Bool) (box : Bool) (n : ℕ) : ℝ :=
  ∑ t ∈ range n, survival m schedule box t

noncomputable def survivalCost (m : ℝ) (schedule : ℕ → Bool) (box : Bool) : ℝ≥0∞ :=
  ∑' n, ENNReal.ofReal (survival m schedule box n)

noncomputable def searchMean (m : ℝ) : ℝ := m / (m - 1)

def coordinate (s : State) (box : Bool) : ℝ := if box then s.1 else s.2

noncomputable def budgetState (m V : ℝ) (schedule : ℕ → Bool) (n : ℕ) : State :=
  state m (V - searchMean m, V - searchMean m) schedule n

lemma survival_pos (m : ℝ) (hm : 0 < m) (s : ℕ → Bool) (b : Bool) (n : ℕ) :
    0 < survival m s b n := pow_pos (one_div_pos.mpr hm) _

lemma prefix_cost_nonneg (m : ℝ) (hm : 0 < m) (s : ℕ → Bool) (b : Bool) (n : ℕ) :
    0 ≤ prefixCost m s b n :=
  sum_nonneg (fun t _ => (survival_pos m hm s b t).le)

lemma search_mean_pos (m : ℝ) (hm : 1 < m) : 0 < searchMean m :=
  div_pos (by linarith) (by linarith)

lemma visits_add_le (s : ℕ → Bool) (b : Bool) (n k : ℕ) :
    visits s b (n + k) ≤ visits s b n + k := by
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Nat.add_succ, visits]
    split_ifs <;> omega

lemma prefix_cost_succ (m : ℝ) (s : ℕ → Bool) (b : Bool) (n : ℕ) :
    prefixCost m s b (n + 1) = prefixCost m s b n + survival m s b n := by
  exact sum_range_succ _ n

lemma survival_succ (m : ℝ) (s : ℕ → Bool) (b : Bool) (n : ℕ) :
    survival m s b (n + 1) =
      if s n = b then survival m s b n / m else survival m s b n := by
  unfold survival
  rw [visits]
  split_ifs <;> simp [pow_succ, div_eq_mul_inv]

/-- Exact finite-prefix conservation law. This identity is proved from the
actual visit count and the recursive state; it is not an interface premise. -/
theorem budget_conservation (m V : ℝ) (hm : 1 < m) (s : ℕ → Bool) (n : ℕ) (b : Bool) :
    prefixCost m s b n + survival m s b n *
      (searchMean m + coordinate (budgetState m V s n) b) = V := by
  have hm0 : m ≠ 0 := by linarith
  have hmd : m - 1 ≠ 0 := by linarith
  have searched (p z : ℝ) :
      p + p / m * (searchMean m + m * z) = p * (searchMean m + z) := by
    unfold searchMean
    field_simp
    ring
  have unsearched (p z : ℝ) :
      p + p * (searchMean m + (z - 1)) = p * (searchMean m + z) := by ring
  induction n with
  | zero => simp [prefixCost, survival, visits, budgetState, state, coordinate]
  | succ n ih =>
    rw [prefix_cost_succ, survival_succ]
    unfold budgetState at *
    rw [state]
    cases hb : b <;> cases ha : s n <;>
      simp only [hb, ha, coordinate, step, Bool.false_eq_true, Bool.true_eq_false,
        ↓reduceIte] at *
    all_goals
      first
      | rw [add_assoc, searched]; exact ih
      | rw [add_assoc, unsearched]; exact ih

/-- No suffix can beat searching its occupied box at every step. -/
theorem remaining_survival_lower_bound (m : ℝ) (hm : 1 < m)
    (s : ℕ → Bool) (b : Bool) (n : ℕ) :
    ENNReal.ofReal (survival m s b n * searchMean m) ≤
      ∑' k, ENNReal.ofReal (survival m s b (k + n)) := by
  have hr0 : 0 ≤ 1 / m := (one_div_pos.mpr (by linarith : 0 < m)).le
  have hr1 : 1 / m < 1 := (div_lt_one (by linarith)).mpr hm
  have hs := (hasSum_geometric_of_lt_one hr0 hr1).mul_left (survival m s b n)
  have hmean : (1 - 1 / m)⁻¹ = searchMean m := by
    unfold searchMean
    field_simp
  have hsum : (∑' k, survival m s b n * (1 / m) ^ k) =
      survival m s b n * searchMean m := by rw [hs.tsum_eq, hmean]
  rw [← hsum, ENNReal.ofReal_tsum_of_nonneg
    (fun k => mul_nonneg (survival_pos m (by linarith) s b n).le (pow_nonneg hr0 k)) hs.summable]
  apply ENNReal.tsum_le_tsum
  intro k
  apply ENNReal.ofReal_le_ofReal
  have hcount := visits_add_le s b n k
  rw [Nat.add_comm n k] at hcount
  simpa only [survival, pow_add] using pow_le_pow_of_le_one hr0 hr1.le hcount

/-- The exact expected-cost prefix bound, valid also for infinite total costs. -/
theorem prefix_plus_remaining_le_cost (m : ℝ) (hm : 1 < m)
    (s : ℕ → Bool) (b : Bool) (n : ℕ) :
    ENNReal.ofReal (prefixCost m s b n + survival m s b n * searchMean m) ≤
      survivalCost m s b := by
  have hp0 := prefix_cost_nonneg m (by linarith) s b n
  have ht0 := mul_nonneg (survival_pos m (by linarith) s b n).le (search_mean_pos m hm).le
  rw [ENNReal.ofReal_add hp0 ht0]
  have hp : ENNReal.ofReal (prefixCost m s b n) =
      ∑ t ∈ range n, ENNReal.ofReal (survival m s b t) :=
    ENNReal.ofReal_sum_of_nonneg (fun t _ => (survival_pos m (by linarith) s b t).le)
  rw [hp]
  calc
    _ ≤ (∑ t ∈ range n, ENNReal.ofReal (survival m s b t)) +
        ∑' k, ENNReal.ofReal (survival m s b (k + n)) :=
      add_le_add_left (remaining_survival_lower_bound m hm s b n) _
    _ = survivalCost m s b := ENNReal.summable.sum_add_tsum_nat_add'

/-- An actual expectation upper bound forces the corresponding budget
coordinate to be nonnegative at every prefix. -/
theorem cost_bound_implies_budget_nonnegative (m V : ℝ) (hm : 1 < m) (hV : 0 ≤ V)
    (s : ℕ → Bool) (b : Bool) (hcost : survivalCost m s b ≤ ENNReal.ofReal V) (n : ℕ) :
    0 ≤ coordinate (budgetState m V s n) b := by
  have hlower := (ENNReal.ofReal_le_ofReal_iff hV).mp
    ((prefix_plus_remaining_le_cost m hm s b n).trans hcost)
  have hid := budget_conservation m V hm s n b
  have hp := survival_pos m (by linarith) s b n
  nlinarith

/-- Conversely, nonnegative budgets bound all finite prefix costs, and hence
the entire extended nonnegative expected cost. -/
theorem budget_nonnegative_implies_cost_bound (m V : ℝ) (hm : 1 < m)
    (s : ℕ → Bool) (b : Bool)
    (hbudget : ∀ n, 0 ≤ coordinate (budgetState m V s n) b) :
    survivalCost m s b ≤ ENNReal.ofReal V := by
  apply ENNReal.tsum_le_of_sum_range_le
  intro n
  have hid := budget_conservation m V hm s n b
  have htail := mul_nonneg (survival_pos m (by linarith) s b n).le
    (add_nonneg (search_mean_pos m hm).le (hbudget n))
  have hp : prefixCost m s b n ≤ V := by linarith
  rw [← ENNReal.ofReal_sum_of_nonneg
    (fun t (_ : t ∈ range n) => (survival_pos m (by linarith) s b t).le)]
  exact ENNReal.ofReal_le_ofReal hp

/-- The probability-cost condition and the recursive nonnegative-budget
condition are equivalent for arbitrary infinite deterministic schedules. -/
theorem cost_bound_iff_budget_feasible (m V : ℝ) (hm : 1 < m) (hV : 0 ≤ V)
    (s : ℕ → Bool) :
    (∀ b, survivalCost m s b ≤ ENNReal.ofReal V) ↔
      ∀ n, Nonnegative (budgetState m V s n) := by
  constructor
  · intro hc n
    constructor
    · exact cost_bound_implies_budget_nonnegative m V hm hV s true (hc true) n
    · exact cost_bound_implies_budget_nonnegative m V hm hV s false (hc false) n
  · intro hb b
    apply budget_nonnegative_implies_cost_bound m V hm s b
    intro n
    cases b
    · exact (hb n).2
    · exact (hb n).1


noncomputable def candidateValue (m : ℕ) : ℝ :=
  searchMean m + 1 + candidateDelta m / m

lemma candidate_value_pos (m : ℕ) (hm : 3 ≤ m) : 0 < candidateValue m := by
  have hmreal : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have hq := search_mean_pos m hmreal
  have hd := div_nonneg (candidate_delta_nonnegative m hm) (Nat.cast_nonneg m)
  unfold candidateValue
  linarith

lemma candidate_budget_state (m n : ℕ) (s : ℕ → Bool) :
    budgetState m (candidateValue m) s n = state m (candidateInitial m) s n := by
  unfold budgetState candidateValue candidateInitial
  congr 1
  apply Prod.ext <;> dsimp <;> ring

/-- The candidate attains a finite upper bound in the actual infinite-cost model. -/
theorem candidate_survival_cost_le (m : ℕ) (hm : 3 ≤ m) (b : Bool) :
    survivalCost m (candidate m) b ≤ ENNReal.ofReal (candidateValue m) := by
  have hmreal : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  apply (cost_bound_iff_budget_feasible m (candidateValue m) hmreal
    (candidate_value_pos m hm).le (candidate m)).2 _ b
  intro n
  rw [candidate_budget_state]
  exact candidate_nonnegative m hm n

lemma periodic_coordinate_le (m : ℝ) (h : ℕ) (delta : ℝ) (hh : 0 < h)
    (hm : 1 ≤ m) (hd : 0 ≤ delta) (hreturn : m ^ h * delta = (h : ℝ) + delta)
    (n : ℕ) (b : Bool) :
    coordinate (state m ((h : ℝ) + delta, delta) (periodicAction h) n) b ≤
      (h : ℝ) + delta := by
  have hj : n % h < h := Nat.mod_lt n hh
  have hdecomp : n / h * h + n % h = n := by
    simpa only [Nat.mul_comm, Nat.add_comm] using Nat.mod_add_div n h
  have hpower := mul_le_mul_of_nonneg_right (pow_le_pow_right₀ hm hj.le) hd
  rw [hreturn] at hpower
  have hinactive : (h : ℝ) + delta - (n % h : ℕ) ≤ (h : ℝ) + delta := by
    have : (0 : ℝ) ≤ (n % h : ℕ) := Nat.cast_nonneg (n % h)
    linarith
  rw [← hdecomp, periodic_block_state m h delta hh hreturn (n / h) (n % h) hj.le]
  cases ha : blockAction (n / h) <;> cases b <;>
    simp only [ha, Bool.false_eq_true, ↓reduceIte, coordinate] <;> assumption

/-- A uniform real bound on both candidate coordinates at every time. -/
theorem candidate_coordinate_bounded (m : ℕ) (hm : 3 ≤ m) (n : ℕ) (b : Bool) :
    0 ≤ coordinate (state m (candidateInitial m) (candidate m) n) b ∧
      coordinate (state m (candidateInitial m) (candidate m) n) b ≤
        (m : ℝ) + candidateDelta m := by
  constructor
  · cases b
    · exact (candidate_nonnegative m hm n).2
    · exact (candidate_nonnegative m hm n).1
  · have hm1 : (1 : ℝ) ≤ m := by exact_mod_cast (show 1 ≤ m by omega)
    have hdiv := div_le_self (candidate_delta_nonnegative m hm) hm1
    have hm0 : (m : ℝ) ≠ 0 := by exact_mod_cast (show m ≠ 0 by omega)
    rcases n with _ | (_ | n)
    · cases b <;> simp only [state, candidateInitial, coordinate, Bool.false_eq_true, ↓reduceIte] <;> linarith
    · cases b <;> simp only [state, candidateInitial, coordinate, candidate, step, Bool.false_eq_true, ↓reduceIte]
      · linarith
      · have heq : (m : ℝ) * (1 + candidateDelta m / m) = m + candidateDelta m := by
          field_simp
        rw [heq]
    · rw [show n + 1 + 1 = 2 + n by omega, candidate_tail_state m hm]
      have hbound := periodic_coordinate_le (m : ℝ) (m - 1) (candidateDelta m)
        (by omega) hm1 (candidate_delta_nonnegative m hm) (candidate_delta_return m hm) n b
      have hcast : ((m - 1 : ℕ) : ℝ) ≤ m := by exact_mod_cast Nat.sub_le m 1
      exact hbound.trans (add_le_add_right hcast _)

/-- Bounded feasible budgets force the finite upper bound to be the exact
infinite expected cost. The proof uses summability and a vanishing remainder. -/
theorem survival_cost_eq_of_bounded_budget (m V B : ℝ) (hm : 1 < m)
    (s : ℕ → Bool) (b : Bool)
    (hbound : ∀ n, 0 ≤ coordinate (budgetState m V s n) b ∧
      coordinate (budgetState m V s n) b ≤ B) :
    survivalCost m s b = ENNReal.ofReal V := by
  have hpos : ∀ n, 0 ≤ survival m s b n := fun n => (survival_pos m (by linarith) s b n).le
  have hp : ∀ n, prefixCost m s b n ≤ V := by
    intro n
    have hid := budget_conservation m V hm s n b
    have htail := mul_nonneg (hpos n) (add_nonneg (search_mean_pos m hm).le (hbound n).1)
    linarith
  have hsum : Summable (survival m s b) := summable_of_sum_range_le hpos hp
  have hz : Tendsto (survival m s b) atTop (𝓝 0) := hsum.tendsto_atTop_zero
  have hrem : Tendsto (fun n => survival m s b n *
      (searchMean m + coordinate (budgetState m V s n) b)) atTop (𝓝 0) := by
    apply squeeze_zero
    · intro n
      exact mul_nonneg (hpos n) (add_nonneg (search_mean_pos m hm).le (hbound n).1)
    · intro n
      exact mul_le_mul_of_nonneg_left (add_le_add_left (hbound n).2 _) (hpos n)
    · simpa using hz.mul_const (searchMean m + B)
  have hlim : Tendsto (prefixCost m s b) atTop (𝓝 V) := by
    have heq : prefixCost m s b = fun n => V - survival m s b n *
        (searchMean m + coordinate (budgetState m V s n) b) := by
      funext n
      have hid := budget_conservation m V hm s n b
      linarith
    rw [heq]
    simpa using tendsto_const_nhds.sub hrem
  have hsumlim : Tendsto (prefixCost m s b) atTop (𝓝 (∑' n, survival m s b n)) :=
    hsum.hasSum.tendsto_sum_nat
  have heq := tendsto_nhds_unique hsumlim hlim
  unfold survivalCost
  rw [← ENNReal.ofReal_tsum_of_nonneg hpos hsum, heq]

/-- Both conditional expected costs of the explicit candidate equal the claimed
value, with no summability or payoff formula assumed. -/
theorem candidate_survival_cost_eq (m : ℕ) (hm : 3 ≤ m) (b : Bool) :
    survivalCost m (candidate m) b = ENNReal.ofReal (candidateValue m) := by
  apply survival_cost_eq_of_bounded_budget m (candidateValue m) (m + candidateDelta m)
    (by exact_mod_cast (show 1 < m by omega)) (candidate m) b
  intro n
  rw [candidate_budget_state]
  exact candidate_coordinate_bounded m hm n b

def complementSchedule (s : ℕ → Bool) (n : ℕ) : Bool := !(s n)

lemma complement_schedule_involutive (s : ℕ → Bool) :
    complementSchedule (complementSchedule s) = s := by
  funext n
  simp [complementSchedule]

lemma visits_complement (s : ℕ → Bool) (b : Bool) (n : ℕ) :
    visits (complementSchedule s) b n = visits s (!b) n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    simp only [visits, ih, complementSchedule]
    congr 1
    have hnot (a c : Bool) :
        (if (!a) = c then (1 : ℕ) else 0) = (if a = !c then 1 else 0) := by
      cases a <;> cases c <;> decide
    exact hnot (s n) b

lemma survival_cost_complement (m : ℝ) (s : ℕ → Bool) (b : Bool) :
    survivalCost m (complementSchedule s) b = survivalCost m s (!b) := by
  simp only [survivalCost, survival, visits_complement]

noncomputable def worstSurvivalCost (m : ℝ) (s : ℕ → Bool) : ℝ≥0∞ :=
  max (survivalCost m s true) (survivalCost m s false)

lemma worst_survival_cost_complement (m : ℝ) (s : ℕ → Bool) :
    worstSurvivalCost m (complementSchedule s) = worstSurvivalCost m s := by
  simp [worstSurvivalCost, survival_cost_complement, max_comm]

lemma candidate_worst_survival_cost (m : ℕ) (hm : 3 ≤ m) :
    worstSurvivalCost m (candidate m) = ENNReal.ofReal (candidateValue m) := by
  simp [worstSurvivalCost, candidate_survival_cost_eq m hm]

/-- Actual finite expected-cost bounds discharge all residual-budget premises
in the uniqueness theorem. Both possible first actions are covered. -/
theorem survival_cost_bound_classification (m : ℕ) (hm : 3 ≤ m) (s : ℕ → Bool) :
    worstSurvivalCost m s ≤ ENNReal.ofReal (candidateValue m) ↔
      s = candidate m ∨ s = complementSchedule (candidate m) := by
  have hmreal : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have rigid (t : ℕ → Bool) (hfirst : t 0 = true)
      (hcost : worstSurvivalCost m t ≤ ENNReal.ofReal (candidateValue m)) : t = candidate m := by
    apply concrete_candidate_rigidity m hm t hfirst
    have hb := (cost_bound_iff_budget_feasible m (candidateValue m) hmreal
      (candidate_value_pos m hm).le t).1 (fun b => ?_)
    · intro n
      simpa only [candidate_budget_state] using hb n
    · cases b
      · exact (le_max_right _ _).trans hcost
      · exact (le_max_left _ _).trans hcost
  constructor
  · intro hc
    by_cases hfirst : s 0 = true
    · exact Or.inl (rigid s hfirst hc)
    · have hcfirst : complementSchedule s 0 = true := by
        cases hs : s 0 <;> simp_all [complementSchedule]
      have heq := rigid (complementSchedule s) hcfirst
        (by simpa only [worst_survival_cost_complement] using hc)
      right
      simpa only [complement_schedule_involutive] using congrArg complementSchedule heq
  · rintro (rfl | rfl)
    · exact (candidate_worst_survival_cost m hm).le
    · rw [worst_survival_cost_complement, candidate_worst_survival_cost m hm]

/-- Global minimax optimality over all infinite words, including divergent costs. -/
theorem pure_search_survival_optimality (m : ℕ) (hm : 3 ≤ m) (s : ℕ → Bool) :
    ENNReal.ofReal (candidateValue m) ≤ worstSurvivalCost m s := by
  by_contra h
  have hlt : worstSurvivalCost m s < ENNReal.ofReal (candidateValue m) := lt_of_not_ge h
  rcases (survival_cost_bound_classification m hm s).1 hlt.le with rfl | rfl
  · rw [candidate_worst_survival_cost m hm] at hlt
    exact lt_irrefl _ hlt
  · rw [worst_survival_cost_complement, candidate_worst_survival_cost m hm] at hlt
    exact lt_irrefl _ hlt

/-- The two label-reversed candidates are exactly the minimizing infinite words. -/
theorem pure_search_survival_minimizers (m : ℕ) (hm : 3 ≤ m) (s : ℕ → Bool) :
    worstSurvivalCost m s = ENNReal.ofReal (candidateValue m) ↔
      s = candidate m ∨ s = complementSchedule (candidate m) := by
  constructor
  · intro h
    exact (survival_cost_bound_classification m hm s).1 h.le
  · intro h
    exact le_antisymm ((survival_cost_bound_classification m hm s).2 h)
      (pure_search_survival_optimality m hm s)

/-- The value is the exact expression displayed in Theorem 1 of the manuscript. -/
theorem candidate_value_formula (m : ℕ) (hm : 3 ≤ m) :
    candidateValue m = 2 + 1 / ((m : ℝ) - 1) +
      ((m : ℝ) - 1) / ((m : ℝ) * ((m : ℝ) ^ (m - 1) - 1)) := by
  have hm0 : (m : ℝ) ≠ 0 := by exact_mod_cast (show m ≠ 0 by omega)
  have hmd : (m : ℝ) - 1 ≠ 0 := by
    have hmreal : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
    linarith
  unfold candidateValue searchMean candidateDelta
  field_simp
  ring

end PureSearch

#print axioms PureSearch.survival_pos
#print axioms PureSearch.prefix_cost_nonneg
#print axioms PureSearch.search_mean_pos
#print axioms PureSearch.visits_add_le
#print axioms PureSearch.prefix_cost_succ
#print axioms PureSearch.survival_succ
#print axioms PureSearch.budget_conservation
#print axioms PureSearch.remaining_survival_lower_bound
#print axioms PureSearch.prefix_plus_remaining_le_cost
#print axioms PureSearch.cost_bound_implies_budget_nonnegative
#print axioms PureSearch.budget_nonnegative_implies_cost_bound
#print axioms PureSearch.cost_bound_iff_budget_feasible
#print axioms PureSearch.candidate_value_pos
#print axioms PureSearch.candidate_budget_state
#print axioms PureSearch.candidate_survival_cost_le
#print axioms PureSearch.periodic_coordinate_le
#print axioms PureSearch.candidate_coordinate_bounded
#print axioms PureSearch.survival_cost_eq_of_bounded_budget
#print axioms PureSearch.candidate_survival_cost_eq
#print axioms PureSearch.complement_schedule_involutive
#print axioms PureSearch.visits_complement
#print axioms PureSearch.survival_cost_complement
#print axioms PureSearch.worst_survival_cost_complement
#print axioms PureSearch.candidate_worst_survival_cost
#print axioms PureSearch.survival_cost_bound_classification
#print axioms PureSearch.pure_search_survival_optimality
#print axioms PureSearch.pure_search_survival_minimizers
#print axioms PureSearch.candidate_value_formula
