import GlobalPriorLimit
import NonarithmeticDeficitLimits

/-! Nonarithmetic fixed- and growing-order minima and every approximate optimizing prior. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

theorem positive_prior_cost_optimized_limit (V : ℕ → ℝ → ℝ) {θ c : ℝ}
    (hθ : 0 < θ) (hθ' : θ < 1) (hc : 0 < c)
    (hConfine : ∀ C ≥ (0 : ℝ), ∃ l > 0, ∃ u > 0, ∀ᶠ n in atTop, ∀ a, 0 < a →
      V n a ≤ C → a ∈ Icc l u)
    (hUniform : ∀ l u : ℝ, 0 < l → l ≤ u → ∀ ε > 0,
      ∀ᶠ n in atTop, ∀ a ∈ Icc l u, |V n a - c * priorCost θ a| < ε) :
    ∃ aStar > 0, θ * (1 + aStar) * Real.log (1 + aStar) = aStar ∧
      (∀ x > 0, θ * (1 + x) * Real.log (1 + x) = x → x = aStar) ∧
      ∀ a e : ℕ → ℝ, (∀ᶠ n in atTop, 0 < a n) → Tendsto e atTop (𝓝 0) →
        (∀ᶠ n in atTop, ∀ x > 0, V n (a n) ≤ V n x + e n) →
        Tendsto a atTop (𝓝 aStar) ∧ Tendsto (fun n => V n (a n)) atTop (𝓝 (c * priorCost θ aStar)) := by
  obtain ⟨aStar, hStar, hEq, hRoot, hStrict⟩ := prior_cost_unique_minimum hθ hθ'
  refine ⟨aStar, hStar, hEq, hRoot, ?_⟩
  intro a e ha he hOpt
  apply global_compact_prior_minimizers hStar (continuousOn_const.mul (prior_cost_continuousOn θ))
    (fun x hx hne => mul_lt_mul_of_pos_left (hStrict x hx hne) hc)
    hConfine hUniform a e ha he hOpt

variable {κ : Type*} [Fintype κ]

theorem nonarithmetic_fixed_optimized_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (hNon : ¬ ArithmeticSupport (logLikelihood p q))
    {b θ : ℝ} (hb : 1 ≤ b) (hθ : 0 < θ) (hθ' : θ < 1)
    (hm : tiltedMean p q θ = 0) :
    let V := scaledBlockObjective p q (-logCumulant p q θ) (fun _ => b)
    let c := fixedTiltConstant (tiltedVariance p q θ) b θ
    ∃ aStar > 0, θ * (1 + aStar) * Real.log (1 + aStar) = aStar ∧
      (∀ x > 0, θ * (1 + x) * Real.log (1 + x) = x → x = aStar) ∧
      ∀ a e : ℕ → ℝ, (∀ᶠ n in atTop, 0 < a n) → Tendsto e atTop (𝓝 0) →
        (∀ᶠ n in atTop, ∀ x > 0, V n (a n) ≤ V n x + e n) →
        Tendsto a atTop (𝓝 aStar) ∧ Tendsto (fun n => V n (a n)) atTop (𝓝 (c * priorCost θ aStar)) := by
  let R := tiltedMass p q θ
  let Y := logLikelihood p q
  let v := tiltedVariance p q θ
  let I := -logCumulant p q θ
  let c := fixedTiltConstant v b θ
  have hv : 0 < v := tilted_variance_pos p q hp hq hne θ
  have hR : ∀ i, 0 < R i := tilted_mass_pos p q hp θ
  have hVar : R.expect (fun i => Y i ^ 2) = v := by
    have h := tilted_variance_second_moment p q θ
    rw [hm, zero_pow (by norm_num : (2 : ℕ) ≠ 0), sub_zero] at h
    exact h.symm
  have hI : 0 < I := by
    have h := positive_tilt_rate p q hp hq hne hθ
    rwa [hm, mul_zero, zero_sub] at h
  have hb₀ : 0 < b := zero_lt_one.trans_le hb
  have hc : 0 < c := mul_pos (gaussian_height_pos hv) (div_pos
    (mul_pos (Real.Gamma_pos_of_pos (sub_pos.mpr hθ')) (Real.Gamma_pos_of_pos (add_pos hb₀ hθ)))
    (mul_pos hθ (Real.Gamma_pos_of_pos hb₀)))
  apply positive_prior_cost_optimized_limit _ hθ hθ' hc
  · intro C hC
    apply scaled_product_priors_confined p q R hp hq Y hI hθ hθ' zero_lt_one hC
      (fun _ => b) (fun _ => hb) (fun _ => kernelGap b) (fun _ z hz => fixed_gap_half_min hb hz)
    · exact fun n a => fixed_scaled_product_missing p q hp hq (n + 1) b a θ
    · intro D E
      obtain ⟨P, hP, N, hN⟩ := finite_nonarithmetic_central_window R hR Y hNon hm
        (show 0 < R.expect (fun i => Y i ^ 2) by rwa [hVar]) zero_lt_one D E
      exact ⟨P, hP, eventually_atTop.2 ⟨N, hN⟩⟩
  · intro l u hl hlu ε hε
    simpa only [scaledBlockObjective, priorCost, mul_div_assoc] using
      nonarithmetic_fixed_product_deficit_limit p q hp hq hne hNon hb hθ hθ' hm hl hlu hε

theorem nonarithmetic_growing_optimized_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (hNon : ¬ ArithmeticSupport (logLikelihood p q)) {r θ : ℝ}
    (hr : 0 < r) (hθ : 0 < θ) (hθ' : θ < 1) (hm : tiltedMean p q θ = -r) :
    let B (n : ℕ) := Real.exp (((n + 1 : ℕ) : ℝ) * r)
    let V := scaledBlockObjective p q (-(logCumulant p q θ + θ * r)) B
    let c := growingTiltConstant (tiltedVariance p q θ) θ
    ∃ aStar > 0, θ * (1 + aStar) * Real.log (1 + aStar) = aStar ∧
      (∀ x > 0, θ * (1 + x) * Real.log (1 + x) = x → x = aStar) ∧
      ∀ a e : ℕ → ℝ, (∀ᶠ n in atTop, 0 < a n) → Tendsto e atTop (𝓝 0) →
        (∀ᶠ n in atTop, ∀ x > 0, V n (a n) ≤ V n x + e n) →
        Tendsto a atTop (𝓝 aStar) ∧ Tendsto (fun n => V n (a n)) atTop (𝓝 (c * priorCost θ aStar)) := by
  let R := tiltedMass p q θ
  let Y (i : κ) := logLikelihood p q i + r
  let v := tiltedVariance p q θ
  let I := -(logCumulant p q θ + θ * r)
  let c := growingTiltConstant v θ
  let B (n : ℕ) := Real.exp (((n + 1 : ℕ) : ℝ) * r)
  have hB (n : ℕ) : 1 ≤ B n := by
    unfold B
    rw [← Real.exp_zero, Real.exp_le_exp]
    positivity
  have hR : ∀ i, 0 < R i := tilted_mass_pos p q hp θ
  have hA : ¬ ArithmeticSupport Y :=
    fun h => hNon ((arithmetic_support_shift_iff (logLikelihood p q) r).1 h)
  have hM : R.expect Y = 0 := by
    change (tiltedMass p q θ).expect (fun i => logLikelihood p q i + r) = 0
    rw [tilted_shifted_mean, hm, neg_add_cancel]
  have hV : R.expect (fun i => Y i ^ 2) = v :=
    tilted_shifted_second_moment p q θ r hm
  have hv : 0 < v := tilted_variance_pos p q hp hq hne θ
  have hI : 0 < I := by
    have h := positive_tilt_rate p q hp hq hne hθ
    rw [hm] at h
    unfold I
    linarith only [h]
  have hc : 0 < c := mul_pos (gaussian_height_pos hv)
    (div_pos (Real.Gamma_pos_of_pos (sub_pos.mpr hθ')) hθ)
  apply positive_prior_cost_optimized_limit _ hθ hθ' hc
  · intro C hC
    apply scaled_product_priors_confined p q R hp hq Y hI hθ hθ' zero_lt_one hC
      B hB (fun n => normalizedGap (B n)) (fun n z hz => normalized_gap_half_min (hB n) hz)
    · exact fun n a => growing_scaled_product_missing p q hp hq (n + 1) a θ r
    · intro D E
      obtain ⟨P, hP, N, hN⟩ := finite_nonarithmetic_central_window R hR Y hA hM
        (show 0 < R.expect (fun i => Y i ^ 2) by rwa [hV]) zero_lt_one D E
      exact ⟨P, hP, eventually_atTop.2 ⟨N, hN⟩⟩
  · intro l u hl hlu ε hε
    simpa only [scaledBlockObjective, priorCost, mul_div_assoc] using
      nonarithmetic_growing_product_deficit_limit p q hp hq hne hNon hr hθ hθ' hm hl hlu hε

end RenyiProductOrderPhase
