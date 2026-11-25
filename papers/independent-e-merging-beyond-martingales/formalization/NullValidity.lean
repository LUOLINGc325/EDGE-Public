import IndependentMerging
import Mathlib.Probability.Integration
import Mathlib.Tactic.FunProp

/-!
# Independent-input validity on arbitrary probability spaces

This module proves the probability assertions of manuscript Section 2.2 for
the entire parameter family. Inputs may be unbounded. Their independence is
Mathlib's `IndepFun`, and all expectations are actual Bochner integrals.
The positive/negative-part means, product integrability, and factorization
are conclusions, not assumptions about the target merger.
-/

open MeasureTheory ProbabilityTheory

namespace IndependentMerging

noncomputable def mergerLambda (lam x y : ℝ) : ℝ :=
  1 + lam * (max (x - 1) 0 * max (y - 1) 0 -
    max (1 - x) 0 * max (1 - y) 0)

theorem mergerLambda_eq_convex (lam x y : ℝ) :
    mergerLambda lam x y = (1 - lam) + lam * merger x y := by
  unfold mergerLambda merger
  ring

theorem mergerLambda_one (x y : ℝ) : mergerLambda 1 x y = merger x y := by
  rw [mergerLambda_eq_convex]
  ring

theorem mergerLambda_continuous (lam : ℝ) :
    Continuous (fun z : ℝ × ℝ => mergerLambda lam z.1 z.2) := by
  unfold mergerLambda
  fun_prop

theorem mergerLambda_symmetric (lam x y : ℝ) :
    mergerLambda lam x y = mergerLambda lam y x := by
  rw [mergerLambda_eq_convex, mergerLambda_eq_convex, merger_symmetric]

theorem mergerLambda_nonnegative {lam x y : ℝ} (hlam0 : 0 ≤ lam) (hlam1 : lam ≤ 1)
    (hx : 0 ≤ x) (hy : 0 ≤ y) : 0 ≤ mergerLambda lam x y := by
  rw [mergerLambda_eq_convex]
  exact add_nonneg (sub_nonneg.mpr hlam1) (mul_nonneg hlam0 (merger_nonnegative hx hy))

theorem mergerLambda_monotone_left {lam x x' y : ℝ} (hlam : 0 ≤ lam) (hx : x ≤ x') :
    mergerLambda lam x y ≤ mergerLambda lam x' y := by
  simp only [mergerLambda_eq_convex]
  exact add_le_add_left (mul_le_mul_of_nonneg_left (merger_monotone_left hx) hlam) _

theorem mergerLambda_monotone_right {lam x y y' : ℝ} (hlam : 0 ≤ lam) (hy : y ≤ y') :
    mergerLambda lam x y ≤ mergerLambda lam x y' := by
  simp only [mergerLambda_eq_convex]
  exact add_le_add_left (mul_le_mul_of_nonneg_left (merger_monotone_right hy) hlam) _

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

/-- A finite, almost-everywhere nonnegative e-variable on a probability space.
Integrability is part of the definition, so the integral cannot hide infinity. -/
def IsEVariable (X : Ω → ℝ) (μ : Measure Ω) : Prop :=
  (∀ᵐ ω ∂μ, 0 ≤ X ω) ∧ Integrable X μ ∧ (∫ ω, X ω ∂μ) ≤ 1

theorem surplus_integrable [IsFiniteMeasure μ] {X : Ω → ℝ} (hX : Integrable X μ) :
    Integrable (fun ω => max (X ω - 1) 0) μ :=
  (hX.sub (integrable_const 1)).pos_part

theorem shortfall_integrable [IsFiniteMeasure μ] {X : Ω → ℝ} (hX : Integrable X μ) :
    Integrable (fun ω => max (1 - X ω) 0) μ :=
  ((integrable_const 1).sub hX).pos_part

/-- Surplus minus shortfall equals the actual input mean minus one. -/
theorem surplus_sub_shortfall_mean [IsProbabilityMeasure μ] {X : Ω → ℝ}
    (hX : Integrable X μ) :
    (∫ ω, max (X ω - 1) 0 ∂μ) - (∫ ω, max (1 - X ω) 0 ∂μ) =
      (∫ ω, X ω ∂μ) - 1 := by
  rw [← integral_sub (surplus_integrable hX) (shortfall_integrable hX)]
  have hpoint : (fun ω => max (X ω - 1) 0 - max (1 - X ω) 0) =
      (fun ω => X ω - 1) := by
    funext ω
    have h := max_zero_sub_max_neg_zero_eq_self (X ω - 1)
    simpa only [neg_sub] using h
  rw [hpoint, integral_sub hX (integrable_const 1)]
  simp

theorem independent_surplus_product_integrable [IsProbabilityMeasure μ]
    {X Y : Ω → ℝ} (hXY : IndepFun X Y μ) (hX : Integrable X μ)
    (hY : Integrable Y μ) :
    Integrable (fun ω => max (X ω - 1) 0 * max (Y ω - 1) 0) μ := by
  have hm : Measurable (fun x : ℝ => max (x - 1) 0) :=
    (measurable_id.sub_const 1).max measurable_const
  exact (hXY.comp hm hm).integrable_mul (surplus_integrable hX) (surplus_integrable hY)

theorem independent_shortfall_product_integrable [IsProbabilityMeasure μ]
    {X Y : Ω → ℝ} (hXY : IndepFun X Y μ) (hX : Integrable X μ)
    (hY : Integrable Y μ) :
    Integrable (fun ω => max (1 - X ω) 0 * max (1 - Y ω) 0) μ := by
  have hm : Measurable (fun x : ℝ => max (1 - x) 0) :=
    (measurable_const.sub measurable_id).max measurable_const
  exact (hXY.comp hm hm).integrable_mul (shortfall_integrable hX) (shortfall_integrable hY)

/-- Independence supplies all product integrability, also for unbounded inputs. -/
theorem mergerLambda_integrable [IsProbabilityMeasure μ]
    {X Y : Ω → ℝ} (lam : ℝ) (hXY : IndepFun X Y μ)
    (hX : Integrable X μ) (hY : Integrable Y μ) :
    Integrable (fun ω => mergerLambda lam (X ω) (Y ω)) μ :=
  (integrable_const 1).add
    (((independent_surplus_product_integrable hXY hX hY).sub
      (independent_shortfall_product_integrable hXY hX hY)).const_mul lam)

/-- The expectation identity is obtained from genuine independence. -/
theorem mergerLambda_integral [IsProbabilityMeasure μ]
    {X Y : Ω → ℝ} (lam : ℝ) (hXY : IndepFun X Y μ)
    (hX : Integrable X μ) (hY : Integrable Y μ) :
    (∫ ω, mergerLambda lam (X ω) (Y ω) ∂μ) = 1 + lam *
      ((∫ ω, max (X ω - 1) 0 ∂μ) * (∫ ω, max (Y ω - 1) 0 ∂μ) -
       (∫ ω, max (1 - X ω) 0 ∂μ) * (∫ ω, max (1 - Y ω) 0 ∂μ)) := by
  have hp := independent_surplus_product_integrable hXY hX hY
  have hn := independent_shortfall_product_integrable hXY hX hY
  have hmp : Measurable (fun x : ℝ => max (x - 1) 0) :=
    (measurable_id.sub_const 1).max measurable_const
  have hmn : Measurable (fun x : ℝ => max (1 - x) 0) :=
    (measurable_const.sub measurable_id).max measurable_const
  have ep := (hXY.comp hmp hmp).integral_mul_of_integrable
    (surplus_integrable hX) (surplus_integrable hY)
  have en := (hXY.comp hmn hmn).integral_mul_of_integrable
    (shortfall_integrable hX) (shortfall_integrable hY)
  have hd : Integrable (fun ω => max (X ω - 1) 0 * max (Y ω - 1) 0 -
      max (1 - X ω) 0 * max (1 - Y ω) 0) μ := hp.sub hn
  have hs : Integrable (fun ω => lam * (max (X ω - 1) 0 * max (Y ω - 1) 0 -
      max (1 - X ω) 0 * max (1 - Y ω) 0)) μ := hd.const_mul lam
  change (∫ ω, max (X ω - 1) 0 * max (Y ω - 1) 0 ∂μ) = _ at ep
  change (∫ ω, max (1 - X ω) 0 * max (1 - Y ω) 0 ∂μ) = _ at en
  unfold mergerLambda
  rw [integral_add (integrable_const 1) hs, integral_const_mul,
    integral_sub hp hn, ep, en]
  simp [Function.comp_def]

/-- Every pair of independent e-variables gives a valid output e-variable.
The hypotheses contain no condition on the merger's output or its moments. -/
theorem independent_e_merger_valid [IsProbabilityMeasure μ]
    {X Y : Ω → ℝ} {lam : ℝ} (hlam0 : 0 ≤ lam) (hlam1 : lam ≤ 1)
    (hXY : IndepFun X Y μ) (hX : IsEVariable X μ) (hY : IsEVariable Y μ) :
    IsEVariable (fun ω => mergerLambda lam (X ω) (Y ω)) μ := by
  refine ⟨?_, mergerLambda_integrable lam hXY hX.2.1 hY.2.1, ?_⟩
  · filter_upwards [hX.1, hY.1] with ω hx hy
    exact mergerLambda_nonnegative hlam0 hlam1 hx hy
  · rw [mergerLambda_integral lam hXY hX.2.1 hY.2.1]
    have hx := surplus_sub_shortfall_mean hX.2.1
    have hy := surplus_sub_shortfall_mean hY.2.1
    have hxle : (∫ ω, max (X ω - 1) 0 ∂μ) ≤ (∫ ω, max (1 - X ω) 0 ∂μ) := by
      linarith [hX.2.2]
    have hyle : (∫ ω, max (Y ω - 1) 0 ∂μ) ≤ (∫ ω, max (1 - Y ω) 0 ∂μ) := by
      linarith [hY.2.2]
    have hbX : 0 ≤ (∫ ω, max (X ω - 1) 0 ∂μ) :=
      integral_nonneg (fun ω => le_max_right _ _)
    have hbY : 0 ≤ (∫ ω, max (Y ω - 1) 0 ∂μ) :=
      integral_nonneg (fun ω => le_max_right _ _)
    have hp := mul_le_mul hxle hyle hbY (le_trans hbX hxle)
    have h := mul_nonpos_of_nonneg_of_nonpos hlam0 (sub_nonpos.mpr hp)
    linarith

/-- Precision holds for every independent exact-mean-one law, including
continuous distributions and laws with unbounded support. -/
theorem independent_e_merger_precise [IsProbabilityMeasure μ]
    {X Y : Ω → ℝ} (lam : ℝ) (hXY : IndepFun X Y μ)
    (hX : Integrable X μ) (hY : Integrable Y μ)
    (hmX : (∫ ω, X ω ∂μ) = 1) (hmY : (∫ ω, Y ω ∂μ) = 1) :
    (∫ ω, mergerLambda lam (X ω) (Y ω) ∂μ) = 1 := by
  rw [mergerLambda_integral lam hXY hX hY]
  have hx := surplus_sub_shortfall_mean hX
  have hy := surplus_sub_shortfall_mean hY
  have hx' : (∫ ω, max (X ω - 1) 0 ∂μ) = (∫ ω, max (1 - X ω) 0 ∂μ) := by
    linarith
  have hy' : (∫ ω, max (Y ω - 1) 0 ∂μ) = (∫ ω, max (1 - Y ω) 0 ∂μ) := by
    linarith
  rw [hx', hy', sub_self, mul_zero, add_zero]

end IndependentMerging

#print axioms IndependentMerging.independent_e_merger_valid
#print axioms IndependentMerging.independent_e_merger_precise
