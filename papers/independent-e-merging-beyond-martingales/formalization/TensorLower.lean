import TreeCertificate

open Finset Filter MeasureTheory
open scoped BigOperators Topology

namespace IndependentMerging

variable {n : ℕ}

noncomputable def productMerger (lam : Fin n → ℝ) (x : PairInput n) : ℝ :=
  ∏ i, mergerLambda (lam i) (x (i, false)) (x (i, true))

noncomputable def productCapital (lam : Fin n → ℝ) : ℝ := ∏ i, wholeCapital (lam i)

theorem weighted_pair_merger (lam : ℝ) {t : ℝ} (ht : 1 < t) :
    (∑ a, witnessWeight t a *
      mergerLambda lam (witnessValue t a false) (witnessValue t a true)) =
    threeNumerator lam t := by
  rw [Fin.sum_univ_three]
  simp only [witnessWeight_zero, witnessWeight_one, witnessWeight_two,
    witnessValue_zero, witnessValue_one, witnessValue_two, Bool.false_eq_true, ↓reduceIte, one_mul]
  rw [(mergerLambda_axis lam).1, (mergerLambda_axis lam).2, mergerLambda_diagonal lam ht.le]
  unfold threeNumerator
  ring

theorem weighted_product_merger (lam : Fin n → ℝ) {t : ℝ} (ht : 1 < t) :
    weightedSum (fun _ : Fin n => witnessWeight t)
      (fun z => productMerger lam (witnessInput t z)) = ∏ i, threeNumerator (lam i) t := by
  change weightedSum _ (fun z => ∏ i, mergerLambda (lam i)
    (witnessValue t (z i) false) (witnessValue t (z i) true)) = _
  rw [weightedSum_product _ (fun i a => mergerLambda (lam i)
    (witnessValue t a false) (witnessValue t a true))]
  exact Finset.prod_congr rfl (fun i _ => weighted_pair_merger (lam i) ht)

theorem witnessMass_pos {t : ℝ} (ht : 1 < t) : 0 < witnessMass t := by
  unfold witnessMass
  have h := mul_pos (by linarith : 0 < 2 * t) (sub_pos.mpr ht)
  linarith

noncomputable def witnessProbability (t : ℝ) (a : PairAtom) : ℝ :=
  witnessWeight t a / witnessMass t

theorem witnessProbability_is_law {t : ℝ} (ht : 1 < t) :
    (∀ a, 0 ≤ witnessProbability t a) ∧ (∑ a, witnessProbability t a) = 1 := by
  refine ⟨fun a => div_nonneg (witnessWeight_nonnegative ht a) (witnessMass_pos ht).le, ?_⟩
  unfold witnessProbability
  rw [← Finset.sum_div, witnessWeight_sum, div_self (witnessMass_pos ht).ne']

theorem product_witness_probability {t : ℝ} (ht : 1 < t) :
    weightedSum (fun _ : Fin n => witnessProbability t) (fun _ => 1) = 1 := by
  have he : (fun _ : (Fin n → PairAtom) => (1 : ℝ)) =
      (fun _ => ∏ _i : Fin n, (1 : ℝ)) := by funext z; simp
  rw [he, weightedSum_product _ (fun _ _ => (1 : ℝ))]
  simp [witnessProbability_is_law ht]

theorem normalized_witness_sum (t : ℝ) (g : (Fin n → PairAtom) → ℝ) :
    weightedSum (fun _ : Fin n => witnessProbability t) g =
      weightedSum (fun _ : Fin n => witnessWeight t) g / witnessMass t ^ n := by
  unfold weightedSum witnessProbability
  rw [Finset.sum_div]
  apply Finset.sum_congr rfl
  intro z _
  rw [Finset.prod_div_distrib]
  simp only [Finset.prod_const, Finset.card_univ, Fintype.card_fin]
  ring

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

/-- Integrate the finite witness inequality across an arbitrary seed space. -/
theorem TreeMixture.adaptive_witness_bound (G : TreeMixture μ n) {t : ℝ} (ht : 1 < t) :
    weightedSum (fun _ : Fin n => witnessWeight t) (fun z => G.payoff (witnessInput t z)) ≤
      G.mean * threeDenominator t ^ n := by
  classical
  let factor (z : Fin n → PairAtom) : ℝ := ∏ i, witnessWeight t (z i)
  let unit (z : Fin n → PairAtom) (ω : Ω) := (G.tree ω).unitPayoff (witnessInput t z)
  have hi (z : Fin n → PairAtom) :
      Integrable (fun ω => factor z * (G.capital ω * unit z ω)) μ :=
    (G.payoff_integrable (witnessInput t z) ht.le
      (fun c => witnessValue_box ht (z c.1) c.2)).const_mul _
  have hsum : Integrable (fun ω => ∑ z, factor z * (G.capital ω * unit z ω)) μ :=
    integrable_finset_sum Finset.univ (fun z _ => hi z)
  have hpoint : ∀ᵐ ω ∂μ,
      (∑ z, factor z * (G.capital ω * unit z ω)) ≤ threeDenominator t ^ n * G.capital ω := by
    filter_upwards [G.capital_nonnegative] with ω hc
    calc
      _ = G.capital ω * weightedSum (fun _ : Fin n => witnessWeight t)
          (fun z => unit z ω) :=
        weightedSum_const_mul _ _ _
      _ ≤ G.capital ω * threeDenominator t ^ n :=
        mul_le_mul_of_nonneg_left ((G.tree ω).root_witness_certificate ht) hc
      _ = _ := mul_comm _ _
  have h := integral_mono_ae hsum (G.capital_integrable.const_mul _) hpoint
  rw [integral_finset_sum Finset.univ (fun z _ => hi z), integral_const_mul] at h
  simp_rw [integral_const_mul] at h
  simpa only [weightedSum, TreeMixture.payoff, TreeMixture.mean, factor, unit, mul_comm] using h

theorem TreeMixture.adaptive_probability_bound (G : TreeMixture μ n) {t : ℝ} (ht : 1 < t) :
    weightedSum (fun _ : Fin n => witnessProbability t) (fun z => G.payoff (witnessInput t z)) ≤
      G.mean * (threeDenominator t / witnessMass t) ^ n := by
  rw [normalized_witness_sum, div_pow, ← mul_div_assoc]
  exact div_le_div_of_nonneg_right (G.adaptive_witness_bound ht) (pow_nonneg (witnessMass_pos ht).le _)

theorem product_ratio_tendsto (lam : Fin n → ℝ) :
    Tendsto (fun t => ∏ i, threeRatio (lam i) t) atTop (𝓝 (productCapital lam)) := by
  unfold productCapital
  exact tendsto_finset_prod _ (fun i _ => three_ratio_limit (lam i))

theorem TreeMixture.adaptive_product_capital_lower (G : TreeMixture μ n) (lam : Fin n → ℝ)
    (hdom : ∀ x : PairInput n, (∀ c, 0 ≤ x c) → productMerger lam x ≤ G.payoff x) :
    productCapital lam ≤ G.mean := by
  apply le_of_tendsto (product_ratio_tendsto lam)
  filter_upwards [eventually_gt_atTop (1 : ℝ)] with t ht
  have hweighted := weightedSum_mono
    (fun (_ : Fin n) a => witnessWeight_nonnegative ht a)
    (fun z => hdom (witnessInput t z) (fun c => (witnessValue_box ht (z c.1) c.2).1))
  rw [weighted_product_merger lam ht] at hweighted
  have hnum := hweighted.trans (G.adaptive_witness_bound ht)
  simp only [threeRatio, Finset.prod_div_distrib, Finset.prod_const, Finset.card_univ, Fintype.card_fin]
  exact (div_le_iff₀ (pow_pos (threeDenominator_pos ht) _)).mpr (by simpa [mul_comm] using hnum)

end IndependentMerging
