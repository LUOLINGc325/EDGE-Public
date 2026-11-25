import SuperEndpointBounds
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics

/-! The exact optimized saturation limit and an explicit attaining asymptotic scale. -/

open scoped Topology
open Filter

namespace RenyiProductOrderPhase

theorem super_endpoint_time_tendsto_zero {M r : ℝ} (hr : M < r) (ell : ℝ) :
    Tendsto (fun n : ℕ => superEndpointTime M r ell (n + 1)) atTop (𝓝 0) := by
  have hS : Tendsto (fun n : ℕ => n + 1) atTop atTop := tendsto_atTop.2 fun m =>
    (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n))
  have hN : Tendsto (fun n : ℕ => ((n + 1 : ℕ) : ℝ)) atTop atTop :=
    tendsto_natCast_atTop_atTop.comp hS
  have hA := (tendsto_rpow_mul_exp_neg_mul_atTop_nhds_zero
    (1 : ℝ) (r - M) (sub_pos.mpr hr)).comp hN
  have hR : Tendsto (fun n : ℕ => 2 * ((n + 1 : ℕ) : ℝ) * ell /
      Real.exp (((n + 1 : ℕ) : ℝ) * (r - M))) atTop (𝓝 0) := by
    have hB := hA.const_mul (2 * ell)
    have hEq (n : ℕ) : (2 * ell) * ((((n + 1 : ℕ) : ℝ) ^ (1 : ℝ)) *
        Real.exp (-(r - M) * ((n + 1 : ℕ) : ℝ))) =
        2 * ((n + 1 : ℕ) : ℝ) * ell / Real.exp (((n + 1 : ℕ) : ℝ) * (r - M)) := by
      rw [Real.rpow_one, neg_mul, mul_comm (r - M), Real.exp_neg, div_eq_mul_inv]
      ring
    simpa only [Function.comp_apply, mul_zero, hEq] using hB
  simpa only [superEndpointTime, Real.sqrt_zero] using hR.sqrt

theorem super_endpoint_reference_mass_tendsto_one {M r : ℝ} (hr : M < r) (ell : ℝ) :
    Tendsto (fun n : ℕ => priorWeight (superEndpointPrior M r ell (n + 1))) atTop (𝓝 1) := by
  have hU := (super_endpoint_time_tendsto_zero hr ell).neg
  have h := (Real.continuous_exp.tendsto (0 : ℝ)).comp
    (show Tendsto (fun n : ℕ => -superEndpointTime M r ell (n + 1)) atTop (𝓝 0) by
      simpa only [neg_zero] using hU)
  have hEq (n : ℕ) : Real.exp (-superEndpointTime M r ell (n + 1)) =
      priorWeight (superEndpointPrior M r ell (n + 1)) := by
    unfold priorWeight superEndpointPrior
    rw [show 1 + (Real.exp (superEndpointTime M r ell (n + 1)) - 1) =
      Real.exp (superEndpointTime M r ell (n + 1)) by ring, Real.exp_neg]
  have hFn : (Real.exp ∘ fun n : ℕ => -superEndpointTime M r ell (n + 1)) =
      fun n => priorWeight (superEndpointPrior M r ell (n + 1)) := funext hEq
  rw [hFn, Real.exp_zero] at h
  exact h

variable {κ : Type*} [Fintype κ]

theorem super_endpoint_optimized_saturation (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {M r : ℝ} (hM₀ : 0 ≤ M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hAtom : 0 < endpointAtomMass p q M) (hAtom' : endpointAtomMass p q M < 1)
    (hr : M < r) :
    Tendsto (fun n : ℕ => sInf (productDeficitValues p q (n + 1)
      (Real.exp (((n + 1 : ℕ) : ℝ) * r))) / endpointEpsilon M (n + 1)) atTop (𝓝 1) := by
  let ell := endpointLogRate p q M
  let U (n : ℕ) := superEndpointTime M r ell (n + 1)
  have hU : Tendsto U atTop (𝓝 0) := super_endpoint_time_tendsto_zero hr ell
  have hEll : 0 < ell := neg_pos.mpr (Real.log_neg hAtom hAtom')
  have hUpper : Tendsto (fun n : ℕ => U n / 2 + Real.exp (U n)) atTop (𝓝 1) := by
    simpa only [Function.comp_apply, zero_div, Real.exp_zero, zero_add] using
      (hU.div_const 2).add ((Real.continuous_exp.tendsto _).comp hU)
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le
    (show Tendsto (fun _ : ℕ => (1 : ℝ)) atTop (𝓝 1) from tendsto_const_nhds) hUpper
  · intro n
    exact (super_endpoint_quantitative_bound p q hp hq hne hM₀ hM hAtom hAtom'
      (r := r) (Nat.succ_pos n)).1
  · intro n
    have h := super_endpoint_quantitative_bound p q hp hq hne hM₀ hM hAtom hAtom'
      (r := r) (Nat.succ_pos n)
    exact h.2.1.trans (h.2.2.trans (add_le_add_left
      (exp_sub_one_div_upper (super_endpoint_time_pos hEll (Nat.succ_pos n))) _))

end RenyiProductOrderPhase
