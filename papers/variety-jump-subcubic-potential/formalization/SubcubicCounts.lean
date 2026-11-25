import SubcubicDefs

set_option autoImplicit false
set_option linter.unusedSectionVars false

namespace Subcubic

universe u v
variable {V : Type u} {C : Type v}
variable [Fintype V] [DecidableEq V] [Fintype C] [DecidableEq C]

/-- Every foreign color occurs at an alien neighbor, and only there. -/
theorem utility_colors_image_some (G : Graph V) (q : Coloring V C) (c : C) (x : V) :
    ((neighborColors G q x).erase c).image (@Option.some C) =
      (alienNeighbors G q c x).image q := by
  classical
  ext z
  constructor
  · intro hz
    obtain ⟨b, hb, rfl⟩ := Finset.mem_image.mp hz
    have hb' : b ≠ c ∧ ∃ y : V, Adj G x y ∧ q y = some b := by
      simpa [neighborColors] using hb
    obtain ⟨hbc, y, hyAdj, hyCol⟩ := hb'
    apply Finset.mem_image.mpr
    refine ⟨y, ?_, hyCol⟩
    have hny : y ∈ neighbors G x :=
      Finset.mem_filter.mpr ⟨Finset.mem_univ y, hyAdj⟩
    have hnon : q y ≠ none := by simp [hyCol]
    have hnotc : q y ≠ some c := by simpa [hyCol] using hbc
    exact Finset.mem_filter.mpr ⟨hny, hnon, hnotc⟩
  · intro hz
    obtain ⟨y, hy, rfl⟩ := Finset.mem_image.mp hz
    have hy' : Adj G x y ∧ q y ≠ none ∧ q y ≠ some c := by
      simpa [alienNeighbors, neighbors] using hy
    cases hcol : q y with
    | none => exact False.elim (hy'.2.1 hcol)
    | some b =>
      apply Finset.mem_image.mpr
      refine ⟨b, ?_, rfl⟩
      have hbc : b ≠ c := by
        intro heq
        apply hy'.2.2
        simpa [heq] using hcol
      simp only [Finset.mem_erase, neighborColors, Finset.mem_filter,
        Finset.mem_univ, true_and]
      exact ⟨hbc, y, hy'.1, hcol⟩

theorem utility_eq_alien_image_card (G : Graph V) (q : Coloring V C) (c : C) (x : V) :
    utility G q c x = ((alienNeighbors G q c x).image q).card := by
  have hcard := congrArg Finset.card (utility_colors_image_some G q c x)
  have hinj : Function.Injective (@Option.some C) := by
    intro a b h
    exact Option.some.inj h
  rw [Finset.card_image_of_injective _ hinj] at hcard
  exact hcard

/-- Distinct foreign types cannot outnumber foreign occupied neighbors. -/
theorem utility_le_alienCount (G : Graph V) (q : Coloring V C) (c : C) (x : V) :
    utility G q c x ≤ alienCount G q c x := by
  rw [utility_eq_alien_image_card]
  exact Finset.card_image_le

/-- There is no foreign type precisely when there is no foreign neighbor. -/
theorem utility_eq_zero_iff_alienCount_eq_zero
    (G : Graph V) (q : Coloring V C) (c : C) (x : V) :
    utility G q c x = 0 ↔ alienCount G q c x = 0 := by
  rw [utility_eq_alien_image_card]
  simp only [alienCount, Finset.card_eq_zero, Finset.image_eq_empty]

end Subcubic

#print axioms Subcubic.utility_colors_image_some
#print axioms Subcubic.utility_eq_alien_image_card
#print axioms Subcubic.utility_le_alienCount
#print axioms Subcubic.utility_eq_zero_iff_alienCount_eq_zero

