import GrowingKernelIntegral

/-! Lebesgue tails for the exponential envelopes used in the kernel approximation. -/

open scoped Topology
open Set Filter MeasureTheory

namespace RenyiProductOrderPhase

noncomputable def exponentialEnvelope (c x : ℝ) : ℝ := Real.exp (-c * |x|)

theorem exponential_envelope_left (c : ℝ) {x : ℝ} (hx : x ≤ 0) :
    exponentialEnvelope c x = Real.exp (c * x) := by
  unfold exponentialEnvelope
  rw [abs_of_nonpos hx, mul_neg, neg_mul, neg_neg]

theorem exponential_envelope_right (c : ℝ) {x : ℝ} (hx : 0 ≤ x) :
    exponentialEnvelope c x = Real.exp (-c * x) := by
  unfold exponentialEnvelope
  rw [abs_of_nonneg hx]

theorem exponential_envelope_integrable {c : ℝ} (hc : 0 < c) :
    Integrable (exponentialEnvelope c) := by
  have hL : IntegrableOn (exponentialEnvelope c) (Iic 0) :=
    (integrableOn_exp_mul_Iic hc 0).congr_fun
      (fun _ hx => (exponential_envelope_left c hx).symm) measurableSet_Iic
  have hR : IntegrableOn (exponentialEnvelope c) (Ioi 0) :=
    (integrableOn_exp_mul_Ioi (neg_lt_zero.mpr hc) 0).congr_fun
      (fun _ hx => (exponential_envelope_right c (mem_Ioi.mp hx).le).symm) measurableSet_Ioi
  simpa only [Iic_union_Ioi, integrableOn_univ] using hL.union hR

theorem exponential_envelope_tail_integral {c L : ℝ} (hc : 0 < c) (hL : 0 < L) :
    (∫ x in {s : ℝ | L ≤ |s|}, exponentialEnvelope c x) = 2 * Real.exp (-c * L) / c := by
  have hSet : {s : ℝ | L ≤ |s|} = Iic (-L) ∪ Ici L := by
    ext x
    change L ≤ |x| ↔ x ≤ -L ∨ L ≤ x
    rw [le_abs]
    constructor
    · rintro (h | h)
      · exact Or.inr h
      · exact Or.inl (by linarith only [h])
    · rintro (h | h)
      · exact Or.inr (by linarith only [h])
      · exact Or.inl h
  have hDisj : Disjoint (Iic (-L)) (Ici L) := Set.disjoint_left.2 (fun x h₁ h₂ => by
    have hA : x ≤ -L := h₁
    have hB : L ≤ x := h₂
    linarith only [hA, hB, hL])
  have hInt := exponential_envelope_integrable hc
  have hLeft : (∫ x in Iic (-L), exponentialEnvelope c x) = ∫ x in Iic (-L), Real.exp (c * x) := by
    refine setIntegral_congr_fun measurableSet_Iic (fun x hx => ?_)
    exact exponential_envelope_left c ((mem_Iic.mp hx).trans (neg_nonpos.mpr hL.le))
  have hRight : (∫ x in Ioi L, exponentialEnvelope c x) = ∫ x in Ioi L, Real.exp (-c * x) := by
    refine setIntegral_congr_fun measurableSet_Ioi (fun x hx => ?_)
    exact exponential_envelope_right c (hL.trans (mem_Ioi.mp hx)).le
  rw [hSet, setIntegral_union hDisj measurableSet_Ici hInt.integrableOn hInt.integrableOn,
    integral_Ici_eq_integral_Ioi, hLeft, hRight, integral_exp_mul_Iic hc,
    integral_exp_mul_Ioi (neg_lt_zero.mpr hc), mul_neg, neg_mul, neg_div_neg_eq]
  ring

theorem exponential_envelope_tail_small {c ε : ℝ} (hc : 0 < c) (hε : 0 < ε) :
    ∃ K > 0, ∀ L ≥ K, (∫ x in {s : ℝ | L ≤ |s|}, exponentialEnvelope c x) < ε := by
  have hLin : Tendsto (fun L : ℝ => -c * L) atTop atBot :=
    (tendsto_const_mul_atBot_of_neg (neg_lt_zero.mpr hc)).mpr tendsto_id
  have hT : Tendsto (fun L : ℝ => 2 * Real.exp (-c * L) / c) atTop (𝓝 0) := by
    simpa only [Function.comp_apply, mul_zero, zero_div] using
      (((Real.tendsto_exp_atBot.comp hLin).const_mul (2 : ℝ)).div_const c)
  obtain ⟨K₀, hK₀⟩ := eventually_atTop.1 (hT.eventually (Iio_mem_nhds hε))
  let K := max K₀ 1
  have hK : 0 < K := zero_lt_one.trans_le (le_max_right _ _)
  refine ⟨K, hK, ?_⟩
  intro L hLK
  rw [exponential_envelope_tail_integral hc (hK.trans_le hLK)]
  exact hK₀ L ((le_max_left _ _).trans hLK)

end RenyiProductOrderPhase
