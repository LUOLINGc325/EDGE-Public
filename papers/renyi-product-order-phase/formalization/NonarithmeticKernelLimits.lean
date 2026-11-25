import NonarithmeticTestLimit
import KernelEnvelope
import FixedKernelIntegral
import Mathlib.Topology.UniformSpace.HeineCantor

/-! Compact-uniform evaluation of the fixed and limiting tilted kernels. -/

open Set MeasureTheory

namespace RenyiProductOrderPhase

theorem prior_time_uniform_modulus (f : ℝ × ℝ → ℝ) {l u a b : ℝ}
    (hf : ContinuousOn f (Icc l u ×ˢ Icc a b))
    {ε : ℝ} (hε : 0 < ε) :
    ∃ δ > 0, ∀ q ∈ Icc l u, ∀ x ∈ Icc a b, ∀ y ∈ Icc a b,
      |x - y| < δ → |f (q, x) - f (q, y)| < ε := by
  have hK : IsCompact (Icc l u ×ˢ Icc a b) := isCompact_Icc.prod isCompact_Icc
  obtain ⟨δ, hδ, hU⟩ := (Metric.uniformContinuousOn_iff.1
    (hK.uniformContinuousOn_of_continuous hf)) ε hε
  refine ⟨δ, hδ, ?_⟩
  intro q hq x hx y hy hxy
  exact (show dist (f (q, x)) (f (q, y)) < ε from
    hU (q, x) ⟨hq, hx⟩ (q, y) ⟨hq, hy⟩
      (by simpa only [dist_prod_same_left, Real.dist_eq] using hxy))

theorem fixed_tilted_kernel_continuousOn (b θ : ℝ) :
    ContinuousOn (fun x : ℝ × ℝ => tiltedKernel b x.1 θ x.2) (Ici (0 : ℝ) ×ˢ univ) := by
  let z (x : ℝ × ℝ) := 1 + x.1 * Real.exp x.2
  have hz : Continuous z := by unfold z; fun_prop
  have hPow : ContinuousOn (fun x : ℝ × ℝ => z x ^ (-b)) (Ici (0 : ℝ) ×ˢ univ) :=
    hz.continuousOn.rpow_const (fun x hx => Or.inl (show 0 < z x by
      have hA : 0 ≤ x.1 := hx.1
      unfold z
      positivity).ne')
  have hExp : Continuous (fun x : ℝ × ℝ => Real.exp (-(θ * x.2))) := by fun_prop
  exact hExp.continuousOn.mul (continuousOn_const.sub hPow)

theorem fixed_tilted_kernel_continuous (b θ : ℝ) {a : ℝ} (ha : 0 ≤ a) :
    Continuous (tiltedKernel b a θ) := by
  have h := (fixed_tilted_kernel_continuousOn b θ).comp_continuous
    (show Continuous (fun s : ℝ => (a, s)) from continuous_const.prodMk continuous_id)
    (fun s => show (a, s) ∈ Ici (0 : ℝ) ×ˢ univ from ⟨ha, mem_univ s⟩)
  exact h

theorem growing_limit_kernel_joint_continuous (θ : ℝ) :
    Continuous (fun x : ℝ × ℝ => growingLimitKernel x.1 θ x.2) := by
  unfold growingLimitKernel growingLimitGap
  fun_prop

variable {κ : Type*} [Fintype κ]

theorem nonarithmetic_fixed_tilted_limit (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (Y : κ → ℝ) (hNon : ¬ ArithmeticSupport Y) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) {b θ l u ε : ℝ}
    (hb : 1 ≤ b) (hθ : 0 < θ) (hθ' : θ < 1) (hl : 0 < l) (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ a ∈ Icc l u,
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * (FiniteMass.tensor (fun _ : Fin (n + 1) => p)).expect
        (fun x => tiltedKernel b a θ (iidSum Y x)) -
        gaussianHeight (p.expect (fun i => Y i ^ 2)) *
        (a ^ θ * Real.Gamma (1 - θ) * Real.Gamma (b + θ) / (θ * Real.Gamma b))| < ε := by
  let F (a : Icc l u) := tiltedKernel b (a : ℝ) θ
  let c := min θ (1 - θ)
  let A := max 1 (b * u)
  have hc : 0 < c := lt_min hθ (sub_pos.mpr hθ')
  have hA : 0 ≤ A := zero_le_one.trans (le_max_left _ _)
  have hMeas (a : Icc l u) : Measurable (F a) :=
    (fixed_tilted_kernel_continuous b θ (hl.le.trans a.property.1)).measurable
  have hEnv (a : Icc l u) (s : ℝ) : |F a s| ≤ A * exponentialEnvelope c s := by
    have h := fixed_tilted_kernel_envelope (hl.le.trans a.property.1) a.property.2 hb (θ := θ) s
    simpa only [F, A, c, exponentialEnvelope, neg_mul, abs_of_nonneg h.1] using h.2
  have hUniform (L : ℕ) (η : ℝ) (hη : 0 < η) :
      ∃ δ > 0, ∀ a : Icc l u, ∀ x y,
        x ∈ Icc (-(L : ℝ)) (L : ℝ) → y ∈ Icc (-(L : ℝ)) (L : ℝ) →
        |x - y| < δ → |F a x - F a y| < η := by
    have hCont := (fixed_tilted_kernel_continuousOn b θ).mono
      (show Icc l u ×ˢ Icc (-(L : ℝ)) (L : ℝ) ⊆ Ici (0 : ℝ) ×ˢ univ from
        fun x hx => ⟨hl.le.trans hx.1.1, mem_univ x.2⟩)
    obtain ⟨δ, hδ, hU⟩ := prior_time_uniform_modulus _ hCont hη
    exact ⟨δ, hδ, fun a x y hx hy hxy => hU a a.property x hx y hy hxy⟩
  obtain ⟨N, hN⟩ := uniform_nonarithmetic_test_limit p hp Y hNon hm hv F hc hA hMeas hEnv hUniform hε
  refine ⟨N, ?_⟩
  intro n hn a ha
  have h := hN n hn ⟨a, ha⟩
  unfold F at h
  rwa [fixed_tilted_kernel_gamma (hl.trans_le ha.1) hb hθ hθ'] at h

theorem nonarithmetic_growing_limit_kernel_test (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (Y : κ → ℝ) (hNon : ¬ ArithmeticSupport Y) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) {θ l u ε : ℝ}
    (hθ : 0 < θ) (hθ' : θ < 1) (hl : 0 < l) (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ a ∈ Icc l u,
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * (FiniteMass.tensor (fun _ : Fin (n + 1) => p)).expect
        (fun x => growingLimitKernel a θ (iidSum Y x)) -
        gaussianHeight (p.expect (fun i => Y i ^ 2)) * (a ^ θ * Real.Gamma (1 - θ) / θ)| < ε := by
  let F (a : Icc l u) := growingLimitKernel (a : ℝ) θ
  let c := min θ (1 - θ)
  let A := max 1 u
  have hc : 0 < c := lt_min hθ (sub_pos.mpr hθ')
  have hA : 0 ≤ A := zero_le_one.trans (le_max_left _ _)
  have hMeas (a : Icc l u) : Measurable (F a) :=
    ((growing_limit_kernel_joint_continuous θ).comp
      (show Continuous (fun s : ℝ => ((a : ℝ), s)) from continuous_const.prodMk continuous_id)).measurable
  have hEnv (a : Icc l u) (s : ℝ) : |F a s| ≤ A * exponentialEnvelope c s := by
    have h := growing_limit_kernel_envelope (hl.le.trans a.property.1) a.property.2 (θ := θ) s
    simpa only [F, A, c, exponentialEnvelope, neg_mul, abs_of_nonneg h.1] using h.2
  have hUniform (L : ℕ) (η : ℝ) (hη : 0 < η) :
      ∃ δ > 0, ∀ a : Icc l u, ∀ x y,
        x ∈ Icc (-(L : ℝ)) (L : ℝ) → y ∈ Icc (-(L : ℝ)) (L : ℝ) →
        |x - y| < δ → |F a x - F a y| < η := by
    have hCont : ContinuousOn (fun x : ℝ × ℝ => growingLimitKernel x.1 θ x.2)
        (Icc l u ×ˢ Icc (-(L : ℝ)) (L : ℝ)) :=
      (growing_limit_kernel_joint_continuous θ).continuousOn
    obtain ⟨δ, hδ, hU⟩ := prior_time_uniform_modulus _ hCont hη
    exact ⟨δ, hδ, fun a x y hx hy hxy => hU a a.property x hx y hy hxy⟩
  obtain ⟨N, hN⟩ := uniform_nonarithmetic_test_limit p hp Y hNon hm hv F hc hA hMeas hEnv hUniform hε
  refine ⟨N, ?_⟩
  intro n hn a ha
  have h := hN n hn ⟨a, ha⟩
  unfold F at h
  rwa [growing_limit_kernel_gamma (hl.trans_le ha.1) hθ hθ'] at h

end RenyiProductOrderPhase
