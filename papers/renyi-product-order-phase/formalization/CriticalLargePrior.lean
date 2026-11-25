import CriticalMomentGrowth

/-! A single global large-prior bound in the critical KL window. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

theorem log_exp_sub_one_lower {U : ℝ} (hU : Real.log 2 ≤ U) :
    U - Real.log 2 ≤ Real.log (Real.exp U - 1) := by
  have h2 : 2 ≤ Real.exp U := by
    simpa only [Real.exp_log (by norm_num : (0 : ℝ) < 2)] using Real.exp_le_exp.mpr hU
  have h := Real.log_le_log (div_pos (Real.exp_pos U) (by norm_num : (0 : ℝ) < 2))
    (show Real.exp U / 2 ≤ Real.exp U - 1 by linarith only [h2])
  rwa [Real.log_div (Real.exp_pos U).ne' (by norm_num : (2 : ℝ) ≠ 0), Real.log_exp] at h

variable {κ : Type*} [Fintype κ]

theorem critical_large_prior_linear_bound (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (ζ : ℝ) {n : ℕ} (hn : 0 < n) {L t : ℝ} (hL : 0 < L) (ht : 0 < t)
    (hb : 1 ≤ criticalOrder p q ζ n)
    (hSmall : ∀ i, |(L / criticalScale p q n) * klCenteredLikelihood p q i| ≤ 1)
    (hTilt : L / criticalScale p q n ≤ 1)
    (hU : Real.log 2 ≤ t * criticalScale p q n) :
    L * t - (Real.exp 1 * L ^ 2 + L * |ζ| + Real.log 2) ≤
      negativeLogProductMoment p q n (criticalOrder p q ζ n) (criticalPrior p q n t) := by
  let σ := klSigma p q
  let s := criticalScale p q n
  let U := t * s
  let a := criticalPrior p q n t
  let B := criticalOrder p q ζ n
  let θ := L / s
  let W := klCenteredLikelihood p q
  have hs : 0 < s := critical_scale_pos p q hp hq hne hn
  have ha : 0 < a := critical_prior_positive p q hs ht
  have hθ : 0 < θ := div_pos hL hs
  have hScale : θ * s = L := div_mul_cancel₀ _ hs.ne'
  have hStat := kl_centered_likelihood_stats p q hp hq hne
  have hMgf := centered_finite_log_mgf_upper p W θ hStat.1 hSmall
  change Real.log (p.expect (fun i => Real.exp (θ * W i))) ≤
    (Real.exp 1 * θ ^ 2) * p.expect (fun i => W i ^ 2) at hMgf
  rw [show p.expect (fun i => W i ^ 2) = σ ^ 2 from hStat.2] at hMgf
  have hCal : ((n : ℝ) * ((Real.exp 1 * θ ^ 2) * σ ^ 2)) = Real.exp 1 * L ^ 2 := by
    let r := Real.sqrt (n : ℝ)
    have hr : r ^ 2 = (n : ℝ) := Real.sq_sqrt (Nat.cast_nonneg _)
    rw [← hr]
    calc
      _ = Real.exp 1 * (θ * (σ * r)) ^ 2 := by ring
      _ = _ := by change Real.exp 1 * (θ * s) ^ 2 = _; rw [hScale]
  have hMn := mul_le_mul_of_nonneg_left hMgf (Nat.cast_nonneg n)
  rw [hCal] at hMn
  have h := product_negative_log_power_lower p q hp hq n ha hθ (hTilt.trans hb)
  change θ * (Real.log B + Real.log a - Real.log θ) -
    (n : ℝ) * logCumulant p q (-θ) ≤ negativeLogProductMoment p q n B a at h
  have hOrder : Real.log B = (n : ℝ) * klMean p q + ζ * s := Real.log_exp _
  rw [hOrder, cumulant_from_kl_centered_likelihood] at h
  have hA₀ : U - Real.log 2 ≤ Real.log a := log_exp_sub_one_lower hU
  have hThetaLog : Real.log θ ≤ 0 := Real.log_nonpos hθ.le hTilt
  have hA := mul_le_mul_of_nonneg_left hA₀ hθ.le
  have hAt := mul_le_mul_of_nonneg_left hThetaLog hθ.le
  have hT₂ := mul_le_mul_of_nonneg_right hTilt (Real.log_nonneg (by norm_num : (1 : ℝ) ≤ 2))
  have hζ := mul_le_mul_of_nonneg_left (neg_abs_le ζ) hL.le
  have hSc₁ : θ * U = L * t := by
    unfold U
    calc
      _ = (θ * s) * t := by ring
      _ = _ := by rw [hScale]
  have hSc₂ : θ * (ζ * s) = L * ζ := by
    calc
      _ = (θ * s) * ζ := by ring
      _ = _ := by rw [hScale]
  rw [mul_sub, hSc₁] at hA
  have hExact : θ * ((n : ℝ) * klMean p q + ζ * s + Real.log a - Real.log θ) -
      (n : ℝ) * (θ * klMean p q + Real.log (p.expect (fun i => Real.exp (θ * W i)))) =
      L * ζ + θ * Real.log a - θ * Real.log θ -
        (n : ℝ) * Real.log (p.expect (fun i => Real.exp (θ * W i))) := by
    calc
      _ = θ * (ζ * s) + θ * Real.log a - θ * Real.log θ -
        (n : ℝ) * Real.log (p.expect (fun i => Real.exp (θ * W i))) := by ring
      _ = _ := by rw [hSc₂]
  rw [hExact] at h
  change _ ≤ negativeLogProductMoment p q n B a
  nlinarith only [h, hMn, hA, hAt, hT₂, hζ]

end RenyiProductOrderPhase
