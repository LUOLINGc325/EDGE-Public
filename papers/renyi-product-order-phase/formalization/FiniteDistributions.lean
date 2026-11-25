import Core
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Data.Fintype.BigOperators

/-! Finite probability masses, mixtures, and finite channels. -/

open scoped BigOperators
open Classical

namespace RenyiProductOrderPhase

structure FiniteMass (ι : Type*) [Fintype ι] where
  weight : ι → ℝ
  weight_nonneg : ∀ i, 0 ≤ weight i
  total : ∑ i, weight i = 1

namespace FiniteMass

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

instance : CoeFun (FiniteMass ι) (fun _ => ι → ℝ) := ⟨weight⟩

@[ext] theorem ext {p q : FiniteMass ι} (h : ∀ i, p i = q i) : p = q := by
  cases p
  cases q
  cases funext h
  rfl

theorem exists_weight_pos (p : FiniteMass ι) : ∃ i, 0 < p i := by
  by_contra! h
  have hz (i : ι) : p i = 0 := le_antisymm (h i) (p.weight_nonneg i)
  have ht : (∑ i, p i) = (1 : ℝ) := p.total
  simp only [hz, Finset.sum_const_zero] at ht
  exact zero_ne_one ht

noncomputable def expect (p : FiniteMass ι) (f : ι → ℝ) : ℝ := ∑ i, p i * f i

theorem expect_const (p : FiniteMass ι) (c : ℝ) :
    p.expect (fun _ => c) = c := by
  unfold expect
  rw [← Finset.sum_mul, p.total, one_mul]

theorem expect_mono (p : FiniteMass ι) {f g : ι → ℝ} (h : ∀ i, f i ≤ g i) :
    p.expect f ≤ p.expect g :=
  Finset.sum_le_sum (fun i _ => mul_le_mul_of_nonneg_left (h i) (p.weight_nonneg i))

theorem expect_pos (p : FiniteMass ι) {f : ι → ℝ} (hf : ∀ i, 0 ≤ f i)
    {i : ι} (hp : 0 < p i) (hi : 0 < f i) : 0 < p.expect f :=
  (mul_pos hp hi).trans_le
    (Finset.single_le_sum (fun j _ => mul_nonneg (p.weight_nonneg j) (hf j))
      (Finset.mem_univ i))

theorem expect_strict (p : FiniteMass ι) {f g : ι → ℝ} (hle : ∀ i, f i ≤ g i)
    {i : ι} (hp : 0 < p i) (hlt : f i < g i) : p.expect f < p.expect g :=
  Finset.sum_lt_sum
    (fun j _ => mul_le_mul_of_nonneg_left (hle j) (p.weight_nonneg j))
    ⟨i, Finset.mem_univ i, mul_lt_mul_of_pos_left hlt hp⟩

noncomputable def dirac (i : ι) : FiniteMass ι where
  weight j := if j = i then 1 else 0
  weight_nonneg j := by split <;> norm_num
  total := by classical simp

@[simp] theorem dirac_apply (i j : ι) : dirac i j = if j = i then 1 else 0 := by
  classical
  rfl

theorem dirac_expect (i : ι) (f : ι → ℝ) : (dirac i).expect f = f i := by
  classical
  simp [expect, ite_mul]

noncomputable def mix (p q : FiniteMass ι) (t : ℝ) (ht : t ∈ Set.Icc (0 : ℝ) 1) :
    FiniteMass ι where
  weight i := t * p i + (1 - t) * q i
  weight_nonneg i := add_nonneg (mul_nonneg ht.1 (p.weight_nonneg i))
    (mul_nonneg (sub_nonneg.mpr ht.2) (q.weight_nonneg i))
  total := by
    rw [Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum, p.total, q.total]
    ring

@[simp] theorem mix_apply (p q : FiniteMass ι) (t : ℝ) (ht : t ∈ Set.Icc (0 : ℝ) 1)
    (i : ι) : mix p q t ht i = t * p i + (1 - t) * q i := rfl

theorem mix_pos_left (p q : FiniteMass ι) {t : ℝ} (ht : t ∈ Set.Icc (0 : ℝ) 1)
    (htp : 0 < t) {i : ι} (hp : 0 < p i) : 0 < mix p q t ht i := by
  rw [mix_apply]
  exact add_pos_of_pos_of_nonneg (mul_pos htp hp)
    (mul_nonneg (sub_nonneg.mpr ht.2) (q.weight_nonneg i))

/-- Propagating a mass through a channel on two finite alphabets. -/
noncomputable def push (p : FiniteMass ι) (w : ι → FiniteMass κ) : FiniteMass κ where
  weight j := ∑ i, p i * w i j
  weight_nonneg j := Finset.sum_nonneg (fun i _ => mul_nonneg (p.weight_nonneg i)
    ((w i).weight_nonneg j))
  total := by
    rw [Finset.sum_comm]
    calc
      (∑ i, ∑ j, p i * w i j) = ∑ i, p i := by
        refine Finset.sum_congr rfl (fun i _ => ?_)
        rw [← Finset.mul_sum, (w i).total, mul_one]
      _ = 1 := p.total

@[simp] theorem push_apply (p : FiniteMass ι) (w : ι → FiniteMass κ) (j : κ) :
    p.push w j = ∑ i, p i * w i j := rfl

theorem push_dirac (w : ι → FiniteMass κ) (i : ι) : (dirac i).push w = w i := by
  ext j
  exact dirac_expect i (fun x => w x j)

theorem push_mix (p q : FiniteMass ι) (w : ι → FiniteMass κ) (t : ℝ)
    (ht : t ∈ Set.Icc (0 : ℝ) 1) :
    (mix p q t ht).push w = mix (p.push w) (q.push w) t ht := by
  ext j
  simp only [mix_apply, push_apply, add_mul, mul_assoc, Finset.sum_add_distrib, Finset.mul_sum]

theorem push_pos (p : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i j, 0 < w i j) (j : κ) : 0 < p.push w j := by
  obtain ⟨i, hi⟩ := p.exists_weight_pos
  exact p.expect_pos (fun k => (hw k j).le) hi (hw i j)

def AbsolutelyContinuous (p q : FiniteMass ι) : Prop := ∀ i, q i = 0 → p i = 0

theorem AbsolutelyContinuous.reference_pos {p q : FiniteMass ι}
    (h : p.AbsolutelyContinuous q) {i : ι} (hi : 0 < p i) : 0 < q i := by
  by_contra! hq
  exact hi.ne' (h i (le_antisymm hq (q.weight_nonneg i)))

theorem absolutelyContinuous_of_pos (p q : FiniteMass ι) (hq : ∀ i, 0 < q i) :
    p.AbsolutelyContinuous q := fun i hi => ((hq i).ne' hi).elim

theorem absolutelyContinuous_dirac_mix (i j : ι) {t : ℝ}
    (ht : t ∈ Set.Icc (0 : ℝ) 1) (htp : 0 < t) :
    (dirac i).AbsolutelyContinuous (mix (dirac i) (dirac j) t ht) := by
  classical
  intro k hk
  by_cases hki : k = i
  · subst k
    have hi : 0 < dirac i i := by simp
    exact ((mix_pos_left _ _ ht htp hi).ne' hk).elim
  · simp [hki]

end FiniteMass

end RenyiProductOrderPhase
