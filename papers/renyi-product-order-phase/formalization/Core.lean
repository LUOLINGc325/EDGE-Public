import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Lean

/-!
# Exact two-point reciprocal Jensen deficit

This file proves the finite, two-point alpha = 2 algebraic deficit and the
general finite-weight reciprocal Jensen identity, signs, and equality conditions.
It does not formalize the local limit theorem, the asymptotic optimization,
or the reduction from channel SDPI coefficients.
-/

set_option autoImplicit false

open scoped BigOperators

namespace RenyiProductOrderPhase

noncomputable def reciprocalJensenGap (a w x y : ℝ) : ℝ :=
  w / (1 + a * x) + (1 - w) / (1 + a * y) -
    1 / (1 + a * (w * x + (1 - w) * y))

theorem reciprocalJensenGap_identity
    (a w x y : ℝ)
    (ha : 0 < a) (hx : 0 < x) (hy : 0 < y)
    (hw0 : 0 ≤ w) (hw1 : w ≤ 1) :
    reciprocalJensenGap a w x y =
      a ^ 2 * w * (1 - w) * (x - y) ^ 2 /
        ((1 + a * x) * (1 + a * y) *
          (1 + a * (w * x + (1 - w) * y))) := by
  have h1w : 0 ≤ 1 - w := sub_nonneg.mpr hw1
  have hdx : 0 < 1 + a * x := by positivity
  have hdy : 0 < 1 + a * y := by positivity
  have hdm : 0 < 1 + a * (w * x + (1 - w) * y) := by positivity
  unfold reciprocalJensenGap
  field_simp [ne_of_gt hdx, ne_of_gt hdy, ne_of_gt hdm]
  ring

theorem reciprocalJensenGap_nonneg
    (a w x y : ℝ)
    (ha : 0 < a) (hx : 0 < x) (hy : 0 < y)
    (hw0 : 0 ≤ w) (hw1 : w ≤ 1) :
    0 ≤ reciprocalJensenGap a w x y := by
  rw [reciprocalJensenGap_identity a w x y ha hx hy hw0 hw1]
  have h1w : 0 ≤ 1 - w := sub_nonneg.mpr hw1
  positivity

theorem reciprocalJensenGap_pos
    (a w x y : ℝ)
    (ha : 0 < a) (hx : 0 < x) (hy : 0 < y)
    (hw0 : 0 < w) (hw1 : w < 1) (hxy : x ≠ y) :
    0 < reciprocalJensenGap a w x y := by
  rw [reciprocalJensenGap_identity a w x y ha hx hy
    (le_of_lt hw0) (le_of_lt hw1)]
  have h1w : 0 < 1 - w := sub_pos.mpr hw1
  have hsq : 0 < (x - y) ^ 2 := sq_pos_of_ne_zero (sub_ne_zero.mpr hxy)
  positivity

theorem reciprocalJensenGap_zero_iff
    (a w x y : ℝ)
    (ha : 0 < a) (hx : 0 < x) (hy : 0 < y)
    (hw0 : 0 < w) (hw1 : w < 1) :
    reciprocalJensenGap a w x y = 0 ↔ x = y := by
  constructor
  · intro hgap
    by_contra hxy
    have hpos := reciprocalJensenGap_pos a w x y ha hx hy hw0 hw1 hxy
    linarith
  · intro hxy
    subst y
    rw [reciprocalJensenGap_identity a w x x ha hx hx
      (le_of_lt hw0) (le_of_lt hw1)]
    simp

theorem strict_reciprocalJensen
    (a w x y : ℝ)
    (ha : 0 < a) (hx : 0 < x) (hy : 0 < y)
    (hw0 : 0 < w) (hw1 : w < 1) (hxy : x ≠ y) :
    1 / (1 + a * (w * x + (1 - w) * y)) <
      w / (1 + a * x) + (1 - w) / (1 + a * y) := by
  have hpos := reciprocalJensenGap_pos a w x y ha hx hy hw0 hw1 hxy
  unfold reciprocalJensenGap at hpos
  linarith

theorem finiteWeightedMean_pos
    {ι : Type*} [Fintype ι] (w d : ι → ℝ)
    (hw : ∀ i, 0 ≤ w i) (hd : ∀ i, 0 < d i)
    (hw_sum : ∑ i, w i = 1) :
    0 < ∑ i, w i * d i := by
  classical
  have hex : ∃ i, 0 < w i := by
    by_contra hn
    have hz : ∀ i, w i = 0 := by
      intro i
      have hi : ¬ 0 < w i := fun h => hn ⟨i, h⟩
      exact le_antisymm (le_of_not_gt hi) (hw i)
    have : (∑ i, w i) = 0 := by simp [hz]
    linarith
  obtain ⟨i, hi⟩ := hex
  have hle : w i * d i ≤ ∑ j, w j * d j :=
    Finset.single_le_sum (fun j _ => mul_nonneg (hw j) (le_of_lt (hd j)))
      (Finset.mem_univ i)
  exact lt_of_lt_of_le (mul_pos hi (hd i)) hle

theorem finiteReciprocalGap_identity
    {ι : Type*} [Fintype ι] (w d : ι → ℝ) (m : ℝ)
    (hd : ∀ i, d i ≠ 0) (hm : m ≠ 0)
    (hw_sum : ∑ i, w i = 1) (hmean : ∑ i, w i * d i = m) :
    (∑ i, w i / d i) - 1 / m =
      (∑ i, w i * (d i - m) ^ 2 / d i) / m ^ 2 := by
  classical
  have hterm (i : ι) :
      w i * (d i - m) ^ 2 / d i =
        w i * d i - 2 * m * w i + m ^ 2 * (w i / d i) := by
    field_simp [hd i]
    ring
  have hsum : (∑ i, w i * (d i - m) ^ 2 / d i) =
      m ^ 2 * (∑ i, w i / d i) - m := by
    calc
      _ = ∑ i, (w i * d i - 2 * m * w i + m ^ 2 * (w i / d i)) := by
        apply Finset.sum_congr rfl
        intro i _
        exact hterm i
      _ = (∑ i, w i * d i) - 2 * m * (∑ i, w i) +
          m ^ 2 * (∑ i, w i / d i) := by
        simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.mul_sum]
      _ = m ^ 2 * (∑ i, w i / d i) - m := by
        rw [hw_sum, hmean]
        ring
  rw [hsum]
  field_simp [hm]
  ring

theorem finiteReciprocalGap_nonneg
    {ι : Type*} [Fintype ι] (w d : ι → ℝ)
    (hw : ∀ i, 0 ≤ w i) (hd : ∀ i, 0 < d i)
    (hw_sum : ∑ i, w i = 1) :
    0 ≤ (∑ i, w i / d i) - 1 / (∑ i, w i * d i) := by
  have hm := finiteWeightedMean_pos w d hw hd hw_sum
  rw [finiteReciprocalGap_identity w d (∑ i, w i * d i)
    (fun i => ne_of_gt (hd i)) (ne_of_gt hm) hw_sum rfl]
  exact div_nonneg
    (Finset.sum_nonneg fun i _ => div_nonneg
      (mul_nonneg (hw i) (sq_nonneg _)) (le_of_lt (hd i)))
    (sq_nonneg _)

theorem finiteReciprocalGap_pos
    {ι : Type*} [Fintype ι] (w d : ι → ℝ)
    (hw : ∀ i, 0 ≤ w i) (hd : ∀ i, 0 < d i)
    (hw_sum : ∑ i, w i = 1)
    (hvar : ∃ i, 0 < w i ∧ d i ≠ ∑ j, w j * d j) :
    0 < (∑ i, w i / d i) - 1 / (∑ i, w i * d i) := by
  classical
  have hm := finiteWeightedMean_pos w d hw hd hw_sum
  rw [finiteReciprocalGap_identity w d (∑ i, w i * d i)
    (fun i => ne_of_gt (hd i)) (ne_of_gt hm) hw_sum rfl]
  obtain ⟨i, hi, hneq⟩ := hvar
  have hterm : 0 < w i * (d i - ∑ j, w j * d j) ^ 2 / d i :=
    div_pos (mul_pos hi (sq_pos_of_ne_zero (sub_ne_zero.mpr hneq))) (hd i)
  have hle : w i * (d i - ∑ j, w j * d j) ^ 2 / d i ≤
      ∑ k, w k * (d k - ∑ j, w j * d j) ^ 2 / d k :=
    Finset.single_le_sum (fun k _ => div_nonneg
      (mul_nonneg (hw k) (sq_nonneg (d k - ∑ j, w j * d j)))
      (le_of_lt (hd k))) (Finset.mem_univ i)
  exact div_pos (lt_of_lt_of_le hterm hle) (sq_pos_of_pos hm)

theorem finiteReciprocalGap_zero_iff
    {ι : Type*} [Fintype ι] (w d : ι → ℝ)
    (hw : ∀ i, 0 ≤ w i) (hd : ∀ i, 0 < d i)
    (hw_sum : ∑ i, w i = 1) :
    (∑ i, w i / d i) - 1 / (∑ i, w i * d i) = 0 ↔
      ∀ i, 0 < w i → d i = ∑ j, w j * d j := by
  constructor
  · intro hgap i hi
    by_contra hdi
    have hpos := finiteReciprocalGap_pos w d hw hd hw_sum ⟨i, hi, hdi⟩
    linarith
  · intro heq
    have hm := finiteWeightedMean_pos w d hw hd hw_sum
    rw [finiteReciprocalGap_identity w d (∑ i, w i * d i)
      (fun i => ne_of_gt (hd i)) (ne_of_gt hm) hw_sum rfl]
    have hz (i : ι) : w i * (d i - ∑ j, w j * d j) ^ 2 / d i = 0 := by
      by_cases hi : 0 < w i
      · rw [heq i hi]
        simp
      · have hwi : w i = 0 := le_antisymm (le_of_not_gt hi) (hw i)
        simp [hwi]
    simp [hz]

theorem finiteReciprocalGap_pos_of_distinct
    {ι : Type*} [Fintype ι] (w d : ι → ℝ)
    (hw : ∀ i, 0 ≤ w i) (hd : ∀ i, 0 < d i)
    (hw_sum : ∑ i, w i = 1)
    (hvar : ∃ i j, 0 < w i ∧ 0 < w j ∧ d i ≠ d j) :
    0 < (∑ i, w i / d i) - 1 / (∑ i, w i * d i) := by
  obtain ⟨i, j, hi, hj, hneq⟩ := hvar
  apply finiteReciprocalGap_pos w d hw hd hw_sum
  by_cases hdi : d i = ∑ k, w k * d k
  · refine ⟨j, hj, ?_⟩
    intro hdj
    exact hneq (hdi.trans hdj.symm)
  · exact ⟨i, hi, hdi⟩

theorem concrete_nonzero_gap :
    reciprocalJensenGap 1 (1 / 2) 1 3 = (1 / 24 : ℝ) := by
  norm_num [reciprocalJensenGap]

end RenyiProductOrderPhase

#print axioms RenyiProductOrderPhase.reciprocalJensenGap_identity
#print axioms RenyiProductOrderPhase.reciprocalJensenGap_nonneg
#print axioms RenyiProductOrderPhase.reciprocalJensenGap_pos
#print axioms RenyiProductOrderPhase.reciprocalJensenGap_zero_iff
#print axioms RenyiProductOrderPhase.strict_reciprocalJensen
#print axioms RenyiProductOrderPhase.finiteWeightedMean_pos
#print axioms RenyiProductOrderPhase.finiteReciprocalGap_identity
#print axioms RenyiProductOrderPhase.finiteReciprocalGap_nonneg
#print axioms RenyiProductOrderPhase.finiteReciprocalGap_pos
#print axioms RenyiProductOrderPhase.finiteReciprocalGap_zero_iff
#print axioms RenyiProductOrderPhase.finiteReciprocalGap_pos_of_distinct
#print axioms RenyiProductOrderPhase.concrete_nonzero_gap

-- Audit every declaration created in this module, including auxiliary declarations.
open Lean in
run_cmd do
  let env ← getEnv
  let mut entries : Array (String × Array String) := #[]
  for (name, _) in env.constants.map₂.toList do
    let axioms ← Lean.collectAxioms name
    entries := entries.push (name.toString, axioms.map Name.toString)
  logInfo m!"CORE_KERNEL_AXIOMS: {(toJson entries).compress}"
