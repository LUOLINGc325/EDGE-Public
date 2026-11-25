import FiniteRenyi
import Mathlib.Analysis.SpecialFunctions.Pow.Deriv
import Mathlib.Analysis.Calculus.Deriv.Slope

/-! The scalar deficit at the small-prior endpoint. -/

open scoped BigOperators Topology
open Set Filter

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem scalar_moment_at_zero (p q : FiniteMass κ) (b : ℝ) :
    scalarMoment p q b 0 = 1 := by
  simp only [scalarMoment, zero_mul, add_zero, Real.one_rpow, FiniteMass.expect_const]

theorem hasDerivAt_scalar_moment_zero (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (b : ℝ) :
    HasDerivAt (scalarMoment p q b) (-b) 0 := by
  let R (y : κ) := q y / p y
  have h (y : κ) : HasDerivAt (fun a : ℝ => p y * (1 + a * R y) ^ (-b))
      (p y * (R y * (-b))) 0 := by
    have hA : HasDerivAt (fun a : ℝ => 1 + a * R y) (R y) 0 := by
      simpa using (((hasDerivAt_id (0 : ℝ)).mul_const (R y)).const_add 1)
    simpa only [zero_mul, add_zero, Real.one_rpow, mul_one] using
      ((hA.rpow_const (p := -b) (Or.inl (by simp))).const_mul (p y))
  have hAll := HasDerivAt.sum (u := Finset.univ) (fun y _ => h y)
  convert hAll using 1
  calc
    -b = (p.expect R) * (-b) := by
      rw [show p.expect R = 1 from
        reference_expected_ratio q p (FiniteMass.absolutelyContinuous_of_pos q p hp), one_mul]
    _ = _ := by simp only [FiniteMass.expect, Finset.sum_mul, mul_assoc]

theorem scalar_deficit_tendsto_zero (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (b : ℝ) (hb : 0 < b) :
    Tendsto (scalarDeficit p q b) (𝓝[>] (0 : ℝ)) (𝓝 1) := by
  let L (a : ℝ) := -Real.log (scalarMoment p q b a)
  let U (a : ℝ) := b * Real.log (1 + a)
  have hL₀ : L 0 = 0 := by simp [L, scalar_moment_at_zero]
  have hU₀ : U 0 = 0 := by simp [U]
  have hL : HasDerivAt L b 0 := by
    have h := ((hasDerivAt_scalar_moment_zero p q hp b).log
      (by rw [scalar_moment_at_zero]; exact one_ne_zero)).neg
    simpa only [scalar_moment_at_zero, div_one, neg_neg, L] using h
  have hAffine : HasDerivAt (fun a : ℝ => 1 + a) 1 0 :=
    (hasDerivAt_id (0 : ℝ)).const_add 1
  have hU : HasDerivAt U b 0 := by
    have h := (hAffine.log (by norm_num)).const_mul b
    simpa only [add_zero, div_one, mul_one, U] using h
  have hL' : Tendsto (fun a : ℝ => a⁻¹ * L a) (𝓝[>] (0 : ℝ)) (𝓝 b) := by
    simpa only [zero_add, hL₀, sub_zero, smul_eq_mul] using hL.tendsto_slope_zero_right
  have hU' : Tendsto (fun a : ℝ => a⁻¹ * U a) (𝓝[>] (0 : ℝ)) (𝓝 b) := by
    simpa only [zero_add, hU₀, sub_zero, smul_eq_mul] using hU.tendsto_slope_zero_right
  have h := hL'.div hU' hb.ne'
  rw [div_self hb.ne'] at h
  refine h.congr' ?_
  have hpos : ∀ᶠ a : ℝ in 𝓝[>] (0 : ℝ), 0 < a := self_mem_nhdsWithin
  filter_upwards [hpos] with a ha
  change (a⁻¹ * L a) / (a⁻¹ * U a) = L a / U a
  exact mul_div_mul_left _ _ (inv_ne_zero ha.ne')

end RenyiProductOrderPhase
