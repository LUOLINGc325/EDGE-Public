import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Lean.Elab.Tactic.Omega

/-!
# Conditional finite-prefix certificate for risk-sensitive ski rental

The row functional below is the finite positive-part expression obtained from
the normalized CVaR constraints.  This file proves comparison and uniqueness
directly from that expression.  Root construction and its interpretation as a
ski-rental problem are separate, explicit interfaces.
-/

namespace RiskSensitiveSkiRental

open scoped BigOperators

noncomputable def row (a : ℝ) (i : ℕ) (u : ℕ → ℝ) (t : ℝ) : ℝ :=
  a * min 1 t - ∑ j ∈ Finset.range i, max 0 (min 1 t - t + u j)

private theorem offset_antitone {s t : ℝ} (hst : s ≤ t) :
    min 1 t - t ≤ min 1 s - s := by
  rcases le_total t 1 with ht | ht
  · rw [min_eq_right ht, min_eq_right (le_trans hst ht)]
    linarith
  · rw [min_eq_left ht]
    rcases le_total s 1 with hs | hs
    · rw [min_eq_right hs]
      linarith
    · rw [min_eq_left hs]
      linarith

theorem row_mono_argument (a : ℝ) (ha : 0 ≤ a) (i : ℕ) (u : ℕ → ℝ)
    {s t : ℝ} (hst : s ≤ t) : row a i u s ≤ row a i u t := by
  have hm : min 1 s ≤ min 1 t := min_le_min_left 1 hst
  have hp := mul_le_mul_of_nonneg_left hm ha
  have hs : (∑ j ∈ Finset.range i, max 0 (min 1 t - t + u j)) ≤
      ∑ j ∈ Finset.range i, max 0 (min 1 s - s + u j) := by
    apply Finset.sum_le_sum
    intro j _
    apply max_le_max (le_refl 0)
    exact add_le_add_right (offset_antitone hst) (u j)
  unfold row
  linarith

theorem row_antitone_prefix (a : ℝ) (i : ℕ) (u x : ℕ → ℝ) (t : ℝ)
    (hprefix : ∀ j < i, x j ≤ u j) : row a i u t ≤ row a i x t := by
  have hs : (∑ j ∈ Finset.range i, max 0 (min 1 t - t + x j)) ≤
      ∑ j ∈ Finset.range i, max 0 (min 1 t - t + u j) := by
    apply Finset.sum_le_sum
    intro j hj
    apply max_le_max (le_refl 0)
    exact add_le_add_left (hprefix j (Finset.mem_range.mp hj)) _
  unfold row
  linarith

theorem row_strict_below_cap (a : ℝ) (ha : 0 < a) (i : ℕ) (u : ℕ → ℝ)
    {s t : ℝ} (hst : s < t) (hcap : row a i u s < a) :
    row a i u s < row a i u t := by
  by_cases hs : s < 1
  · have hm : min 1 s < min 1 t := by
      rw [min_eq_right (le_of_lt hs)]
      exact lt_min hs hst
    have hp := mul_lt_mul_of_pos_left hm ha
    have hsum : (∑ j ∈ Finset.range i, max 0 (min 1 t - t + u j)) ≤
        ∑ j ∈ Finset.range i, max 0 (min 1 s - s + u j) := by
      apply Finset.sum_le_sum
      intro j _
      apply max_le_max (le_refl 0)
      exact add_le_add_right (offset_antitone (le_of_lt hst)) (u j)
    unfold row
    linarith
  · have hs1 : 1 ≤ s := le_of_not_gt hs
    have ht1 : 1 ≤ t := le_trans hs1 (le_of_lt hst)
    have hsumpos : 0 < ∑ j ∈ Finset.range i, max 0 (1 - s + u j) := by
      unfold row at hcap
      rw [min_eq_left hs1] at hcap
      linarith
    have hex : ∃ j ∈ Finset.range i, 0 < max 0 (1 - s + u j) := by
      by_contra hn
      have hzero : (∑ j ∈ Finset.range i, max 0 (1 - s + u j)) = 0 := by
        apply Finset.sum_eq_zero
        intro j hj
        have hnot : ¬ 0 < max 0 (1 - s + u j) := fun h => hn ⟨j, hj, h⟩
        exact le_antisymm (le_of_not_gt hnot) (le_max_left _ _)
      linarith
    obtain ⟨j, hj, hjpos⟩ := hex
    have hjarg : 0 < 1 - s + u j := by
      by_contra hn
      rw [max_eq_left (le_of_not_gt hn)] at hjpos
      exact lt_irrefl 0 hjpos
    have hjstrict : max 0 (1 - t + u j) < max 0 (1 - s + u j) := by
      rw [max_eq_right (le_of_lt hjarg)]
      apply max_lt hjarg
      linarith
    have hsum : (∑ k ∈ Finset.range i, max 0 (1 - t + u k)) <
        ∑ k ∈ Finset.range i, max 0 (1 - s + u k) := by
      apply Finset.sum_lt_sum
      · intro k _
        apply max_le_max (le_refl 0)
        linarith
      · exact ⟨j, hj, hjstrict⟩
    unfold row
    rw [min_eq_left hs1, min_eq_left ht1]
    linarith

theorem root_upper_certificate (a : ℝ) (ha : 0 < a) (i : ℕ)
    (u x : ℕ → ℝ) (root t budget : ℝ)
    (hroot : row a i u root = budget) (hbudget : budget < a)
    (hprefix : ∀ j < i, x j ≤ u j)
    (hfeasible : row a i x t ≤ budget) : t ≤ root := by
  by_contra h
  have hlt : root < t := lt_of_not_ge h
  have hcap : row a i u root < a := by rw [hroot]; exact hbudget
  have hstrict := row_strict_below_cap a ha i u hlt hcap
  have hcompare := row_antitone_prefix a i u x t hprefix
  linarith

theorem cumulative_maximality (a : ℝ) (ha : 0 < a) (n : ℕ)
    (u x budget : ℕ → ℝ)
    (hroot : ∀ i < n, row a i u (u i) = budget i)
    (hbudget : ∀ i < n, budget i < a)
    (hfeasible : ∀ i < n, row a i x (x i) ≤ budget i) :
    ∀ i < n, x i ≤ u i := by
  intro i
  induction i using Nat.strong_induction_on with
  | h i ih =>
    intro hi
    apply root_upper_certificate a ha i u x (u i) (x i) (budget i)
      (hroot i hi) (hbudget i hi)
    · intro j hj
      exact ih j hj (lt_trans hj hi)
    · exact hfeasible i hi

theorem row_equality_forces_active_coordinate (a : ℝ) (i : ℕ)
    (u x : ℕ → ℝ) (t : ℝ)
    (hprefix : ∀ j < i, x j ≤ u j)
    (hrow : row a i x t ≤ row a i u t)
    (j : ℕ) (hj : j < i)
    (hactive : 0 < min 1 t - t + u j) : x j = u j := by
  by_contra hne
  have hxj : x j < u j := lt_of_le_of_ne (hprefix j hj) hne
  have hterm : max 0 (min 1 t - t + x j) < max 0 (min 1 t - t + u j) := by
    rw [max_eq_right (le_of_lt hactive)]
    apply max_lt hactive
    linarith
  have hsum : (∑ k ∈ Finset.range i, max 0 (min 1 t - t + x k)) <
      ∑ k ∈ Finset.range i, max 0 (min 1 t - t + u k) := by
    apply Finset.sum_lt_sum
    · intro k hk
      apply max_le_max (le_refl 0)
      exact add_le_add_left (hprefix k (Finset.mem_range.mp hk)) _
    · exact ⟨j, Finset.mem_range.mpr hj, hterm⟩
  unfold row at hrow
  linarith

theorem predecessor_active {previous next : ℝ}
    (hprevious : 0 < previous) (hstep : next < 1 + previous) :
    0 < min 1 next - next + previous := by
  rcases le_total next 1 with hn | hn
  · rw [min_eq_right hn]
    linarith
  · rw [min_eq_left hn]
    linarith

theorem cumulative_uniqueness (a : ℝ) (ha : 0 < a) (n : ℕ)
    (u x budget : ℕ → ℝ)
    (hroot : ∀ i < n, row a i u (u i) = budget i)
    (hbudget : ∀ i < n, budget i < a)
    (hfeasible : ∀ i < n, row a i x (x i) ≤ budget i)
    (hactive : ∀ i, i + 1 < n → 0 < min 1 (u (i + 1)) - u (i + 1) + u i)
    (hterminal : x (n - 1) = u (n - 1)) :
    ∀ i < n, x i = u i := by
  have hmax := cumulative_maximality a ha n u x budget hroot hbudget hfeasible
  have hback : ∀ i, i + 1 < n → x (i + 1) = u (i + 1) → x i = u i := by
    intro i hi heq
    apply row_equality_forces_active_coordinate a (i + 1) u x (u (i + 1))
    · intro j hj
      exact hmax j (lt_trans hj hi)
    · rw [hroot (i + 1) hi]
      simpa only [heq] using hfeasible (i + 1) hi
    · exact Nat.lt_succ_self i
    · exact hactive i hi
  intro i hi
  have hib : i ≤ n - 1 := by omega
  exact Nat.decreasingInduction (motive := fun k _ => x k = u k)
    (fun k hk hnext => hback k (by omega) hnext) hterminal hib

noncomputable def mass (q : ℝ) (u : ℕ → ℝ) (i : ℕ) : ℝ :=
  if i = 0 then q * u 0 else q * (u i - u (i - 1))

theorem mass_uniqueness (a : ℝ) (ha : 0 < a) (n : ℕ)
    (u x budget : ℕ → ℝ) (q : ℝ)
    (hroot : ∀ i < n, row a i u (u i) = budget i)
    (hbudget : ∀ i < n, budget i < a)
    (hfeasible : ∀ i < n, row a i x (x i) ≤ budget i)
    (hactive : ∀ i, i + 1 < n → 0 < min 1 (u (i + 1)) - u (i + 1) + u i)
    (hterminal : x (n - 1) = u (n - 1)) :
    ∀ i < n, mass q x i = mass q u i := by
  have heq := cumulative_uniqueness a ha n u x budget hroot hbudget
    hfeasible hactive hterminal
  intro i hi
  unfold mass
  split_ifs with hz
  · subst i
    rw [heq 0 hi]
  · rw [heq i hi, heq (i - 1) (by omega)]

theorem subcritical_ratio_lower_bound (a : ℝ) (ha : 0 < a) (n : ℕ) (hn : 0 < n)
    (u x : ℕ → ℝ) (target competing : ℝ)
    (hroot : ∀ i < n, row a i u (u i) = ((i : ℝ) + 1) * target)
    (hbudget : ∀ i < n, ((i : ℝ) + 1) * target < a)
    (hfeasible : ∀ i < n, row a i x (x i) ≤ ((i : ℝ) + 1) * competing)
    (hterminal : x (n - 1) = u (n - 1)) : target ≤ competing := by
  by_contra h
  have hlt : competing < target := lt_of_not_ge h
  have hfeasible' : ∀ i < n, row a i x (x i) ≤ ((i : ℝ) + 1) * target := by
    intro i hi
    have hi0 : 0 < (i : ℝ) + 1 := by exact_mod_cast Nat.zero_lt_succ i
    exact le_trans (hfeasible i hi)
      (le_of_lt (mul_lt_mul_of_pos_left hlt hi0))
  have hmax := cumulative_maximality a ha n u x
    (fun i => ((i : ℝ) + 1) * target) hroot hbudget hfeasible'
  have hlast : n - 1 < n := by omega
  have hprefix : ∀ j < n - 1, x j ≤ u j := by
    intro j hj
    exact hmax j (lt_trans hj hlast)
  have hcompare := row_antitone_prefix a (n - 1) u x (u (n - 1)) hprefix
  have hbound := hfeasible (n - 1) hlast
  rw [hterminal] at hbound
  rw [hroot (n - 1) hlast] at hcompare
  have hlast0 : 0 < ((n - 1 : ℕ) : ℝ) + 1 := by
    exact_mod_cast Nat.zero_lt_succ (n - 1)
  have hstrict := mul_lt_mul_of_pos_left hlt hlast0
  linarith

theorem normalized_optimality (a : ℝ) (ha : 0 < a) (n : ℕ) (hn : 0 < n)
    (u x : ℕ → ℝ) (target competing q : ℝ) (hq : 0 < q)
    (hroot : ∀ i < n, row a i u (u i) = ((i : ℝ) + 1) * target)
    (hbudget : ∀ i < n, ((i : ℝ) + 1) * target < a)
    (hfeasible : ∀ i < n, row a i x (x i) ≤ ((i : ℝ) + 1) * competing)
    (hunormalized : q * u (n - 1) = 1)
    (hxnormalized : q * x (n - 1) = 1) : target ≤ competing := by
  have hterminal : x (n - 1) = u (n - 1) := by
    apply mul_left_cancel₀ (ne_of_gt hq)
    exact hxnormalized.trans hunormalized.symm
  exact subcritical_ratio_lower_bound a ha n hn u x target competing hroot hbudget
    hfeasible hterminal

theorem normalized_mass_uniqueness (a : ℝ) (ha : 0 < a) (n : ℕ)
    (u x budget : ℕ → ℝ) (q : ℝ) (hq : 0 < q)
    (hroot : ∀ i < n, row a i u (u i) = budget i)
    (hbudget : ∀ i < n, budget i < a)
    (hfeasible : ∀ i < n, row a i x (x i) ≤ budget i)
    (hpositive : ∀ i, i + 1 < n → 0 < u i)
    (hstep : ∀ i, i + 1 < n → u (i + 1) < 1 + u i)
    (hunormalized : q * u (n - 1) = 1)
    (hxnormalized : q * x (n - 1) = 1) :
    ∀ i < n, mass q x i = mass q u i := by
  have hterminal : x (n - 1) = u (n - 1) := by
    apply mul_left_cancel₀ (ne_of_gt hq)
    exact hxnormalized.trans hunormalized.symm
  apply mass_uniqueness a ha n u x budget q hroot hbudget hfeasible
  · intro i hi
    exact predecessor_active (hpositive i hi) (hstep i hi)
  · exact hterminal

#print axioms row_mono_argument
#print axioms row_antitone_prefix
#print axioms row_strict_below_cap
#print axioms root_upper_certificate
#print axioms cumulative_maximality
#print axioms row_equality_forces_active_coordinate
#print axioms predecessor_active
#print axioms cumulative_uniqueness
#print axioms mass_uniqueness
#print axioms subcritical_ratio_lower_bound
#print axioms normalized_optimality
#print axioms normalized_mass_uniqueness

end RiskSensitiveSkiRental
