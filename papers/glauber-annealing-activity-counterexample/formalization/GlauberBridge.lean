import RegularGlauber

open scoped BigOperators

namespace GlauberAnnealing

variable {V : Type*} [Fintype V] {M : RegularGraph V}

/-- The cut produced by deleting a bridge, oriented from its lower-energy side. -/
structure BridgeCut (M : RegularGraph V) where
  low : V → Prop
  source : V
  target : V
  low_source : low source
  high_target : ¬low target
  adj : M.graph.Adj source target
  unique_crossing : ∀ {i j}, low i → ¬low j → M.graph.Adj i j → i = source ∧ j = target

namespace BridgeCut

noncomputable def ofIsBridge {s t : V}
    (h : M.graph.IsBridge s(s, t)) : BridgeCut M := by
  classical
  let H := M.graph \ SimpleGraph.fromEdgeSet {s(s, t)}
  obtain ⟨hst, hnot⟩ := SimpleGraph.isBridge_iff.mp h
  refine ⟨H.Reachable s, s, t, SimpleGraph.Reachable.refl s, hnot, hst, ?_⟩
  intro i j hi hj ha
  have he : s(i, j) = s(s, t) := by
    by_contra hn
    have hadj : H.Adj i j := by
      refine (SimpleGraph.sdiff_adj _ _ _ _).2 ⟨ha, ?_⟩
      exact fun hf => hn (Set.mem_singleton_iff.mp ((SimpleGraph.fromEdgeSet_adj _).mp hf).1)
    exact hj (hi.trans hadj.reachable)
  rcases Sym2.eq_iff.mp he with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · exact ⟨rfl, rfl⟩
  · exact (hnot hi).elim

variable (C : BridgeCut M)

theorem endpoints_ne : C.source ≠ C.target :=
  fun h => C.high_target (h ▸ C.low_source)

theorem endpoint_mem_neighbors : C.target ∈ neighbors M.graph C.source :=
  mem_neighbors.mpr C.adj

theorem source_mem_neighbors : C.source ∈ neighbors M.graph C.target :=
  mem_neighbors.mpr C.adj.symm

theorem same_side_of_nonendpoint {i j : V} (hi : i ≠ C.source) (hj : i ≠ C.target)
    (h : M.graph.Adj i j) : C.low i ↔ C.low j := by
  classical
  constructor
  · intro h₁
    by_contra h₂
    exact hi ((C.unique_crossing h₁ h₂ h).1)
  · intro h₂
    by_contra h₁
    exact hj ((C.unique_crossing h₂ h₁ h.symm).2)

noncomputable def base (i : V) : ℝ := by
  classical exact if C.low i then 0 else 1

noncomputable def slope (i : V) : ℝ := by
  classical exact if i = C.source then 1 else if i = C.target then -1 else 0

noncomputable def energy (ε : ℝ) (i : V) : ℝ := C.base i + ε * C.slope i

theorem energy_source (ε : ℝ) : C.energy ε C.source = ε := by
  classical
  simp [energy, base, slope, C.low_source]

theorem energy_target (ε : ℝ) : C.energy ε C.target = 1 - ε := by
  classical
  simp [energy, base, slope, C.high_target, Ne.symm C.endpoints_ne, sub_eq_add_neg]

theorem same_side_difference (ε : ℝ) {i j : V} (h : C.low i ↔ C.low j) :
    C.energy ε i - C.energy ε j = ε * (C.slope i - C.slope j) := by
  classical
  unfold energy base
  rw [if_congr h rfl rfl]
  ring

open Classical in
theorem source_neighbor_difference (ε : ℝ) {j : V} (h : M.graph.Adj C.source j) :
    C.energy ε C.source - C.energy ε j =
      if j = C.target then 2 * ε - 1 else ε := by
  classical
  by_cases hj : j = C.target
  · rw [if_pos hj, hj, C.energy_source, C.energy_target]
    ring
  · have hlo : C.low j := by
      by_cases hhi : C.low j
      · exact hhi
      · exact False.elim (hj (C.unique_crossing C.low_source hhi h).2)
    have hn : j ≠ C.source := h.ne.symm
    rw [if_neg hj, C.energy_source]
    simp [energy, base, slope, hlo, hn, hj]

open Classical in
theorem target_neighbor_difference (ε : ℝ) {j : V} (h : M.graph.Adj C.target j) :
    C.energy ε C.target - C.energy ε j =
      if j = C.source then 1 - 2 * ε else -ε := by
  classical
  by_cases hj : j = C.source
  · rw [if_pos hj, hj, C.energy_source, C.energy_target]
    ring
  · have hhi : ¬C.low j := fun hlo => hj (C.unique_crossing hlo C.high_target h.symm).1
    have hn : j ≠ C.target := h.ne.symm
    rw [if_neg hj, C.energy_target]
    simp [energy, base, slope, hhi, hn, hj]

noncomputable def scale (x : ℝ) : ℝ := (x ^ 2)⁻¹

noncomputable def early (x : ℝ) : ℝ := scale x
noncomputable def middle (x : ℝ) : ℝ := x
noncomputable def late (x : ℝ) : ℝ := x ^ 4

theorem inverse_temperature_order {x : ℝ} (hx : 2 < x) :
    0 < early x ∧ early x < middle x ∧ middle x < late x := by
  have hx0 : 0 < x := by linarith
  have hx1 : 1 < x := by linarith
  have hx2 : 1 < x ^ 2 := by nlinarith
  have hxp : x < x ^ 4 := by
    have hcube : 1 < x ^ 3 := by
      calc
        1 < x ^ 2 := hx2
        _ = x ^ 2 * 1 := (mul_one _).symm
        _ < x ^ 2 * x := mul_lt_mul_of_pos_left hx1 (sq_pos_of_pos hx0)
        _ = x ^ 3 := by ring
    calc
      x = x * 1 := (mul_one _).symm
      _ < x * x ^ 3 := mul_lt_mul_of_pos_left hcube hx0
      _ = x ^ 4 := by ring
  refine ⟨by unfold early scale; positivity, ?_, hxp⟩
  unfold early scale middle
  exact (inv_lt_one_of_one_lt₀ hx2).trans hx1

end BridgeCut
end GlauberAnnealing
