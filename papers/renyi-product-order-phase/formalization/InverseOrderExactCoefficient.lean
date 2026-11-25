import InverseOrderPriorLimit
import PriorAttainment

/-! Exact minima and all optimizing priors in the inverse Rényi interior. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem exponential_prior_cost_least (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {n : ℕ} (hn : 0 < n) (r : ℝ) :
    ∃ U > 0, (∀ t > 0, exponentialPriorCost p q r n U ≤ exponentialPriorCost p q r n t) ∧
      exponentialPriorCost p q r n U =
        orderAtRate r n * sInf (productDeficitValues p q n (orderAtRate r n)) := by
  have hb : 0 < orderAtRate r n := Real.exp_pos _
  obtain ⟨a, ha, hA⟩ := product_deficit_attained p q hp hq hne hn _ hb
  let U := Real.log (1 + a)
  have hInv := time_from_positive_prior ha
  refine ⟨U, hInv.1, ?_, ?_⟩
  · intro t ht
    rw [exponential_prior_exact_scale p q r n hInv.1, exponential_prior_exact_scale p q r n ht, hInv.2]
    exact mul_le_mul_of_nonneg_left (hA.2 ⟨_, prior_from_time_pos ht, rfl⟩) hb.le
  · rw [exponential_prior_exact_scale p q r n hInv.1, hInv.2, hA.csInf_eq]

theorem inverse_order_exact_coefficient_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {r M : ℝ} (hD : klMean p q < r) (hM : r < M)
    (hSupport : ∀ i, -M ≤ logLikelihood p q i)
    (hAtom : ∃ i, logLikelihood p q i = -M)
    (hOther : ∃ i, -M < logLikelihood p q i) :
    ∃ β > 0, renyiDivergence β p q = r ∧
      (∀ b > 0, renyiDivergence b p q = r → b = β) ∧
      let u := inverseOrderSlope p q r β
      u ∈ Ioo 0 (M - r) ∧
      Tendsto (fun n : ℕ => orderAtRate r (n + 1) *
        sInf (productDeficitValues p q (n + 1) (orderAtRate r (n + 1)))) atTop (𝓝 β) ∧
      ∀ U e : ℕ → ℝ, (∀ᶠ n in atTop, 0 < U n) → Tendsto e atTop (𝓝 0) →
        (∀ᶠ n in atTop, ∀ t > 0, exponentialPriorCost p q r (n + 1) (U n) ≤
          exponentialPriorCost p q r (n + 1) t + e n) →
        Tendsto (fun n => U n / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 u) := by
  have hr : 0 < r := (kl_mean_pos p q hp hq hne).trans hD
  obtain ⟨β, hβ, hR, hu, hUnique⟩ := inverse_order_root_and_tangent p q hp hq hne hD hM hAtom
  let u := inverseOrderSlope p q r β
  have hRoot := (inverse_renyi_cumulant_iff p q hp hq hβ.ne' r).2 hR
  have huM : u < M - r := by
    unfold u inverseOrderSlope
    linarith only [tilted_mean_strictly_above_minimum p q hp hSupport hOther (-β)]
  refine ⟨β, hβ, hR, hUnique, ⟨hu, huM⟩, ?_, ?_⟩
  · classical
    choose U hU hOpt hEq using fun n : ℕ => exponential_prior_cost_least p q hp hq hne (Nat.succ_pos n) r
    have hA := inverse_order_approximate_values p q hp hq hne hr hD hβ hRoot hu
      U (fun _ => 0) (Filter.Eventually.of_forall hU) tendsto_const_nhds
      (Filter.Eventually.of_forall fun n t ht => by simpa only [add_zero] using hOpt n t ht)
    exact hA.1.congr hEq
  · intro U e hU he hOpt
    obtain ⟨hV, d, hd, hD'⟩ := inverse_order_approximate_values p q hp hq hne hr hD hβ hRoot hu
      U e hU he hOpt
    have hUT : Tendsto U atTop atTop := by
      apply tendsto_atTop.2
      intro A
      filter_upwards [hD', (successor_real_tendsto.const_mul_atTop hd).eventually (eventually_ge_atTop A)]
        with n hn hA
      exact hA.trans hn
    exact inverse_order_normalized_time_limit p q hp hq hr hβ hRoot U hUT hV

end RenyiProductOrderPhase
