import LatticeStructure
import SmoothedFourierInterval
import Mathlib.Analysis.Complex.RealDeriv
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

/-! Orthogonality of lattice phases on one full frequency period. -/

open Set MeasureTheory

namespace RenyiProductOrderPhase

theorem fourier_phase_integer (k : ℤ) : fourierPhase (k : ℝ) = 1 := by
  unfold fourierPhase
  apply Complex.exp_eq_one_iff.2
  refine ⟨k, ?_⟩
  push_cast
  ring

theorem hasDerivAt_fourier_phase_mul (s t : ℝ) :
    HasDerivAt (fun u : ℝ => fourierPhase (u * s))
      (fourierPhase (t * s) * (((2 * Real.pi * s : ℝ) : ℂ) * Complex.I)) t := by
  have hlin : HasDerivAt (fun u : ℝ => 2 * Real.pi * (u * s)) (2 * Real.pi * s) t := by
    simpa only [one_mul] using (((hasDerivAt_id t).mul_const s).const_mul (2 * Real.pi))
  exact (hlin.ofReal_comp.mul_const Complex.I).cexp

theorem lattice_phase_orthogonality (h : ℝ) (hh : 0 < h) (k : ℤ) :
    let T := 1 / (2 * h)
    (∫ t in -T..T, fourierPhase (t * (h * (k : ℝ)))) =
      if k = 0 then ((1 / h : ℝ) : ℂ) else 0 := by
  let T := 1 / (2 * h)
  have hTwo : 2 * T = 1 / h := by
    apply (eq_div_iff hh.ne').2
    calc
      _ = (2 * h) * (1 / (2 * h)) := by unfold T; ring
      _ = _ := mul_div_cancel₀ _ (mul_ne_zero (by norm_num) hh.ne')
  change (∫ t in -T..T, fourierPhase (t * (h * (k : ℝ)))) = _
  by_cases hk : k = 0
  · subst k
    simp only [Int.cast_zero, mul_zero, fourier_phase_zero, if_pos rfl,
      intervalIntegral.integral_const, Complex.real_smul, mul_one]
    rw [show T - (-T) = 1 / h by linarith only [hTwo], if_true]
  · rw [if_neg hk]
    let c := h * (k : ℝ)
    let A : ℂ := ((2 * Real.pi * c : ℝ) : ℂ) * Complex.I
    have hc : c ≠ 0 := mul_ne_zero hh.ne' (Int.cast_ne_zero.mpr hk)
    have hA : A ≠ 0 :=
      mul_ne_zero (Complex.ofReal_ne_zero.mpr
        (mul_ne_zero (mul_ne_zero (by norm_num) Real.pi_ne_zero) hc)) Complex.I_ne_zero
    let F (t : ℝ) := fourierPhase (t * c) * A⁻¹
    have hD (t : ℝ) : HasDerivAt F (fourierPhase (t * c)) t := by
      have h := (hasDerivAt_fourier_phase_mul c t).mul_const A⁻¹
      convert h using 1
      change fourierPhase (t * c) = (fourierPhase (t * c) * A) * A⁻¹
      rw [mul_assoc, mul_inv_cancel₀ hA, mul_one]
    have hCont : Continuous (fun t : ℝ => fourierPhase (t * c)) :=
      fourier_phase_continuous.comp (continuous_id.mul continuous_const)
    change (∫ t in -T..T, fourierPhase (t * c)) = 0
    rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun t _ => hD t)
      (hCont.intervalIntegrable (-T) T)]
    have hLoc : T * c = (-T) * c + (k : ℝ) := by
      have hTh : T * h = 1 / 2 := by
        have hEv : (2 * T) * h = 1 := (eq_div_iff hh.ne').1 hTwo
        nlinarith only [hEv]
      calc
        _ = (T * h) * (k : ℝ) := by unfold c; ring
        _ = -(T * h) * (k : ℝ) + (k : ℝ) := by rw [hTh]; ring
        _ = _ := by unfold c; ring
    unfold F
    rw [hLoc, fourier_phase_add, fourier_phase_integer, mul_one, sub_self]

end RenyiProductOrderPhase
