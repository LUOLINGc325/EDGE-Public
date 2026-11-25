import CompactDeficitLimit
import LatticeKernelLimits
import NonarithmeticDeficitLimits

/-! Sharp maximal-lattice phase profiles for the exact finite contraction deficit. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def phaseMoment {Y : κ → ℝ} (L : MaximalLattice Y) (v : ℝ)
    (F : ℝ → ℝ → ℝ) (n : ℕ) (a : ℝ) : ℝ :=
  (L.span * gaussianHeight v) * ∑' j : ℤ, F a (L.phasePoint (n + 1) j)

theorem compact_uniform_deficit_from_phase_moment (p q : FiniteMass κ) (hq : ∀ i, 0 < q i)
    {Y : κ → ℝ} (L : MaximalLattice Y) {v I l u c A : ℝ}
    (hv : 0 < v) (hI : 0 < I) (hl : 0 < l) (hc : 0 < c) (hA : 0 ≤ A)
    (B : ℕ → ℝ) (hb : ∀ n, 0 < B n) (F : ℝ → ℝ → ℝ)
    (hEnv : ∀ a ∈ Icc l u, ∀ x, |F a x| ≤ A * exponentialEnvelope c x)
    (hMoment : ∀ ε > 0, ∀ᶠ n in atTop, ∀ a ∈ Icc l u,
      |blockScale I (n + 1) * productMissing p q (n + 1) (B n) a - phaseMoment L v F n a| < ε)
    {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop, ∀ a ∈ Icc l u,
      |B n * blockScale I (n + 1) * productScalarDeficit p q (n + 1) (B n) a -
        phaseMoment L v F n a / Real.log (1 + a)| < ε := by
  let H := L.span * gaussianHeight v
  have hH : 0 ≤ H := (mul_pos L.span_pos (gaussian_height_pos hv)).le
  let C := (A * Real.exp (c * L.span)) * (∑' j : ℤ, exponentialGridWeight (c * L.span) j)
  have hC : 0 ≤ C :=
    mul_nonneg (mul_nonneg hA (Real.exp_nonneg _)) (tsum_nonneg (fun _ => Real.exp_nonneg _))
  have hG : ∀ᶠ n in atTop, ∀ a ∈ Icc l u, phaseMoment L v F n a ≤ H * C := by
    refine Filter.Eventually.of_forall (fun n a ha => ?_)
    have h := (L.phase_test_series (F a) (n + 1) hc hA (hEnv a ha)).2
    exact mul_le_mul_of_nonneg_left ((le_abs_self _).trans h) hH
  exact compact_uniform_deficit_from_local_moment p q hq hI hl B hb (phaseMoment L v F)
    (mul_nonneg hH hC) hG hMoment hε

theorem arithmetic_fixed_product_deficit_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (L : MaximalLattice (logLikelihood p q))
    {b θ : ℝ} (hb : 1 ≤ b) (hθ : 0 < θ) (hθ' : θ < 1) (hm : tiltedMean p q θ = 0)
    {l u ε : ℝ} (hl : 0 < l) (hε : 0 < ε) :
    ∀ᶠ n : ℕ in atTop, ∀ a ∈ Icc l u,
      |b * blockScale (-logCumulant p q θ) (n + 1) * productScalarDeficit p q (n + 1) b a -
        phaseMoment L (tiltedVariance p q θ) (fun a => tiltedKernel b a θ) n a /
          Real.log (1 + a)| < ε := by
  let R := tiltedMass p q θ
  let Y := logLikelihood p q
  let v := tiltedVariance p q θ
  let F (a : ℝ) := tiltedKernel b a θ
  let c := min θ (1 - θ)
  let A := max 1 (b * u)
  have hc : 0 < c := lt_min hθ (sub_pos.mpr hθ')
  have hA : 0 ≤ A := zero_le_one.trans (le_max_left _ _)
  have hR : ∀ i, 0 < R i := tilted_mass_pos p q hp θ
  have hv : 0 < v := tilted_variance_pos p q hp hq hne θ
  have hVar : R.expect (fun i => Y i ^ 2) = v := by
    have h := tilted_variance_second_moment p q θ
    rw [hm, zero_pow (by norm_num : (2 : ℕ) ≠ 0), sub_zero] at h
    exact h.symm
  have hI : 0 < -logCumulant p q θ := by
    have h := positive_tilt_rate p q hp hq hne hθ
    rwa [hm, mul_zero, zero_sub] at h
  have hEnv (a : ℝ) (ha : a ∈ Icc l u) (s : ℝ) : |F a s| ≤ A * exponentialEnvelope c s := by
    have h := fixed_tilted_kernel_envelope (hl.le.trans ha.1) ha.2 hb (θ := θ) s
    simpa only [F, A, c, exponentialEnvelope, neg_mul, abs_of_nonneg h.1] using h.2
  have hMoment (η : ℝ) (hη : 0 < η) :
      ∀ᶠ n : ℕ in atTop, ∀ a ∈ Icc l u,
        |blockScale (-logCumulant p q θ) (n + 1) * productMissing p q (n + 1) b a -
          phaseMoment L v F n a| < η := by
    let G (a : Icc l u) := F (a : ℝ)
    obtain ⟨N, hN⟩ := L.uniform_lattice_test_limit R hR hm
      (show 0 < R.expect (fun i => Y i ^ 2) by rwa [hVar]) G hc hA hη
      (fun a x => hEnv a a.property x)
    refine eventually_atTop.2 ⟨N, ?_⟩
    intro n hn a ha
    rw [fixed_scaled_product_missing p q hp hq (n + 1) b a θ]
    have h := hN n hn ⟨a, ha⟩
    rw [hVar] at h
    exact h
  exact compact_uniform_deficit_from_phase_moment p q hq L hv hI hl hc hA
    (fun _ => b) (fun _ => zero_lt_one.trans_le hb) F hEnv hMoment hε

theorem arithmetic_growing_product_deficit_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (L : MaximalLattice (logLikelihood p q)) {r θ : ℝ}
    (hr : 0 < r) (hθ : 0 < θ) (hθ' : θ < 1) (hm : tiltedMean p q θ = -r)
    {l u ε : ℝ} (hl : 0 < l) (hε : 0 < ε) :
    let B (n : ℕ) := Real.exp (((n + 1 : ℕ) : ℝ) * r)
    ∀ᶠ n : ℕ in atTop, ∀ a ∈ Icc l u,
      |B n * blockScale (-(logCumulant p q θ + θ * r)) (n + 1) *
        productScalarDeficit p q (n + 1) (B n) a -
        phaseMoment (L.shift r) (tiltedVariance p q θ) (fun a => growingLimitKernel a θ) n a /
          Real.log (1 + a)| < ε := by
  let R := tiltedMass p q θ
  let Y (i : κ) := logLikelihood p q i + r
  let L' := L.shift r
  let I := -(logCumulant p q θ + θ * r)
  let B (n : ℕ) := Real.exp (((n + 1 : ℕ) : ℝ) * r)
  let v := tiltedVariance p q θ
  let F (a : ℝ) := growingLimitKernel a θ
  let c := min θ (1 - θ)
  let A := max 1 u
  have hc : 0 < c := lt_min hθ (sub_pos.mpr hθ')
  have hA : 0 ≤ A := zero_le_one.trans (le_max_left _ _)
  have hB (n : ℕ) : 1 ≤ B n := by
    unfold B
    rw [← Real.exp_zero, Real.exp_le_exp]
    positivity
  have hR : ∀ i, 0 < R i := tilted_mass_pos p q hp θ
  have hM : R.expect Y = 0 := by unfold R Y; rw [tilted_shifted_mean, hm, neg_add_cancel]
  have hV : R.expect (fun i => Y i ^ 2) = v := tilted_shifted_second_moment p q θ r hm
  have hv : 0 < v := tilted_variance_pos p q hp hq hne θ
  have hI : 0 < I := by
    have h := positive_tilt_rate p q hp hq hne hθ
    rw [hm] at h
    unfold I
    linarith only [h]
  have hEnv (a : ℝ) (ha : a ∈ Icc l u) (s : ℝ) : |F a s| ≤ A * exponentialEnvelope c s := by
    have h := growing_limit_kernel_envelope (hl.le.trans ha.1) ha.2 (θ := θ) s
    simpa only [F, A, c, exponentialEnvelope, neg_mul, abs_of_nonneg h.1] using h.2
  have hMoment (η : ℝ) (hη : 0 < η) :
      ∀ᶠ n : ℕ in atTop, ∀ a ∈ Icc l u,
        |blockScale I (n + 1) * productMissing p q (n + 1) (B n) a - phaseMoment L' v F n a| < η := by
    obtain ⟨N, hN⟩ := L'.growing_tilted_phase_moment R hR hM
      (show 0 < R.expect (fun i => Y i ^ 2) by rwa [hV])
      B hB (growing_order_tendsto hr) hθ hθ' (u := u) hη
    refine eventually_atTop.2 ⟨N, ?_⟩
    intro n hn a ha
    rw [growing_scaled_product_missing p q hp hq (n + 1) a θ r]
    have h := hN n hn a ⟨hl.le.trans ha.1, ha.2⟩
    rw [hV] at h
    exact h
  exact compact_uniform_deficit_from_phase_moment p q hq L' hv hI hl hc hA B
    (fun n => zero_lt_one.trans_le (hB n)) F hEnv hMoment hε

end RenyiProductOrderPhase
