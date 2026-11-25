import NullValidity
import Mathlib.MeasureTheory.Integral.Prod

/-!
# Pointwise admissibility from genuine exact product nulls

For every nonnegative input we construct a two-atom, nonnegative, mean-one
probability law giving it strictly positive mass. The admissibility proof
uses actual product measures and the validity and precision theorems, not
an assumed finite-certificate value.
-/

open MeasureTheory ProbabilityTheory

namespace IndependentMerging

/-- The full product-law definition of a two-input independent e-merger. -/
def IsIndependentEMerger (T : ℝ → ℝ → ℝ) : Prop :=
  (∀ x y : ℝ, 0 ≤ x → 0 ≤ y → 0 ≤ T x y) ∧
  Measurable (fun z : ℝ × ℝ => T z.1 z.2) ∧
  ∀ μ ν : Measure ℝ, IsProbabilityMeasure μ → IsProbabilityMeasure ν →
    IsEVariable id μ → IsEVariable id ν →
    Integrable (fun z : ℝ × ℝ => T z.1 z.2) (μ.prod ν) ∧
      (∫ z, T z.1 z.2 ∂μ.prod ν) ≤ 1

theorem product_coordinates_independent (μ ν : Measure ℝ)
    [IsProbabilityMeasure μ] [IsProbabilityMeasure ν] :
    IndepFun (Prod.fst : ℝ × ℝ → ℝ) Prod.snd (μ.prod ν) := by
  apply (indepFun_iff_map_prod_eq_prod_map_map
    measurable_fst.aemeasurable measurable_snd.aemeasurable).mpr
  simp

theorem product_fst_evariable (μ ν : Measure ℝ)
    [IsProbabilityMeasure μ] [IsProbabilityMeasure ν] (hμ : IsEVariable id μ) :
    IsEVariable (Prod.fst : ℝ × ℝ → ℝ) (μ.prod ν) := by
  refine ⟨Measure.quasiMeasurePreserving_fst.ae hμ.1, ?_, ?_⟩
  · simpa using hμ.2.1.mul_prod (integrable_const (μ := ν) (1 : ℝ))
  · simpa using (show (∫ z, (id : ℝ → ℝ) z.1 ∂μ.prod ν) ≤ 1 by
      rw [integral_fun_fst]
      simpa using hμ.2.2)

theorem product_snd_evariable (μ ν : Measure ℝ)
    [IsProbabilityMeasure μ] [IsProbabilityMeasure ν] (hν : IsEVariable id ν) :
    IsEVariable (Prod.snd : ℝ × ℝ → ℝ) (μ.prod ν) := by
  refine ⟨Measure.quasiMeasurePreserving_snd.ae hν.1, ?_, ?_⟩
  · simpa using (integrable_const (μ := μ) (1 : ℝ)).mul_prod hν.2.1
  · simpa using (show (∫ z, (id : ℝ → ℝ) z.2 ∂μ.prod ν) ≤ 1 by
      rw [integral_fun_snd]
      simpa using hν.2.2)

theorem mergerLambda_isIndependentEMerger {lam : ℝ} (hlam0 : 0 ≤ lam) (hlam1 : lam ≤ 1) :
    IsIndependentEMerger (mergerLambda lam) := by
  refine ⟨fun _ _ hx hy => mergerLambda_nonnegative hlam0 hlam1 hx hy,
    (mergerLambda_continuous lam).measurable, ?_⟩
  intro μ ν hμp hνp hμ hν
  letI := hμp
  letI := hνp
  exact (independent_e_merger_valid hlam0 hlam1 (product_coordinates_independent μ ν)
    (product_fst_evariable μ ν hμ) (product_snd_evariable μ ν hν)).2

/-- Both weights are positive, even at x=0 or x=1. -/
noncomputable def atomWeight (x : ℝ) : ℝ := 1 / (x + 2)
noncomputable def otherWeight (x : ℝ) : ℝ := (x + 1) / (x + 2)
noncomputable def companion (x : ℝ) : ℝ := 2 / (x + 1)

noncomputable def exactNull (x : ℝ) : Measure ℝ :=
  ENNReal.ofReal (atomWeight x) • Measure.dirac x +
    ENNReal.ofReal (otherWeight x) • Measure.dirac (companion x)

theorem exactNull_parameters {x : ℝ} (hx : 0 ≤ x) :
    0 < atomWeight x ∧ 0 < otherWeight x ∧ 0 ≤ companion x ∧
      atomWeight x + otherWeight x = 1 ∧
      atomWeight x * x + otherWeight x * companion x = 1 := by
  have h1 : x + 1 ≠ 0 := ne_of_gt (by linarith)
  have h2 : x + 2 ≠ 0 := ne_of_gt (by linarith)
  refine ⟨by unfold atomWeight; positivity, by unfold otherWeight; positivity,
    by unfold companion; positivity, ?_, ?_⟩
  · unfold atomWeight otherWeight
    field_simp
    ring
  · unfold atomWeight otherWeight companion
    field_simp
    ring

theorem exactNull_probability {x : ℝ} (hx : 0 ≤ x) : IsProbabilityMeasure (exactNull x) := by
  obtain ⟨ha, hb, _, hsum, _⟩ := exactNull_parameters hx
  constructor
  simp only [exactNull, Measure.add_apply, Measure.smul_apply, Measure.dirac_apply_of_mem
    (Set.mem_univ _), smul_eq_mul, mul_one]
  rw [← ENNReal.ofReal_add ha.le hb.le, hsum]
  simp

theorem exactNull_integrable (x : ℝ) (f : ℝ → ℝ) : Integrable f (exactNull x) := by
  exact (integrable_dirac.smul_measure ENNReal.ofReal_ne_top).add_measure
    (integrable_dirac.smul_measure ENNReal.ofReal_ne_top)

theorem exactNull_integral {x : ℝ} (hx : 0 ≤ x) (f : ℝ → ℝ) :
    (∫ z, f z ∂exactNull x) = atomWeight x * f x + otherWeight x * f (companion x) := by
  obtain ⟨ha, hb, _, _, _⟩ := exactNull_parameters hx
  unfold exactNull
  rw [integral_add_measure
    (integrable_dirac.smul_measure ENNReal.ofReal_ne_top)
    (integrable_dirac.smul_measure ENNReal.ofReal_ne_top)]
  simp [integral_smul_measure, ENNReal.toReal_ofReal ha.le, ENNReal.toReal_ofReal hb.le]

theorem exactNull_mean_one {x : ℝ} (hx : 0 ≤ x) : (∫ z, z ∂exactNull x) = 1 := by
  rw [exactNull_integral hx]
  exact (exactNull_parameters hx).2.2.2.2

theorem exactNull_evariable {x : ℝ} (hx : 0 ≤ x) : IsEVariable id (exactNull x) := by
  refine ⟨?_, exactNull_integrable x id, (exactNull_mean_one hx).le⟩
  apply ae_add_measure_iff.mpr
  constructor
  · apply Measure.ae_smul_measure
    simpa using hx
  · apply Measure.ae_smul_measure
    simpa using (exactNull_parameters hx).2.2.1

theorem exact_product_integral {x y : ℝ} (hx : 0 ≤ x) (hy : 0 ≤ y)
    (T : ℝ → ℝ → ℝ)
    (hT : Integrable (fun z : ℝ × ℝ => T z.1 z.2) ((exactNull x).prod (exactNull y))) :
    (∫ z, T z.1 z.2 ∂(exactNull x).prod (exactNull y)) =
      atomWeight x * (atomWeight y * T x y + otherWeight y * T x (companion y)) +
      otherWeight x * (atomWeight y * T (companion x) y +
        otherWeight y * T (companion x) (companion y)) := by
  letI := exactNull_probability hx
  letI := exactNull_probability hy
  rw [integral_prod _ hT, exactNull_integral hx]
  rw [exactNull_integral hy, exactNull_integral hy]

/-- Precision rules out strict improvement at every point of the nonnegative
quadrant. The comparator is any genuine independent e-merger. -/
theorem mergerLambda_admissible {lam : ℝ} (hlam0 : 0 ≤ lam) (hlam1 : lam ≤ 1)
    (H : ℝ → ℝ → ℝ) (hH : IsIndependentEMerger H)
    (hdom : ∀ x y : ℝ, 0 ≤ x → 0 ≤ y → mergerLambda lam x y ≤ H x y) :
    ∀ x y : ℝ, 0 ≤ x → 0 ≤ y → H x y = mergerLambda lam x y := by
  intro x y hx hy
  let μ := exactNull x
  let ν := exactNull y
  letI : IsProbabilityMeasure μ := exactNull_probability hx
  letI : IsProbabilityMeasure ν := exactNull_probability hy
  have hX := product_fst_evariable μ ν (exactNull_evariable hx)
  have hY := product_snd_evariable μ ν (exactNull_evariable hy)
  have hXY := product_coordinates_independent μ ν
  have hmeanX : (∫ z : ℝ × ℝ, z.1 ∂μ.prod ν) = 1 := by
    calc
      _ = ∫ z, z ∂μ := by
        simpa using integral_fun_fst (μ := μ) (ν := ν) (fun z : ℝ => z)
      _ = 1 := exactNull_mean_one hx
  have hmeanY : (∫ z : ℝ × ℝ, z.2 ∂μ.prod ν) = 1 := by
    calc
      _ = ∫ z, z ∂ν := by
        simpa using integral_fun_snd (μ := μ) (ν := ν) (fun z : ℝ => z)
      _ = 1 := exactNull_mean_one hy
  have hp := independent_e_merger_precise lam hXY hX.2.1 hY.2.1 hmeanX hmeanY
  have hi := ((mergerLambda_isIndependentEMerger hlam0 hlam1).2.2 μ ν
    inferInstance inferInstance (exactNull_evariable hx) (exactNull_evariable hy)).1
  have hHv := hH.2.2 μ ν inferInstance inferInstance (exactNull_evariable hx) (exactNull_evariable hy)
  rw [exact_product_integral hx hy (mergerLambda lam) hi] at hp
  rw [exact_product_integral hx hy H hHv.1] at hHv
  obtain ⟨hax, hbx, hcx, _, _⟩ := exactNull_parameters hx
  obtain ⟨hay, hby, hcy, _, _⟩ := exactNull_parameters hy
  have hxy := hdom x y hx hy
  have hxcy := hdom x (companion y) hx hcy
  have hcxy := hdom (companion x) y hcx hy
  have hcxcy := hdom (companion x) (companion y) hcx hcy
  have hrest1 := mul_nonneg (mul_nonneg hax.le hby.le) (sub_nonneg.mpr hxcy)
  have hrest2 := mul_nonneg (mul_nonneg hbx.le hay.le) (sub_nonneg.mpr hcxy)
  have hrest3 := mul_nonneg (mul_nonneg hbx.le hby.le) (sub_nonneg.mpr hcxcy)
  have hco : 0 < atomWeight x * atomWeight y := mul_pos hax hay
  have hnonpos : atomWeight x * atomWeight y * (H x y - mergerLambda lam x y) ≤ 0 := by
    linarith only [hp, hHv.2, hrest1, hrest2, hrest3]
  have hupper : H x y ≤ mergerLambda lam x y := by
    by_contra h
    exact (not_lt_of_ge hnonpos) (mul_pos hco (sub_pos.mpr (lt_of_not_ge h)))
  exact le_antisymm hupper hxy

end IndependentMerging

#print axioms IndependentMerging.mergerLambda_isIndependentEMerger
#print axioms IndependentMerging.mergerLambda_admissible
