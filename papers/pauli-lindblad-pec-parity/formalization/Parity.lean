import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Lean

set_option autoImplicit false

namespace PECParity

open scoped BigOperators

section Fibers

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq Y]

noncomputable def mass (label : X → Y) (parity : X → Bool)
    (weight : X → ℝ) (g : Y) (b : Bool) : ℝ :=
  ∑ x, if label x = g ∧ parity x = b then weight x else 0

noncomputable def unsignedTotal (weight : X → ℝ) : ℝ := ∑ x, weight x

noncomputable def collectedTotal (label : X → Y) (parity : X → Bool)
    (weight : X → ℝ) : ℝ :=
  ∑ g, |mass label parity weight g false - mass label parity weight g true|

omit [Fintype Y] in
theorem mass_nonneg (label : X → Y) (parity : X → Bool) (weight : X → ℝ)
    (hw : ∀ x, 0 ≤ weight x) (g : Y) (b : Bool) :
    0 ≤ mass label parity weight g b := by
  apply Finset.sum_nonneg
  intro x _
  split_ifs
  · exact hw x
  · exact le_refl 0

omit [Fintype Y] in
theorem mass_pos_of (label : X → Y) (parity : X → Bool) (weight : X → ℝ)
    (hw : ∀ x, 0 < weight x) (g : Y) (b : Bool) (x : X)
    (hl : label x = g) (hp : parity x = b) :
    0 < mass label parity weight g b := by
  classical
  have hn : ∀ y ∈ (Finset.univ : Finset X),
      0 ≤ (if label y = g ∧ parity y = b then weight y else 0) := by
    intro y _
    split_ifs
    · exact (hw y).le
    · exact le_refl 0
  have he := Finset.single_le_sum hn (Finset.mem_univ x)
  have hh : weight x ≤ mass label parity weight g b := by
    simpa [mass, hl, hp] using he
  exact lt_of_lt_of_le (hw x) hh

omit [Fintype Y] in
theorem mass_zero_of_absent (label : X → Y) (parity : X → Bool) (weight : X → ℝ)
    (g : Y) (b : Bool) (h : ∀ x, label x = g → parity x ≠ b) :
    mass label parity weight g b = 0 := by
  apply Finset.sum_eq_zero
  intro x _
  split_ifs with hx
  · exact False.elim ((h x hx.1) hx.2)
  · rfl

omit [Fintype Y] in
theorem fiber_mass_partition (label : X → Y) (parity : X → Bool) (weight : X → ℝ)
    (g : Y) :
    mass label parity weight g false + mass label parity weight g true =
      ∑ x, if label x = g then weight x else 0 := by
  rw [mass, mass, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro x _
  cases hp : parity x <;> by_cases hl : label x = g <;> simp [hp, hl]

theorem total_mass_partition (label : X → Y) (parity : X → Bool) (weight : X → ℝ) :
    ∑ g, (mass label parity weight g false + mass label parity weight g true) =
      unsignedTotal weight := by
  simp_rw [fiber_mass_partition]
  rw [Finset.sum_comm]
  simp [unsignedTotal]

omit [Fintype Y] in
theorem signed_fiber_formula (label : X → Y) (parity : X → Bool) (weight : X → ℝ)
    (g : Y) :
    mass label parity weight g false - mass label parity weight g true =
      ∑ x, if label x = g then (if parity x then -weight x else weight x) else 0 := by
  rw [mass, mass, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro x _
  cases hp : parity x <;> by_cases hl : label x = g <;> simp [hp, hl]

theorem local_gap (a b : ℝ) : a + b - |a - b| = 2 * min a b := by
  rcases le_total a b with h | h
  · rw [abs_of_nonpos (sub_nonpos.mpr h), min_eq_left h]
    ring
  · rw [abs_of_nonneg (sub_nonneg.mpr h), min_eq_right h]
    ring

theorem exact_cancellation_gap (label : X → Y) (parity : X → Bool) (weight : X → ℝ) :
    unsignedTotal weight - collectedTotal label parity weight =
      2 * ∑ g, min (mass label parity weight g false) (mass label parity weight g true) := by
  rw [← total_mass_partition label parity weight, collectedTotal, ← Finset.sum_sub_distrib]
  simp_rw [local_gap]
  rw [Finset.mul_sum]

theorem min_eq_zero_iff_of_nonnegative (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    min a b = 0 ↔ a = 0 ∨ b = 0 := by
  constructor
  · intro h
    rcases le_total a b with hab | hba
    · exact Or.inl ((min_eq_left hab).symm.trans h)
    · exact Or.inr ((min_eq_right hba).symm.trans h)
  · rintro (rfl | rfl)
    · exact min_eq_left hb
    · exact min_eq_right ha

theorem total_equality_iff_unmixed (label : X → Y) (parity : X → Bool) (weight : X → ℝ)
    (hw : ∀ x, 0 ≤ weight x) :
    unsignedTotal weight = collectedTotal label parity weight ↔
      ∀ g, mass label parity weight g false = 0 ∨ mass label parity weight g true = 0 := by
  have hn : ∀ g ∈ (Finset.univ : Finset Y),
      0 ≤ min (mass label parity weight g false) (mass label parity weight g true) := by
    intro g _
    exact le_min (mass_nonneg label parity weight hw g false)
      (mass_nonneg label parity weight hw g true)
  have hg := exact_cancellation_gap label parity weight
  constructor
  · intro he
    have hs : (∑ g, min (mass label parity weight g false) (mass label parity weight g true)) = 0 := by
      linarith
    intro g
    apply (min_eq_zero_iff_of_nonnegative _ _ (mass_nonneg label parity weight hw g false)
      (mass_nonneg label parity weight hw g true)).mp
    exact (Finset.sum_eq_zero_iff_of_nonneg hn).mp hs g (Finset.mem_univ g)
  · intro hm
    have hs : (∑ g, min (mass label parity weight g false) (mass label parity weight g true)) = 0 := by
      apply Finset.sum_eq_zero
      intro g _
      exact (min_eq_zero_iff_of_nonnegative _ _ (mass_nonneg label parity weight hw g false)
        (mass_nonneg label parity weight hw g true)).mpr (hm g)
    linarith

omit [Fintype Y] in
theorem unmixed_iff_fiber_parity (label : X → Y) (parity : X → Bool) (weight : X → ℝ)
    (hw : ∀ x, 0 < weight x) :
    (∀ g, mass label parity weight g false = 0 ∨ mass label parity weight g true = 0) ↔
      ∀ x y, label x = label y → parity x = parity y := by
  constructor
  · intro hm x y hl
    cases hx : parity x <;> cases hy : parity y
    · rfl
    · have hp := mass_pos_of label parity weight hw (label x) false x rfl hx
      have hn := mass_pos_of label parity weight hw (label x) true y hl.symm hy
      rcases hm (label x) with he | he <;> linarith
    · have hp := mass_pos_of label parity weight hw (label x) true x rfl hx
      have hn := mass_pos_of label parity weight hw (label x) false y hl.symm hy
      rcases hm (label x) with he | he <;> linarith
    · rfl
  · intro h g
    by_cases he : ∃ x, label x = g ∧ parity x = false
    · rcases he with ⟨x, hx, hp⟩
      right
      apply mass_zero_of_absent
      intro y hy hpy
      have hh := h x y (hx.trans hy.symm)
      simp [hp, hpy] at hh
    · left
      apply mass_zero_of_absent
      intro x hx hp
      exact he ⟨x, hx, hp⟩

theorem total_equality_iff_fiber_parity (label : X → Y) (parity : X → Bool) (weight : X → ℝ)
    (hw : ∀ x, 0 < weight x) :
    unsignedTotal weight = collectedTotal label parity weight ↔
      ∀ x y, label x = label y → parity x = parity y := by
  exact (total_equality_iff_unmixed label parity weight (fun x => (hw x).le)).trans
    (unmixed_iff_fiber_parity label parity weight hw)

theorem collected_le_unsigned (label : X → Y) (parity : X → Bool) (weight : X → ℝ)
    (hw : ∀ x, 0 ≤ weight x) :
    collectedTotal label parity weight ≤ unsignedTotal weight := by
  have hn : 0 ≤ ∑ g, min (mass label parity weight g false) (mass label parity weight g true) := by
    apply Finset.sum_nonneg
    intro g _
    exact le_min (mass_nonneg label parity weight hw g false)
      (mass_nonneg label parity weight hw g true)
  have hg := exact_cancellation_gap label parity weight
  linarith

end Fibers

theorem zmod_two_cases (z : ZMod 2) : z = 0 ∨ z = 1 := by
  exact (by decide : ∀ z : ZMod 2, z = 0 ∨ z = 1) z

section Kernel

variable {V W : Type*} [AddGroup V] [AddGroup W]

noncomputable def parityBit (parity : V →+ ZMod 2) (x : V) : Bool := decide (parity x = 1)

theorem parityBit_eq_iff (parity : V →+ ZMod 2) (x y : V) :
    parityBit parity x = parityBit parity y ↔ parity x = parity y := by
  rcases zmod_two_cases (parity x) with hx | hx <;>
    rcases zmod_two_cases (parity y) with hy | hy <;> simp [parityBit, hx, hy]

theorem fiber_parity_iff_even_kernel (label : V →+ W) (parity : V →+ ZMod 2) :
    (∀ x y, label x = label y → parity x = parity y) ↔
      ∀ z, label z = 0 → parity z = 0 := by
  constructor
  · intro h z hz
    have he := h z 0 (by simpa using hz)
    simpa using he
  · intro h x y hxy
    have hz : label (x - y) = 0 := by simp [map_sub, hxy]
    have hp := h (x - y) hz
    simpa [map_sub, sub_eq_zero] using hp

theorem no_cancellation_iff_even_kernel [Fintype V] [Fintype W] [DecidableEq W]
    (label : V →+ W) (parity : V →+ ZMod 2) (weight : V → ℝ)
    (hw : ∀ x, 0 < weight x) :
    unsignedTotal weight = collectedTotal label (parityBit parity) weight ↔
      ∀ z, label z = 0 → parity z = 0 := by
  rw [total_equality_iff_fiber_parity label (parityBit parity) weight hw]
  simp_rw [parityBit_eq_iff]
  exact fiber_parity_iff_even_kernel label parity

theorem odd_kernel_strict_saving [Fintype V] [Fintype W] [DecidableEq W]
    (label : V →+ W) (parity : V →+ ZMod 2) (weight : V → ℝ)
    (hw : ∀ x, 0 < weight x) (z : V) (hz : label z = 0) (hp : parity z = 1) :
    collectedTotal label (parityBit parity) weight < unsignedTotal weight := by
  have hle := collected_le_unsigned label (parityBit parity) weight (fun x => (hw x).le)
  rcases lt_or_eq_of_le hle with hlt | heq
  · exact hlt
  · have hz0 := (no_cancellation_iff_even_kernel label parity weight hw).mp heq.symm z hz
    have h01 : (0 : ZMod 2) = 1 := hz0.symm.trans hp
    exact False.elim (zero_ne_one h01)

end Kernel

section BinarySelections

abbrev Selection (n : ℕ) := Fin n → ZMod 2

noncomputable def binaryLabel {n m : ℕ} (labels : Fin n → Fin m → ZMod 2) :
    Selection n →+ Selection m where
  toFun s k := ∑ j, s j * labels j k
  map_zero' := by
    funext k
    simp
  map_add' s t := by
    funext k
    simp [Pi.add_apply, add_mul, Finset.sum_add_distrib]

noncomputable def selectionParity {n : ℕ} : Selection n →+ ZMod 2 where
  toFun s := ∑ j, s j
  map_zero' := by simp
  map_add' s t := by simp [Pi.add_apply, Finset.sum_add_distrib]

noncomputable def selectionWeight {n : ℕ} (a b : Fin n → ℝ) (s : Selection n) : ℝ :=
  ∏ j, if s j = 0 then a j else b j

theorem selectionWeight_pos {n : ℕ} (a b : Fin n → ℝ)
    (ha : ∀ j, 0 < a j) (hb : ∀ j, 0 < b j) (s : Selection n) :
    0 < selectionWeight a b s := by
  apply Finset.prod_pos
  intro j _
  split_ifs
  · exact ha j
  · exact hb j

theorem zmod_two_sum (f : ZMod 2 → ℝ) : (∑ z, f z) = f 0 + f 1 := by
  change (∑ z : Fin 2, f z) = f 0 + f 1
  exact Fin.sum_univ_two f

theorem product_weight_total {n : ℕ} (a b : Fin n → ℝ) :
    unsignedTotal (selectionWeight a b) = ∏ j, (a j + b j) := by
  have h := Fintype.prod_sum (κ := fun _ : Fin n => ZMod 2)
    (fun j z => if z = 0 then a j else b j)
  have hs : ∀ j, (∑ z : ZMod 2, if z = 0 then a j else b j) = a j + b j := by
    intro j
    rw [zmod_two_sum]
    simp
  simp_rw [hs] at h
  exact h.symm

noncomputable def binaryCoefficient {n m : ℕ} (labels : Fin n → Fin m → ZMod 2)
    (a b : Fin n → ℝ) (g : Selection m) : ℝ :=
  ∑ s : Selection n, if binaryLabel labels s = g then
    (if selectionParity s = 0 then selectionWeight a b s else -selectionWeight a b s) else 0

theorem binary_coefficient_mass_difference {n m : ℕ} (labels : Fin n → Fin m → ZMod 2)
    (a b : Fin n → ℝ) (g : Selection m) :
    binaryCoefficient labels a b g =
      mass (binaryLabel labels) (parityBit selectionParity) (selectionWeight a b) g false -
      mass (binaryLabel labels) (parityBit selectionParity) (selectionWeight a b) g true := by
  rw [signed_fiber_formula]
  apply Finset.sum_congr rfl
  intro s _
  rcases zmod_two_cases (selectionParity s) with h | h <;> simp [parityBit, h]

theorem binary_collected_formula {n m : ℕ} (labels : Fin n → Fin m → ZMod 2)
    (a b : Fin n → ℝ) :
    collectedTotal (binaryLabel labels) (parityBit selectionParity) (selectionWeight a b) =
      ∑ g : Selection m, |binaryCoefficient labels a b g| := by
  simp only [binary_coefficient_mass_difference, collectedTotal]

theorem binary_no_cancellation_iff {n m : ℕ} (labels : Fin n → Fin m → ZMod 2)
    (a b : Fin n → ℝ) (ha : ∀ j, 0 < a j) (hb : ∀ j, 0 < b j) :
    (∏ j, (a j + b j)) = (∑ g : Selection m, |binaryCoefficient labels a b g|) ↔
      ∀ s : Selection n, binaryLabel labels s = 0 → selectionParity s = 0 := by
  rw [← product_weight_total a b, ← binary_collected_formula labels a b]
  exact no_cancellation_iff_even_kernel (binaryLabel labels) selectionParity (selectionWeight a b)
    (selectionWeight_pos a b ha hb)

theorem binary_exact_cancellation_gap {n m : ℕ} (labels : Fin n → Fin m → ZMod 2)
    (a b : Fin n → ℝ) :
    (∏ j, (a j + b j)) - (∑ g : Selection m, |binaryCoefficient labels a b g|) =
      2 * ∑ g : Selection m,
        min (mass (binaryLabel labels) (parityBit selectionParity) (selectionWeight a b) g false)
          (mass (binaryLabel labels) (parityBit selectionParity) (selectionWeight a b) g true) := by
  calc
    (∏ j, (a j + b j)) - (∑ g : Selection m, |binaryCoefficient labels a b g|) =
        unsignedTotal (selectionWeight a b) -
          collectedTotal (binaryLabel labels) (parityBit selectionParity) (selectionWeight a b) := by
      congr 1
      · exact (product_weight_total a b).symm
      · exact (binary_collected_formula labels a b).symm
    _ = _ := exact_cancellation_gap (binaryLabel labels) (parityBit selectionParity) (selectionWeight a b)

theorem binary_odd_dependency_strict_saving {n m : ℕ} (labels : Fin n → Fin m → ZMod 2)
    (a b : Fin n → ℝ) (ha : ∀ j, 0 < a j) (hb : ∀ j, 0 < b j)
    (s : Selection n) (hl : binaryLabel labels s = 0) (hp : selectionParity s = 1) :
    (∑ g : Selection m, |binaryCoefficient labels a b g|) < ∏ j, (a j + b j) := by
  rw [← product_weight_total a b, ← binary_collected_formula labels a b]
  exact odd_kernel_strict_saving (binaryLabel labels) selectionParity (selectionWeight a b)
    (selectionWeight_pos a b ha hb) s hl hp

end BinarySelections

section Examples

noncomputable def independentLabels : Fin 2 → Fin 2 → ZMod 2 :=
  fun j k => if j = k then 1 else 0

theorem independent_labels_have_even_kernel :
    ∀ s : Selection 2, binaryLabel independentLabels s = 0 → selectionParity s = 0 := by
  intro s hs
  have hlabel : binaryLabel independentLabels s = s := by
    funext k
    simp [binaryLabel, independentLabels, mul_ite]
  have hz : s = 0 := hlabel.symm.trans hs
  simp [hz]

theorem independent_labels_no_saving (a b : Fin 2 → ℝ)
    (ha : ∀ j, 0 < a j) (hb : ∀ j, 0 < b j) :
    (∏ j, (a j + b j)) = (∑ g : Selection 2, |binaryCoefficient independentLabels a b g|) := by
  exact (binary_no_cancellation_iff independentLabels a b ha hb).mpr
    independent_labels_have_even_kernel

noncomputable def triangleLabels : Fin 3 → Fin 2 → ZMod 2 := fun j k =>
  if j = 0 then (if k = 0 then 1 else 0)
  else if j = 1 then (if k = 1 then 1 else 0)
  else 1

theorem triangle_odd_dependency_label :
    binaryLabel triangleLabels (fun _ : Fin 3 => 1) = 0 := by
  funext k
  rcases (by decide : ∀ k : Fin 2, k = 0 ∨ k = 1) k with h | h <;> subst k <;>
    norm_num [binaryLabel, triangleLabels, Fin.sum_univ_succ] <;> decide

theorem triangle_odd_dependency_parity :
    selectionParity (fun _ : Fin 3 => 1) = 1 := by
  norm_num [selectionParity, Fin.sum_univ_succ]
  decide

theorem triangle_strict_saving (a b : Fin 3 → ℝ)
    (ha : ∀ j, 0 < a j) (hb : ∀ j, 0 < b j) :
    (∑ g : Selection 2, |binaryCoefficient triangleLabels a b g|) < ∏ j, (a j + b j) := by
  exact binary_odd_dependency_strict_saving triangleLabels a b ha hb
    (fun _ => 1) triangle_odd_dependency_label triangle_odd_dependency_parity

end Examples

end PECParity
