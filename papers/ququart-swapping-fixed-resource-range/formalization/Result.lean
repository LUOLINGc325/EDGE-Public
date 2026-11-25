import Lean
import Mathlib.Data.Real.Sqrt
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.FieldSimp
import Mathlib.Data.Complex.Norm

/- Fixed-resource ququart swapping: complete explicit-protocol proof.
   Lean 4.19.0; mathlib c44e0c8ee63ca166450922a373c7409c5d26b00b.
   The final command inventories every new declaration and its transitive axioms. -/

-- Source section: Core.lean
namespace QuquartSwapping

noncomputable section

noncomputable abbrev Vec := Fin 4 → ℝ

noncomputable def normSq (a : Vec) : ℝ := a 0 ^ 2 + a 1 ^ 2 + a 2 ^ 2 + a 3 ^ 2

noncomputable def valid (a : Vec) : Prop := (∀ i, 0 ≤ a i) ∧ normSq a = 1

noncomputable def ent (a : Vec) : ℝ :=
  2 * (a 0 * a 1 + a 0 * a 2 + a 0 * a 3 + a 1 * a 2 + a 1 * a 3 + a 2 * a 3)

noncomputable def opp (a : Vec) : ℝ := 2 * (a 0 * a 2 + a 1 * a 3)

noncomputable def feasible (e t : ℝ) : Prop :=
  0 ≤ e ∧ e ≤ 3 ∧ 0 ≤ t ∧ t ≤ 1 ∧ t ≤ e ∧ e - 1 ≤ 2 * t

noncomputable def transfer (e f t u : ℝ) : ℝ := (e - t) * (f - u) / 2 + t * u

noncomputable def lower (e f : ℝ) : ℝ :=
  if e ≤ 1 then (if f ≤ 1 then 0 else e * (f - 1) / 2)
  else (if f ≤ 1 then f * (e - 1) / 2 else (e*f + e + f - 3) / 4)

noncomputable def upper (e f : ℝ) : ℝ :=
  if e ≤ 1 then (if f ≤ 1 then e * f else e)
  else (if f ≤ 1 then f else 1 + (e - 1) * (f - 1) / 2)

noncomputable def average (a b : Vec) : ℝ :=
  ∑ p : Fin 4, ∑ j : Fin 4, ∑ k : Fin 4,
    if j = k then 0 else a (p+j) * a (p+k) * b j * b k

end
end QuquartSwapping


-- Source section: Model.lean
namespace QuquartSwapping

noncomputable section

noncomputable abbrev CVec := Fin 4 → ℂ

noncomputable def magnitude (c : CVec) : Vec := fun i => ‖c i‖

noncomputable def inputEnt (c : CVec) : ℝ :=
  ∑ j : Fin 4, ∑ k : Fin 4, if j = k then 0 else ‖c j * c k‖

noncomputable def bellAmplitude (c b : CVec) (p q j : Fin 4) : ℂ :=
  c (p+j) * b j * (-Complex.I) ^ (q.val * j.val) / 2

noncomputable def mass (v : CVec) : ℝ := ∑ j : Fin 4, ‖v j‖ ^ 2

noncomputable def outcome (v : CVec) : ℝ :=
  if mass v = 0 then 0
  else mass v * inputEnt (fun j => v j / (Real.sqrt (mass v) : ℂ))

noncomputable def bellAverage (c b : CVec) : ℝ :=
  ∑ p : Fin 4, ∑ q : Fin 4, outcome (bellAmplitude c b p q)

lemma normSq_sum (a : Vec) : normSq a = ∑ i : Fin 4, a i ^ 2 := by
  simp [normSq, Fin.sum_univ_succ]
  ring

lemma inputEnt_magnitude (c : CVec) : inputEnt c = ent (magnitude c) := by
  simp [inputEnt, ent, magnitude, Fin.sum_univ_succ, Complex.norm_mul]
  ring

lemma magnitude_valid (c : CVec) (hc : mass c = 1) : valid (magnitude c) := by
  refine ⟨fun i => norm_nonneg _, ?_⟩
  simpa [normSq_sum, magnitude, mass] using hc

lemma norm_bellAmplitude (c b : CVec) (p q j : Fin 4) :
    ‖bellAmplitude c b p q j‖ = ‖c (p+j)‖ * ‖b j‖ / 2 := by
  simp [bellAmplitude, Complex.norm_div, Complex.norm_mul, Complex.norm_pow]

lemma mass_nonneg (v : CVec) : 0 ≤ mass v := by
  exact Finset.sum_nonneg (fun i _ => sq_nonneg _)

lemma mass_zero (v : CVec) (hv : mass v = 0) : ∀ i, v i = 0 := by
  intro i
  have hi : ‖v i‖ ^ 2 ≤ mass v := by
    apply Finset.single_le_sum (fun j _ => sq_nonneg _) (Finset.mem_univ i)
  have hn : ‖v i‖ = 0 := by nlinarith [norm_nonneg (v i)]
  exact norm_eq_zero.mp hn

lemma inputEnt_div (v : CVec) (r : ℝ) (hr : 0 < r) :
    inputEnt (fun j => v j / (r : ℂ)) = inputEnt v / r^2 := by
  rw [inputEnt_magnitude, inputEnt_magnitude]
  simp [ent, magnitude, Complex.norm_div, abs_of_pos hr]
  ring

lemma outcome_eq (v : CVec) : outcome v = inputEnt v := by
  by_cases h : mass v = 0
  · have hz := mass_zero v h
    simp [outcome, h, inputEnt, hz]
  · have hp : 0 < mass v := lt_of_le_of_ne (mass_nonneg v) (Ne.symm h)
    rw [outcome, if_neg h, inputEnt_div v (Real.sqrt (mass v)) (Real.sqrt_pos.2 hp)]
    rw [Real.sq_sqrt (mass_nonneg v)]
    field_simp

lemma mass_div (v : CVec) (r : ℝ) (hr : 0 < r) :
    mass (fun j => v j / (r : ℂ)) = mass v / r^2 := by
  simp [mass, Complex.norm_div, abs_of_pos hr, Fin.sum_univ_succ]
  ring

lemma normalized_mass (v : CVec) (hv : mass v ≠ 0) :
    mass (fun j => v j / (Real.sqrt (mass v) : ℂ)) = 1 := by
  have hp : 0 < mass v := lt_of_le_of_ne (mass_nonneg v) (Ne.symm hv)
  rw [mass_div v _ (Real.sqrt_pos.2 hp), Real.sq_sqrt (mass_nonneg v)]
  exact div_self hv

lemma total_bell_mass (c b : CVec) :
    (∑ p : Fin 4, ∑ q : Fin 4, mass (bellAmplitude c b p q)) = mass c * mass b := by
  simp only [mass, norm_bellAmplitude]
  simp [Fin.sum_univ_succ]
  ring

lemma total_bell_probability (c b : CVec) (hc : mass c = 1) (hb : mass b = 1) :
    (∑ p : Fin 4, ∑ q : Fin 4, mass (bellAmplitude c b p q)) = 1 := by
  rw [total_bell_mass, hc, hb, mul_one]

lemma schmidt_index_injective (p : Fin 4) : Function.Injective (fun j : Fin 4 => p+j) := by
  intro j k h
  exact add_left_cancel h

lemma average_transfer (a b : Vec) :
    average a b = transfer (ent a) (ent b) (opp a) (opp b) := by
  simp [average, transfer, ent, opp, Fin.sum_univ_succ]
  ring

lemma bellAverage_average (c b : CVec) :
    bellAverage c b = average (magnitude c) (magnitude b) := by
  simp only [bellAverage, outcome_eq, inputEnt]
  simp only [Complex.norm_mul, norm_bellAmplitude]
  simp [average, magnitude, Fin.sum_univ_succ]
  ring

theorem bellAverage_transfer (c b : CVec) :
    bellAverage c b = transfer (inputEnt c) (inputEnt b)
      (opp (magnitude c)) (opp (magnitude b)) := by
  rw [bellAverage_average, average_transfer, inputEnt_magnitude, inputEnt_magnitude]

end
end QuquartSwapping


-- Source section: Feasibility.lean
namespace QuquartSwapping

theorem valid_feasible (a : Vec) (ha : valid a) :
    feasible (ent a) (opp a) := by
  rcases ha with ⟨ha, hn⟩
  have h0 := ha 0
  have h1 := ha 1
  have h2 := ha 2
  have h3 := ha 3
  dsimp [normSq] at hn
  dsimp [feasible, ent, opp]
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · nlinarith only [mul_nonneg h0 h1, mul_nonneg h0 h2,
      mul_nonneg h0 h3, mul_nonneg h1 h2, mul_nonneg h1 h3,
      mul_nonneg h2 h3]
  · nlinarith only [hn, sq_nonneg (a 0 - a 1), sq_nonneg (a 0 - a 2),
      sq_nonneg (a 0 - a 3), sq_nonneg (a 1 - a 2),
      sq_nonneg (a 1 - a 3), sq_nonneg (a 2 - a 3)]
  · nlinarith only [mul_nonneg h0 h2, mul_nonneg h1 h3]
  · nlinarith only [hn, sq_nonneg (a 0 - a 2), sq_nonneg (a 1 - a 3)]
  · nlinarith only [mul_nonneg h0 h1, mul_nonneg h0 h3,
      mul_nonneg h1 h2, mul_nonneg h2 h3]
  · nlinarith only [hn, sq_nonneg (a 0 + a 2 - a 1 - a 3)]

theorem ent_add_norm_eq_sum_sq (a : Vec) :
    ent a + normSq a = (a 0 + a 1 + a 2 + a 3) ^ 2 := by
  dsimp [ent, normSq]
  ring

theorem feasible_realizable (e t : ℝ) (het : feasible e t) :
    ∃ a : Vec, valid a ∧ ent a = e ∧ opp a = t := by
  rcases het with ⟨he0, he3, ht0, ht1, hte, het⟩
  let s : ℝ := Real.sqrt (e + 1)
  let h : ℝ := Real.sqrt (1 - e + 2 * t)
  let u : ℝ := (s + h) / 2
  let v : ℝ := (s - h) / 2
  let r : ℝ := Real.sqrt ((1 - t) / (1 + t))
  have hs0 : 0 ≤ s := Real.sqrt_nonneg _
  have hh0 : 0 ≤ h := Real.sqrt_nonneg _
  have hs2 : s ^ 2 = e + 1 := Real.sq_sqrt (by linarith only [he0])
  have hh2 : h ^ 2 = 1 - e + 2 * t := Real.sq_sqrt (by linarith only [het])
  have hhs : h ≤ s := by nlinarith only [hs2, hh2, hte, hs0, hh0]
  have hu0 : 0 ≤ u := by dsimp [u]; linarith only [hs0, hh0]
  have hv0 : 0 ≤ v := by dsimp [v]; linarith only [hhs]
  have huv : u ^ 2 + v ^ 2 = 1 + t := by
    dsimp [u, v]
    nlinarith only [hs2, hh2]
  have hus : u + v = s := by dsimp [u, v]; ring
  have hden : 0 < 1 + t := by linarith only [ht0]
  have hr0 : 0 ≤ r := Real.sqrt_nonneg _
  have hr2 : r ^ 2 = (1 - t) / (1 + t) :=
    Real.sq_sqrt (div_nonneg (by linarith only [ht1]) (le_of_lt hden))
  have hrr : (1 + t) * r ^ 2 = 1 - t := by
    rw [hr2]
    field_simp [ne_of_gt hden]
  have hr1 : r ≤ 1 := by
    have hquot : (1 - t) / (1 + t) ≤ 1 :=
      (div_le_one hden).mpr (by linarith only [ht0])
    nlinarith only [hr2, hquot, hr0]
  have hnorm : (u ^ 2 + v ^ 2) * (1 + r ^ 2) = 2 := by
    rw [huv]
    nlinarith only [hrr]
  have hopp : (u ^ 2 + v ^ 2) * (1 - r ^ 2) = 2 * t := by
    rw [huv]
    nlinarith only [hrr]
  let a : Vec := ![u * (1 + r) / 2, v * (1 + r) / 2,
    u * (1 - r) / 2, v * (1 - r) / 2]
  have ha0 : ∀ i, 0 ≤ a i := by
    intro i
    fin_cases i <;> simp only [a, Matrix.cons_val_zero,
      Matrix.cons_val_one, Matrix.cons_val_two, Matrix.cons_val_three]
    · exact div_nonneg (mul_nonneg hu0 (by linarith only [hr0])) (by norm_num)
    · exact div_nonneg (mul_nonneg hv0 (by linarith only [hr0])) (by norm_num)
    · exact div_nonneg (mul_nonneg hu0 (by linarith only [hr1])) (by norm_num)
    · exact div_nonneg (mul_nonneg hv0 (by linarith only [hr1])) (by norm_num)
  have han : normSq a = 1 := by
    calc
      normSq a = (u ^ 2 + v ^ 2) * (1 + r ^ 2) / 2 := by
        dsimp [normSq, a]
        ring
      _ = 1 := by rw [hnorm]; norm_num
  have has : a 0 + a 1 + a 2 + a 3 = s := by
    calc
      a 0 + a 1 + a 2 + a 3 = u + v := by dsimp [a]; ring
      _ = s := hus
  refine ⟨a, ⟨ha0, han⟩, ?_, ?_⟩
  · have hi := ent_add_norm_eq_sum_sq a
    rw [han, has, hs2] at hi
    linarith only [hi]
  · calc
      opp a = (u ^ 2 + v ^ 2) * (1 - r ^ 2) / 2 := by
        dsimp [opp, a]
        ring
      _ = t := by rw [hopp]; ring

theorem feasibility_exact (e t : ℝ) :
    feasible e t ↔ ∃ a : Vec, valid a ∧ ent a = e ∧ opp a = t := by
  constructor
  · exact feasible_realizable e t
  · rintro ⟨a, ha, he, ht⟩
    rw [← he, ← ht]
    exact valid_feasible a ha

end QuquartSwapping


-- Source section: Optimization.lean
noncomputable section

namespace QuquartSwapping

noncomputable def oppLow (e : ℝ) : ℝ := max 0 ((e - 1) / 2)
noncomputable def oppHigh (e : ℝ) : ℝ := min e 1

theorem feasible_iff_interval (e t : ℝ) :
    feasible e t ↔ 0 ≤ e ∧ e ≤ 3 ∧ oppLow e ≤ t ∧ t ≤ oppHigh e := by
  unfold feasible oppLow oppHigh
  constructor
  · rintro ⟨he0, he3, ht0, ht1, hte, het⟩
    exact ⟨he0, he3, max_le ht0 (by linarith), le_min hte ht1⟩
  · rintro ⟨he0, he3, hlt, hth⟩
    exact ⟨he0, he3, le_trans (le_max_left _ _) hlt,
      le_trans hth (min_le_right _ _), le_trans hth (min_le_left _ _),
      by have := le_trans (le_max_right 0 ((e-1)/2)) hlt; linarith⟩

theorem oppLow_le_oppHigh {e : ℝ} (he0 : 0 ≤ e) (he3 : e ≤ 3) :
    oppLow e ≤ oppHigh e := by
  unfold oppLow oppHigh
  exact max_le (le_min he0 (by norm_num))
    (le_min (by linarith) (by linarith))

theorem feasible_low {e : ℝ} (he0 : 0 ≤ e) (he3 : e ≤ 3) :
    feasible e (oppLow e) := by
  rw [feasible_iff_interval]
  exact ⟨he0, he3, le_refl _, oppLow_le_oppHigh he0 he3⟩

theorem feasible_high {e : ℝ} (he0 : 0 ≤ e) (he3 : e ≤ 3) :
    feasible e (oppHigh e) := by
  rw [feasible_iff_interval]
  exact ⟨he0, he3, oppLow_le_oppHigh he0 he3, le_refl _⟩

private theorem affine_lower {a b l h x m : ℝ}
    (hlx : l ≤ x) (hxh : x ≤ h) (hl : m ≤ a*l+b) (hh : m ≤ a*h+b) :
    m ≤ a*x+b := by
  by_cases ha : 0 ≤ a
  · nlinarith [mul_nonneg ha (sub_nonneg.mpr hlx)]
  · nlinarith [mul_nonneg (le_of_lt (neg_pos.mpr (lt_of_not_ge ha)))
      (sub_nonneg.mpr hxh)]

private theorem affine_upper {a b l h x m : ℝ}
    (hlx : l ≤ x) (hxh : x ≤ h) (hl : a*l+b ≤ m) (hh : a*h+b ≤ m) :
    a*x+b ≤ m := by
  by_cases ha : 0 ≤ a
  · nlinarith [mul_nonneg ha (sub_nonneg.mpr hxh)]
  · nlinarith [mul_nonneg (le_of_lt (neg_pos.mpr (lt_of_not_ge ha)))
      (sub_nonneg.mpr hlx)]

private theorem transfer_affine_t (e f t u : ℝ) :
    transfer e f t u = ((3*u-f)/2)*t + e*(f-u)/2 := by
  unfold transfer
  ring

private theorem transfer_affine_u (e f t u : ℝ) :
    transfer e f t u = ((3*t-e)/2)*u + f*(e-t)/2 := by
  unfold transfer
  ring

private theorem rectangle_bounds {e f t u l h m n L U : ℝ}
    (hlt : l ≤ t) (hth : t ≤ h) (hmu : m ≤ u) (hun : u ≤ n)
    (hlm : L ≤ transfer e f l m ∧ transfer e f l m ≤ U)
    (hln : L ≤ transfer e f l n ∧ transfer e f l n ≤ U)
    (hhm : L ≤ transfer e f h m ∧ transfer e f h m ≤ U)
    (hhn : L ≤ transfer e f h n ∧ transfer e f h n ≤ U) :
    L ≤ transfer e f t u ∧ transfer e f t u ≤ U := by
  have hl : L ≤ transfer e f l u ∧ transfer e f l u ≤ U := by
    simp only [transfer_affine_u] at hlm hln ⊢
    exact ⟨affine_lower hmu hun hlm.1 hln.1, affine_upper hmu hun hlm.2 hln.2⟩
  have hh : L ≤ transfer e f h u ∧ transfer e f h u ≤ U := by
    simp only [transfer_affine_u] at hhm hhn ⊢
    exact ⟨affine_lower hmu hun hhm.1 hhn.1, affine_upper hmu hun hhm.2 hhn.2⟩
  simp only [transfer_affine_t] at hl hh ⊢
  exact ⟨affine_lower hlt hth hl.1 hh.1, affine_upper hlt hth hl.2 hh.2⟩

theorem transfer_lower_endpoint {e f : ℝ}
    (_he0 : 0 ≤ e) (_he3 : e ≤ 3) (_hf0 : 0 ≤ f) (_hf3 : f ≤ 3) :
    transfer e f (oppHigh e) (oppLow f) = lower e f := by
  unfold oppHigh oppLow lower transfer
  split_ifs with he hf hf
  · rw [min_eq_left he, max_eq_left (by linarith : (f-1)/2 ≤ 0)]
    ring
  · rw [min_eq_left he, max_eq_right (by linarith : 0 ≤ (f-1)/2)]
    ring
  · rw [min_eq_right (by linarith : 1 ≤ e), max_eq_left (by linarith : (f-1)/2 ≤ 0)]
    ring
  · rw [min_eq_right (by linarith : 1 ≤ e), max_eq_right (by linarith : 0 ≤ (f-1)/2)]
    ring

theorem transfer_upper_endpoint {e f : ℝ}
    (_he0 : 0 ≤ e) (_he3 : e ≤ 3) (_hf0 : 0 ≤ f) (_hf3 : f ≤ 3) :
    transfer e f (oppHigh e) (oppHigh f) = upper e f := by
  unfold oppHigh upper transfer
  split_ifs with he hf hf
  · rw [min_eq_left he, min_eq_left hf]
    ring
  · rw [min_eq_left he, min_eq_right (by linarith : 1 ≤ f)]
    ring
  · rw [min_eq_right (by linarith : 1 ≤ e), min_eq_left hf]
    ring
  · rw [min_eq_right (by linarith : 1 ≤ e), min_eq_right (by linarith : 1 ≤ f)]
    ring

theorem transfer_bounds {e f t u : ℝ} (het : feasible e t) (hfu : feasible f u) :
    lower e f ≤ transfer e f t u ∧ transfer e f t u ≤ upper e f := by
  rcases (feasible_iff_interval e t).mp het with ⟨he0, he3, hlt, hth⟩
  rcases (feasible_iff_interval f u).mp hfu with ⟨hf0, hf3, hmu, hun⟩
  by_cases he : e ≤ 1 <;> by_cases hf : f ≤ 1
  · have le0 : oppLow e = 0 := max_eq_left (by linarith)
    have lf0 : oppLow f = 0 := max_eq_left (by linarith)
    have hee : oppHigh e = e := min_eq_left he
    have hff : oppHigh f = f := min_eq_left hf
    apply rectangle_bounds hlt hth hmu hun
    all_goals
      simp only [le0, lf0, hee, hff, lower, upper, if_pos he, if_pos hf, transfer]
      constructor <;> nlinarith only [mul_nonneg he0 hf0]
  · have le0 : oppLow e = 0 := max_eq_left (by linarith)
    have lff : oppLow f = (f-1)/2 := max_eq_right (by linarith)
    have hee : oppHigh e = e := min_eq_left he
    have hf1 : oppHigh f = 1 := min_eq_right (by linarith)
    apply rectangle_bounds hlt hth hmu hun
    all_goals
      simp only [le0, lff, hee, hf1, lower, upper, if_pos he, if_neg hf, transfer]
      constructor <;> nlinarith only [mul_nonneg he0 (show 0 ≤ 3-f by linarith)]
  · have lee : oppLow e = (e-1)/2 := max_eq_right (by linarith)
    have lf0 : oppLow f = 0 := max_eq_left (by linarith)
    have he1 : oppHigh e = 1 := min_eq_right (by linarith)
    have hff : oppHigh f = f := min_eq_left hf
    apply rectangle_bounds hlt hth hmu hun
    all_goals
      simp only [lee, lf0, he1, hff, lower, upper, if_neg he, if_pos hf, transfer]
      constructor <;> nlinarith only [mul_nonneg hf0 (show 0 ≤ 3-e by linarith)]
  · have lee : oppLow e = (e-1)/2 := max_eq_right (by linarith)
    have lff : oppLow f = (f-1)/2 := max_eq_right (by linarith)
    have he1 : oppHigh e = 1 := min_eq_right (by linarith)
    have hf1 : oppHigh f = 1 := min_eq_right (by linarith)
    apply rectangle_bounds hlt hth hmu hun
    all_goals
      simp only [lee, lff, he1, hf1, lower, upper, if_neg he, if_neg hf, transfer]
      constructor <;> nlinarith only [mul_nonneg (show 0 ≤ 3-e by linarith)
        (show 0 ≤ 3-f by linarith)]

theorem transfer_surjective {e f z : ℝ}
    (he0 : 0 ≤ e) (he3 : e ≤ 3) (hf0 : 0 ≤ f) (hf3 : f ≤ 3)
    (hzl : lower e f ≤ z) (hzu : z ≤ upper e f) :
    ∃ t u : ℝ, feasible e t ∧ feasible f u ∧ transfer e f t u = z := by
  by_cases hEq : lower e f = upper e f
  · refine ⟨oppHigh e, oppLow f, feasible_high he0 he3, feasible_low hf0 hf3, ?_⟩
    rw [transfer_lower_endpoint he0 he3 hf0 hf3]
    linarith
  · have hGap : 0 < upper e f - lower e f := by
      have hle : lower e f ≤ upper e f := hzl.trans hzu
      exact sub_pos.mpr (lt_of_le_of_ne hle hEq)
    let r : ℝ := (z - lower e f) / (upper e f - lower e f)
    have hr0 : 0 ≤ r := div_nonneg (sub_nonneg.mpr hzl) (le_of_lt hGap)
    have hr1 : r ≤ 1 := by
      dsimp [r]
      apply (div_le_iff₀ hGap).mpr
      linarith
    have hspan : 0 ≤ oppHigh f - oppLow f :=
      sub_nonneg.mpr (oppLow_le_oppHigh hf0 hf3)
    have hu0 : oppLow f ≤ oppLow f + r * (oppHigh f - oppLow f) := by
      nlinarith only [mul_nonneg hr0 hspan]
    have hu1 : oppLow f + r * (oppHigh f - oppLow f) ≤ oppHigh f := by
      nlinarith only [mul_nonneg (sub_nonneg.mpr hr1) hspan]
    have hfu : feasible f (oppLow f + r * (oppHigh f - oppLow f)) := by
      rw [feasible_iff_interval]
      exact ⟨hf0, hf3, hu0, hu1⟩
    refine ⟨oppHigh e, oppLow f + r * (oppHigh f - oppLow f),
      feasible_high he0 he3, hfu, ?_⟩
    have hinterp :
        transfer e f (oppHigh e) (oppLow f + r * (oppHigh f - oppLow f)) =
        transfer e f (oppHigh e) (oppLow f) +
        r * (transfer e f (oppHigh e) (oppHigh f) -
          transfer e f (oppHigh e) (oppLow f)) := by
      unfold transfer
      ring
    rw [transfer_lower_endpoint he0 he3 hf0 hf3,
      transfer_upper_endpoint he0 he3 hf0 hf3] at hinterp
    have hcancel : r * (upper e f - lower e f) = z - lower e f :=
      div_mul_cancel₀ _ (ne_of_gt hGap)
    rw [hinterp, hcancel]
    ring

theorem transfer_range_iff {e f z : ℝ}
    (he0 : 0 ≤ e) (he3 : e ≤ 3) (hf0 : 0 ≤ f) (hf3 : f ≤ 3) :
    (∃ t u : ℝ, feasible e t ∧ feasible f u ∧ transfer e f t u = z) ↔
      lower e f ≤ z ∧ z ≤ upper e f := by
  constructor
  · rintro ⟨t, u, het, hfu, rfl⟩
    exact transfer_bounds het hfu
  · rintro ⟨hzl, hzu⟩
    exact transfer_surjective he0 he3 hf0 hf3 hzl hzu

end QuquartSwapping


-- Source section: Main.lean
namespace QuquartSwapping

noncomputable section

noncomputable def radius (e : ℝ) : ℝ := if e ≤ 1 then e else (3-e)/2

noncomputable def attainable (e f z : ℝ) : Prop :=
  ∃ c b : CVec, mass c = 1 ∧ mass b = 1 ∧
    inputEnt c = e ∧ inputEnt b = f ∧ bellAverage c b = z

lemma mass_eq_normSq (c : CVec) : mass c = normSq (magnitude c) := by
  simp [mass, normSq_sum, magnitude]

lemma magnitude_ofReal (a : Vec) (ha : ∀ i, 0 ≤ a i) :
    magnitude (fun i => (a i : ℂ)) = a := by
  funext i
  simp [magnitude, Complex.norm_real, abs_of_nonneg (ha i)]

lemma complex_realizable (e t : ℝ) (het : feasible e t) :
    ∃ c : CVec, mass c = 1 ∧ inputEnt c = e ∧ opp (magnitude c) = t := by
  obtain ⟨a, ha, he, ht⟩ := feasible_realizable e t het
  refine ⟨fun i => (a i : ℂ), ?_, ?_, ?_⟩
  · rw [mass_eq_normSq, magnitude_ofReal a ha.1]
    exact ha.2
  · rw [inputEnt_magnitude, magnitude_ofReal a ha.1]
    exact he
  · rw [magnitude_ofReal a ha.1]
    exact ht

theorem physical_bounds (c b : CVec) (hc : mass c = 1) (hb : mass b = 1) :
    lower (inputEnt c) (inputEnt b) ≤ bellAverage c b ∧
      bellAverage c b ≤ upper (inputEnt c) (inputEnt b) := by
  have hcF := valid_feasible (magnitude c) (magnitude_valid c hc)
  have hbF := valid_feasible (magnitude b) (magnitude_valid b hb)
  rw [← inputEnt_magnitude] at hcF hbF
  rw [bellAverage_transfer]
  exact transfer_bounds hcF hbF

theorem attainable_iff {e f z : ℝ}
    (he0 : 0 ≤ e) (he3 : e ≤ 3) (hf0 : 0 ≤ f) (hf3 : f ≤ 3) :
    attainable e f z ↔ lower e f ≤ z ∧ z ≤ upper e f := by
  constructor
  · rintro ⟨c, b, hc, hb, he, hf, hz⟩
    simpa [he, hf, hz] using physical_bounds c b hc hb
  · rintro ⟨hzl, hzu⟩
    obtain ⟨t, u, het, hfu, hval⟩ := transfer_surjective he0 he3 hf0 hf3 hzl hzu
    obtain ⟨c, hc, he, ht⟩ := complex_realizable e t het
    obtain ⟨b, hb, hf, hu⟩ := complex_realizable f u hfu
    refine ⟨c, b, hc, hb, he, hf, ?_⟩
    rw [bellAverage_transfer, he, hf, ht, hu, hval]

lemma lower_compact (e f : ℝ) :
    lower e f = (e*f - radius e * radius f)/3 := by
  by_cases he : e ≤ 1 <;> by_cases hf : f ≤ 1 <;>
    simp [lower, radius, he, hf] <;> ring

lemma upper_compact (e f : ℝ) :
    upper e f = (e*f + 2*radius e * radius f)/3 := by
  by_cases he : e ≤ 1 <;> by_cases hf : f ≤ 1 <;>
    simp [upper, radius, he, hf] <;> ring

theorem exact_physical_range {e f z : ℝ}
    (he0 : 0 ≤ e) (he3 : e ≤ 3) (hf0 : 0 ≤ f) (hf3 : f ≤ 3) :
    attainable e f z ↔
      (e*f - radius e * radius f)/3 ≤ z ∧
      z ≤ (e*f + 2*radius e * radius f)/3 := by
  rw [attainable_iff he0 he3 hf0 hf3, lower_compact, upper_compact]

lemma transfer_centered (e f t u : ℝ) :
    transfer e f t u = e*f/3 + (3/2:ℝ)*(t-e/3)*(u-f/3) := by
  unfold transfer
  ring

theorem physical_centered (c b : CVec) :
    bellAverage c b = inputEnt c * inputEnt b / 3 +
      (3/2:ℝ) * (opp (magnitude c) - inputEnt c / 3) *
        (opp (magnitude b) - inputEnt b / 3) := by
  rw [bellAverage_transfer, transfer_centered]

lemma radius_nonneg {e : ℝ} (he0 : 0 ≤ e) (he3 : e ≤ 3) : 0 ≤ radius e := by
  unfold radius
  split_ifs <;> linarith

lemma radius_pos {e : ℝ} (he0 : 0 < e) (he3 : e < 3) : 0 < radius e := by
  unfold radius
  split_ifs <;> linarith

lemma lower_le_upper {e f : ℝ}
    (he0 : 0 ≤ e) (he3 : e ≤ 3) (hf0 : 0 ≤ f) (hf3 : f ≤ 3) :
    lower e f ≤ upper e f := by
  rw [lower_compact, upper_compact]
  nlinarith [mul_nonneg (radius_nonneg he0 he3) (radius_nonneg hf0 hf3)]

theorem upper_attained {e f : ℝ}
    (he0 : 0 ≤ e) (he3 : e ≤ 3) (hf0 : 0 ≤ f) (hf3 : f ≤ 3) :
    attainable e f (upper e f) := by
  exact (attainable_iff he0 he3 hf0 hf3).2 ⟨lower_le_upper he0 he3 hf0 hf3, le_refl _⟩

theorem lower_attained {e f : ℝ}
    (he0 : 0 ≤ e) (he3 : e ≤ 3) (hf0 : 0 ≤ f) (hf3 : f ≤ 3) :
    attainable e f (lower e f) := by
  exact (attainable_iff he0 he3 hf0 hf3).2 ⟨le_refl _, lower_le_upper he0 he3 hf0 hf3⟩

theorem strict_violation_every_interior_resource {e f : ℝ}
    (he0 : 0 < e) (he3 : e < 3) (hf0 : 0 < f) (hf3 : f < 3) :
    ∃ z : ℝ, attainable e f z ∧ e*f/3 < z := by
  refine ⟨upper e f, upper_attained he0.le he3.le hf0.le hf3.le, ?_⟩
  rw [upper_compact]
  nlinarith [mul_pos (radius_pos he0 he3) (radius_pos hf0 hf3)]

theorem exact_width (e f : ℝ) : upper e f - lower e f = radius e * radius f := by
  rw [lower_compact, upper_compact]
  ring

theorem printed_value_one_third (e f : ℝ) :
    e*f/3 = lower e f + (upper e f - lower e f)/3 := by
  rw [lower_compact, upper_compact]
  ring

theorem printed_value_attainable {e f : ℝ}
    (he0 : 0 ≤ e) (he3 : e ≤ 3) (hf0 : 0 ≤ f) (hf3 : f ≤ 3) :
    attainable e f (e*f/3) := by
  rw [exact_physical_range he0 he3 hf0 hf3]
  have hw := mul_nonneg (radius_nonneg he0 he3) (radius_nonneg hf0 hf3)
  constructor <;> nlinarith

theorem boundary_range {e f z : ℝ}
    (he0 : 0 ≤ e) (he3 : e ≤ 3) (hf0 : 0 ≤ f) (hf3 : f ≤ 3)
    (hedge : e = 0 ∨ e = 3 ∨ f = 0 ∨ f = 3) :
    attainable e f z ↔ z = e*f/3 := by
  have hw : radius e * radius f = 0 := by
    rcases hedge with h | h | h | h <;> subst h <;> norm_num [radius]
  rw [exact_physical_range he0 he3 hf0 hf3]
  constructor
  · rintro ⟨hl, hu⟩
    nlinarith
  · intro hz
    constructor <;> nlinarith

theorem one_one_range (z : ℝ) : attainable 1 1 z ↔ 0 ≤ z ∧ z ≤ 1 := by
  rw [attainable_iff (by norm_num) (by norm_num) (by norm_num) (by norm_num)]
  norm_num [lower, upper]

theorem two_two_range (z : ℝ) : attainable 2 2 z ↔ (5/4:ℝ) ≤ z ∧ z ≤ (3/2:ℝ) := by
  rw [attainable_iff (by norm_num) (by norm_num) (by norm_num) (by norm_num)]
  norm_num [lower, upper]

noncomputable def publishedWitness : CVec := ![(7/10:ℂ),(1/10:ℂ),(7/10:ℂ),(1/10:ℂ)]

theorem publishedWitness_values :
    mass publishedWitness = 1 ∧ inputEnt publishedWitness = 39/25 ∧
    bellAverage publishedWitness publishedWitness = 723/625 ∧
    upper (39/25) (39/25) = 723/625 := by
  have h1 : ‖(1 : ℂ)‖ = (1 : ℝ) := by
    simpa only [Nat.cast_one] using (Complex.norm_natCast 1)
  have hm : magnitude publishedWitness = ![(7/10:ℝ),(1/10:ℝ),(7/10:ℝ),(1/10:ℝ)] := by
    funext i
    fin_cases i <;> norm_num [magnitude, publishedWitness, Complex.norm_div, h1]
  rw [mass_eq_normSq, inputEnt_magnitude, bellAverage_transfer, inputEnt_magnitude, hm]
  norm_num [normSq, ent, opp, transfer, upper, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.head_cons, Matrix.tail_cons]

end
end QuquartSwapping


-- Collect dependencies of all declarations created in this module, including compiler auxiliaries.
open Lean in
run_cmd do
  let env ← getEnv
  let mut entries : Array (String × Array String) := #[]
  for (name, _) in env.constants.map₂.toList do
    let axioms ← Lean.collectAxioms name
    entries := entries.push (name.toString, axioms.map Name.toString)
  logInfo m!"EDEG_KERNEL_AXIOMS: {(toJson entries).compress}"
