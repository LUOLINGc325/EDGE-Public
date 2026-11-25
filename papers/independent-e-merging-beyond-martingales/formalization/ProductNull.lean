import TreeAssembly

open Finset MeasureTheory ProbabilityTheory
open scoped BigOperators

namespace IndependentMerging

variable {n : ℕ}

noncomputable def partialMerger (s : Finset (Fin n)) (lam : Fin n → ℝ) (x : PairInput n) : ℝ :=
  ∏ i ∈ s, mergerLambda (lam i) (x (i, false)) (x (i, true))

theorem partialMerger_insert {s : Finset (Fin n)} {i : Fin n} (hi : i ∉ s)
    (lam : Fin n → ℝ) (x : PairInput n) :
    partialMerger (insert i s) lam x =
      mergerLambda (lam i) (x (i, false)) (x (i, true)) * partialMerger s lam x :=
  Finset.prod_insert hi

theorem productMerger_continuous (lam : Fin n → ℝ) : Continuous (productMerger lam) := by
  unfold productMerger
  refine continuous_finset_prod _ fun i _ => ?_
  change Continuous ((fun z : ℝ × ℝ => mergerLambda (lam i) z.1 z.2) ∘
    (fun x : PairInput n => (x (i, false), x (i, true))))
  exact (mergerLambda_continuous (lam i)).comp
    ((continuous_apply (i, false)).prodMk (continuous_apply (i, true)))

theorem productMerger_nonnegative (lam : Fin n → ℝ) (hl : ∀ i, 0 ≤ lam i)
    (hu : ∀ i, lam i ≤ 1) (x : PairInput n) (hx : ∀ c, 0 ≤ x c) : 0 ≤ productMerger lam x :=
  Finset.prod_nonneg fun i _ => mergerLambda_nonnegative (hl i) (hu i) (hx _) (hx _)

theorem productMerger_monotone (lam : Fin n → ℝ) (hl : ∀ i, 0 ≤ lam i)
    (hu : ∀ i, lam i ≤ 1) (x y : PairInput n) (hx : ∀ c, 0 ≤ x c) (hxy : ∀ c, x c ≤ y c) :
    productMerger lam x ≤ productMerger lam y := by
  apply Finset.prod_le_prod
  · intro i _
    exact mergerLambda_nonnegative (hl i) (hu i) (hx _) (hx _)
  · intro i _
    exact (mergerLambda_monotone_left (hl i) (hxy (i, false))).trans
      (mergerLambda_monotone_right (hl i) (hxy (i, true)))

theorem productMerger_pair_swaps (lam : Fin n → ℝ) (swap : Fin n → Bool) (x : PairInput n) :
    productMerger lam (fun c => x (c.1, if swap c.1 then !c.2 else c.2)) = productMerger lam x := by
  unfold productMerger
  apply Finset.prod_congr rfl
  intro i _
  cases hs : swap i <;> simp [hs, mergerLambda_symmetric]

theorem productMerger_uniform_pair_permutation (lam : ℝ) (e : Equiv.Perm (Fin n))
    (x : PairInput n) : productMerger (fun _ => lam) (fun c => x (e c.1, c.2)) =
      productMerger (fun _ => lam) x := by
  unfold productMerger
  exact Equiv.prod_comp e (fun i => mergerLambda lam (x (i, false)) (x (i, true)))

theorem separate_pair_domain {s : Finset (Fin n)} {i : Fin n} (hi : i ∉ s) :
    Disjoint (pairDomain i) (pairsDomain s) := by
  apply Finset.disjoint_left.mpr
  intro c hc hcs
  exact hi ((mem_pairDomain_iff i c).mp hc ▸ (mem_pairsDomain s c).mp hcs)

noncomputable def extendInput (D : Finset (PairCoord n)) (u : (↥D → ℝ)) : PairInput n :=
  fun c => if hc : c ∈ D then u ⟨c, hc⟩ else 0

theorem extendInput_measurable (D : Finset (PairCoord n)) (c : PairCoord n) :
    Measurable (fun u : ↥D → ℝ => extendInput D u c) := by
  by_cases h : c ∈ D
  · simpa [extendInput, h] using (measurable_pi_apply (⟨c, h⟩ : ↥D)
      : Measurable fun u : ↥D → ℝ => u ⟨c, h⟩)
  · simp [extendInput, h]

theorem merger_on_extension_measurable (D : Finset (PairCoord n)) (i : Fin n) (lam : ℝ) :
    Measurable (fun u : ↥D → ℝ => mergerLambda lam
      (extendInput D u (i, false)) (extendInput D u (i, true))) := by
  change Measurable ((fun z : ℝ × ℝ => mergerLambda lam z.1 z.2) ∘
    (fun u : ↥D → ℝ => (extendInput D u (i, false), extendInput D u (i, true))))
  exact (mergerLambda_continuous lam).measurable.comp
    ((extendInput_measurable D (i, false)).prodMk (extendInput_measurable D (i, true)))

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

theorem pair_variables_independent {X : PairCoord n → Ω → ℝ}
    (hX : iIndepFun X μ) (i : Fin n) :
    IndepFun (X (i, false)) (X (i, true)) μ :=
  hX.indepFun (by simp)

set_option maxHeartbeats 600000 in
theorem pair_independent_of_other_mergers {X : PairCoord n → Ω → ℝ}
    (hX : iIndepFun X μ) (hm : ∀ c, AEMeasurable (X c) μ) (lam : Fin n → ℝ)
    {s : Finset (Fin n)} {i : Fin n} (hi : i ∉ s) :
    IndepFun (fun ω => mergerLambda (lam i) (X (i, false) ω) (X (i, true) ω))
      (fun ω => partialMerger s lam (fun c => X c ω)) μ := by
  let D := pairDomain i
  let E := pairsDomain s
  let first (u : ↥D → ℝ) := mergerLambda (lam i) (extendInput D u (i, false))
    (extendInput D u (i, true))
  let rest (v : ↥E → ℝ) := partialMerger s lam (extendInput E v)
  have he := iIndepFun.indepFun_finset₀ D E (separate_pair_domain hi) hX hm
  have hf : Measurable first := merger_on_extension_measurable D i (lam i)
  have hr : Measurable rest := by
    unfold rest partialMerger
    exact Finset.measurable_prod s (fun j _ => merger_on_extension_measurable E j (lam j))
  have hh := he.comp hf hr
  have hfirst : first ∘ (fun ω (c : ↥D) => X c ω) =
      (fun ω => mergerLambda (lam i) (X (i, false) ω) (X (i, true) ω)) := by
    funext ω
    simp [first, D, extendInput, mem_pairDomain]
  have hrest : rest ∘ (fun ω (c : ↥E) => X c ω) =
      (fun ω => partialMerger s lam (fun c => X c ω)) := by
    funext ω
    simp only [Function.comp_def, rest, partialMerger]
    apply Finset.prod_congr rfl
    intro j hj
    simp [extendInput, E, hj]
  rw [hfirst, hrest] at hh
  exact hh

theorem partial_merger_moments [IsProbabilityMeasure μ] {X : PairCoord n → Ω → ℝ}
    (hX : iIndepFun X μ) (hi : ∀ c, Integrable (X c) μ) (lam : Fin n → ℝ)
    (s : Finset (Fin n)) :
    Integrable (fun ω => partialMerger s lam (fun c => X c ω)) μ ∧
      ((∫ ω, partialMerger s lam (fun c => X c ω) ∂μ) =
        ∏ i ∈ s, ∫ ω, mergerLambda (lam i) (X (i, false) ω) (X (i, true) ω) ∂μ) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp [partialMerger]
  | insert i s hmem ih =>
    have ht := mergerLambda_integrable (lam i) (pair_variables_independent hX i) (hi _) (hi _)
    have hind := pair_independent_of_other_mergers hX
      (fun c => (hi c).aestronglyMeasurable.aemeasurable) lam hmem
    simp_rw [partialMerger_insert hmem]
    refine ⟨hind.integrable_mul ht ih.1, ?_⟩
    have hmul := hind.integral_mul_of_integrable ht ih.1
    change (∫ ω, mergerLambda (lam i) (X (i, false) ω) (X (i, true) ω) *
      partialMerger s lam (fun c => X c ω) ∂μ) = _ at hmul
    rw [hmul, ih.2, Finset.prod_insert hmem]

theorem product_merger_integral [IsProbabilityMeasure μ] {X : PairCoord n → Ω → ℝ}
    (hX : iIndepFun X μ) (hi : ∀ c, Integrable (X c) μ) (lam : Fin n → ℝ) :
    (∫ ω, productMerger lam (fun c => X c ω) ∂μ) =
      ∏ i, ∫ ω, mergerLambda (lam i) (X (i, false) ω) (X (i, true) ω) ∂μ :=
  (partial_merger_moments hX hi lam Finset.univ).2

theorem product_merger_valid [IsProbabilityMeasure μ] {X : PairCoord n → Ω → ℝ}
    (hX : iIndepFun X μ) (hi : ∀ c, IsEVariable (X c) μ) (lam : Fin n → ℝ)
    (hl : ∀ i, 0 ≤ lam i) (hu : ∀ i, lam i ≤ 1) :
    IsEVariable (fun ω => productMerger lam (fun c => X c ω)) μ := by
  have hxnonneg : ∀ᵐ ω ∂μ, ∀ c, 0 ≤ X c ω := ae_all_iff.mpr (fun c => (hi c).1)
  have hpair (i : Fin n) := independent_e_merger_valid (hl i) (hu i)
    (pair_variables_independent hX i) (hi (i, false)) (hi (i, true))
  refine ⟨hxnonneg.mono (fun ω hw => productMerger_nonnegative lam hl hu (fun c => X c ω) hw),
    (partial_merger_moments hX (fun c => (hi c).2.1) lam Finset.univ).1, ?_⟩
  rw [product_merger_integral hX (fun c => (hi c).2.1) lam]
  calc
    _ ≤ ∏ _i : Fin n, (1 : ℝ) := Finset.prod_le_prod
      (fun i _ => integral_nonneg_of_ae (hpair i).1) (fun i _ => (hpair i).2.2)
    _ = _ := by simp

theorem product_merger_precise [IsProbabilityMeasure μ] {X : PairCoord n → Ω → ℝ}
    (hX : iIndepFun X μ) (hi : ∀ c, Integrable (X c) μ)
    (hExact : ∀ c, (∫ ω, X c ω ∂μ) = 1) (lam : Fin n → ℝ) :
    (∫ ω, productMerger lam (fun c => X c ω) ∂μ) = 1 := by
  rw [product_merger_integral hX hi lam]
  exact Finset.prod_eq_one fun i _ =>
    independent_e_merger_precise (lam i) (pair_variables_independent hX i)
      (hi _) (hi _) (hExact _) (hExact _)

end IndependentMerging
