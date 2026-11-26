import UniformMeanMeasure
import OccupancySensitivity
import Mathlib.Data.Finset.Max

open scoped BigOperators

namespace TwoColorNullity.Occupancy

def CoordinateOscillation {Label : Type*} {m : ℕ} (f : (Fin m → Label) → ℝ) : Prop :=
  ∀ x y : Fin m → Label, ∀ changed : Fin m,
    (∀ j, j ≠ changed → x j = y j) → |f x - f y| ≤ 2

private theorem section_oscillation {Label : Type*} {m : ℕ}
    {f : (Fin (m + 1) → Label) → ℝ} (hf : CoordinateOscillation f) (a : Label) :
    CoordinateOscillation (fun tail => f (Fin.cons a tail)) := by
  intro x y changed h
  apply hf (Fin.cons a x) (Fin.cons a y) changed.succ
  intro j
  refine Fin.cases ?_ ?_ j
  · intro _
    rfl
  · intro k hk
    exact h k (fun e => hk (congrArg Fin.succ e))

private theorem section_head_difference {Label : Type*} {m : ℕ}
    {f : (Fin (m + 1) → Label) → ℝ} (hf : CoordinateOscillation f)
    (a b : Label) (tail : Fin m → Label) :
    |f (Fin.cons a tail) - f (Fin.cons b tail)| ≤ 2 := by
  apply hf (Fin.cons a tail) (Fin.cons b tail) 0
  intro j
  refine Fin.cases ?_ ?_ j
  · intro h
    exact (h rfl).elim
  · intro k _
    rfl

set_option maxHeartbeats 800000 in
/-- Sequentially expose one uniform coordinate and use Hoeffding's lemma at each step. -/
theorem finiteMean_boundedDifferences_mgf {Label : Type*} [Fintype Label] [Nonempty Label] (m : ℕ)
    (f : (Fin m → Label) → ℝ) (hf : CoordinateOscillation f) (t : ℝ) :
    finiteMean (fun x => Real.exp (t * (f x - finiteMean f))) ≤ Real.exp ((m : ℝ) * t ^ 2 / 2) := by
  classical
  induction m with
  | zero =>
    let empty : Fin 0 → Label := Fin.elim0
    have hc (x : Fin 0 → Label) : f x = f empty := congrArg f (Subsingleton.elim _ _)
    have hmean : finiteMean f = f empty :=
      (congrArg finiteMean (funext hc)).trans (finiteMean_const _)
    simp [hc, hmean, finiteMean_const]
  | succ m ih =>
    let g (a : Label) := finiteMean (fun tail : Fin m → Label => f (Fin.cons a tail))
    have htotal : finiteMean f = finiteMean g := finiteMean_cons f
    have hg (a b : Label) : g a ≤ g b + 2 := by
      calc
        g a ≤ finiteMean (fun tail : Fin m → Label => f (Fin.cons b tail) + 2) := by
          apply finiteMean_mono
          intro tail
          have h := (abs_le.mp (section_head_difference hf a b tail)).2
          linarith
        _ = g b + 2 := by rw [finiteMean_add, finiteMean_const]
    obtain ⟨a₀, _, hmin⟩ := Finset.exists_min_image Finset.univ g Finset.univ_nonempty
    have hhead := finiteMean_hoeffding_width_two g (g a₀)
      (fun a => ⟨hmin a (Finset.mem_univ _), hg a a₀⟩) t
    let weight (a : Label) := Real.exp (t * (g a - finiteMean g))
    let residual (a : Label) := finiteMean (fun z : Fin m → Label =>
      Real.exp (t * (f (Fin.cons a z) - g a)))
    have hsplit (a : Label) :
        finiteMean (fun z : Fin m → Label => Real.exp (t * (f (Fin.cons a z) - finiteMean f))) =
          weight a * residual a := by
      unfold weight residual
      rw [← finiteMean_const_mul]
      apply congrArg finiteMean
      funext z
      rw [← Real.exp_add, htotal]
      congr 1
      ring
    have htail (a : Label) : residual a ≤ Real.exp ((m : ℝ) * t ^ 2 / 2) :=
      ih (fun z => f (Fin.cons a z)) (section_oscillation hf a)
    calc
      _ = finiteMean (fun a : Label => finiteMean fun z : Fin m → Label =>
        Real.exp (t * (f (Fin.cons a z) - finiteMean f))) :=
        finiteMean_cons (m := m) (fun x : Fin (m + 1) → Label => Real.exp (t * (f x - finiteMean f)))
      _ = finiteMean (fun a => weight a * residual a) := congrArg finiteMean (funext hsplit)
      _ ≤ finiteMean (fun a => weight a * Real.exp ((m : ℝ) * t ^ 2 / 2)) :=
        finiteMean_mono fun a => mul_le_mul_of_nonneg_left (htail a) (Real.exp_pos _).le
      _ = finiteMean weight * Real.exp ((m : ℝ) * t ^ 2 / 2) := finiteMean_mul_const _ _
      _ ≤ Real.exp (t ^ 2 / 2) * Real.exp ((m : ℝ) * t ^ 2 / 2) :=
        mul_le_mul_of_nonneg_right hhead (Real.exp_pos _).le
      _ = _ := by
        rw [← Real.exp_add]
        congr 1
        push_cast
        ring

theorem finiteMean_boundedDifferences_upperTail {Label : Type*} [Fintype Label] [Nonempty Label] (m : ℕ)
    (f : (Fin m → Label) → ℝ) (hf : CoordinateOscillation f) (t : ℝ) (ht : 0 ≤ t) :
    finiteProbability (fun x => t ≤ f x - finiteMean f) ≤ Real.exp (-(t ^ 2) / (2 * (m : ℝ))) :=
  finiteProbability_ge_of_averaged_mgf _ m (finiteMean_boundedDifferences_mgf m f hf) t ht

theorem finiteMean_boundedDifferences_lowerTail {Label : Type*} [Fintype Label] [Nonempty Label] (m : ℕ)
    (f : (Fin m → Label) → ℝ) (hf : CoordinateOscillation f) (t : ℝ) (ht : 0 ≤ t) :
    finiteProbability (fun x => t ≤ -(f x - finiteMean f)) ≤ Real.exp (-(t ^ 2) / (2 * (m : ℝ))) := by
  apply finiteProbability_ge_of_averaged_mgf _ m _ t ht
  intro u
  simpa only [neg_mul, mul_neg, neg_sq] using finiteMean_boundedDifferences_mgf m f hf (-u)

theorem finiteProbability_union_two {Sample : Type*} [Fintype Sample]
    (first second : Sample → Prop) :
    finiteProbability (fun x => first x ∨ second x) ≤ finiteProbability first + finiteProbability second := by
  classical
  let evt (b : Bool) (x : Sample) := if b then first x else second x
  let sides : Finset Bool := {true, false}
  have h (x : Sample) : (first x ∨ second x) ↔ ∃ b ∈ sides, evt b x := by
    constructor
    · rintro (h | h)
      · exact ⟨true, by simp [sides], by simpa [evt] using h⟩
      · exact ⟨false, Finset.mem_univ _, by simpa [evt] using h⟩
    · rintro ⟨b, _, hb⟩
      cases b
      · exact Or.inr (by simpa [evt] using hb)
      · exact Or.inl (by simpa [evt] using hb)
  rw [show (fun x => first x ∨ second x) = (fun x => ∃ b ∈ sides, evt b x) from
    funext fun x => propext (h x)]
  simpa [evt, sides, Finset.sum_insert] using
    finiteProbability_union_bound (witnesses := sides) evt

theorem finiteMean_boundedDifferences_twoTails {Label : Type*} [Fintype Label] [Nonempty Label] (m : ℕ)
    (f : (Fin m → Label) → ℝ) (hf : CoordinateOscillation f) (t : ℝ) (ht : 0 ≤ t) :
    finiteProbability (fun x => t ≤ |f x - finiteMean f|) ≤ 2 * Real.exp (-(t ^ 2) / (2 * (m : ℝ))) := by
  have h :
      finiteProbability (fun x => t ≤ |f x - finiteMean f|) ≤
        finiteProbability (fun x => t ≤ f x - finiteMean f ∨ t ≤ -(f x - finiteMean f)) := by
    apply finiteProbability_mono
    intro x hx
    rwa [abs_eq_max_neg, le_max_iff] at hx
  refine h.trans ((finiteProbability_union_two _ _).trans ?_)
  rw [two_mul]
  exact add_le_add (finiteMean_boundedDifferences_upperTail m f hf t ht)
    (finiteMean_boundedDifferences_lowerTail m f hf t ht)

theorem restrictedOddCount_twoTails {Label : Type*} [Fintype Label] [DecidableEq Label] [Nonempty Label]
    (m : ℕ) (targets : Finset Label) (t : ℝ) (ht : 0 ≤ t) :
    finiteProbability (fun bins : Fin m → Label => t ≤ |(restrictedOddCount targets bins : ℝ) -
      finiteMean (fun draws : Fin m → Label => (restrictedOddCount targets draws : ℝ))|) ≤
      2 * Real.exp (-(t ^ 2) / (2 * (m : ℝ))) :=
  finiteMean_boundedDifferences_twoTails m _ (restrictedOddCount_bounded_difference targets) t ht

end TwoColorNullity.Occupancy
