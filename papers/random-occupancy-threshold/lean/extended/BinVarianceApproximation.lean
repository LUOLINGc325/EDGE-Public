import BinPowerApproximation
import OccupancyVariance

namespace TwoColorNullity.Occupancy

private theorem power_difference_bounds (a b : ℝ) (hb : 0 ≤ b) (hab : b ≤ a) (r : ℕ) :
    ((r + 1 : ℕ) : ℝ) * (a - b) * b ^ r ≤ a ^ (r + 1) - b ^ (r + 1) ∧
      a ^ (r + 1) - b ^ (r + 1) ≤ ((r + 1 : ℕ) : ℝ) * (a - b) * a ^ r := by
  induction r with
  | zero => simp
  | succ r ih =>
    have ha := hb.trans hab
    have hd := sub_nonneg.mpr hab
    have lower := mul_le_mul_of_nonneg_left ih.1 hb
    have upper := mul_le_mul_of_nonneg_left ih.2 ha
    have hc := mul_le_mul_of_nonneg_left (pow_le_pow_left₀ hb hab (r + 1)) hd
    simp only [Nat.cast_succ, pow_succ] at lower upper hc ⊢
    exact ⟨by nlinarith only [lower, hc], by nlinarith only [upper, hc]⟩

noncomputable def varianceCurve (lambda : ℝ) : ℝ :=
  1 - (1 + 4 * lambda) * Real.exp (-(4 * lambda))

theorem varianceCurve_pos {lambda : ℝ} (hl : 0 < lambda) : 0 < varianceCurve lambda := by
  have h : 4 * lambda + 1 < Real.exp (4 * lambda) :=
    Real.add_one_lt_exp (by positivity : 4 * lambda ≠ 0)
  unfold varianceCurve
  rw [Real.exp_neg, ← div_eq_mul_inv]
  apply sub_pos.mpr
  exact (div_lt_iff₀ (Real.exp_pos _)).mpr (by linarith)

private theorem variance_pow_bounds (m : ℕ) (hm : 0 < m) (k : ℝ) (hk : 8 ≤ k) :
    let a := (1 - 2 / k) ^ 2
    let b := 1 - 4 / k
    let y := 4 * (m : ℝ) / k
    let e := Real.exp (-y)
    let value := 1 - a ^ m + (k - 1) * (b ^ m - a ^ m)
    1 - (1 + y) * e - y * (4 / k) ≤ value ∧
      value ≤ 1 - (1 + y) * e + 16 * (m : ℝ) / k ^ 2 + y * (32 * (m : ℝ) / k ^ 2 + 1 / k) := by
  dsimp only
  let x := 2 / k
  let z := 4 / k
  let a := (1 - x) ^ 2
  let b := 1 - z
  let y := 4 * (m : ℝ) / k
  let q := 1 - 1 / k
  let e := Real.exp (-y)
  let r := m - 1
  have hkpos : 0 < k := by linarith
  have hx0 : 0 ≤ x := by positivity
  have hz0 : 0 ≤ z := by positivity
  have hxhalf : x ≤ 1 / 2 := by
    apply (div_le_iff₀ hkpos).mpr
    linarith
  have hzhalf : z ≤ 1 / 2 := by
    apply (div_le_iff₀ hkpos).mpr
    linarith
  have hb0 : 0 ≤ b := by dsimp [b]; linarith
  have hb1 : b ≤ 1 := by dsimp [b]; linarith
  have hd : a - b = 4 / k ^ 2 := by
    unfold a b x z
    field_simp [hkpos.ne']
    ring
  have hba : b ≤ a := by
    have hp : 0 ≤ 4 / k ^ 2 := by positivity
    linarith
  have ha0 := hb0.trans hba
  have hq : q ≤ 1 := by
    unfold q
    have hp : 0 ≤ 1 / k := by positivity
    linarith
  have hy0 : 0 ≤ y := by positivity
  have hr : r + 1 = m := by dsimp [r]; omega
  have hrR : (r : ℝ) + 1 = m := by exact_mod_cast hr
  have hrLe : (r : ℝ) ≤ m := by linarith
  have hA (l : ℕ) :
      0 ≤ Real.exp (-(l : ℝ) * z) - a ^ l ∧
        Real.exp (-(l : ℝ) * z) - a ^ l ≤ 16 * (l : ℝ) / k ^ 2 := by
    have h := binPower_exp_approximation (2 * l) x hx0 hxhalf
    have hp : a ^ l = (1 - x) ^ (2 * l) := (pow_mul _ _ _).symm
    have he : -((2 * l : ℕ) : ℝ) * x = -(l : ℝ) * z := by
      push_cast
      unfold x z
      ring
    have hrhs : 2 * ((2 * l : ℕ) : ℝ) * x ^ 2 = 16 * (l : ℝ) / k ^ 2 := by
      push_cast
      unfold x
      ring
    rwa [← hp, he, hrhs] at h
  have hB (l : ℕ) :
      0 ≤ Real.exp (-(l : ℝ) * z) - b ^ l ∧
        Real.exp (-(l : ℝ) * z) - b ^ l ≤ 32 * (l : ℝ) / k ^ 2 := by
    have h := binPower_exp_approximation l z hz0 hzhalf
    have hrhs : 2 * (l : ℝ) * z ^ 2 = 32 * (l : ℝ) / k ^ 2 := by unfold z; ring
    rwa [hrhs] at h
  have hy : -(m : ℝ) * z = -y := by unfold y z; ring
  have hdelt : -(r : ℝ) * z - (-y) = z := by
    rw [← hy, ← sub_mul, show -(r : ℝ) - -(m : ℝ) = 1 by linarith [hrR], one_mul]
  have harg : -y ≤ -(r : ℝ) * z := by linarith
  have hastr : -(r : ℝ) * z ≤ 0 := mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (Nat.cast_nonneg r)) hz0
  have hdelta := exp_sub_le_sub_nonpositive _ _ harg hastr
  change Real.exp (-(r : ℝ) * z) - e ≤ _ at hdelta
  rw [hdelt] at hdelta
  have hE : e ≤ Real.exp (-(r : ℝ) * z) := Real.exp_le_exp.mpr harg
  have hAm := hA m
  rw [hy] at hAm
  change 0 ≤ e - a ^ m ∧ e - a ^ m ≤ 16 * (m : ℝ) / k ^ 2 at hAm
  have hAprev : a ^ r ≤ e + z := by linarith only [(hA r).1, hdelta]
  have hBprev : e - 32 * (m : ℝ) / k ^ 2 ≤ b ^ r := by
    have hsc : 32 * (r : ℝ) / k ^ 2 ≤ 32 * (m : ℝ) / k ^ 2 := by gcongr
    linarith only [(hB r).2, hE, hsc]
  have hBpow : b ^ r ≤ 1 := by simpa only [one_pow] using pow_le_pow_left₀ hb0 hb1 r
  have hprod : (k - 1) * ((m : ℝ) * (a - b)) = y * q := by
    rw [hd]
    unfold y q
    field_simp [hkpos.ne']
  let difference := (k - 1) * (a ^ m - b ^ m)
  have hp := power_difference_bounds a b hb0 hba r
  rw [hr] at hp
  have hxlo : y * q * b ^ r ≤ difference := by
    unfold difference
    rw [← hprod, mul_assoc]
    exact mul_le_mul_of_nonneg_left hp.1 (by linarith)
  have hxhi : difference ≤ y * q * a ^ r := by
    unfold difference
    rw [← hprod, mul_assoc]
    exact mul_le_mul_of_nonneg_left hp.2 (by linarith)
  have hlo : e - (32 * (m : ℝ) / k ^ 2 + 1 / k) ≤ q * b ^ r := by
    have hBprod := mul_le_mul_of_nonneg_left hBpow (show 0 ≤ 1 / k by positivity)
    unfold q
    nlinarith only [hBprev, hBprod]
  have hhi : q * a ^ r ≤ e + z := by
    exact (mul_le_mul_of_nonneg_right hq (pow_nonneg ha0 _)).trans (by simpa only [one_mul] using hAprev)
  have hboundlo := (mul_le_mul_of_nonneg_left hlo hy0).trans (by simpa only [mul_assoc] using hxlo)
  have hboundhi := hxhi.trans (by simpa only [mul_assoc] using mul_le_mul_of_nonneg_left hhi hy0)
  change 1 - (1 + y) * e - y * z ≤ 1 - a ^ m + (k - 1) * (b ^ m - a ^ m) ∧
    1 - a ^ m + (k - 1) * (b ^ m - a ^ m) ≤
      1 - (1 + y) * e + 16 * (m : ℝ) / k ^ 2 + y * (32 * (m : ℝ) / k ^ 2 + 1 / k)
  unfold difference at hboundlo hboundhi
  exact ⟨by nlinarith only [hAm.1, hboundhi], by nlinarith only [hAm.2, hboundlo]⟩

/-- The normalized variance differs from its Poisson-scale limit by explicit inverse-bin errors. -/
theorem oddBinVariance_approximation (m k : ℕ) (hm : 0 < m) (hk : 8 ≤ k) :
    let lambda := (m : ℝ) / (k : ℝ)
    let normalized := 4 * oddBinVariance (Fin m) (Fin k) / (k : ℝ)
    varianceCurve lambda - 16 * lambda / (k : ℝ) ≤ normalized ∧
      normalized ≤ varianceCurve lambda + (16 * lambda + 4 * lambda * (32 * lambda + 1)) / (k : ℝ) := by
  letI : NeZero k := ⟨by omega⟩
  have hkR : (0 : ℝ) < k := by exact_mod_cast (show 0 < k by omega)
  have hb := variance_pow_bounds m hm (k : ℝ) (by exact_mod_cast hk)
  have hv := oddBinVariance_exact (Item := Fin m) (Label := Fin k)
  simp only [singleParityMean, pairParityMean, Fintype.card_fin] at hv
  dsimp only at hb ⊢
  rw [hv]
  have hsquare : ((1 - 2 / (k : ℝ)) ^ m) ^ 2 = ((1 - 2 / (k : ℝ)) ^ 2) ^ m := by
    rw [← pow_mul, ← pow_mul, Nat.mul_comm m 2]
  rw [hsquare]
  have hquot :
      ((k : ℝ) * (1 - ((1 - 2 / (k : ℝ)) ^ 2) ^ m) +
        (k : ℝ) * ((k : ℝ) - 1) * ((1 - 4 / (k : ℝ)) ^ m - ((1 - 2 / (k : ℝ)) ^ 2) ^ m)) / (k : ℝ) =
      1 - ((1 - 2 / (k : ℝ)) ^ 2) ^ m + ((k : ℝ) - 1) *
        ((1 - 4 / (k : ℝ)) ^ m - ((1 - 2 / (k : ℝ)) ^ 2) ^ m) := by
    field_simp [hkR.ne']
  rw [hquot]
  unfold varianceCurve
  have hy : 4 * (m : ℝ) / (k : ℝ) = 4 * ((m : ℝ) / (k : ℝ)) := by ring
  rw [hy] at hb
  have hfirst : 4 * ((m : ℝ) / (k : ℝ)) * (4 / (k : ℝ)) =
      16 * ((m : ℝ) / (k : ℝ)) / (k : ℝ) := by ring
  have hsecond :
      16 * (m : ℝ) / (k : ℝ) ^ 2 + (4 * ((m : ℝ) / (k : ℝ))) *
        (32 * (m : ℝ) / (k : ℝ) ^ 2 + 1 / (k : ℝ)) =
      (16 * ((m : ℝ) / (k : ℝ)) + 4 * ((m : ℝ) / (k : ℝ)) *
        (32 * ((m : ℝ) / (k : ℝ)) + 1)) / (k : ℝ) := by ring
  rw [hfirst, add_assoc, hsecond] at hb
  exact hb

end TwoColorNullity.Occupancy
