import FiniteFrontier
import Mathlib.Tactic.Positivity

/-! Equal-job recursion on the active branch of §3. -/

open scoped BigOperators

namespace FiniteFrontier

noncomputable def baselineRobustness (m : ℝ) : ℝ := 2 * m / (m + 1)

noncomputable def triangularCost (m : ℝ) : ℝ := m * (m + 1) / 2

noncomputable def unitIntercept (m R i : ℝ) : ℝ :=
  (i * (2 * m + 1 - i) - R * i * (i + 1)) / 2

noncomputable def unitDenominator (m R i : ℝ) : ℝ :=
  ((R - 2) * (m + 1) + (R + 2) * i) / 2

def unitGap (m R i : ℝ) : ℝ := m + 1 - (R + 1) * i

theorem unit_intercept_step (m R i : ℝ) :
    unitIntercept m R (i + 1) - unitIntercept m R i = unitGap m R (i + 1) := by
  unfold unitIntercept unitGap
  ring

theorem unit_denominator_complement (m R i : ℝ) :
    (m - (i + 1)) * unitDenominator m R (i + 1) - unitGap m R (i + 1) =
      (m - i) * (unitDenominator m R i + 1) := by
  unfold unitDenominator unitGap
  ring

theorem unit_denominator_plus_gap (m R i : ℝ) :
    unitDenominator m R i + unitGap m R i = R * (m - i + 1) / 2 := by
  unfold unitDenominator unitGap
  ring

theorem base_robustness_positive (m : ℝ) (hm : 0 < m) : 0 < baselineRobustness m :=
  div_pos (by positivity) (by positivity)

theorem unit_zero_denominator_nonneg (m R : ℝ) (hm : 0 < m)
    (hR : baselineRobustness m ≤ R) : 0 ≤ unitDenominator m R 0 + 1 := by
  have hRm : 2 * m ≤ R * (m + 1) :=
    (div_le_iff₀ (by linarith : 0 < m + 1)).mp hR
  unfold unitDenominator
  nlinarith only [hRm]

theorem unit_denominator_positive (m R i : ℝ) (hm : 0 < m)
    (hR : baselineRobustness m ≤ R) (hi : 1 ≤ i) :
    0 < unitDenominator m R i := by
  have h₀ := unit_zero_denominator_nonneg m R hm hR
  have hR₀ := (base_robustness_positive m hm).trans_le hR
  have h : unitDenominator m R i =
      (unitDenominator m R 0 + 1) + R / 2 + (R + 2) * (i - 1) / 2 := by
    unfold unitDenominator
    ring
  rw [h]
  have hi₁ : 0 ≤ i - 1 := sub_nonneg.mpr hi
  have hlast : 0 ≤ (R + 2) * (i - 1) / 2 := by positivity
  linarith

theorem unit_denominator_add_one_nonneg (m R i : ℝ) (hm : 0 < m)
    (hR : baselineRobustness m ≤ R) (hi : 0 ≤ i) :
    0 ≤ unitDenominator m R i + 1 := by
  have h₀ := unit_zero_denominator_nonneg m R hm hR
  have hR₀ := (base_robustness_positive m hm).trans_le hR
  have h : unitDenominator m R i + 1 =
      (unitDenominator m R 0 + 1) + (R + 2) * i / 2 := by
    unfold unitDenominator
    ring
  rw [h]
  exact add_nonneg h₀ (by positivity)

noncomputable def unitFraction (m R i : ℝ) : ℝ :=
  unitGap m R i / ((m - i) * unitDenominator m R i)

/-- This recursive profile is evaluated only up to the last active branch index. -/
noncomputable def activeUnitLevel (m R : ℝ) : ℕ → ℝ
  | 0 => 0
  | i + 1 =>
      let previous := activeUnitLevel m R i
      previous + unitFraction m R ((i : ℝ) + 1) * (1 - previous)

noncomputable def cappedUnitLevel (m R : ℝ) (a i : ℕ) : ℝ :=
  activeUnitLevel m R (min i a)

theorem unit_fraction_interval (m R i : ℝ) (hm : 0 < m)
    (hR : baselineRobustness m ≤ R) (hi : 0 ≤ i) (hiₘ : i + 1 < m)
    (hgap : 0 ≤ unitGap m R (i + 1)) : unitFraction m R (i + 1) ∈ Set.Icc 0 1 := by
  have hd := unit_denominator_positive m R (i + 1) hm hR (by linarith)
  have hden : 0 < (m - (i + 1)) * unitDenominator m R (i + 1) :=
    mul_pos (sub_pos.mpr hiₘ) hd
  have hp : 0 ≤ (m - i) * (unitDenominator m R i + 1) :=
    mul_nonneg (by linarith) (unit_denominator_add_one_nonneg m R i hm hR hi)
  have hc := unit_denominator_complement m R i
  constructor
  · exact div_nonneg hgap hden.le
  · exact (div_le_one hden).mpr (by linarith only [hp, hc])

theorem active_unit_level_step (m R : ℝ) (i : ℕ) (hq : activeUnitLevel m R i ∈ Set.Icc 0 1)
    (hf : unitFraction m R ((i : ℝ) + 1) ∈ Set.Icc 0 1) :
    activeUnitLevel m R i ≤ activeUnitLevel m R (i + 1) ∧
      activeUnitLevel m R (i + 1) ∈ Set.Icc 0 1 := by
  have hq' : 0 ≤ 1 - activeUnitLevel m R i := sub_nonneg.mpr hq.2
  have hprod : 0 ≤ unitFraction m R ((i : ℝ) + 1) * (1 - activeUnitLevel m R i) :=
    mul_nonneg hf.1 hq'
  have hprod' := mul_le_mul_of_nonneg_right hf.2 hq'
  change
    activeUnitLevel m R i ≤ activeUnitLevel m R i +
      unitFraction m R ((i : ℝ) + 1) * (1 - activeUnitLevel m R i) ∧
    activeUnitLevel m R i +
      unitFraction m R ((i : ℝ) + 1) * (1 - activeUnitLevel m R i) ∈ Set.Icc 0 1
  exact ⟨by linarith, ⟨by linarith only [hq.1, hprod], by linarith only [hprod']⟩⟩

theorem active_unit_level_interval (m R : ℝ) (a : ℕ) (hm : 0 < m)
    (hR : baselineRobustness m ≤ R) (ha : (a : ℝ) < m)
    (hgap : 0 ≤ unitGap m R a) :
    ∀ i : ℕ, i ≤ a → activeUnitLevel m R i ∈ Set.Icc 0 1 := by
  have hRp : 0 ≤ R + 1 := by
    have h := (base_robustness_positive m hm).trans_le hR
    linarith
  intro i
  induction i with
  | zero => simp [activeUnitLevel]
  | succ i ih =>
    intro hi
    have hia : (i : ℝ) + 1 ≤ (a : ℝ) := by exact_mod_cast hi
    have hg : 0 ≤ unitGap m R ((i : ℝ) + 1) := by
      unfold unitGap at hgap ⊢
      linarith only [hgap, mul_le_mul_of_nonneg_left hia hRp]
    exact (active_unit_level_step m R i (ih (Nat.le_of_succ_le hi))
      (unit_fraction_interval m R i hm hR (by positivity) (hia.trans_lt ha) hg)).2

theorem capped_unit_level_monotone (m R : ℝ) (a : ℕ) (hm : 0 < m)
    (hR : baselineRobustness m ≤ R) (ha : (a : ℝ) < m)
    (hgap : 0 ≤ unitGap m R a) :
    Monotone (cappedUnitLevel m R a) := by
  apply monotone_nat_of_le_succ
  intro i
  by_cases hi : a ≤ i
  · simp [cappedUnitLevel, min_eq_right hi, min_eq_right (hi.trans (Nat.le_succ i))]
  have hi' : i + 1 ≤ a := by omega
  have hi₀ : i ≤ a := by omega
  have hia : (i : ℝ) + 1 ≤ (a : ℝ) := by exact_mod_cast hi'
  have hRp : 0 ≤ R + 1 := by
    have h := (base_robustness_positive m hm).trans_le hR
    linarith
  have hg : 0 ≤ unitGap m R ((i : ℝ) + 1) := by
    unfold unitGap at hgap ⊢
    linarith only [hgap, mul_le_mul_of_nonneg_left hia hRp]
  simpa only [cappedUnitLevel, min_eq_left hi', min_eq_left hi₀] using
    (active_unit_level_step m R i (active_unit_level_interval m R a hm hR ha hgap i hi₀)
      (unit_fraction_interval m R i hm hR (by positivity) (hia.trans_lt ha) hg)).1

/-- Aggregate attained work of the unmarked jobs at stage i. -/
noncomputable def activeUnitTail (m R : ℝ) (i : ℕ) : ℝ :=
  (m - i) * activeUnitLevel m R i

/-- The sum through stage i, including the zero initial stage. -/
noncomputable def activeUnitTailSum (m R : ℝ) (i : ℕ) : ℝ :=
  ∑ j ∈ Finset.range (i + 1), activeUnitTail m R j

theorem active_unit_tail_step (m R : ℝ) (i : ℕ) (hm : 0 < m)
    (hR : baselineRobustness m ≤ R) (hiₘ : (i : ℝ) + 1 < m) :
    unitDenominator m R ((i : ℝ) + 1) * activeUnitTail m R (i + 1) =
      (unitDenominator m R i + 1) * activeUnitTail m R i + unitGap m R ((i : ℝ) + 1) := by
  have hd := unit_denominator_positive m R ((i : ℝ) + 1) hm hR (by linarith)
  have hden : (m - ((i : ℝ) + 1)) * unitDenominator m R ((i : ℝ) + 1) ≠ 0 :=
    (mul_pos (by linarith) hd).ne'
  have hc := unit_denominator_complement m R (i : ℝ)
  simp only [activeUnitTail, Nat.cast_add, Nat.cast_one, activeUnitLevel, unitFraction]
  set D := (m - ((i : ℝ) + 1)) * unitDenominator m R ((i : ℝ) + 1)
  set G := unitGap m R ((i : ℝ) + 1)
  set q := activeUnitLevel m R i
  suffices D * (q + G / D * (1 - q)) =
      (unitDenominator m R i + 1) * ((m - i) * q) + G by
    (convert this using 1; unfold D; ring)
  rw [mul_add]
  have hcancel : D * (G / D * (1 - q)) = G * (1 - q) := by
    calc
      D * (G / D * (1 - q)) = (G / D * D) * (1 - q) := by ring
      _ = G * (1 - q) := by rw [div_mul_cancel₀ G hden]
  rw [hcancel]
  have hcharge := congrArg (fun t : ℝ => t * q) hc
  dsimp at hcharge
  nlinarith only [hcharge]

theorem active_unit_prefix_equality (m R : ℝ) (a : ℕ) (hm : 0 < m)
    (hR : baselineRobustness m ≤ R) (ha : (a : ℝ) < m) :
    ∀ i : ℕ, i + 1 ≤ a →
      unitDenominator m R ((i : ℝ) + 1) * activeUnitTail m R (i + 1) =
        unitIntercept m R ((i : ℝ) + 1) + activeUnitTailSum m R i := by
  intro i
  induction i with
  | zero =>
    intro hi
    have hi' : (0 : ℝ) + 1 < m := (by exact_mod_cast hi : (0 : ℝ) + 1 ≤ (a : ℝ)).trans_lt ha
    have he := active_unit_tail_step m R 0 hm hR (by simpa using hi')
    have hs := unit_intercept_step m R 0
    simp [activeUnitTailSum, activeUnitTail, activeUnitLevel, unitIntercept] at he hs ⊢
    linarith only [he, hs]
  | succ i ih =>
    intro hi
    have hi' : i + 1 ≤ a := by omega
    have hnext : (↑(i + 1) : ℝ) + 1 < m :=
      (by exact_mod_cast hi : (↑(i + 1) : ℝ) + 1 ≤ (a : ℝ)).trans_lt ha
    rw [active_unit_tail_step m R (i + 1) hm hR hnext]
    have he := ih hi'
    have hs := unit_intercept_step m R (↑(i + 1) : ℝ)
    have hsum : activeUnitTailSum m R (i + 1) =
        activeUnitTailSum m R i + activeUnitTail m R (i + 1) := by
      unfold activeUnitTailSum
      rw [Finset.sum_range_succ]
    rw [hsum]
    push_cast at *
    nlinarith only [he, hs]

end FiniteFrontier
