import SubcubicLocal

set_option autoImplicit false
set_option linter.unusedSectionVars false

namespace Subcubic
universe u v
variable {V : Type u} {C : Type v}
variable [Fintype V] [DecidableEq V] [Fintype C] [DecidableEq C]

theorem holes_put (q : Coloring V C) (x : V) (c : C) :
    holes (put q x c) = (holes q).erase x := by
  ext y
  by_cases h : y = x
  · subst y
    simp
  · simp [put_ne q x y c h, h]

theorem holes_erase (q : Coloring V C) (x : V) :
    holes (erase q x) = insert x (holes q) := by
  ext y
  by_cases h : y = x
  · subst y
    simp
  · simp [erase_ne q x y h, h]

theorem put_erase_restore (q : Coloring V C) (x : V) (c : C)
    (hx : q x = some c) : put (erase q x) x c = q := by
  funext y
  by_cases h : y = x
  · subst y
    simp [hx]
  · simp [put, erase, Function.update_apply, h, Ne.symm h]

theorem two_holes_with (q : Coloring V C) (d : V)
    (hcard : (holes q).card = 2) (hd : q d = none) :
    ∃ o : V, d ≠ o ∧ holes q = {d, o} := by
  obtain ⟨a, b, hab, hset⟩ := Finset.card_eq_two.mp hcard
  have hm : d = a ∨ d = b := by
    have hm : d ∈ holes q := (mem_holes q d).mpr hd
    simpa [hset] using hm
  rcases hm with hda | hdb
  · subst d
    exact ⟨b, hab, hset⟩
  · subst d
    exact ⟨a, Ne.symm hab, hset.trans (Finset.pair_comm a b)⟩

theorem holes_triple_put_first (q : Coloring V C) (s d o : V) (c : C)
    (hholes : holes q = {s, d, o}) (hsd : s ≠ d) (hso : s ≠ o) :
    holes (put q s c) = {d, o} := by
  rw [holes_put, hholes]
  simp [hsd, hso]

theorem holes_triple_put_second (q : Coloring V C) (s d o : V) (c : C)
    (hholes : holes q = {s, d, o}) (hsd : s ≠ d) (hdo : d ≠ o) :
    holes (put q d c) = {s, o} := by
  rw [holes_put, hholes]
  ext y
  simp only [Finset.mem_erase, Finset.mem_insert, Finset.mem_singleton]
  constructor
  · rintro ⟨hne, he | he | he⟩
    · exact Or.inl he
    · exact False.elim (hne he)
    · exact Or.inr he
  · intro he
    rcases he with rfl | rfl
    · exact ⟨hsd, Or.inl rfl⟩
    · exact ⟨Ne.symm hdo, Or.inr (Or.inr rfl)⟩

theorem TE_two (G : Graph V) (q : Coloring V C) (a b : V)
    (hab : a ≠ b) (hholes : holes q = {a, b}) :
    TE G q = tau G q a + tau G q b := by
  simp [TE, hholes, hab]

theorem D_two (G : Graph V) (q : Coloring V C) (a b : V)
    (hab : a ≠ b) (hholes : holes q = {a, b}) :
    D G q = degree G a + degree G b := by
  simp [D, hholes, hab]

theorem degree_partition (G : Graph V) (q : Coloring V C) (c : C) (x : V) :
    degree G x = sameCount G q c x + alienCount G q c x +
      ((neighbors G x).filter (fun y => q y = none)).card := by
  have h1 := Finset.filter_card_add_filter_neg_card_eq_card
    (s := neighbors G x) (fun y => q y = some c)
  have h2 := Finset.filter_card_add_filter_neg_card_eq_card
    (s := (neighbors G x).filter (fun y => q y ≠ some c)) (fun y => q y = none)
  have he : ((neighbors G x).filter (fun y => q y ≠ some c)).filter
      (fun y => q y = none) = (neighbors G x).filter (fun y => q y = none) := by
    ext y
    simp only [Finset.mem_filter]
    constructor
    · intro h
      exact ⟨h.1.1, h.2⟩
    · intro h
      exact ⟨⟨h.1, by simp [h.2]⟩, h.2⟩
  have ha : ((neighbors G x).filter (fun y => q y ≠ some c)).filter
      (fun y => ¬ q y = none) = alienNeighbors G q c x := by
    ext y
    simp [alienNeighbors, and_left_comm, and_assoc, and_comm]
  rw [he, ha] at h2
  have h1' : sameCount G q c x +
      ((neighbors G x).filter (fun y => q y ≠ some c)).card = degree G x := by
    simpa only [sameCount, sameNeighbors, degree] using h1
  have h2' : ((neighbors G x).filter (fun y => q y = none)).card +
      alienCount G q c x =
      ((neighbors G x).filter (fun y => q y ≠ some c)).card := by
    simpa only [alienCount] using h2
  omega

theorem empty_neighbors_three (G : Graph V) (q : Coloring V C) (x a b : V)
    (hholes : holes q = {x, a, b}) (hab : a ≠ b) :
    ((neighbors G x).filter (fun y => q y = none)).card =
      (if Adj G x a then 1 else 0) + (if Adj G x b then 1 else 0) := by
  have he : (neighbors G x).filter (fun y => q y = none) =
      ({a, b} : Finset V).filter (fun y => Adj G x y) := by
    ext y
    have hq : q y = none ↔ y = x ∨ y = a ∨ y = b := by
      rw [← mem_holes, hholes]
      simp
    simp only [Finset.mem_filter, mem_neighbors, Finset.mem_insert,
      Finset.mem_singleton, hq]
    constructor
    · rintro ⟨hedge, h | h | h⟩
      · subst y
        exact False.elim (no_self_adj G x hedge)
      · exact ⟨Or.inl h, hedge⟩
      · exact ⟨Or.inr h, hedge⟩
    · rintro ⟨h | h, hedge⟩
      · exact ⟨hedge, Or.inr (Or.inl h)⟩
      · exact ⟨hedge, Or.inr (Or.inr h)⟩
  rw [he]
  by_cases ha : G.edge x a = true <;> by_cases hb : G.edge x b = true <;>
    simp [Finset.filter_insert, Finset.filter_singleton, Adj, ha, hb, hab]

theorem degree_three_holes (G : Graph V) (q : Coloring V C) (c : C) (x a b : V)
    (hholes : holes q = {x, a, b}) (hab : a ≠ b) :
    degree G x = sameCount G q c x + alienCount G q c x +
      (if Adj G x a then 1 else 0) + (if Adj G x b then 1 else 0) := by
  rw [degree_partition G q c x, empty_neighbors_three G q x a b hholes hab]
  omega

end Subcubic
