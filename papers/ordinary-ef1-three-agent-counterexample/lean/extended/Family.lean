import Definitions

open scoped BigOperators
noncomputable section
namespace OrdinaryEF1

@[simp] theorem fin3_mk_two (h : 2 < 3) : (⟨2, h⟩ : Fin 3) = 2 := rfl
@[simp] theorem fin3_two_ne_zero : (2 : Fin 3) ≠ 0 := by decide
@[simp] theorem fin3_two_ne_one : (2 : Fin 3) ≠ 1 := by decide
@[simp] theorem fin3_zero_ne_two : (0 : Fin 3) ≠ 2 := by decide
@[simp] theorem fin3_one_ne_two : (1 : Fin 3) ≠ 2 := by decide

-- Section 4 profile in the actual recipient-dependent utility model.
noncomputable def cyclicProfile (a b g z : ℝ) (i r x : Fin 3) : ℝ :=
  if i = r then (if x = 0 then a else if x = 1 then b else g)
  else if (i.val + 1) % 3 = r.val ∧ x = 2 then g + z else 0

noncomputable def alloc (r s t : Fin 3) (x : Fin 3) : Fin 3 :=
  if x = 0 then r else if x = 1 then s else t

theorem alloc_eta (A : Fin 3 → Fin 3) :
    alloc (A 0) (A 1) (A 2) = A := by
  funext x
  fin_cases x <;> simp [alloc]

set_option maxHeartbeats 800000 in
theorem noEF1_of_b_lt_a {a b g z : ℝ}
    (_ha : 0 < a) (hb : 0 < b) (_hg : 0 < g) (_hz : 0 < z)
    (hab : b < a) (hbg : b < g) (hbz : b < z) :
    ¬ ∃ A : Fin 3 → Fin 3, EF1 (cyclicProfile a b g z) A := by
  rintro ⟨A, h⟩
  have hno : ∀ r s t : Fin 3, ¬ EF1 (cyclicProfile a b g z) (alloc r s t) := by
    intro r s t h'
    fin_cases r <;> fin_cases s <;> fin_cases t
    · obtain ⟨d, hd⟩ := h' 1 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 2 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 2 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 1 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 2 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 2 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 1 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 1 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 2 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 0 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 2 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 2 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 0 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 2 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 0 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 0 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 2 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 0 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 1 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 1 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 0 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 0 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 1 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 0 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 1 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 1 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
    · obtain ⟨d, hd⟩ := h' 0 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [hb, hab, hbg, hbz, hd]
  exact hno (A 0) (A 1) (A 2) (by simpa only [alloc_eta] using h)

set_option maxHeartbeats 800000 in
theorem noEF1_of_a_lt_b {a b g z : ℝ}
    (ha : 0 < a) (_hb : 0 < b) (_hg : 0 < g) (_hz : 0 < z)
    (hab : a < b) (hag : a < g) (haz : a < z) :
    ¬ ∃ A : Fin 3 → Fin 3, EF1 (cyclicProfile a b g z) A := by
  rintro ⟨A, h⟩
  have hno : ∀ r s t : Fin 3, ¬ EF1 (cyclicProfile a b g z) (alloc r s t) := by
    intro r s t h'
    fin_cases r <;> fin_cases s <;> fin_cases t
    · obtain ⟨d, hd⟩ := h' 1 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 2 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 2 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 0 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 2 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 2 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 1 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 1 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 0 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 1 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 2 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 2 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 0 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 2 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 0 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 0 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 1 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 0 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 1 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 1 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 2 0 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 0 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 2 1 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 0 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 1 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 1 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
    · obtain ⟨d, hd⟩ := h' 0 2 (by decide)
      fin_cases d <;>
        norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;> linarith only [ha, hab, hag, haz, hd]
  exact hno (A 0) (A 1) (A 2) (by simpa only [alloc_eta] using h)

/-- With item c at agent 0, only the two exceptional allocations can be EF1. -/
theorem seven_nonexceptional_allocations_fail {a b g z : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hg : 0 < g) (hz : 0 < z)
    (r s : Fin 3) (hX : ¬ (r = 0 ∧ s = 1)) (hY : ¬ (r = 1 ∧ s = 0)) :
    ¬ EF1 (cyclicProfile a b g z) (alloc r s 0) := by
  intro h
  fin_cases r <;> fin_cases s
  · obtain ⟨d, hd⟩ := h 1 0 (by decide)
    fin_cases d <;>
      norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;>
      linarith only [ha, hb, hg, hz, hd]
  · exact hX ⟨rfl, rfl⟩
  · obtain ⟨d, hd⟩ := h 1 0 (by decide)
    fin_cases d <;>
      norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;>
      linarith only [ha, hb, hg, hz, hd]
  · exact hY ⟨rfl, rfl⟩
  · obtain ⟨d, hd⟩ := h 0 1 (by decide)
    fin_cases d <;>
      norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;>
      linarith only [ha, hb, hg, hz, hd]
  · obtain ⟨d, hd⟩ := h 0 1 (by decide)
    fin_cases d <;>
      norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;>
      linarith only [ha, hb, hg, hz, hd]
  · obtain ⟨d, hd⟩ := h 1 0 (by decide)
    fin_cases d <;>
      norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;>
      linarith only [ha, hb, hg, hz, hd]
  · obtain ⟨d, hd⟩ := h 0 1 (by decide)
    fin_cases d <;>
      norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;>
      linarith only [ha, hb, hg, hz, hd]
  · obtain ⟨d, hd⟩ := h 1 2 (by decide)
    fin_cases d <;>
      norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;>
      linarith only [ha, hb, hg, hz, hd]

theorem equal_has_EF1 {a b g z : ℝ}
    (_ha : 0 < a) (_hb : 0 < b) (hg : 0 < g) (hz : 0 < z)
    (hab : a = b) :
    EF1 (cyclicProfile a b g z) (alloc 0 1 0) := by
  intro i j hij
  fin_cases i <;> fin_cases j
  · exact (hij rfl).elim
  · refine ⟨2, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hab]
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hg]
  · refine ⟨2, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hab]
  · exact (hij rfl).elim
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hz]
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  · exact (hij rfl).elim

theorem small_g_has_EF1_left {a b g z : ℝ}
    (_ha : 0 < a) (_hb : 0 < b) (hg : 0 < g) (hz : 0 < z)
    (hab : b ≤ a) (hgb : g ≤ b) :
    EF1 (cyclicProfile a b g z) (alloc 0 1 0) := by
  intro i j hij
  fin_cases i <;> fin_cases j
  · exact (hij rfl).elim
  · refine ⟨2, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hab]
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hg]
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hgb]
  · exact (hij rfl).elim
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hz]
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  · exact (hij rfl).elim

theorem small_z_has_EF1_left {a b g z : ℝ}
    (_ha : 0 < a) (_hb : 0 < b) (hg : 0 < g) (hz : 0 < z)
    (hab : b ≤ a) (hzb : z ≤ b) :
    EF1 (cyclicProfile a b g z) (alloc 1 0 0) := by
  intro i j hij
  fin_cases i <;> fin_cases j
  · exact (hij rfl).elim
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hzb]
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hg]
  · refine ⟨2, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hab]
  · exact (hij rfl).elim
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hz]
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  · exact (hij rfl).elim

theorem small_g_has_EF1_right {a b g z : ℝ}
    (_ha : 0 < a) (_hb : 0 < b) (hg : 0 < g) (hz : 0 < z)
    (hab : a ≤ b) (hga : g ≤ a) :
    EF1 (cyclicProfile a b g z) (alloc 1 0 0) := by
  intro i j hij
  fin_cases i <;> fin_cases j
  · exact (hij rfl).elim
  · refine ⟨2, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hab]
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hg]
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hga]
  · exact (hij rfl).elim
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hz]
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  · exact (hij rfl).elim

theorem small_z_has_EF1_right {a b g z : ℝ}
    (_ha : 0 < a) (_hb : 0 < b) (hg : 0 < g) (hz : 0 < z)
    (hab : a ≤ b) (hza : z ≤ a) :
    EF1 (cyclicProfile a b g z) (alloc 0 1 0) := by
  intro i j hij
  fin_cases i <;> fin_cases j
  · exact (hij rfl).elim
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hza]
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hg]
  · refine ⟨2, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hab]
  · exact (hij rfl).elim
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hz]
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  · exact (hij rfl).elim

theorem equal_has_EF1_right {a b g z : ℝ}
    (_ha : 0 < a) (_hb : 0 < b) (hg : 0 < g) (hz : 0 < z)
    (hab : a = b) :
    EF1 (cyclicProfile a b g z) (alloc 1 0 0) := by
  intro i j hij
  fin_cases i <;> fin_cases j
  · exact (hij rfl).elim
  · refine ⟨2, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hab]
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hg]
  · refine ⟨2, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hab]
  · exact (hij rfl).elim
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  · refine ⟨1, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
    linarith only [hz]
  · refine ⟨0, ?_⟩
    norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three]
  · exact (hij rfl).elim

/-- The exact condition for the first exceptional allocation X. -/
theorem exceptional_X_EF1_iff {a b g z : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hg : 0 < g) (hz : 0 < z) (hab : b ≤ a) :
    EF1 (cyclicProfile a b g z) (alloc 0 1 0) ↔ a = b ∨ g ≤ b := by
  constructor
  · intro h
    by_contra hn
    push_neg at hn
    have hab' : b < a := by
      rcases lt_or_eq_of_le hab with hh | hh
      · exact hh
      · exact (hn.1 hh.symm).elim
    obtain ⟨d, hd⟩ := h 1 0 (by decide)
    fin_cases d <;>
      norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;>
      linarith [hn.2]
  · rintro (he | hgb)
    · exact equal_has_EF1 ha hb hg hz he
    · exact small_g_has_EF1_left ha hb hg hz hab hgb

/-- The exact condition for the second exceptional allocation Y. -/
theorem exceptional_Y_EF1_iff {a b g z : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hg : 0 < g) (hz : 0 < z) (hab : b ≤ a) :
    EF1 (cyclicProfile a b g z) (alloc 1 0 0) ↔ a = b ∨ z ≤ b := by
  constructor
  · intro h
    by_contra hn
    push_neg at hn
    have hab' : b < a := by
      rcases lt_or_eq_of_le hab with hh | hh
      · exact hh
      · exact (hn.1 hh.symm).elim
    obtain ⟨d, hd⟩ := h 0 1 (by decide)
    fin_cases d <;>
      norm_num [gap, cyclicProfile, swapRecipient, alloc, Fin.sum_univ_three] at hd <;>
      linarith [hn.2]
  · rintro (he | hzb)
    · exact equal_has_EF1_right ha hb hg hz he
    · exact small_z_has_EF1_left ha hb hg hz hab hzb

theorem exact_nonexistence_region {a b g z : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hg : 0 < g) (hz : 0 < z) :
    (¬ ∃ A : Fin 3 → Fin 3, EF1 (cyclicProfile a b g z) A) ↔
      a ≠ b ∧ min a b < min g z := by
  constructor
  · intro h
    by_cases he : a = b
    · exact (h ⟨alloc 0 1 0, equal_has_EF1 ha hb hg hz he⟩).elim
    · refine ⟨he, ?_⟩
      rcases lt_or_gt_of_ne he with hab | hab
      · rw [min_eq_left (le_of_lt hab)]
        by_cases hga : g ≤ a
        · exact (h ⟨alloc 1 0 0, small_g_has_EF1_right ha hb hg hz (le_of_lt hab) hga⟩).elim
        · by_cases hza : z ≤ a
          · exact (h ⟨alloc 0 1 0, small_z_has_EF1_right ha hb hg hz (le_of_lt hab) hza⟩).elim
          · exact lt_min (lt_of_not_ge hga) (lt_of_not_ge hza)
      · rw [min_eq_right (le_of_lt hab)]
        by_cases hgb : g ≤ b
        · exact (h ⟨alloc 0 1 0, small_g_has_EF1_left ha hb hg hz (le_of_lt hab) hgb⟩).elim
        · by_cases hzb : z ≤ b
          · exact (h ⟨alloc 1 0 0, small_z_has_EF1_left ha hb hg hz (le_of_lt hab) hzb⟩).elim
          · exact lt_min (lt_of_not_ge hgb) (lt_of_not_ge hzb)
  · rintro ⟨he, hm⟩
    rcases lt_or_gt_of_ne he with hab | hab
    · have h : a < min g z := by simpa [min_eq_left (le_of_lt hab)] using hm
      exact noEF1_of_a_lt_b ha hb hg hz hab
        (lt_of_lt_of_le h (min_le_left _ _)) (lt_of_lt_of_le h (min_le_right _ _))
    · have h : b < min g z := by simpa [min_eq_right (le_of_lt hab)] using hm
      exact noEF1_of_b_lt_a ha hb hg hz hab
        (lt_of_lt_of_le h (min_le_left _ _)) (lt_of_lt_of_le h (min_le_right _ _))

theorem integer_counterexample :
    ¬ ∃ A : Fin 3 → Fin 3, EF1 (cyclicProfile 2 1 2 2) A := by
  apply noEF1_of_b_lt_a <;> norm_num

theorem gap_add_recipient_constant {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (c : Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) (i j : Fin n) (d : Fin (m + 1)) :
    gap (fun i r x => u i r x + c i x) A i j d = gap u A i j d := by
  unfold gap
  apply Finset.sum_congr rfl
  intro x hx
  split_ifs <;> ring

theorem EF1_add_recipient_constant {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (c : Fin n → Fin m → ℝ)
    (A : Fin m → Fin n) :
    EF1 (fun i r x => u i r x + c i x) A ↔ EF1 u A := by
  unfold EF1
  simp only [gap_add_recipient_constant]

theorem shifted_counterexample :
    ¬ ∃ A : Fin 3 → Fin 3, EF1 (fun i r x => cyclicProfile 2 1 2 2 i r x + 1) A := by
  rintro ⟨A, h⟩
  exact integer_counterexample ⟨A, (EF1_add_recipient_constant
    (cyclicProfile 2 1 2 2) (fun _ _ => 1) A).mp h⟩

#print axioms exact_nonexistence_region
#print axioms integer_counterexample
#print axioms shifted_counterexample

end OrdinaryEF1

