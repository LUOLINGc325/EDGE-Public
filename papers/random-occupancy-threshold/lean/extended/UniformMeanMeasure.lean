import ProjectionProbability
import Mathlib.Probability.Distributions.Uniform
import Mathlib.Probability.ProbabilityMassFunction.Integrals
import Mathlib.Probability.Moments.SubGaussian
import Mathlib.Data.Fin.Tuple.Basic

open MeasureTheory ProbabilityTheory Real
open scoped BigOperators ENNReal NNReal

namespace TwoColorNullity.Occupancy

theorem finiteMean_mono {Sample : Type*} [Fintype Sample] {f g : Sample → ℝ}
    (h : ∀ x, f x ≤ g x) : finiteMean f ≤ finiteMean g := by
  unfold finiteMean
  exact div_le_div_of_nonneg_right (Finset.sum_le_sum fun x _ => h x) (Nat.cast_nonneg _)

theorem finiteMean_prod {Sample Auxiliary : Type*} [Fintype Sample] [Fintype Auxiliary]
    (f : Sample × Auxiliary → ℝ) :
    finiteMean f = finiteMean (fun x : Sample => finiteMean fun y : Auxiliary => f (x, y)) := by
  simp only [finiteMean, Fintype.sum_prod_type, Fintype.card_prod, Nat.cast_mul,
    Finset.sum_div, div_div, mul_comm]

theorem finiteMean_cons {Label : Type*} [Fintype Label] {m : ℕ}
    (f : (Fin (m + 1) → Label) → ℝ) :
    finiteMean f = finiteMean (fun first : Label => finiteMean fun tail : Fin m → Label =>
      f (Fin.cons first tail)) := by
  let e := Fin.consEquiv (fun _ : Fin (m + 1) => Label)
  exact (finiteMean_comp_equiv e f).symm.trans (finiteMean_prod (f ∘ e))

section UniformMeasure

local instance discreteFiniteSample (Sample : Type*) : MeasurableSpace Sample := ⊤

private noncomputable def finiteUniformMeasure (Sample : Type*) [Fintype Sample] [Nonempty Sample] :
    Measure Sample := (PMF.uniformOfFintype Sample).toMeasure

local instance finiteUniformIsProbability (Sample : Type*) [Fintype Sample] [Nonempty Sample] :
    IsProbabilityMeasure (finiteUniformMeasure Sample) := by
  unfold finiteUniformMeasure
  infer_instance

private theorem uniformIntegral_eq_finiteMean {Sample : Type*} [Fintype Sample] [Nonempty Sample]
    (f : Sample → ℝ) :
    (∫ x, f x ∂finiteUniformMeasure Sample) = finiteMean f := by
  simp only [finiteUniformMeasure, PMF.integral_eq_sum, PMF.uniformOfFintype_apply,
    ENNReal.toReal_inv, ENNReal.toReal_natCast, smul_eq_mul, ← Finset.mul_sum, finiteMean, div_eq_mul_inv]
  ring

private theorem uniformMeasureReal_eq_finiteProbability {Sample : Type*} [Fintype Sample] [Nonempty Sample]
    (event : Sample → Prop) :
    (finiteUniformMeasure Sample).real {x | event x} = finiteProbability event := by
  classical
  let selected : Set Sample := {x | event x}
  have indicator : selected.indicator (1 : Sample → ℝ) =
      (fun x => if event x then 1 else 0) := by
    funext x
    by_cases hx : event x <;> simp [selected, hx]
  calc
    _ = ∫ x, selected.indicator (1 : Sample → ℝ) x ∂finiteUniformMeasure Sample :=
      (MeasureTheory.integral_indicator_one (μ := finiteUniformMeasure Sample) (s := selected)
        MeasurableSet.of_discrete).symm
    _ = finiteMean (selected.indicator (1 : Sample → ℝ)) := uniformIntegral_eq_finiteMean _
    _ = _ := by rw [indicator, finiteProbability_eq_mean_indicator]

/-- An interval of length two gives a centered sub-Gaussian proxy of one. -/
theorem finiteMean_hoeffding_width_two {Sample : Type*} [Fintype Sample] [Nonempty Sample]
    (f : Sample → ℝ) (lower : ℝ) (h : ∀ x, f x ∈ Set.Icc lower (lower + 2)) (t : ℝ) :
    finiteMean (fun x => Real.exp (t * (f x - finiteMean f))) ≤ Real.exp (t ^ 2 / 2) := by
  have hm : AEMeasurable f (finiteUniformMeasure Sample) := Measurable.of_discrete.aemeasurable
  have hh := hasSubgaussianMGF_of_mem_Icc hm (Filter.Eventually.of_forall h)
  have hparam : (‖lower + 2 - lower‖₊ / 2) ^ 2 = (1 : ℝ≥0) := by
    rw [show lower + 2 - lower = 2 by ring]
    apply NNReal.eq
    norm_num [Real.norm_eq_abs]
  rw [hparam] at hh
  simpa only [ProbabilityTheory.mgf, uniformIntegral_eq_finiteMean, NNReal.coe_one, one_mul] using hh.mgf_le t

theorem finiteProbability_ge_of_averaged_mgf {Sample : Type*} [Fintype Sample] [Nonempty Sample]
    (f : Sample → ℝ) (m : ℕ)
    (h : ∀ u : ℝ, finiteMean (fun x => Real.exp (u * f x)) ≤ Real.exp ((m : ℝ) * u ^ 2 / 2))
    (t : ℝ) (ht : 0 ≤ t) :
    finiteProbability (fun x => t ≤ f x) ≤ Real.exp (-(t ^ 2) / (2 * (m : ℝ))) := by
  have hh : HasSubgaussianMGF f (m : ℝ≥0) (finiteUniformMeasure Sample) :=
    ⟨fun _ => Integrable.of_finite, fun u => by
      simpa only [ProbabilityTheory.mgf, uniformIntegral_eq_finiteMean, NNReal.coe_natCast] using h u⟩
  rw [← uniformMeasureReal_eq_finiteProbability]
  simpa only [NNReal.coe_natCast] using hh.measure_ge_le ht

end UniformMeasure
end TwoColorNullity.Occupancy
