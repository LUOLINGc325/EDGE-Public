import Mathlib.Combinatorics.SimpleGraph.Path
import Mathlib.Data.Real.Archimedean
import Mathlib.Data.Finset.Powerset
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# The connected five-vertex sharpness witness

The legal actions are the edges 01, 02, 12, 23, 34 of an actual connected
simple graph. Every vertex has unit reward; a trap in the selected edge
destroys its reward. All probability strategies below are real vectors.
This module establishes the equality witness, not the universal graph bound.
-/

set_option autoImplicit false

open scoped BigOperators

namespace ReciprocalSearch.FiveVertex

noncomputable section

abbrev Vertex := Fin 5
abbrev Action := Fin 5

noncomputable def edge (a : Action) : Finset Vertex :=
  if a.val = 0 then {0, 1} else if a.val = 1 then {0, 2}
  else if a.val = 2 then {1, 2} else if a.val = 3 then {2, 3} else {3, 4}

noncomputable def vertexReward (_v : Vertex) : ℝ := 1

noncomputable def reward (a : Action) : ℝ := ∑ v ∈ edge a, vertexReward v

noncomputable def payoff (a : Action) (trap : Vertex) : ℝ :=
  if trap ∈ edge a then 0 else reward a

noncomputable def Probability (p : Fin 5 → ℝ) : Prop :=
  (∀ i, 0 ≤ p i) ∧ ∑ i, p i = 1

noncomputable def expected (p : Action → ℝ) (trap : Vertex) : ℝ :=
  ∑ a, p a * payoff a trap

noncomputable def rowExpected (q : Vertex → ℝ) (a : Action) : ℝ :=
  ∑ v, q v * payoff a v

noncomputable def mixedPayoff (p : Action → ℝ) (q : Vertex → ℝ) : ℝ :=
  ∑ v, q v * expected p v

/-- The minimum over exactly the five legal pure trap positions. -/
noncomputable def guarantee (p : Action → ℝ) : ℝ :=
  min (min (expected p 0) (expected p 1))
    (min (expected p 2) (min (expected p 3) (expected p 4)))

/-- The maximum over exactly the five legal pure search actions. -/
noncomputable def hiderCost (q : Vertex → ℝ) : ℝ :=
  max (max (rowExpected q 0) (rowExpected q 1))
    (max (rowExpected q 2) (max (rowExpected q 3) (rowExpected q 4)))

noncomputable def gameValue : ℝ :=
  sSup {t | ∃ p : Action → ℝ, Probability p ∧ guarantee p = t}

noncomputable def hiderValue : ℝ :=
  sInf {t | ∃ q : Vertex → ℝ, Probability q ∧ hiderCost q = t}

noncomputable def searcherStar (a : Action) : ℝ :=
  if a.val = 3 then 0 else if a.val = 4 then 2 / 5 else 1 / 5

noncomputable def hiderStar (_v : Vertex) : ℝ := 1 / 5

/-- The graph is defined by the same legal edges used in the payoff. -/
noncomputable def graph : SimpleGraph Vertex where
  Adj u v := u ≠ v ∧ ∃ a : Action, u ∈ edge a ∧ v ∈ edge a
  symm := by
    rintro u v ⟨hne, a, hu, hv⟩
    exact ⟨hne.symm, a, hv, hu⟩
  loopless := by
    intro u h
    exact h.1 rfl

theorem graph_edges_have_two_vertices (a : Action) : (edge a).card = 2 := by
  fin_cases a <;>
    norm_num [edge, Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem graph_connected : graph.Connected := by
  have h01 : graph.Adj 0 1 := by
    refine ⟨by decide, 0, ?_, ?_⟩ <;> decide
  have h02 : graph.Adj 0 2 := by
    refine ⟨by decide, 1, ?_, ?_⟩ <;> decide
  have h23 : graph.Adj 2 3 := by
    refine ⟨by decide, 3, ?_, ?_⟩ <;> decide
  have h34 : graph.Adj 3 4 := by
    refine ⟨by decide, 4, ?_, ?_⟩ <;> decide
  apply (SimpleGraph.connected_iff_exists_forall_reachable graph).mpr
  refine ⟨0, ?_⟩
  intro v
  fin_cases v
  · exact SimpleGraph.Reachable.rfl
  · exact h01.reachable
  · exact h02.reachable
  · exact h02.reachable.trans h23.reachable
  · exact (h02.reachable.trans h23.reachable).trans h34.reachable

theorem reward_formula (a : Action) : reward a = 2 := by
  simp [reward, vertexReward, graph_edges_have_two_vertices]

theorem expected_zero (p : Action → ℝ) :
    expected p 0 = 2 * (p 2 + p 3 + p 4) := by
  norm_num [expected, payoff, reward_formula, edge, Fin.sum_univ_five,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem expected_one (p : Action → ℝ) :
    expected p 1 = 2 * (p 1 + p 3 + p 4) := by
  norm_num [expected, payoff, reward_formula, edge, Fin.sum_univ_five,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem expected_two (p : Action → ℝ) :
    expected p 2 = 2 * (p 0 + p 4) := by
  norm_num [expected, payoff, reward_formula, edge, Fin.sum_univ_five,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem expected_three (p : Action → ℝ) :
    expected p 3 = 2 * (p 0 + p 1 + p 2) := by
  norm_num [expected, payoff, reward_formula, edge, Fin.sum_univ_five,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem expected_four (p : Action → ℝ) :
    expected p 4 = 2 * (p 0 + p 1 + p 2 + p 3) := by
  norm_num [expected, payoff, reward_formula, edge, Fin.sum_univ_five,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem rowExpected_zero (q : Vertex → ℝ) :
    rowExpected q 0 = 2 * (q 2 + q 3 + q 4) := by
  norm_num [rowExpected, payoff, reward_formula, edge, Fin.sum_univ_five,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem rowExpected_one (q : Vertex → ℝ) :
    rowExpected q 1 = 2 * (q 1 + q 3 + q 4) := by
  norm_num [rowExpected, payoff, reward_formula, edge, Fin.sum_univ_five,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem rowExpected_two (q : Vertex → ℝ) :
    rowExpected q 2 = 2 * (q 0 + q 3 + q 4) := by
  norm_num [rowExpected, payoff, reward_formula, edge, Fin.sum_univ_five,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem rowExpected_three (q : Vertex → ℝ) :
    rowExpected q 3 = 2 * (q 0 + q 1 + q 4) := by
  norm_num [rowExpected, payoff, reward_formula, edge, Fin.sum_univ_five,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem rowExpected_four (q : Vertex → ℝ) :
    rowExpected q 4 = 2 * (q 0 + q 1 + q 2) := by
  norm_num [rowExpected, payoff, reward_formula, edge, Fin.sum_univ_five,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem le_guarantee_iff (p : Action → ℝ) (t : ℝ) :
    t ≤ guarantee p ↔ ∀ v, t ≤ expected p v := by
  simp only [guarantee, le_min_iff]
  constructor
  · rintro ⟨⟨h0, h1⟩, ⟨h2, ⟨h3, h4⟩⟩⟩ v
    fin_cases v <;> assumption
  · intro h
    exact ⟨⟨h 0, h 1⟩, ⟨h 2, ⟨h 3, h 4⟩⟩⟩

theorem hiderCost_le_iff (q : Vertex → ℝ) (t : ℝ) :
    hiderCost q ≤ t ↔ ∀ a, rowExpected q a ≤ t := by
  simp only [hiderCost, max_le_iff]
  constructor
  · rintro ⟨⟨h0, h1⟩, ⟨h2, ⟨h3, h4⟩⟩⟩ a
    fin_cases a <;> assumption
  · intro h
    exact ⟨⟨h 0, h 1⟩, ⟨h 2, ⟨h 3, h 4⟩⟩⟩

theorem reward_pos (a : Action) : 0 < reward a := by
  fin_cases a <;> norm_num [reward, vertexReward, edge, Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem searcherStar_probability : Probability searcherStar := by
  constructor
  · intro a
    fin_cases a <;> norm_num [searcherStar, Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · norm_num [searcherStar, Fin.sum_univ_five, Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem hiderStar_probability : Probability hiderStar := by
  constructor
  · intro v
    fin_cases v <;> norm_num [hiderStar, Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · norm_num [hiderStar, Fin.sum_univ_five, Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem searcherStar_columns (v : Vertex) : expected searcherStar v = 6 / 5 := by
  fin_cases v
  · change expected searcherStar 0 = 6 / 5
    norm_num [expected_zero, searcherStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change expected searcherStar 1 = 6 / 5
    norm_num [expected_one, searcherStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change expected searcherStar 2 = 6 / 5
    norm_num [expected_two, searcherStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change expected searcherStar 3 = 6 / 5
    norm_num [expected_three, searcherStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change expected searcherStar 4 = 6 / 5
    norm_num [expected_four, searcherStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem hiderStar_rows (a : Action) : rowExpected hiderStar a = 6 / 5 := by
  fin_cases a
  · change rowExpected hiderStar 0 = 6 / 5
    norm_num [rowExpected_zero, hiderStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change rowExpected hiderStar 1 = 6 / 5
    norm_num [rowExpected_one, hiderStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change rowExpected hiderStar 2 = 6 / 5
    norm_num [rowExpected_two, hiderStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change rowExpected hiderStar 3 = 6 / 5
    norm_num [rowExpected_three, hiderStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change rowExpected hiderStar 4 = 6 / 5
    norm_num [rowExpected_four, hiderStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem searcherStar_guarantee : guarantee searcherStar = 6 / 5 := by
  simp [guarantee, searcherStar_columns]

theorem hiderStar_cost : hiderCost hiderStar = 6 / 5 := by
  simp [hiderCost, hiderStar_rows]

theorem mixedPayoff_comm (p : Action → ℝ) (q : Vertex → ℝ) :
    mixedPayoff p q = ∑ a, p a * rowExpected q a := by
  simp only [mixedPayoff, expected, rowExpected, Finset.mul_sum]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro a _
  apply Finset.sum_congr rfl
  intro v _
  ring

theorem searcherStar_against_all (q : Vertex → ℝ) (hq : Probability q) :
    mixedPayoff searcherStar q = 6 / 5 := by
  simp only [mixedPayoff, searcherStar_columns, ← Finset.sum_mul, hq.2, one_mul]

theorem hiderStar_against_all (p : Action → ℝ) (hp : Probability p) :
    mixedPayoff p hiderStar = 6 / 5 := by
  rw [mixedPayoff_comm]
  simp only [hiderStar_rows, ← Finset.sum_mul, hp.2, one_mul]

theorem guarantee_le_mixture (p : Action → ℝ) (q : Vertex → ℝ)
    (hq : Probability q) : guarantee p ≤ mixedPayoff p q := by
  have hcols := (le_guarantee_iff p (guarantee p)).1 le_rfl
  calc
    guarantee p = ∑ v, q v * guarantee p := by rw [← Finset.sum_mul, hq.2, one_mul]
    _ ≤ mixedPayoff p q := Finset.sum_le_sum
      (fun v _ => mul_le_mul_of_nonneg_left (hcols v) (hq.1 v))

theorem mixture_le_hiderCost (p : Action → ℝ) (q : Vertex → ℝ)
    (hp : Probability p) : mixedPayoff p q ≤ hiderCost q := by
  have hrows := (hiderCost_le_iff q (hiderCost q)).1 le_rfl
  rw [mixedPayoff_comm]
  calc
    _ ≤ ∑ a, p a * hiderCost q := Finset.sum_le_sum
      (fun a _ => mul_le_mul_of_nonneg_left (hrows a) (hp.1 a))
    _ = hiderCost q := by rw [← Finset.sum_mul, hp.2, one_mul]

theorem all_searchers_upper_bound (p : Action → ℝ) (hp : Probability p) :
    guarantee p ≤ 6 / 5 := by
  simpa [hiderStar_against_all p hp] using guarantee_le_mixture p hiderStar hiderStar_probability

theorem all_hiders_lower_bound (q : Vertex → ℝ) (hq : Probability q) :
    6 / 5 ≤ hiderCost q := by
  simpa [searcherStar_against_all q hq] using mixture_le_hiderCost searcherStar q searcherStar_probability

theorem gameValue_exact : gameValue = 6 / 5 := by
  apply IsGreatest.csSup_eq
  constructor
  · exact ⟨searcherStar, searcherStar_probability, searcherStar_guarantee⟩
  · rintro t ⟨p, hp, rfl⟩
    exact all_searchers_upper_bound p hp

theorem hiderValue_exact : hiderValue = 6 / 5 := by
  apply IsLeast.csInf_eq
  constructor
  · exact ⟨hiderStar, hiderStar_probability, hiderStar_cost⟩
  · rintro t ⟨q, hq, rfl⟩
    exact all_hiders_lower_bound q hq

theorem searcher_optimum_unique (p : Action → ℝ) (hp : Probability p)
    (hopt : guarantee p = 6 / 5) : p = searcherStar := by
  have hcols := (le_guarantee_iff p (6 / 5)).1 hopt.ge
  have h0 := hcols 0
  have h1 := hcols 1
  have h2 := hcols 2
  have h3 := hcols 3
  have h4 := hcols 4
  have hsum := hp.2
  norm_num [expected_zero, expected_one, expected_two, expected_three, expected_four,
    Fin.sum_univ_five] at h0 h1 h2 h3 h4 hsum
  funext a
  fin_cases a
  · change p 0 = 1 / 5
    linarith
  · change p 1 = 1 / 5
    linarith
  · change p 2 = 1 / 5
    linarith
  · change p 3 = 0
    linarith
  · change p 4 = 2 / 5
    linarith

/-- A support is an actual set of permitted hyperedges, not a free LP variable. -/
noncomputable def inverseWeight (support : Finset Action) (a : Action) : ℝ :=
  if a ∈ support then 1 / reward a else 0

noncomputable def normalizer (support : Finset Action) : ℝ := ∑ a, inverseWeight support a

noncomputable def reciprocal (support : Finset Action) (a : Action) : ℝ :=
  inverseWeight support a / normalizer support

noncomputable def reciprocalValue : ℝ :=
  sSup {t | ∃ support : Finset Action,
    support.Nonempty ∧ guarantee (reciprocal support) = t}

theorem inverseWeight_nonnegative (support : Finset Action) (a : Action) :
    0 ≤ inverseWeight support a := by
  by_cases ha : a ∈ support
  · simp only [inverseWeight, if_pos ha]
    exact le_of_lt (div_pos zero_lt_one (reward_pos a))
  · simp [inverseWeight, ha]

theorem normalizer_pos (support : Finset Action) (h : support.Nonempty) :
    0 < normalizer support := by
  apply Finset.sum_pos'
  · intro a _
    exact inverseWeight_nonnegative support a
  · obtain ⟨a, ha⟩ := h
    refine ⟨a, Finset.mem_univ a, ?_⟩
    simpa only [inverseWeight, if_pos ha] using div_pos zero_lt_one (reward_pos a)

theorem reciprocal_probability (support : Finset Action) (h : support.Nonempty) :
    Probability (reciprocal support) := by
  constructor
  · intro a
    exact div_nonneg (inverseWeight_nonnegative support a) (normalizer_pos support h).le
  · change (∑ a, inverseWeight support a / normalizer support) = 1
    rw [← Finset.sum_div]
    exact div_self (ne_of_gt (normalizer_pos support h))

theorem reciprocal_positive_iff (support : Finset Action) (h : support.Nonempty)
    (a : Action) : 0 < reciprocal support a ↔ a ∈ support := by
  by_cases ha : a ∈ support
  · simp only [ha, iff_true]
    apply div_pos _ (normalizer_pos support h)
    simpa only [inverseWeight, if_pos ha] using div_pos zero_lt_one (reward_pos a)
  · simp [reciprocal, inverseWeight, ha]

/-- Exactly the 31 nonempty subsets of the five actual legal graph edges. -/
theorem nonempty_support_count :
    (Finset.univ.filter (fun support : Finset Action => support.Nonempty)).card = 31 := by
  decide

/-- Exhaustive proof for actual finite supports, with real reciprocal weights.
The empty set also has value zero by Lean's division convention, but is never
included among the admissible probability strategies. -/
theorem all_reciprocal_supports_bound (support : Finset Action) :
    guarantee (reciprocal support) ≤ 1 := by
  fin_cases support <;>
    norm_num [guarantee, expected_zero, expected_one, expected_two, expected_three, expected_four,
      reciprocal, normalizer, inverseWeight, reward_formula, Fin.sum_univ_five,
      Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

noncomputable def attainingSupport : Finset Action := {0, 4}

theorem attainingSupport_nonempty : attainingSupport.Nonempty := by decide

theorem reciprocal_attainment : guarantee (reciprocal attainingSupport) = 1 := by
  norm_num [guarantee, expected_zero, expected_one, expected_two, expected_three, expected_four,
    reciprocal, normalizer, inverseWeight, attainingSupport, reward_formula, Fin.sum_univ_five,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem reciprocalValue_exact : reciprocalValue = 1 := by
  apply IsGreatest.csSup_eq
  constructor
  · exact ⟨attainingSupport, attainingSupport_nonempty, reciprocal_attainment⟩
  · rintro t ⟨support, _hne, rfl⟩
    exact all_reciprocal_supports_bound support

theorem strict_gap : gameValue - reciprocalValue = 1 / 5 := by
  rw [gameValue_exact, reciprocalValue_exact]
  norm_num

theorem exact_ratio : reciprocalValue / gameValue = 5 / 6 := by
  rw [gameValue_exact, reciprocalValue_exact]
  norm_num

/-- The conjectured form fails for every permitted nonempty support. -/
theorem every_reciprocal_strategy_suboptimal (support : Finset Action)
    (h : support.Nonempty) :
    Probability (reciprocal support) ∧ guarantee (reciprocal support) < gameValue := by
  constructor
  · exact reciprocal_probability support h
  · rw [gameValue_exact]
    exact lt_of_le_of_lt (all_reciprocal_supports_bound support) (by norm_num)

end

end ReciprocalSearch.FiveVertex

#print axioms ReciprocalSearch.FiveVertex.gameValue_exact
#print axioms ReciprocalSearch.FiveVertex.hiderValue_exact
#print axioms ReciprocalSearch.FiveVertex.searcher_optimum_unique
#print axioms ReciprocalSearch.FiveVertex.reciprocal_probability
#print axioms ReciprocalSearch.FiveVertex.reciprocal_positive_iff
#print axioms ReciprocalSearch.FiveVertex.nonempty_support_count
#print axioms ReciprocalSearch.FiveVertex.all_reciprocal_supports_bound
#print axioms ReciprocalSearch.FiveVertex.reciprocal_attainment
#print axioms ReciprocalSearch.FiveVertex.reciprocalValue_exact
#print axioms ReciprocalSearch.FiveVertex.strict_gap
#print axioms ReciprocalSearch.FiveVertex.exact_ratio
#print axioms ReciprocalSearch.FiveVertex.every_reciprocal_strategy_suboptimal

#print axioms ReciprocalSearch.FiveVertex.graph_connected
