import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# The weighted threshold comparison used in the Mpemba preparation proof

This file formalizes the genuine Bochner-integral rearrangement step. It does
not formalize the delay equation, positivity/log-concavity of its fundamental
solution, or the scalar waiting-time optimization.

The mathematical input `Antitone q` is an explicit hypothesis, not an axiom
asserting that the physical delay kernel has this property.
-/

set_option autoImplicit false

open MeasureTheory

namespace Mpemba

variable {α : Type*}

/-- Centering a multiplier does not change the integral against a mean-zero
integrable function; the sign of the centered product proves nonnegativity. -/
theorem centered_integral_nonneg
    [MeasurableSpace α]
    (μ : Measure α) (q f : α → ℝ) (c : ℝ)
    (hf : Integrable f μ)
    (hqf : Integrable (fun x => q x * f x) μ)
    (hmean : (∫ x, f x ∂μ) = 0)
    (hsign : ∀ᵐ x ∂μ, 0 ≤ (q x - c) * f x) :
    0 ≤ ∫ x, q x * f x ∂μ := by
  have hnonneg := integral_nonneg_of_ae hsign
  have hcenter : (∫ x, (q x - c) * f x ∂μ) = ∫ x, q x * f x ∂μ := by
    simp_rw [sub_mul]
    rw [integral_sub hqf (hf.const_mul c), integral_const_mul, hmean,
      mul_zero, sub_zero]
  rw [hcenter] at hnonneg
  exact hnonneg

section Threshold

variable [LinearOrder α]

/-- A negative-then-positive bang-bang history. Its value at the switch is
chosen to be `1`; the comparison is valid even if the measure has an atom there. -/
def threshold (w x : α) : ℝ := if x < w then -1 else 1

/-- The two sides of a threshold have matching signs in the rearrangement. -/
theorem threshold_product_nonneg
    (q : α → ℝ) (w x : α) (r v : ℝ)
    (hq : Antitone q) (hr : 0 ≤ r) (hvlo : -1 ≤ v) (hvhi : v ≤ 1) :
    0 ≤ (q x - q w) * (r * (v - threshold w x)) := by
  unfold threshold
  split_ifs with hx
  · exact mul_nonneg (sub_nonneg.mpr (hq (le_of_lt hx)))
      (mul_nonneg hr (by linarith))
  · exact mul_nonneg_of_nonpos_of_nonpos
      (sub_nonpos.mpr (hq (le_of_not_gt hx)))
      (mul_nonpos_of_nonneg_of_nonpos hr (sub_nonpos.mpr hvhi))

/-- At equal weighted initial mean, the threshold history minimizes the
weighted response for every antitone likelihood ratio. All four integrability
requirements concern actual Bochner integrals and are stated explicitly. -/
theorem threshold_integral_comparison
    [MeasurableSpace α]
    (μ : Measure α) (ρ q v : α → ℝ) (w : α)
    (hq : Antitone q)
    (hρ : ∀ᵐ x ∂μ, 0 ≤ ρ x)
    (hv : ∀ᵐ x ∂μ, -1 ≤ v x ∧ v x ≤ 1)
    (hρv : Integrable (fun x => ρ x * v x) μ)
    (hρw : Integrable (fun x => ρ x * threshold w x) μ)
    (hqρv : Integrable (fun x => q x * (ρ x * v x)) μ)
    (hqρw : Integrable (fun x => q x * (ρ x * threshold w x)) μ)
    (hmean : (∫ x, ρ x * v x ∂μ) = ∫ x, ρ x * threshold w x ∂μ) :
    (∫ x, q x * (ρ x * threshold w x) ∂μ) ≤
      ∫ x, q x * (ρ x * v x) ∂μ := by
  let f : α → ℝ := fun x => ρ x * v x - ρ x * threshold w x
  have hf : Integrable f μ := hρv.sub hρw
  have hqf : Integrable (fun x => q x * f x) μ := by
    simpa only [f, mul_sub] using hqρv.sub hqρw
  have hfmean : (∫ x, f x ∂μ) = 0 := by
    dsimp [f]
    rw [integral_sub hρv hρw, hmean, sub_self]
  have hsign : ∀ᵐ x ∂μ, 0 ≤ (q x - q w) * f x := by
    filter_upwards [hρ, hv] with x hxρ hxv
    simpa only [f, mul_sub] using
      threshold_product_nonneg q w x (ρ x) (v x) hq hxρ hxv.1 hxv.2
  have hnonneg := centered_integral_nonneg μ q f (q w) hf hqf hfmean hsign
  have hsplit : (∫ x, q x * f x ∂μ) =
      (∫ x, q x * (ρ x * v x) ∂μ) -
      ∫ x, q x * (ρ x * threshold w x) ∂μ := by
    simp only [f, mul_sub]
    exact integral_sub hqρv hqρw
  rw [hsplit] at hnonneg
  exact sub_nonneg.mp hnonneg

/-- The pointwise nonnegative comparison product equals an absolute-value
deficit. This identity also covers a possible atom at the switching point. -/
theorem threshold_product_abs
    (q : α → ℝ) (w x : α) (r v : ℝ)
    (hq : Antitone q) (hr : 0 ≤ r) (hvlo : -1 ≤ v) (hvhi : v ≤ 1) :
    (q x - q w) * (r * (v - threshold w x)) =
      r * |q x - q w| * |v - threshold w x| := by
  calc
    (q x - q w) * (r * (v - threshold w x)) =
        |(q x - q w) * (r * (v - threshold w x))| :=
      (abs_of_nonneg
        (threshold_product_nonneg q w x r v hq hr hvlo hvhi)).symm
    _ = r * |q x - q w| * |v - threshold w x| := by
      rw [abs_mul, abs_mul, abs_of_nonneg hr]
      ring

/-- Exact nonnegative deficit formula, stronger than the integral comparison.
Its right-hand side measures departures from the threshold away from levels
where the likelihood ratio agrees with its value at the cut. -/
theorem threshold_integral_deficit
    [MeasurableSpace α]
    (μ : Measure α) (ρ q v : α → ℝ) (w : α)
    (hq : Antitone q)
    (hρ : ∀ᵐ x ∂μ, 0 ≤ ρ x)
    (hv : ∀ᵐ x ∂μ, -1 ≤ v x ∧ v x ≤ 1)
    (hρv : Integrable (fun x => ρ x * v x) μ)
    (hρw : Integrable (fun x => ρ x * threshold w x) μ)
    (hqρv : Integrable (fun x => q x * (ρ x * v x)) μ)
    (hqρw : Integrable (fun x => q x * (ρ x * threshold w x)) μ)
    (hmean : (∫ x, ρ x * v x ∂μ) = ∫ x, ρ x * threshold w x ∂μ) :
    (∫ x, q x * (ρ x * v x) ∂μ) -
      (∫ x, q x * (ρ x * threshold w x) ∂μ) =
      ∫ x, ρ x * |q x - q w| * |v x - threshold w x| ∂μ := by
  let f : α → ℝ := fun x => ρ x * v x - ρ x * threshold w x
  have hf : Integrable f μ := hρv.sub hρw
  have hqf : Integrable (fun x => q x * f x) μ := by
    simpa only [f, mul_sub] using hqρv.sub hqρw
  have hfmean : (∫ x, f x ∂μ) = 0 := by
    dsimp [f]
    rw [integral_sub hρv hρw, hmean, sub_self]
  have hsplit : (∫ x, q x * f x ∂μ) =
      (∫ x, q x * (ρ x * v x) ∂μ) -
      ∫ x, q x * (ρ x * threshold w x) ∂μ := by
    simp only [f, mul_sub]
    exact integral_sub hqρv hqρw
  have hcenter : (∫ x, (q x - q w) * f x ∂μ) = ∫ x, q x * f x ∂μ := by
    simp_rw [sub_mul]
    rw [integral_sub hqf (hf.const_mul (q w)), integral_const_mul,
      hfmean, mul_zero, sub_zero]
  have hpoint : (fun x => (q x - q w) * f x) =ᵐ[μ]
      (fun x => ρ x * |q x - q w| * |v x - threshold w x|) := by
    filter_upwards [hρ, hv] with x hxρ hxv
    simpa only [f, mul_sub] using
      threshold_product_abs q w x (ρ x) (v x) hq hxρ hxv.1 hxv.2
  calc
    (∫ x, q x * (ρ x * v x) ∂μ) -
        (∫ x, q x * (ρ x * threshold w x) ∂μ) =
        ∫ x, q x * f x ∂μ := hsplit.symm
    _ = ∫ x, (q x - q w) * f x ∂μ := hcenter.symm
    _ = ∫ x, ρ x * |q x - q w| * |v x - threshold w x| ∂μ :=
      integral_congr_ae hpoint

/-- Equality forces the threshold almost everywhere when the ratio is
strictly antitone, the weight is positive, and the cut is an almost-everywhere
exception. The final hypothesis holds for Lebesgue measure at every cut. -/
theorem threshold_integral_equality_ae
    [MeasurableSpace α]
    (μ : Measure α) (ρ q v : α → ℝ) (w : α)
    (hq : StrictAnti q)
    (hρ : ∀ᵐ x ∂μ, 0 < ρ x)
    (hv : ∀ᵐ x ∂μ, -1 ≤ v x ∧ v x ≤ 1)
    (hcut : ∀ᵐ x ∂μ, x ≠ w)
    (hρv : Integrable (fun x => ρ x * v x) μ)
    (hρw : Integrable (fun x => ρ x * threshold w x) μ)
    (hqρv : Integrable (fun x => q x * (ρ x * v x)) μ)
    (hqρw : Integrable (fun x => q x * (ρ x * threshold w x)) μ)
    (hmean : (∫ x, ρ x * v x ∂μ) = ∫ x, ρ x * threshold w x ∂μ)
    (hresponse : (∫ x, q x * (ρ x * v x) ∂μ) =
      ∫ x, q x * (ρ x * threshold w x) ∂μ) :
    v =ᵐ[μ] threshold w := by
  let f : α → ℝ := fun x => ρ x * v x - ρ x * threshold w x
  have hf : Integrable f μ := hρv.sub hρw
  have hqf : Integrable (fun x => q x * f x) μ := by
    simpa only [f, mul_sub] using hqρv.sub hqρw
  have hfmean : (∫ x, f x ∂μ) = 0 := by
    dsimp [f]
    rw [integral_sub hρv hρw, hmean, sub_self]
  have hqfmean : (∫ x, q x * f x ∂μ) = 0 := by
    simp only [f, mul_sub]
    rw [integral_sub hqρv hqρw, hresponse, sub_self]
  have hg : Integrable (fun x => (q x - q w) * f x) μ := by
    simpa only [sub_mul] using hqf.sub (hf.const_mul (q w))
  have hsign : ∀ᵐ x ∂μ, 0 ≤ (q x - q w) * f x := by
    filter_upwards [hρ, hv] with x hxρ hxv
    simpa only [f, mul_sub] using
      threshold_product_nonneg q w x (ρ x) (v x) hq.antitone hxρ.le hxv.1 hxv.2
  have hgmean : (∫ x, (q x - q w) * f x ∂μ) = 0 := by
    simp_rw [sub_mul]
    rw [integral_sub hqf (hf.const_mul (q w)), integral_const_mul,
      hfmean, hqfmean, mul_zero, sub_zero]
  have hzero := (integral_eq_zero_iff_of_nonneg_ae hsign hg).mp hgmean
  filter_upwards [hρ, hcut, hzero] with x hxρ hxcut hxzero
  have hqne : q x - q w ≠ 0 :=
    sub_ne_zero.mpr (fun heq => hxcut (hq.injective heq))
  have hproduct : (q x - q w) * (ρ x * (v x - threshold w x)) = 0 := by
    simpa only [f, mul_sub, Pi.zero_apply] using hxzero
  have hinner : ρ x * (v x - threshold w x) = 0 :=
    (mul_eq_zero.mp hproduct).resolve_left hqne
  exact sub_eq_zero.mp ((mul_eq_zero.mp hinner).resolve_left (ne_of_gt hxρ))

end Threshold

end Mpemba

#print axioms Mpemba.centered_integral_nonneg
#print axioms Mpemba.threshold_product_nonneg
#print axioms Mpemba.threshold_integral_comparison
#print axioms Mpemba.threshold_product_abs
#print axioms Mpemba.threshold_integral_deficit
#print axioms Mpemba.threshold_integral_equality_ae
