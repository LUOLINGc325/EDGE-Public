import LatticeTestLimit

/-! A positive lattice atom in every fixed-width logarithmic central window. -/

open Set

namespace RenyiProductOrderPhase

theorem shifted_lattice_point_after {h : ℝ} (hh : 0 < h) (φ x : ℝ) :
    ∃ j : ℤ, x < h * ((j : ℝ) + φ) ∧ h * ((j : ℝ) + φ) ≤ x + h := by
  let t := x / h - φ
  let j := ⌊t⌋ + 1
  have ht : h * (t + φ) = x := by
    unfold t
    rw [sub_add_cancel, mul_div_cancel₀ _ hh.ne']
  have hLeft : t < (j : ℝ) := by
    unfold j
    simpa only [Int.cast_add, Int.cast_one] using Int.lt_floor_add_one t
  have hRight : (j : ℝ) ≤ t + 1 := by
    unfold j
    rw [Int.cast_add, Int.cast_one]
    exact add_le_add_right (Int.floor_le t) _
  refine ⟨j, ?_, ?_⟩
  · exact ht ▸ mul_lt_mul_of_pos_left (add_lt_add_right hLeft φ) hh
  · calc
      _ ≤ h * ((t + 1) + φ) := mul_le_mul_of_nonneg_left (add_le_add_right hRight φ) hh.le
      _ = h * (t + φ) + h := by ring
      _ = _ := by rw [ht]

variable {κ : Type*} [Fintype κ]

theorem MaximalLattice.logarithmic_interval_lower {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) (hp : ∀ i, 0 < p i) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) (D E : ℝ) :
    ∃ c > 0, ∃ N : ℕ, ∀ n ≥ N, ∀ x : ℝ,
      |x| ≤ D * Real.log ((n + 1 : ℕ) : ℝ) + E →
      c ≤ Real.sqrt ((n + 1 : ℕ) : ℝ) *
        finiteSumEvent p Y (n + 1) (Ico x (x + 2 * L.span)) := by
  obtain ⟨c, hc, N, hN⟩ := finite_lattice_central_atom L p hp hm hv D (E + L.span)
  refine ⟨c, hc, N, ?_⟩
  intro n hn x hx
  obtain ⟨j, hj₀, hj₁⟩ := shifted_lattice_point_after L.span_pos (L.phase (n + 1)) x
  let s := L.phasePoint (n + 1) j
  have hs₀ : x < s := hj₀
  have hs₁ : s ≤ x + L.span := hj₁
  have hs : s ∈ Ico x (x + 2 * L.span) := ⟨hs₀.le, by linarith only [hs₁, L.span_pos]⟩
  have hAbs : |s| ≤ D * Real.log ((n + 1 : ℕ) : ℝ) + (E + L.span) := by
    have hDiff : |s - x| ≤ L.span := by
      rw [abs_of_nonneg (sub_nonneg.mpr hs₀.le)]
      linarith only [hs₁]
    have h := abs_sub_le s x 0
    simp only [sub_zero] at h
    linarith only [h, hx, hDiff]
  have hLaw := hN n hn s ⟨_, L.phase_point_eq (n + 1) j⟩ hAbs
  have hset : ({s} : Set ℝ) ⊆ Ico x (x + 2 * L.span) := singleton_subset_iff.2 hs
  exact hLaw.trans (mul_le_mul_of_nonneg_left (finite_sum_event_mono p Y (n + 1) hset)
    (Real.sqrt_nonneg _))

end RenyiProductOrderPhase
