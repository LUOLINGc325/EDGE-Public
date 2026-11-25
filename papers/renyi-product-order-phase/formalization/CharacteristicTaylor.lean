import FiniteCharacteristic
import Mathlib.Data.Complex.Exponential

/-! A uniform third-order remainder for the characteristic function of a finite centered law. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

namespace FiniteMass

variable {κ : Type*} [Fintype κ]

theorem complex_expect_coe (p : FiniteMass κ) (f : κ → ℝ) :
    p.complexExpect (fun i => (f i : ℂ)) = (p.expect f : ℂ) := by
  unfold complexExpect expect
  change _ = Complex.ofRealHom (∑ i, p i * f i)
  rw [map_sum]
  simp only [map_mul, Complex.ofRealHom_eq_coe]

theorem complex_expect_scale (p : FiniteMass κ) (f : κ → ℂ) (a : ℂ) :
    p.complexExpect (fun i => a * f i) = a * p.complexExpect f := by
  unfold complexExpect
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  ring

theorem complex_expect_add (p : FiniteMass κ) (f g : κ → ℂ) :
    p.complexExpect (fun i => f i + g i) = p.complexExpect f + p.complexExpect g := by
  unfold complexExpect
  simp only [mul_add, Finset.sum_add_distrib]

theorem complex_expect_sub (p : FiniteMass κ) (f g : κ → ℂ) :
    p.complexExpect (fun i => f i - g i) = p.complexExpect f - p.complexExpect g := by
  unfold complexExpect
  simp only [mul_sub, Finset.sum_sub_distrib]

theorem complex_expect_norm_le (p : FiniteMass κ) (f : κ → ℂ) :
    ‖p.complexExpect f‖ ≤ p.expect (fun i => ‖f i‖) := by
  unfold complexExpect expect
  calc
    _ ≤ ∑ i, ‖(p i : ℂ) * f i‖ := norm_sum_le _ _
    _ = _ := by
      have h (i : κ) : ‖(p i : ℂ)‖ = p i := Complex.norm_of_nonneg (p.weight_nonneg i)
      simp only [norm_mul, h]

end FiniteMass

variable {κ : Type*} [Fintype κ]

noncomputable def fourierArgument (t : ℝ) : ℂ := (↑(2 * Real.pi * t) : ℂ) * Complex.I

theorem fourier_argument_product (s t : ℝ) :
    fourierArgument (s * t) = fourierArgument s * (t : ℂ) := by
  unfold fourierArgument
  push_cast
  ring

theorem fourier_argument_norm (s t : ℝ) :
    ‖fourierArgument (s * t)‖ = |s| * |2 * Real.pi * t| := by
  unfold fourierArgument
  rw [norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs]
  rw [show 2 * Real.pi * (s * t) = s * (2 * Real.pi * t) by ring, abs_mul]

theorem fourier_argument_quadratic (s t : ℝ) :
    fourierArgument (s * t) ^ 2 / 2 =
      ((-2 * Real.pi ^ 2 * s ^ 2 : ℝ) : ℂ) * ((t ^ 2 : ℝ) : ℂ) := by
  unfold fourierArgument
  rw [mul_pow, Complex.I_sq]
  push_cast
  ring

theorem complex_exp_quadratic_remainder (z : ℂ) :
    ‖Complex.exp z - (1 + z + z ^ 2 / 2)‖ ≤ ‖z‖ ^ 3 * Real.exp ‖z‖ := by
  have h := Complex.norm_exp_sub_sum_le_norm_mul_exp z 3
  have hsum : (∑ j ∈ Finset.range 3, z ^ j / (j.factorial : ℂ)) =
      1 + z + z ^ 2 / 2 := by
    norm_num [Finset.sum_range_succ, Nat.factorial]
  rwa [hsum] at h

theorem centered_characteristic_polynomial (p : FiniteMass κ) (Y : κ → ℝ)
    (hY : p.expect Y = 0) (t : ℝ) :
    p.complexExpect (fun i => 1 + fourierArgument (t * Y i) +
      fourierArgument (t * Y i) ^ 2 / 2) =
      ((1 - 2 * Real.pi ^ 2 * p.expect (fun i => Y i ^ 2) * t ^ 2 : ℝ) : ℂ) := by
  rw [p.complex_expect_add, p.complex_expect_add, p.complex_expect_const]
  have hl : p.complexExpect (fun i => fourierArgument (t * Y i)) = 0 := by
    simp only [fourier_argument_product, p.complex_expect_scale, p.complex_expect_coe, hY,
      Complex.ofReal_zero, mul_zero]
  have hq :
      p.complexExpect (fun i => fourierArgument (t * Y i) ^ 2 / 2) =
        ((-2 * Real.pi ^ 2 * t ^ 2 : ℝ) : ℂ) * (p.expect (fun i => Y i ^ 2) : ℂ) := by
    simp only [fourier_argument_quadratic, p.complex_expect_scale, p.complex_expect_coe]
  rw [hl, hq]
  push_cast
  ring

noncomputable def thirdRemainderWeight (p : FiniteMass κ) (Y : κ → ℝ) : ℝ :=
  p.expect (fun i => |2 * Real.pi * Y i| ^ 3 * Real.exp |2 * Real.pi * Y i|)

theorem third_remainder_weight_nonneg (p : FiniteMass κ) (Y : κ → ℝ) :
    0 ≤ thirdRemainderWeight p Y :=
  p.expect_nonneg (fun i => mul_nonneg (pow_nonneg (abs_nonneg (2 * Real.pi * Y i)) 3)
    (Real.exp_pos |2 * Real.pi * Y i|).le)

theorem centered_characteristic_remainder (p : FiniteMass κ) (Y : κ → ℝ)
    (hY : p.expect Y = 0) {t : ℝ} (ht : |t| ≤ 1) :
    ‖characteristic p Y t -
      ((1 - 2 * Real.pi ^ 2 * p.expect (fun i => Y i ^ 2) * t ^ 2 : ℝ) : ℂ)‖ ≤
      thirdRemainderWeight p Y * |t| ^ 3 := by
  let z (i : κ) := fourierArgument (t * Y i)
  let g (i : κ) := Complex.exp (z i) - (1 + z i + z i ^ 2 / 2)
  have hnorm (i : κ) :
      ‖g i‖ ≤ |2 * Real.pi * Y i| ^ 3 * Real.exp |2 * Real.pi * Y i| * |t| ^ 3 := by
    have h := complex_exp_quadratic_remainder (z i)
    have hn : ‖z i‖ = |t| * |2 * Real.pi * Y i| := fourier_argument_norm t (Y i)
    have he : Real.exp ‖z i‖ ≤ Real.exp |2 * Real.pi * Y i| := by
      rw [hn, Real.exp_le_exp]
      exact mul_le_of_le_one_left (abs_nonneg _) ht
    calc
      _ ≤ ‖z i‖ ^ 3 * Real.exp ‖z i‖ := h
      _ ≤ ‖z i‖ ^ 3 * Real.exp |2 * Real.pi * Y i| :=
        mul_le_mul_of_nonneg_left he (pow_nonneg (norm_nonneg _) _)
      _ = _ := by rw [hn, mul_pow]; ring
  have hid : characteristic p Y t -
      ((1 - 2 * Real.pi ^ 2 * p.expect (fun i => Y i ^ 2) * t ^ 2 : ℝ) : ℂ) =
        p.complexExpect g := by
    change p.complexExpect (fun i => Complex.exp (z i)) - _ = _
    rw [← centered_characteristic_polynomial p Y hY t, ← p.complex_expect_sub]
  rw [hid]
  calc
    _ ≤ p.expect (fun i => ‖g i‖) := p.complex_expect_norm_le g
    _ ≤ p.expect (fun i => |2 * Real.pi * Y i| ^ 3 * Real.exp |2 * Real.pi * Y i| * |t| ^ 3) :=
      p.expect_mono hnorm
    _ = _ := by
      unfold thirdRemainderWeight FiniteMass.expect
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun i _ => ?_
      ring

end RenyiProductOrderPhase
