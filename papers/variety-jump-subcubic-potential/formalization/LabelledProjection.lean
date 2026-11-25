import SubcubicDefs

set_option autoImplicit false
set_option linter.unusedSectionVars false

namespace Subcubic

universe u v w
variable {V : Type u} {C : Type v} {A : Type w}
variable [Fintype V] [DecidableEq V] [Fintype C] [DecidableEq C]

theorem project_update (typeOf : A → C) (q : V → Option A)
    (x : V) (value : Option A) :
    project typeOf (Function.update q x value) =
      Function.update (project typeOf q) x (value.map typeOf) := by
  funext y
  by_cases hy : y = x
  · subst y
    simp [project]
  · simp [project, Function.update, hy]

theorem project_jump (typeOf : A → C) (q : V → Option A)
    (s d : V) (a : A) :
    project typeOf (Function.update (Function.update q s none) d (some a)) =
      put (erase (project typeOf q) s) d (typeOf a) := by
  rw [project_update, project_update]
  rfl

theorem holes_project [DecidableEq A] (typeOf : A → C) (q : V → Option A) :
    holes (project typeOf q) = holes q := by
  ext x
  simp [holes, project]

theorem labelled_improves_project (G : Graph V) (typeOf : A → C)
    (q q' : V → Option A) (h : LabelledImproves G typeOf q q') :
    Improves G (project typeOf q) (project typeOf q') := by
  obtain ⟨s, d, a, hs, hd, hq', hbetter⟩ := h
  refine ⟨s, d, typeOf a, ?_, ?_, ?_, hbetter⟩
  · simp [project, hs]
  · simp [project, hd]
  · rw [hq']
    exact project_jump typeOf q s d a

theorem wellFormed_occupied_injective (q : V → Option A) (h : WellFormed q)
    (a : A) (x y : V) (hx : q x = some a) (hy : q y = some a) : x = y := by
  obtain ⟨z, hz, hu⟩ := h a
  exact (hu x hx).trans (hu y hy).symm

/-- Relocating an agent to a vacancy preserves exactly one occurrence of every agent. -/
theorem wellFormed_jump (q : V → Option A) (s d : V) (a : A)
    (h : WellFormed q) (hs : q s = some a) (hd : q d = none) :
    WellFormed (Function.update (Function.update q s none) d (some a)) := by
  classical
  have hsd : s ≠ d := by
    intro heq
    subst d
    rw [hs] at hd
    cases hd
  intro b
  by_cases hba : b = a
  · subst b
    refine ⟨d, by simp, ?_⟩
    intro y hy
    by_cases hyd : y = d
    · exact hyd
    · by_cases hys : y = s
      · subst y
        simp [Function.update, hsd] at hy
      · have hya : q y = some a := by
          simpa [Function.update, hyd, hys] using hy
        have heq := wellFormed_occupied_injective q h a y s hya hs
        exact False.elim (hys heq)
  · obtain ⟨x, hx, hu⟩ := h b
    have hxs : x ≠ s := by
      intro heq
      subst x
      exact hba (Option.some.inj (hx.symm.trans hs))
    have hxd : x ≠ d := by
      intro heq
      subst x
      rw [hd] at hx
      cases hx
    refine ⟨x, ?_, ?_⟩
    · simpa [Function.update, hxs, hxd] using hx
    · intro y hy
      by_cases hyd : y = d
      · subst y
        have hab : a = b := by simpa using hy
        exact False.elim (hba hab.symm)
      · by_cases hys : y = s
        · subst y
          simp [Function.update, hsd] at hy
        · have hyb : q y = some b := by
            simpa [Function.update, hyd, hys] using hy
          exact hu y hyb

theorem labelled_preserves_wellFormed (G : Graph V) (typeOf : A → C)
    (q q' : V → Option A) (hWF : WellFormed q)
    (h : LabelledImproves G typeOf q q') : WellFormed q' := by
  obtain ⟨s, d, a, hs, hd, hq', _⟩ := h
  rw [hq']
  exact wellFormed_jump q s d a hWF hs hd

end Subcubic

#print axioms Subcubic.project_update
#print axioms Subcubic.project_jump
#print axioms Subcubic.holes_project
#print axioms Subcubic.labelled_improves_project
#print axioms Subcubic.wellFormed_occupied_injective
#print axioms Subcubic.wellFormed_jump
#print axioms Subcubic.labelled_preserves_wellFormed

