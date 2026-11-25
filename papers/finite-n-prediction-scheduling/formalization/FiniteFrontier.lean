import Lean
import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

/-!
Algebraic core of the finite-n prediction-scheduling construction.

Scope: the actual finite frozen-cost functional, its cone/concavity properties,
finite positive combinations of feasible endpoint data, and preservation of an
endpoint invariant throughout a line segment. This file does not formalize the
continuous-time scheduling semantics, unit-profile optimality, or monotonicity
of the unit-instance frontier in the number of jobs.

The ordered double sum includes the diagonal. Therefore the correct formula
is (sum v + sum_i sum_j min(v_i,v_j))/2, not sum v + (double sum)/2.
-/

open scoped BigOperators

namespace FiniteFrontier

theorem min_superadditive (a b c d : ℝ) :
    min a b + min c d ≤ min (a + c) (b + d) := by
  exact le_min (add_le_add (min_le_left a b) (min_le_left c d))
    (add_le_add (min_le_right a b) (min_le_right c d))

theorem min_nonneg_scale (c : ℝ) (hc : 0 ≤ c) (a b : ℝ) :
    min (c * a) (c * b) = c * min a b := by
  exact (mul_min_of_nonneg a b hc).symm

variable {ι : Type*} [Fintype ι]

/-- The frozen SPT cost, using an ordered pair sum that includes its diagonal. -/
noncomputable def frozenCost (v : ι → ℝ) : ℝ :=
  ((∑ i, v i) + ∑ i, ∑ j, min (v i) (v j)) / 2

theorem frozen_zero : frozenCost (fun _ : ι => 0) = 0 := by
  simp [frozenCost]

theorem frozen_nonneg (v : ι → ℝ) (hv : ∀ i, 0 ≤ v i) :
    0 ≤ frozenCost v := by
  apply div_nonneg
  · exact add_nonneg (Finset.sum_nonneg fun i _ => hv i)
      (Finset.sum_nonneg fun i _ =>
        Finset.sum_nonneg fun j _ => le_min (hv i) (hv j))
  · norm_num

theorem frozen_nonneg_scale (c : ℝ) (hc : 0 ≤ c) (v : ι → ℝ) :
    frozenCost (fun i => c * v i) = c * frozenCost v := by
  unfold frozenCost
  simp_rw [min_nonneg_scale c hc, ← Finset.mul_sum]
  ring

theorem frozen_superadditive (v w : ι → ℝ) :
    frozenCost v + frozenCost w ≤ frozenCost (fun i => v i + w i) := by
  have hpair :
      (∑ i, ∑ j, min (v i) (v j)) + (∑ i, ∑ j, min (w i) (w j)) ≤
        ∑ i, ∑ j, min (v i + w i) (v j + w j) := by
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_le_sum
    intro i hi
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_le_sum fun j _ =>
      min_superadditive (v i) (v j) (w i) (w j)
  unfold frozenCost
  rw [Finset.sum_add_distrib]
  linarith

theorem frozen_concave (v w : ι → ℝ) (θ : ℝ)
    (hθ0 : 0 ≤ θ) (hθ1 : θ ≤ 1) :
    (1 - θ) * frozenCost v + θ * frozenCost w ≤
      frozenCost (fun i => (1 - θ) * v i + θ * w i) := by
  have h := frozen_superadditive (fun i => (1 - θ) * v i) (fun i => θ * w i)
  rw [frozen_nonneg_scale (1 - θ) (sub_nonneg.mpr hθ1),
    frozen_nonneg_scale θ hθ0] at h
  exact h

theorem frozen_uniform (n : ℕ) (c : ℝ) :
    frozenCost (fun _ : Fin n => c) = (n : ℝ) * ((n : ℝ) + 1) * c / 2 := by
  simp [frozenCost]
  ring

variable {α : Type*}

theorem frozen_sum_superadditive (s : Finset α) (v : α → ι → ℝ) :
    (∑ a ∈ s, frozenCost (v a)) ≤
      frozenCost (fun i => ∑ a ∈ s, v a i) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp [frozen_zero]
  | @insert a s ha ih =>
    simp only [Finset.sum_insert ha]
    exact (add_le_add_left ih (frozenCost (v a))).trans
      (frozen_superadditive (v a) (fun i => ∑ b ∈ s, v b i))

theorem frozen_weighted_sum_superadditive (s : Finset α)
    (weights : α → ℝ) (v : α → ι → ℝ)
    (hw : ∀ a ∈ s, 0 ≤ weights a) :
    (∑ a ∈ s, weights a * frozenCost (v a)) ≤
      frozenCost (fun i => ∑ a ∈ s, weights a * v a i) := by
  calc
    (∑ a ∈ s, weights a * frozenCost (v a)) =
        ∑ a ∈ s, frozenCost (fun i => weights a * v a i) := by
      apply Finset.sum_congr rfl
      intro a ha
      exact (frozen_nonneg_scale (weights a) (hw a ha) (v a)).symm
    _ ≤ frozenCost (fun i => ∑ a ∈ s, weights a * v a i) :=
      frozen_sum_superadditive s (fun a i => weights a * v a i)

/-- The robustness inequality is preserved by any finite nonnegative combination.
The costs and elapsed-service vectors are explicit data, not a conclusion hidden
inside a structure or an asserted optimality premise. -/
theorem weighted_snapshot_invariant (s : Finset α)
    (weights costs : α → ℝ) (v : α → ι → ℝ) (R : ℝ)
    (hR : 0 ≤ R) (hw : ∀ a ∈ s, 0 ≤ weights a)
    (hfeasible : ∀ a ∈ s, costs a ≤ R * frozenCost (v a)) :
    (∑ a ∈ s, weights a * costs a) ≤
      R * frozenCost (fun i => ∑ a ∈ s, weights a * v a i) := by
  calc
    (∑ a ∈ s, weights a * costs a) ≤
        ∑ a ∈ s, weights a * (R * frozenCost (v a)) := by
      exact Finset.sum_le_sum fun a ha =>
        mul_le_mul_of_nonneg_left (hfeasible a ha) (hw a ha)
    _ = R * ∑ a ∈ s, weights a * frozenCost (v a) := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro a ha
      ring
    _ ≤ R * frozenCost (fun i => ∑ a ∈ s, weights a * v a i) :=
      mul_le_mul_of_nonneg_left (frozen_weighted_sum_superadditive s weights v hw) hR

/-- Endpoint feasibility suffices throughout a linearly interpolated phase. -/
theorem segment_invariant (v w : ι → ℝ) (F G R θ : ℝ)
    (hR : 0 ≤ R) (hθ0 : 0 ≤ θ) (hθ1 : θ ≤ 1)
    (hF : F ≤ R * frozenCost v) (hG : G ≤ R * frozenCost w) :
    (1 - θ) * F + θ * G ≤
      R * frozenCost (fun i => (1 - θ) * v i + θ * w i) := by
  calc
    (1 - θ) * F + θ * G ≤
        (1 - θ) * (R * frozenCost v) + θ * (R * frozenCost w) :=
      add_le_add (mul_le_mul_of_nonneg_left hF (sub_nonneg.mpr hθ1))
        (mul_le_mul_of_nonneg_left hG hθ0)
    _ = R * ((1 - θ) * frozenCost v + θ * frozenCost w) := by ring
    _ ≤ R * frozenCost (fun i => (1 - θ) * v i + θ * w i) :=
      mul_le_mul_of_nonneg_left (frozen_concave v w θ hθ0 hθ1) hR

end FiniteFrontier

#print axioms FiniteFrontier.min_superadditive
#print axioms FiniteFrontier.min_nonneg_scale
#print axioms FiniteFrontier.frozenCost
#print axioms FiniteFrontier.frozen_zero
#print axioms FiniteFrontier.frozen_nonneg
#print axioms FiniteFrontier.frozen_nonneg_scale
#print axioms FiniteFrontier.frozen_superadditive
#print axioms FiniteFrontier.frozen_concave
#print axioms FiniteFrontier.frozen_uniform
#print axioms FiniteFrontier.frozen_sum_superadditive
#print axioms FiniteFrontier.frozen_weighted_sum_superadditive
#print axioms FiniteFrontier.weighted_snapshot_invariant
#print axioms FiniteFrontier.segment_invariant

-- Audit every declaration created in this module, including compiler auxiliaries.
open Lean in
run_cmd do
  let env ← getEnv
  let mut entries : Array (String × Array String) := #[]
  for (name, _) in env.constants.map₂.toList do
    let axioms ← Lean.collectAxioms name
    entries := entries.push (name.toString, axioms.map Name.toString)
  logInfo m!"EDEG_KERNEL_AXIOMS: {(toJson entries).compress}"
