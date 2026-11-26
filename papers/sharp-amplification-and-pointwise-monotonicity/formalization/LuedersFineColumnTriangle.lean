import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace SharpAmplificationAndPointwiseMonotonicityResearchProof1

/-- Theorem 1 proof step: the fine signed records in each column `j` sum to `-E * v j`,
so the triangle inequality in each column gives `(E/2) ∑_j |v j| ≤ (1/2) ∑_j ∑_i |D i j|`.
This is the finite-array column-sum bound, valid also when `E = 0`. -/
theorem fine_column_triangle {ι κ : Type*} [Fintype ι] [Fintype κ]
    (D : ι → κ → ℝ) (v : κ → ℝ) (E : ℝ) (hE : 0 ≤ E)
    (hcol : ∀ j, (∑ i, D i j) = -E * v j) :
    E / 2 * (∑ j, |v j|) ≤ (∑ j, ∑ i, |D i j|) / 2 := by
  have hterm : ∀ j, E * |v j| ≤ ∑ i, |D i j| := by
    intro j
    have h1 : |∑ i, D i j| ≤ ∑ i, |D i j| := Finset.abs_sum_le_sum_abs _ _
    have h2 : |∑ i, D i j| = E * |v j| := by
      rw [hcol j, abs_mul]
      simp [abs_neg, abs_of_nonneg hE]
    linarith [h1, h2]
  have hsum : E * (∑ j, |v j|) ≤ ∑ j, ∑ i, |D i j| := by
    calc E * (∑ j, |v j|) = ∑ j, E * |v j| := by rw [Finset.mul_sum]
      _ ≤ ∑ j, ∑ i, |D i j| := Finset.sum_le_sum (fun j _ => hterm j)
  linarith [hsum]

end SharpAmplificationAndPointwiseMonotonicityResearchProof1
