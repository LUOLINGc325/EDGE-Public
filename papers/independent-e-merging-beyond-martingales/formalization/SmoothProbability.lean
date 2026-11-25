import SmoothProperties

open MeasureTheory ProbabilityTheory

namespace IndependentMerging

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

theorem smoothRoot_integrable [IsFiniteMeasure μ] {X : Ω → ℝ} {eps : ℝ}
    (he : 0 ≤ eps) (hX : Integrable X μ) :
    Integrable (fun ω => smoothRoot eps (X ω)) μ := by
  apply (hX.norm.add (integrable_const (1 + eps))).mono'
  · exact ((smoothRoot_continuous eps).measurable.comp_aemeasurable
      hX.aestronglyMeasurable.aemeasurable).aestronglyMeasurable
  · filter_upwards [] with ω
    change ‖smoothRoot eps (X ω)‖ ≤ ‖X ω‖ + (1 + eps)
    rw [Real.norm_eq_abs, abs_of_nonneg (smoothRoot_nonnegative eps (X ω)), Real.norm_eq_abs]
    linarith [smoothRoot_growth_bound he (X ω)]

theorem smoothMerger_moments [IsProbabilityMeasure μ]
    {X Y : Ω → ℝ} {eps : ℝ} (he : 0 ≤ eps) (lam : ℝ)
    (hind : IndepFun X Y μ) (hX : Integrable X μ) (hY : Integrable Y μ) :
    Integrable (fun ω => smoothMerger eps lam (X ω) (Y ω)) μ ∧
      ((∫ ω, smoothMerger eps lam (X ω) (Y ω) ∂μ) =
        1 + lam / 2 * (((∫ ω, X ω ∂μ) - 1) * (∫ ω, smoothRoot eps (Y ω) ∂μ) +
        ((∫ ω, Y ω ∂μ) - 1) * (∫ ω, smoothRoot eps (X ω) ∂μ))) := by
  have hX₁ : Integrable (fun ω => X ω - 1) μ := hX.sub (integrable_const 1)
  have hY₁ : Integrable (fun ω => Y ω - 1) μ := hY.sub (integrable_const 1)
  have hXr := smoothRoot_integrable he hX
  have hYr := smoothRoot_integrable he hY
  have hm₁ : Measurable (fun x : ℝ => x - 1) := measurable_id.sub_const 1
  have hmr : Measurable (smoothRoot eps) := (smoothRoot_continuous eps).measurable
  have hleft : IndepFun (fun ω => X ω - 1) (fun ω => smoothRoot eps (Y ω)) μ :=
    hind.comp hm₁ hmr
  have hright : IndepFun (fun ω => Y ω - 1) (fun ω => smoothRoot eps (X ω)) μ :=
    hind.symm.comp hm₁ hmr
  have hli : Integrable (fun ω => (X ω - 1) * smoothRoot eps (Y ω)) μ :=
    hleft.integrable_mul hX₁ hYr
  have hri : Integrable (fun ω => (Y ω - 1) * smoothRoot eps (X ω)) μ :=
    hright.integrable_mul hY₁ hXr
  have hsc : Integrable (fun ω => lam / 2 *
      ((X ω - 1) * smoothRoot eps (Y ω) + (Y ω - 1) * smoothRoot eps (X ω))) μ :=
    (hli.add hri).const_mul (lam / 2)
  refine ⟨(integrable_const 1).add hsc, ?_⟩
  have hl := hleft.integral_mul_of_integrable hX₁ hYr
  have hr := hright.integral_mul_of_integrable hY₁ hXr
  change (∫ ω, (X ω - 1) * smoothRoot eps (Y ω) ∂μ) = _ at hl
  change (∫ ω, (Y ω - 1) * smoothRoot eps (X ω) ∂μ) = _ at hr
  unfold smoothMerger
  rw [integral_add (integrable_const 1) hsc, integral_const_mul, integral_add hli hri, hl, hr,
    integral_sub hX (integrable_const 1), integral_sub hY (integrable_const 1)]
  simp

theorem smoothMerger_valid [IsProbabilityMeasure μ]
    {X Y : Ω → ℝ} {eps lam : ℝ} (he : 0 < eps) (hl : 0 < lam)
    (hu : lam ≤ 1 / Real.sqrt (1 + eps ^ 2))
    (hind : IndepFun X Y μ) (hX : IsEVariable X μ) (hY : IsEVariable Y μ) :
    IsEVariable (fun ω => smoothMerger eps lam (X ω) (Y ω)) μ := by
  obtain ⟨hi, hformula⟩ := smoothMerger_moments he.le lam hind hX.2.1 hY.2.1
  have hn : ∀ᵐ ω ∂μ, 0 ≤ smoothMerger eps lam (X ω) (Y ω) := by
    filter_upwards [hX.1, hY.1] with ω hωx hωy
    exact smoothMerger_nonnegative he hl hu hωx hωy
  have hxr : 0 ≤ (∫ ω, smoothRoot eps (X ω) ∂μ) :=
    integral_nonneg fun ω => smoothRoot_nonnegative eps (X ω)
  have hyr : 0 ≤ (∫ ω, smoothRoot eps (Y ω) ∂μ) :=
    integral_nonneg fun ω => smoothRoot_nonnegative eps (Y ω)
  refine ⟨hn, hi, ?_⟩
  rw [hformula]
  have hleft := mul_nonpos_of_nonpos_of_nonneg (sub_nonpos.mpr hX.2.2) hyr
  have hright := mul_nonpos_of_nonpos_of_nonneg (sub_nonpos.mpr hY.2.2) hxr
  have hp := mul_nonpos_of_nonneg_of_nonpos (by positivity : 0 ≤ lam / 2)
    (add_nonpos hleft hright)
  linarith

theorem smoothMerger_precise [IsProbabilityMeasure μ]
    {X Y : Ω → ℝ} {eps : ℝ} (he : 0 ≤ eps) (lam : ℝ)
    (hind : IndepFun X Y μ) (hX : Integrable X μ) (hY : Integrable Y μ)
    (hx : (∫ ω, X ω ∂μ) = 1) (hy : (∫ ω, Y ω ∂μ) = 1) :
    (∫ ω, smoothMerger eps lam (X ω) (Y ω) ∂μ) = 1 := by
  rw [(smoothMerger_moments he lam hind hX hY).2, hx, hy]
  simp

theorem smoothMerger_isIndependentEMerger {eps lam : ℝ} (he : 0 < eps) (hl : 0 < lam)
    (hu : lam ≤ 1 / Real.sqrt (1 + eps ^ 2)) : IsIndependentEMerger (smoothMerger eps lam) := by
  refine ⟨fun _ _ hx hy => smoothMerger_nonnegative he hl hu hx hy,
    (smoothMerger_continuous eps lam).measurable, ?_⟩
  intro μ ν hp hq hx hy
  letI := hp
  letI := hq
  exact (smoothMerger_valid he hl hu (product_coordinates_independent μ ν)
    (product_fst_evariable μ ν hx) (product_snd_evariable μ ν hy)).2

theorem precise_on_atoms_is_admissible {T H : ℝ → ℝ → ℝ}
    (hT : IsIndependentEMerger T) (hH : IsIndependentEMerger H)
    (hp : ∀ x y : ℝ, 0 ≤ x → 0 ≤ y →
      (∫ z : ℝ × ℝ, T z.1 z.2 ∂(exactNull x).prod (exactNull y)) = 1)
    (hdom : DominatesOnQuadrant H T) :
    ∀ x y : ℝ, 0 ≤ x → 0 ≤ y → H x y = T x y := by
  intro x y hx hy
  let μ := exactNull x
  let ν := exactNull y
  letI : IsProbabilityMeasure μ := exactNull_probability hx
  letI : IsProbabilityMeasure ν := exactNull_probability hy
  have hTe := hT.2.2 μ ν inferInstance inferInstance (exactNull_evariable hx) (exactNull_evariable hy)
  have hHe := hH.2.2 μ ν inferInstance inferInstance (exactNull_evariable hx) (exactNull_evariable hy)
  have he := hp x y hx hy
  rw [exact_product_integral hx hy T hTe.1] at he
  rw [exact_product_integral hx hy H hHe.1] at hHe
  obtain ⟨hx1, hx2, hcx, _, _⟩ := exactNull_parameters hx
  obtain ⟨hy1, hy2, hcy, _, _⟩ := exactNull_parameters hy
  have hterm₁ := mul_nonneg (mul_nonneg hx1.le hy2.le)
    (sub_nonneg.mpr (hdom x (companion y) hx hcy))
  have hterm₂ := mul_nonneg (mul_nonneg hx2.le hy1.le)
    (sub_nonneg.mpr (hdom (companion x) y hcx hy))
  have hterm₃ := mul_nonneg (mul_nonneg hx2.le hy2.le)
    (sub_nonneg.mpr (hdom (companion x) (companion y) hcx hcy))
  have ht : atomWeight x * atomWeight y * (H x y - T x y) ≤ 0 := by
    linarith only [he, hHe.2, hterm₁, hterm₂, hterm₃]
  apply le_antisymm _ (hdom x y hx hy)
  by_contra! hh
  exact (not_lt_of_ge ht) (mul_pos (mul_pos hx1 hy1) (sub_pos.mpr hh))

theorem smoothMerger_admissible {eps lam : ℝ} (he : 0 < eps) (hl : 0 < lam)
    (hu : lam ≤ 1 / Real.sqrt (1 + eps ^ 2)) (H : ℝ → ℝ → ℝ)
    (hH : IsIndependentEMerger H) (hdom : DominatesOnQuadrant H (smoothMerger eps lam)) :
    ∀ x y : ℝ, 0 ≤ x → 0 ≤ y → H x y = smoothMerger eps lam x y := by
  apply precise_on_atoms_is_admissible (smoothMerger_isIndependentEMerger he hl hu) hH _ hdom
  intro x y hx hy
  let μ := exactNull x
  let ν := exactNull y
  letI : IsProbabilityMeasure μ := exactNull_probability hx
  letI : IsProbabilityMeasure ν := exactNull_probability hy
  have hX := product_fst_evariable μ ν (exactNull_evariable hx)
  have hY := product_snd_evariable μ ν (exactNull_evariable hy)
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
  exact smoothMerger_precise he.le lam (product_coordinates_independent μ ν)
    hX.2.1 hY.2.1 hmeanX hmeanY

end IndependentMerging
