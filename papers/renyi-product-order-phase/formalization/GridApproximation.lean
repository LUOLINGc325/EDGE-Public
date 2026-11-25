import GridStepLimit

/-! Approximation on a fixed compact window by one grid for an entire family. -/

open Set

namespace RenyiProductOrderPhase

theorem exists_grid_approximation {α : Type*} (F : α → ℝ → ℝ) (L : ℕ)
    {η : ℝ} (hη : 0 < η)
    (hUniform : ∀ ε > 0, ∃ δ > 0, ∀ a x y,
      x ∈ Icc (-(L : ℝ)) (L : ℝ) → y ∈ Icc (-(L : ℝ)) (L : ℝ) →
      |x - y| < δ → |F a x - F a y| < ε) :
    ∃ h > 0, ∃ J : Finset ℤ, ∀ a x,
      (x ∈ Ico (-(L : ℝ)) (L : ℝ) → |F a x - gridStep h J (F a) x| < η) ∧
      (x ∉ Ico (-(L : ℝ)) (L : ℝ) → gridStep h J (F a) x = 0) := by
  obtain ⟨δ, hδ, hMod⟩ := hUniform η hη
  obtain ⟨m, hm⟩ := exists_nat_gt (1 / δ)
  have hm₀ : 0 < (m : ℝ) := (one_div_pos.mpr hδ).trans hm
  let h := 1 / (m : ℝ)
  have hh : 0 < h := one_div_pos.mpr hm₀
  have hhδ : h < δ :=
    (div_lt_iff₀ hm₀).2 (by simpa only [mul_comm] using (div_lt_iff₀ hδ).1 hm)
  let D : ℤ := (L : ℤ) * (m : ℤ)
  let J := Finset.Ico (-D) D
  have hD : h * (D : ℝ) = (L : ℝ) := by
    unfold h D
    push_cast
    calc
      _ = (L : ℝ) * ((m : ℝ) * (1 / (m : ℝ))) := by ring
      _ = _ := by rw [mul_div_cancel₀ _ hm₀.ne', mul_one]
  have hNeg : h * ((-D : ℤ) : ℝ) = -(L : ℝ) := by
    rw [Int.cast_neg, mul_neg, hD]
  have hCells (x : ℝ) :
      gridIndex h x ∈ J ↔ x ∈ Ico (-(L : ℝ)) (L : ℝ) := by
    unfold J
    rw [grid_index_mem_interval hh, hNeg, hD]
  have hSample (j : ℤ) (hj : j ∈ J) : h * (j : ℝ) ∈ Icc (-(L : ℝ)) (L : ℝ) := by
    have hj' := Finset.mem_Ico.1 hj
    have hl : ((-D : ℤ) : ℝ) ≤ (j : ℝ) := by exact_mod_cast hj'.1
    have hr : (j : ℝ) ≤ (D : ℝ) := by exact_mod_cast hj'.2.le
    rw [← hNeg, ← hD]
    exact ⟨mul_le_mul_of_nonneg_left hl hh.le, mul_le_mul_of_nonneg_left hr hh.le⟩
  refine ⟨h, hh, J, ?_⟩
  intro a x
  rw [grid_step_value hh]
  constructor
  · intro hx
    have hx' := (hCells x).2 hx
    rw [if_pos hx']
    exact hMod a x (h * (gridIndex h x : ℝ)) ⟨hx.1, hx.2.le⟩ (hSample _ hx')
      ((grid_sample_dist hh x).trans hhδ)
  · intro hx
    rw [if_neg (fun h => hx ((hCells x).1 h))]

end RenyiProductOrderPhase
