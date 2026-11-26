import WeightedMixture
import Mathlib.Topology.Order.DenselyOrdered
import Mathlib.Tactic.FunProp
import Mathlib.Topology.Algebra.Ring.Real
import Mathlib.Topology.Algebra.Order.Field

open Filter Set
open scoped Topology

namespace RandomizedTwoJobRobustness

/-- For a law already supported on the three optimal shares, the virtual-time bound
on strictly positive sizes determines all three probabilities (Section 5). -/
theorem three_share_law_unique {A B p₀ p₁ pₕ : ℝ}
    (hA : 0 < A) (hB : 0 < B) (hsum : p₀ + p₁ + pₕ = 1)
    (hbound : ∀ u v : ℝ, 0 < u → 0 < v →
      p₀ * v + p₁ * u + 2 * pₕ * min u v ≤
        min u v + (A * u + B * v + min u v) / D A B) :
    p₀ = pB A B ∧ p₁ = pA A B ∧ pₕ = pS A B := by
  have hleftL : ContinuousAt
      (fun u => p₀ * 1 + p₁ * u + 2 * pₕ * min u 1) (0 : ℝ) := by fun_prop
  have hleftR : ContinuousAt
      (fun u => min u 1 + (A * u + B * 1 + min u 1) / D A B) (0 : ℝ) := by fun_prop
  have hrightL : ContinuousAt
      (fun v => p₀ * v + p₁ * 1 + 2 * pₕ * min 1 v) (0 : ℝ) := by fun_prop
  have hrightR : ContinuousAt
      (fun v => min 1 v + (A * 1 + B * v + min 1 v) / D A B) (0 : ℝ) := by fun_prop
  have hpos : ∀ᶠ t in 𝓝[Ioi (0 : ℝ)] 0, 0 < t := eventually_mem_nhdsWithin
  have hleft0 := le_of_tendsto_of_tendsto
    hleftL.continuousWithinAt hleftR.continuousWithinAt
    (hpos.mono fun u hu => hbound u 1 hu zero_lt_one)
  have hright0 := le_of_tendsto_of_tendsto
    hrightL.continuousWithinAt hrightR.continuousWithinAt
    (hpos.mono fun v hv => hbound 1 v zero_lt_one hv)
  have h₀ : p₀ ≤ pB A B := by simpa [pB] using hleft0
  have h₁ : p₁ ≤ pA A B := by simpa [pA] using hright0
  have hdiag := hbound 1 1 zero_lt_one zero_lt_one
  simp only [mul_one, min_self] at hdiag
  have hₕ : pₕ ≤ pS A B := by
    unfold pS
    linarith
  have hcaps := probs_sum_one hA hB
  exact ⟨by linarith, by linarith, by linarith⟩

end RandomizedTwoJobRobustness
