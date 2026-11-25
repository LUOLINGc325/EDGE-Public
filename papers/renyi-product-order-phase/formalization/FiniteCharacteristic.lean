import CumulantDerivatives
import Mathlib.Analysis.SpecialFunctions.Complex.Log

/-! The characteristic function of an actual positive finite law. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

namespace FiniteMass

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

noncomputable def complexExpect (p : FiniteMass κ) (f : κ → ℂ) : ℂ :=
  ∑ i, (p i : ℂ) * f i

theorem complex_expect_real (p : FiniteMass κ) (f : κ → ℂ) :
    (p.complexExpect f).re = p.expect (fun i => (f i).re) := by
  unfold complexExpect expect
  change Complex.reAddGroupHom (∑ i, (p i : ℂ) * f i) = _
  rw [map_sum]
  simp only [Complex.coe_reAddGroupHom, Complex.mul_re, Complex.ofReal_re,
    Complex.ofReal_im, zero_mul, sub_zero]

theorem complex_expect_imag (p : FiniteMass κ) (f : κ → ℂ) :
    (p.complexExpect f).im = p.expect (fun i => (f i).im) := by
  unfold complexExpect expect
  change Complex.imAddGroupHom (∑ i, (p i : ℂ) * f i) = _
  rw [map_sum]
  simp only [Complex.coe_imAddGroupHom, Complex.mul_im, Complex.ofReal_re,
    Complex.ofReal_im, zero_mul, add_zero]

theorem complex_expect_const (p : FiniteMass κ) (c : ℂ) :
    p.complexExpect (fun _ => c) = c := by
  unfold complexExpect
  have h : (∑ i, (p i : ℂ)) = (↑(∑ i, p i) : ℂ) :=
    (map_sum Complex.ofRealHom (fun i : κ => p i) Finset.univ).symm
  rw [← Finset.sum_mul, h, p.total, Complex.ofReal_one, one_mul]

theorem complex_expect_tensor [DecidableEq ι] (p : ι → FiniteMass κ) (g : ι → κ → ℂ) :
    (tensor p).complexExpect (fun x => ∏ i, g i (x i)) =
      ∏ i, (p i).complexExpect (g i) := by
  unfold complexExpect
  calc
    _ = ∑ x : ι → κ, ∏ i, (p i (x i) : ℂ) * g i (x i) := by
      refine Finset.sum_congr rfl fun x _ => ?_
      simp only [tensor_apply, Complex.ofReal_prod, Finset.prod_mul_distrib]
    _ = _ := (Fintype.prod_sum (fun (i : ι) (y : κ) => (p i y : ℂ) * g i y)).symm

end FiniteMass

variable {κ : Type*} [Fintype κ]

noncomputable def fourierPhase (t : ℝ) : ℂ :=
  Complex.exp ((↑(2 * Real.pi * t) : ℂ) * Complex.I)

theorem fourier_phase_norm (t : ℝ) : ‖fourierPhase t‖ = 1 := by
  rw [fourierPhase, Complex.norm_exp]
  simp [Complex.mul_re]

theorem fourier_phase_add (s t : ℝ) : fourierPhase (s + t) = fourierPhase s * fourierPhase t := by
  unfold fourierPhase
  rw [← Complex.exp_add]
  congr 1
  push_cast
  ring

theorem fourier_phase_zero : fourierPhase 0 = 1 := by simp [fourierPhase]

theorem fourier_phase_period {s t : ℝ} (h : fourierPhase s = fourierPhase t) :
    ∃ j : ℤ, s - t = (j : ℝ) := by
  obtain ⟨j, hj⟩ := Complex.exp_eq_exp_iff_exists_int.mp h
  have he : 2 * Real.pi * s = 2 * Real.pi * t + (j : ℝ) * (2 * Real.pi) := by
    simpa [Complex.add_im, Complex.mul_im, Complex.mul_re] using congrArg Complex.im hj
  refine ⟨j, ?_⟩
  have hz : (2 * Real.pi) * (s - t - (j : ℝ)) = 0 := by nlinarith only [he]
  exact sub_eq_zero.mp ((mul_eq_zero.mp hz).resolve_left (by positivity))

noncomputable def characteristic (p : FiniteMass κ) (Y : κ → ℝ) (t : ℝ) : ℂ :=
  p.complexExpect (fun y => fourierPhase (t * Y y))

theorem characteristic_zero (p : FiniteMass κ) (Y : κ → ℝ) :
    characteristic p Y 0 = 1 := by
  simp only [characteristic, zero_mul, fourier_phase_zero, FiniteMass.complex_expect_const]

theorem characteristic_continuous (p : FiniteMass κ) (Y : κ → ℝ) :
    Continuous (characteristic p Y) := by
  unfold characteristic FiniteMass.complexExpect fourierPhase
  exact continuous_finset_sum _ (fun i _ => by fun_prop)

theorem characteristic_norm_le_one (p : FiniteMass κ) (Y : κ → ℝ) (t : ℝ) :
    ‖characteristic p Y t‖ ≤ 1 := by
  unfold characteristic FiniteMass.complexExpect
  calc
    _ ≤ ∑ i, ‖(p i : ℂ) * fourierPhase (t * Y i)‖ := norm_sum_le _ _
    _ = _ := by
      have h (i : κ) : ‖(p i : ℂ)‖ = p i := Complex.norm_of_nonneg (p.weight_nonneg i)
      simp only [norm_mul, h, fourier_phase_norm, mul_one, p.total]

theorem phase_squared_coordinates (z : ℂ) : z.re ^ 2 + z.im ^ 2 = ‖z‖ ^ 2 := by
  rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
  ring

theorem characteristic_deviation (p : FiniteMass κ) (Y : κ → ℝ) (t : ℝ) :
    p.expect (fun y =>
      ((fourierPhase (t * Y y)).re - (characteristic p Y t).re) ^ 2 +
      ((fourierPhase (t * Y y)).im - (characteristic p Y t).im) ^ 2) =
      1 - ‖characteristic p Y t‖ ^ 2 := by
  let f (y : κ) := (fourierPhase (t * Y y)).re
  let g (y : κ) := (fourierPhase (t * Y y)).im
  let z := characteristic p Y t
  have hF : z.re = p.expect f := p.complex_expect_real _
  have hG : z.im = p.expect g := p.complex_expect_imag _
  have hAdd (a b : κ → ℝ) : p.expect (fun i => a i + b i) = p.expect a + p.expect b := by
    simpa only [one_mul] using p.expect_linear a b 1 1
  have hSquare : p.expect (fun y => f y ^ 2) + p.expect (fun y => g y ^ 2) = 1 := by
    rw [← hAdd]
    have h (i : κ) : f i ^ 2 + g i ^ 2 = 1 := by
      unfold f g
      rw [phase_squared_coordinates, fourier_phase_norm, one_pow]
    simp only [h, FiniteMass.expect_const]
  change p.expect (fun y => (f y - z.re) ^ 2 + (g y - z.im) ^ 2) = 1 - ‖z‖ ^ 2
  rw [hF, hG, hAdd, p.expect_centered_square, p.expect_centered_square,
    ← phase_squared_coordinates z, hF, hG]
  linarith only [hSquare]

def ArithmeticSupport (Y : κ → ℝ) : Prop :=
  ∃ c h : ℝ, 0 < h ∧ ∀ y, ∃ z : ℤ, Y y = c + h * (z : ℝ)

theorem lattice_of_characteristic_unit (p : FiniteMass κ) (hp : ∀ y, 0 < p y)
    (Y : κ → ℝ) {t : ℝ} (ht : t ≠ 0) (h : ‖characteristic p Y t‖ = 1) :
    ∃ a : ℝ, ∀ i, ∃ k : ℤ, Y i = a + |t|⁻¹ * (k : ℝ) := by
  let z := characteristic p Y t
  let V (y : κ) := ((fourierPhase (t * Y y)).re - z.re) ^ 2 +
    ((fourierPhase (t * Y y)).im - z.im) ^ 2
  have hE : p.expect V = 0 := by
    rw [show p.expect V = 1 - ‖characteristic p Y t‖ ^ 2 from characteristic_deviation p Y t, h]
    norm_num
  have hPhase (y : κ) : fourierPhase (t * Y y) = z := by
    have hV₀ (i : κ) : 0 ≤ V i := add_nonneg (sq_nonneg _) (sq_nonneg _)
    have he : V y = 0 := by
      by_contra hn
      have hz := p.expect_pos hV₀ (hp y) (lt_of_le_of_ne (hV₀ y) (Ne.symm hn))
      rw [hE] at hz
      exact (lt_irrefl 0) hz
    change ((fourierPhase (t * Y y)).re - z.re) ^ 2 +
      ((fourierPhase (t * Y y)).im - z.im) ^ 2 = 0 at he
    apply Complex.ext
    · by_contra hne
      have hpos := sq_pos_of_ne_zero (sub_ne_zero.mpr hne)
      linarith only [he, hpos, sq_nonneg ((fourierPhase (t * Y y)).im - z.im)]
    · by_contra hne
      have hpos := sq_pos_of_ne_zero (sub_ne_zero.mpr hne)
      linarith only [he, hpos, sq_nonneg ((fourierPhase (t * Y y)).re - z.re)]
  obtain ⟨y, _⟩ := p.exists_weight_pos
  refine ⟨Y y, ?_⟩
  intro i
  obtain ⟨m, hm⟩ := fourier_phase_period ((hPhase i).trans (hPhase y).symm)
  have hd : Y i - Y y = (m : ℝ) / t := (eq_div_iff ht).2 (by nlinarith only [hm])
  have he : Y i = Y y + (m : ℝ) / t := by rw [← hd]; ring
  rcases lt_or_gt_of_ne ht with ht₀ | ht₀
  · refine ⟨-m, ?_⟩
    rw [abs_of_neg ht₀, inv_neg, Int.cast_neg, neg_mul_neg, he, div_eq_mul_inv, mul_comm (m : ℝ)]
  · refine ⟨m, ?_⟩
    rw [abs_of_pos ht₀, he, div_eq_mul_inv, mul_comm (m : ℝ)]

theorem characteristic_norm_strict_nonarithmetic (p : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (Y : κ → ℝ) (hY : ¬ ArithmeticSupport Y)
    {t : ℝ} (ht : t ≠ 0) : ‖characteristic p Y t‖ < 1 := by
  refine lt_of_le_of_ne (characteristic_norm_le_one p Y t) (fun he => hY ?_)
  obtain ⟨a, ha⟩ := lattice_of_characteristic_unit p hp Y ht he
  exact ⟨a, |t|⁻¹, inv_pos.mpr (abs_pos.mpr ht), ha⟩

end RenyiProductOrderPhase
