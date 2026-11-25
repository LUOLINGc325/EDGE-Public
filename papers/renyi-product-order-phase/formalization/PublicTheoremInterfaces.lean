import DeficitRegimeRates
import BISOPhaseParity

/-! Public channel statements and the manuscript's prior parametrization. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem prior_weight_as_exponential {a : ℝ} (ha : 0 < a) :
    priorWeight a = Real.exp (-Real.log (1 + a)) := by
  unfold priorWeight
  rw [Real.exp_neg, Real.exp_log (by linarith)]

theorem kl_mean_is_relative_entropy (p q : FiniteMass κ) :
    klMean p q = p.expect (fun i => Real.log (p i / q i)) := by
  unfold klMean tiltedMean
  rw [tilted_mass_at_zero, ← neg_one_mul, ← FiniteMass.expect_scale_function]
  congr 1
  funext i
  have h : (q i / p i)⁻¹ = p i / q i := inv_div _ _
  rw [neg_one_mul, logLikelihood, ← Real.log_inv, h]

theorem prior_weight_tendsto {α : Type*} {l : Filter α} {a : α → ℝ} {aStar : ℝ}
    (hA : 0 < aStar) (h : Tendsto a l (𝓝 aStar)) :
    Tendsto (fun n => priorWeight (a n)) l (𝓝 (priorWeight aStar)) := by
  have hc : ContinuousAt (fun x : ℝ => 1 + x) aStar := by fun_prop
  exact ((hc.inv₀ (by linarith : (1 : ℝ) + aStar ≠ 0)).tendsto.comp h)

theorem biso_critical_window_limit (w : BinarySymmetricChannel κ) (ζ : ℝ) :
    let p := w.channel false
    let q := w.channel true
    ∃ tStar > 0, (∀ t > 0, criticalGaussianCost ζ tStar ≤ criticalGaussianCost ζ t) ∧
      Tendsto (fun n : ℕ => criticalOrder p q ζ (n + 1) * criticalScale p q (n + 1) *
        channelProductDeficit w (n + 1) (criticalOrder p q ζ (n + 1))) atTop
          (𝓝 (criticalGaussianCost ζ tStar)) ∧
      ∀ a : ℕ → ℝ, (∀ᶠ n in atTop, 0 < a n ∧
        IsLeast (productDeficitValues p q (n + 1) (criticalOrder p q ζ (n + 1)))
          (productScalarDeficit p q (n + 1) (criticalOrder p q ζ (n + 1)) (a n))) →
        Tendsto (fun n => Real.log (1 + a n) / criticalScale p q (n + 1)) atTop (𝓝 tStar) := by
  let p := w.channel false
  let q := w.channel true
  have hp := w.positive false
  have hq := w.positive true
  let B (n : ℕ) := criticalOrder p q ζ (n + 1)
  obtain ⟨t, ht, hm, hL, hP⟩ := critical_exact_coefficient_limit p q hp hq w.informative ζ
  refine ⟨t, ht, hm, ?_, hP⟩
  have h := channel_product_deficit_eventually_eq w B
    ((critical_order_tendsto p q hp hq w.informative ζ).eventually (eventually_ge_atTop 1))
  apply hL.congr'
  filter_upwards [h] with n hn
  change channelProductDeficit w (n + 1) (B n) = sInf (productDeficitValues p q (n + 1) (B n)) at hn
  rw [hn]

theorem biso_maximum_likelihood_limit (w : BinarySymmetricChannel κ) {M : ℝ}
    (hM₀ : 0 < M) (hM : ∀ i, -M ≤ logLikelihood (w.channel false) (w.channel true) i)
    (hm : 0 < endpointAtomMass (w.channel false) (w.channel true) M)
    (hm' : endpointAtomMass (w.channel false) (w.channel true) M < 1) :
    let ell := endpointLogRate (w.channel false) (w.channel true) M
    let T (n : ℕ) := endpointBlockTime ell (n + 1)
    let V (n : ℕ) := orderAtRate M (n + 1) * channelProductDeficit w (n + 1) (orderAtRate M (n + 1))
    Tendsto (fun n => Real.log ((n + 1 : ℕ) : ℝ) * (V n - Real.exp (T n))) atTop (𝓝 0) ∧
    Tendsto (fun n => V n / ((((n + 1 : ℕ) : ℝ) * ell) / Real.log ((n + 1 : ℕ) : ℝ)))
      atTop (𝓝 1) := by
  let p := w.channel false
  let q := w.channel true
  let B (n : ℕ) := orderAtRate M (n + 1)
  have hB (n : ℕ) : 1 ≤ B n := by
    unfold B orderAtRate
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr (mul_nonneg (Nat.cast_nonneg _) hM₀.le)
  have h := endpoint_exact_coefficient_limits p q (w.positive false) (w.positive true)
    w.informative hM₀ hM hm hm'
  have hb (n : ℕ) : channelProductDeficit w (n + 1) (B n) =
      sInf (productDeficitValues p q (n + 1) (B n)) :=
    product_contraction_deficit w (Nat.succ_pos n) (B n) (hB n)
  refine ⟨h.1.congr (fun n => ?_), h.2.congr (fun n => ?_)⟩
  · dsimp only
    rw [hb n]
  · dsimp only
    rw [hb n]

theorem exact_prior_minimizers_scaled (p q : FiniteMass κ) (I : ℝ) (B : ℕ → ℝ)
    (hb : ∀ n, 0 < B n) (a : ℕ → ℝ)
    (ha : ∀ᶠ n in atTop, 0 < a n ∧ IsLeast (productDeficitValues p q (n + 1) (B n))
      (productScalarDeficit p q (n + 1) (B n) (a n))) :
    ∀ᶠ n in atTop, ∀ x > 0, scaledBlockObjective p q I B n (a n) ≤
      scaledBlockObjective p q I B n x + (fun _ : ℕ => (0 : ℝ)) n := by
  filter_upwards [ha] with n hn
  intro x hx
  rw [add_zero]
  unfold scaledBlockObjective
  exact mul_le_mul_of_nonneg_left (hn.2.2 ⟨x, hx, rfl⟩)
    (mul_nonneg (hb n).le (positive_block_scale I n).le)

theorem biso_fixed_all_nonarithmetic_prior_limits (w : BinarySymmetricChannel κ)
    (hNon : ¬ ArithmeticSupport (logLikelihood (w.channel false) (w.channel true))) {b : ℝ} (hb : 1 ≤ b) :
    let p := w.channel false
    let q := w.channel true
    ∃ aStar > 0, (1 + aStar) * Real.log (1 + aStar) = 2 * aStar ∧
      (∀ x > 0, (1 + x) * Real.log (1 + x) = 2 * x → x = aStar) ∧
      ∀ a : ℕ → ℝ, (∀ᶠ n in atTop, 0 < a n ∧ IsLeast (productDeficitValues p q (n + 1) b)
        (productScalarDeficit p q (n + 1) b (a n))) →
        Tendsto (fun n => priorWeight (a n)) atTop (𝓝 (priorWeight aStar)) := by
  let p := w.channel false
  let q := w.channel true
  let θ : ℝ := 1 / 2
  obtain ⟨aStar, haStar, hEq, hRoot, hLimit⟩ :=
    nonarithmetic_fixed_optimized_limit p q (w.positive false) (w.positive true) w.informative
      hNon hb (by norm_num : 0 < θ) (by norm_num : θ < 1) w.halfway_tilt_centered
  refine ⟨aStar, haStar, by norm_num [θ] at hEq; linarith only [hEq], ?_, ?_⟩
  · intro x hx he
    apply hRoot x hx
    unfold θ
    linarith only [he]
  · intro a ha
    have h := hLimit a (fun _ => 0) (ha.mono (fun _ hn => hn.1)) tendsto_const_nhds
      (exact_prior_minimizers_scaled p q (-logCumulant p q θ) (fun _ => b)
        (fun _ => zero_lt_one.trans_le hb) a ha)
    exact prior_weight_tendsto haStar h.1

theorem biso_growing_all_nonarithmetic_prior_limits (w : BinarySymmetricChannel κ)
    (hNon : ¬ ArithmeticSupport (logLikelihood (w.channel false) (w.channel true)))
    {r : ℝ} (hr : 0 < r) (hD : r < klMean (w.channel false) (w.channel true)) :
    let p := w.channel false
    let q := w.channel true
    let B (n : ℕ) := orderAtRate r (n + 1)
    ∃ θ ∈ Ioo (0 : ℝ) (1 / 2), tiltedMean p q θ = -r ∧
      ∃ aStar > 0, -θ * Real.log (priorWeight aStar) = 1 - priorWeight aStar ∧
        ∀ a : ℕ → ℝ, (∀ᶠ n in atTop, 0 < a n ∧ IsLeast (productDeficitValues p q (n + 1) (B n))
          (productScalarDeficit p q (n + 1) (B n) (a n))) →
          Tendsto (fun n => priorWeight (a n)) atTop (𝓝 (priorWeight aStar)) := by
  let p := w.channel false
  let q := w.channel true
  let B (n : ℕ) := orderAtRate r (n + 1)
  obtain ⟨θ, ⟨hθ, hm⟩, _⟩ := w.unique_tilt_saddle hr hD
  obtain ⟨aStar, haStar, hEq, _, hLimit⟩ := nonarithmetic_growing_optimized_limit p q
    (w.positive false) (w.positive true) w.informative hNon hr hθ.1 (hθ.2.trans (by norm_num)) hm
  refine ⟨θ, hθ, hm, aStar, haStar, (prior_weight_stationarity haStar).1 hEq, ?_⟩
  intro a ha
  have h := hLimit a (fun _ => 0) (ha.mono (fun _ hn => hn.1)) tendsto_const_nhds
    (exact_prior_minimizers_scaled p q (-(logCumulant p q θ + θ * r)) B
      (fun _ => Real.exp_pos _) a ha)
  exact prior_weight_tendsto haStar h.1

end RenyiProductOrderPhase
