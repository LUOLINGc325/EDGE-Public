import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity.Basic
import SwapDefinitions

/-!
The positive-real-weight family for the same executable CVZ algorithm.
All moments below are evaluated from `swapLaw`; no moment is assumed.
Mathematical labels 1,...,6 correspond to the bit positions 0,...,5.
-/

namespace SwapRounding

noncomputable section

set_option maxRecDepth 10000
set_option maxHeartbeats 2000000

theorem first_merge_shape (a b : ℝ) :
    merge 6 a b firstBase secondBase =
      .branch 7 11 2 3 (b / (a + b)) (a / (a + b)) (.done 11) (.done 7) := by
  rfl

theorem second_merge_first_shape (s c : ℝ) :
    merge 6 s c 7 thirdBase =
      .branch 7 52 0 4 (c / (s + c)) (s / (s + c))
        (.branch 22 52 1 5 (c / (s + c)) (s / (s + c)) (.done 52) (.done 22))
        (.branch 7 37 1 5 (c / (s + c)) (s / (s + c)) (.done 37) (.done 7)) := by
  rfl

theorem second_merge_second_shape (s c : ℝ) :
    merge 6 s c 11 thirdBase =
      .branch 11 52 0 2 (c / (s + c)) (s / (s + c))
        (.branch 14 52 1 4 (c / (s + c)) (s / (s + c))
          (.branch 28 52 3 5 (c / (s + c)) (s / (s + c)) (.done 52) (.done 28))
          (.branch 14 38 3 5 (c / (s + c)) (s / (s + c)) (.done 38) (.done 14)))
        (.branch 11 49 1 4 (c / (s + c)) (s / (s + c))
          (.branch 25 49 3 5 (c / (s + c)) (s / (s + c)) (.done 49) (.done 25))
          (.branch 11 35 3 5 (c / (s + c)) (s / (s + c)) (.done 35) (.done 11))) := by
  rfl

/-- The complete eleven-atom law, expressed through arbitrary rewards. -/
theorem parametric_expectation_formula (a b c : ℝ)
    (hab : a + b ≠ 0) (htotal : a + b + c = 1) (f : Base → ℝ) :
    swapExpected a b c f =
      a * (a+b) * f 7 + b * (a+b)^2 * f 11 +
      b * (a+b) * c * f 35 + a*c * f 37 +
      b * (a+b) * c * f 25 + b*c^2 * f 49 +
      b * (a+b) * c * f 14 + a*c * f 22 +
      b*c^2 * f 38 + b*c^2 * f 28 + c^2*(a+c) * f 52 := by
  simp only [swapExpected, swapLaw, first_merge_shape, second_merge_first_shape,
    second_merge_second_shape, bindLaw, treeLaw, scaleLaw, expectLaw,
    List.map_cons, List.map_nil, List.flatMap_cons, List.flatMap_nil,
    List.nil_append, List.cons_append, List.foldr_cons, List.foldr_nil,
    mul_one, htotal, div_one]
  have hc : c = 1-a-b := by linarith
  subst c
  field_simp
  ring

theorem parametric_event_moment (a b c : ℝ)
    (hab : a + b ≠ 0) (htotal : a + b + c = 1) :
    swapExpected a b c (eventIndicator : Base → ℝ) = a*c := by
  rw [parametric_expectation_formula a b c hab htotal]
  norm_num [eventIndicator, witnessEvent, member]

theorem parametric_joint_moment (a b c : ℝ)
    (hab : a + b ≠ 0) (htotal : a + b + c = 1) :
    swapExpected a b c (jointIndicator : Base → ℝ) = a*c := by
  rw [parametric_expectation_formula a b c hab htotal]
  norm_num [jointIndicator, witnessEvent, member]

theorem parametric_marginals (a b c : ℝ)
    (hab : a + b ≠ 0) (htotal : a + b + c = 1) :
    swapExpected a b c (coordinate 0 : Base → ℝ) = a+b ∧
    swapExpected a b c (coordinate 1 : Base → ℝ) = a+b ∧
    swapExpected a b c (coordinate 2 : Base → ℝ) = a+c ∧
    swapExpected a b c (coordinate 3 : Base → ℝ) = b ∧
    swapExpected a b c (coordinate 4 : Base → ℝ) = c ∧
    swapExpected a b c (coordinate 5 : Base → ℝ) = c := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;>
    rw [parametric_expectation_formula a b c hab htotal] <;>
    norm_num [coordinate, member]
  all_goals
    have hc : c = 1-a-b := by linarith
    subst c
    ring

theorem parametric_coordinate_moment (a b c : ℝ)
    (hab : a + b ≠ 0) (htotal : a + b + c = 1) :
    swapExpected a b c (coordinate 2 : Base → ℝ) = a+c :=
  (parametric_marginals a b c hab htotal).2.2.1

theorem parametric_total_mass (a b c : ℝ)
    (hab : a + b ≠ 0) (htotal : a + b + c = 1) :
    swapExpected a b c (fun _ => (1 : ℝ)) = 1 := by
  rw [parametric_expectation_formula a b c hab htotal]
  simp only [mul_one]
  have hc : c = 1-a-b := by linarith
  subst c
  ring

/-- Point probabilities in the actual sequential CVZ output law. -/
noncomputable def atomProbability (a b c : ℝ) (t : Base) : ℝ :=
  swapExpected a b c (fun s => if s = t then 1 else 0)

theorem parametric_atom_table (a b c : ℝ)
    (hab : a + b ≠ 0) (htotal : a + b + c = 1) :
    atomProbability a b c 7 = a*(a+b) ∧
    atomProbability a b c 11 = b*(a+b)^2 ∧
    atomProbability a b c 35 = b*(a+b)*c ∧
    atomProbability a b c 37 = a*c ∧
    atomProbability a b c 25 = b*(a+b)*c ∧
    atomProbability a b c 49 = b*c^2 ∧
    atomProbability a b c 14 = b*(a+b)*c ∧
    atomProbability a b c 22 = a*c ∧
    atomProbability a b c 38 = b*c^2 ∧
    atomProbability a b c 28 = b*c^2 ∧
    atomProbability a b c 52 = c^2*(a+c) := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;>
    unfold atomProbability <;>
    rw [parametric_expectation_formula a b c hab htotal] <;> norm_num

theorem parametric_no_other_atoms (a b c : ℝ)
    (hab : a + b ≠ 0) (htotal : a + b + c = 1) (t : Base)
    (h : t ∉ ([7,11,35,37,25,49,14,22,38,28,52] : List Nat)) :
    atomProbability a b c t = 0 := by
  unfold atomProbability
  rw [parametric_expectation_formula a b c hab htotal]
  simp only [List.mem_cons, List.not_mem_nil, not_or, not_false_eq_true, and_true] at h
  rcases h with ⟨h7,h11,h35,h37,h25,h49,h14,h22,h38,h28,h52⟩
  simp [Ne.symm h7, Ne.symm h11, Ne.symm h35, Ne.symm h37, Ne.symm h25,
    Ne.symm h49, Ne.symm h14, Ne.symm h22, Ne.symm h38, Ne.symm h28, Ne.symm h52]

noncomputable def zeroJointIndicator (s : Base) : ℝ :=
  if !member s 2 && witnessEvent s then 1 else 0

theorem parametric_zero_joint_moment (a b c : ℝ)
    (hab : a + b ≠ 0) (htotal : a + b + c = 1) :
    swapExpected a b c zeroJointIndicator = 0 := by
  rw [parametric_expectation_formula a b c hab htotal]
  norm_num [zeroJointIndicator, witnessEvent, member]

theorem parametric_conditional_zero (a b c : ℝ)
    (hab : a + b ≠ 0) (htotal : a + b + c = 1) :
    swapExpected a b c zeroJointIndicator /
      (1 - swapExpected a b c (coordinate 2 : Base → ℝ)) = 0 := by
  rw [parametric_zero_joint_moment a b c hab htotal]
  exact zero_div _

theorem parametric_conditional_one (a b c : ℝ)
    (hab : a + b ≠ 0) (htotal : a + b + c = 1) :
    swapExpected a b c (jointIndicator : Base → ℝ) /
      swapExpected a b c (coordinate 2 : Base → ℝ) = a*c/(a+c) := by
  rw [parametric_joint_moment a b c hab htotal,
    parametric_coordinate_moment a b c hab htotal]

theorem parametric_conditioning_positive (a b c : ℝ)
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (htotal : a + b + c = 1) :
    0 < swapExpected a b c (coordinate 2 : Base → ℝ) ∧
    0 < 1 - swapExpected a b c (coordinate 2 : Base → ℝ) := by
  have hab : a+b ≠ 0 := ne_of_gt (add_pos ha hb)
  rw [parametric_coordinate_moment a b c hab htotal]
  constructor <;> linarith

theorem parametric_covariance (a b c : ℝ)
    (hab : a + b ≠ 0) (htotal : a + b + c = 1) :
    swapExpected a b c (jointIndicator : Base → ℝ) -
      swapExpected a b c (coordinate 2 : Base → ℝ) *
        swapExpected a b c (eventIndicator : Base → ℝ) = a*b*c := by
  rw [parametric_joint_moment a b c hab htotal,
    parametric_coordinate_moment a b c hab htotal,
    parametric_event_moment a b c hab htotal]
  have hc : c = 1-a-b := by linarith
  subst c
  ring

theorem parametric_covariance_positive (a b c : ℝ)
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (htotal : a + b + c = 1) :
    0 < swapExpected a b c (jointIndicator : Base → ℝ) -
      swapExpected a b c (coordinate 2 : Base → ℝ) *
        swapExpected a b c (eventIndicator : Base → ℝ) := by
  rw [parametric_covariance a b c (ne_of_gt (add_pos ha hb)) htotal]
  exact mul_pos (mul_pos ha hb) hc

/-- Every actual execution-path weight is strictly positive. -/
theorem parametric_law_positive (a b c : ℝ)
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (out : Base × ℝ)
    (hout : out ∈ swapLaw a b c) : 0 < out.2 := by
  simp only [swapLaw, first_merge_shape, second_merge_first_shape,
    second_merge_second_shape, bindLaw, treeLaw, scaleLaw,
    List.map_cons, List.map_nil, List.flatMap_cons, List.flatMap_nil,
    List.nil_append, List.cons_append, mul_one,
    List.mem_cons, List.not_mem_nil, or_false] at hout
  rcases hout with h|h|h|h|h|h|h|h|h|h|h|h
  all_goals
    subst out
    dsimp
    positivity

theorem parametric_law_support (a b c : ℝ) (out : Base × ℝ)
    (hout : out ∈ swapLaw a b c) : isBase out.1 = true := by
  simp only [swapLaw, first_merge_shape, second_merge_first_shape,
    second_merge_second_shape, bindLaw, treeLaw, scaleLaw,
    List.map_cons, List.map_nil, List.flatMap_cons, List.flatMap_nil,
    List.nil_append, List.cons_append, mul_one,
    List.mem_cons, List.not_mem_nil, or_false] at hout
  rcases hout with h|h|h|h|h|h|h|h|h|h|h|h
  all_goals
    subst out
    dsimp only [Prod.fst]
    decide

/-- Monotonicity is tested on ALL 64 subsets, not just the rank-three support. -/
noncomputable def RealIncreasing (f : Base → ℝ) : Prop :=
  ∀ s t : Fin 64, maskSubset s.val t.val = true → f s.val ≤ f t.val

noncomputable def RealIndependentOf (i : Nat) (f : Base → ℝ) : Prop :=
  ∀ s t : Fin 64, sameOutside i s.val t.val = true → f s.val = f t.val

noncomputable def RealOneNegativeAssociated (a b c : ℝ) : Prop :=
  ∀ (i : Fin 6) (f : Base → ℝ), RealIncreasing f → RealIndependentOf i.val f →
    swapExpected a b c (fun s => (coordinate i.val s : ℝ) * f s) ≤
      swapExpected a b c (coordinate i.val : Base → ℝ) * swapExpected a b c f

/-- Full singleton-versus-complement definition, including arbitrary monotone g. -/
noncomputable def RealFullOneNegativeAssociated (a b c : ℝ) : Prop :=
  ∀ (i : Fin 6) (f : Base → ℝ) (g : ℝ → ℝ),
    RealIncreasing f → RealIndependentOf i.val f → Monotone g →
      swapExpected a b c (fun s => g (coordinate i.val s) * f s) ≤
        swapExpected a b c (fun s => g (coordinate i.val s)) * swapExpected a b c f

/-- The identity singleton test is a necessary consequence of the full definition. -/
theorem full_one_na_implies_coordinate_condition (a b c : ℝ)
    (h : RealFullOneNegativeAssociated a b c) : RealOneNegativeAssociated a b c := by
  intro i f hf hi
  exact h i f (fun x : ℝ => x) hf hi (fun _ _ hxy => hxy)

theorem real_event_increasing : RealIncreasing (eventIndicator : Base → ℝ) := by
  intro s t hst
  by_cases hs : witnessEvent s.val = true
  · have ht := event_upset s t hst hs
    simp [eventIndicator, hs, ht]
  · have hsfalse : witnessEvent s.val = false := by
      cases h : witnessEvent s.val <;> simp_all
    simp [eventIndicator, hsfalse]
    cases h : witnessEvent t.val <;> norm_num

theorem real_event_independent : RealIndependentOf 2 (eventIndicator : Base → ℝ) := by
  intro s t hst
  unfold eventIndicator
  rw [event_ignores_third s t hst]

theorem real_joint_is_product :
    (jointIndicator : Base → ℝ) =
      (fun s => (coordinate 2 s : ℝ) * (eventIndicator s : ℝ)) := by
  funext s
  cases h : member s 2 <;> cases he : witnessEvent s <;>
    simp [jointIndicator, coordinate, eventIndicator, h, he]

theorem parametric_not_one_negative_associated (a b c : ℝ)
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (htotal : a + b + c = 1) :
    ¬ RealOneNegativeAssociated a b c := by
  intro h
  have htest := h (2 : Fin 6) (eventIndicator : Base → ℝ)
    real_event_increasing real_event_independent
  change swapExpected a b c (fun s => (coordinate 2 s : ℝ) * eventIndicator s) ≤
    swapExpected a b c (coordinate 2 : Base → ℝ) *
      swapExpected a b c (eventIndicator : Base → ℝ) at htest
  rw [← real_joint_is_product] at htest
  have hpos := parametric_covariance_positive a b c ha hb hc htotal
  linarith

theorem parametric_not_full_one_negative_associated (a b c : ℝ)
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (htotal : a + b + c = 1) :
    ¬ RealFullOneNegativeAssociated a b c := by
  intro h
  exact parametric_not_one_negative_associated a b c ha hb hc htotal
    (full_one_na_implies_coordinate_condition a b c h)

theorem parametric_negative_regression_violation (a b c : ℝ)
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (htotal : a + b + c = 1) :
    swapExpected a b c zeroJointIndicator /
        (1 - swapExpected a b c (coordinate 2 : Base → ℝ)) <
      swapExpected a b c (jointIndicator : Base → ℝ) /
        swapExpected a b c (coordinate 2 : Base → ℝ) := by
  have hab := ne_of_gt (add_pos ha hb)
  rw [parametric_conditional_zero a b c hab htotal,
    parametric_conditional_one a b c hab htotal]
  exact div_pos (mul_pos ha hc) (add_pos ha hc)

/-- A concrete point in the quantified positive simplex; the theorem is not vacuous. -/
theorem positive_simplex_counterexample :
    ∃ a b c : ℝ, 0 < a ∧ 0 < b ∧ 0 < c ∧ a+b+c = 1 ∧
      ¬ RealOneNegativeAssociated a b c := by
  refine ⟨1/3,1/3,1/3,by norm_num,by norm_num,by norm_num,by norm_num,?_⟩
  apply parametric_not_one_negative_associated <;> norm_num

theorem positive_simplex_full_counterexample :
    ∃ a b c : ℝ, 0 < a ∧ 0 < b ∧ 0 < c ∧ a+b+c = 1 ∧
      ¬ RealFullOneNegativeAssociated a b c := by
  refine ⟨1/3,1/3,1/3,by norm_num,by norm_num,by norm_num,by norm_num,?_⟩
  apply parametric_not_full_one_negative_associated <;> norm_num

end

end SwapRounding
