import Mathlib.Data.Real.Archimedean
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Fintype.Order
import Mathlib.Tactic.Ring

/-!
# Finite reward search games

Each permitted action has a reward and a predicate saying which trap
configurations avoid that action. Hypergraphs instantiate the predicate by
disjointness of the actual sets.
-/

set_option autoImplicit false
open Finset

namespace ReciprocalSearch

structure RewardGame (Action Trap : Type*) where
  reward : Action → ℝ
  safe : Action → Trap → Prop
  reward_pos : ∀ a, 0 < reward a

namespace RewardGame

variable {A H : Type*} [Fintype A] [Fintype H] [Nonempty H]

noncomputable section
open Classical

def payoff (g : RewardGame A H) (a : A) (h : H) : ℝ :=
  if g.safe a h then g.reward a else 0

def expected (g : RewardGame A H) (p : A → ℝ) (h : H) : ℝ :=
  ∑ a, p a * g.payoff a h

def rowExpected (g : RewardGame A H) (q : H → ℝ) (a : A) : ℝ :=
  ∑ h, q h * g.payoff a h

omit [Nonempty H] in
theorem mixed_expected_swap (g : RewardGame A H) (p : A → ℝ) (q : H → ℝ) :
    ∑ h, q h * g.expected p h = ∑ a, p a * g.rowExpected q a := by
  unfold expected rowExpected
  simp_rw [mul_sum]
  rw [sum_comm]
  apply sum_congr rfl
  intro a _
  apply sum_congr rfl
  intro h _
  ring

def Probability {X : Type*} [Fintype X] (p : X → ℝ) : Prop :=
  (∀ x, 0 ≤ p x) ∧ ∑ x, p x = 1

def guarantee (g : RewardGame A H) (p : A → ℝ) : ℝ :=
  univ.inf' univ_nonempty (g.expected p)

theorem le_guarantee_iff (g : RewardGame A H) (p : A → ℝ) (t : ℝ) :
    t ≤ g.guarantee p ↔ ∀ h, t ≤ g.expected p h := by
  simp [guarantee, le_inf'_iff]

theorem guarantee_le_expected (g : RewardGame A H) (p : A → ℝ) (h : H) :
    g.guarantee p ≤ g.expected p h :=
  (g.le_guarantee_iff p _).mp le_rfl h

theorem exists_guarantee_trap (g : RewardGame A H) (p : A → ℝ) :
    ∃ h, g.guarantee p = g.expected p h := by
  obtain ⟨h, _, heq⟩ := exists_mem_eq_inf' univ_nonempty (g.expected p)
  exact ⟨h, heq⟩

def value (g : RewardGame A H) : ℝ :=
  sSup {t | ∃ p, Probability p ∧ g.guarantee p = t}

theorem guarantee_le_value (g : RewardGame A H) (p : A → ℝ) (hp : Probability p) :
    g.guarantee p ≤ g.value := by
  have hbound : BddAbove {t | ∃ q, Probability q ∧ g.guarantee q = t} := by
    refine ⟨∑ a, g.reward a, ?_⟩
    rintro t ⟨q, hq, rfl⟩
    obtain ⟨h⟩ := ‹Nonempty H›
    refine (g.guarantee_le_expected q h).trans (sum_le_sum fun a _ => ?_)
    have hq1 : q a ≤ 1 := by
      rw [← hq.2]
      exact single_le_sum (fun i _ => hq.1 i) (mem_univ a)
    unfold payoff
    split_ifs
    · exact mul_le_of_le_one_left (g.reward_pos a).le hq1
    · simpa using (g.reward_pos a).le
  exact le_csSup hbound ⟨p, hp, rfl⟩

theorem value_of_equalizing (g : RewardGame A H) (p : A → ℝ) (q : H → ℝ)
    (hp : Probability p) (hq : Probability q) (t : ℝ)
    (hpcol : ∀ h, g.expected p h = t) (hqrow : ∀ a, g.rowExpected q a = t) :
    g.value = t := by
  apply IsGreatest.csSup_eq
  constructor
  · refine ⟨p, hp, le_antisymm ?_ ((g.le_guarantee_iff p t).mpr fun h => (hpcol h).ge)⟩
    obtain ⟨h⟩ := ‹Nonempty H›
    rw [← hpcol h]
    exact g.guarantee_le_expected p h
  · rintro b ⟨r, hr, rfl⟩
    calc
      g.guarantee r = ∑ h, q h * g.guarantee r := by rw [← sum_mul, hq.2, one_mul]
      _ ≤ ∑ h, q h * g.expected r h :=
        sum_le_sum fun h _ => mul_le_mul_of_nonneg_left (g.guarantee_le_expected r h) (hq.1 h)
      _ = t := by rw [g.mixed_expected_swap]; simp_rw [hqrow, ← sum_mul, hr.2, one_mul]

theorem optimal_columns_eq_of_full_support (g : RewardGame A H) (p : A → ℝ) (q : H → ℝ)
    (hp : Probability p) (hq : Probability q) (hqpos : ∀ h, 0 < q h) (t : ℝ)
    (hbound : t ≤ g.guarantee p) (hqrow : ∀ a, g.rowExpected q a = t) :
    ∀ h, g.expected p h = t := by
  have hnonneg h : 0 ≤ q h * (g.expected p h - t) :=
    mul_nonneg (hq.1 h) (sub_nonneg.mpr (hbound.trans (g.guarantee_le_expected p h)))
  have hsum : (∑ h, q h * (g.expected p h - t)) = 0 := by
    simp only [mul_sub, sum_sub_distrib, g.mixed_expected_swap]
    simp_rw [hqrow, ← sum_mul, hp.2, hq.2, one_mul, sub_self]
  intro h
  have hh := single_le_sum (fun i _ => hnonneg i) (mem_univ h)
  rw [hsum] at hh
  have hz := le_antisymm hh (hnonneg h)
  exact sub_eq_zero.mp ((mul_eq_zero.mp hz).resolve_left (hqpos h).ne')

def normalizer (g : RewardGame A H) (s : Finset A) : ℝ :=
  ∑ a ∈ s, 1 / g.reward a

omit [Fintype A] [Fintype H] [Nonempty H] in
theorem normalizer_pos (g : RewardGame A H) {s : Finset A} (hs : s.Nonempty) :
    0 < g.normalizer s :=
  sum_pos (fun a _ => one_div_pos.mpr (g.reward_pos a)) hs

def reciprocal (g : RewardGame A H) (s : Finset A) (a : A) : ℝ :=
  if a ∈ s then (1 / g.reward a) / g.normalizer s else 0

omit [Fintype H] [Nonempty H] in
theorem reciprocal_probability (g : RewardGame A H) {s : Finset A} (hs : s.Nonempty) :
    Probability (g.reciprocal s) := by
  constructor
  · intro a
    unfold reciprocal
    split_ifs
    · exact div_nonneg (one_div_pos.mpr (g.reward_pos a)).le (g.normalizer_pos hs).le
    · exact le_rfl
  · unfold reciprocal
    rw [← sum_filter, filter_univ_mem, ← sum_div]
    exact div_self (ne_of_gt (g.normalizer_pos hs))

omit [Fintype H] [Nonempty H] in
theorem reciprocal_expected (g : RewardGame A H) (s : Finset A) (h : H) :
    g.expected (g.reciprocal s) h = (s.filter fun a => g.safe a h).card / g.normalizer s := by
  classical
  unfold expected
  calc
    _ = ∑ a ∈ s.filter (fun a => g.safe a h), g.reciprocal s a * g.payoff a h := by
      symm
      apply sum_subset (subset_univ _)
      intro a _ ha
      by_cases has : a ∈ s
      · have hn : ¬g.safe a h := fun hh => ha (mem_filter.mpr ⟨has, hh⟩)
        simp [payoff, hn]
      · simp [reciprocal, has]
    _ = ∑ _ ∈ s.filter (fun a => g.safe a h), 1 / g.normalizer s := by
      apply sum_congr rfl
      intro a ha
      obtain ⟨has, hh⟩ := mem_filter.mp ha
      simp only [reciprocal, payoff, if_pos has, if_pos hh]
      calc
        (1 / g.reward a) / g.normalizer s * g.reward a =
            ((1 / g.reward a) * g.reward a) / g.normalizer s := by ring
        _ = _ := by rw [one_div_mul_cancel (g.reward_pos a).ne']
    _ = _ := by simp [div_eq_mul_inv]

def reciprocalValue (g : RewardGame A H) : ℝ :=
  sSup {t | ∃ s : Finset A, s.Nonempty ∧ g.guarantee (g.reciprocal s) = t}

theorem reciprocal_guarantee_le_value (g : RewardGame A H) (s : Finset A) (hs : s.Nonempty) :
    g.guarantee (g.reciprocal s) ≤ g.reciprocalValue := by
  let candidates : Set ℝ := {t | ∃ f : Finset A, f.Nonempty ∧ g.guarantee (g.reciprocal f) = t}
  have hbounded : BddAbove candidates := by
    refine ⟨g.value, ?_⟩
    intro t ht
    change (∃ f : Finset A, f.Nonempty ∧ g.guarantee (g.reciprocal f) = t) at ht
    obtain ⟨f, hf, rfl⟩ := ht
    exact g.guarantee_le_value (g.reciprocal f) (g.reciprocal_probability hf)
  have hmem : g.guarantee (g.reciprocal s) ∈ candidates := ⟨s, hs, rfl⟩
  exact le_csSup hbounded hmem

theorem reciprocal_value_le [Nonempty A] (g : RewardGame A H) (b : ℝ)
    (h : ∀ s : Finset A, s.Nonempty → g.guarantee (g.reciprocal s) ≤ b) :
    g.reciprocalValue ≤ b := by
  apply csSup_le
  · obtain ⟨a⟩ := ‹Nonempty A›
    exact ⟨g.guarantee (g.reciprocal {a}), {a}, singleton_nonempty a, rfl⟩
  · rintro t ⟨s, hs, rfl⟩
    exact h s hs

/-- Comparison on exactly the same admissible search and trap sets.
The fixed-searcher guarantee scales from below and every reciprocal support
scales from above. -/
theorem perturbation_bounds [Nonempty A] (g g' : RewardGame A H)
    (hsafe : ∀ a h, g'.safe a h ↔ g.safe a h)
    (l u : ℝ) (hl : 0 ≤ l) (hu : 0 < u)
    (hlo : ∀ a, l * g.reward a ≤ g'.reward a)
    (hhi : ∀ a, g'.reward a ≤ u * g.reward a)
    (p : A → ℝ) (hp : Probability p) (b : ℝ)
    (hb : ∀ s : Finset A, s.Nonempty → g.guarantee (g.reciprocal s) ≤ b) :
    l * g.guarantee p ≤ g'.value ∧ g'.reciprocalValue ≤ u * b := by
  constructor
  · apply le_trans _ (g'.guarantee_le_value p hp)
    apply (g'.le_guarantee_iff p _).mpr
    intro h
    apply (mul_le_mul_of_nonneg_left (g.guarantee_le_expected p h) hl).trans
    unfold expected
    rw [mul_sum]
    apply sum_le_sum
    intro a _
    rw [mul_left_comm l (p a)]
    apply mul_le_mul_of_nonneg_left _ (hp.1 a)
    simp only [payoff, hsafe]
    split_ifs
    · exact hlo a
    · rw [mul_zero]
  · apply g'.reciprocal_value_le
    intro s hs
    have hnorm : g.normalizer s / u ≤ g'.normalizer s := by
      unfold normalizer
      rw [sum_div]
      apply sum_le_sum
      intro a _
      rw [div_div, mul_comm (g.reward a) u]
      exact one_div_le_one_div_of_le (g'.reward_pos a) (hhi a)
    obtain ⟨h, hh⟩ := g.exists_guarantee_trap (g.reciprocal s)
    apply (g'.guarantee_le_expected _ h).trans
    have hcard : (s.filter (fun a => g'.safe a h)).card =
        (s.filter (fun a => g.safe a h)).card := by
      congr 1
      ext a
      simp [hsafe]
    rw [g'.reciprocal_expected, hcard]
    apply le_trans _ (mul_le_mul_of_nonneg_left (hb s hs) hu.le)
    rw [hh, g.reciprocal_expected]
    rw [← mul_div_assoc, mul_comm u, ← div_div_eq_mul_div]
    exact div_le_div_of_nonneg_left (Nat.cast_nonneg _) (div_pos (g.normalizer_pos hs) hu) hnorm

end
end RewardGame
end ReciprocalSearch
