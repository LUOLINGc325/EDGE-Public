import TiltedKernels
import Mathlib.Analysis.SpecialFunctions.Gamma.Basic
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.MeasureTheory.Function.Jacobian

/-! Exact evaluation of the growing-order limiting tilted integral. -/

open Set MeasureTheory

namespace RenyiProductOrderPhase

noncomputable def growingLimitGap (z : ℝ) : ℝ := 1 - Real.exp (-z)

noncomputable def growingLimitKernel (a θ s : ℝ) : ℝ :=
  Real.exp (-(θ * s)) * growingLimitGap (a * Real.exp s)

theorem growing_limit_gap_bounds {z : ℝ} (hz : 0 ≤ z) :
    0 ≤ growingLimitGap z ∧ growingLimitGap z ≤ z ∧ growingLimitGap z ≤ 1 := by
  have h : Real.exp (-z) ≤ 1 := by
    simpa only [Real.exp_zero] using Real.exp_le_exp.2 (neg_nonpos.mpr hz)
  unfold growingLimitGap
  exact ⟨sub_nonneg.mpr h, by linarith only [Real.add_one_le_exp (-z)],
    sub_le_self _ (Real.exp_nonneg _)⟩

theorem integrable_exp_weighted_gap {θ A : ℝ} (hθ : 0 < θ) (hθ' : θ < 1)
    {f : ℝ → ℝ} (hf : Measurable f) (h₀ : ∀ s, 0 ≤ f s)
    (h₁ : ∀ s, f s ≤ 1) (h₂ : ∀ s, f s ≤ A * Real.exp s) :
    Integrable (fun s => Real.exp (-(θ * s)) * f s) := by
  let g (s : ℝ) := Real.exp (-(θ * s)) * f s
  have hE : Continuous (fun s : ℝ => Real.exp (-(θ * s))) := by fun_prop
  have hg : Measurable g := hE.measurable.mul hf
  let μL := (volume : Measure ℝ).restrict (Iic 0)
  let μR := (volume : Measure ℝ).restrict (Ioi 0)
  have hLeftDom : Integrable (fun s : ℝ => A * Real.exp ((1 - θ) * s)) μL :=
    (integrableOn_exp_mul_Iic (sub_pos.mpr hθ') 0).const_mul A
  have hRightDom : Integrable (fun s : ℝ => Real.exp ((-θ) * s)) μR :=
    integrableOn_exp_mul_Ioi (neg_lt_zero.mpr hθ) 0
  have hLeftBound (s : ℝ) : ‖g s‖ ≤ A * Real.exp ((1 - θ) * s) := by
    unfold g
    rw [Real.norm_of_nonneg (mul_nonneg (Real.exp_nonneg _) (h₀ s))]
    calc
      _ ≤ Real.exp (-(θ * s)) * (A * Real.exp s) :=
        mul_le_mul_of_nonneg_left (h₂ s) (Real.exp_nonneg _)
      _ = _ := by
        rw [show (1 - θ) * s = -(θ * s) + s by ring, Real.exp_add]
        ring
  have hRightBound (s : ℝ) : ‖g s‖ ≤ Real.exp ((-θ) * s) := by
    unfold g
    rw [Real.norm_of_nonneg (mul_nonneg (Real.exp_nonneg _) (h₀ s)), neg_mul]
    exact mul_le_of_le_one_right (Real.exp_nonneg _) (h₁ s)
  have hLeft : IntegrableOn g (Iic 0) :=
    hLeftDom.mono' hg.aestronglyMeasurable (Filter.Eventually.of_forall hLeftBound)
  have hRight : IntegrableOn g (Ioi 0) :=
    hRightDom.mono' hg.aestronglyMeasurable (Filter.Eventually.of_forall hRightBound)
  have hUnion : IntegrableOn g (Iic 0 ∪ Ioi 0) := integrableOn_union.2 ⟨hLeft, hRight⟩
  simpa only [Iic_union_Ioi, integrableOn_univ] using hUnion

theorem scaled_exp_image {a : ℝ} (ha : 0 < a) :
    (fun s : ℝ => a * Real.exp s) '' (univ : Set ℝ) = Ioi 0 := by
  ext z
  constructor
  · rintro ⟨s, _, rfl⟩
    exact mul_pos ha (Real.exp_pos _)
  · intro hz
    refine ⟨Real.log (z / a), mem_univ _, ?_⟩
    have hz' : 0 < z := hz
    change a * Real.exp (Real.log (z / a)) = z
    rw [Real.exp_log (div_pos hz' ha), mul_div_cancel₀ _ ha.ne']

theorem scaled_exp_change_variables {a : ℝ} (ha : 0 < a) (g : ℝ → ℝ) :
    (∫ s, (a * Real.exp s) * g (a * Real.exp s)) = ∫ z in Ioi 0, g z := by
  let f (s : ℝ) := a * Real.exp s
  have hImage : f '' (univ : Set ℝ) = Ioi 0 := scaled_exp_image ha
  have hD (s : ℝ) (_ : s ∈ (univ : Set ℝ)) : HasDerivWithinAt f (f s) univ s :=
    ((Real.hasDerivAt_exp s).const_mul a).hasDerivWithinAt
  have hInj : InjOn f (univ : Set ℝ) := fun x _ y _ h =>
    Real.exp_injective (mul_left_cancel₀ ha.ne' h)
  have h := integral_image_eq_integral_abs_deriv_smul MeasurableSet.univ hD hInj g
  rw [hImage, Measure.restrict_univ] at h
  have hAbs (s : ℝ) : |f s| = f s := abs_of_pos (mul_pos ha (Real.exp_pos _))
  simpa only [hAbs, smul_eq_mul, f] using h.symm

theorem integrable_scaled_exp_change {a : ℝ} (ha : 0 < a) {g : ℝ → ℝ}
    (hg : IntegrableOn g (Ioi 0)) : Integrable (fun s => (a * Real.exp s) * g (a * Real.exp s)) := by
  let f (s : ℝ) := a * Real.exp s
  have hImage : f '' (univ : Set ℝ) = Ioi 0 := scaled_exp_image ha
  have hD (s : ℝ) (_ : s ∈ (univ : Set ℝ)) : HasDerivWithinAt f (f s) univ s :=
    ((Real.hasDerivAt_exp s).const_mul a).hasDerivWithinAt
  have hInj : InjOn f (univ : Set ℝ) := fun x _ y _ h =>
    Real.exp_injective (mul_left_cancel₀ ha.ne' h)
  have h := integrableOn_image_iff_integrableOn_abs_deriv_smul MeasurableSet.univ hD hInj g
  rw [hImage, integrableOn_univ] at h
  have hAbs (s : ℝ) : |f s| = f s := abs_of_pos (mul_pos ha (Real.exp_pos _))
  simpa only [hAbs, smul_eq_mul, f] using h.1 hg

theorem exponential_tilt_rescaling {a : ℝ} (ha : 0 < a) (θ s : ℝ) :
    Real.exp (-(θ * s)) = a ^ θ * (a * Real.exp s) ^ (-θ) := by
  rw [Real.mul_rpow ha.le (Real.exp_nonneg _), Real.rpow_neg ha.le, ← Real.exp_mul,
    ← mul_assoc, mul_inv_cancel₀ (Real.rpow_pos_of_pos ha _).ne', one_mul]
  congr 1
  ring

theorem integral_exponential_tilt_by_parts {θ : ℝ} (hθ : 0 < θ)
    (v v' : ℝ → ℝ) (hV : ∀ s, HasDerivAt v (v' s) s)
    (h₁ : Integrable (fun s => Real.exp (-(θ * s)) * v s))
    (h₂ : Integrable (fun s => Real.exp (-(θ * s)) * v' s)) :
    (∫ s, Real.exp (-(θ * s)) * v s) = (∫ s, Real.exp (-(θ * s)) * v' s) / θ := by
  let u (s : ℝ) := Real.exp (-(θ * s))
  let u' (s : ℝ) := -θ * u s
  have hU (s : ℝ) : HasDerivAt u (u' s) s := by
    have h := (Real.hasDerivAt_exp (-(θ * s))).comp s
      (((hasDerivAt_id s).const_mul θ).neg)
    simpa only [u, u', id_eq, mul_one, mul_comm] using h
  have hProduct : (u' * v) = fun s => -θ * (u s * v s) := by
    funext s
    change (-θ * u s) * v s = -θ * (u s * v s)
    rw [mul_assoc]
  have hUV : Integrable (u' * v) := by
    rw [hProduct]
    exact h₁.const_mul (-θ)
  have h := integral_mul_deriv_eq_deriv_mul_of_integrable hU hV
    (show Integrable (u * v') from h₂) hUV (show Integrable (u * v) from h₁)
  have hEq : (∫ s, u' s * v s) = -θ * ∫ s, u s * v s := by
    change (∫ s, (u' * v) s) = _
    rw [hProduct, integral_const_mul]
  rw [hEq, neg_mul, neg_neg] at h
  apply (eq_div_iff hθ.ne').2
  exact (mul_comm _ _).trans h.symm

theorem growing_limit_kernel_gamma {a θ : ℝ} (ha : 0 < a) (hθ : 0 < θ) (hθ' : θ < 1) :
    (∫ s, growingLimitKernel a θ s) = a ^ θ * Real.Gamma (1 - θ) / θ := by
  let w (s : ℝ) := a * Real.exp s
  let v (s : ℝ) := growingLimitGap (w s)
  let v' (s : ℝ) := w s * Real.exp (-(w s))
  let g (z : ℝ) := Real.exp (-z) * z ^ (-θ)
  have hw (s : ℝ) : 0 < w s := mul_pos ha (Real.exp_pos _)
  have hV (s : ℝ) : HasDerivAt v (v' s) s := by
    have hW : HasDerivAt w (w s) s := (Real.hasDerivAt_exp s).const_mul a
    have he := (Real.hasDerivAt_exp (-(w s))).comp s hW.neg
    unfold v growingLimitGap v'
    simpa only [Function.comp_apply, mul_neg, neg_mul, zero_sub, neg_neg, mul_comm] using
      (hasDerivAt_const s (1 : ℝ)).sub he
  have hvMeas : Measurable v := by unfold v w growingLimitGap; fun_prop
  have hInt : Integrable (fun s => Real.exp (-(θ * s)) * v s) := by
    apply integrable_exp_weighted_gap hθ hθ' hvMeas
    · exact fun s => (growing_limit_gap_bounds (hw s).le).1
    · exact fun s => (growing_limit_gap_bounds (hw s).le).2.2
    · exact fun s => (growing_limit_gap_bounds (hw s).le).2.1
  have hG : IntegrableOn g (Ioi 0) := by
    simpa only [g, sub_sub_cancel_left, neg_sub, sub_self, zero_sub] using
      (Real.GammaIntegral_convergent (sub_pos.mpr hθ'))
  have hRep (s : ℝ) : Real.exp (-(θ * s)) * v' s = a ^ θ * (w s * g (w s)) := by
    rw [exponential_tilt_rescaling ha θ s]
    unfold w v' g
    ring
  have hInt' : Integrable (fun s => Real.exp (-(θ * s)) * v' s) := by
    simpa only [hRep] using (integrable_scaled_exp_change ha hG).const_mul (a ^ θ)
  change (∫ s, Real.exp (-(θ * s)) * v s) = _
  rw [integral_exponential_tilt_by_parts hθ v v' hV hInt hInt']
  simp_rw [hRep, integral_const_mul]
  rw [scaled_exp_change_variables ha g, Real.Gamma_eq_integral (sub_pos.mpr hθ')]
  simp only [g, sub_sub_cancel_left, neg_sub, sub_self, zero_sub]

end RenyiProductOrderPhase
