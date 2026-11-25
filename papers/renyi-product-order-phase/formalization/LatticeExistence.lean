import LatticeStructure
import Mathlib.Data.Nat.Find

/-! Every nonconstant arithmetic law has a largest positive lattice span. -/

namespace RenyiProductOrderPhase

theorem two_point_span_quotient {κ : Type*} {Y : κ → ℝ} {i j : κ} (hij : Y j < Y i)
    {a h : ℝ} (hh : 0 < h) (hs : ∀ y, ∃ z : ℤ, Y y = a + h * (z : ℝ)) :
    ∃ k : ℕ, 0 < k ∧ h = (Y i - Y j) / (k : ℝ) := by
  obtain ⟨u, hu⟩ := hs i
  obtain ⟨v, hv⟩ := hs j
  have he : Y i - Y j = h * ((u - v : ℤ) : ℝ) := by
    rw [hu, hv, Int.cast_sub]
    ring
  have hp : 0 < ((u - v : ℤ) : ℝ) := by
    have h := sub_pos.mpr hij
    rw [he] at h
    exact pos_of_mul_pos_right h hh.le
  have hp' : 0 < u - v := by exact_mod_cast hp
  let k := (u - v).toNat
  have hkInt : (k : ℤ) = u - v := Int.toNat_of_nonneg hp'.le
  have hk : (k : ℝ) = ((u - v : ℤ) : ℝ) := by exact_mod_cast hkInt
  have hkPos : 0 < k := by
    have h : 0 < (k : ℝ) := by simpa only [hk] using hp
    exact_mod_cast h
  exact ⟨k, hkPos, (eq_div_iff (by positivity : (k : ℝ) ≠ 0)).2 (by rw [hk, ← he])⟩

theorem maximal_lattice_exists {κ : Type*} {Y : κ → ℝ}
    (hNonconstant : ∃ i j, Y i ≠ Y j) (hArithmetic : ArithmeticSupport Y) :
    Nonempty (MaximalLattice Y) := by
  classical
  obtain ⟨i, j, hij⟩ := hNonconstant
  suffices H : ∀ u v : κ, Y v < Y u → Nonempty (MaximalLattice Y) by
    rcases lt_or_gt_of_ne hij with h | h
    · exact H j i h
    · exact H i j h
  intro u v huv
  let D := Y u - Y v
  have hD : 0 < D := sub_pos.mpr huv
  let P (k : ℕ) := 0 < k ∧ ∃ a : ℝ, ∀ y, ∃ z : ℤ, Y y = a + (D / (k : ℝ)) * (z : ℝ)
  have hExists : ∃ k, P k := by
    obtain ⟨a, h, hh, hs⟩ := hArithmetic
    obtain ⟨k, hk, he⟩ := two_point_span_quotient huv hh hs
    exact ⟨k, hk, a, fun y => he ▸ hs y⟩
  let k := Nat.find hExists
  obtain ⟨hk, a, ha⟩ : P k := Nat.find_spec hExists
  have hkPos : 0 < (k : ℝ) := by exact_mod_cast hk
  refine ⟨⟨a, D / (k : ℝ), div_pos hD hkPos, ha, ?_⟩⟩
  intro c h hh hs
  obtain ⟨m, hm, he⟩ := two_point_span_quotient huv hh hs
  have hmP : P m := ⟨hm, c, fun y => he ▸ hs y⟩
  have hkm : k ≤ m := Nat.find_min' hExists hmP
  rw [he]
  exact div_le_div_of_nonneg_left hD.le hkPos (by exact_mod_cast hkm)

end RenyiProductOrderPhase
