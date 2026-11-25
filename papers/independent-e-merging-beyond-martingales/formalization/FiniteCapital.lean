import OptimalCapital

open Filter MeasureTheory
open scoped Topology

namespace IndependentMerging

noncomputable def finiteCapital (lam t : ℝ) : ℝ := max 1 (threeRatio lam t)

theorem finiteCapital_at_least_one (lam t : ℝ) : 1 ≤ finiteCapital lam t :=
  le_max_left _ _

theorem finiteCapital_bounded {lam t : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) (ht : 1 < t) :
    finiteCapital lam t ≤ 3 / 2 := by
  apply max_le (by norm_num)
  exact (three_ratio_le_wholeCapital hl ht).trans (by unfold wholeCapital; linarith)

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

theorem PairMixture.finite_capital_lower [IsProbabilityMeasure μ] (G : PairMixture μ)
    {lam t : ℝ} (ht : 1 < t)
    (h01 : mergerLambda lam 0 1 ≤ G.payoff 0 1)
    (h10 : mergerLambda lam 1 0 ≤ G.payoff 1 0)
    (htt : mergerLambda lam t t ≤ G.payoff t t) :
    finiteCapital lam t ≤ G.mean := by
  apply max_le
  · rw [← (mergerLambda_axis lam).1]
    exact h01.trans (G.no_gain_on_unit_box (by constructor <;> norm_num)
      (by constructor <;> norm_num))
  · have h := G.three_ratio_lower (c := 1) ht (by simpa using h01)
      (by simpa using h10) (by simpa using htt)
    simpa using h

noncomputable def finiteFirstStake (lam t : ℝ) : ℝ :=
  2 * (finiteCapital lam t - 1) / finiteCapital lam t

noncomputable def finiteSecondStake (t z : ℝ) : ℝ := if z = t then 1 else 0

theorem finiteFirstStake_bounds {lam t : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) (ht : 1 < t) :
    0 ≤ finiteFirstStake lam t ∧ finiteFirstStake lam t ≤ 1 := by
  have hm := finiteCapital_at_least_one lam t
  have hC := finiteCapital_bounded hl hu ht
  have hpos : 0 < finiteCapital lam t := by linarith
  unfold finiteFirstStake
  exact ⟨div_nonneg (mul_nonneg (by norm_num) (sub_nonneg.mpr hm)) hpos.le,
    (div_le_iff₀ hpos).mpr (by linarith)⟩

theorem finiteSecondStake_bounds (t z : ℝ) :
    0 ≤ finiteSecondStake t z ∧ finiteSecondStake t z ≤ 1 := by
  unfold finiteSecondStake
  split <;> norm_num

theorem finite_capital_times_stake (lam t : ℝ) :
    finiteCapital lam t * finiteFirstStake lam t = 2 * (finiteCapital lam t - 1) := by
  have hn : finiteCapital lam t ≠ 0 :=
    ne_of_gt ((by norm_num : (0 : ℝ) < 1).trans_le (finiteCapital_at_least_one lam t))
  unfold finiteFirstStake
  field_simp [hn]

noncomputable def finiteDomainOptimizer {lam t : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1)
    (ht : 1 < t) : PairMixture fairOrderLaw :=
  fairTwoOrders (finiteCapital lam t) (finiteFirstStake lam t) (finiteSecondStake t)
    ((by norm_num : (0 : ℝ) ≤ 1).trans (finiteCapital_at_least_one lam t))
    (finiteFirstStake_bounds hl hu ht) (finiteSecondStake_bounds t)

theorem finiteDomainOptimizer_mean {lam t : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) (ht : 1 < t) :
    (finiteDomainOptimizer hl hu ht).mean = finiteCapital lam t := fairTwoOrders_mean ..

theorem finiteDomainOptimizer_axes {lam t : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) (ht : 1 < t) :
    let G := finiteDomainOptimizer hl hu ht
    G.payoff 0 1 = 1 ∧ G.payoff 1 0 = 1 := by
  have ht1 : (1 : ℝ) ≠ t := (ne_of_gt ht).symm
  have ht0 : (0 : ℝ) ≠ t := ne_of_lt (by linarith)
  have hm := finite_capital_times_stake lam t
  dsimp only
  unfold finiteDomainOptimizer
  rw [fairTwoOrders_payoff, fairTwoOrders_payoff]
  simp only [orderedStrategy, Bool.false_eq_true, ↓reduceIte, finiteSecondStake, if_neg ht0,
    if_neg ht1]
  constructor <;> nlinarith

theorem finiteDomainOptimizer_diagonal {lam t : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) (ht : 1 < t) :
    (finiteDomainOptimizer hl hu ht).payoff t t =
      finiteCapital lam t * threeDenominator t - 2 * t * (t - 1) := by
  unfold finiteDomainOptimizer
  rw [fairTwoOrders_payoff]
  simp only [orderedStrategy, Bool.false_eq_true, ↓reduceIte, finiteSecondStake, if_pos rfl, one_mul]
  have h := finite_capital_times_stake lam t
  calc
    _ = finiteCapital lam t * t +
          (finiteCapital lam t * finiteFirstStake lam t) * t * (t - 1) := by ring
    _ = _ := by rw [h]; unfold threeDenominator; ring

theorem finite_domain_cost_attained {lam t : ℝ} (hl : 0 ≤ lam) (hu : lam ≤ 1) (ht : 1 < t) :
    ∃ H : PairMixture fairOrderLaw, H.mean = finiteCapital lam t ∧
      mergerLambda lam 0 1 ≤ H.payoff 0 1 ∧ mergerLambda lam 1 0 ≤ H.payoff 1 0 ∧
      mergerLambda lam t t ≤ H.payoff t t := by
  let H := finiteDomainOptimizer hl hu ht
  have ha := finiteDomainOptimizer_axes hl hu ht
  refine ⟨H, finiteDomainOptimizer_mean hl hu ht, ?_, ?_, ?_⟩
  · rw [(mergerLambda_axis lam).1, ha.1]
  · rw [(mergerLambda_axis lam).2, ha.2]
  · rw [finiteDomainOptimizer_diagonal hl hu ht, mergerLambda_diagonal lam ht.le]
    have hr : threeRatio lam t ≤ finiteCapital lam t := le_max_right _ _
    have hd := (div_le_iff₀ (threeDenominator_pos ht)).mp hr
    unfold threeNumerator at hd
    linarith

theorem finite_cost_example : finiteCapital 1 3 = (17 / 15 : ℝ) := by
  norm_num [finiteCapital, threeRatio, threeNumerator, threeDenominator, max_def]

theorem finite_capital_limit {lam : ℝ} (hl : 0 ≤ lam) :
    Tendsto (finiteCapital lam) atTop (𝓝 (wholeCapital lam)) := by
  have h := (show Tendsto (fun _ : ℝ => (1 : ℝ)) atTop (𝓝 1) from tendsto_const_nhds).max
    (three_ratio_limit lam)
  have hh : 1 ≤ wholeCapital lam := by unfold wholeCapital; linarith
  simpa only [finiteCapital, max_eq_right hh] using h

end IndependentMerging
