import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Tactic.Linarith

open MeasureTheory

namespace TrapCertificate

/-- Projection of a level onto a closed interval. -/
noncomputable def clampLevel (l u c : ℝ) : ℝ := min u (max l c)

/-- Projection onto an interval produces a nonnegative normal term. -/
theorem clampNormal {l u c z : ℝ} (hl : l ≤ z) (hu : z ≤ u) :
    0 ≤ (clampLevel l u c - c) * (z - clampLevel l u c) := by
  unfold clampLevel
  rcases le_total c l with hcl | hlc
  · rw [max_eq_left hcl, min_eq_right (hl.trans hu)]
    exact mul_nonneg (sub_nonneg.mpr hcl) (sub_nonneg.mpr hl)
  · rw [max_eq_right hlc]
    rcases le_total c u with hcu | huc
    · simp [min_eq_right hcu]
    · rw [min_eq_left huc]
      exact mul_nonneg_of_nonpos_of_nonpos (sub_nonpos.mpr huc) (sub_nonpos.mpr hu)

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {l u z : α → ℝ} {c : ℝ}

private theorem energyConstantBound
    {w : α → ℝ} (hw : ∀ᵐ t ∂μ, w t = clampLevel (l t) (u t) c)
    (hbox : ∀ᵐ t ∂μ, l t ≤ z t ∧ z t ≤ u t)
    (hz : Integrable z μ) (hiw : Integrable w μ)
    (hz₂ : Integrable (fun t => z t ^ 2) μ)
    (hw₂ : Integrable (fun t => w t ^ 2) μ)
    (hd₂ : Integrable (fun t => (z t - w t)^2) μ)
    (hmean : ∫ t, z t ∂μ = ∫ t, w t ∂μ) :
    (∫ t, w t ^ 2 ∂μ) + (∫ t, (z t - w t)^2 ∂μ) ≤ ∫ t, z t ^ 2 ∂μ := by
  have hin : Integrable (fun t => 2*c*(z t - w t)) μ :=
    (hz.sub hiw).const_mul _
  have hzw₂ : Integrable (fun t => z t ^ 2 - w t ^ 2) μ := hz₂.sub hw₂
  have hout : Integrable (fun t => z t ^ 2 - w t ^ 2 - (z t - w t)^2) μ :=
    hzw₂.sub hd₂
  have hab : (fun t => 2*c*(z t - w t)) ≤ᵐ[μ]
      (fun t => z t ^ 2 - w t ^ 2 - (z t - w t)^2) := by
    filter_upwards [hw, hbox] with t ht htbox
    have hn := clampNormal (c := c) htbox.1 htbox.2
    rw [← ht] at hn
    nlinarith only [hn]
  have h := integral_mono_ae hin hout hab
  rw [integral_const_mul, integral_sub hz hiw, hmean, sub_self, mul_zero,
    integral_sub hzw₂ hd₂, integral_sub hz₂ hw₂] at h
  linarith

/-- Among profiles with the same integral, a pointwise clamp minimizes the
quadratic energy, with an explicit lower bound on the objective gap. -/
theorem clampEnergyGap
    (hbox : ∀ᵐ t ∂μ, l t ≤ z t ∧ z t ≤ u t)
    (hz : Integrable z μ)
    (hw : Integrable (fun t => clampLevel (l t) (u t) c) μ)
    (hz₂ : Integrable (fun t => z t ^ 2) μ)
    (hw₂ : Integrable (fun t => (clampLevel (l t) (u t) c)^2) μ)
    (hd₂ : Integrable (fun t => (z t - clampLevel (l t) (u t) c)^2) μ)
    (hmean : ∫ t, z t ∂μ = ∫ t, clampLevel (l t) (u t) c ∂μ) :
    (∫ t, (clampLevel (l t) (u t) c)^2 ∂μ) +
      (∫ t, (z t - clampLevel (l t) (u t) c)^2 ∂μ) ≤ ∫ t, z t ^ 2 ∂μ :=
  energyConstantBound (Filter.Eventually.of_forall (fun _ => rfl))
    hbox hz hw hz₂ hw₂ hd₂ hmean

/-- A competitor achieving the clamp energy agrees almost everywhere with
the clamp, including when the two envelopes coincide on a set. -/
theorem clampEnergyUnique
    (hbox : ∀ᵐ t ∂μ, l t ≤ z t ∧ z t ≤ u t)
    (hz : Integrable z μ)
    (hw : Integrable (fun t => clampLevel (l t) (u t) c) μ)
    (hz₂ : Integrable (fun t => z t ^ 2) μ)
    (hw₂ : Integrable (fun t => (clampLevel (l t) (u t) c)^2) μ)
    (hd₂ : Integrable (fun t => (z t - clampLevel (l t) (u t) c)^2) μ)
    (hmean : ∫ t, z t ∂μ = ∫ t, clampLevel (l t) (u t) c ∂μ)
    (heq : ∫ t, z t ^ 2 ∂μ = ∫ t, (clampLevel (l t) (u t) c)^2 ∂μ) :
    z =ᵐ[μ] (fun t => clampLevel (l t) (u t) c) := by
  have h := clampEnergyGap hbox hz hw hz₂ hw₂ hd₂ hmean
  rw [heq] at h
  have hnon : 0 ≤ᵐ[μ] (fun t => (z t - clampLevel (l t) (u t) c)^2) :=
    Filter.Eventually.of_forall (fun t => sq_nonneg _)
  have hzero : ∫ t, (z t - clampLevel (l t) (u t) c)^2 ∂μ = 0 :=
    le_antisymm (by linarith) (integral_nonneg_of_ae hnon)
  have hae := (integral_eq_zero_iff_of_nonneg_ae hnon hd₂).1 hzero
  filter_upwards [hae] with t ht
  exact sub_eq_zero.mp (sq_eq_zero_iff.mp ht)

/-- The free-terminal certificate with a fixed affine displacement. A
pointwise first-variation bound `b(t) * (s - r)` cancels the linear
terms when `∫ b = 2*c*q - 2*p*r`. Here `s` and `r` are the competitor
and candidate terminal values, and `q` is the terminal displacement factor. -/
theorem freeTerminalEnergyGap
    {w b : α → ℝ} {p q s r : ℝ}
    (hz : Integrable z μ) (hw : Integrable w μ) (hb : Integrable b μ)
    (hz₂ : Integrable (fun t => z t ^ 2) μ)
    (hw₂ : Integrable (fun t => w t ^ 2) μ)
    (hd₂ : Integrable (fun t => (z t - w t)^2) μ)
    (hmean : (∫ t, z t ∂μ) + q*s = (∫ t, w t ∂μ) + q*r)
    (hcancel : (∫ t, b t ∂μ) = 2*c*q - 2*p*r)
    (hvar : ∀ᵐ t ∂μ, b t * (s - r) ≤ 2*(w t - c)*(z t - w t)) :
    (∫ t, w t ^ 2 ∂μ) + p*r^2 +
      (∫ t, (z t - w t)^2 ∂μ) + p*(s-r)^2 ≤ (∫ t, z t ^ 2 ∂μ) + p*s^2 := by
  have hzw₂ : Integrable (fun t => z t ^ 2 - w t ^ 2) μ := hz₂.sub hw₂
  have hout : Integrable (fun t => z t ^ 2 - w t ^ 2 - (z t - w t)^2) μ :=
    hzw₂.sub hd₂
  have hlin : Integrable (fun t => 2*c*(z t - w t)) μ :=
    (hz.sub hw).const_mul _
  have htail : Integrable (fun t => b t * (s - r)) μ := hb.mul_const _
  have hab : (fun t => 2*c*(z t - w t) + b t * (s-r)) ≤ᵐ[μ]
      (fun t => z t ^ 2 - w t ^ 2 - (z t - w t)^2) := by
    filter_upwards [hvar] with t ht
    nlinarith only [ht]
  have hsum : Integrable (fun t => 2*c*(z t - w t) + b t * (s-r)) μ :=
    hlin.add htail
  have h := integral_mono_ae hsum hout hab
  have harea : (∫ t, z t ∂μ) - (∫ t, w t ∂μ) = -q*(s-r) := by
    nlinarith only [hmean]
  rw [integral_add hlin htail, integral_const_mul, integral_sub hz hw, harea,
    integral_mul_const, hcancel, integral_sub hzw₂ hd₂, integral_sub hz₂ hw₂] at h
  nlinarith only [h]

end TrapCertificate

#print axioms TrapCertificate.clampNormal
#print axioms TrapCertificate.clampEnergyGap
#print axioms TrapCertificate.clampEnergyUnique
#print axioms TrapCertificate.freeTerminalEnergyGap
