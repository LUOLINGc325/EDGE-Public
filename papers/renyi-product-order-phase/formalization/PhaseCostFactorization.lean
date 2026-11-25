import PeriodicPhaseProfile
import ArithmeticDeficitLimits
import GlobalPriorLimit

/-! The exact periodic factorization and compact sublevel sets of the moving-phase objective. -/

open Set

namespace RenyiProductOrderPhase

theorem exponential_gap_prior_translate (g : ℝ → ℝ) (θ s : ℝ) {a : ℝ} (ha : 0 < a) :
    Real.exp (-(θ * s)) * g (a * Real.exp s) =
      a ^ θ * (Real.exp (-(θ * (s + Real.log a))) * g (Real.exp (s + Real.log a))) := by
  have he : Real.exp (s + Real.log a) = a * Real.exp s := by
    rw [Real.exp_add, Real.exp_log ha, mul_comm]
  have hShift : -(θ * (s + Real.log a)) = -(θ * s) + -(θ * Real.log a) := by ring
  have hr : Real.exp (-(θ * Real.log a)) = (a ^ θ)⁻¹ := by
    rw [Real.exp_neg, Real.rpow_def_of_pos ha, mul_comm θ]
  rw [he, hShift, Real.exp_add, hr]
  symm
  calc
    _ = (a ^ θ * (a ^ θ)⁻¹) * (Real.exp (-(θ * s)) * g (a * Real.exp s)) := by ring
    _ = _ := by rw [mul_inv_cancel₀ (Real.rpow_pos_of_pos ha _).ne', one_mul]

theorem phase_moment_periodic_factorization {κ : Type*} [Fintype κ] {Y : κ → ℝ}
    (L : MaximalLattice Y) (v θ : ℝ) (g : ℝ → ℝ) (n : ℕ)
    {a c A : ℝ} (ha : 0 < a) (hc : 0 < c) (hA : 0 ≤ A)
    (hJ : ∀ s, |Real.exp (-(θ * s)) * g (Real.exp s)| ≤ A * exponentialEnvelope c s) :
    phaseMoment L v (fun a s => Real.exp (-(θ * s)) * g (a * Real.exp s)) n a =
      gaussianHeight v * a ^ θ *
        periodicKernelProfile L.span (fun s => Real.exp (-(θ * s)) * g (Real.exp s))
          (L.span * L.phase (n + 1) + Real.log a) := by
  let J (s : ℝ) := Real.exp (-(θ * s)) * g (Real.exp s)
  let shift := L.span * L.phase (n + 1) + Real.log a
  have hArg (j : ℤ) : L.phasePoint (n + 1) j + Real.log a = shift + L.span * (j : ℝ) := by
    unfold MaximalLattice.phasePoint shift
    ring
  have hPoint (j : ℤ) :
      Real.exp (-(θ * L.phasePoint (n + 1) j)) * g (a * Real.exp (L.phasePoint (n + 1) j)) =
        a ^ θ * J (shift + L.span * (j : ℝ)) := by
    rw [exponential_gap_prior_translate g θ (L.phasePoint (n + 1) j) ha]
    unfold J
    rw [hArg j]
  unfold phaseMoment periodicKernelProfile
  change (L.span * gaussianHeight v) *
    (∑' j : ℤ, Real.exp (-(θ * L.phasePoint (n + 1) j)) *
      g (a * Real.exp (L.phasePoint (n + 1) j))) =
    (gaussianHeight v * a ^ θ) * (L.span * (∑' j : ℤ, J (shift + L.span * (j : ℝ))))
  simp only [hPoint]
  rw [(periodic_kernel_series L.span_pos hc hA hJ shift).tsum_mul_left]
  ring

theorem compact_prior_cost_sublevel {θ C : ℝ} (hθ : 0 < θ) (hθ' : θ < 1) :
    ∃ l > 0, ∃ u > 0, ∀ a, 0 < a → priorCost θ a ≤ C → a ∈ Icc l u := by
  have hθ₁ : 0 < 1 - θ := sub_pos.mpr hθ'
  let S := (C + 1) / (1 - θ)
  let T := max 1 (8 * (C + 1) / θ ^ 2)
  let l := Real.exp (-S)
  let u := Real.exp T
  refine ⟨l, Real.exp_pos _, u, Real.exp_pos _, ?_⟩
  intro a ha hCost
  have hLog : 0 < Real.log (1 + a) := Real.log_pos (by linarith)
  have hA : 0 < a ^ θ := Real.rpow_pos_of_pos ha _
  constructor
  · apply le_of_not_ge
    intro hSmall
    have hS : S ≤ -Real.log a := by
      have h := Real.log_le_log ha hSmall
      change Real.log a ≤ Real.log (Real.exp (-S)) at h
      rw [Real.log_exp] at h
      linarith only [h]
    have hB : Real.exp ((1 - θ) * -Real.log a) ≤ priorCost θ a := by
      have hEq : Real.exp ((1 - θ) * -Real.log a) = (a ^ θ) / a := by
        rw [show (1 - θ) * -Real.log a = Real.log a * θ - Real.log a by ring,
          Real.exp_sub, ← Real.rpow_def_of_pos ha, Real.exp_log ha]
      rw [hEq]
      exact div_le_div_of_nonneg_left hA.le hLog (log_one_add_bounds ha.le).2
    have hThreshold : (1 - θ) * S = C + 1 := mul_div_cancel₀ _ hθ₁.ne'
    have hApprox := (Real.add_one_le_exp ((1 - θ) * S)).trans
      ((Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left hS hθ₁.le)).trans hB)
    rw [hThreshold] at hApprox
    linarith only [hApprox, hCost]
  · apply le_of_not_ge
    intro hLarge
    have ht : T ≤ Real.log a := by
      have h := Real.log_le_log (Real.exp_pos T) hLarge
      change Real.log (Real.exp T) ≤ Real.log a at h
      rwa [Real.log_exp] at h
    have ht₀ : 1 ≤ Real.log a := (le_max_left _ _).trans ht
    have ha₁ : 1 ≤ a := by
      rw [← Real.exp_zero, ← Real.exp_log ha, Real.exp_le_exp]
      exact zero_le_one.trans ht₀
    have hG := (exp_ratio_lower_linear hθ ht₀).trans
      (show Real.exp (θ * Real.log a) / (Real.log a + 1) ≤ priorCost θ a by
        rw [mul_comm θ, ← Real.rpow_def_of_pos ha]
        exact div_le_div_of_nonneg_left hA.le hLog (log_one_add_le_log_add_one ha₁))
    have ht' : 8 * (C + 1) ≤ Real.log a * θ ^ 2 :=
      (div_le_iff₀ (pow_pos hθ 2)).1 ((le_max_right _ _).trans ht)
    nlinarith only [hG, ht', hCost]

end RenyiProductOrderPhase
