import IndependentMerging
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# Three-point separation for actual randomized strategies

The original algebraic certificate is extended to arbitrary finite mixtures
and to Bochner integration over a probability space of strategy seeds. The
seed may choose either reading order and the stakes. The three payoff
functions are explicitly required to be integrable; no three-point upper
bound is assumed in the theorem about actual strategies.

This does not claim the separate null-law independence, admissibility, or
whole-domain optimal-capital theorems from the manuscript.
-/

open scoped BigOperators
open MeasureTheory

namespace IndependentMerging

/-- A finite probability mixture preserves the separating functional. -/
theorem finite_mixture_three_point_bound {ι : Type*} (s : Finset ι)
    (p : ι → ℝ) (H : ι → ℝ → ℝ → ℝ)
    (hp : ∀ i ∈ s, 0 ≤ p i) (hsum : ∑ i ∈ s, p i = 1)
    (hbound : ∀ i ∈ s, H i 3 3 + 6 * H i 0 1 + 6 * H i 1 0 ≤ 15) :
    (∑ i ∈ s, p i * H i 3 3) + 6 * (∑ i ∈ s, p i * H i 0 1) +
      6 * (∑ i ∈ s, p i * H i 1 0) ≤ 15 := by
  have hlinear :
      (∑ i ∈ s, p i * H i 3 3) + 6 * (∑ i ∈ s, p i * H i 0 1) +
        6 * (∑ i ∈ s, p i * H i 1 0) =
      ∑ i ∈ s, p i * (H i 3 3 + 6 * H i 0 1 + 6 * H i 1 0) := by
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro i _
    ring
  rw [hlinear]
  calc
    _ ≤ ∑ i ∈ s, p i * 15 :=
      Finset.sum_le_sum (fun i hi => mul_le_mul_of_nonneg_left (hbound i hi) (hp i hi))
    _ = 15 := by rw [← Finset.sum_mul, hsum]; norm_num

/-- The actual two-step payoff, with the reading order chosen by a seed. -/
noncomputable def orderedStrategy (reverse : Bool) (a : ℝ) (b : ℝ → ℝ)
    (x y : ℝ) : ℝ :=
  if reverse then (1 + a * (y - 1)) * (1 + b y * (x - 1))
  else (1 + a * (x - 1)) * (1 + b x * (y - 1))

/-- Both reading orders obey the same functional bound, derived from stakes. -/
theorem ordered_strategy_three_point_bound (reverse : Bool) (a : ℝ) (b : ℝ → ℝ)
    (ha : 0 ≤ a) (hb3 : b 3 ≤ 1) (hb1 : 0 ≤ b 1) :
    orderedStrategy reverse a b 3 3 + 6 * orderedStrategy reverse a b 0 1 +
      6 * orderedStrategy reverse a b 1 0 ≤ 15 := by
  have h := strategy_three_point_bound ha hb3 hb1
  cases reverse <;> norm_num [orderedStrategy] <;> nlinarith

/-- Bounded stakes give bounded payoffs at every input in the separating box. -/
theorem ordered_strategy_bounds (reverse : Bool) (a : ℝ) (b : ℝ → ℝ)
    {x y : ℝ} (ha : 0 ≤ a ∧ a ≤ 1)
    (hbx : 0 ≤ b x ∧ b x ≤ 1) (hby : 0 ≤ b y ∧ b y ≤ 1)
    (hx : 0 ≤ x ∧ x ≤ 3) (hy : 0 ≤ y ∧ y ≤ 3) :
    0 ≤ orderedStrategy reverse a b x y ∧ orderedStrategy reverse a b x y ≤ 9 := by
  have factor {u t : ℝ} (hu : 0 ≤ u ∧ u ≤ 1) (ht : 0 ≤ t ∧ t ≤ 3) :
      0 ≤ 1 + u * (t - 1) ∧ 1 + u * (t - 1) ≤ 3 :=
    ⟨by nlinarith [mul_nonneg hu.1 ht.1],
      by nlinarith [mul_nonneg hu.1 (sub_nonneg.mpr ht.2)]⟩
  have product {u v : ℝ} (hu : 0 ≤ u ∧ u ≤ 3) (hv : 0 ≤ v ∧ v ≤ 3) :
      0 ≤ u * v ∧ u * v ≤ 9 :=
    ⟨mul_nonneg hu.1 hv.1, by nlinarith [mul_le_mul hu.2 hv.2 hv.1 (by norm_num : (0:ℝ) ≤ 3)]⟩
  cases reverse with
  | false => exact product (factor ha hx) (factor hbx hy)
  | true => exact product (factor ha hy) (factor hby hx)

variable {Ω : Type*} [MeasurableSpace Ω]

/-- For measurable bounded-stake payoffs, integrability is a conclusion. -/
theorem ordered_strategy_integrable (μ : Measure Ω) [IsFiniteMeasure μ]
    (reverse : Ω → Bool) (a : Ω → ℝ) (b : Ω → ℝ → ℝ) {x y : ℝ}
    (hstrong : AEStronglyMeasurable
      (fun ω => orderedStrategy (reverse ω) (a ω) (b ω) x y) μ)
    (ha : ∀ᵐ ω ∂μ, 0 ≤ a ω ∧ a ω ≤ 1)
    (hbx : ∀ᵐ ω ∂μ, 0 ≤ b ω x ∧ b ω x ≤ 1)
    (hby : ∀ᵐ ω ∂μ, 0 ≤ b ω y ∧ b ω y ≤ 1)
    (hx : 0 ≤ x ∧ x ≤ 3) (hy : 0 ≤ y ∧ y ≤ 3) :
    Integrable (fun ω => orderedStrategy (reverse ω) (a ω) (b ω) x y) μ := by
  apply (integrable_const (9 : ℝ)).mono' hstrong
  filter_upwards [ha, hbx, hby] with ω ha' hbx' hby'
  obtain ⟨h0, h9⟩ := ordered_strategy_bounds (reverse ω) (a ω) (b ω) ha' hbx' hby' hx hy
  simpa [Real.norm_eq_abs, abs_of_nonneg h0] using h9

/-- Expectation over the strategy seed, at fixed observed inputs. -/
noncomputable def mixedPayoff (μ : Measure Ω) (H : Ω → ℝ → ℝ → ℝ)
    (x y : ℝ) : ℝ := ∫ ω, H ω x y ∂μ

/-- Integration preserves the functional bound, without a finite-support restriction. -/
theorem probability_mixture_three_point_bound (μ : Measure Ω) [IsProbabilityMeasure μ]
    (H : Ω → ℝ → ℝ → ℝ)
    (h33 : Integrable (fun ω => H ω 3 3) μ)
    (h01 : Integrable (fun ω => H ω 0 1) μ)
    (h10 : Integrable (fun ω => H ω 1 0) μ)
    (hbound : ∀ᵐ ω ∂μ, H ω 3 3 + 6 * H ω 0 1 + 6 * H ω 1 0 ≤ 15) :
    mixedPayoff μ H 3 3 + 6 * mixedPayoff μ H 0 1 +
      6 * mixedPayoff μ H 1 0 ≤ 15 := by
  have h := integral_mono_ae ((h33.add (h01.const_mul 6)).add (h10.const_mul 6))
    (integrable_const (15 : ℝ)) hbound
  rw [integral_add' (h33.add (h01.const_mul 6)) (h10.const_mul 6),
    integral_add' h33 (h01.const_mul 6), integral_const_mul, integral_const_mul] at h
  simpa [mixedPayoff] using h

/-- The random seed may choose the reading order and every stake. -/
theorem randomized_strategy_three_point_bound (μ : Measure Ω) [IsProbabilityMeasure μ]
    (reverse : Ω → Bool) (a : Ω → ℝ) (b : Ω → ℝ → ℝ)
    (ha : ∀ᵐ ω ∂μ, 0 ≤ a ω)
    (hb3 : ∀ᵐ ω ∂μ, b ω 3 ≤ 1) (hb1 : ∀ᵐ ω ∂μ, 0 ≤ b ω 1)
    (h33 : Integrable (fun ω => orderedStrategy (reverse ω) (a ω) (b ω) 3 3) μ)
    (h01 : Integrable (fun ω => orderedStrategy (reverse ω) (a ω) (b ω) 0 1) μ)
    (h10 : Integrable (fun ω => orderedStrategy (reverse ω) (a ω) (b ω) 1 0) μ) :
    mixedPayoff μ (fun ω => orderedStrategy (reverse ω) (a ω) (b ω)) 3 3 +
      6 * mixedPayoff μ (fun ω => orderedStrategy (reverse ω) (a ω) (b ω)) 0 1 +
      6 * mixedPayoff μ (fun ω => orderedStrategy (reverse ω) (a ω) (b ω)) 1 0 ≤ 15 := by
  apply probability_mixture_three_point_bound μ _ h33 h01 h10
  filter_upwards [ha, hb3, hb1] with ω ha' hb3' hb1'
  exact ordered_strategy_three_point_bound (reverse ω) (a ω) (b ω) ha' hb3' hb1'

/-- No integrable probability mixture of the actual strategies can dominate
the merger even on the three separating inputs. -/
theorem randomized_strategy_no_domination (μ : Measure Ω) [IsProbabilityMeasure μ]
    (reverse : Ω → Bool) (a : Ω → ℝ) (b : Ω → ℝ → ℝ)
    (ha : ∀ᵐ ω ∂μ, 0 ≤ a ω)
    (hb3 : ∀ᵐ ω ∂μ, b ω 3 ≤ 1) (hb1 : ∀ᵐ ω ∂μ, 0 ≤ b ω 1)
    (hi33 : Integrable (fun ω => orderedStrategy (reverse ω) (a ω) (b ω) 3 3) μ)
    (hi01 : Integrable (fun ω => orderedStrategy (reverse ω) (a ω) (b ω) 0 1) μ)
    (hi10 : Integrable (fun ω => orderedStrategy (reverse ω) (a ω) (b ω) 1 0) μ) :
    ¬ (merger 3 3 ≤ mixedPayoff μ (fun ω => orderedStrategy (reverse ω) (a ω) (b ω)) 3 3 ∧
      merger 0 1 ≤ mixedPayoff μ (fun ω => orderedStrategy (reverse ω) (a ω) (b ω)) 0 1 ∧
      merger 1 0 ≤ mixedPayoff μ (fun ω => orderedStrategy (reverse ω) (a ω) (b ω)) 1 0) := by
  rintro ⟨h33, h01, h10⟩
  exact no_three_point_domination _
    (randomized_strategy_three_point_bound μ reverse a b ha hb3 hb1 hi33 hi01 hi10)
    h33 h01 h10

/-- The usual measurable, [0,1]-valued stakes need no external integrability
premises and cannot dominate the proposed merger. -/
theorem measurable_randomized_strategy_no_domination
    (μ : Measure Ω) [IsProbabilityMeasure μ]
    (reverse : Ω → Bool) (a : Ω → ℝ) (b : Ω → ℝ → ℝ)
    (ha : ∀ᵐ ω ∂μ, 0 ≤ a ω ∧ a ω ≤ 1)
    (hb : ∀ z : ℝ, ∀ᵐ ω ∂μ, 0 ≤ b ω z ∧ b ω z ≤ 1)
    (hstrong : ∀ x y : ℝ, AEStronglyMeasurable
      (fun ω => orderedStrategy (reverse ω) (a ω) (b ω) x y) μ) :
    ¬ (merger 3 3 ≤ mixedPayoff μ (fun ω => orderedStrategy (reverse ω) (a ω) (b ω)) 3 3 ∧
      merger 0 1 ≤ mixedPayoff μ (fun ω => orderedStrategy (reverse ω) (a ω) (b ω)) 0 1 ∧
      merger 1 0 ≤ mixedPayoff μ (fun ω => orderedStrategy (reverse ω) (a ω) (b ω)) 1 0) := by
  apply randomized_strategy_no_domination μ reverse a b
    (ha.mono (fun _ h => h.1)) ((hb 3).mono (fun _ h => h.2))
    ((hb 1).mono (fun _ h => h.1))
  · exact ordered_strategy_integrable μ reverse a b (hstrong 3 3) ha (hb 3) (hb 3)
      (by norm_num) (by norm_num)
  · exact ordered_strategy_integrable μ reverse a b (hstrong 0 1) ha (hb 0) (hb 1)
      (by norm_num) (by norm_num)
  · exact ordered_strategy_integrable μ reverse a b (hstrong 1 0) ha (hb 1) (hb 0)
      (by norm_num) (by norm_num)

end IndependentMerging

#print axioms IndependentMerging.finite_mixture_three_point_bound
#print axioms IndependentMerging.ordered_strategy_three_point_bound
#print axioms IndependentMerging.ordered_strategy_bounds
#print axioms IndependentMerging.ordered_strategy_integrable
#print axioms IndependentMerging.probability_mixture_three_point_bound
#print axioms IndependentMerging.randomized_strategy_three_point_bound
#print axioms IndependentMerging.randomized_strategy_no_domination
#print axioms IndependentMerging.measurable_randomized_strategy_no_domination
