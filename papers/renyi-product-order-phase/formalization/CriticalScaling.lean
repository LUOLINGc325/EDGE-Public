import NormalizedLikelihood
import NegativeLogPriorShape
import SoftThresholdBounds

/-! Exact thresholds and likelihood coordinates in the growing KL window. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def criticalScale (p q : FiniteMass κ) (n : ℕ) : ℝ :=
  klSigma p q * Real.sqrt (n : ℝ)

noncomputable def criticalOrder (p q : FiniteMass κ) (ζ : ℝ) (n : ℕ) : ℝ :=
  Real.exp ((n : ℝ) * klMean p q + ζ * criticalScale p q n)

noncomputable def criticalPrior (p q : FiniteMass κ) (n : ℕ) (t : ℝ) : ℝ :=
  Real.exp (t * criticalScale p q n) - 1

noncomputable def criticalObjective (p q : FiniteMass κ) (ζ : ℝ) (n : ℕ) (t : ℝ) : ℝ :=
  negativeLogProductMoment p q n (criticalOrder p q ζ n) (criticalPrior p q n t) / t

theorem critical_scale_pos (p q : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (hq : ∀ i, 0 < q i) (hne : p ≠ q) {n : ℕ} (hn : 0 < n) :
    0 < criticalScale p q n :=
  mul_pos (kl_sigma_pos p q hp hq hne) (Real.sqrt_pos.2 (by exact_mod_cast hn))

theorem critical_scale_tendsto (p q : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (hq : ∀ i, 0 < q i) (hne : p ≠ q) :
    Tendsto (fun n : ℕ => criticalScale p q (n + 1)) atTop atTop := by
  have hS : Tendsto (fun n : ℕ => n + 1) atTop atTop := tendsto_atTop.2 fun m =>
    (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n))
  exact (nat_sqrt_tendsto_atTop.comp hS).const_mul_atTop (kl_sigma_pos p q hp hq hne)

theorem critical_order_tendsto (p q : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (hq : ∀ i, 0 < q i) (hne : p ≠ q) (ζ : ℝ) :
    Tendsto (fun n : ℕ => criticalOrder p q ζ (n + 1)) atTop atTop := by
  let D := klMean p q
  let σ := klSigma p q
  have hD : 0 < D := kl_mean_pos p q hp hq hne
  have hσ : 0 < σ := kl_sigma_pos p q hp hq hne
  have hS : Tendsto (fun n : ℕ => n + 1) atTop atTop := tendsto_atTop.2 fun m =>
    (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n))
  have hN : Tendsto (fun n : ℕ => ((n + 1 : ℕ) : ℝ)) atTop atTop :=
    tendsto_natCast_atTop_atTop.comp hS
  have hRoot := (nat_sqrt_tendsto_atTop.comp hS).eventually
    (eventually_ge_atTop (2 * (|ζ| * σ) / D))
  apply Real.tendsto_exp_atTop.comp
  have hLin := hN.const_mul_atTop (show 0 < D / 2 by positivity)
  apply tendsto_atTop.2
  intro M
  filter_upwards [hRoot, hLin.eventually (eventually_ge_atTop M)] with n hn hM
  let N : ℝ := ((n + 1 : ℕ) : ℝ)
  let R := Real.sqrt N
  have hN₀ : 0 ≤ N := by unfold N; positivity
  have hR₀ : 0 ≤ R := Real.sqrt_nonneg _
  have hSq : R ^ 2 = N := Real.sq_sqrt hN₀
  have hLower : -|ζ| * (σ * R) ≤ ζ * (σ * R) :=
    mul_le_mul_of_nonneg_right (neg_abs_le ζ) (mul_nonneg hσ.le hR₀)
  have hn₀ : 2 * (|ζ| * σ) ≤ R * D := (div_le_iff₀ hD).1 hn
  have hProd := mul_le_mul_of_nonneg_right hn₀ hR₀
  change M ≤ N * D + ζ * (σ * R)
  change M ≤ D / 2 * N at hM
  rw [show R * D * R = D * R ^ 2 by ring, hSq] at hProd
  nlinarith only [hLower, hProd, hM]

theorem critical_prior_positive (p q : FiniteMass κ) {n : ℕ} {t : ℝ}
    (hs : 0 < criticalScale p q n) (ht : 0 < t) : 0 < criticalPrior p q n t := by
  unfold criticalPrior
  exact sub_pos.mpr (by simpa only [Real.exp_zero] using Real.exp_lt_exp.mpr (mul_pos ht hs))

theorem critical_log_prior (p q : FiniteMass κ) (n : ℕ) (t : ℝ) :
    Real.log (1 + criticalPrior p q n t) = t * criticalScale p q n := by
  unfold criticalPrior
  rw [show 1 + (Real.exp (t * criticalScale p q n) - 1) =
    Real.exp (t * criticalScale p q n) by ring, Real.log_exp]

theorem critical_objective_exact_scale (p q : FiniteMass κ) (ζ : ℝ) (n : ℕ) {t : ℝ}
    (hs : 0 < criticalScale p q n) (ht : 0 < t) :
    criticalObjective p q ζ n t =
      criticalOrder p q ζ n * criticalScale p q n *
        productScalarDeficit p q n (criticalOrder p q ζ n) (criticalPrior p q n t) := by
  have hb : 0 < criticalOrder p q ζ n := Real.exp_pos _
  unfold criticalObjective negativeLogProductMoment productScalarDeficit
  rw [critical_log_prior]
  field_simp [hb.ne', hs.ne', ht.ne']
  ring

theorem critical_argument_exact (p q : FiniteMass κ) (ζ : ℝ) (n : ℕ) (t : ℝ)
    (hs : 0 < criticalScale p q n) (z : Fin n → κ) :
    let X := iidSum (fun i => standardizedLogLikelihood p q i / Real.sqrt (n : ℝ)) z
    let s := criticalScale p q n
    criticalOrder p q ζ n * criticalPrior p q n t * Real.exp (likelihoodSum p q z) =
      (1 - Real.exp (-(t * s))) * Real.exp (s * (ζ + t - X)) := by
  let X := iidSum (fun i => standardizedLogLikelihood p q i / Real.sqrt (n : ℝ)) z
  let s := criticalScale p q n
  have hX : X * s = -likelihoodSum p q z - (n : ℝ) * klMean p q :=
    (eq_div_iff hs.ne').1 (standardized_likelihood_block_exact p q n z)
  have hE : (n : ℝ) * klMean p q + ζ * s + likelihoodSum p q z = s * (ζ - X) := by
    nlinarith only [hX]
  change Real.exp ((n : ℝ) * klMean p q + ζ * s) * (Real.exp (t * s) - 1) *
      Real.exp (likelihoodSum p q z) = _
  calc
    _ = (Real.exp (t * s) - 1) * Real.exp ((n : ℝ) * klMean p q + ζ * s + likelihoodSum p q z) := by
      simp only [Real.exp_add]
      ring
    _ = (1 - Real.exp (-(t * s))) * Real.exp (s * (ζ + t - X)) := by
      rw [hE, show s * (ζ + t - X) = s * (ζ - X) + t * s by ring, Real.exp_add]
      have hW : Real.exp (-(t * s)) * Real.exp (t * s) = 1 := by
        rw [← Real.exp_add, neg_add_cancel, Real.exp_zero]
      calc
        _ = Real.exp (s * (ζ - X)) * (Real.exp (t * s) -
            Real.exp (-(t * s)) * Real.exp (t * s)) := by rw [hW]; ring
        _ = _ := by ring

theorem finite_sum_cdf_complement (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ) (x : ℝ) :
    finiteSumEvent p Y n (Ioi x) = 1 - finiteSumEvent p Y n (Iic x) := by
  classical
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let f (z : Fin n → κ) := (Iic x).indicator (fun _ => (1 : ℝ)) (iidSum Y z)
  let g (z : Fin n → κ) := (Ioi x).indicator (fun _ => (1 : ℝ)) (iidSum Y z)
  have h (z : Fin n → κ) : g z + f z = 1 := by
    rcases le_or_gt (iidSum Y z) x with hz | hz
    · unfold f g
      rw [indicator_of_mem (mem_Iic.mpr hz),
        indicator_of_not_mem (show iidSum Y z ∉ Ioi x from not_lt_of_ge hz), zero_add]
    · unfold f g
      rw [indicator_of_not_mem (show iidSum Y z ∉ Iic x from not_le_of_gt hz),
        indicator_of_mem (mem_Ioi.mpr hz), add_zero]
  have he := P.expect_add_functions g f
  simp only [h, P.expect_const] at he
  change P.expect g = 1 - P.expect f
  linarith only [he]

end RenyiProductOrderPhase
