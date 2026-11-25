import CriticalSoftThreshold
import CriticalGaussianVariational
import Mathlib.Topology.UniformSpace.HeineCantor

/-! Compact-uniform convergence of the exact critical-window contraction objective. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem critical_small_exponential_tendsto (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {d : ℝ} (hd : 0 < d) :
    Tendsto (fun n : ℕ => Real.exp (-(d * criticalScale p q (n + 1)))) atTop (𝓝 0) := by
  have hS := critical_scale_tendsto p q hp hq hne
  have hA := (tendsto_const_mul_atBot_of_neg (neg_lt_zero.mpr hd)).mpr hS
  simpa only [Function.comp_apply, neg_mul] using Real.tendsto_exp_atBot.comp hA

theorem critical_moment_compact_uniform (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (ζ : ℝ) {l u ε : ℝ} (hl : 0 < l) (hε : 0 < ε) :
    ∀ᶠ n : ℕ in atTop, ∀ t ∈ Icc l u,
      |productScalarMoment p q (n + 1) (criticalOrder p q ζ (n + 1)) (criticalPrior p q (n + 1) t) -
        standardNormalTail (ζ + t)| < ε := by
  let G := gaussianHeight 1
  have hG : 0 ≤ G := (gaussian_height_pos zero_lt_one).le
  let d := ε / (4 * (G + 1))
  have hDen : 0 < 4 * (G + 1) := by positivity
  have hd : 0 < d := div_pos hε hDen
  have hGd : G * d < ε / 4 := by
    have hE : (4 * (G + 1)) * d = ε := mul_div_cancel₀ _ hDen.ne'
    nlinarith only [hE, hd]
  have hCLT := kl_uniform_central_limit p q hp hq hne (div_pos hε (by norm_num : (0 : ℝ) < 4))
  have hB := (critical_order_tendsto p q hp hq hne ζ).eventually (eventually_ge_atTop 1)
  have hL := (critical_scale_tendsto p q hp hq hne).eventually
    (eventually_ge_atTop (Real.log 2 / l))
  have hE := (critical_small_exponential_tendsto p q hp hq hne hd).eventually
    (Iio_mem_nhds (div_pos hε (by norm_num : (0 : ℝ) < 8)))
  filter_upwards [hCLT, hB, hL, hE] with n hCL hnB hnL hnE
  intro t ht
  let s := criticalScale p q (n + 1)
  let E := Real.exp (-(d * s))
  let X (i : κ) := standardizedLogLikelihood p q i / Real.sqrt ((n + 1 : ℕ) : ℝ)
  let A := productScalarMoment p q (n + 1) (criticalOrder p q ζ (n + 1))
    (criticalPrior p q (n + 1) t)
  have hs : 0 < s := critical_scale_pos p q hp hq hne (Nat.succ_pos n)
  have ht₀ : 0 < t := hl.trans_le ht.1
  have hU : Real.log 2 ≤ t * s := by
    have h : Real.log 2 ≤ s * l := (div_le_iff₀ hl).1 hnL
    rw [mul_comm s l] at h
    exact h.trans (mul_le_mul_of_nonneg_right ht.1 hs.le)
  have hBds := critical_soft_threshold_sandwich p q hp hq ζ (n + 1) (d := d) hs ht₀ hnB hU
  have hb₁ : 1 - finiteSumEvent p X (n + 1) (Iic (ζ + t + d)) - E ≤ A := hBds.1
  have hb₂ : A ≤ 1 - finiteSumEvent p X (n + 1) (Iic (ζ + t - d)) + 2 * E := hBds.2
  have hE' : E < ε / 8 := hnE
  have hCDF₁ := (abs_lt.mp (hCL (ζ + t + d))).2
  have hCDF₂ := (abs_lt.mp (hCL (ζ + t - d))).1
  have hShift₁ := (gaussian_cdf_increment zero_lt_one (show ζ + t ≤ ζ + t + d by linarith)).2
  have hShift₂ := (gaussian_cdf_increment zero_lt_one (show ζ + t - d ≤ ζ + t by linarith)).2
  rw [add_sub_cancel_left] at hShift₁
  rw [sub_sub_cancel] at hShift₂
  change gaussianCDF 1 (ζ + t + d) - gaussianCDF 1 (ζ + t) ≤ G * d at hShift₁
  change gaussianCDF 1 (ζ + t) - gaussianCDF 1 (ζ + t - d) ≤ G * d at hShift₂
  have hTail := standard_normal_tail_complement (ζ + t)
  change |A - standardNormalTail (ζ + t)| < ε
  rw [abs_lt]
  exact ⟨by linarith only [hb₁, hCDF₁, hShift₁, hTail, hE', hGd, hε],
    by linarith only [hb₂, hCDF₂, hShift₂, hTail, hE', hGd, hε]⟩

theorem critical_objective_compact_uniform (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (ζ : ℝ) {l u ε : ℝ} (hl : 0 < l) (hε : 0 < ε) :
    ∀ᶠ n : ℕ in atTop, ∀ t ∈ Icc l u,
      |criticalObjective p q ζ (n + 1) t - criticalGaussianCost ζ t| < ε := by
  let m := standardNormalTail (ζ + u) / 2
  have hm : 0 < m := div_pos (standard_normal_tail_bounds _).1 (by norm_num)
  let S := Icc m 1
  have hCont : ContinuousOn (fun x : ℝ => -Real.log x) S :=
    (continuous_id.continuousOn.log (fun _ hx => (hm.trans_le hx.1).ne')).neg
  have hUC := isCompact_Icc.uniformContinuousOn_of_continuous hCont
  obtain ⟨d, hd, hD⟩ := (Metric.uniformContinuousOn_iff.1 hUC) (ε * l) (mul_pos hε hl)
  have hCL := critical_moment_compact_uniform p q hp hq hne ζ (u := u) hl (lt_min hd hm)
  filter_upwards [hCL] with n hn
  intro t ht
  let A := productScalarMoment p q (n + 1) (criticalOrder p q ζ (n + 1))
    (criticalPrior p q (n + 1) t)
  let B := standardNormalTail (ζ + t)
  have hNear : |A - B| < min d m := hn t ht
  have hBpos : 0 < B := (standard_normal_tail_bounds _).1
  have hAnti : Antitone standardNormalTail := by
    intro x y hxy
    have h := standard_normal_tail_complement x
    have h' := standard_normal_tail_complement y
    have hG := (gaussian_cdf_increment zero_lt_one hxy).1
    linarith only [h, h', hG]
  have hm₁ : 2 * m ≤ B := by
    unfold m
    have h := hAnti (add_le_add_left ht.2 ζ)
    linarith only [h]
  have hBs : B ∈ S := ⟨by linarith only [hm₁, hm], (standard_normal_tail_bounds _).2.le⟩
  have hAs : A ∈ S := by
    have hA := (abs_lt.mp (hNear.trans_le (min_le_right d m))).1
    have hS := critical_scale_pos p q hp hq hne (Nat.succ_pos n)
    have ha := critical_prior_positive p q hS (hl.trans_le ht.1)
    have hOrder : 0 < criticalOrder p q ζ (n + 1) := Real.exp_pos _
    have hB := product_missing_probability_bounds p q hq (n + 1) hOrder ha
    change 0 ≤ 1 - A ∧ 1 - A < 1 at hB
    exact ⟨by linarith only [hA, hm₁], by linarith only [hB.1]⟩
  have hClose := hD A hAs B hBs (by
    rw [Real.dist_eq]
    exact hNear.trans_le (min_le_left d m))
  rw [Real.dist_eq] at hClose
  have ht₀ : 0 < t := hl.trans_le ht.1
  change |(-Real.log A) / t - (-Real.log B) / t| < ε
  rw [← sub_div, abs_div, abs_of_pos ht₀]
  exact (div_lt_iff₀ ht₀).2 (hClose.trans_le (mul_le_mul_of_nonneg_left ht.1 hε.le))

end RenyiProductOrderPhase
