import OccupancyCurve
import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace TwoColorNullity.Occupancy

theorem log_one_sub_first_order (x : ℝ) (hhalf : x ≤ 1 / 2) :
    0 ≤ -x - Real.log (1 - x) ∧ -x - Real.log (1 - x) ≤ 2 * x ^ 2 := by
  have hpos : 0 < 1 - x := by linarith
  have hupper := Real.log_le_sub_one_of_pos hpos
  have hlower := Real.one_sub_inv_le_log_of_pos hpos
  have heq : -x - (1 - (1 - x)⁻¹) = x ^ 2 / (1 - x) := by
    field_simp [hpos.ne']
    ring
  have hquot : x ^ 2 / (1 - x) ≤ 2 * x ^ 2 := by
    apply (div_le_iff₀ hpos).mpr
    nlinarith only [mul_le_mul_of_nonneg_right hhalf (sq_nonneg x)]
  exact ⟨by linarith, (sub_le_sub_left hlower (-x)).trans (by rwa [heq])⟩

theorem exp_sub_le_sub_nonpositive (a b : ℝ) (hab : a ≤ b) (hb : b ≤ 0) :
    Real.exp b - Real.exp a ≤ b - a := by
  have h := Real.add_one_le_exp (a - b)
  have hle : 1 - Real.exp (a - b) ≤ b - a := by linarith
  have hmain := mul_le_mul_of_nonneg_left hle (Real.exp_pos b).le
  rw [mul_sub, mul_one, ← Real.exp_add, show b + (a - b) = a by ring] at hmain
  have hcap : Real.exp b ≤ 1 := by
    rw [← Real.exp_zero]
    exact Real.exp_le_exp.mpr hb
  exact hmain.trans (by simpa only [one_mul] using mul_le_mul_of_nonneg_right hcap (sub_nonneg.mpr hab))

theorem binPower_exp_approximation (m : ℕ) (x : ℝ) (h0 : 0 ≤ x) (hhalf : x ≤ 1 / 2) :
    0 ≤ Real.exp (-(m : ℝ) * x) - (1 - x) ^ m ∧
      Real.exp (-(m : ℝ) * x) - (1 - x) ^ m ≤ 2 * (m : ℝ) * x ^ 2 := by
  have hpos : 0 < 1 - x := by linarith
  obtain ⟨hlog, herr⟩ := log_one_sub_first_order x hhalf
  have hscale : 0 ≤ (m : ℝ) := Nat.cast_nonneg _
  have hab : (m : ℝ) * Real.log (1 - x) ≤ -(m : ℝ) * x := by
    have hs := mul_le_mul_of_nonneg_left (show Real.log (1 - x) ≤ -x by linarith) hscale
    simpa only [mul_neg, neg_mul] using hs
  have hnonpos : -(m : ℝ) * x ≤ 0 := mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr hscale) h0
  have hpow := exp_sub_le_sub_nonpositive _ _ hab hnonpos
  have hlo := Real.exp_le_exp.mpr hab
  rw [Real.exp_nat_mul, Real.exp_log hpos] at hpow hlo
  refine ⟨sub_nonneg.mpr hlo, hpow.trans ?_⟩
  have hscaled := mul_le_mul_of_nonneg_left herr hscale
  linarith only [hscaled]

theorem expectedOddCount_approximation (n bins : ℕ) (hn : 1 ≤ n) (hbins : 4 ≤ bins) :
    let m := 3 * n - 1
    |finiteMean (fun profile : Fin m → Fin bins => (oddBinCount profile : ℝ)) -
      (n : ℝ) * occupancyCurve ((bins : ℝ) / (n : ℝ))| ≤ 4 * (m : ℝ) / (bins : ℝ) + 1 := by
  dsimp only
  let m := 3 * n - 1
  let k := (bins : ℝ)
  let x := 2 / k
  letI : NeZero bins := ⟨by omega⟩
  have hk : 0 < k := by
    change 0 < (bins : ℝ)
    exact_mod_cast (show 0 < bins by omega)
  have hnR : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hk4 : 4 ≤ k := by
    change 4 ≤ (bins : ℝ)
    exact_mod_cast hbins
  have hx : 0 ≤ x := by positivity
  have hxhalf : x ≤ 1 / 2 := by
    unfold x
    apply (div_le_div_iff₀ hk (by norm_num)).mpr
    linarith only [hk4]
  have hm : (m : ℝ) = 3 * (n : ℝ) - 1 := by
    unfold m
    rw [Nat.cast_sub (by omega : 1 ≤ 3 * n), Nat.cast_mul, Nat.cast_ofNat, Nat.cast_one]
  have hbin := binPower_exp_approximation m x hx hxhalf
  let target := -(6 * (n : ℝ)) / k
  have hdiff : -(m : ℝ) * x = target + x := by
    unfold x target
    rw [hm]
    ring
  have ht : target ≤ -(m : ℝ) * x := by linarith
  have hnonpos : -(m : ℝ) * x ≤ 0 := mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (Nat.cast_nonneg m)) hx
  have he := exp_sub_le_sub_nonpositive _ _ ht hnonpos
  have he' : Real.exp (-(m : ℝ) * x) - Real.exp target ≤ x := by linarith
  have helower : Real.exp target ≤ Real.exp (-(m : ℝ) * x) := Real.exp_le_exp.mpr ht
  have habs : |Real.exp target - (1 - x) ^ m| ≤ 2 * (m : ℝ) * x ^ 2 + x := by
    apply abs_le.mpr
    constructor
    · have hpos : 0 ≤ 2 * (m : ℝ) * x ^ 2 := by positivity
      linarith only [hbin.1, he', hpos]
    · linarith only [hbin.2, helower, hx]
  have hcurve : (n : ℝ) * occupancyCurve (k / (n : ℝ)) = k / 2 * (1 - Real.exp target) := by
    unfold occupancyCurve
    have heq : -(6 : ℝ) / (k / (n : ℝ)) = target := by
      unfold target
      field_simp [hk.ne', hnR.ne']
    rw [heq]
    field_simp [hnR.ne']
  change |finiteMean (fun profile : Fin m → Fin bins => (oddBinCount profile : ℝ)) -
    (n : ℝ) * occupancyCurve (k / (n : ℝ))| ≤ 4 * (m : ℝ) / k + 1
  rw [oddBinCount_mean, Fintype.card_fin, Fintype.card_fin, hcurve]
  change |k / 2 * (1 - (1 - x) ^ m) - k / 2 * (1 - Real.exp target)| ≤ _
  rw [← mul_sub, show 1 - (1 - x) ^ m - (1 - Real.exp target) =
    Real.exp target - (1 - x) ^ m by ring, abs_mul, abs_of_nonneg (by positivity)]
  refine (mul_le_mul_of_nonneg_left habs (by positivity)).trans_eq ?_
  unfold x
  field_simp [hk.ne']
  ring

end TwoColorNullity.Occupancy
