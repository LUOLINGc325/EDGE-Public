import CharacteristicScaling

/-! Affine lattice support and the characteristic function on its fundamental frequency band. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

variable {κ : Type*}

structure MaximalLattice (Y : κ → ℝ) where
  offset : ℝ
  span : ℝ
  span_pos : 0 < span
  support : ∀ i, ∃ k : ℤ, Y i = offset + span * (k : ℝ)
  maximal : ∀ (a h : ℝ), 0 < h → (∀ i, ∃ k : ℤ, Y i = a + h * (k : ℝ)) → h ≤ span

noncomputable def MaximalLattice.halfFrequency {Y : κ → ℝ} (L : MaximalLattice Y) : ℝ :=
  1 / (2 * L.span)

theorem MaximalLattice.half_frequency_pos {Y : κ → ℝ} (L : MaximalLattice Y) :
    0 < L.halfFrequency :=
  div_pos zero_lt_one (mul_pos (by norm_num) L.span_pos)

theorem MaximalLattice.iid_sum_support {Y : κ → ℝ} (L : MaximalLattice Y)
    {n : ℕ} (x : Fin n → κ) :
    ∃ k : ℤ, iidSum Y x = (n : ℝ) * L.offset + L.span * (k : ℝ) := by
  classical
  choose z hz using L.support
  refine ⟨∑ i, z (x i), ?_⟩
  unfold iidSum
  simp only [hz, Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul, Int.cast_sum, Finset.mul_sum]

variable [Fintype κ]

theorem MaximalLattice.characteristic_strict {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) (hp : ∀ i, 0 < p i) {t : ℝ}
    (ht : |t| ≤ L.halfFrequency) (hne : t ≠ 0) :
    ‖characteristic p Y t‖ < 1 := by
  refine lt_of_le_of_ne (characteristic_norm_le_one p Y t) (fun he => ?_)
  obtain ⟨a, ha⟩ := lattice_of_characteristic_unit p hp Y hne he
  have ha₀ : 0 < |t| := abs_pos.mpr hne
  have hspan := L.maximal a |t|⁻¹ (inv_pos.mpr ha₀) ha
  have hOne := mul_le_mul_of_nonneg_right hspan ha₀.le
  rw [inv_mul_cancel₀ ha₀.ne'] at hOne
  have ht' : |t| * (2 * L.span) ≤ 1 :=
    (le_div_iff₀ (mul_pos (by norm_num) L.span_pos)).1 ht
  nlinarith only [hOne, ht']

theorem MaximalLattice.characteristic_band {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) (hp : ∀ i, 0 < p i) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) :
    ∃ c > 0, ∀ t : ℝ, |t| ≤ L.halfFrequency →
      ‖characteristic p Y t‖ ≤ Real.exp (-c * t ^ 2) :=
  characteristic_gaussian_on_band_of_strict p Y hm hv L.half_frequency_pos
    (fun _ ht hne => L.characteristic_strict p hp ht hne)

end RenyiProductOrderPhase
