import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Lean.Elab.Tactic.Omega

namespace PolygonRigidityStability

open Finset

/-- Equation (2): abstract scalar triangle defect for a tight chain.
`a k` are adjacent target distances, `ac` the target closing distance,
`c k` and `cc` the corresponding tested (expected) distances.
Tightness of the chain with defect `δ` is
`ac - ∑ a = (m+1)δ`.  Under `|c k - a k| ≤ δ + ε`, `|ac - cc| ≤ δ + ε`,
and homogeneity `cc ≤ ∑ c`, the chain defect of `c` is nonnegative and at
most `(m+1)ε`. -/
theorem scalar_triangle_defect
    (m : ℕ) (a c : ℕ → ℝ) (ac cc δ ε : ℝ)
    (hδ : 0 ≤ δ) (hε : 0 ≤ ε)
    (htight : ac - ∑ k ∈ range m, a k = ((m + 1 : ℕ) : ℝ) * δ)
    (hedge : ∀ k ∈ range m, |c k - a k| ≤ δ + ε)
    (hclose : |ac - cc| ≤ δ + ε)
    (hhom : cc ≤ ∑ k ∈ range m, c k) :
    0 ≤ (∑ k ∈ range m, c k) - cc ∧
      (∑ k ∈ range m, c k) - cc ≤ ((m + 1 : ℕ) : ℝ) * ε := by
  have hm_nonneg : (0 : ℝ) ≤ (m : ℕ) := by positivity
  have hstep_abs : |(∑ k ∈ range m, c k) - (∑ k ∈ range m, a k)|
      ≤ (m : ℕ) * (δ + ε) := by
    have hsplit : (∑ k ∈ range m, c k) - (∑ k ∈ range m, a k)
        = ∑ k ∈ range m, (c k - a k) := by
      rw [sum_sub_distrib]
    rw [hsplit]
    calc |∑ k ∈ range m, (c k - a k)|
        ≤ ∑ k ∈ range m, |c k - a k| := abs_sum_le_sum_abs _ _
      _ ≤ ∑ _k ∈ range m, (δ + ε) := sum_le_sum (fun k hk => hedge k hk)
      _ = (m : ℕ) * (δ + ε) := by rw [sum_const, card_range, nsmul_eq_mul]
  have habs_close : -(δ + ε) ≤ ac - cc := neg_le_of_abs_le hclose
  have habs_close' : ac - cc ≤ δ + ε := le_of_abs_le hclose
  have htight' : ac - ∑ k ∈ range m, a k = ((m + 1 : ℕ) : ℝ) * δ := htight
  have hcast : ((m + 1 : ℕ) : ℝ) = (m : ℕ) + 1 := by push_cast; ring
  have hkey : (∑ k ∈ range m, c k) - cc
      = ((∑ k ∈ range m, c k) - (∑ k ∈ range m, a k)) + (ac - cc)
        - ((m + 1 : ℕ) : ℝ) * δ := by
    linarith
  constructor
  · have h1 : -((m : ℕ) * (δ + ε)) ≤ (∑ k ∈ range m, c k) - (∑ k ∈ range m, a k) :=
      neg_le_of_abs_le hstep_abs
    have hexpand : (m : ℕ) * (δ + ε) = (m : ℕ) * δ + (m : ℕ) * ε := by ring
    nlinarith [hm_nonneg, hδ, hε]
  · have h1 : (∑ k ∈ range m, c k) - (∑ k ∈ range m, a k) ≤ (m : ℕ) * (δ + ε) :=
      le_of_abs_le hstep_abs
    have hexpand : (m : ℕ) * (δ + ε) = (m : ℕ) * δ + (m : ℕ) * ε := by ring
    nlinarith [hm_nonneg, hδ, hε]

/-- Exact closing edge value at `ε = 0`: the tested closing scalar equals
`ac - δ`. -/
theorem exact_closing_eq
    (m : ℕ) (a c : ℕ → ℝ) (ac cc δ : ℝ)
    (hδ : 0 ≤ δ)
    (htight : ac - ∑ k ∈ range m, a k = ((m + 1 : ℕ) : ℝ) * δ)
    (hedge : ∀ k ∈ range m, |c k - a k| ≤ δ)
    (hclose : |ac - cc| ≤ δ)
    (hhom : cc ≤ ∑ k ∈ range m, c k) :
    (∑ k ∈ range m, c k) - cc = 0 ∧ cc = ac - δ := by
  have hdef := scalar_triangle_defect m a c ac cc δ 0 hδ le_rfl htight
    (fun k hk => by linarith [hedge k hk]) (by simpa using hclose) hhom
  have hnonneg : 0 ≤ (∑ k ∈ range m, c k) - cc := hdef.1
  have hupper : (∑ k ∈ range m, c k) - cc ≤ 0 := by
    simpa using hdef.2
  have hzero : (∑ k ∈ range m, c k) - cc = 0 := le_antisymm hupper hnonneg
  have hcc_eq_sum : cc = ∑ k ∈ range m, c k := by linarith
  have hstep_abs : |(∑ k ∈ range m, c k) - (∑ k ∈ range m, a k)| ≤ (m : ℕ) * δ := by
    have hsplit : (∑ k ∈ range m, c k) - (∑ k ∈ range m, a k)
        = ∑ k ∈ range m, (c k - a k) := by rw [sum_sub_distrib]
    rw [hsplit]
    calc |∑ k ∈ range m, (c k - a k)|
        ≤ ∑ k ∈ range m, |c k - a k| := abs_sum_le_sum_abs _ _
      _ ≤ ∑ _k ∈ range m, δ := sum_le_sum (fun k hk => hedge k hk)
      _ = (m : ℕ) * δ := by rw [sum_const, card_range, nsmul_eq_mul]
  have hsum_ub : (∑ k ∈ range m, c k) ≤ (∑ k ∈ range m, a k) + (m : ℕ) * δ := by
    linarith [le_of_abs_le hstep_abs]
  have haeq : (∑ k ∈ range m, a k) = ac - ((m + 1 : ℕ) : ℝ) * δ := by linarith
  have hcast : ((m + 1 : ℕ) : ℝ) = (m : ℕ) + 1 := by push_cast; ring
  have hsum_ub' : (∑ k ∈ range m, c k) ≤ ac - δ := by nlinarith
  have hcc_ub : cc ≤ ac - δ := by rw [hcc_eq_sum]; exact hsum_ub'
  have hlow : ac - δ ≤ cc := by
    have := le_of_abs_le hclose
    linarith
  exact ⟨hzero, le_antisymm hcc_ub hlow⟩

end PolygonRigidityStability
