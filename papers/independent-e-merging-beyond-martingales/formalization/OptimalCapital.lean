import PairCapitalModel
import Mathlib.Topology.Algebra.Order.Field

open Filter MeasureTheory
open scoped Topology

namespace IndependentMerging

noncomputable def wholeCapital (lam : ℝ) : ℝ := 1 + lam / 2
noncomputable def hedgeEfficiency (lam : ℝ) : ℝ := 2 / (2 + lam)
noncomputable def hedgeShare (lam : ℝ) : ℝ := lam / (2 + lam)

noncomputable def threeNumerator (lam t : ℝ) : ℝ :=
  1 + lam * (t - 1) ^ 2 + 2 * t * (t - 1)

noncomputable def threeDenominator (t : ℝ) : ℝ := t * (2 * t - 1)

noncomputable def threeRatio (lam t : ℝ) : ℝ := threeNumerator lam t / threeDenominator t

theorem threeDenominator_pos {t : ℝ} (ht : 1 < t) : 0 < threeDenominator t :=
  mul_pos (by linarith) (by linarith)

theorem mergerLambda_axis (lam : ℝ) :
    mergerLambda lam 0 1 = 1 ∧ mergerLambda lam 1 0 = 1 := by simp [mergerLambda]

theorem mergerLambda_diagonal (lam : ℝ) {t : ℝ} (ht : 1 ≤ t) :
    mergerLambda lam t t = 1 + lam * (t - 1) ^ 2 := by
  unfold mergerLambda
  rw [max_eq_left (sub_nonneg.mpr ht), max_eq_right (sub_nonpos.mpr ht)]
  ring

theorem three_numerator_sum (lam : ℝ) {t : ℝ} (ht : 1 ≤ t) :
    mergerLambda lam t t + t * (t - 1) * mergerLambda lam 0 1 +
      t * (t - 1) * mergerLambda lam 1 0 = threeNumerator lam t := by
  rw [mergerLambda_diagonal lam ht, (mergerLambda_axis lam).1, (mergerLambda_axis lam).2]
  unfold threeNumerator
  ring

theorem three_capital_surplus (lam t : ℝ) :
    wholeCapital lam * threeDenominator t - threeNumerator lam t =
      (1 + 3 * lam / 2) * t - (1 + lam) := by
  unfold wholeCapital threeDenominator threeNumerator
  ring

theorem three_ratio_le_wholeCapital {lam t : ℝ} (hl : 0 ≤ lam) (ht : 1 < t) :
    threeRatio lam t ≤ wholeCapital lam := by
  apply (div_le_iff₀ (threeDenominator_pos ht)).mpr
  apply sub_nonneg.mp
  rw [three_capital_surplus]
  have h := mul_nonneg (by linarith : 0 ≤ 1 + 3 * lam / 2) (sub_nonneg.mpr ht.le)
  nlinarith

theorem three_ratio_limit (lam : ℝ) : Tendsto (threeRatio lam) atTop (𝓝 (wholeCapital lam)) := by
  have hi : Tendsto (fun t : ℝ => t⁻¹) atTop (𝓝 0) := tendsto_inv_atTop_zero
  have h₁ := (tendsto_const_nhds (x := (1 : ℝ)) (f := (atTop : Filter ℝ))).sub hi
  have h₂ := (tendsto_const_nhds (x := (2 : ℝ)) (f := (atTop : Filter ℝ))).sub hi
  have hn := ((hi.pow 2).add ((h₁.pow 2).const_mul lam)).add (h₁.const_mul 2)
  have h := hn.div h₂ (by norm_num)
  have ht : ∀ᶠ t : ℝ in atTop, 1 < t := eventually_gt_atTop 1
  have he : (fun t : ℝ => (t⁻¹ ^ 2 + lam * (1 - t⁻¹) ^ 2 + 2 * (1 - t⁻¹)) /
      (2 - t⁻¹)) =ᶠ[atTop] threeRatio lam := by
    filter_upwards [ht] with t h
    have ht0 : t ≠ 0 := by linarith
    have hd : 2 * t - 1 ≠ 0 := by linarith
    have hd' : 2 - t⁻¹ ≠ 0 := by
      have hi' := inv_lt_one_of_one_lt₀ h
      linarith
    unfold threeRatio threeNumerator threeDenominator
    field_simp [ht0, hd, hd']
    all_goals ring
  have hv : (0 ^ 2 + lam * (1 - 0) ^ 2 + 2 * (1 - 0)) / (2 - 0) = wholeCapital lam := by
    unfold wholeCapital
    ring
  rw [← hv]
  exact h.congr' he

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

theorem PairMixture.three_ratio_lower [IsProbabilityMeasure μ] (G : PairMixture μ)
    {lam c t : ℝ} (ht : 1 < t)
    (h01 : c * mergerLambda lam 0 1 ≤ G.payoff 0 1)
    (h10 : c * mergerLambda lam 1 0 ≤ G.payoff 1 0)
    (htt : c * mergerLambda lam t t ≤ G.payoff t t) :
    c * threeRatio lam t ≤ G.mean := by
  have hw : 0 ≤ t * (t - 1) := mul_nonneg (by linarith) (sub_nonneg.mpr ht.le)
  have hi := add_le_add (add_le_add htt (mul_le_mul_of_nonneg_left h01 hw))
    (mul_le_mul_of_nonneg_left h10 hw)
  have hh : c * threeNumerator lam t ≤ threeDenominator t * G.mean := by
    rw [← three_numerator_sum lam ht.le]
    calc
      _ = (c * mergerLambda lam t t + t * (t - 1) * (c * mergerLambda lam 0 1)) +
          t * (t - 1) * (c * mergerLambda lam 1 0) := by ring
      _ ≤ _ := hi.trans (G.three_point_bound ht.le)
  rw [threeRatio, ← mul_div_assoc, div_le_iff₀ (threeDenominator_pos ht)]
  simpa [mul_comm] using hh

theorem PairMixture.whole_capital_lower [IsProbabilityMeasure μ] (G : PairMixture μ)
    {lam c : ℝ} (h : DominatesOnQuadrant G.payoff (fun x y => c * mergerLambda lam x y)) :
    c * wholeCapital lam ≤ G.mean := by
  apply le_of_tendsto ((three_ratio_limit lam).const_mul c)
  filter_upwards [eventually_gt_atTop (1 : ℝ)] with t ht
  have ht0 : 0 ≤ t := by linarith
  exact G.three_ratio_lower ht (h 0 1 (by norm_num) (by norm_num))
    (h 1 0 (by norm_num) (by norm_num)) (h t t ht0 ht0)

theorem PairMixture.efficiency_bound [IsProbabilityMeasure μ] (G : PairMixture μ)
    {lam c : ℝ} (hl : 0 ≤ lam) (hm : G.mean ≤ 1)
    (h : DominatesOnQuadrant G.payoff (fun x y => c * mergerLambda lam x y)) :
    c ≤ hedgeEfficiency lam := by
  have hd : 0 < 2 + lam := by linarith
  apply (le_div_iff₀ hd).mpr
  have hc := (G.whole_capital_lower h).trans hm
  unfold wholeCapital at hc
  nlinarith

noncomputable def hedgeStake (lam z : ℝ) : ℝ :=
  2 * lam * max (z - 1) 0 / (2 - lam + 2 * lam * z)

theorem hedgeShare_nonnegative {lam : ℝ} (hl : 0 ≤ lam) : 0 ≤ hedgeShare lam := by
  unfold hedgeShare
  positivity

theorem hedge_first_bounds {lam : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) :
    0 ≤ 2 * hedgeShare lam ∧ 2 * hedgeShare lam ≤ 1 := by
  refine ⟨mul_nonneg (by norm_num) (hedgeShare_nonnegative hl), ?_⟩
  unfold hedgeShare
  rw [← mul_div_assoc, div_le_iff₀ (by linarith : 0 < 2 + lam)]
  linarith

theorem hedgeStake_denominator_pos {lam z : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1)
    (hz : 0 ≤ z) : 0 < 2 - lam + 2 * lam * z := by
  nlinarith [mul_nonneg hl hz]

theorem hedge_second_bounds {lam : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) (z : ℝ) :
    0 ≤ hedgeStake lam z ∧ hedgeStake lam z ≤ 1 := by
  by_cases hz : z ≤ 1
  · simp [hedgeStake, max_eq_right (sub_nonpos.mpr hz)]
  · have hz' : 1 < z := lt_of_not_ge hz
    have hd := hedgeStake_denominator_pos hl hu (by linarith : 0 ≤ z)
    rw [hedgeStake, max_eq_left (sub_nonneg.mpr hz'.le)]
    refine ⟨div_nonneg (mul_nonneg (by positivity) (sub_nonneg.mpr hz'.le)) hd.le, ?_⟩
    apply (div_le_iff₀ hd).mpr
    nlinarith

noncomputable def hedgeValue (lam x y : ℝ) : ℝ :=
  1 + hedgeShare lam * ((x - 1) + (y - 1)) +
    hedgeShare lam * (max (x - 1) 0 * (y - 1) + max (y - 1) 0 * (x - 1))

theorem hedge_order_value {lam x y : ℝ}
    (hl : 0 ≤ lam) (hu : lam ≤ 1) (hx : 0 ≤ x) :
    orderedStrategy false (2 * hedgeShare lam) (hedgeStake lam) x y =
      1 + 2 * hedgeShare lam * (x - 1) + 2 * hedgeShare lam * max (x - 1) 0 * (y - 1) := by
  have hd : 2 + lam ≠ 0 := ne_of_gt (by linarith)
  have hx' := (hedgeStake_denominator_pos hl hu hx).ne'
  simp only [orderedStrategy, Bool.false_eq_true, ↓reduceIte, hedgeShare, hedgeStake]
  field_simp [hd, hx']
  ring

theorem hedge_is_fair_order_average {lam x y : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1)
    (hx : 0 ≤ x) (hy : 0 ≤ y) :
    (orderedStrategy false (2 * hedgeShare lam) (hedgeStake lam) x y +
      orderedStrategy true (2 * hedgeShare lam) (hedgeStake lam) x y) / 2 =
      hedgeValue lam x y := by
  have hswap : orderedStrategy true (2 * hedgeShare lam) (hedgeStake lam) x y =
      orderedStrategy false (2 * hedgeShare lam) (hedgeStake lam) y x := rfl
  rw [hswap, hedge_order_value hl hu hx, hedge_order_value hl hu hy]
  unfold hedgeValue
  ring

theorem hedge_dominates_scaled {lam x y : ℝ} (hl : 0 ≤ lam) (hx : 0 ≤ x) (hy : 0 ≤ y) :
    hedgeEfficiency lam * mergerLambda lam x y ≤ hedgeValue lam x y := by
  have hd : 2 + lam ≠ 0 := by linarith
  have hshare : 1 - hedgeEfficiency lam = hedgeShare lam := by
    unfold hedgeEfficiency hedgeShare
    field_simp [hd]
  have hsc : hedgeEfficiency lam * lam = 2 * hedgeShare lam := by
    unfold hedgeEfficiency hedgeShare
    ring
  have hcalc : hedgeValue lam x y - hedgeEfficiency lam * mergerLambda lam x y =
      hedgeShare lam * (1 + (x - 1) + (y - 1) +
        (max (x - 1) 0 * (y - 1) + max (y - 1) 0 * (x - 1)) -
        2 * (max (x - 1) 0 * max (y - 1) 0 - max (1 - x) 0 * max (1 - y) 0)) := by
    unfold hedgeValue mergerLambda
    calc
      _ = (1 - hedgeEfficiency lam) + hedgeShare lam * ((x - 1) + (y - 1) +
          (max (x - 1) 0 * (y - 1) + max (y - 1) 0 * (x - 1))) -
          (hedgeEfficiency lam * lam) *
            (max (x - 1) 0 * max (y - 1) 0 - max (1 - x) 0 * max (1 - y) 0) := by ring
      _ = _ := by rw [hshare, hsc]; ring
  apply sub_nonneg.mp
  rw [hcalc]
  apply mul_nonneg (hedgeShare_nonnegative hl)
  by_cases hxx : x ≤ 1 <;> by_cases hyy : y ≤ 1
  · rw [max_eq_right (sub_nonpos.mpr hxx), max_eq_right (sub_nonpos.mpr hyy),
        max_eq_left (sub_nonneg.mpr hxx), max_eq_left (sub_nonneg.mpr hyy)]
    have hp := mul_nonneg hx hy
    have hq := mul_nonneg (sub_nonneg.mpr hxx) (sub_nonneg.mpr hyy)
    nlinarith
  · have hY := le_of_lt (lt_of_not_ge hyy)
    rw [max_eq_right (sub_nonpos.mpr hxx), max_eq_left (sub_nonneg.mpr hY),
        max_eq_left (sub_nonneg.mpr hxx), max_eq_right (sub_nonpos.mpr hY)]
    nlinarith [mul_nonneg hx hy]
  · have hX := le_of_lt (lt_of_not_ge hxx)
    rw [max_eq_left (sub_nonneg.mpr hX), max_eq_right (sub_nonpos.mpr hyy),
        max_eq_right (sub_nonpos.mpr hX), max_eq_left (sub_nonneg.mpr hyy)]
    nlinarith [mul_nonneg hx hy]
  · have hX := le_of_lt (lt_of_not_ge hxx)
    have hY := le_of_lt (lt_of_not_ge hyy)
    rw [max_eq_left (sub_nonneg.mpr hX), max_eq_left (sub_nonneg.mpr hY),
        max_eq_right (sub_nonpos.mpr hX), max_eq_right (sub_nonpos.mpr hY)]
    nlinarith

theorem wholeCapital_mul_efficiency {lam : ℝ} (hl : 0 ≤ lam) :
    wholeCapital lam * hedgeEfficiency lam = 1 := by
  have hz : 2 + lam ≠ 0 := by linarith
  unfold wholeCapital hedgeEfficiency
  field_simp [hz]

noncomputable def wholeDomainOptimizer {lam : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) :
    PairMixture fairOrderLaw :=
  fairTwoOrders (wholeCapital lam) (2 * hedgeShare lam) (hedgeStake lam)
    (by unfold wholeCapital; linarith) (hedge_first_bounds hl hu) (hedge_second_bounds hl hu)

theorem wholeDomainOptimizer_mean {lam : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) :
    (wholeDomainOptimizer hl hu).mean = wholeCapital lam := fairTwoOrders_mean ..

theorem wholeDomainOptimizer_dominates {lam : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) :
    DominatesOnQuadrant (wholeDomainOptimizer hl hu).payoff (mergerLambda lam) := by
  intro x y hx hy
  unfold wholeDomainOptimizer
  rw [fairTwoOrders_payoff, hedge_is_fair_order_average hl hu hx hy]
  have h := mul_le_mul_of_nonneg_left (hedge_dominates_scaled hl hx hy)
    (show 0 ≤ wholeCapital lam by unfold wholeCapital; linarith)
  rw [← mul_assoc, wholeCapital_mul_efficiency hl, one_mul] at h
  exact h

theorem whole_domain_cost_attained {lam : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) :
    ∃ H : PairMixture fairOrderLaw, H.mean = wholeCapital lam ∧
      DominatesOnQuadrant H.payoff (mergerLambda lam) :=
  ⟨wholeDomainOptimizer hl hu, wholeDomainOptimizer_mean hl hu, wholeDomainOptimizer_dominates hl hu⟩

theorem unit_domain_efficiency_attained {lam : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) :
    ∃ H : PairMixture fairOrderLaw, H.mean = 1 ∧
      DominatesOnQuadrant H.payoff (fun x y => hedgeEfficiency lam * mergerLambda lam x y) := by
  let H := fairTwoOrders 1 (2 * hedgeShare lam) (hedgeStake lam) (by norm_num)
    (hedge_first_bounds hl hu) (hedge_second_bounds hl hu)
  refine ⟨H, fairTwoOrders_mean .., ?_⟩
  intro x y hx hy
  dsimp only [H]
  rw [fairTwoOrders_payoff, hedge_is_fair_order_average hl hu hx hy, one_mul]
  exact hedge_dominates_scaled hl hx hy

end IndependentMerging
