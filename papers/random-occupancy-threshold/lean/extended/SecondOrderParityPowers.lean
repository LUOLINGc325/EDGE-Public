import BinPowerApproximation
import OccupancyVariance
import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Analysis.Complex.Exponential

open scoped BigOperators

namespace TwoColorNullity.Occupancy

private theorem log_one_sub_second_order (x : ℝ) (hx : 0 ≤ x) (hhalf : x ≤ 1 / 2) :
    |Real.log (1 - x) + x + x ^ 2 / 2| ≤ 2 * x ^ 3 := by
  have hx' : |x| < 1 := by rw [abs_of_nonneg hx]; linarith
  have h := Real.abs_log_sub_add_sum_range_le hx' 2
  rw [abs_of_nonneg hx] at h
  have hsum : (∑ i ∈ Finset.range 2, x ^ (i + 1) / (i + 1)) = x + x ^ 2 / 2 := by
    norm_num [Finset.sum_range_succ]
  rw [hsum] at h
  have hd : x ^ 3 / (1 - x) ≤ 2 * x ^ 3 := by
    apply (div_le_iff₀ (by linarith : 0 < 1 - x)).mpr
    nlinarith only [mul_le_mul_of_nonneg_right hhalf (show 0 ≤ x ^ 3 by positivity)]
  have heq : Real.log (1 - x) + x + x ^ 2 / 2 = (x + x ^ 2 / 2) + Real.log (1 - x) := by ring
  rw [heq]
  exact h.trans hd

private theorem binPower_second_order (m : ℕ) (x : ℝ) (hx : 0 ≤ x) (hhalf : x ≤ 1 / 2)
    (hsmall : 2 * (m : ℝ) * x ^ 2 ≤ 1) :
    |(1 - x) ^ m - Real.exp (-(m : ℝ) * x) * (1 - (m : ℝ) * x ^ 2 / 2)| ≤
      4 * (m : ℝ) ^ 2 * x ^ 4 + 2 * (m : ℝ) * x ^ 3 := by
  let d := (m : ℝ) * (Real.log (1 - x) + x)
  let e := Real.exp (-(m : ℝ) * x)
  have hm : 0 ≤ (m : ℝ) := Nat.cast_nonneg _
  have hlog := log_one_sub_first_order x hhalf
  have hd : d ≤ 0 := mul_nonpos_of_nonneg_of_nonpos hm (by linarith only [hlog.1])
  have hdBound : |d| ≤ 2 * (m : ℝ) * x ^ 2 := by
    rw [abs_of_nonpos hd]
    have h := mul_le_mul_of_nonneg_left hlog.2 hm
    unfold d
    linarith only [h]
  have he := Real.abs_exp_sub_one_sub_id_le (hdBound.trans hsmall)
  have hlogErr := mul_le_mul_of_nonneg_left (log_one_sub_second_order x hx hhalf) hm
  have hδ : |d + (m : ℝ) * x ^ 2 / 2| ≤ 2 * (m : ℝ) * x ^ 3 := by
    have heq : d + (m : ℝ) * x ^ 2 / 2 = (m : ℝ) * (Real.log (1 - x) + x + x ^ 2 / 2) := by
      unfold d
      ring
    rw [heq, abs_mul, abs_of_nonneg hm]
    exact hlogErr.trans_eq (by ring)
  have hsq : d ^ 2 ≤ 4 * (m : ℝ) ^ 2 * x ^ 4 := by
    have hp := pow_le_pow_left₀ (abs_nonneg d) hdBound 2
    rw [sq_abs] at hp
    exact hp.trans_eq (by ring)
  have hinner : |Real.exp d - (1 - (m : ℝ) * x ^ 2 / 2)| ≤
      4 * (m : ℝ) ^ 2 * x ^ 4 + 2 * (m : ℝ) * x ^ 3 := by
    have h := abs_add_le (Real.exp d - 1 - d) (d + (m : ℝ) * x ^ 2 / 2)
    have hrewrite : Real.exp d - 1 - d + (d + (m : ℝ) * x ^ 2 / 2) =
        Real.exp d - (1 - (m : ℝ) * x ^ 2 / 2) := by ring
    rw [hrewrite] at h
    exact h.trans (add_le_add (he.trans hsq) hδ)
  have hpow : (1 - x) ^ m = e * Real.exp d := by
    unfold e d
    rw [← Real.exp_add, show -(m : ℝ) * x + (m : ℝ) * (Real.log (1 - x) + x) =
      (m : ℝ) * Real.log (1 - x) by ring, Real.exp_nat_mul, Real.exp_log (by linarith)]
  have hePos : 0 < e := Real.exp_pos _
  have heBound : e ≤ 1 := Real.exp_le_one_iff.mpr (mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr hm) hx)
  rw [hpow, ← mul_sub, abs_mul, abs_of_nonneg hePos.le]
  exact (mul_le_mul_of_nonneg_right heBound (abs_nonneg _)).trans (by simpa only [one_mul] using hinner)

/-- The two parity powers have the stated corrections with explicit quadratic inverse-bin errors. -/
theorem parity_powers_second_order (m k : ℕ) (hk : 8 ≤ k) (hsmall : 32 * (m : ℝ) / (k : ℝ) ^ 2 ≤ 1) :
    let lambda := (m : ℝ) / (k : ℝ)
    let a := singleParityMean (Fin m) (Fin k)
    let b := pairParityMean (Fin m) (Fin k)
    |a ^ 2 - Real.exp (-(4 * lambda)) * (1 - 4 * lambda / (k : ℝ))| ≤
        (256 * lambda ^ 2 + 32 * lambda) / (k : ℝ) ^ 2 ∧
      |b - Real.exp (-(4 * lambda)) * (1 - 8 * lambda / (k : ℝ))| ≤
        (1024 * lambda ^ 2 + 128 * lambda) / (k : ℝ) ^ 2 := by
  let K := (k : ℝ)
  change 32 * (m : ℝ) / K ^ 2 ≤ 1 at hsmall
  have hK : 0 < K := by
    change 0 < (k : ℝ)
    exact_mod_cast (show 0 < k by omega)
  have hK8 : 8 ≤ K := by
    change 8 ≤ (k : ℝ)
    exact_mod_cast hk
  have hx : 2 / K ≤ 1 / 2 := (div_le_iff₀ hK).mpr (by linarith)
  have hy : 4 / K ≤ 1 / 2 := (div_le_iff₀ hK).mpr (by linarith)
  have hs₁ : 2 * ((2 * m : ℕ) : ℝ) * (2 / K) ^ 2 ≤ 1 := by
    have h : 2 * ((2 * m : ℕ) : ℝ) * (2 / K) ^ 2 =
        (32 * (m : ℝ) / K ^ 2) / 2 := by push_cast; ring
    rw [h]
    linarith
  have hs₂ : 2 * (m : ℝ) * (4 / K) ^ 2 ≤ 1 := by
    rw [show 2 * (m : ℝ) * (4 / K) ^ 2 = 32 * (m : ℝ) / K ^ 2 by ring]
    exact hsmall
  have ha := binPower_second_order (2 * m) (2 / K) (by positivity) hx hs₁
  have hb := binPower_second_order m (4 / K) (by positivity) hy hs₂

  have harg₁ : -((2 * m : ℕ) : ℝ) * (2 / K) = -(4 * ((m : ℝ) / K)) := by
    push_cast
    ring
  have hshift₁ : ((2 * m : ℕ) : ℝ) * (2 / K) ^ 2 / 2 = 4 * ((m : ℝ) / K) / K := by
    push_cast
    field_simp [hK.ne']
    ring
  have herror₁ : 4 * ((2 * m : ℕ) : ℝ) ^ 2 * (2 / K) ^ 4 +
      2 * ((2 * m : ℕ) : ℝ) * (2 / K) ^ 3 =
        (256 * ((m : ℝ) / K) ^ 2 + 32 * ((m : ℝ) / K)) / K ^ 2 := by
    push_cast
    field_simp [hK.ne']
    ring
  have harg₂ : -(m : ℝ) * (4 / K) = -(4 * ((m : ℝ) / K)) := by ring
  have hshift₂ : (m : ℝ) * (4 / K) ^ 2 / 2 = 8 * ((m : ℝ) / K) / K := by
    field_simp [hK.ne']
    ring
  have herror₂ : 4 * (m : ℝ) ^ 2 * (4 / K) ^ 4 + 2 * (m : ℝ) * (4 / K) ^ 3 =
        (1024 * ((m : ℝ) / K) ^ 2 + 128 * ((m : ℝ) / K)) / K ^ 2 := by
    field_simp [hK.ne']
    ring
  rw [harg₁, hshift₁, herror₁] at ha
  rw [harg₂, hshift₂, herror₂] at hb
  dsimp only
  simp only [singleParityMean, pairParityMean, Fintype.card_fin]
  rw [← pow_mul, Nat.mul_comm m 2]
  exact ⟨ha, hb⟩

end TwoColorNullity.Occupancy
