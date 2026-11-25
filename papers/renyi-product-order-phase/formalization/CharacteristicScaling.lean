import CharacteristicGaussian
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics

/-! Tensor factorization and the centered characteristic function at Gaussian scaling. -/

open scoped BigOperators Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def iidSum {n : ℕ} (Y : κ → ℝ) (x : Fin n → κ) : ℝ := ∑ i, Y (x i)

theorem fourier_phase_sum {ι : Type*} (s : Finset ι) (f : ι → ℝ) :
    fourierPhase (∑ i ∈ s, f i) = ∏ i ∈ s, fourierPhase (f i) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp [fourier_phase_zero]
  | insert i s hi hs =>
    rw [Finset.sum_insert hi, Finset.prod_insert hi, fourier_phase_add, hs]

theorem characteristic_independent_sum (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ) (t : ℝ) :
    characteristic (FiniteMass.tensor (fun _ : Fin n => p)) (iidSum Y) t =
      characteristic p Y t ^ n := by
  calc
    _ = (FiniteMass.tensor (fun _ : Fin n => p)).complexExpect
        (fun x => ∏ i, fourierPhase (t * Y (x i))) := by
      unfold characteristic
      congr 1
      funext x
      rw [iidSum, Finset.mul_sum, fourier_phase_sum]
    _ = _ := by
      rw [FiniteMass.complex_expect_tensor (fun _ : Fin n => p)
        (fun _ y => fourierPhase (t * Y y))]
      simp only [characteristic, Finset.prod_const, Finset.card_univ, Fintype.card_fin]

theorem complex_unit_pow_difference (z w : ℂ) (hz : ‖z‖ ≤ 1) (hw : ‖w‖ ≤ 1) (n : ℕ) :
    ‖z ^ n - w ^ n‖ ≤ (n : ℝ) * ‖z - w‖ := by
  induction n with
  | zero => simp
  | succ n ih =>
    have h : z ^ (n + 1) - w ^ (n + 1) =
        z * (z ^ n - w ^ n) + (z - w) * w ^ n := by
      simp only [pow_succ]
      ring
    have hPow : ‖w ^ n‖ ≤ 1 := by
      rw [norm_pow]
      exact pow_le_one₀ (norm_nonneg _) hw
    have hZ := mul_le_mul_of_nonneg_right hz (norm_nonneg (z ^ n - w ^ n))
    have hW := mul_le_mul_of_nonneg_left hPow (norm_nonneg (z - w))
    calc
      _ ≤ ‖z * (z ^ n - w ^ n)‖ + ‖(z - w) * w ^ n‖ := by
        rw [h]
        exact norm_add_le _ _
      _ ≤ (n : ℝ) * ‖z - w‖ + ‖z - w‖ := by
        rw [norm_mul, norm_mul]
        simpa only [one_mul, mul_one] using add_le_add (hZ.trans (by simpa using ih)) hW
      _ = _ := by push_cast; ring

theorem real_exp_linear_remainder (z : ℝ) :
    |Real.exp z - (1 + z)| ≤ |z| ^ 2 * Real.exp |z| := by
  have h := Complex.norm_exp_sub_sum_le_norm_mul_exp (z : ℂ) 2
  have he : (∑ j ∈ Finset.range 2, (z : ℂ) ^ j / (j.factorial : ℂ)) =
      ((1 + z : ℝ) : ℂ) := by
    norm_num [Finset.sum_range_succ, Nat.factorial, Complex.ofReal_add]
  rw [he, ← Complex.ofReal_exp, ← Complex.ofReal_sub] at h
  simpa only [Complex.norm_real, Real.norm_eq_abs] using h

theorem characteristic_gaussian_remainder (p : FiniteMass κ) (Y : κ → ℝ)
    (hMean : p.expect Y = 0) (hVar : 0 < p.expect (fun i => Y i ^ 2)) :
    ∃ C ≥ 0, ∀ t : ℝ, |t| ≤ 1 →
      ‖characteristic p Y t -
        (Real.exp (-(2 * Real.pi ^ 2 * p.expect (fun i => Y i ^ 2)) * t ^ 2) : ℂ)‖ ≤
          C * |t| ^ 3 := by
  let k := 2 * Real.pi ^ 2 * p.expect (fun i => Y i ^ 2)
  let B := thirdRemainderWeight p Y
  have hk : 0 < k := mul_pos (mul_pos (by norm_num) (pow_pos Real.pi_pos 2)) hVar
  have hB : 0 ≤ B := third_remainder_weight_nonneg p Y
  refine ⟨B + k ^ 2 * Real.exp k,
    add_nonneg hB (mul_nonneg (sq_nonneg _) (Real.exp_pos _).le), ?_⟩
  intro t ht
  let c : ℂ := ((1 - k * t ^ 2 : ℝ) : ℂ)
  let e : ℂ := (Real.exp (-k * t ^ 2) : ℂ)
  have h0 : ‖characteristic p Y t - c‖ ≤ B * |t| ^ 3 :=
    centered_characteristic_remainder p Y hMean ht
  have hArg : |-k * t ^ 2| = k * |t| ^ 2 := by
    rw [abs_mul, abs_neg, abs_of_pos hk, abs_pow]
  have ht₂ : |t| ^ 2 ≤ 1 := pow_le_one₀ (abs_nonneg _) ht
  have hExp : Real.exp (k * |t| ^ 2) ≤ Real.exp k := by
    rw [Real.exp_le_exp]
    simpa only [mul_one] using mul_le_mul_of_nonneg_left ht₂ hk.le
  have h1 : ‖c - e‖ ≤ k ^ 2 * Real.exp k * |t| ^ 3 := by
    have h := real_exp_linear_remainder (-k * t ^ 2)
    rw [hArg] at h
    have hh : ‖c - e‖ = |Real.exp (-k * t ^ 2) - (1 + (-k * t ^ 2))| := by
      unfold c e
      rw [← Complex.ofReal_sub, Complex.norm_real, Real.norm_eq_abs]
      have hq : 1 - k * t ^ 2 = 1 + (-k * t ^ 2) := by ring
      rw [hq, abs_sub_comm]
    rw [hh]
    calc
      _ ≤ (k * |t| ^ 2) ^ 2 * Real.exp (k * |t| ^ 2) := h
      _ ≤ (k * |t| ^ 2) ^ 2 * Real.exp k :=
        mul_le_mul_of_nonneg_left hExp (sq_nonneg _)
      _ = (k ^ 2 * Real.exp k * |t| ^ 3) * |t| := by ring
      _ ≤ _ := mul_le_of_le_one_right
        (mul_nonneg (mul_nonneg (sq_nonneg _) (Real.exp_pos _).le) (pow_nonneg (abs_nonneg _) _)) ht
  change ‖characteristic p Y t - e‖ ≤ _
  calc
    _ ≤ ‖characteristic p Y t - c‖ + ‖c - e‖ := norm_sub_le_norm_sub_add_norm_sub _ _ _
    _ ≤ B * |t| ^ 3 + k ^ 2 * Real.exp k * |t| ^ 3 := add_le_add h0 h1
    _ = _ := by ring

theorem gaussian_scaling_power (k u : ℝ) {n : ℕ} (hn : 0 < n) :
    (Real.exp (-k * (u / Real.sqrt (n : ℝ)) ^ 2)) ^ n = Real.exp (-k * u ^ 2) := by
  have hN : (0 : ℝ) < n := by exact_mod_cast hn
  rw [← Real.exp_nat_mul, div_pow, Real.sq_sqrt hN.le]
  congr 1
  calc
    _ = (-k * u ^ 2) * ((n : ℝ) / (n : ℝ)) := by ring
    _ = _ := by rw [div_self hN.ne', mul_one]

theorem characteristic_scaled_error_bound (p : FiniteMass κ) (Y : κ → ℝ)
    (hMean : p.expect Y = 0) (hVar : 0 < p.expect (fun i => Y i ^ 2)) :
    ∃ C ≥ 0, ∀ (u : ℝ) (n : ℕ), 0 < n → |u| ≤ Real.sqrt (n : ℝ) →
      ‖characteristic p Y (u / Real.sqrt (n : ℝ)) ^ n -
        (Real.exp (-(2 * Real.pi ^ 2 * p.expect (fun i => Y i ^ 2)) * u ^ 2) : ℂ)‖ ≤
          C * |u| ^ 3 / Real.sqrt (n : ℝ) := by
  obtain ⟨C, hC, hf⟩ := characteristic_gaussian_remainder p Y hMean hVar
  refine ⟨C, hC, ?_⟩
  intro u n hn hu
  let k := 2 * Real.pi ^ 2 * p.expect (fun i => Y i ^ 2)
  let r := Real.sqrt (n : ℝ)
  let t := u / r
  let e : ℂ := (Real.exp (-k * t ^ 2) : ℂ)
  have hN : (0 : ℝ) < n := by exact_mod_cast hn
  have hr : 0 < r := Real.sqrt_pos.2 hN
  have hrt : r ^ 2 = (n : ℝ) := Real.sq_sqrt hN.le
  have ht : |t| ≤ 1 := by
    unfold t
    rw [abs_div, abs_of_pos hr]
    exact (div_le_one hr).2 hu
  have he : ‖e‖ ≤ 1 := by
    unfold e
    rw [Complex.norm_of_nonneg (Real.exp_pos _).le, ← Real.exp_zero, Real.exp_le_exp]
    have hk : 0 < k := mul_pos (mul_pos (by norm_num) (pow_pos Real.pi_pos 2)) hVar
    exact mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr hk.le) (sq_nonneg t)
  have hexp : e ^ n = (Real.exp (-k * u ^ 2) : ℂ) := by
    unfold e
    rw [← Complex.ofReal_pow, gaussian_scaling_power k u hn]
  change ‖characteristic p Y t ^ n - (Real.exp (-k * u ^ 2) : ℂ)‖ ≤ _
  rw [← hexp]
  calc
    _ ≤ (n : ℝ) * ‖characteristic p Y t - e‖ :=
      complex_unit_pow_difference _ _ (characteristic_norm_le_one p Y t) he n
    _ ≤ (n : ℝ) * (C * |t| ^ 3) := mul_le_mul_of_nonneg_left (hf t ht) hN.le
    _ = _ := by
      unfold t
      rw [abs_div, abs_of_pos hr, div_pow]
      change (n : ℝ) * (C * (|u| ^ 3 / r ^ 3)) = C * |u| ^ 3 / r
      calc
        _ = (n : ℝ) / r ^ 2 * (C * |u| ^ 3 / r) := by
          rw [show r ^ 3 = r ^ 2 * r from pow_succ r 2, ← div_div]
          simp only [div_eq_mul_inv]
          ring
        _ = _ := by rw [hrt, div_self hN.ne', one_mul]

end RenyiProductOrderPhase
