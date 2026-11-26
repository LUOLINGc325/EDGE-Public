import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Topology.Algebra.InfiniteSum.Real

namespace UnknownGapAdaptationBoundaryResearchProof2

/-- Dyadic tail bound: a nonnegative series whose finite partial sums are uniformly
bounded by a constant is summable, with the infinite sum bounded by the same
constant. This is the precise convergence step needed after (20) in Lemma 4. -/
theorem dyadic_infinite_tail_bound (a : ℕ → ℝ)
    (hnonneg : ∀ k, 0 ≤ a k)
    (hbound : ∀ N : ℕ, (∑ k ∈ Finset.range N, a k) ≤ (Real.exp 1 - 2)⁻¹) :
    Summable a ∧ (∑' k, a k) ≤ (Real.exp 1 - 2)⁻¹ := by
  have hmono : Monotone fun N : ℕ => ∑ k ∈ Finset.range N, a k := by
    intro N M hNM
    apply Finset.sum_le_sum_of_subset_of_nonneg
    · intro x hx
      simp only [Finset.mem_range] at hx ⊢
      omega
    · intro x _ _
      exact hnonneg x
  have hbdd : BddAbove (Set.range fun N : ℕ => ∑ k ∈ Finset.range N, a k) := by
    refine ⟨(Real.exp 1 - 2)⁻¹, ?_⟩
    rintro _ ⟨N, rfl⟩
    exact hbound N
  have hsummable : Summable a :=
    summable_of_sum_range_le hnonneg (fun N => hbound N)
  refine ⟨hsummable, ?_⟩
  have htendsto : Filter.Tendsto (fun N : ℕ => ∑ k ∈ Finset.range N, a k)
      Filter.atTop (nhds (∑' k, a k)) :=
    hsummable.hasSum.tendsto_sum_nat
  exact le_of_tendsto htendsto (Filter.Eventually.of_forall hbound)

end UnknownGapAdaptationBoundaryResearchProof2
