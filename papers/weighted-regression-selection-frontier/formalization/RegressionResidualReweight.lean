import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace WeightedRegressionSelectionFrontierResearchProof1

theorem residual_reweight {ι : Type*} (s : Finset ι) (r β x : ι → ℝ) (hn : ∀ i∈s, r i≠0) : (∑ i∈s, (β i/|r i|)*r i*x i) = ∑ i∈s, β i*(if 0<r i then 1 else -1)*x i := by
  apply Finset.sum_congr rfl
  intro i hi
  have hre := hn i hi
  rcases lt_or_gt_of_ne hre with h | h
  · rw [abs_of_neg h, if_neg (not_lt_of_ge h.le)]
    field_simp [hre]
    ring
  · rw [abs_of_pos h, if_pos h]
    field_simp [hre]

end WeightedRegressionSelectionFrontierResearchProof1
