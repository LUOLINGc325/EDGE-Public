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
# The actual four-vertex booby-trap game

Actions are the hyperedges {0,1}, {0,2}, {0,3}, {1,2,3}; each vertex has
unit reward. A trap in the chosen edge destroys the entire reward.
The strategy variables below range over all real probability vectors.
No payoff matrix certificate, game value or optimization result is assumed.
-/

set_option autoImplicit false

open scoped BigOperators

namespace ReciprocalSearch.FourVertex

noncomputable section

abbrev Vertex := Fin 4
abbrev Action := Fin 4

noncomputable def edge (a : Action) : Finset Vertex :=
  if a.val = 0 then {0, 1} else if a.val = 1 then {0, 2}
  else if a.val = 2 then {0, 3} else {1, 2, 3}

noncomputable def vertexReward (_v : Vertex) : ℝ := 1

noncomputable def reward (a : Action) : ℝ := ∑ v ∈ edge a, vertexReward v

noncomputable def payoff (a : Action) (trap : Vertex) : ℝ :=
  if trap ∈ edge a then 0 else reward a

noncomputable def Probability (p : Fin 4 → ℝ) : Prop :=
  (∀ i, 0 ≤ p i) ∧ ∑ i, p i = 1

noncomputable def expected (p : Action → ℝ) (trap : Vertex) : ℝ :=
  ∑ a, p a * payoff a trap

noncomputable def rowExpected (q : Vertex → ℝ) (a : Action) : ℝ :=
  ∑ v, q v * payoff a v

noncomputable def mixedPayoff (p : Action → ℝ) (q : Vertex → ℝ) : ℝ :=
  ∑ v, q v * expected p v

/-- The minimum over exactly the four legal pure trap positions. -/
noncomputable def guarantee (p : Action → ℝ) : ℝ :=
  min (min (expected p 0) (expected p 1)) (min (expected p 2) (expected p 3))

/-- The maximum over exactly the four legal pure search actions. -/
noncomputable def hiderCost (q : Vertex → ℝ) : ℝ :=
  max (max (rowExpected q 0) (rowExpected q 1))
    (max (rowExpected q 2) (rowExpected q 3))

noncomputable def gameValue : ℝ :=
  sSup {t | ∃ p : Action → ℝ, Probability p ∧ guarantee p = t}

noncomputable def hiderValue : ℝ :=
  sInf {t | ∃ q : Vertex → ℝ, Probability q ∧ hiderCost q = t}

noncomputable def searcherStar (a : Action) : ℝ := if a.val = 3 then 4 / 13 else 3 / 13

noncomputable def hiderStar (v : Vertex) : ℝ := if v.val = 0 then 4 / 13 else 3 / 13

/-- These identities are derived from the legal hyperedges and trap rule. -/
theorem reward_formula (a : Action) : reward a = if a.val = 3 then 3 else 2 := by
  fin_cases a <;>
    norm_num [reward, vertexReward, edge, Fin.ext_iff, Fin.coe_ofNat_eq_mod,
      -Fin.val_eq_zero_iff]

theorem expected_zero (p : Action → ℝ) : expected p 0 = 3 * p 3 := by
  norm_num [expected, payoff, reward_formula, edge, Fin.sum_univ_four,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem expected_one (p : Action → ℝ) : expected p 1 = 2 * (p 1 + p 2) := by
  norm_num [expected, payoff, reward_formula, edge, Fin.sum_univ_four,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem expected_two (p : Action → ℝ) : expected p 2 = 2 * (p 0 + p 2) := by
  norm_num [expected, payoff, reward_formula, edge, Fin.sum_univ_four,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem expected_three (p : Action → ℝ) : expected p 3 = 2 * (p 0 + p 1) := by
  norm_num [expected, payoff, reward_formula, edge, Fin.sum_univ_four,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem rowExpected_zero (q : Vertex → ℝ) : rowExpected q 0 = 2 * (q 2 + q 3) := by
  norm_num [rowExpected, payoff, reward_formula, edge, Fin.sum_univ_four,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem rowExpected_one (q : Vertex → ℝ) : rowExpected q 1 = 2 * (q 1 + q 3) := by
  norm_num [rowExpected, payoff, reward_formula, edge, Fin.sum_univ_four,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem rowExpected_two (q : Vertex → ℝ) : rowExpected q 2 = 2 * (q 1 + q 2) := by
  norm_num [rowExpected, payoff, reward_formula, edge, Fin.sum_univ_four,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem rowExpected_three (q : Vertex → ℝ) : rowExpected q 3 = 3 * q 0 := by
  norm_num [rowExpected, payoff, reward_formula, edge, Fin.sum_univ_four,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  ring

theorem le_guarantee_iff (p : Action → ℝ) (t : ℝ) :
    t ≤ guarantee p ↔ ∀ v, t ≤ expected p v := by
  simp only [guarantee, le_min_iff]
  constructor
  · rintro ⟨⟨h0, h1⟩, ⟨h2, h3⟩⟩ v
    fin_cases v <;> assumption
  · intro h
    exact ⟨⟨h 0, h 1⟩, ⟨h 2, h 3⟩⟩

theorem hiderCost_le_iff (q : Vertex → ℝ) (t : ℝ) :
    hiderCost q ≤ t ↔ ∀ a, rowExpected q a ≤ t := by
  simp only [hiderCost, max_le_iff]
  constructor
  · rintro ⟨⟨h0, h1⟩, ⟨h2, h3⟩⟩ a
    fin_cases a <;> assumption
  · intro h
    exact ⟨⟨h 0, h 1⟩, ⟨h 2, h 3⟩⟩

theorem reward_pos (a : Action) : 0 < reward a := by
  fin_cases a <;> norm_num [reward, vertexReward, edge, Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem searcherStar_probability : Probability searcherStar := by
  constructor
  · intro a
    fin_cases a <;> norm_num [searcherStar, Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · norm_num [searcherStar, Fin.sum_univ_four, Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem hiderStar_probability : Probability hiderStar := by
  constructor
  · intro v
    fin_cases v <;> norm_num [hiderStar, Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · norm_num [hiderStar, Fin.sum_univ_four, Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem searcherStar_columns (v : Vertex) : expected searcherStar v = 12 / 13 := by
  fin_cases v
  · change expected searcherStar 0 = 12 / 13
    norm_num [expected_zero, searcherStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change expected searcherStar 1 = 12 / 13
    norm_num [expected_one, searcherStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change expected searcherStar 2 = 12 / 13
    norm_num [expected_two, searcherStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change expected searcherStar 3 = 12 / 13
    norm_num [expected_three, searcherStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem hiderStar_rows (a : Action) : rowExpected hiderStar a = 12 / 13 := by
  fin_cases a
  · change rowExpected hiderStar 0 = 12 / 13
    norm_num [rowExpected_zero, hiderStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change rowExpected hiderStar 1 = 12 / 13
    norm_num [rowExpected_one, hiderStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change rowExpected hiderStar 2 = 12 / 13
    norm_num [rowExpected_two, hiderStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]
  · change rowExpected hiderStar 3 = 12 / 13
    norm_num [rowExpected_three, hiderStar, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem searcherStar_guarantee : guarantee searcherStar = 12 / 13 := by
  simp [guarantee, searcherStar_columns]

theorem hiderStar_cost : hiderCost hiderStar = 12 / 13 := by
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
    mixedPayoff searcherStar q = 12 / 13 := by
  simp only [mixedPayoff, searcherStar_columns, ← Finset.sum_mul, hq.2, one_mul]

theorem hiderStar_against_all (p : Action → ℝ) (hp : Probability p) :
    mixedPayoff p hiderStar = 12 / 13 := by
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
    guarantee p ≤ 12 / 13 := by
  simpa [hiderStar_against_all p hp] using guarantee_le_mixture p hiderStar hiderStar_probability

theorem all_hiders_lower_bound (q : Vertex → ℝ) (hq : Probability q) :
    12 / 13 ≤ hiderCost q := by
  simpa [searcherStar_against_all q hq] using mixture_le_hiderCost searcherStar q searcherStar_probability

theorem gameValue_exact : gameValue = 12 / 13 := by
  apply IsGreatest.csSup_eq
  constructor
  · exact ⟨searcherStar, searcherStar_probability, searcherStar_guarantee⟩
  · rintro t ⟨p, hp, rfl⟩
    exact all_searchers_upper_bound p hp

theorem hiderValue_exact : hiderValue = 12 / 13 := by
  apply IsLeast.csInf_eq
  constructor
  · exact ⟨hiderStar, hiderStar_probability, hiderStar_cost⟩
  · rintro t ⟨q, hq, rfl⟩
    exact all_hiders_lower_bound q hq

theorem searcher_optimum_unique (p : Action → ℝ) (hp : Probability p)
    (hopt : guarantee p = 12 / 13) : p = searcherStar := by
  have hcols := (le_guarantee_iff p (12 / 13)).1 hopt.ge
  have h0 := hcols 0
  have h1 := hcols 1
  have h2 := hcols 2
  have h3 := hcols 3
  have hsum := hp.2
  norm_num [expected_zero, expected_one, expected_two, expected_three, Fin.sum_univ_four,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff] at h0 h1 h2 h3 hsum
  funext a
  fin_cases a
  · change p 0 = 3 / 13
    linarith
  · change p 1 = 3 / 13
    linarith
  · change p 2 = 3 / 13
    linarith
  · change p 3 = 4 / 13
    linarith

theorem hider_optimum_unique (q : Vertex → ℝ) (hq : Probability q)
    (hopt : hiderCost q = 12 / 13) : q = hiderStar := by
  have hrows := (hiderCost_le_iff q (12 / 13)).1 hopt.le
  have h0 := hrows 0
  have h1 := hrows 1
  have h2 := hrows 2
  have h3 := hrows 3
  have hsum := hq.2
  norm_num [rowExpected_zero, rowExpected_one, rowExpected_two, rowExpected_three, Fin.sum_univ_four,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff] at h0 h1 h2 h3 hsum
  funext v
  fin_cases v
  · change q 0 = 4 / 13
    linarith
  · change q 1 = 3 / 13
    linarith
  · change q 2 = 3 / 13
    linarith
  · change q 3 = 3 / 13
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

/-- Exactly the 15 nonempty subsets of the four actual legal actions. -/
theorem nonempty_support_count :
    (Finset.univ.filter (fun support : Finset Action => support.Nonempty)).card = 15 := by
  decide

/-- Exhaustive proof for actual finite supports, with real reciprocal weights.
The empty set also has value zero by Lean's division convention, but is never
included among the admissible probability strategies. -/
theorem all_reciprocal_supports_bound (support : Finset Action) :
    guarantee (reciprocal support) ≤ 3 / 4 := by
  fin_cases support <;>
    norm_num [guarantee, expected_zero, expected_one, expected_two, expected_three,
      reciprocal, normalizer, inverseWeight, reward_formula, Fin.sum_univ_four,
      Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

noncomputable def attainingSupport : Finset Action := {0, 1, 3}

theorem attainingSupport_nonempty : attainingSupport.Nonempty := by decide

theorem reciprocal_attainment : guarantee (reciprocal attainingSupport) = 3 / 4 := by
  norm_num [guarantee, expected_zero, expected_one, expected_two, expected_three,
    reciprocal, normalizer, inverseWeight, attainingSupport, reward_formula, Fin.sum_univ_four,
    Fin.ext_iff, Fin.coe_ofNat_eq_mod, -Fin.val_eq_zero_iff]

theorem reciprocalValue_exact : reciprocalValue = 3 / 4 := by
  apply IsGreatest.csSup_eq
  constructor
  · exact ⟨attainingSupport, attainingSupport_nonempty, reciprocal_attainment⟩
  · rintro t ⟨support, _hne, rfl⟩
    exact all_reciprocal_supports_bound support

theorem strict_gap : gameValue - reciprocalValue = 9 / 52 := by
  rw [gameValue_exact, reciprocalValue_exact]
  norm_num

theorem exact_ratio : reciprocalValue / gameValue = 13 / 16 := by
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

end ReciprocalSearch.FourVertex

#print axioms ReciprocalSearch.FourVertex.gameValue_exact
#print axioms ReciprocalSearch.FourVertex.hiderValue_exact
#print axioms ReciprocalSearch.FourVertex.searcher_optimum_unique
#print axioms ReciprocalSearch.FourVertex.hider_optimum_unique
#print axioms ReciprocalSearch.FourVertex.reciprocal_probability
#print axioms ReciprocalSearch.FourVertex.reciprocal_positive_iff
#print axioms ReciprocalSearch.FourVertex.nonempty_support_count
#print axioms ReciprocalSearch.FourVertex.all_reciprocal_supports_bound
#print axioms ReciprocalSearch.FourVertex.reciprocal_attainment
#print axioms ReciprocalSearch.FourVertex.reciprocalValue_exact
#print axioms ReciprocalSearch.FourVertex.strict_gap
#print axioms ReciprocalSearch.FourVertex.exact_ratio
#print axioms ReciprocalSearch.FourVertex.every_reciprocal_strategy_suboptimal
