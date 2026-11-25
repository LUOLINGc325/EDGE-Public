import KernelEnvelope
import GridApproximationError

/-! Replacing the actual growing-order kernel by its limit under the scaled finite law. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem uniform_growing_kernel_replacement (p : FiniteMass κ) (Y : κ → ℝ) (B : ℕ → ℝ)
    (hB : Tendsto B atTop atTop) {θ u C : ℝ}
    (hθ : 0 < θ) (hθ' : θ < 1) (hC : 0 ≤ C)
    (hConc : ∀ᶠ n : ℕ in atTop, ∀ x : ℝ,
      Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent p Y (n + 1) (Ico x (x + 1)) ≤ C)
    {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop, ∀ a ∈ Icc (0 : ℝ) u,
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * (FiniteMass.tensor (fun _ : Fin (n + 1) => p)).expect
          (fun x => growingLimitKernel a θ (iidSum Y x)) -
        Real.sqrt ((n + 1 : ℕ) : ℝ) * (FiniteMass.tensor (fun _ : Fin (n + 1) => p)).expect
          (fun x => growingTiltedKernel (B n) a θ (iidSum Y x))| < ε := by
  classical
  let c := min θ (1 - θ)
  have hc : 0 < c := lt_min hθ (sub_pos.mpr hθ')
  let A := max 1 u
  have hA : 0 ≤ A := zero_le_one.trans (le_max_left _ _)
  let W := C * (Real.exp c * ∑' j, exponentialGridWeight c j)
  have hW : 0 ≤ W := mul_nonneg hC (mul_nonneg (Real.exp_nonneg _) (tsum_nonneg (fun _ => Real.exp_nonneg _)))
  let δ := ε / (2 * (W + 1))
  let η := ε / (2 * (A + 1))
  have hD : 0 < 2 * (W + 1) := by positivity
  have hE : 0 < 2 * (A + 1) := by positivity
  have hδ : 0 < δ := div_pos hε hD
  have hη : 0 < η := div_pos hε hE
  obtain ⟨K, hK, hTail⟩ := exponential_scaled_expectation_tails p Y hc hC hη
  let D := Real.exp (θ * K) * (u * Real.exp K) ^ 2
  have hD₀ : 0 ≤ D := by unfold D; positivity
  let T := max 1 ((D * Real.exp (c * K)) / δ)
  have hEventually : ∀ᶠ n in atTop, T ≤ B n := hB.eventually (eventually_ge_atTop T)
  filter_upwards [hConc, hEventually] with n hn hBN
  intro a ha
  let r := Real.sqrt ((n + 1 : ℕ) : ℝ)
  let P := FiniteMass.tensor (fun _ : Fin (n + 1) => p)
  have hR : 0 ≤ r := Real.sqrt_nonneg _
  have hb : 1 ≤ B n := (le_max_left _ _).trans hBN
  have hb₀ : 0 < B n := zero_lt_one.trans_le hb
  have hCoef : (D * Real.exp (c * K)) / B n ≤ δ := by
    have h := (div_le_iff₀ hδ).1 ((le_max_right _ _).trans hBN)
    apply (div_le_iff₀ hb₀).2
    exact h.trans_eq (mul_comm _ _)
  let f (s : ℝ) := growingLimitKernel a θ s
  let g (s : ℝ) := growingTiltedKernel (B n) a θ s
  let Tail (s : ℝ) := if K ≤ |s| then exponentialEnvelope c s else 0
  have hGap (s : ℝ) : 0 ≤ f s - g s := by
    unfold f g growingLimitKernel growingTiltedKernel growingLimitGap
    rw [← mul_sub]
    exact mul_nonneg (Real.exp_nonneg _) (normalized_gap_exp_error hb (mul_nonneg ha.1 (Real.exp_nonneg s))).1
  have hBound (s : ℝ) : |f s - g s| ≤ δ * exponentialEnvelope c s + A * Tail s := by
    rw [abs_of_nonneg (hGap s)]
    by_cases hs : K ≤ |s|
    · have hF := growing_limit_kernel_envelope ha.1 ha.2 (θ := θ) s
      have hG := growing_tilted_kernel_envelope ha.1 ha.2 hb (θ := θ) s
      unfold Tail
      rw [if_pos hs]
      have hUF : f s ≤ A * exponentialEnvelope c s := by
        simpa only [f, A, c, exponentialEnvelope, neg_mul] using hF.2
      exact (sub_le_self _ hG.1).trans (hUF.trans (le_add_of_nonneg_left
        (mul_nonneg hδ.le (Real.exp_nonneg _))))
    · have hK' : |s| ≤ K := (lt_of_not_ge hs).le
      have hh := (growing_tilted_kernel_compact_error ha.1 ha.2 hθ.le hb hK').2
      have hGain : 1 ≤ Real.exp (c * K) * exponentialEnvelope c s := by
        unfold exponentialEnvelope
        rw [← Real.exp_add, ← Real.exp_zero, Real.exp_le_exp]
        nlinarith only [mul_le_mul_of_nonneg_left hK' hc.le]
      unfold Tail
      rw [if_neg hs, mul_zero, add_zero]
      calc
        _ ≤ D / B n := hh
        _ ≤ (D / B n) * (Real.exp (c * K) * exponentialEnvelope c s) :=
          le_mul_of_one_le_right (div_nonneg hD₀ hb₀.le) hGain
        _ = ((D * Real.exp (c * K)) / B n) * exponentialEnvelope c s := by ring
        _ ≤ _ := mul_le_mul_of_nonneg_right hCoef (Real.exp_nonneg _)
  have hWn : r * P.expect (fun x => exponentialEnvelope c (iidSum Y x)) ≤ W :=
    exponential_scaled_expectation_bound p Y hc hC hn
  have hTn : r * P.expect (fun x => Tail (iidSum Y x)) ≤ η := (hTail (n + 1) hn).le
  have hTotal : δ * W + A * η < ε := by
    have hI : 2 * (W + 1) * δ = ε := mul_div_cancel₀ _ hD.ne'
    have hJ : 2 * (A + 1) * η = ε := mul_div_cancel₀ _ hE.ne'
    nlinarith only [hI, hJ, hδ, hη]
  change |r * P.expect (fun x => f (iidSum Y x)) - r * P.expect (fun x => g (iidSum Y x))| < ε
  rw [← mul_sub, abs_mul, abs_of_nonneg hR]
  calc
    _ ≤ r * P.expect (fun x => |f (iidSum Y x) - g (iidSum Y x)|) :=
      mul_le_mul_of_nonneg_left (P.abs_expect_sub_le _ _) hR
    _ ≤ r * P.expect (fun x => δ * exponentialEnvelope c (iidSum Y x) + A * Tail (iidSum Y x)) :=
      mul_le_mul_of_nonneg_left (P.expect_mono (fun x => hBound (iidSum Y x))) hR
    _ = δ * (r * P.expect (fun x => exponentialEnvelope c (iidSum Y x))) +
        A * (r * P.expect (fun x => Tail (iidSum Y x))) := by
      rw [FiniteMass.expect_add_functions, FiniteMass.expect_scale_function, FiniteMass.expect_scale_function]
      ring
    _ ≤ δ * W + A * η := add_le_add (mul_le_mul_of_nonneg_left hWn hδ.le)
      (mul_le_mul_of_nonneg_left hTn hA)
    _ < ε := hTotal

end RenyiProductOrderPhase
