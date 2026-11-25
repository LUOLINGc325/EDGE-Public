import ProductNull
import Mathlib.MeasureTheory.Constructions.Pi

open Finset Function MeasureTheory ProbabilityTheory
open scoped BigOperators

namespace IndependentMerging

variable {n : ℕ}

theorem product_measure_marginal (ν : PairCoord n → Measure ℝ)
    [∀ c, IsProbabilityMeasure (ν c)] (c : PairCoord n) :
    (Measure.pi ν).map (fun x : PairInput n => x c) = ν c := by
  classical
  ext A hA
  rw [Measure.map_apply (measurable_pi_apply c) hA]
  change Measure.pi ν (eval c ⁻¹' A) = ν c A
  rw [← Set.univ_pi_update_univ, Measure.pi_pi]
  rw [← Finset.mul_prod_erase Finset.univ _ (Finset.mem_univ c)]
  rw [Function.update_self]
  have hr : (∏ j ∈ (Finset.univ : Finset (PairCoord n)).erase c,
      ν j ((Function.update (fun _ : PairCoord n => (Set.univ : Set ℝ)) c A) j)) = 1 := by
    apply Finset.prod_eq_one
    intro j hj
    rw [Function.update_of_ne (Finset.mem_erase.mp hj).1, measure_univ]
  rw [hr, mul_one]

theorem product_measure_independence (ν : PairCoord n → Measure ℝ)
    [∀ c, IsProbabilityMeasure (ν c)] :
    iIndepFun (fun c (x : PairInput n) => x c) (Measure.pi ν) := by
  apply (iIndepFun_iff_map_fun_eq_pi_map (fun c => (measurable_pi_apply c).aemeasurable)).mpr
  change (Measure.pi ν).map id = _
  rw [Measure.map_id]
  congr 1
  funext c
  exact (product_measure_marginal ν c).symm

theorem product_coordinate_mean (ν : PairCoord n → Measure ℝ)
    [∀ c, IsProbabilityMeasure (ν c)] (c : PairCoord n) :
    (∫ x : PairInput n, x c ∂Measure.pi ν) = ∫ z : ℝ, z ∂ν c := by
  have h := integral_map (μ := Measure.pi ν)
    (measurable_pi_apply c).aemeasurable (f := fun z : ℝ => z)
    continuous_id.stronglyMeasurable.aestronglyMeasurable
  rw [product_measure_marginal ν c] at h
  exact h.symm

theorem product_coordinate_evariable (ν : PairCoord n → Measure ℝ)
    [∀ c, IsProbabilityMeasure (ν c)] (c : PairCoord n) (h : IsEVariable id (ν c)) :
    IsEVariable (fun x : PairInput n => x c) (Measure.pi ν) := by
  let e : PairInput n → ℝ := fun x => x c
  have hm : Measurable e := measurable_pi_apply c
  have hM : MeasurePreserving e (Measure.pi ν) (ν c) :=
    ⟨hm, product_measure_marginal ν c⟩
  have hmap : ∀ᵐ z ∂(Measure.pi ν).map e, 0 ≤ z := by rw [hM.map_eq]; exact h.1
  have hn : ∀ᵐ x ∂Measure.pi ν, 0 ≤ e x :=
    (ae_map_iff hm.aemeasurable (measurableSet_Ici : MeasurableSet (Set.Ici (0 : ℝ)))).mp hmap
  refine ⟨hn, (hM.integrable_comp h.2.1.aestronglyMeasurable).mpr h.2.1, ?_⟩
  rw [product_coordinate_mean ν c]
  exact h.2.2

/-- Every independent family of marginal e-variable laws is a valid test,
including continuous laws and laws with unbounded support. -/
def IsProductIndependentEMerger (F : PairInput n → ℝ) : Prop :=
  (∀ x, (∀ c, 0 ≤ x c) → 0 ≤ F x) ∧ Measurable F ∧
  ∀ ν : PairCoord n → Measure ℝ, (∀ c, IsProbabilityMeasure (ν c)) →
    (∀ c, IsEVariable id (ν c)) →
    Integrable F (Measure.pi ν) ∧ (∫ x, F x ∂Measure.pi ν) ≤ 1

theorem productMerger_isIndependentEMerger (lam : Fin n → ℝ)
    (hl : ∀ i, 0 ≤ lam i) (hu : ∀ i, lam i ≤ 1) :
    IsProductIndependentEMerger (productMerger lam) := by
  refine ⟨productMerger_nonnegative lam hl hu, (productMerger_continuous lam).measurable, ?_⟩
  intro ν hp hν
  letI : ∀ c, IsProbabilityMeasure (ν c) := hp
  exact (product_merger_valid (product_measure_independence ν)
    (fun c => product_coordinate_evariable ν c (hν c)) lam hl hu).2

theorem exactNull_atom_pos {x : ℝ} (hx : 0 ≤ x) :
    0 < exactNull x ({x} : Set ℝ) := by
  have hp := (exactNull_parameters hx).1
  unfold exactNull
  simp only [Measure.add_apply, Measure.smul_apply, smul_eq_mul,
    Measure.dirac_apply_of_mem (Set.mem_singleton x), mul_one]
  exact lt_of_lt_of_le (ENNReal.ofReal_pos.mpr hp) le_self_add

theorem productMerger_admissible (lam : Fin n → ℝ)
    (hl : ∀ i, 0 ≤ lam i) (hu : ∀ i, lam i ≤ 1) (H : PairInput n → ℝ)
    (hH : IsProductIndependentEMerger H)
    (hdom : ∀ x, (∀ c, 0 ≤ x c) → productMerger lam x ≤ H x) :
    ∀ x, (∀ c, 0 ≤ x c) → H x = productMerger lam x := by
  classical
  intro x hx
  let ν (c : PairCoord n) := exactNull (x c)
  letI : ∀ c, IsProbabilityMeasure (ν c) := fun c => exactNull_probability (hx c)
  have he (c : PairCoord n) := exactNull_evariable (hx c)
  have heval (c : PairCoord n) := product_coordinate_evariable ν c (he c)
  have hF := (productMerger_isIndependentEMerger lam hl hu).2.2 ν (fun _ => inferInstance) he
  have hHg := hH.2.2 ν (fun _ => inferInstance) he
  have hμ := product_measure_independence ν
  have hprec : (∫ z, productMerger lam z ∂Measure.pi ν) = 1 := by
    apply product_merger_precise hμ (fun c => (heval c).2.1) _ lam
    intro c
    rw [product_coordinate_mean ν c]
    exact exactNull_mean_one (hx c)
  have hAE : productMerger lam ≤ᵐ[Measure.pi ν] H := by
    have hnn : ∀ᵐ z ∂Measure.pi ν, ∀ c, 0 ≤ z c := ae_all_iff.mpr fun c => (heval c).1
    exact hnn.mono fun z hz => hdom z hz
  have hInt : (∫ z, productMerger lam z ∂Measure.pi ν) = (∫ z, H z ∂Measure.pi ν) :=
    le_antisymm (integral_mono_ae hF.1 hHg.1 hAE) (by rw [hprec]; exact hHg.2)
  have heq := (integral_eq_iff_of_ae_le hF.1 hHg.1 hAE).mp hInt
  have hpos : 0 < Measure.pi ν ({x} : Set (PairInput n)) := by
    rw [← Set.univ_pi_singleton x, Measure.pi_pi]
    exact pos_iff_ne_zero.mpr (Finset.prod_ne_zero_iff.mpr fun c _ =>
      (exactNull_atom_pos (hx c)).ne')
  by_contra hx'
  have hd : ({x} : Set (PairInput n)) ⊆ {z | ¬ productMerger lam z = H z} := by
    intro z hz
    simpa [(Set.mem_singleton_iff.mp hz)] using Ne.symm hx'
  exact hpos.ne' (measure_mono_null hd (ae_iff.mp heq))

end IndependentMerging
