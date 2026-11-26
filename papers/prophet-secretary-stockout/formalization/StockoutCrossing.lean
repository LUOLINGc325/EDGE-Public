import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# Finite calibrated crossing comparison

This file verifies the finite signed-sequence core of the stockout comparison.
It does not formalize Newton inequalities, relative log-concavity, Poisson
probabilities, infinite summation, or the stochastic online-allocation model.

The weak nonnegative superlevel set, including zero entries, is assumed to be
an interval. Replacing this by an informal strict sign-change pattern would
miss the zero-prefix/zero-suffix cases.
-/

set_option autoImplicit false

open Finset

namespace StockoutCrossing

/-- Sum of the first `m` entries. All application theorems restrict `m ≤ N`. -/
noncomputable def prefixSum (d : ℕ → ℝ) (m : ℕ) : ℝ := ∑ i ∈ range m, d i

/-- The weak superlevel set `{i < N | 0 ≤ d i}` is order-convex. -/
def NonnegInterval (d : ℕ → ℝ) (N : ℕ) : Prop :=
  ∀ i j l : ℕ, i ≤ j → j ≤ l → l < N →
    0 ≤ d i → 0 ≤ d l → 0 ≤ d j

/-- Matching total mass and mass below an interior cut force all earlier
prefix sums to be nonpositive. The proof includes zero entries in the shape
condition and uses a nonnegative witness on the nonempty right side. -/
theorem calibrated_prefix_nonpos
    (d : ℕ → ℝ) (N k : ℕ)
    (hkN : k < N) (hshape : NonnegInterval d N)
    (htotal : prefixSum d N = 0) (hcut : prefixSum d k = 0)
    (m : ℕ) (hmk : m ≤ k) : prefixSum d m ≤ 0 := by
  have htail : (∑ i ∈ Ico k N, d i) = 0 := by
    rw [sum_Ico_eq_sub d hkN.le]
    change prefixSum d N - prefixSum d k = 0
    rw [htotal, hcut, sub_self]
  have htail_le : (∑ _i ∈ Ico k N, (0 : ℝ)) ≤ ∑ i ∈ Ico k N, d i := by
    simp [htail]
  obtain ⟨l, hl, hdl⟩ :=
    exists_le_of_sum_le (nonempty_Ico.mpr hkN) htail_le
  by_contra hbad
  have hmpos : 0 < prefixSum d m := lt_of_not_ge hbad
  have hpossum : (∑ _i ∈ range m, (0 : ℝ)) < ∑ i ∈ range m, d i := by
    simpa [prefixSum] using hmpos
  obtain ⟨i, hi, hdi⟩ := exists_lt_of_sum_lt hpossum
  have hmid : (∑ j ∈ Ico m k, d j) < 0 := by
    rw [sum_Ico_eq_sub d hmk]
    change prefixSum d k - prefixSum d m < 0
    rw [hcut]
    linarith
  have hnegsum : (∑ j ∈ Ico m k, d j) < ∑ _j ∈ Ico m k, (0 : ℝ) := by
    simpa using hmid
  obtain ⟨j, hj, hdj⟩ := exists_lt_of_sum_lt hnegsum
  have hij : i ≤ j := by
    have hi' := mem_range.mp hi
    have hj' := (mem_Ico.mp hj).1
    omega
  have hjl : j ≤ l := by
    have hj' := (mem_Ico.mp hj).2
    have hl' := (mem_Ico.mp hl).1
    omega
  have hnonneg := hshape i j l hij hjl (mem_Ico.mp hl).2 hdi.le hdl
  linarith

/-- Matching total mass and mass below an interior cut force all later
prefix sums to be nonnegative. This time the nonempty left side supplies
the nonnegative witness. -/
theorem calibrated_prefix_nonneg
    (d : ℕ → ℝ) (N k : ℕ)
    (hkpos : 0 < k) (hshape : NonnegInterval d N)
    (htotal : prefixSum d N = 0) (hcut : prefixSum d k = 0)
    (m : ℕ) (hkm : k ≤ m) (hmN : m ≤ N) : 0 ≤ prefixSum d m := by
  have hleft_nonempty : (range k).Nonempty := ⟨0, mem_range.mpr hkpos⟩
  have hleft_le : (∑ _i ∈ range k, (0 : ℝ)) ≤ ∑ i ∈ range k, d i := by
    change (∑ _i ∈ range k, (0 : ℝ)) ≤ prefixSum d k
    simp [hcut]
  obtain ⟨i, hi, hdi⟩ := exists_le_of_sum_le hleft_nonempty hleft_le
  by_contra hbad
  have hmneg : prefixSum d m < 0 := lt_of_not_ge hbad
  have hmid : (∑ j ∈ Ico k m, d j) < 0 := by
    rw [sum_Ico_eq_sub d hkm]
    change prefixSum d m - prefixSum d k < 0
    rw [hcut, sub_zero]
    exact hmneg
  have hnegsum : (∑ j ∈ Ico k m, d j) < ∑ _j ∈ Ico k m, (0 : ℝ) := by
    simpa using hmid
  obtain ⟨j, hj, hdj⟩ := exists_lt_of_sum_lt hnegsum
  have htail : 0 < ∑ l ∈ Ico m N, d l := by
    rw [sum_Ico_eq_sub d hmN]
    change 0 < prefixSum d N - prefixSum d m
    rw [htotal]
    linarith
  have hpossum : (∑ _l ∈ Ico m N, (0 : ℝ)) < ∑ l ∈ Ico m N, d l := by
    simpa using htail
  obtain ⟨l, hl, hdl⟩ := exists_lt_of_sum_lt hpossum
  have hij : i ≤ j := by
    have hi' := mem_range.mp hi
    have hj' := (mem_Ico.mp hj).1
    omega
  have hjl : j ≤ l := by
    have hj' := (mem_Ico.mp hj).2
    have hl' := (mem_Ico.mp hl).1
    omega
  have hnonneg := hshape i j l hij hjl (mem_Ico.mp hl).2 hdi hdl.le
  linarith

/-- The complete finite calibrated CDF sign comparison. -/
theorem calibrated_prefix_sign
    (d : ℕ → ℝ) (N k : ℕ)
    (hkpos : 0 < k) (hkN : k < N) (hshape : NonnegInterval d N)
    (htotal : prefixSum d N = 0) (hcut : prefixSum d k = 0) :
    (∀ m : ℕ, m ≤ k → prefixSum d m ≤ 0) ∧
    (∀ m : ℕ, k ≤ m → m ≤ N → 0 ≤ prefixSum d m) := by
  constructor
  · exact fun m hm => calibrated_prefix_nonpos d N k hkN hshape htotal hcut m hm
  · exact fun m hkm hmN =>
      calibrated_prefix_nonneg d N k hkpos hshape htotal hcut m hkm hmN

/-- Finite summation by parts in a form which also works at `N=0`. -/
theorem weighted_sum_by_parts (d w : ℕ → ℝ) (N : ℕ) :
    (∑ i ∈ range N, w i * d i) =
      w N * prefixSum d N +
        ∑ i ∈ range N, (w i - w (i + 1)) * prefixSum d (i + 1) := by
  induction N with
  | zero => simp [prefixSum]
  | succ N ih =>
    rw [sum_range_succ, sum_range_succ, ih]
    have hp : prefixSum d (N + 1) = prefixSum d N + d N := by
      simp [prefixSum, sum_range_succ]
    rw [hp]
    ring

/-- A weight increasing strictly before the cut and decreasing strictly
after the cut has nonnegative signed expectation. The weight jump at the
cut is unrestricted because its calibrated prefix coefficient is zero.
The inequalities themselves are weak; constant weights are allowed. -/
theorem calibrated_weighted_sum_nonneg
    (d w : ℕ → ℝ) (N k : ℕ)
    (hkpos : 0 < k) (hkN : k < N) (hshape : NonnegInterval d N)
    (htotal : prefixSum d N = 0) (hcut : prefixSum d k = 0)
    (hwleft : ∀ i : ℕ, i + 1 < k → w i ≤ w (i + 1))
    (hwright : ∀ i : ℕ, k < i + 1 → i < N → w (i + 1) ≤ w i) :
    0 ≤ ∑ i ∈ range N, w i * d i := by
  rw [weighted_sum_by_parts, htotal, mul_zero, zero_add]
  apply sum_nonneg
  intro i hi
  rcases lt_trichotomy (i + 1) k with hlt | heq | hgt
  · exact mul_nonneg_of_nonpos_of_nonpos
      (sub_nonpos.mpr (hwleft i hlt))
      (calibrated_prefix_nonpos d N k hkN hshape htotal hcut (i + 1) hlt.le)
  · rw [heq, hcut, mul_zero]
  · exact mul_nonneg
      (sub_nonneg.mpr (hwright i hgt (mem_range.mp hi)))
      (calibrated_prefix_nonneg d N k hkpos hshape htotal hcut (i + 1) hgt.le
        (by have hi' := mem_range.mp hi; omega))

/-- A direct comparison of two finite mass sequences, with both equal-mass
conditions explicit. Nonnegative masses and normalization are not required
for this algebraic comparison; in the probability application they hold. -/
theorem calibrated_mass_weight_comparison
    (p q w : ℕ → ℝ) (N k : ℕ)
    (hkpos : 0 < k) (hkN : k < N)
    (hshape : ∀ i j l : ℕ, i ≤ j → j ≤ l → l < N →
      q i ≤ p i → q l ≤ p l → q j ≤ p j)
    (htotal : prefixSum p N = prefixSum q N)
    (hcut : prefixSum p k = prefixSum q k)
    (hwleft : ∀ i : ℕ, i + 1 < k → w i ≤ w (i + 1))
    (hwright : ∀ i : ℕ, k < i + 1 → i < N → w (i + 1) ≤ w i) :
    (∑ i ∈ range N, w i * q i) ≤ ∑ i ∈ range N, w i * p i := by
  have hs : NonnegInterval (fun i => p i - q i) N := by
    intro i j l hij hjl hl hi hh
    exact sub_nonneg.mpr
      (hshape i j l hij hjl hl (sub_nonneg.mp hi) (sub_nonneg.mp hh))
  have ht : prefixSum (fun i => p i - q i) N = 0 := by
    simp only [prefixSum, sum_sub_distrib]
    change prefixSum p N - prefixSum q N = 0
    rw [htotal, sub_self]
  have hc : prefixSum (fun i => p i - q i) k = 0 := by
    simp only [prefixSum, sum_sub_distrib]
    change prefixSum p k - prefixSum q k = 0
    rw [hcut, sub_self]
  have h := calibrated_weighted_sum_nonneg (fun i => p i - q i) w N k
    hkpos hkN hs ht hc hwleft hwright
  simp_rw [mul_sub] at h
  rw [sum_sub_distrib] at h
  exact sub_nonneg.mp h

end StockoutCrossing

#print axioms StockoutCrossing.calibrated_prefix_nonpos
#print axioms StockoutCrossing.calibrated_prefix_nonneg
#print axioms StockoutCrossing.calibrated_prefix_sign
#print axioms StockoutCrossing.weighted_sum_by_parts
#print axioms StockoutCrossing.calibrated_weighted_sum_nonneg
#print axioms StockoutCrossing.calibrated_mass_weight_comparison
