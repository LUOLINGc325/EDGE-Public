import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Ring

open scoped BigOperators

namespace DirectedCycleTwoSeasonWitnessResearchProof1

/-- Normalized pairing of the left and right vectors underlying equation (5). -/
theorem normalized_pairing {ι : Type*} [Fintype ι] [Nonempty ι]
    (w v vp : ι → ℝ) (hw : ∀ i, 0 < w i) (hv : ∀ i, 0 < v i)
    (hp : ∀ i, 0 < vp i) :
    (∑ i, ((w i / vp i) / (∑ j, w j * v j / vp j)) * v i) = 1 := by
  let z := ∑ j, w j * v j / vp j
  have hz : 0 < z :=
    Finset.sum_pos (fun j _ => div_pos (mul_pos (hw j) (hv j)) (hp j)) Finset.univ_nonempty
  change (∑ i, ((w i / vp i) / z) * v i) = 1
  calc
    (∑ i, ((w i / vp i) / z) * v i) = ∑ i, (w i * v i / vp i) * z⁻¹ := by
      apply Finset.sum_congr rfl
      intro i _
      ring
    _ = z * z⁻¹ := (Finset.sum_mul _ _ _).symm
    _ = 1 := mul_inv_cancel₀ hz.ne'

end DirectedCycleTwoSeasonWitnessResearchProof1
