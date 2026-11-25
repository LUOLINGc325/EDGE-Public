import TiltedKernels

/-! Uniform first-order passage from a missing moment to its logarithmic deficit. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

theorem scaled_negative_log_error {S u : ℝ} (hS : 0 ≤ S) (hu₁ : u < 1) :
    0 ≤ S * (-Real.log (1 - u)) - S * u ∧
      S * (-Real.log (1 - u)) - S * u ≤ (S * u) * u / (1 - u) := by
  have h := neg_log_one_sub_bounds hu₁
  constructor
  · exact sub_nonneg.mpr (mul_le_mul_of_nonneg_left h.1 hS)
  · calc
      _ ≤ S * (u / (1 - u)) - S * u :=
        sub_le_sub_right (mul_le_mul_of_nonneg_left h.2 hS) _
      _ = _ := by
        field_simp [(sub_pos.mpr hu₁).ne']
        ring

theorem uniform_scaled_log_linearization {α : Type*} (S : ℕ → ℝ) (u : ℕ → α → ℝ) {C : ℝ}
    (hS : Tendsto S atTop atTop) (hC : 0 ≤ C)
    (hU : ∀ᶠ n in atTop, ∀ a, 0 ≤ u n a ∧ u n a < 1 ∧ S n * u n a ≤ C)
    {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop, ∀ a,
      |S n * (-Real.log (1 - u n a)) - S n * u n a| < ε := by
  let V := ε / (4 * (C + 1))
  have hPos : 0 < 4 * (C + 1) := by positivity
  have hV : 0 < V := div_pos hε hPos
  let δ := min (1 / 2 : ℝ) V
  have hδ : 0 < δ := lt_min (by norm_num) hV
  have hδ₁ : δ ≤ 1 / 2 := min_le_left _ _
  have hδ₂ : δ ≤ V := min_le_right _ _
  have hTarget : 2 * C * δ < ε := by
    have hC' : 0 ≤ 2 * C := by positivity
    have hEq : 4 * (C + 1) * V = ε := mul_div_cancel₀ _ hPos.ne'
    have hh : 2 * C * V < ε := by
      nlinarith only [hEq, hV, mul_nonneg hC hV.le]
    exact (mul_le_mul_of_nonneg_left hδ₂ hC').trans_lt hh
  have hLarge : ∀ᶠ n in atTop, 1 + C / δ ≤ S n :=
    hS.eventually (eventually_ge_atTop _)
  filter_upwards [hU, hLarge] with n hn hL
  intro a
  have hQR : 0 ≤ C / δ := div_nonneg hC hδ.le
  have hSPos : 0 < S n := (show 0 < 1 + C / δ by linarith only [hQR]).trans_le hL
  have hCδ : C / δ ≤ S n := (le_add_of_nonneg_left zero_le_one).trans hL
  have hUpper : u n a ≤ δ := by
    have hh := hn a
    apply le_of_mul_le_mul_left _ hSPos
    exact hh.2.2.trans ((div_le_iff₀ hδ).1 hCδ)
  obtain ⟨h₀, h₁, hB⟩ := hn a
  have he := scaled_negative_log_error hSPos.le h₁
  rw [abs_of_nonneg he.1]
  apply he.2.trans_lt
  have hDen : 0 < 1 - u n a := sub_pos.mpr h₁
  have hHalf : 1 / 2 ≤ 1 - u n a := by linarith only [hUpper, hδ₁]
  have hBound : (S n * u n a) * u n a / (1 - u n a) ≤ 2 * C * δ := by
    apply (div_le_iff₀ hDen).2
    calc
      _ ≤ C * δ := mul_le_mul hB hUpper h₀ hC
      _ = (2 * C * δ) * (1 / 2) := by ring
      _ ≤ _ := mul_le_mul_of_nonneg_left hHalf (by positivity)
  exact hBound.trans_lt hTarget

end RenyiProductOrderPhase
