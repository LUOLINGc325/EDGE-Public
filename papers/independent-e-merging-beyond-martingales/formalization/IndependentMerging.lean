import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FieldSimp

/-!
Algebraic certificate for an independent e-value merger.

This file proves the real inequalities, exact scalar mean identity, and finite
separation witness. It does NOT formalize probability measures, independence,
expectation factorization, admissibility, or arbitrary probability mixtures.
Those links are proved in the accompanying mathematical manuscript.
-/

namespace IndependentMerging

def merger (x y : ℝ) : ℝ :=
  1 + max (x - 1) 0 * max (y - 1) 0 -
    max (1 - x) 0 * max (1 - y) 0

theorem merger_symmetric (x y : ℝ) : merger x y = merger y x := by
  unfold merger
  ring

theorem merger_low_low {x y : ℝ} (hx : x ≤ 1) (hy : y ≤ 1) :
    merger x y = x + y - x * y := by
  have hx0 : x - 1 ≤ 0 := sub_nonpos.mpr hx
  have hy0 : y - 1 ≤ 0 := sub_nonpos.mpr hy
  have hx1 : 0 ≤ 1 - x := sub_nonneg.mpr hx
  have hy1 : 0 ≤ 1 - y := sub_nonneg.mpr hy
  simp only [merger, max_eq_right hx0, max_eq_right hy0,
    max_eq_left hx1, max_eq_left hy1]
  ring

theorem merger_low_high {x y : ℝ} (hx : x ≤ 1) (hy : 1 ≤ y) :
    merger x y = 1 := by
  have hx0 : x - 1 ≤ 0 := sub_nonpos.mpr hx
  have hy0 : 1 - y ≤ 0 := sub_nonpos.mpr hy
  simp [merger, max_eq_right hx0, max_eq_right hy0]

theorem merger_high_low {x y : ℝ} (hx : 1 ≤ x) (hy : y ≤ 1) :
    merger x y = 1 := by
  rw [merger_symmetric]
  exact merger_low_high hy hx

theorem merger_high_high {x y : ℝ} (hx : 1 ≤ x) (hy : 1 ≤ y) :
    merger x y = 1 + (x - 1) * (y - 1) := by
  have hx0 : 1 - x ≤ 0 := sub_nonpos.mpr hx
  have hy0 : 1 - y ≤ 0 := sub_nonpos.mpr hy
  have hx1 : 0 ≤ x - 1 := sub_nonneg.mpr hx
  have hy1 : 0 ≤ y - 1 := sub_nonneg.mpr hy
  simp [merger, max_eq_right hx0, max_eq_right hy0,
    max_eq_left hx1, max_eq_left hy1]

theorem merger_nonnegative {x y : ℝ} (hx0 : 0 ≤ x) (hy0 : 0 ≤ y) :
    0 ≤ merger x y := by
  rcases le_total x 1 with hx | hx
  · rcases le_total y 1 with hy | hy
    · rw [merger_low_low hx hy]
      nlinarith [mul_nonneg hx0 (sub_nonneg.mpr hy)]
    · rw [merger_low_high hx hy]
      norm_num
  · rcases le_total y 1 with hy | hy
    · rw [merger_high_low hx hy]
      norm_num
    · rw [merger_high_high hx hy]
      nlinarith [mul_nonneg (sub_nonneg.mpr hx) (sub_nonneg.mpr hy)]

theorem merger_upper_bound {x y : ℝ} (hx0 : 0 ≤ x) (hy0 : 0 ≤ y) :
    merger x y ≤ 1 + x * y := by
  have hx : max (x - 1) 0 ≤ x := max_le (by linarith) hx0
  have hy : max (y - 1) 0 ≤ y := max_le (by linarith) hy0
  have hp := mul_le_mul hx hy (le_max_right (y - 1) 0) hx0
  have hn := mul_nonneg (le_max_right (1 - x) 0) (le_max_right (1 - y) 0)
  unfold merger
  linarith

theorem merger_monotone_left {x x' y : ℝ} (hxx : x ≤ x') :
    merger x y ≤ merger x' y := by
  have hp : max (x - 1) 0 ≤ max (x' - 1) 0 :=
    max_le_max (sub_le_sub_right hxx 1) le_rfl
  have hn : max (1 - x') 0 ≤ max (1 - x) 0 :=
    max_le_max (sub_le_sub_left hxx 1) le_rfl
  have hp' := mul_le_mul_of_nonneg_right hp (le_max_right (y - 1) 0)
  have hn' := mul_le_mul_of_nonneg_right hn (le_max_right (1 - y) 0)
  unfold merger
  linarith

theorem merger_monotone_right {x y y' : ℝ} (hyy : y ≤ y') :
    merger x y ≤ merger x y' := by
  rw [merger_symmetric x y, merger_symmetric x y']
  exact merger_monotone_left hyy

theorem scalar_validity {aX bX aY bY : ℝ}
    (hbX : 0 ≤ bX) (hbY : 0 ≤ bY)
    (hX : bX ≤ aX) (hY : bY ≤ aY) :
    1 + bX * bY - aX * aY ≤ 1 := by
  have hprod : bX * bY ≤ aX * aY := mul_le_mul hX hY hbY (le_trans hbX hX)
  linarith

theorem scalar_precision {aX bX aY bY : ℝ}
    (hX : aX = bX) (hY : aY = bY) :
    1 + bX * bY - aX * aY = 1 := by
  rw [hX, hY]
  ring

/-- A deterministic first-coordinate-first gambling strategy satisfies the
three-point inequality. Here a is its first stake, b its second stake after
seeing 3, and c its second stake after seeing 1. -/
theorem strategy_three_point_bound {a b c : ℝ}
    (ha0 : 0 ≤ a) (hb1 : b ≤ 1) (hc0 : 0 ≤ c) :
    (1 + 2 * a) * (1 + 2 * b) + 6 * (1 - a) + 6 * (1 - c) ≤ 15 := by
  have hprod := mul_nonneg (show 0 ≤ 1 + 2 * a by linarith)
    (show 0 ≤ 1 - b by linarith)
  nlinarith

/-- A finite two-order convex mixture inherits the three-point bound. -/
theorem mixture_three_point_bound {p A B : ℝ}
    (hp0 : 0 ≤ p) (hp1 : p ≤ 1) (hA : A ≤ 15) (hB : B ≤ 15) :
    p * A + (1 - p) * B ≤ 15 := by
  have hA' := mul_nonneg hp0 (show 0 ≤ 15 - A by linarith)
  have hB' := mul_nonneg (show 0 ≤ 1 - p by linarith)
    (show 0 ≤ 15 - B by linarith)
  nlinarith

theorem merger_three_point_value :
    merger 3 3 + 6 * merger 0 1 + 6 * merger 1 0 = 17 := by
  norm_num [merger]

/-- This is the algebraic incompatibility. The probabilistic proof separately
establishes that every generalized martingale merger satisfies the hypothesis. -/
theorem no_three_point_match (H : ℝ → ℝ → ℝ)
    (hH : H 3 3 + 6 * H 0 1 + 6 * H 1 0 ≤ 15)
    (h33 : H 3 3 = merger 3 3)
    (h01 : H 0 1 = merger 0 1)
    (h10 : H 1 0 = merger 1 0) : False := by
  rw [h33, h01, h10, merger_three_point_value] at hH
  norm_num at hH

theorem no_three_point_domination (H : ℝ → ℝ → ℝ)
    (hH : H 3 3 + 6 * H 0 1 + 6 * H 1 0 ≤ 15)
    (h33 : merger 3 3 ≤ H 3 3)
    (h01 : merger 0 1 ≤ H 0 1)
    (h10 : merger 1 0 ≤ H 1 0) : False := by
  have hF := merger_three_point_value
  linarith

noncomputable def twoThirdsHedger (x y : ℝ) : ℝ :=
  1 + ((x - 1) + (y - 1)) / 3 +
    (max (x - 1) 0 * (y - 1) + max (y - 1) 0 * (x - 1)) / 3

/-- The explicit algebraic payoff attains pointwise factor 2/3. Its gambling
representation is separately checked below, but its expectation is not
formalized here. -/
theorem two_thirds_majorization {x y : ℝ} (hx0 : 0 ≤ x) (hy0 : 0 ≤ y) :
    (2 / 3 : ℝ) * merger x y ≤ twoThirdsHedger x y := by
  rcases le_total x 1 with hx | hx
  · rcases le_total y 1 with hy | hy
    · rw [merger_low_low hx hy]
      have hx1 : x - 1 ≤ 0 := sub_nonpos.mpr hx
      have hy1 : y - 1 ≤ 0 := sub_nonpos.mpr hy
      simp only [twoThirdsHedger, max_eq_right hx1, max_eq_right hy1]
      have h1 := mul_nonneg hx0 hy0
      have h2 := mul_nonneg (sub_nonneg.mpr hx) (sub_nonneg.mpr hy)
      nlinarith
    · rw [merger_low_high hx hy]
      have hx1 : x - 1 ≤ 0 := sub_nonpos.mpr hx
      have hy1 : 0 ≤ y - 1 := sub_nonneg.mpr hy
      simp only [twoThirdsHedger, max_eq_right hx1, max_eq_left hy1]
      nlinarith [mul_nonneg hx0 hy0]
  · rcases le_total y 1 with hy | hy
    · rw [merger_high_low hx hy]
      have hx1 : 0 ≤ x - 1 := sub_nonneg.mpr hx
      have hy1 : y - 1 ≤ 0 := sub_nonpos.mpr hy
      simp only [twoThirdsHedger, max_eq_left hx1, max_eq_right hy1]
      nlinarith [mul_nonneg hx0 hy0]
    · rw [merger_high_high hx hy]
      have hx1 : 0 ≤ x - 1 := sub_nonneg.mpr hx
      have hy1 : 0 ≤ y - 1 := sub_nonneg.mpr hy
      simp only [twoThirdsHedger, max_eq_left hx1, max_eq_left hy1]
      nlinarith

noncomputable def secondStake (z : ℝ) : ℝ := 2 * max (z - 1) 0 / (1 + 2 * z)

theorem second_stake_bounds {z : ℝ} (hz : 0 ≤ z) :
    0 ≤ secondStake z ∧ secondStake z ≤ 1 := by
  have hden : 0 < 1 + 2 * z := by linarith
  have hmax : max (z - 1) 0 ≤ z := max_le (by linarith) hz
  constructor
  · unfold secondStake
    exact div_nonneg (mul_nonneg (by norm_num) (le_max_right (z - 1) 0))
      (le_of_lt hden)
  · unfold secondStake
    apply (div_le_one hden).2
    linarith

theorem first_factor_stake_identity {z : ℝ} (hz : 0 ≤ z) :
    (1 + (2 / 3 : ℝ) * (z - 1)) * secondStake z =
      (2 / 3 : ℝ) * max (z - 1) 0 := by
  have hden : 1 + 2 * z ≠ 0 := ne_of_gt (by linarith)
  unfold secondStake
  field_simp
  nlinarith

theorem hedger_gambling_representation {x y : ℝ} (hx0 : 0 ≤ x) (hy0 : 0 ≤ y) :
    (1 / 2 : ℝ) * ((1 + (2 / 3 : ℝ) * (x - 1)) *
      (1 + secondStake x * (y - 1))) +
    (1 / 2 : ℝ) * ((1 + (2 / 3 : ℝ) * (y - 1)) *
      (1 + secondStake y * (x - 1))) = twoThirdsHedger x y := by
  have hx := first_factor_stake_identity hx0
  have hy := first_factor_stake_identity hy0
  unfold twoThirdsHedger
  nlinarith [congrArg (fun z : ℝ => z * (y - 1)) hx,
    congrArg (fun z : ℝ => z * (x - 1)) hy]

/-- The coefficient constraints produced by the paper's whole-domain argument
force the optimal efficiency to be at most 2/3. Obtaining these constraints
from limits and stochastic mixtures remains part of the written proof. -/
theorem efficiency_upper_bound {c A B : ℝ}
    (hA : A ≤ 1 - c) (hB : B ≤ 1 - c) (hAB : c ≤ A + B) :
    c ≤ (2 / 3 : ℝ) := by
  linarith

end IndependentMerging

#print axioms IndependentMerging.merger_symmetric
#print axioms IndependentMerging.merger_low_low
#print axioms IndependentMerging.merger_low_high
#print axioms IndependentMerging.merger_high_low
#print axioms IndependentMerging.merger_high_high
#print axioms IndependentMerging.merger_nonnegative
#print axioms IndependentMerging.merger_upper_bound
#print axioms IndependentMerging.merger_monotone_left
#print axioms IndependentMerging.merger_monotone_right
#print axioms IndependentMerging.scalar_validity
#print axioms IndependentMerging.scalar_precision
#print axioms IndependentMerging.strategy_three_point_bound
#print axioms IndependentMerging.mixture_three_point_bound
#print axioms IndependentMerging.merger_three_point_value
#print axioms IndependentMerging.no_three_point_match
#print axioms IndependentMerging.no_three_point_domination
#print axioms IndependentMerging.two_thirds_majorization
#print axioms IndependentMerging.second_stake_bounds
#print axioms IndependentMerging.first_factor_stake_identity
#print axioms IndependentMerging.hedger_gambling_representation
#print axioms IndependentMerging.efficiency_upper_bound
