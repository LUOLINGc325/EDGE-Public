import LatticeOrthogonality
import SmoothedFourierSum

/-! Exact Fourier inversion of each atom of the finite lattice sum. -/

open scoped BigOperators
open Set MeasureTheory

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem MaximalLattice.atom_fourier_inversion {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) (n : ℕ) {s : ℝ}
    (hs : ∃ z : ℤ, s = (n : ℝ) * L.offset + L.span * (z : ℝ)) :
    (finiteSumEvent p Y n {s} : ℂ) =
      (L.span : ℂ) * ∫ t in -L.halfFrequency..L.halfFrequency,
        fourierPhase (-t * s) * characteristic p Y t ^ n := by
  let T := L.halfFrequency
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let F (q : Fin n → κ) (t : ℝ) :=
    (P q : ℂ) * fourierPhase (t * (iidSum Y q - s))
  have hInt (q : Fin n → κ) : IntervalIntegrable (F q) volume (-T) T := by
    have h : Continuous (F q) := continuous_const.mul
      (fourier_phase_continuous.comp (continuous_id.mul continuous_const))
    exact h.intervalIntegrable (-T) T
  have hPoint (t : ℝ) : fourierPhase (-t * s) * characteristic p Y t ^ n =
      ∑ q, F q t := by
    rw [← characteristic_independent_sum p Y n t, characteristic, FiniteMass.complexExpect,
      Finset.mul_sum]
    refine Finset.sum_congr rfl fun q _ => ?_
    unfold F
    calc
      _ = (P q : ℂ) * (fourierPhase (-t * s) * fourierPhase (t * iidSum Y q)) := by ring
      _ = _ := by rw [← fourier_phase_add, show -t * s + t * iidSum Y q =
        t * (iidSum Y q - s) by ring]
  unfold finiteSumEvent
  rw [← FiniteMass.complex_expect_coe]
  unfold FiniteMass.complexExpect
  change (∑ q : Fin n → κ, (P q : ℂ) *
      Complex.ofReal (({s} : Set ℝ).indicator (fun _ => (1 : ℝ)) (iidSum Y q))) =
    (L.span : ℂ) * ∫ t in -T..T, fourierPhase (-t * s) * characteristic p Y t ^ n
  simp_rw [hPoint]
  rw [intervalIntegral.integral_finset_sum (fun q _ => hInt q), Finset.mul_sum]
  refine Finset.sum_congr rfl fun q _ => ?_
  obtain ⟨z, hz⟩ := hs
  obtain ⟨w, hw⟩ := L.iid_sum_support q
  let k := w - z
  have he : iidSum Y q - s = L.span * (k : ℝ) := by
    rw [hw, hz]
    unfold k
    push_cast
    ring
  have hOrth : (∫ t in -T..T, fourierPhase (t * (iidSum Y q - s))) =
      if k = 0 then ((1 / L.span : ℝ) : ℂ) else 0 := by
    rw [he]
    exact lattice_phase_orthogonality L.span L.span_pos k
  unfold F
  rw [intervalIntegral.integral_const_mul, hOrth]
  by_cases hk : k = 0
  · have hzero : iidSum Y q - s = 0 := by rw [he, hk, Int.cast_zero, mul_zero]
    have hq : iidSum Y q ∈ ({s} : Set ℝ) := by simpa only [mem_singleton_iff] using sub_eq_zero.mp hzero
    have hCancel : (L.span : ℂ) * ((1 / L.span : ℝ) : ℂ) = 1 := by
      rw [← Complex.ofReal_mul, mul_div_cancel₀ _ L.span_pos.ne', Complex.ofReal_one]
    rw [indicator_of_mem hq, Complex.ofReal_one, mul_one, if_pos hk]
    calc
      _ = (P q : ℂ) * 1 := (mul_one _).symm
      _ = _ := by
        rw [← hCancel]
        ring
  · have hq : iidSum Y q ∉ ({s} : Set ℝ) := by
      intro h
      have h0 : iidSum Y q = s := h
      have hx : L.span * (k : ℝ) = 0 := by rw [← he, h0, sub_self]
      exact (mul_ne_zero L.span_pos.ne' (Int.cast_ne_zero.mpr hk)) hx
    rw [indicator_of_not_mem hq, Complex.ofReal_zero, if_neg hk, mul_zero, mul_zero]

end RenyiProductOrderPhase
