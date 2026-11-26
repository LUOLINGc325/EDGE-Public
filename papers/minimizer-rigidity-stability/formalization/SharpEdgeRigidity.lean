import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Fintype.Fin
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace PolygonRigidityStability

/-- Under the scalar tightness condition in Section 2, vanishing error fixes
the closing scalar and every leg individually. -/
theorem individual_edge_rigidity
    {m : ℕ} (a c : Fin m → ℝ) (ac cc δ : ℝ)
    (h_tight : ac - ∑ i, a i = (m + 1 : ℝ) * δ)
    (h_sum : cc ≤ ∑ i, c i)
    (h_edge : ∀ i, c i ≤ a i + δ)
    (h_close : ac - δ ≤ cc) :
    cc = ac - δ ∧ ∀ i, c i = a i + δ := by
  let slack : Fin m → ℝ := fun i => a i + δ - c i
  have h_nonneg (i : Fin m) : 0 ≤ slack i := sub_nonneg.mpr (h_edge i)
  have h_total : ∑ i, slack i =
      (∑ i, a i) + (m : ℝ) * δ - (∑ i, c i) := by
    simp [slack, Finset.sum_sub_distrib, Finset.sum_add_distrib, nsmul_eq_mul]
  have h_target : ac - δ = (∑ i, a i) + (m : ℝ) * δ := by
    linarith [add_mul (m : ℝ) 1 δ]
  have h_zero : ∑ i, slack i = 0 := by
    have h_upper : ∑ i, slack i ≤ 0 := by linarith
    have h_lower : 0 ≤ ∑ i, slack i := Finset.sum_nonneg fun i _ => h_nonneg i
    exact le_antisymm h_upper h_lower
  refine ⟨by linarith, fun i => ?_⟩
  exact (sub_eq_zero.mp ((Finset.sum_eq_zero_iff_of_nonneg
    (fun j _ => h_nonneg j)).mp h_zero i (Finset.mem_univ i))).symm

end PolygonRigidityStability
