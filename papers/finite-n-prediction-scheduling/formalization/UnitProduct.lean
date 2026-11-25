import UnitRecurrence
import Mathlib.Tactic.FieldSimp

/-! The finite product representation of the manuscript's unit-job value. -/

open scoped BigOperators

namespace FiniteFrontier

noncomputable def unitProduct (m R : ℝ) (a : ℕ) : ℝ :=
  ∏ j ∈ Finset.range a, (1 - R / (2 * unitDenominator m R ((j : ℝ) + 1)))

theorem unit_survival_step (m R : ℝ) (i : ℕ) (hm : 0 < m)
    (hR : baselineRobustness m ≤ R) (hi : (i : ℝ) + 1 < m) :
    (m - ((i : ℝ) + 1)) * (1 - activeUnitLevel m R (i + 1)) =
      (m - i) * (1 - activeUnitLevel m R i) *
        (1 - R / (2 * unitDenominator m R ((i : ℝ) + 1))) := by
  let d := unitDenominator m R ((i : ℝ) + 1)
  let M := m - ((i : ℝ) + 1)
  let G := unitGap m R ((i : ℝ) + 1)
  let q := activeUnitLevel m R i
  have hd : 0 < d := unit_denominator_positive m R _ hm hR (by linarith)
  have hM : 0 < M := sub_pos.mpr hi
  have hc : M * d - G = (m - i) * (unitDenominator m R i + 1) :=
    unit_denominator_complement m R i
  have hp : unitDenominator m R i + 1 = d - R / 2 := by
    unfold d unitDenominator
    ring
  change M * (1 - (q + G / (M * d) * (1 - q))) =
    (m - i) * (1 - q) * (1 - R / (2 * d))
  calc
    _ = (M * d - G) * (1 - q) / d := by
      field_simp [hM.ne', hd.ne']
      ring
    _ = _ := by
      rw [hc, hp]
      field_simp [hd.ne']
      ring

theorem unit_survival_product (m R : ℝ) (hm : 0 < m) (hR : baselineRobustness m ≤ R) :
    ∀ a : ℕ, (a : ℝ) < m →
      (m - a) * (1 - activeUnitLevel m R a) = m * unitProduct m R a := by
  intro a
  induction a with
  | zero =>
    intro _
    simp [activeUnitLevel, unitProduct]
  | succ a ih =>
    intro ha
    have ha' : (a : ℝ) + 1 < m := by exact_mod_cast ha
    have hprev : (a : ℝ) < m := by linarith
    have hp : unitProduct m R (a + 1) =
        unitProduct m R a * (1 - R / (2 * unitDenominator m R ((a : ℝ) + 1))) := by
      unfold unitProduct
      rw [Finset.prod_range_succ]
    rw [Nat.cast_succ, unit_survival_step m R a hm hR ha', ih hprev, hp]
    ring

theorem unit_tail_of_product (m R : ℝ) (a : ℕ) (hm : 0 < m)
    (hR : baselineRobustness m ≤ R) (ha : (a : ℝ) < m) :
    activeUnitTail m R a = m - a - m * unitProduct m R a := by
  unfold activeUnitTail
  linarith only [unit_survival_product m R hm hR a ha]

/-- The value given by (7) on a branch with active-index cutoff a.
The zero cutoff includes the serial branch. -/
noncomputable def unitValue (m R : ℝ) (a : ℕ) : ℝ :=
  match a with
  | 0 => 1
  | j + 1 => 1 +
      (activeUnitTailSum m R j + (m - (j + 1 : ℕ) + 1) / 2 * activeUnitTail m R (j + 1)) /
        triangularCost m

noncomputable def branchProduct (R H : ℝ) (a : ℕ) : ℝ :=
  ∏ j ∈ Finset.range a, (1 - R / ((R - 2) * H + (R + 2) * ((j : ℝ) + 1)))

noncomputable def branchValue (R H : ℝ) (a : ℕ) : ℝ :=
  R - (R - 1 + (R + 1) * a / H) * branchProduct R H a

theorem unit_product_eq_branch_product (m R : ℝ) (a : ℕ) :
    unitProduct m R a = branchProduct R (m + 1) a := by
  unfold unitProduct branchProduct
  apply Finset.prod_congr rfl
  intro j _
  congr 2
  unfold unitDenominator
  ring

/-- The recurrence and the product expression give the very same unit-instance value. -/
theorem unit_value_eq_branch_value (m R : ℝ) (a : ℕ) (hm : 0 < m)
    (hR : baselineRobustness m ≤ R) (ha : (a : ℝ) < m) :
    unitValue m R a = branchValue R (m + 1) a := by
  cases a with
  | zero => simp [unitValue, branchValue, branchProduct]
  | succ j =>
    let i : ℝ := (j : ℝ) + 1
    let E := activeUnitTail m R (j + 1)
    let P := unitProduct m R (j + 1)
    have he : E = m - i - m * P := by
      simpa only [Nat.cast_succ] using unit_tail_of_product m R (j + 1) hm hR ha
    have hpre : unitDenominator m R i * E =
        unitIntercept m R i + activeUnitTailSum m R j :=
      active_unit_prefix_equality m R (j + 1) hm hR ha j le_rfl
    have hn : 0 < m + 1 := by positivity
    have hQ : 0 < triangularCost m := by unfold triangularCost; positivity
    have hform : branchProduct R (m + 1) (j + 1) = P :=
      (unit_product_eq_branch_product m R (j + 1)).symm
    rw [unitValue, branchValue]
    rw [hform, Nat.cast_succ]
    change 1 + (activeUnitTailSum m R j + (m - i + 1) / 2 * E) /
      triangularCost m = R - (R - 1 + (R + 1) * i / (m + 1)) * P
    have hs : activeUnitTailSum m R j = unitDenominator m R i * E - unitIntercept m R i := by
      linarith only [hpre]
    rw [hs, he]
    unfold unitDenominator unitIntercept triangularCost
    field_simp [hm.ne', hn.ne']
    ring

theorem branch_value_empty (R H : ℝ) : branchValue R H 0 = 1 := by
  simp [branchValue, branchProduct]

/-- Adjacent branches meet at the exact shared cutoff. -/
theorem branch_value_agrees_at_cutoff (R : ℝ) (a : ℕ) (hR : 0 < R) :
    branchValue R ((R + 1) * ((a : ℝ) + 1)) (a + 1) =
      branchValue R ((R + 1) * ((a : ℝ) + 1)) a := by
  let H := (R + 1) * ((a : ℝ) + 1)
  let L := (R - 2) * H + (R + 2) * ((a : ℝ) + 1)
  have hRp : 0 < R + 1 := by positivity
  have ha : 0 < (a : ℝ) + 1 := by positivity
  have hH : 0 < H := mul_pos hRp ha
  have hL : L = R ^ 2 * ((a : ℝ) + 1) := by
    unfold L H
    ring
  have hL₀ : 0 < L := by rw [hL]; positivity
  unfold branchValue branchProduct
  rw [Finset.prod_range_succ]
  push_cast
  change R - (R - 1 + (R + 1) * ((a : ℝ) + 1) / H) *
      (branchProduct R H a * (1 - R / L)) =
    R - (R - 1 + (R + 1) * (a : ℝ) / H) * branchProduct R H a
  suffices hl : (R - 1 + (R + 1) * ((a : ℝ) + 1) / H) * (1 - R / L) =
      R - 1 + (R + 1) * (a : ℝ) / H by
    linarith only [congrArg (· * branchProduct R H a) hl]
  rw [hL]
  unfold H
  field_simp [hRp.ne', hR.ne', ha.ne']
  ring

end FiniteFrontier
