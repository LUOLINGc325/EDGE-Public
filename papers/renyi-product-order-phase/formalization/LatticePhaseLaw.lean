import FiniteLatticeLLT
import GridConcentration

/-! Exact phase normalization and the integer-indexed law of each lattice sum. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

variable {κ : Type*} {Y : κ → ℝ}

noncomputable def MaximalLattice.phase (L : MaximalLattice Y) (n : ℕ) : ℝ :=
  Int.fract ((n : ℝ) * L.offset / L.span)

theorem MaximalLattice.phase_bounds (L : MaximalLattice Y) (n : ℕ) :
    0 ≤ L.phase n ∧ L.phase n < 1 :=
  ⟨Int.fract_nonneg _, Int.fract_lt_one _⟩

noncomputable def MaximalLattice.phasePoint (L : MaximalLattice Y) (n : ℕ) (j : ℤ) : ℝ :=
  L.span * ((j : ℝ) + L.phase n)

theorem MaximalLattice.phase_point_eq (L : MaximalLattice Y) (n : ℕ) (j : ℤ) :
    L.phasePoint n j = (n : ℝ) * L.offset + L.span *
      ((j - ⌊(n : ℝ) * L.offset / L.span⌋ : ℤ) : ℝ) := by
  let t := (n : ℝ) * L.offset / L.span
  have h : L.span * (Int.fract t + (⌊t⌋ : ℝ)) = (n : ℝ) * L.offset := by
    rw [Int.fract_add_floor]
    unfold t
    exact mul_div_cancel₀ _ L.span_pos.ne'
  unfold MaximalLattice.phasePoint MaximalLattice.phase
  change L.span * ((j : ℝ) + Int.fract t) =
    (n : ℝ) * L.offset + L.span * ((j - ⌊t⌋ : ℤ) : ℝ)
  rw [Int.cast_sub, ← h]
  ring

theorem MaximalLattice.phase_point_index (L : MaximalLattice Y) (n : ℕ) (j : ℤ) :
    gridIndex L.span (L.phasePoint n j) = j := by
  unfold gridIndex MaximalLattice.phasePoint
  rw [mul_div_cancel_left₀ _ L.span_pos.ne', Int.floor_eq_iff]
  have h := L.phase_bounds n
  exact ⟨le_add_of_nonneg_right h.1, add_lt_add_left h.2 _⟩

theorem MaximalLattice.sum_eq_phase_point (L : MaximalLattice Y) {n : ℕ} (x : Fin n → κ) :
    iidSum Y x = L.phasePoint n (gridIndex L.span (iidSum Y x)) := by
  obtain ⟨z, hz⟩ := L.iid_sum_support x
  let j := z + ⌊(n : ℝ) * L.offset / L.span⌋
  have h : iidSum Y x = L.phasePoint n j := by
    rw [hz, L.phase_point_eq]
    unfold j
    rw [add_sub_cancel_right]
  have hIndex : gridIndex L.span (iidSum Y x) = j := by rw [h, L.phase_point_index]
  rw [hIndex]
  exact h

theorem MaximalLattice.sum_index_eq_iff (L : MaximalLattice Y) {n : ℕ} (x : Fin n → κ) (j : ℤ) :
    gridIndex L.span (iidSum Y x) = j ↔ iidSum Y x = L.phasePoint n j := by
  constructor
  · intro h
    exact h ▸ L.sum_eq_phase_point x
  · intro h
    rw [h, L.phase_point_index]

theorem arithmetic_support_shift_iff (Y : κ → ℝ) (r : ℝ) :
    ArithmeticSupport (fun y => Y y + r) ↔ ArithmeticSupport Y := by
  constructor
  · rintro ⟨a, h, hh, hY⟩
    refine ⟨a - r, h, hh, fun y => ?_⟩
    obtain ⟨z, hz⟩ := hY y
    change Y y + r = a + h * (z : ℝ) at hz
    exact ⟨z, by linarith only [hz]⟩
  · rintro ⟨a, h, hh, hY⟩
    refine ⟨a + r, h, hh, fun y => ?_⟩
    obtain ⟨z, hz⟩ := hY y
    refine ⟨z, ?_⟩
    change Y y + r = a + r + h * (z : ℝ)
    rw [hz]
    ring

noncomputable def MaximalLattice.shift (L : MaximalLattice Y) (r : ℝ) : MaximalLattice (fun y => Y y + r) where
  offset := L.offset + r
  span := L.span
  span_pos := L.span_pos
  support y := by
    obtain ⟨z, hz⟩ := L.support y
    refine ⟨z, ?_⟩
    change Y y + r = L.offset + r + L.span * (z : ℝ)
    rw [hz]
    ring
  maximal a h hh hs := by
    apply L.maximal (a - r) h hh
    intro y
    obtain ⟨z, hz⟩ := hs y
    change Y y + r = a + h * (z : ℝ) at hz
    exact ⟨z, by linarith only [hz]⟩

variable [Fintype κ]

theorem MaximalLattice.phase_atom_probability (L : MaximalLattice Y)
    (p : FiniteMass κ) (n : ℕ) (j : ℤ) :
    (FiniteMass.tensor (fun _ : Fin n => p)).expect
      (fun x => if gridIndex L.span (iidSum Y x) = j then 1 else 0) =
      finiteSumEvent p Y n {L.phasePoint n j} := by
  classical
  unfold finiteSumEvent FiniteMass.expect
  refine Finset.sum_congr rfl fun x _ => ?_
  change _ * (if gridIndex L.span (iidSum Y x) = j then (1 : ℝ) else 0) =
    _ * ({L.phasePoint n j} : Set ℝ).indicator (fun _ => (1 : ℝ)) (iidSum Y x)
  by_cases hx : gridIndex L.span (iidSum Y x) = j
  · have hs : iidSum Y x ∈ ({L.phasePoint n j} : Set ℝ) := (L.sum_index_eq_iff x j).1 hx
    rw [if_pos hx, Set.indicator_of_mem hs]
  · have hs : iidSum Y x ∉ ({L.phasePoint n j} : Set ℝ) := fun h => hx ((L.sum_index_eq_iff x j).2 h)
    rw [if_neg hx, Set.indicator_of_not_mem hs]

theorem MaximalLattice.phase_sum_expectation (L : MaximalLattice Y)
    (p : FiniteMass κ) (n : ℕ) (f : ℝ → ℝ) :
    (FiniteMass.tensor (fun _ : Fin n => p)).expect (fun x => f (iidSum Y x)) =
      ∑' j : ℤ, f (L.phasePoint n j) * finiteSumEvent p Y n {L.phasePoint n j} := by
  classical
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let cell (x : Fin n → κ) := gridIndex L.span (iidSum Y x)
  let J := Finset.univ.image cell
  have hEq : (fun x : Fin n → κ => f (iidSum Y x)) = fun x => f (L.phasePoint n (cell x)) := by
    funext x
    exact congrArg f (L.sum_eq_phase_point x)
  have hZero (j : ℤ) (hj : j ∉ J) : finiteSumEvent p Y n {L.phasePoint n j} = 0 := by
    rw [← L.phase_atom_probability]
    have h : (fun x : Fin n → κ => if cell x = j then (1 : ℝ) else 0) = fun _ => 0 := by
      funext x
      have hx : cell x ≠ j := fun he => hj (Finset.mem_image.2 ⟨x, Finset.mem_univ _, he⟩)
      exact if_neg hx
    change P.expect (fun x => if cell x = j then (1 : ℝ) else 0) = 0
    rw [h, P.expect_const]
  rw [hEq]
  rw [finite_expectation_by_cells P cell (fun j => f (L.phasePoint n j))]
  rw [tsum_eq_sum (s := J) (fun j hj => mul_eq_zero_of_right _ (hZero j hj))]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [L.phase_atom_probability]

end RenyiProductOrderPhase
