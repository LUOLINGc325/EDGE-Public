import Core

set_option autoImplicit false
open scoped BigOperators
open RenyiProductOrderPhase

namespace IndependentBoundaryReview

-- A1: boundary weights destroy strictness despite distinct positive values.
theorem endpoint_weight_zero :
    reciprocalJensenGap 1 0 1 3 = 0 ∧ (1 : ℝ) ≠ 3 := by
  norm_num [reciprocalJensenGap]

theorem endpoint_weight_one :
    reciprocalJensenGap 1 1 1 3 = 0 ∧ (1 : ℝ) ≠ 3 := by
  norm_num [reciprocalJensenGap]

-- A2: setting the scale to zero also destroys strictness.
theorem zero_scale : reciprocalJensenGap 0 (1 / 2) 1 3 = 0 := by
  norm_num [reciprocalJensenGap]

-- A3: normalized signed weights and positive denominators can give a negative gap.
theorem negative_weight_counterexample :
    (∑ i : Bool, (if i then (2 : ℝ) else -1)) = 1 ∧
    (∀ i : Bool, 0 < (if i then (2 : ℝ) else 1)) ∧
    ((∑ i : Bool, (if i then (2 : ℝ) else -1) /
          (if i then (2 : ℝ) else 1)) -
        1 / (∑ i : Bool, (if i then (2 : ℝ) else -1) *
          (if i then (2 : ℝ) else 1))) = -(1 / 3 : ℝ) := by
  norm_num

-- A4: Lean's totalized division does not rescue a zero denominator.
theorem zero_denominator_counterexample :
    ((∑ i : Bool, (1 / 2 : ℝ) / (if i then (2 : ℝ) else 0)) -
        1 / (∑ i : Bool, (1 / 2 : ℝ) * (if i then (2 : ℝ) else 0))) =
      -(3 / 4 : ℝ) := by
  norm_num

-- A5: unequal values outside positive-weight support must not force strictness.
theorem zero_weight_off_support :
    ((∑ i : Bool, (if i then (0 : ℝ) else 1) /
          (if i then (3 : ℝ) else 1)) -
        1 / (∑ i : Bool, (if i then (0 : ℝ) else 1) *
          (if i then (3 : ℝ) else 1))) = 0 := by
  norm_num

-- A6: the probability normalization is essential to the stated inequality.
theorem missing_normalization_counterexample :
    ((1 / 2 : ℝ) / 1 - 1 / ((1 / 2 : ℝ) * 1)) = -(3 / 2 : ℝ) := by
  norm_num

-- A7: no normalized probability vector exists on the empty finite type.
theorem empty_type_impossible (w : Empty → ℝ)
    (h : ∑ i, w i = 1) : False := by
  simp at h

-- N1: instantiate the audited strict theorem on a concrete nondegenerate family.
theorem strict_theorem_has_witness :
    0 < reciprocalJensenGap 1 (1 / 2) 1 3 := by
  exact reciprocalJensenGap_pos 1 (1 / 2) 1 3
    (by norm_num) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)

-- N2: instantiate the arbitrary-finite theorem, rather than relying only on numerics.
theorem finite_theorem_has_witness :
    0 < (∑ i : Bool, (1 / 2 : ℝ) / (if i then (4 : ℝ) else 2)) -
      1 / (∑ i : Bool, (1 / 2 : ℝ) * (if i then (4 : ℝ) else 2)) := by
  apply finiteReciprocalGap_pos_of_distinct
    (fun _ : Bool => (1 / 2 : ℝ)) (fun i : Bool => if i then (4 : ℝ) else 2)
  · intro i
    norm_num
  · intro i
    cases i <;> norm_num
  · norm_num
  · exact ⟨false, true, by norm_num, by norm_num, by norm_num⟩

end IndependentBoundaryReview

open Lean in
run_cmd do
  let env ← getEnv
  let mut rows : Array (String × Array String) := #[]
  for (name, _) in env.constants.map₂.toList do
    let axioms ← Lean.collectAxioms name
    rows := rows.push (name.toString, axioms.map Name.toString)
  logInfo m!"INDEPENDENT_BOUNDARY_AXIOMS: {(toJson rows).compress}"
