import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Analysis.SpecialFunctions.Exp

open MeasureTheory

namespace ResetCertificate

variable {μ : Measure ℝ} {f m : ℝ → ℝ} {c : ℝ}

/-- Subtracting the weight at the sign cut preserves the integral when the signed
function has zero mean. -/
private theorem centeredIntegral (hf : Integrable f μ)
    (hmf : Integrable (fun x => m x * f x) μ)
    (hzero : ∫ x, f x ∂μ = 0) :
    (∫ x, (m x - m c) * f x ∂μ) = ∫ x, m x * f x ∂μ := by
  simp only [sub_mul]
  rw [integral_sub hmf (hf.const_mul _), integral_const_mul, hzero, mul_zero, sub_zero]

private theorem centeredNonpos (hm : Monotone m)
    (hsign : ∀ᵐ x ∂μ, (x < c → 0 ≤ f x) ∧ (c < x → f x ≤ 0)) :
    ∀ᵐ x ∂μ, (m x - m c) * f x ≤ 0 := by
  filter_upwards [hsign] with x hx
  rcases lt_trichotomy x c with h | rfl | h
  · exact mul_nonpos_of_nonpos_of_nonneg (sub_nonpos.mpr (hm h.le)) (hx.1 h)
  · simp
  · exact mul_nonpos_of_nonneg_of_nonpos (sub_nonneg.mpr (hm h.le)) (hx.2 h)

/-- A nondecreasing weight gives a nonpositive integral against an integrable
mean-zero signed function that changes from nonnegative to nonpositive at a cut. -/
theorem integral_mul_nonpos (hf : Integrable f μ)
    (hmf : Integrable (fun x => m x * f x) μ)
    (hzero : ∫ x, f x ∂μ = 0) (hm : Monotone m)
    (hsign : ∀ᵐ x ∂μ, (x < c → 0 ≤ f x) ∧ (c < x → f x ≤ 0)) :
    (∫ x, m x * f x ∂μ) ≤ 0 := by
  rw [← centeredIntegral (c := c) hf hmf hzero]
  exact integral_nonpos_of_ae (centeredNonpos hm hsign)

/-- A positive-measure region of strict attenuation makes the integral strictly
negative. Using the support of the centered integrand allows for arbitrary
measures, including atoms at the cut. -/
theorem integral_mul_neg (hf : Integrable f μ)
    (hmf : Integrable (fun x => m x * f x) μ)
    (hzero : ∫ x, f x ∂μ = 0) (hm : Monotone m)
    (hsign : ∀ᵐ x ∂μ, (x < c → 0 ≤ f x) ∧ (c < x → f x ≤ 0))
    (hstrict : 0 < μ {x | (m x - m c) * f x ≠ 0}) :
    (∫ x, m x * f x ∂μ) < 0 := by
  have hcenter : Integrable (fun x => (m x - m c) * f x) μ := by
    simpa only [sub_mul] using hmf.sub (hf.const_mul (m c))
  have hnonneg : 0 ≤ᵐ[μ] (fun x => -((m x - m c) * f x)) := by
    filter_upwards [centeredNonpos hm hsign] with x hx
    exact neg_nonneg.mpr hx
  have hpos : 0 < ∫ x, -((m x - m c) * f x) ∂μ := by
    apply (integral_pos_iff_support_of_nonneg_ae hnonneg hcenter.neg).2
    simpa only [Function.support, neg_ne_zero] using hstrict
  rw [integral_neg, centeredIntegral hf hmf hzero] at hpos
  exact neg_pos.mp hpos

/-- The exterior Laplace-kernel ratio is nondecreasing in the integration
coordinate for a nonnegative kernel parameter. -/
theorem laplaceRatio_monotone {a : ℝ} (ha : 0 ≤ a) (s : ℝ) :
    Monotone (fun t : ℝ => Real.exp (a * (2 * min t s - s))) := by
  intro t u htu
  apply Real.exp_le_exp.mpr
  exact mul_le_mul_of_nonneg_left
    (sub_le_sub_right (mul_le_mul_of_nonneg_left (min_le_min htu le_rfl) (by norm_num)) _) ha

/-- The factor corresponding to the kernel at the cut enters the signed
function; the remaining exterior ratio enters the monotone weight. -/
theorem integral_laplace_nonpos {a s : ℝ} (ha : 0 ≤ a)
    (hf : Integrable (fun t => Real.exp (-a * t) * f t) μ)
    (hkf : Integrable (fun t => Real.exp (a * (2 * min t s - s - t)) * f t) μ)
    (hzero : ∫ t, Real.exp (-a * t) * f t ∂μ = 0)
    (hsign : ∀ᵐ t ∂μ, (t < c → 0 ≤ f t) ∧ (c < t → f t ≤ 0)) :
    (∫ t, Real.exp (a * (2 * min t s - s - t)) * f t ∂μ) ≤ 0 := by
  have hfactor (t : ℝ) :
      Real.exp (a * (2 * min t s - s - t)) * f t =
        Real.exp (a * (2 * min t s - s)) * (Real.exp (-a * t) * f t) := by
    rw [← mul_assoc, ← Real.exp_add]
    congr 2
    ring
  simp only [hfactor] at hkf ⊢
  apply integral_mul_nonpos hf hkf hzero (laplaceRatio_monotone ha s)
  filter_upwards [hsign] with t ht
  exact ⟨fun h => mul_nonneg (Real.exp_nonneg _) (ht.1 h),
    fun h => mul_nonpos_of_nonneg_of_nonpos (Real.exp_nonneg _) (ht.2 h)⟩

/-- Absolute-distance formulation of the exterior Laplace-kernel certificate.
The factor exp(-a*t) is the cut kernel when the integration coordinate
is nonnegative. -/
theorem integral_exterior_laplace_nonpos {a s : ℝ} (ha : 0 ≤ a)
    (hf : Integrable (fun t => Real.exp (-a * t) * f t) μ)
    (hkf : Integrable (fun t => Real.exp (-a * |s - t|) * f t) μ)
    (hzero : ∫ t, Real.exp (-a * t) * f t ∂μ = 0)
    (hsign : ∀ᵐ t ∂μ, (t < c → 0 ≤ f t) ∧ (c < t → f t ≤ 0)) :
    (∫ t, Real.exp (-a * |s - t|) * f t ∂μ) ≤ 0 := by
  have hkernel :
      (fun t => Real.exp (-a * |s - t|) * f t) =ᵐ[μ]
        (fun t => Real.exp (a * (2 * min t s - s - t)) * f t) := by
    filter_upwards with t
    have hexponent : -a * |s - t| = a * (2 * min t s - s - t) := by
      rcases le_total t s with h | h
      · rw [abs_of_nonneg (sub_nonneg.mpr h), min_eq_left h]
        ring
      · rw [abs_of_nonpos (sub_nonpos.mpr h), min_eq_right h]
        ring
    simp only [hexponent]
  rw [integral_congr_ae hkernel]
  exact integral_laplace_nonpos ha hf (hkf.congr hkernel) hzero hsign

end ResetCertificate

#print axioms ResetCertificate.integral_mul_nonpos

#print axioms ResetCertificate.integral_mul_neg
#print axioms ResetCertificate.laplaceRatio_monotone
#print axioms ResetCertificate.integral_laplace_nonpos
#print axioms ResetCertificate.integral_exterior_laplace_nonpos
