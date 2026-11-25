import GridConcentration
import CentralWindows
import Mathlib.Data.Int.Interval

/-! Finite grid approximants for both normalized finite laws and Lebesgue measure. -/

open scoped BigOperators
open Set MeasureTheory

namespace RenyiProductOrderPhase

theorem grid_index_mem_interval {h : ℝ} (hh : 0 < h) (x : ℝ) (a b : ℤ) :
    gridIndex h x ∈ Finset.Ico a b ↔ x ∈ Ico (h * (a : ℝ)) (h * (b : ℝ)) := by
  rw [Finset.mem_Ico, gridIndex, Int.le_floor, Int.floor_lt, mem_Ico,
    le_div_iff₀ hh, div_lt_iff₀ hh, mul_comm h (a : ℝ), mul_comm h (b : ℝ)]

theorem grid_sample_dist {h : ℝ} (hh : 0 < h) (x : ℝ) :
    |x - h * (gridIndex h x : ℝ)| < h := by
  have hs := (grid_index_eq_iff hh x (gridIndex h x)).1 rfl
  change h * (gridIndex h x : ℝ) ≤ x ∧ x < h * ((gridIndex h x : ℝ) + 1) at hs
  rw [abs_of_nonneg (sub_nonneg.mpr hs.1)]
  nlinarith only [hs.2]

noncomputable def gridStep (h : ℝ) (J : Finset ℤ) (f : ℝ → ℝ) (x : ℝ) : ℝ :=
  ∑ j ∈ J, (gridCell h j).indicator (fun _ => f (h * (j : ℝ))) x

theorem grid_step_value {h : ℝ} (hh : 0 < h) (J : Finset ℤ) (f : ℝ → ℝ) (x : ℝ) :
    gridStep h J f x = if gridIndex h x ∈ J then f (h * (gridIndex h x : ℝ)) else 0 := by
  classical
  let k := gridIndex h x
  have hk : x ∈ gridCell h k := (grid_index_eq_iff hh x k).1 rfl
  have hOther (j : ℤ) (hjk : j ≠ k) : x ∉ gridCell h j :=
    fun h => hjk ((grid_index_eq_iff hh x j).2 h).symm
  unfold gridStep
  by_cases hJ : k ∈ J
  · rw [if_pos hJ, Finset.sum_eq_single k]
    · rw [indicator_of_mem hk]
    · intro j _ hne
      rw [indicator_of_not_mem (hOther j hne)]
    · exact fun hn => (hn hJ).elim
  · rw [if_neg hJ]
    exact Finset.sum_eq_zero (fun j hj => indicator_of_not_mem (hOther j
      (fun he => hJ (he ▸ hj))) _)

theorem grid_cell_volume (h : ℝ) (j : ℤ) : volume (gridCell h j) = ENNReal.ofReal h := by
  unfold gridCell
  rw [Real.volume_Ico, show h * ((j : ℝ) + 1) - h * (j : ℝ) = h by ring]

theorem grid_step_terms_integrable (h : ℝ) (f : ℝ → ℝ) (j : ℤ) :
    Integrable ((gridCell h j).indicator (fun _ => f (h * (j : ℝ)))) := by
  rw [integrable_indicator_iff (show MeasurableSet (gridCell h j) from measurableSet_Ico)]
  apply integrableOn_const.2
  right
  rw [grid_cell_volume]
  exact ENNReal.ofReal_lt_top

theorem grid_step_integrable (h : ℝ) (J : Finset ℤ) (f : ℝ → ℝ) :
    Integrable (gridStep h J f) :=
  integrable_finset_sum J (fun j _ => grid_step_terms_integrable h f j)

theorem integral_grid_step {h : ℝ} (hh : 0 ≤ h) (J : Finset ℤ) (f : ℝ → ℝ) :
    (∫ x, gridStep h J f x) = ∑ j ∈ J, f (h * (j : ℝ)) * h := by
  unfold gridStep
  rw [integral_finset_sum J (fun j _ => grid_step_terms_integrable h f j)]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [integral_indicator_const _ (show MeasurableSet (gridCell h j) from measurableSet_Ico)]
  change (volume (gridCell h j)).toReal * f (h * (j : ℝ)) = _
  rw [grid_cell_volume, ENNReal.toReal_ofReal hh, mul_comm]

variable {κ : Type*} [Fintype κ]

theorem finite_sum_expect_grid_step (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    (h : ℝ) (J : Finset ℤ) (f : ℝ → ℝ) :
    (FiniteMass.tensor (fun _ : Fin n => p)).expect (fun x => gridStep h J f (iidSum Y x)) =
      ∑ j ∈ J, f (h * (j : ℝ)) * finiteSumEvent p Y n (gridCell h j) := by
  classical
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let S (j : ℤ) (x : Fin n → κ) := (gridCell h j).indicator
    (fun _ => f (h * (j : ℝ))) (iidSum Y x)
  change (∑ x, P x * ∑ j ∈ J, S j x) = _
  simp_rw [Finset.mul_sum]
  rw [Finset.sum_comm]
  unfold finiteSumEvent FiniteMass.expect
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun x _ => ?_
  unfold S
  by_cases hx : iidSum Y x ∈ gridCell h j
  · simp only [indicator_of_mem hx, mul_one]
    ring
  · simp only [indicator_of_not_mem hx, mul_zero]

end RenyiProductOrderPhase
