import Mathlib.Data.Rat.Defs
import SwapDefinitions

/-! Kernel-checked finite certificate; no native evaluation is used in proofs. -/

namespace SwapRounding

noncomputable section

set_option maxRecDepth 8192
set_option maxHeartbeats 4000000

noncomputable def equalWeight : ℚ := 1 / 3
noncomputable def equalLaw : Law ℚ := swapLaw equalWeight equalWeight equalWeight

noncomputable def pointMass (s : Base) : ℚ :=
  expectLaw equalLaw (fun t => if t == s then 1 else 0)

/-- Aggregated mass numerator, denominator 27; masks use zero-based bits. -/
noncomputable def tableCount : Nat → Nat
  | 7 => 6
  | 11 => 4
  | 35 => 2
  | 37 => 3
  | 25 => 2
  | 49 => 1
  | 14 => 2
  | 22 => 3
  | 38 => 1
  | 28 => 1
  | 52 => 2
  | _ => 0

noncomputable def tableMass (s : Nat) : ℚ := (tableCount s : ℚ) / 27

theorem input_bases_valid :
    isBase firstBase = true ∧ isBase secondBase = true ∧ isBase thirdBase = true := by
  decide +kernel

theorem input_weights_valid :
    0 < equalWeight ∧ equalWeight + equalWeight + equalWeight = 1 := by
  decide +kernel

theorem run_equals_full_table : ∀ s : Fin 64, pointMass s.val = tableMass s.val := by
  decide +kernel

theorem all_output_bases_valid :
    equalLaw.all (fun (s, p) => isBase s && decide (0 < p)) = true := by
  decide +kernel

theorem probability_normalized : expectLaw equalLaw (fun _ => 1) = 1 := by
  decide +kernel

theorem coordinate_marginals :
    (List.range 6).map (fun i => expectLaw equalLaw (coordinate i)) =
      [(2/3 : ℚ), 2/3, 2/3, 1/3, 1/3, 1/3] := by
  decide +kernel

theorem witness_moments :
    expectLaw equalLaw (coordinate 2) = (2/3 : ℚ) ∧
    expectLaw equalLaw eventIndicator = (1/9 : ℚ) ∧
    expectLaw equalLaw jointIndicator = (1/9 : ℚ) := by
  decide +kernel

noncomputable def Increasing (f : Fin 64 → ℚ) : Prop :=
  ∀ s t : Fin 64, maskSubset s.val t.val = true → f s ≤ f t

noncomputable def IndependentOf (i : Fin 6) (f : Fin 64 → ℚ) : Prop :=
  ∀ s t : Fin 64, sameOutside i.val s.val t.val = true → f s = f t

noncomputable def finiteEvent (s : Fin 64) : ℚ := eventIndicator s.val

theorem witness_increasing : Increasing finiteEvent := by
  unfold Increasing
  decide +kernel

theorem witness_independent_of_third_coordinate : IndependentOf ⟨2, by decide⟩ finiteEvent := by
  unfold IndependentOf
  decide +kernel

noncomputable def mean (f : Fin 64 → ℚ) : ℚ :=
  ((List.finRange 64).map (fun s => pointMass s.val * f s)).foldr (· + ·) 0

noncomputable def finiteCoordinate (i : Fin 6) (s : Fin 64) : ℚ := coordinate i.val s.val

noncomputable def covariance (i : Fin 6) (f : Fin 64 → ℚ) : ℚ :=
  mean (fun s => finiteCoordinate i s * f s) - mean (finiteCoordinate i) * mean f

/--
The event version of 1-negative association: each increasing rational-valued
observable avoiding one coordinate has nonpositive covariance with it.
Violation by an indicator also violates the usual real-valued condition.
-/
noncomputable def OneNegativeAssociated : Prop :=
  ∀ (i : Fin 6) (f : Fin 64 → ℚ), Increasing f → IndependentOf i f → covariance i f ≤ 0

theorem exact_positive_covariance :
    covariance ⟨2, by decide⟩ finiteEvent = (1/27 : ℚ) := by
  decide +kernel

theorem covariance_strictly_positive :
    0 < covariance ⟨2, by decide⟩ finiteEvent := by
  rw [exact_positive_covariance]
  decide +kernel

theorem lexicographic_swap_rounding_not_one_negative_associated :
    ¬ OneNegativeAssociated := by
  intro h
  have hn := h ⟨2, by decide⟩ finiteEvent witness_increasing
    witness_independent_of_third_coordinate
  rw [exact_positive_covariance] at hn
  exact (by decide +kernel : ¬ ((1/27 : ℚ) ≤ 0)) hn

#print axioms input_bases_valid
#print axioms input_weights_valid
#print axioms run_equals_full_table
#print axioms all_output_bases_valid
#print axioms probability_normalized
#print axioms coordinate_marginals
#print axioms witness_moments
#print axioms first_merge_valid
#print axioms second_merge_from_first_valid
#print axioms second_merge_from_second_valid
#print axioms witness_increasing
#print axioms witness_independent_of_third_coordinate
#print axioms exact_positive_covariance
#print axioms covariance_strictly_positive
#print axioms lexicographic_swap_rounding_not_one_negative_associated

end

end SwapRounding
