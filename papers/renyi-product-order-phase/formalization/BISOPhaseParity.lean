import LatticePhaseLaw
import CumulantTilt

/-! A symmetric arithmetic likelihood law has at most two fixed-order phases. -/

namespace RenyiProductOrderPhase.BinarySymmetricChannel

variable {κ : Type*} [Fintype κ]

theorem twice_lattice_offset_integral (w : BinarySymmetricChannel κ)
    (L : MaximalLattice (logLikelihood (w.channel false) (w.channel true))) :
    ∃ m : ℤ, 2 * L.offset = L.span * (m : ℝ) := by
  obtain ⟨i, _⟩ := (w.channel false).exists_weight_pos
  obtain ⟨a, ha⟩ := L.support i
  obtain ⟨b, hb⟩ := L.support (w.flip i)
  rw [w.log_likelihood_flip] at hb
  refine ⟨-(a + b), ?_⟩
  push_cast
  linarith only [ha, hb]

theorem fixed_order_lattice_phase_two_periodic (w : BinarySymmetricChannel κ)
    (L : MaximalLattice (logLikelihood (w.channel false) (w.channel true))) (n : ℕ) :
    L.phase (n + 2) = L.phase n := by
  obtain ⟨m, hm⟩ := w.twice_lattice_offset_integral L
  have h : (((n + 2 : ℕ) : ℝ) * L.offset / L.span) =
      (n : ℝ) * L.offset / L.span + (m : ℝ) := by
    push_cast
    rw [add_mul, add_div, hm, mul_div_cancel_left₀ _ L.span_pos.ne']
  unfold MaximalLattice.phase
  rw [h, Int.fract_add_intCast]

theorem fixed_order_lattice_phases (w : BinarySymmetricChannel κ)
    (L : MaximalLattice (logLikelihood (w.channel false) (w.channel true))) (n : ℕ) :
    L.phase n = 0 ∨ L.phase n = 1 / 2 := by
  obtain ⟨m, hm⟩ := w.twice_lattice_offset_integral L
  let t := (n : ℝ) * L.offset / L.span
  let j : ℤ := (n : ℤ) * m
  have h : 2 * t = (j : ℝ) := by
    calc
      _ = ((n : ℝ) * (2 * L.offset)) / L.span := by unfold t; ring
      _ = _ := by
        rw [hm]
        unfold j
        push_cast
        field_simp [L.span_pos.ne']
        ring
  let k : ℤ := j - 2 * ⌊t⌋
  have hk : 2 * Int.fract t = (k : ℝ) := by
    have h2 : (((2 * ⌊t⌋ : ℤ)) : ℝ) = 2 * (⌊t⌋ : ℝ) := by push_cast; rfl
    change 2 * (t - (⌊t⌋ : ℝ)) = ((j - 2 * ⌊t⌋ : ℤ) : ℝ)
    rw [Int.cast_sub, mul_sub, h, h2]
  have h0 : 0 ≤ (k : ℝ) := by rw [← hk]; exact mul_nonneg (by norm_num) (Int.fract_nonneg _)
  have h2 : (k : ℝ) < 2 := by
    rw [← hk]
    linarith only [Int.fract_lt_one t]
  have hk₀ : 0 ≤ k := by exact_mod_cast h0
  have hk₂ : k < 2 := by exact_mod_cast h2
  have hj : k = 0 ∨ k = 1 := by omega
  change Int.fract t = 0 ∨ Int.fract t = 1 / 2
  rcases hj with he | he
  · left
    rw [he, Int.cast_zero] at hk
    linarith only [hk]
  · right
    rw [he, Int.cast_one] at hk
    linarith only [hk]

theorem binary_output_always_arithmetic (Y : Bool → ℝ) : ArithmeticSupport Y := by
  by_cases he : Y true = Y false
  · refine ⟨Y false, 1, zero_lt_one, fun i => ⟨0, ?_⟩⟩
    cases i <;> simp only [he, Int.cast_zero, mul_zero, add_zero]
  · rcases lt_or_gt_of_ne he with h | h
    · refine ⟨Y true, Y false - Y true, sub_pos.mpr h, ?_⟩
      intro i
      cases i
      · refine ⟨1, ?_⟩
        rw [Int.cast_one, mul_one]
        ring
      · exact ⟨0, by rw [Int.cast_zero, mul_zero, add_zero]⟩
    · refine ⟨Y false, Y true - Y false, sub_pos.mpr h, ?_⟩
      intro i
      cases i
      · exact ⟨0, by rw [Int.cast_zero, mul_zero, add_zero]⟩
      · refine ⟨1, ?_⟩
        rw [Int.cast_one, mul_one]
        ring

end RenyiProductOrderPhase.BinarySymmetricChannel
