import TreeAssembly
import Mathlib.MeasureTheory.Integral.Pi

open Finset MeasureTheory
open scoped BigOperators

namespace IndependentMerging

variable {n : ℕ}

noncomputable def allFairOrderLaw (n : ℕ) : Measure (Fin n → Bool) :=
  Measure.pi fun _ => fairOrderLaw

theorem allFairOrderLaw_probability (n : ℕ) : IsProbabilityMeasure (allFairOrderLaw n) := by
  letI : IsProbabilityMeasure fairOrderLaw := fairOrderLaw_probability
  unfold allFairOrderLaw
  infer_instance

theorem allFairOrderLaw_integral_product (f : Fin n → Bool → ℝ) :
    (∫ ord, (∏ i, f i (ord i)) ∂allFairOrderLaw n) =
      ∏ i, ∫ b, f i b ∂fairOrderLaw := by
  letI : MeasureSpace Bool :=
    { toMeasurableSpace := inferInstance
      volume := fairOrderLaw }
  letI : IsProbabilityMeasure (volume : Measure Bool) := fairOrderLaw_probability
  have h := MeasureTheory.integral_fintype_prod_eq_prod (E := fun _ : Fin n => Bool) (Fin n) f
  simpa only [volume_pi, allFairOrderLaw] using h

noncomputable def hedgeReadTree (lam : Fin n → ℝ)
    (hl : ∀ i, 0 ≤ lam i) (hu : ∀ i, lam i ≤ 1) (ord : Fin n → Bool) :
    ReadTree n Finset.univ :=
  (pairSequence Finset.univ (fun i =>
    orderedPairTree i (ord i) ⟨2 * hedgeShare (lam i), hedge_first_bounds (hl i) (hu i)⟩
      (fun z => ⟨hedgeStake (lam i) z, hedge_second_bounds (hl i) (hu i) z⟩))).castDomain
      univ_pairsDomain

theorem hedgeReadTree_payoff (lam : Fin n → ℝ)
    (hl : ∀ i, 0 ≤ lam i) (hu : ∀ i, lam i ≤ 1) (ord : Fin n → Bool) (x : PairInput n) :
    (hedgeReadTree lam hl hu ord).unitPayoff x = ∏ i,
      orderedStrategy (ord i) (2 * hedgeShare (lam i)) (hedgeStake (lam i))
        (x (i, false)) (x (i, true)) := by
  unfold hedgeReadTree
  rw [ReadTree.castDomain_payoff, pairSequence_payoff]
  apply Finset.prod_congr rfl
  intro i _
  exact orderedPairTree_payoff i _ _ _ x

theorem productCapital_nonnegative (lam : Fin n → ℝ) (hl : ∀ i, 0 ≤ lam i) :
    0 ≤ productCapital lam := by
  unfold productCapital
  exact Finset.prod_nonneg fun i _ => by unfold wholeCapital; linarith [hl i]

noncomputable def productHedge (lam : Fin n → ℝ)
    (hl : ∀ i, 0 ≤ lam i) (hu : ∀ i, lam i ≤ 1) : TreeMixture (allFairOrderLaw n) n := by
  letI : IsProbabilityMeasure (allFairOrderLaw n) := allFairOrderLaw_probability n
  refine {
    capital := fun _ => productCapital lam
    tree := hedgeReadTree lam hl hu
    capital_integrable := integrable_const _
    capital_nonnegative := Filter.Eventually.of_forall fun _ => productCapital_nonnegative lam hl
    payoff_measurable := fun x => (measurable_of_finite
      (fun ord => (hedgeReadTree lam hl hu ord).unitPayoff x)).aestronglyMeasurable
  }

theorem productHedge_mean (lam : Fin n → ℝ)
    (hl : ∀ i, 0 ≤ lam i) (hu : ∀ i, lam i ≤ 1) :
    (productHedge lam hl hu).mean = productCapital lam := by
  letI : IsProbabilityMeasure (allFairOrderLaw n) := allFairOrderLaw_probability n
  change (∫ _ : Fin n → Bool, productCapital lam ∂allFairOrderLaw n) = _
  simp

theorem productHedge_payoff (lam : Fin n → ℝ)
    (hl : ∀ i, 0 ≤ lam i) (hu : ∀ i, lam i ≤ 1) (x : PairInput n) (hx : ∀ c, 0 ≤ x c) :
    (productHedge lam hl hu).payoff x =
      productCapital lam * ∏ i, hedgeValue (lam i) (x (i, false)) (x (i, true)) := by
  change (∫ ord, productCapital lam * (hedgeReadTree lam hl hu ord).unitPayoff x
    ∂allFairOrderLaw n) = _
  simp_rw [hedgeReadTree_payoff]
  rw [integral_const_mul, allFairOrderLaw_integral_product (fun i b =>
    orderedStrategy b (2 * hedgeShare (lam i)) (hedgeStake (lam i)) (x (i, false)) (x (i, true)))]
  congr 1
  apply Finset.prod_congr rfl
  intro i _
  rw [fairOrderLaw_integral]
  exact hedge_is_fair_order_average (hl i) (hu i) (hx (i, false)) (hx (i, true))

theorem productHedge_dominates (lam : Fin n → ℝ)
    (hl : ∀ i, 0 ≤ lam i) (hu : ∀ i, lam i ≤ 1) (x : PairInput n) (hx : ∀ c, 0 ≤ x c) :
    productMerger lam x ≤ (productHedge lam hl hu).payoff x := by
  rw [productHedge_payoff lam hl hu x hx]
  unfold productMerger productCapital
  rw [← Finset.prod_mul_distrib]
  apply Finset.prod_le_prod
  · intro i _
    exact mergerLambda_nonnegative (hl i) (hu i) (hx (i, false)) (hx (i, true))
  · intro i _
    have hcost : 0 ≤ wholeCapital (lam i) := by unfold wholeCapital; linarith [hl i]
    have hd := mul_le_mul_of_nonneg_left
      (hedge_dominates_scaled (hl i) (hx (i, false)) (hx (i, true))) hcost
    rwa [← mul_assoc, wholeCapital_mul_efficiency (hl i), one_mul] at hd

theorem adaptive_product_cost_attained (lam : Fin n → ℝ)
    (hl : ∀ i, 0 ≤ lam i) (hu : ∀ i, lam i ≤ 1) :
    ∃ H : TreeMixture (allFairOrderLaw n) n, H.mean = productCapital lam ∧
      ∀ x : PairInput n, (∀ c, 0 ≤ x c) → productMerger lam x ≤ H.payoff x :=
  ⟨productHedge lam hl hu, productHedge_mean lam hl hu, productHedge_dominates lam hl hu⟩

theorem common_parameter_one_cost (n : ℕ) :
    productCapital (fun _ : Fin n => (1 : ℝ)) = (3 / 2) ^ n := by
  unfold productCapital
  rw [Finset.prod_const, Finset.card_univ, Fintype.card_fin]
  congr 1
  unfold wholeCapital
  norm_num

theorem common_parameter_one_efficiency (n : ℕ) :
    (productCapital (fun _ : Fin n => (1 : ℝ)))⁻¹ = (2 / 3) ^ n := by
  rw [common_parameter_one_cost, ← inv_pow]
  norm_num

end IndependentMerging
