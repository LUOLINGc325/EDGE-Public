import SubcubicDefs

set_option autoImplicit false
set_option linter.unusedSectionVars false

namespace Subcubic

universe u v
variable {V : Type u} {C : Type v}
variable [Fintype V] [DecidableEq V] [Fintype C] [DecidableEq C]

@[simp] theorem mem_neighbors (G : Graph V) (x y : V) :
    y ∈ neighbors G x ↔ Adj G x y := by simp [neighbors]

@[simp] theorem mem_holes (q : Coloring V C) (x : V) :
    x ∈ holes q ↔ q x = none := by simp [holes]

@[simp] theorem mem_neighborColors (G : Graph V) (q : Coloring V C) (x : V) (c : C) :
    c ∈ neighborColors G q x ↔ ∃ y : V, Adj G x y ∧ q y = some c := by
  simp [neighborColors]

@[simp] theorem mem_sameNeighbors (G : Graph V) (q : Coloring V C) (c : C) (x y : V) :
    y ∈ sameNeighbors G q c x ↔ Adj G x y ∧ q y = some c := by
  simp [sameNeighbors]

@[simp] theorem mem_alienNeighbors (G : Graph V) (q : Coloring V C) (c : C) (x y : V) :
    y ∈ alienNeighbors G q c x ↔ Adj G x y ∧ q y ≠ none ∧ q y ≠ some c := by
  simp [alienNeighbors]

@[simp] theorem put_self (q : Coloring V C) (x : V) (c : C) : put q x c x = some c := by
  simp [put]

theorem put_ne (q : Coloring V C) (x y : V) (c : C) (h : y ≠ x) : put q x c y = q y := by
  simp [put, h]

@[simp] theorem erase_self (q : Coloring V C) (x : V) : erase q x x = none := by
  simp [erase]

theorem erase_ne (q : Coloring V C) (x y : V) (h : y ≠ x) : erase q x y = q y := by
  simp [erase, h]

theorem no_self_adj (G : Graph V) (x : V) : ¬ Adj G x x := by
  simp [Adj, G.loopless]

theorem adj_comm (G : Graph V) (x y : V) : Adj G x y ↔ Adj G y x := by
  unfold Adj
  rw [G.symmetric x y]

theorem neighborColors_put (G : Graph V) (q : Coloring V C) (x : V) (c : C)
    (hx : q x = none) (y : V) :
    neighborColors G (put q x c) y =
      if Adj G y x then insert c (neighborColors G q y) else neighborColors G q y := by
  ext d
  by_cases h : Adj G y x
  · simp only [if_pos h, mem_neighborColors, Finset.mem_insert]
    constructor
    · rintro ⟨z, hyz, hcol⟩
      by_cases hzx : z = x
      · subst z
        left
        simpa using hcol.symm
      · right
        exact ⟨z, hyz, by simpa [put_ne q x z c hzx] using hcol⟩
    · rintro (hd | ⟨z, hyz, hcol⟩)
      · subst d
        exact ⟨x, h, put_self q x c⟩
      · have hzx : z ≠ x := by
          intro hzx
          subst z
          simp [hx] at hcol
        exact ⟨z, hyz, by simpa [put_ne q x z c hzx] using hcol⟩
  · simp only [if_neg h, mem_neighborColors]
    constructor
    · rintro ⟨z, hyz, hcol⟩
      have hzx : z ≠ x := by
        intro hzx
        exact h (hzx ▸ hyz)
      exact ⟨z, hyz, by simpa [put_ne q x z c hzx] using hcol⟩
    · rintro ⟨z, hyz, hcol⟩
      have hzx : z ≠ x := by
        intro hzx
        exact h (hzx ▸ hyz)
      exact ⟨z, hyz, by simpa [put_ne q x z c hzx] using hcol⟩

theorem utility_put_self (G : Graph V) (q : Coloring V C) (x : V) (c : C)
    (hx : q x = none) : utility G (put q x c) c x = utility G q c x := by
  unfold utility
  rw [neighborColors_put G q x c hx x, if_neg (no_self_adj G x)]

theorem tau_put (G : Graph V) (q : Coloring V C) (x : V) (c : C)
    (hx : q x = none) (y : V) :
    tau G (put q x c) y = tau G q y +
      if Adj G y x ∧ c ∉ neighborColors G q y then 1 else 0 := by
  unfold tau
  rw [neighborColors_put G q x c hx y]
  by_cases h : Adj G y x
  · rw [if_pos h]
    by_cases hc : c ∈ neighborColors G q y
    · rw [Finset.insert_eq_of_mem hc, if_neg (fun hbad => hbad.2 hc)]
      exact (Nat.add_zero _).symm
    · rw [if_pos ⟨h, hc⟩]
      exact Finset.card_insert_of_not_mem hc
  · rw [if_neg h, if_neg (fun hbad => h hbad.1)]
    exact (Nat.add_zero _).symm

theorem color_mem_iff_sameCount_pos (G : Graph V) (q : Coloring V C) (c : C) (x : V) :
    c ∈ neighborColors G q x ↔ 0 < sameCount G q c x := by
  simp [sameCount, Finset.card_pos, Finset.Nonempty]

theorem tau_eq_utility_add (G : Graph V) (q : Coloring V C) (c : C) (x : V) :
    tau G q x = utility G q c x + if 0 < sameCount G q c x then 1 else 0 := by
  by_cases h : c ∈ neighborColors G q x
  · have hm := (color_mem_iff_sameCount_pos G q c x).mp h
    simpa [tau, utility, hm] using (Finset.card_erase_add_one h).symm
  · have hm : ¬ 0 < sameCount G q c x := by
      simpa only [← color_mem_iff_sameCount_pos] using h
    simp [tau, utility, h, hm]

end Subcubic
