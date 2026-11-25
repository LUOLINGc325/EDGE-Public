import SubcubicLocal

set_option autoImplicit false
set_option linter.unusedSectionVars false

namespace Subcubic
universe u v
variable {V : Type u} {C : Type v}
variable [Fintype V] [DecidableEq V] [Fintype C] [DecidableEq C]

/-- Insertion can add only the moving agent's own color; the foreign-color
count at the target vertex of this formula is therefore unchanged. -/
theorem tau_put_eq_utility (G : Graph V) (q : Coloring V C) (x : V) (c : C)
    (hx : q x = none) (y : V) :
    tau G (put q x c) y = utility G q c y +
      if 0 < sameCount G q c y + (if Adj G y x then 1 else 0) then 1 else 0 := by
  rw [tau_put G q x c hx y, tau_eq_utility_add G q c y]
  by_cases hm : 0 < sameCount G q c y
  · have hc := (color_mem_iff_sameCount_pos G q c y).mpr hm
    by_cases ha : G.edge y x = true <;> simp [Adj, ha, hm, hc]
  · have hz : sameCount G q c y = 0 := by omega
    have hc : c ∉ neighborColors G q y := by
      intro h
      exact hm ((color_mem_iff_sameCount_pos G q c y).mp h)
    by_cases ha : G.edge y x = true <;> simp [Adj, ha, hz, hc]

/-- The stationary hole changes diversity only when the inserted color was absent. -/
theorem tau_put_stationary (G : Graph V) (q : Coloring V C) (x : V) (c : C)
    (hx : q x = none) (y : V) :
    tau G (put q x c) y = tau G q y +
      (if c ∈ neighborColors G q y then 0 else 1) *
      (if Adj G y x then 1 else 0) := by
  rw [tau_put G q x c hx y]
  by_cases hc : c ∈ neighborColors G q y <;>
    by_cases ha : G.edge y x = true <;> simp [Adj, hc, ha]

end Subcubic
