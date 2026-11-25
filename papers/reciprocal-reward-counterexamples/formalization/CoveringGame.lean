import FiniteRewardGame
import ActiveConstraints
import Mathlib.Analysis.Convex.Topology
import Mathlib.Tactic.Linarith

/-! The positive reciprocal-reward covering linear program in Theorem 4. -/

set_option autoImplicit false
open Finset Set

namespace ReciprocalSearch.RewardGame

variable {A H : Type*} [Fintype A] [Fintype H]

noncomputable section
open Classical

def coverCoeff (g : RewardGame A H) (h : H) (a : A) : ℝ :=
  if g.safe a h then -1 else 0

def coverage (g : RewardGame A H) (x : A → ℝ) (h : H) : ℝ :=
  ∑ a ∈ univ.filter (fun a => g.safe a h), x a

omit [Fintype H] in
lemma cover_row (g : RewardGame A H) (x : A → ℝ) (h : H) :
    Active.row (g.coverCoeff h) x = -g.coverage x h := by
  unfold Active.row coverCoeff coverage
  simp only [ite_mul, neg_one_mul, zero_mul]
  rw [← sum_filter, sum_neg_distrib]

def coverFeasible (g : RewardGame A H) : Set (A → ℝ) :=
  Active.feasible g.coverCoeff (fun _ => -1)

omit [Fintype H] in
lemma cover_feasible_iff (g : RewardGame A H) (x : A → ℝ) :
    x ∈ g.coverFeasible ↔ (∀ a, 0 ≤ x a) ∧ ∀ h, 1 ≤ g.coverage x h := by
  change (∀ a, 0 ≤ x a) ∧ (∀ h, Active.row (g.coverCoeff h) x ≤ -1) ↔ _
  simp [cover_row, neg_le_neg_iff]

def coverCost (g : RewardGame A H) (x : A → ℝ) : ℝ :=
  Active.row (fun a => 1 / g.reward a) x

def coverVector (g : RewardGame A H) (p : A → ℝ) (v : ℝ) (a : A) : ℝ :=
  (p a * g.reward a) / v

omit [Fintype H] in
lemma cover_from_guarantee (g : RewardGame A H) (p : A → ℝ) (hp : Probability p)
    (v : ℝ) (hv : 0 < v) (hg : ∀ h, v ≤ g.expected p h) :
    g.coverVector p v ∈ g.coverFeasible ∧ g.coverCost (g.coverVector p v) = 1 / v := by
  constructor
  · apply (g.cover_feasible_iff _).mpr
    refine ⟨fun a => div_nonneg (mul_nonneg (hp.1 a) (g.reward_pos a).le) hv.le, ?_⟩
    intro h
    unfold coverage coverVector
    rw [← sum_div, le_div_iff₀ hv, one_mul]
    convert hg h using 1
    unfold expected
    rw [sum_filter]
    apply sum_congr rfl
    intro a _
    by_cases ha : g.safe a h <;> simp [RewardGame.payoff, ha]
  · unfold coverCost Active.row coverVector
    have hterm (a : A) : 1 / g.reward a * (p a * g.reward a / v) = p a / v := by
      field_simp [(g.reward_pos a).ne', hv.ne']
    simp_rw [hterm, ← sum_div, hp.2]

omit [Fintype H] in
theorem exists_extreme_minimum_cover (g : RewardGame A H) {z : A → ℝ}
    (hz : z ∈ g.coverFeasible) :
    ∃ x ∈ g.coverFeasible.extremePoints ℝ,
      ∀ y ∈ g.coverFeasible, g.coverCost x ≤ g.coverCost y := by
  let l := -Active.rowFunctional (fun a => 1 / g.reward a)
  have hl (x : A → ℝ) : l x = -g.coverCost x := by
    simp [l, Active.rowFunctional_apply, coverCost]
  let U := {x ∈ g.coverFeasible | l z ≤ l x}
  have hc : IsCompact U := by
    apply (isCompact_Icc (a := (0 : A → ℝ))
      (b := fun a => g.coverCost z / (1 / g.reward a))).of_isClosed_subset
    · exact (Active.feasible_closed _ _).inter (isClosed_le continuous_const l.continuous)
    · rintro x ⟨hx, hcost⟩
      have hp := ((g.cover_feasible_iff x).mp hx).1
      refine ⟨hp, fun a => ?_⟩
      apply (le_div_iff₀ (one_div_pos.mpr (g.reward_pos a))).mpr
      rw [mul_comm]
      have hsingle : (1 / g.reward a) * x a ≤ g.coverCost x :=
        single_le_sum (fun i _ => mul_nonneg (one_div_pos.mpr (g.reward_pos i)).le (hp i)) (mem_univ a)
      rw [hl, hl, neg_le_neg_iff] at hcost
      exact hsingle.trans hcost
  obtain ⟨x, hx, hmin⟩ := Active.extreme_maximizer_of_compact_superlevel l hz hc
  refine ⟨x, hx, fun y hy => ?_⟩
  simpa only [hl, neg_le_neg_iff] using hmin y hy

variable [Nonempty H]

omit [Fintype H] in
lemma cover_cost_pos (g : RewardGame A H) {x : A → ℝ} (hx : x ∈ g.coverFeasible) :
    0 < g.coverCost x := by
  obtain ⟨h⟩ := ‹Nonempty H›
  obtain ⟨hp, hc⟩ := (g.cover_feasible_iff x).mp hx
  apply sum_pos'
  · intro a _
    exact mul_nonneg (one_div_pos.mpr (g.reward_pos a)).le (hp a)
  · by_contra! hn
    have hz : g.coverage x h = 0 := by
      apply sum_eq_zero
      intro a _
      have hna := hn a (mem_univ a)
      have hn' : ¬0 < x a := fun ha =>
        not_lt_of_ge hna (mul_pos (one_div_pos.mpr (g.reward_pos a)) ha)
      linarith [hp a]
    linarith [hc h]

def probabilityFromCover (g : RewardGame A H) (x : A → ℝ) (a : A) : ℝ :=
  ((1 / g.reward a) * x a) / g.coverCost x

theorem guarantee_from_cover (g : RewardGame A H) {x : A → ℝ} (hx : x ∈ g.coverFeasible) :
    Probability (g.probabilityFromCover x) ∧
      1 / g.coverCost x ≤ g.guarantee (g.probabilityFromCover x) := by
  have hc := g.cover_cost_pos hx
  have hfe := (g.cover_feasible_iff x).mp hx
  constructor
  · constructor
    · intro a
      exact div_nonneg (mul_nonneg (one_div_pos.mpr (g.reward_pos a)).le (hfe.1 a)) hc.le
    · unfold probabilityFromCover
      rw [← sum_div, ← Active.row, ← coverCost, div_self hc.ne']
  · apply (g.le_guarantee_iff _ _).mpr
    intro h
    have he : g.expected (g.probabilityFromCover x) h = g.coverage x h / g.coverCost x := by
      unfold expected coverage
      rw [sum_div, sum_filter]
      apply sum_congr rfl
      intro a _
      by_cases ha : g.safe a h
      · simp only [probabilityFromCover, RewardGame.payoff, ha, if_true]
        field_simp [(g.reward_pos a).ne', hc.ne']
        ring
      · simp [RewardGame.payoff, ha]
    rw [he]
    exact div_le_div_of_nonneg_right (hfe.2 h) hc.le

theorem optimum_from_minimum_cover (g : RewardGame A H) {x : A → ℝ} (hx : x ∈ g.coverFeasible)
    (hmin : ∀ y ∈ g.coverFeasible, g.coverCost x ≤ g.coverCost y) :
    g.value = 1 / g.coverCost x ∧ g.guarantee (g.probabilityFromCover x) = g.value := by
  have hxpos := g.cover_cost_pos hx
  obtain ⟨hp, hg⟩ := g.guarantee_from_cover hx
  have hu (p : A → ℝ) (hprob : Probability p) : g.guarantee p ≤ 1 / g.coverCost x := by
    by_cases h : 0 < g.guarantee p
    · obtain ⟨hfe, hc⟩ := g.cover_from_guarantee p hprob _ h (g.guarantee_le_expected p)
      have hm := hmin _ hfe
      rw [hc] at hm
      exact (le_div_iff₀ hxpos).mpr (by
        rw [mul_comm]
        exact (le_div_iff₀ h).mp hm)
    · exact (le_of_not_gt h).trans (one_div_pos.mpr hxpos).le
  have hval : g.value = 1 / g.coverCost x := by
    apply IsGreatest.csSup_eq
    exact ⟨⟨g.probabilityFromCover x, hp, le_antisymm (hu _ hp) hg⟩,
      fun _ ⟨p, hp', ht⟩ => ht ▸ hu p hp'⟩
  exact ⟨hval, hval ▸ le_antisymm (hu _ hp) hg⟩

end
end ReciprocalSearch.RewardGame
