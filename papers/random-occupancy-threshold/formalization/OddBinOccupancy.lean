import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Nat.Basic
import Lean.Elab.Tactic.Omega

open scoped BigOperators

namespace RandomOccupancyThreshold

/-- Every bin contributes its maximal number of disjoint pairs and one leftover
precisely when its size is odd. This is the integer form of Equation (3). -/
theorem odd_bin_identity {ι : Type*} (bins : Finset ι) (counts : ι → ℕ) :
    (∑ i ∈ bins, counts i) =
      (∑ i ∈ bins, counts i % 2) + 2 * (∑ i ∈ bins, counts i / 2) := by
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  exact (Nat.mod_add_div (counts i) 2).symm

theorem occupancy_feasibility {ι : Type*} (bins : Finset ι) (counts : ι → ℕ)
    {n s : ℕ} (hn : 0 < n) (hs : s ≤ n)
    (hm : (∑ i ∈ bins, counts i) = 3*n-1) :
    n-s ≤ (∑ i ∈ bins, counts i / 2) ↔
      (∑ i ∈ bins, counts i % 2) ≤ n+2*s-1 := by
  have h := odd_bin_identity bins counts
  rw [hm] at h
  omega

end RandomOccupancyThreshold
