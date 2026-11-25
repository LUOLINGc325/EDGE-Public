import CumulantTilt
import BinaryVariation
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Topology.Order.IntermediateValue

/-! Cumulant differentiation, positive tilted variance, and the unique saddle. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

namespace FiniteMass

theorem hasDerivAt_exponential_expectation (p : FiniteMass κ) (Y f : κ → ℝ) (s : ℝ) :
    HasDerivAt (fun t : ℝ => p.expect (fun y => Real.exp (t * Y y) * f y))
      (p.expect (fun y => Real.exp (s * Y y) * Y y * f y)) s := by
  have h (y : κ) : HasDerivAt (fun t => p y * (Real.exp (t * Y y) * f y))
      (p y * (Real.exp (s * Y y) * Y y * f y)) s := by
    have hlin : HasDerivAt (fun t : ℝ => t * Y y) (Y y) s := by
      simpa only [one_mul] using (hasDerivAt_id s).mul_const (Y y)
    exact ((hlin.exp).mul_const (f y)).const_mul (p y)
  exact HasDerivAt.sum (u := Finset.univ) (fun y _ => h y)

end FiniteMass

noncomputable def tiltedMean (p q : FiniteMass κ) (s : ℝ) : ℝ :=
  (tiltedMass p q s).expect (logLikelihood p q)

noncomputable def tiltedVariance (p q : FiniteMass κ) (s : ℝ) : ℝ :=
  (tiltedMass p q s).expect (fun y => (logLikelihood p q y - tiltedMean p q s) ^ 2)

theorem hasDerivAt_tilt_normalizer (p q : FiniteMass κ) (s : ℝ) :
    HasDerivAt (tiltNormalizer p q)
      (p.expect (fun y => Real.exp (s * logLikelihood p q y) * logLikelihood p q y)) s := by
  simpa only [tiltNormalizer, mul_one] using
    (p.hasDerivAt_exponential_expectation (logLikelihood p q) (fun _ => 1) s)

theorem hasDerivAt_log_cumulant (p q : FiniteMass κ) (s : ℝ) :
    HasDerivAt (logCumulant p q) (tiltedMean p q s) s := by
  unfold logCumulant tiltedMean
  rw [tilted_expectation]
  exact (hasDerivAt_tilt_normalizer p q s).log (tilt_normalizer_pos p q s).ne'

theorem FiniteMass.expect_centered_square (P : FiniteMass κ) (Y : κ → ℝ) :
    P.expect (fun y => (Y y - P.expect Y) ^ 2) =
      P.expect (fun y => Y y ^ 2) - (P.expect Y) ^ 2 := by
  let m := P.expect Y
  change P.expect (fun y => (Y y - m) ^ 2) = P.expect (fun y => Y y ^ 2) - m ^ 2
  calc
    _ = P.expect (fun y => 1 * (1 * Y y ^ 2 + (-2 * m) * Y y) + 1 * (m ^ 2)) := by
      congr 1
      funext y
      ring
    _ = _ := by
      rw [P.expect_linear, P.expect_linear, P.expect_const]
      change 1 * (1 * P.expect (fun y => Y y ^ 2) + (-2 * m) * m) + 1 * m ^ 2 = _
      ring

theorem tilted_variance_second_moment (p q : FiniteMass κ) (s : ℝ) :
    tiltedVariance p q s =
      (tiltedMass p q s).expect (fun y => logLikelihood p q y ^ 2) - tiltedMean p q s ^ 2 :=
  (tiltedMass p q s).expect_centered_square (logLikelihood p q)

theorem hasDerivAt_tilted_mean (p q : FiniteMass κ) (s : ℝ) :
    HasDerivAt (tiltedMean p q) (tiltedVariance p q s) s := by
  let Y := logLikelihood p q
  let Z := tiltNormalizer p q
  let M (t : ℝ) := p.expect (fun y => Real.exp (t * Y y) * Y y)
  let N (t : ℝ) := p.expect (fun y => Real.exp (t * Y y) * Y y ^ 2)
  have hz : 0 < Z s := tilt_normalizer_pos p q s
  have hm : HasDerivAt M (N s) s := by
    have h := p.hasDerivAt_exponential_expectation Y Y s
    simpa only [M, N, pow_two, mul_assoc] using h
  have hZD : HasDerivAt Z (M s) s := hasDerivAt_tilt_normalizer p q s
  have hMean : tiltedMean p q = fun t => M t / Z t := by
    funext t
    exact tilted_expectation p q t Y
  have h := hm.div hZD hz.ne'
  rw [← hMean] at h
  convert h using 1
  rw [tilted_variance_second_moment, hMean, tilted_expectation]
  change N s / Z s - (M s / Z s) ^ 2 = (N s * Z s - M s * M s) / (Z s) ^ 2
  calc
    _ = N s * Z s / (Z s * Z s) - M s * M s / (Z s * Z s) := by
      rw [pow_two (M s / Z s), div_mul_div_comm, mul_div_mul_right _ _ hz.ne']
    _ = _ := by rw [← sub_div, pow_two]

theorem tilted_variance_pos (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) (hne : p ≠ q) (s : ℝ) :
    0 < tiltedVariance p q s := by
  obtain ⟨i, j, hij⟩ := ratio_nonconstant p q hp hne
  let Y := logLikelihood p q
  let m := tiltedMean p q s
  have hne' : Y i ≠ Y j := by
    intro h
    apply hij
    have hExp := congrArg Real.exp h
    unfold Y logLikelihood at hExp
    rwa [Real.exp_log (div_pos (hq i) (hp i)), Real.exp_log (div_pos (hq j) (hp j))] at hExp
  obtain ⟨k, hk⟩ : ∃ k, Y k ≠ m := by
    by_cases h : Y i = m
    · exact ⟨j, fun hj => hne' (h.trans hj.symm)⟩
    · exact ⟨i, h⟩
  exact (tiltedMass p q s).expect_pos (fun y => sq_nonneg (Y y - m))
    (tilted_mass_pos p q hp s k) (sq_pos_of_ne_zero (sub_ne_zero.mpr hk))

theorem tilted_mean_strict_mono (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) (hne : p ≠ q) :
    StrictMono (tiltedMean p q) := by
  apply strictMono_of_deriv_pos
  intro x
  rw [(hasDerivAt_tilted_mean p q x).deriv]
  exact tilted_variance_pos p q hp hq hne x

namespace BinarySymmetricChannel

theorem tilted_mean_symmetric (w : BinarySymmetricChannel κ) (s : ℝ) :
    tiltedMean (w.channel false) (w.channel true) s =
      -tiltedMean (w.channel false) (w.channel true) (1 - s) := by
  let P := w.channel false
  let Q := w.channel true
  have hA : HasDerivAt (fun t : ℝ => 1 - t) (-1) s := by
    simpa only [zero_sub] using (hasDerivAt_const s (1 : ℝ)).sub (hasDerivAt_id s)
  have h := (hasDerivAt_log_cumulant P Q (1 - s)).comp s hA
  have hF : logCumulant P Q ∘ (fun t => 1 - t) = logCumulant P Q := by
    funext t
    exact (w.log_cumulant_symmetric t).symm
  rw [hF, mul_neg_one] at h
  exact (hasDerivAt_log_cumulant P Q s).unique h

theorem halfway_tilt_centered (w : BinarySymmetricChannel κ) :
    tiltedMean (w.channel false) (w.channel true) (1 / 2) = 0 := by
  have h := w.tilted_mean_symmetric (1 / 2)
  rw [show (1 : ℝ) - 1 / 2 = 1 / 2 by norm_num] at h
  linarith only [h]

theorem unique_tilt_saddle (w : BinarySymmetricChannel κ) {r : ℝ} (hr : 0 < r)
    (hD : r < -tiltedMean (w.channel false) (w.channel true) 0) :
    ∃! s : ℝ, s ∈ Ioo (0 : ℝ) (1 / 2) ∧
      tiltedMean (w.channel false) (w.channel true) s = -r := by
  let f := tiltedMean (w.channel false) (w.channel true)
  have hmono : StrictMono f :=
    tilted_mean_strict_mono _ _ (w.positive false) (w.positive true) w.informative
  have hf : Continuous f := continuous_iff_continuousAt.2 (fun t =>
    (hasDerivAt_tilted_mean _ _ t).continuousAt)
  have hmid : f (1 / 2) = 0 := w.halfway_tilt_centered
  have hrange : -r ∈ Icc (f 0) (f (1 / 2)) := by
    rw [hmid]
    exact ⟨by linarith only [hD], (neg_neg_of_pos hr).le⟩
  obtain ⟨s, hs, he⟩ := intermediate_value_Icc (show (0 : ℝ) ≤ 1 / 2 by norm_num)
    hf.continuousOn hrange
  have hlo : 0 < s := lt_of_le_of_ne hs.1 (fun hz => by
    rw [← hz] at he
    exact (not_le_of_gt hD) (by linarith only [he]))
  have hhi : s < 1 / 2 := lt_of_le_of_ne hs.2 (fun hz => by
    rw [hz, hmid] at he
    exact hr.ne' (by linarith only [he]))
  exact ⟨s, ⟨⟨hlo, hhi⟩, he⟩, fun _ h => hmono.injective (h.2.trans he.symm)⟩

end BinarySymmetricChannel

end RenyiProductOrderPhase
