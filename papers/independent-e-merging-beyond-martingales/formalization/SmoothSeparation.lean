import SmoothProbability

open Filter MeasureTheory
open scoped Topology

namespace IndependentMerging

theorem smoothMerger_axes {eps : ℝ} (he : 0 ≤ eps) (lam : ℝ) :
    smoothMerger eps lam 0 1 = 1 - lam * eps / 2 ∧
      smoothMerger eps lam 1 0 = 1 - lam * eps / 2 := by
  have hroot : smoothRoot eps 1 = eps := by
    unfold smoothRoot
    simpa using Real.sqrt_sq he
  constructor
  · unfold smoothMerger
    rw [hroot]
    ring
  · rw [smoothMerger_symm eps lam 1 0]
    unfold smoothMerger
    rw [hroot]
    ring

theorem smoothRoot_scaled (eps : ℝ) {t : ℝ} (ht : 0 < t) :
    smoothRoot eps t / t = Real.sqrt ((1 - t⁻¹) ^ 2 + eps ^ 2 * (t⁻¹) ^ 2) := by
  unfold smoothRoot
  rw [← Real.sqrt_sq ht.le, ← Real.sqrt_div (by positivity)]
  congr 1
  field_simp [ht.ne']

theorem smoothMerger_diagonal_scaled (eps lam : ℝ) {t : ℝ} (ht : 0 < t) :
    smoothMerger eps lam t t / t ^ 2 =
      (t⁻¹) ^ 2 + lam * (1 - t⁻¹) * Real.sqrt ((1 - t⁻¹) ^ 2 + eps ^ 2 * (t⁻¹) ^ 2) := by
  rw [← smoothRoot_scaled eps ht]
  unfold smoothMerger
  field_simp [ht.ne']
  ring

theorem smoothMerger_diagonal_limit (eps lam : ℝ) :
    Tendsto (fun t => smoothMerger eps lam t t / t ^ 2) atTop (𝓝 lam) := by
  have hi : Tendsto (fun t : ℝ => t⁻¹) atTop (𝓝 0) := tendsto_inv_atTop_zero
  have hs := (tendsto_const_nhds (x := (1 : ℝ)) (f := (atTop : Filter ℝ))).sub hi
  have harg := (hs.pow 2).add ((hi.pow 2).const_mul (eps ^ 2))
  have hroot := Real.continuous_sqrt.continuousAt.tendsto.comp harg
  have hraw := (hi.pow 2).add ((hs.const_mul lam).mul hroot)
  have heq :
      (fun t : ℝ => (t⁻¹) ^ 2 + lam * (1 - t⁻¹) *
        Real.sqrt ((1 - t⁻¹) ^ 2 + eps ^ 2 * (t⁻¹) ^ 2)) =ᶠ[atTop]
      (fun t => smoothMerger eps lam t t / t ^ 2) := by
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with t ht
    exact (smoothMerger_diagonal_scaled eps lam ht).symm
  have hlim : (0 : ℝ) ^ 2 + lam * (1 - 0) *
      Real.sqrt ((1 - 0) ^ 2 + eps ^ 2 * (0 : ℝ) ^ 2) = lam := by norm_num
  have hfinal := hraw.congr' heq
  rw [hlim] at hfinal
  exact hfinal

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

theorem PairMixture.smooth_axis_diagonal_bound [IsProbabilityMeasure μ] (G : PairMixture μ)
    {eps lam t : ℝ} (ht : 1 < t)
    (hdom : DominatesOnQuadrant G.payoff (smoothMerger eps lam)) :
    smoothMerger eps lam t t / t ^ 2 +
      (1 - t⁻¹) * (smoothMerger eps lam 0 1 + smoothMerger eps lam 1 0) ≤
      (2 - t⁻¹) * G.mean := by
  have ht0 : 0 < t := by linarith
  have hw : 0 ≤ t * (t - 1) := mul_nonneg ht0.le (sub_nonneg.mpr ht.le)
  have h₁ := hdom t t ht0.le ht0.le
  have h₂ := mul_le_mul_of_nonneg_left (hdom 0 1 (by norm_num) (by norm_num)) hw
  have h₃ := mul_le_mul_of_nonneg_left (hdom 1 0 (by norm_num) (by norm_num)) hw
  have hsum := (add_le_add (add_le_add h₁ h₂) h₃).trans (G.three_point_bound ht.le)
  have hd := div_le_div_of_nonneg_right hsum (sq_nonneg t)
  have hleft : (smoothMerger eps lam t t + t * (t - 1) * smoothMerger eps lam 0 1 +
      t * (t - 1) * smoothMerger eps lam 1 0) / t ^ 2 =
      smoothMerger eps lam t t / t ^ 2 +
        (1 - t⁻¹) * (smoothMerger eps lam 0 1 + smoothMerger eps lam 1 0) := by
    field_simp [ht0.ne']
    all_goals ring
  have hright : t * (2 * t - 1) * G.mean / t ^ 2 = (2 - t⁻¹) * G.mean := by
    field_simp [ht0.ne']
    all_goals ring
  rwa [hleft, hright] at hd

theorem PairMixture.smooth_no_domination [IsProbabilityMeasure μ] (G : PairMixture μ)
    {eps lam : ℝ} (he : 0 < eps) (he₁ : eps < 1) (hl : 0 < lam)
    (hm : G.mean ≤ 1) : ¬ DominatesOnQuadrant G.payoff (smoothMerger eps lam) := by
  intro hdom
  have hi : Tendsto (fun t : ℝ => t⁻¹) atTop (𝓝 0) := tendsto_inv_atTop_zero
  have hs := (tendsto_const_nhds (x := (1 : ℝ)) (f := (atTop : Filter ℝ))).sub hi
  have h₂ := (tendsto_const_nhds (x := (2 : ℝ)) (f := (atTop : Filter ℝ))).sub hi
  have hleft := (smoothMerger_diagonal_limit eps lam).add
    (hs.mul_const (smoothMerger eps lam 0 1 + smoothMerger eps lam 1 0))
  have hright := h₂.mul_const G.mean
  have hpoint : ∀ᶠ t : ℝ in atTop,
      smoothMerger eps lam t t / t ^ 2 +
        (1 - t⁻¹) * (smoothMerger eps lam 0 1 + smoothMerger eps lam 1 0) ≤
      (2 - t⁻¹) * G.mean := by
    filter_upwards [eventually_gt_atTop (1 : ℝ)] with t ht
    exact G.smooth_axis_diagonal_bound ht hdom
  have hlimit := le_of_tendsto_of_tendsto hleft hright hpoint
  have haxes := smoothMerger_axes he.le lam
  rw [sub_zero, sub_zero, one_mul, haxes.1, haxes.2] at hlimit
  nlinarith [mul_pos hl (sub_pos.mpr he₁)]

theorem smooth_theorem {eps lam : ℝ} (he : 0 < eps) (he₁ : eps < 1) (hl : 0 < lam)
    (hu : lam ≤ 1 / Real.sqrt (1 + eps ^ 2)) :
    AnalyticOnNhd ℝ (fun z : ℝ × ℝ => smoothMerger eps lam z.1 z.2) Set.univ ∧
    IsIndependentEMerger (smoothMerger eps lam) ∧
    (∀ x, StrictMono (smoothMerger eps lam x)) ∧
    (∀ y, StrictMono (fun x => smoothMerger eps lam x y)) ∧
    (∀ x y, smoothMerger eps lam x y = smoothMerger eps lam y x) ∧
    (∀ H, IsIndependentEMerger H → DominatesOnQuadrant H (smoothMerger eps lam) →
      ∀ x y, 0 ≤ x → 0 ≤ y → H x y = smoothMerger eps lam x y) ∧
    (∀ (μ : Measure Ω) [IsProbabilityMeasure μ] (G : PairMixture μ),
      G.mean ≤ 1 → ¬ DominatesOnQuadrant G.payoff (smoothMerger eps lam)) :=
  ⟨smoothMerger_analytic he, smoothMerger_isIndependentEMerger he hl hu,
    smoothMerger_strict_right he hl, smoothMerger_strict_left he hl, smoothMerger_symm eps lam,
    fun H hH hdom => smoothMerger_admissible he hl hu H hH hdom,
    fun _ _ G hm => G.smooth_no_domination he he₁ hl hm⟩

end IndependentMerging
