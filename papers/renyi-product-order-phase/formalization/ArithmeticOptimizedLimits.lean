import ArithmeticPhaseOptimization

/-! The attained arithmetic contraction deficits at fixed and exponentially growing orders. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem arithmetic_fixed_optimized_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (L : MaximalLattice (logLikelihood p q)) {b θ : ℝ}
    (hb : 1 ≤ b) (hθ : 0 < θ) (hθ' : θ < 1) (hm : tiltedMean p q θ = 0) :
    let H := periodicKernelProfile L.span (fun s => Real.exp (-(θ * s)) * kernelGap b (Real.exp s))
    let G (n : ℕ) := movingPhaseCost θ (gaussianHeight (tiltedVariance p q θ)) H
      (L.span * L.phase (n + 1))
    Tendsto (fun n => (b * blockScale (-logCumulant p q θ) (n + 1)) *
      sInf (productDeficitValues p q (n + 1) b) - sInf (positivePriorValues (G n))) atTop (𝓝 0) ∧
      MovingPhaseOptimizerLimits (scaledBlockObjective p q (-logCumulant p q θ) (fun _ => b))
        θ (gaussianHeight (tiltedVariance p q θ)) H (fun n => L.span * L.phase (n + 1)) ∧
      ∃ c > 0, ∃ C > 0, ∀ n, c ≤ sInf (positivePriorValues (G n)) ∧ sInf (positivePriorValues (G n)) ≤ C := by
  let R := tiltedMass p q θ
  let Y := logLikelihood p q
  let v := tiltedVariance p q θ
  let I := -logCumulant p q θ
  let c := min θ (1 - θ)
  let A := max 1 b
  have hv : 0 < v := tilted_variance_pos p q hp hq hne θ
  have hR : ∀ i, 0 < R i := tilted_mass_pos p q hp θ
  have hVar : R.expect (fun i => Y i ^ 2) = v := by
    have h := tilted_variance_second_moment p q θ
    rw [hm, zero_pow (by norm_num : (2 : ℕ) ≠ 0), sub_zero] at h
    exact h.symm
  have hI : 0 < I := by
    have h := positive_tilt_rate p q hp hq hne hθ
    rwa [hm, mul_zero, zero_sub] at h
  apply arithmetic_optimized_limit_of_phase p q hp hq hne L hv hθ hθ'
    (lt_min hθ (sub_pos.mpr hθ')) (zero_le_one.trans (le_max_left 1 b))
    (fun _ => b) (fun _ => zero_lt_one.trans_le hb) (kernelGap b)
  · intro s
    have h := fixed_tilted_kernel_envelope (a := 1) (A := 1) zero_le_one le_rfl hb (θ := θ) s
    have h₀ : 0 ≤ Real.exp (-(θ * s)) * kernelGap b (Real.exp s) := by
      simpa only [tiltedKernel, one_mul] using h.1
    rw [abs_of_nonneg h₀]
    simpa only [c, A, exponentialEnvelope, tiltedKernel, one_mul, mul_one, neg_mul] using h.2
  · unfold kernelGap
    have h₁ : Continuous (fun x : ℝ => (1 : ℝ) + Real.exp x) := by fun_prop
    have h₂ : Continuous (fun x : ℝ => (1 + Real.exp x) ^ (-b)) := by
      apply continuous_iff_continuousAt.2
      intro x
      exact (Real.continuousAt_rpow_const _ _ (Or.inl (by positivity))).comp h₁.continuousAt
    have h₃ : Continuous (fun x : ℝ => Real.exp (-(θ * x))) := by fun_prop
    exact h₃.mul (continuous_const.sub h₂)
  · intro s
    exact mul_pos (Real.exp_pos _) ((div_pos (Real.exp_pos s) (by positivity)).trans_le
      (kernel_gap_bounds hb (Real.exp_nonneg s)).1)
  · intro C hC
    apply scaled_product_priors_confined p q R hp hq Y hI hθ hθ' (mul_pos (by norm_num : (0 : ℝ) < 2) L.span_pos) hC
      (fun _ => b) (fun _ => hb) (fun _ => kernelGap b) (fun _ z hz => fixed_gap_half_min hb hz)
    · exact fun n a => fixed_scaled_product_missing p q hp hq (n + 1) b a θ
    · intro D E
      obtain ⟨P, hP, N, hN⟩ := L.logarithmic_interval_lower R hR hm
        (show 0 < R.expect (fun i => Y i ^ 2) by rwa [hVar]) D E
      exact ⟨P, hP, eventually_atTop.2 ⟨N, hN⟩⟩
  · intro l u hl _ ε hε
    exact arithmetic_fixed_product_deficit_limit p q hp hq hne L hb hθ hθ' hm hl hε

theorem arithmetic_growing_optimized_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (L : MaximalLattice (logLikelihood p q)) {r θ : ℝ}
    (hr : 0 < r) (hθ : 0 < θ) (hθ' : θ < 1) (hm : tiltedMean p q θ = -r) :
    let B (n : ℕ) := Real.exp (((n + 1 : ℕ) : ℝ) * r)
    let L' := L.shift r
    let H := periodicKernelProfile L'.span (fun s => Real.exp (-(θ * s)) * growingLimitGap (Real.exp s))
    let G (n : ℕ) := movingPhaseCost θ (gaussianHeight (tiltedVariance p q θ)) H
      (L'.span * L'.phase (n + 1))
    Tendsto (fun n => (B n * blockScale (-(logCumulant p q θ + θ * r)) (n + 1)) *
      sInf (productDeficitValues p q (n + 1) (B n)) - sInf (positivePriorValues (G n))) atTop (𝓝 0) ∧
      MovingPhaseOptimizerLimits (scaledBlockObjective p q (-(logCumulant p q θ + θ * r)) B)
        θ (gaussianHeight (tiltedVariance p q θ)) H (fun n => L'.span * L'.phase (n + 1)) ∧
      ∃ c > 0, ∃ C > 0, ∀ n, c ≤ sInf (positivePriorValues (G n)) ∧ sInf (positivePriorValues (G n)) ≤ C := by
  let R := tiltedMass p q θ
  let Y (i : κ) := logLikelihood p q i + r
  let L' := L.shift r
  let v := tiltedVariance p q θ
  let I := -(logCumulant p q θ + θ * r)
  let B (n : ℕ) := Real.exp (((n + 1 : ℕ) : ℝ) * r)
  have hB (n : ℕ) : 1 ≤ B n := by
    unfold B
    rw [← Real.exp_zero, Real.exp_le_exp]
    positivity
  have hR : ∀ i, 0 < R i := tilted_mass_pos p q hp θ
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
  apply arithmetic_optimized_limit_of_phase p q hp hq hne L' hv hθ hθ'
    (lt_min hθ (sub_pos.mpr hθ')) (zero_le_one : (0 : ℝ) ≤ 1)
    B (fun n => zero_lt_one.trans_le (hB n)) growingLimitGap
  · intro s
    have h := growing_limit_kernel_envelope (a := 1) (A := 1) zero_le_one le_rfl (θ := θ) s
    have h₀ : 0 ≤ Real.exp (-(θ * s)) * growingLimitGap (Real.exp s) := by
      simpa only [growingLimitKernel, one_mul] using h.1
    rw [abs_of_nonneg h₀]
    simpa only [exponentialEnvelope, growingLimitKernel, one_mul, max_self, neg_mul] using h.2
  · unfold growingLimitGap
    fun_prop
  · intro s
    unfold growingLimitGap
    apply mul_pos (Real.exp_pos _)
    exact sub_pos.mpr (by rw [← Real.exp_zero, Real.exp_lt_exp]; exact neg_lt_zero.mpr (Real.exp_pos s))
  · intro C hC
    apply scaled_product_priors_confined p q R hp hq Y hI hθ hθ' (mul_pos (by norm_num : (0 : ℝ) < 2) L'.span_pos) hC
      B hB (fun n => normalizedGap (B n)) (fun n z hz => normalized_gap_half_min (hB n) hz)
    · exact fun n a => growing_scaled_product_missing p q hp hq (n + 1) a θ r
    · intro D E
      obtain ⟨P, hP, N, hN⟩ := L'.logarithmic_interval_lower R hR hM
        (show 0 < R.expect (fun i => Y i ^ 2) by rwa [hV]) D E
      exact ⟨P, hP, eventually_atTop.2 ⟨N, hN⟩⟩
  · intro l u hl _ ε hε
    exact arithmetic_growing_product_deficit_limit p q hp hq hne L hr hθ hθ' hm hl hε

end RenyiProductOrderPhase
