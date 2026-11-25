import CompactDeficitLimit
import NonarithmeticKernelLimits
import GrowingKernelReplacement
import LatticePhaseLaw

/-! Sharp nonarithmetic constants for the exact finite contraction deficit. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def fixedTiltConstant (v b θ : ℝ) : ℝ :=
  gaussianHeight v * (Real.Gamma (1 - θ) * Real.Gamma (b + θ) / (θ * Real.Gamma b))

noncomputable def growingTiltConstant (v θ : ℝ) : ℝ :=
  gaussianHeight v * (Real.Gamma (1 - θ) / θ)

theorem growing_order_tendsto {r : ℝ} (hr : 0 < r) :
    Tendsto (fun n : ℕ => Real.exp (((n + 1 : ℕ) : ℝ) * r)) atTop atTop := by
  have hSucc : Tendsto (fun n : ℕ => n + 1) atTop atTop := tendsto_atTop.2 fun m =>
    (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n))
  have hNat : Tendsto (fun n : ℕ => ((n + 1 : ℕ) : ℝ)) atTop atTop :=
    tendsto_natCast_atTop_atTop.comp hSucc
  simpa only [Function.comp_apply, mul_comm] using
    Real.tendsto_exp_atTop.comp (hNat.const_mul_atTop hr)

theorem nonarithmetic_fixed_product_deficit_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (hNon : ¬ ArithmeticSupport (logLikelihood p q))
    {b θ : ℝ} (hb : 1 ≤ b) (hθ : 0 < θ) (hθ' : θ < 1)
    (hm : tiltedMean p q θ = 0) {l u ε : ℝ} (hl : 0 < l) (hlu : l ≤ u) (hε : 0 < ε) :
    ∀ᶠ n : ℕ in atTop, ∀ a ∈ Icc l u,
      |b * blockScale (-logCumulant p q θ) (n + 1) * productScalarDeficit p q (n + 1) b a -
        fixedTiltConstant (tiltedVariance p q θ) b θ * a ^ θ / Real.log (1 + a)| < ε := by
  let R := tiltedMass p q θ
  let Y := logLikelihood p q
  let v := tiltedVariance p q θ
  let c := fixedTiltConstant v b θ
  have hR : ∀ i, 0 < R i := tilted_mass_pos p q hp θ
  have hv : 0 < v := tilted_variance_pos p q hp hq hne θ
  have hVar : R.expect (fun i => Y i ^ 2) = v := by
    have h := tilted_variance_second_moment p q θ
    rw [hm, zero_pow (by norm_num : (2 : ℕ) ≠ 0), sub_zero] at h
    exact h.symm
  have hI : 0 < -logCumulant p q θ := by
    have h := positive_tilt_rate p q hp hq hne hθ
    rwa [hm, mul_zero, zero_sub] at h
  have hb₀ : 0 < b := zero_lt_one.trans_le hb
  have hc : 0 ≤ c := by
    unfold c fixedTiltConstant
    exact mul_nonneg (gaussian_height_pos hv).le (div_nonneg
      (mul_nonneg (Real.Gamma_pos_of_pos (sub_pos.mpr hθ')).le
        (Real.Gamma_pos_of_pos (add_pos hb₀ hθ)).le)
      (mul_pos hθ (Real.Gamma_pos_of_pos hb₀)).le)
  have hGB : ∀ᶠ n : ℕ in atTop, ∀ a ∈ Icc l u, c * a ^ θ ≤ c * u ^ θ :=
    Filter.Eventually.of_forall (fun _ a ha => mul_le_mul_of_nonneg_left
      (Real.rpow_le_rpow (hl.le.trans ha.1) ha.2 hθ.le) hc)
  have hMoment (η : ℝ) (hη : 0 < η) :
      ∀ᶠ n : ℕ in atTop, ∀ a ∈ Icc l u,
        |blockScale (-logCumulant p q θ) (n + 1) * productMissing p q (n + 1) b a - c * a ^ θ| < η := by
    obtain ⟨N, hN⟩ := nonarithmetic_fixed_tilted_limit R hR Y hNon hm
      (show 0 < R.expect (fun i => Y i ^ 2) by rwa [hVar]) hb hθ hθ' hl hη
    refine eventually_atTop.2 ⟨N, ?_⟩
    intro n hn a ha
    rw [fixed_scaled_product_missing p q hp hq (n + 1) b a θ]
    have h := hN n hn a ha
    rw [hVar] at h
    have he : gaussianHeight v * (a ^ θ * Real.Gamma (1 - θ) * Real.Gamma (b + θ) /
        (θ * Real.Gamma b)) = c * a ^ θ := by unfold c fixedTiltConstant; ring
    rwa [he] at h
  exact compact_uniform_deficit_from_local_moment p q hq hI hl (fun _ => b) (fun _ => hb₀)
    (fun _ a => c * a ^ θ) (mul_nonneg hc (Real.rpow_nonneg (hl.le.trans hlu) _))
    hGB hMoment hε

theorem nonarithmetic_growing_product_deficit_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (hNon : ¬ ArithmeticSupport (logLikelihood p q)) {r θ : ℝ}
    (hr : 0 < r) (hθ : 0 < θ) (hθ' : θ < 1)
    (hm : tiltedMean p q θ = -r) {l u ε : ℝ} (hl : 0 < l) (hlu : l ≤ u) (hε : 0 < ε) :
    ∀ᶠ n : ℕ in atTop, ∀ a ∈ Icc l u,
      |Real.exp (((n + 1 : ℕ) : ℝ) * r) * blockScale (-(logCumulant p q θ + θ * r)) (n + 1) *
        productScalarDeficit p q (n + 1) (Real.exp (((n + 1 : ℕ) : ℝ) * r)) a -
        growingTiltConstant (tiltedVariance p q θ) θ * a ^ θ / Real.log (1 + a)| < ε := by
  let R := tiltedMass p q θ
  let Y (i : κ) := logLikelihood p q i + r
  let v := tiltedVariance p q θ
  let c := growingTiltConstant v θ
  let I := -(logCumulant p q θ + θ * r)
  let b (n : ℕ) := Real.exp (((n + 1 : ℕ) : ℝ) * r)
  have hR : ∀ i, 0 < R i := tilted_mass_pos p q hp θ
  have hA : ¬ ArithmeticSupport Y :=
    fun h => hNon ((arithmetic_support_shift_iff (logLikelihood p q) r).1 h)
  have hM : R.expect Y = 0 := by
    change (tiltedMass p q θ).expect (fun i => logLikelihood p q i + r) = 0
    rw [tilted_shifted_mean, hm, neg_add_cancel]
  have hV : R.expect (fun i => Y i ^ 2) = v :=
    tilted_shifted_second_moment p q θ r hm
  have hv : 0 < v := tilted_variance_pos p q hp hq hne θ
  have hVP : 0 < R.expect (fun i => Y i ^ 2) := by rwa [hV]
  have hI : 0 < I := by
    have h := positive_tilt_rate p q hp hq hne hθ
    rw [hm] at h
    unfold I
    linarith only [h]
  have hc : 0 ≤ c := mul_nonneg (gaussian_height_pos hv).le
    (div_nonneg (Real.Gamma_pos_of_pos (sub_pos.mpr hθ')).le hθ.le)
  have hGB : ∀ᶠ n : ℕ in atTop, ∀ a ∈ Icc l u, c * a ^ θ ≤ c * u ^ θ :=
    Filter.Eventually.of_forall (fun _ a ha => mul_le_mul_of_nonneg_left
      (Real.rpow_le_rpow (hl.le.trans ha.1) ha.2 hθ.le) hc)
  obtain ⟨C, hC, NC, hConc⟩ := finite_closed_interval_concentration R hR Y hA hM hVP zero_lt_one
  have hConc' : ∀ᶠ n : ℕ in atTop, ∀ x : ℝ,
      Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent R Y (n + 1) (Ico x (x + 1)) ≤ C :=
    eventually_atTop.2 ⟨NC, fun n hn x =>
      (mul_le_mul_of_nonneg_left (finite_sum_event_mono R Y (n + 1) Ico_subset_Icc_self)
        (Real.sqrt_nonneg _)).trans (hConc n hn x)⟩
  have hMoment (η : ℝ) (hη : 0 < η) :
      ∀ᶠ n : ℕ in atTop, ∀ a ∈ Icc l u,
        |blockScale I (n + 1) * productMissing p q (n + 1) (b n) a - c * a ^ θ| < η := by
    have hHalf : 0 < η / 2 := div_pos hη (by norm_num)
    have hReplace := uniform_growing_kernel_replacement R Y b (growing_order_tendsto hr) (u := u)
      hθ hθ' hC.le hConc' hHalf
    obtain ⟨N, hN⟩ := nonarithmetic_growing_limit_kernel_test R hR Y hA hM hVP hθ hθ' hl hHalf
    filter_upwards [hReplace, eventually_ge_atTop N] with n hn hn'
    intro a ha
    have hLim := hN n hn' a ha
    rw [hV] at hLim
    have hEq : gaussianHeight v * (a ^ θ * Real.Gamma (1 - θ) / θ) = c * a ^ θ := by
      unfold c growingTiltConstant
      ring
    rw [hEq] at hLim
    have hE := hn a ⟨hl.le.trans ha.1, ha.2⟩
    rw [abs_sub_comm] at hE
    rw [growing_scaled_product_missing p q hp hq (n + 1) a θ r]
    exact (abs_sub_le _ _ _).trans_lt (by linarith only [hE, hLim])
  exact compact_uniform_deficit_from_local_moment p q hq hI hl b (fun _ => Real.exp_pos _)
    (fun _ a => c * a ^ θ) (mul_nonneg hc (Real.rpow_nonneg (hl.le.trans hlu) _))
    hGB hMoment hε

end RenyiProductOrderPhase
