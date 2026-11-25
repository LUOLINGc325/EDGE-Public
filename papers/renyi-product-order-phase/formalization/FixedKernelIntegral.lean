import GrowingKernelIntegral
import Mathlib.Analysis.SpecialFunctions.Gamma.Beta

/-! The positive-half-line beta integral and the exact fixed-order tilted constant. -/

open Set MeasureTheory

namespace RenyiProductOrderPhase

noncomputable def betaOnUnit (u v x : ℝ) : ℝ := x ^ (u - 1) * (1 - x) ^ (v - 1)

noncomputable def betaOnPositive (u v x : ℝ) : ℝ := x ^ (u - 1) * (1 + x) ^ (-(u + v))

theorem beta_on_unit_complex (u v : ℝ) {x : ℝ} (hx : x ∈ Ioo (0 : ℝ) 1) :
    (x : ℂ) ^ ((u : ℂ) - 1) * (1 - (x : ℂ)) ^ ((v : ℂ) - 1) =
      (betaOnUnit u v x : ℂ) := by
  unfold betaOnUnit
  rw [Complex.ofReal_mul, Complex.ofReal_cpow hx.1.le, Complex.ofReal_cpow (sub_nonneg.mpr hx.2.le)]
  push_cast
  rfl

theorem beta_positive_jacobian (u v : ℝ) :
    (∫ x in Ioi 0, betaOnPositive u v x) = (∫ x in Ioo 0 1, betaOnUnit u v x) ∧
      (IntegrableOn (betaOnUnit u v) (Ioo 0 1) ↔ IntegrableOn (betaOnPositive u v) (Ioi 0)) := by
  let f (x : ℝ) := x / (1 + x)
  let d (x : ℝ) := ((1 + x) ^ 2)⁻¹
  have hImage : f '' Ioi (0 : ℝ) = Ioo 0 1 := by
    ext y
    constructor
    · rintro ⟨x, hx, rfl⟩
      have hx' : 0 < x := hx
      have hp : 0 < 1 + x := by linarith
      exact ⟨div_pos hx' hp, (div_lt_one hp).2 (by linarith)⟩
    · intro hy
      let x := y / (1 - y)
      refine ⟨x, div_pos hy.1 (sub_pos.mpr hy.2), ?_⟩
      have he : 1 + x = 1 / (1 - y) := by
        unfold x
        field_simp [(sub_pos.mpr hy.2).ne']
      unfold f x
      change x / (1 + x) = y
      rw [he]
      unfold x
      field_simp [(sub_pos.mpr hy.2).ne']
  have hDeriv (x : ℝ) (hx : x ∈ Ioi (0 : ℝ)) :
      HasDerivWithinAt f (d x) (Ioi 0) x := by
    have hx' : 0 < x := hx
    have hp : 0 < 1 + x := by linarith
    have h := (hasDerivAt_id x).div (((hasDerivAt_id x).const_add 1)) hp.ne'
    have he : (1 * (1 + x) - x * 1) / (1 + x) ^ 2 = d x := by
      unfold d
      rw [one_mul, mul_one, add_sub_cancel_right, one_div]
    simp only [id_eq] at h
    rw [he] at h
    exact h.hasDerivWithinAt
  have hInj : InjOn f (Ioi (0 : ℝ)) := by
    intro x hx y hy he
    have hX : 0 < x := hx
    have hY : 0 < y := hy
    have ha : 0 < 1 + x := by linarith
    have hb : 0 < 1 + y := by linarith
    have hh := (div_eq_div_iff ha.ne' hb.ne').1 he
    linarith only [show x * (1 + y) - y * (1 + x) = x - y by ring, hh]
  have hPoint (x : ℝ) (hx : x ∈ Ioi (0 : ℝ)) : |d x| • betaOnUnit u v (f x) =
      betaOnPositive u v x := by
    have hX : 0 < x := hx
    have hp : 0 < 1 + x := by linarith
    have hd : 0 < d x := inv_pos.mpr (pow_pos hp 2)
    have he : 1 - f x = (1 + x)⁻¹ := by
      unfold f
      field_simp [hp.ne']
    have hPow : d x = (1 + x) ^ (-2 : ℝ) := by
      rw [Real.rpow_neg hp.le]
      norm_num [d]
    rw [abs_of_pos hd, hPow]
    unfold betaOnUnit betaOnPositive
    rw [he, Real.inv_rpow hp.le, ← Real.rpow_neg hp.le]
    unfold f
    rw [Real.div_rpow hX.le hp.le, div_eq_mul_inv, ← Real.rpow_neg hp.le, smul_eq_mul]
    calc
      _ = x ^ (u - 1) * (((1 + x) ^ (-(u - 1)) * (1 + x) ^ (-(v - 1))) *
          (1 + x) ^ (-2 : ℝ)) := by ring
      _ = _ := by
        rw [← Real.rpow_add hp, ← Real.rpow_add hp]
        congr 2
        ring
  have h := integral_image_eq_integral_abs_deriv_smul measurableSet_Ioi hDeriv hInj (betaOnUnit u v)
  rw [hImage, setIntegral_congr_fun measurableSet_Ioi hPoint] at h
  have hInt := integrableOn_image_iff_integrableOn_abs_deriv_smul measurableSet_Ioi hDeriv hInj
    (betaOnUnit u v)
  rw [hImage] at hInt
  have hAE : (fun x => |d x| • betaOnUnit u v (f x)) =ᵐ[volume.restrict (Ioi 0)] betaOnPositive u v := by
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
    exact hPoint x hx
  exact ⟨h.symm, hInt.trans (integrable_congr hAE)⟩

theorem beta_positive_gamma {u v : ℝ} (hu : 0 < u) (hv : 0 < v) :
    IntegrableOn (betaOnPositive u v) (Ioi 0) ∧
      (∫ x in Ioi 0, betaOnPositive u v x) = Real.Gamma u * Real.Gamma v / Real.Gamma (u + v) := by
  have hCu : 0 < ((u : ℂ)).re := by simpa using hu
  have hCv : 0 < ((v : ℂ)).re := by simpa using hv
  have hZeroOne : (0 : ℝ) ≤ 1 := by norm_num
  have hComplex := Complex.betaIntegral_convergent hCu hCv
  have hUnit : IntegrableOn (betaOnUnit u v) (Ioo 0 1) := by
    have hInt := hComplex.1.mono_set Ioo_subset_Ioc_self
    apply hInt.norm.congr
    filter_upwards [ae_restrict_mem (measurableSet_Ioo : MeasurableSet (Ioo (0 : ℝ) 1))] with x hx
    rw [beta_on_unit_complex u v hx, Complex.norm_of_nonneg]
    unfold betaOnUnit
    exact mul_nonneg (Real.rpow_nonneg hx.1.le _) (Real.rpow_nonneg (sub_nonneg.mpr hx.2.le) _)
  have hBeta : Complex.betaIntegral (u : ℂ) (v : ℂ) =
      ((∫ x in Ioo 0 1, betaOnUnit u v x : ℝ) : ℂ) := by
    rw [Complex.betaIntegral, intervalIntegral.integral_of_le hZeroOne,
      integral_Ioc_eq_integral_Ioo, ← integral_complex_ofReal]
    exact setIntegral_congr_fun measurableSet_Ioo (fun _ hx => beta_on_unit_complex u v hx)
  have hProd := Complex.Gamma_mul_Gamma_eq_betaIntegral hCu hCv
  rw [hBeta, ← Complex.ofReal_add] at hProd
  simp only [Complex.Gamma_ofReal, ← Complex.ofReal_mul] at hProd
  have hReal := Complex.ofReal_inj.mp hProd
  refine ⟨(beta_positive_jacobian u v).2.1 hUnit, ?_⟩
  rw [(beta_positive_jacobian u v).1]
  exact (eq_div_iff (Real.Gamma_pos_of_pos (add_pos hu hv)).ne').2
    ((mul_comm _ _).trans hReal.symm)

theorem fixed_tilted_kernel_gamma {a b θ : ℝ} (ha : 0 < a) (hb : 1 ≤ b)
    (hθ : 0 < θ) (hθ' : θ < 1) :
    (∫ s, tiltedKernel b a θ s) =
      a ^ θ * Real.Gamma (1 - θ) * Real.Gamma (b + θ) / (θ * Real.Gamma b) := by
  let w (s : ℝ) := a * Real.exp s
  let v (s : ℝ) := kernelGap b (w s)
  let v' (s : ℝ) := b * (w s * (1 + w s) ^ (-b - 1))
  let g := betaOnPositive (1 - θ) (b + θ)
  have hw (s : ℝ) : 0 < w s := mul_pos ha (Real.exp_pos _)
  have hV (s : ℝ) : HasDerivAt v (v' s) s := by
    have hW : HasDerivAt w (w s) s := (Real.hasDerivAt_exp s).const_mul a
    have hPos : 0 < 1 + w s := by linarith only [hw s]
    have h := (hW.const_add 1).rpow_const (p := -b) (Or.inl hPos.ne')
    unfold v kernelGap v'
    convert (hasDerivAt_const s (1 : ℝ)).sub h using 1
    ring
  have hvMeas : Measurable v := by
    unfold v kernelGap w
    fun_prop
  have hInt : Integrable (fun s => Real.exp (-(θ * s)) * v s) := by
    apply integrable_exp_weighted_gap hθ hθ' hvMeas (A := b * a)
    · intro s
      exact (div_nonneg (hw s).le (by linarith only [hw s])).trans (kernel_gap_bounds hb (hw s).le).1
    · exact fun s => (kernel_gap_bounds hb (hw s).le).2.2.le
    · intro s
      have h := (kernel_gap_bounds hb (hw s).le).2.1
      unfold w at h
      simpa only [mul_assoc] using h
  have hBeta := beta_positive_gamma (sub_pos.mpr hθ') (show 0 < b + θ by linarith)
  have hIntG : IntegrableOn g (Ioi 0) := hBeta.1
  have hRep (s : ℝ) : Real.exp (-(θ * s)) * v' s = (b * a ^ θ) * (w s * g (w s)) := by
    rw [exponential_tilt_rescaling ha θ s]
    unfold v' g betaOnPositive
    rw [show (1 - θ) - 1 = -θ by ring, show -((1 - θ) + (b + θ)) = -b - 1 by ring]
    ring
  have hInt' : Integrable (fun s => Real.exp (-(θ * s)) * v' s) := by
    simpa only [hRep] using (integrable_scaled_exp_change ha hIntG).const_mul (b * a ^ θ)
  change (∫ s, Real.exp (-(θ * s)) * v s) = _
  rw [integral_exponential_tilt_by_parts hθ v v' hV hInt hInt']
  simp_rw [hRep, integral_const_mul]
  rw [scaled_exp_change_variables ha g]
  change b * a ^ θ * (∫ x in Ioi 0, betaOnPositive (1 - θ) (b + θ) x) / θ = _
  rw [hBeta.2, show (1 - θ) + (b + θ) = b + 1 by ring, Real.Gamma_add_one (by linarith : b ≠ 0)]
  field_simp [hθ.ne', (Real.Gamma_pos_of_pos (by linarith : 0 < b)).ne', (by linarith : b ≠ 0)]
  ring

end RenyiProductOrderPhase
