import WorstFactor
import Mathlib.Analysis.SpecificLimits.Basic

open Filter
open scoped Topology

namespace TwoColorNullity

theorem ceilDiv_real_bounds (items owners : ℕ) (howners : 0 < owners) :
    (items : ℝ) / owners ≤ ((items ⌈/⌉ owners : ℕ) : ℝ) ∧
    ((items ⌈/⌉ owners : ℕ) : ℝ) ≤ (items : ℝ) / owners + 1 := by
  have hpos : (0 : ℝ) < owners := by exact_mod_cast howners
  constructor
  · apply (div_le_iff₀ hpos).mpr
    have h := (ceilDiv_le_iff_le_mul howners).mp (le_refl (items ⌈/⌉ owners))
    rw [Nat.mul_comm owners] at h
    exact_mod_cast h
  · have hd : (items ⌈/⌉ owners) * owners ≤ items + owners - 1 := by
      rw [Nat.ceilDiv_eq_add_pred_div]
      have h := Nat.div_mul_le_self (items + (owners - 1)) owners
      have hs : items + (owners - 1) = items + owners - 1 := by omega
      simpa only [hs] using h
    have hcast : ((items ⌈/⌉ owners : ℕ) : ℝ) * owners ≤ (items : ℝ) + owners := by
      exact_mod_cast hd.trans (Nat.sub_le _ _)
    apply le_of_mul_le_mul_right _ hpos
    calc
      _ ≤ (items : ℝ) + owners := hcast
      _ = ((items : ℝ) / owners + 1) * owners := by field_simp

theorem binaryLog_atTop : Tendsto (fun n : ℕ => binaryLog n) atTop atTop := by
  have h := Real.tendsto_log_atTop.comp
    (tendsto_natCast_atTop_atTop : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop)
  simpa only [binaryLog, div_eq_mul_inv, mul_comm, Function.comp_apply] using
    h.const_mul_atTop (inv_pos.mpr log_two_pos)

theorem binaryLog_over_n_zero :
    Tendsto (fun n : ℕ => binaryLog n / (n : ℝ)) atTop (𝓝 0) := by
  simpa only [binaryLog, zero_div, div_div, mul_comm] using real_log_over_n_zero.div_const (Real.log 2)

theorem binaryLog_add_atTop (c : ℝ) : Tendsto (fun n : ℕ => binaryLog n + c) atTop atTop := by
  apply tendsto_atTop.2
  intro b
  filter_upwards [tendsto_atTop.1 binaryLog_atTop (b - c)] with n hn
  linarith

noncomputable def normalizedFactor (n : ℕ) (factor : ℝ) : ℝ :=
  factor * (binaryLog n / n)

noncomputable def fixedLowerEnvelope (n : ℕ) : ℝ :=
  (1 - (n : ℝ)⁻¹) * (1 - 6 / (binaryLog n + 6)) - binaryLog n / n

noncomputable def fixedUpperEnvelope (n : ℕ) : ℝ :=
  1 + (binaryLog n - 1)⁻¹ + binaryLog n / n

theorem fixedLowerEnvelope_limit : Tendsto fixedLowerEnvelope atTop (𝓝 1) := by
  have hinv : Tendsto (fun n : ℕ => (n : ℝ)⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_zero.comp tendsto_natCast_atTop_atTop
  have hlogInv := tendsto_inv_atTop_zero.comp (binaryLog_add_atTop 6)
  have hscaled : Tendsto (fun n : ℕ => 6 / (binaryLog n + 6)) atTop (𝓝 0) := by
    simpa only [Function.comp_apply, div_eq_mul_inv, mul_zero] using hlogInv.const_mul (6 : ℝ)
  have hconst : Tendsto (fun _ : ℕ => (1 : ℝ)) atTop (𝓝 1) := tendsto_const_nhds
  simpa only [fixedLowerEnvelope, sub_zero, one_mul] using
    ((hconst.sub hinv).mul (hconst.sub hscaled)).sub binaryLog_over_n_zero

theorem fixedUpperEnvelope_limit : Tendsto fixedUpperEnvelope atTop (𝓝 1) := by
  have hlogInv := tendsto_inv_atTop_zero.comp (binaryLog_add_atTop (-1))
  simpa only [fixedUpperEnvelope, Function.comp_apply, sub_eq_add_neg, add_zero] using
    (tendsto_const_nhds.add hlogInv).add binaryLog_over_n_zero

theorem fixedLowerEnvelope_le (n : ℕ) (hn : 2 ≤ n) :
    fixedLowerEnvelope n ≤ normalizedFactor n
      (((n - 1) ⌈/⌉ (largeSetThreshold n - 1) - 1 : ℕ) : ℝ) := by
  let cutoff := largeSetThreshold n - 1
  let l := binaryLog n
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hl : 0 ≤ l := div_nonneg (Real.log_nonneg (by exact_mod_cast (show 1 ≤ n by omega))) log_two_pos.le
  have hcut : 0 < cutoff := by dsimp [cutoff, largeSetThreshold]; omega
  have hcutR : 0 < (cutoff : ℝ) := by exact_mod_cast hcut
  have hcutLe : (cutoff : ℝ) ≤ l + 6 := by
    have h := threshold_le_binaryLog_add n (by omega)
    have hc : ((cutoff + 1 : ℕ) : ℝ) = (largeSetThreshold n : ℝ) := by
      congr 1
    rw [Nat.cast_add, Nat.cast_one] at hc
    change (largeSetThreshold n : ℝ) ≤ l + 7 at h
    linarith
  have hc1 : 1 ≤ (n - 1) ⌈/⌉ cutoff := by
    by_contra! hz
    have h := (ceilDiv_le_iff_le_mul hcut).mp (show (n - 1) ⌈/⌉ cutoff ≤ 0 by omega)
    omega
  have hnum : ((n - 1 : ℕ) : ℝ) = (n : ℝ) - 1 := by rw [Nat.cast_sub (by omega : 1 ≤ n), Nat.cast_one]
  have hquot := div_le_div_of_nonneg_left (Nat.cast_nonneg (n - 1)) hcutR hcutLe
  have hceil := (ceilDiv_real_bounds (n - 1) cutoff hcut).1
  have hnorm := mul_le_mul_of_nonneg_right (sub_le_sub_right (hquot.trans hceil) 1)
    (div_nonneg hl hnR.le)
  have hdiff : (((n - 1) ⌈/⌉ cutoff - 1 : ℕ) : ℝ) = ((n - 1) ⌈/⌉ cutoff : ℕ) - 1 := by
    rw [Nat.cast_sub hc1, Nat.cast_one]
  have heq : fixedLowerEnvelope n =
      (((n - 1 : ℕ) : ℝ) / (l + 6) - 1) * (l / n) := by
    unfold fixedLowerEnvelope
    change (1 - (n : ℝ)⁻¹) * (1 - 6 / (l + 6)) - l / n = _
    rw [hnum]
    field_simp [hnR.ne', show l + 6 ≠ 0 by positivity]
    ring
  rw [heq]
  change _ ≤ (((n - 1) ⌈/⌉ cutoff - 1 : ℕ) : ℝ) * (l / n)
  rwa [hdiff]

theorem normalizedFactor_le_fixedUpperEnvelope (n : ℕ) (hn : 2 ≤ n) (hl : 1 < binaryLog n) :
    normalizedFactor n (((n - 1) ⌈/⌉ n.log2 : ℕ) : ℝ) ≤ fixedUpperEnvelope n := by
  let l := binaryLog n
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hlR : 0 < l := by dsimp [l]; linarith
  have hlog : 0 < n.log2 := (Nat.le_log2 (by omega)).mpr (by omega)
  have hden : l - 1 ≤ (n.log2 : ℝ) := by
    have h := (binaryLog_floor_bounds n (by omega)).2
    dsimp [l]
    linarith
  have hdenPos : 0 < l - 1 := by dsimp [l]; linarith
  have hnum : ((n - 1 : ℕ) : ℝ) ≤ (n : ℝ) := by exact_mod_cast Nat.sub_le n 1
  have hbound : ((n - 1) ⌈/⌉ n.log2 : ℕ) ≤ (n : ℝ) / (l - 1) + 1 :=
    (ceilDiv_real_bounds (n - 1) n.log2 hlog).2.trans
      (add_le_add_right (div_le_div₀ (Nat.cast_nonneg _) hnum hdenPos hden) 1)
  calc
    _ ≤ ((n : ℝ) / (l - 1) + 1) * (l / n) :=
      mul_le_mul_of_nonneg_right hbound (div_nonneg hlR.le hnR.le)
    _ = fixedUpperEnvelope n := by
      change ((n : ℝ) / (l - 1) + 1) * (l / n) = 1 + (l - 1)⁻¹ + l / n
      field_simp [hnR.ne', hdenPos.ne']
      ring

theorem fixed_worst_factor_limit :
    Tendsto (fun n : ℕ => normalizedFactor n (fixedItemWorst n)) atTop (𝓝 1) := by
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le'
    fixedLowerEnvelope_limit fixedUpperEnvelope_limit
  · filter_upwards [eventually_ge_atTop (2 : ℕ), eventual_worst_exact_bounds] with n hn hb
    have hlog : 0 ≤ binaryLog n := div_nonneg
      (Real.log_nonneg (by exact_mod_cast (show 1 ≤ n by omega))) log_two_pos.le
    exact (fixedLowerEnvelope_le n hn).trans (mul_le_mul_of_nonneg_right hb.1 (by positivity))
  · filter_upwards [eventually_ge_atTop (2 : ℕ), tendsto_atTop.1 binaryLog_atTop 2,
      eventual_worst_exact_bounds] with n hn hlog hb
    have hl : 1 < binaryLog n := by linarith
    have hlog0 : 0 ≤ binaryLog n := by linarith
    exact (mul_le_mul_of_nonneg_right hb.2 (by positivity)).trans
      (normalizedFactor_le_fixedUpperEnvelope n hn hl)

end TwoColorNullity
