import CharacteristicTaylor
import Mathlib.Topology.Order.Compact

/-! Gaussian bounds on each fixed frequency band. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem characteristic_norm_near_zero (p : FiniteMass κ) (Y : κ → ℝ)
    (hMean : p.expect Y = 0) (hVar : 0 < p.expect (fun i => Y i ^ 2)) :
    ∃ δ > 0, ∀ t : ℝ, |t| ≤ δ →
      ‖characteristic p Y t‖ ≤
        Real.exp (-(Real.pi ^ 2 * p.expect (fun i => Y i ^ 2)) * t ^ 2) := by
  let k := 2 * Real.pi ^ 2 * p.expect (fun i => Y i ^ 2)
  let C := thirdRemainderWeight p Y
  have hk : 0 < k := mul_pos (mul_pos (by norm_num) (pow_pos Real.pi_pos 2)) hVar
  have hc : 0 ≤ C := third_remainder_weight_nonneg p Y
  have hk₁ : 0 < k + 1 := by linarith only [hk]
  have hc₁ : 0 < 2 * (C + 1) := by linarith only [hc]
  let δ := min 1 (min (1 / (k + 1)) (k / (2 * (C + 1))))
  have hδ : 0 < δ := lt_min zero_lt_one
    (lt_min (div_pos zero_lt_one hk₁) (div_pos hk hc₁))
  refine ⟨δ, hδ, ?_⟩
  intro t ht
  have ht₁ : |t| ≤ 1 := ht.trans (min_le_left _ _)
  have ht₂ : |t| ≤ 1 / (k + 1) :=
    ht.trans ((min_le_right _ _).trans (min_le_left _ _))
  have ht₃ : |t| ≤ k / (2 * (C + 1)) :=
    ht.trans ((min_le_right _ _).trans (min_le_right _ _))
  have hs : |t| ^ 2 ≤ |t| := by
    nlinarith only [mul_nonneg (abs_nonneg t) (sub_nonneg.mpr ht₁)]
  have hkT : |t| * (k + 1) ≤ 1 := (le_div_iff₀ hk₁).1 ht₂
  have hcT : |t| * (2 * (C + 1)) ≤ k := (le_div_iff₀ hc₁).1 ht₃
  have hbase : 0 ≤ 1 - k * t ^ 2 := by
    rw [← sq_abs t]
    nlinarith only [mul_le_mul_of_nonneg_left hs hk.le, hkT, abs_nonneg t]
  have hcT' : C * |t| ≤ k / 2 := by nlinarith only [hcT, abs_nonneg t]
  let z : ℂ := ((1 - k * t ^ 2 : ℝ) : ℂ)
  have htaylor : ‖characteristic p Y t - z‖ ≤ C * |t| ^ 3 :=
    centered_characteristic_remainder p Y hMean ht₁
  have hnorm : ‖z‖ = 1 - k * t ^ 2 := Complex.norm_of_nonneg hbase
  have hkHalf : k / 2 = Real.pi ^ 2 * p.expect (fun i => Y i ^ 2) := by
    unfold k
    ring
  calc
    ‖characteristic p Y t‖ =
        ‖(characteristic p Y t - z) + z‖ := by rw [sub_add_cancel]
    _ ≤ ‖characteristic p Y t - z‖ + ‖z‖ := norm_add_le _ _
    _ ≤ C * |t| ^ 3 + (1 - k * t ^ 2) := by
      rw [hnorm]
      exact add_le_add_right htaylor _
    _ ≤ 1 + (-(k / 2)) * t ^ 2 := by
      have hs' := mul_le_mul_of_nonneg_right hcT' (sq_nonneg |t|)
      rw [← sq_abs t]
      nlinarith only [hs']
    _ ≤ _ := by
      rw [← hkHalf]
      simpa only [add_comm] using Real.add_one_le_exp (-(k / 2) * t ^ 2)

theorem characteristic_gaussian_on_band_of_strict (p : FiniteMass κ) (Y : κ → ℝ)
    (hMean : p.expect Y = 0) (hVar : 0 < p.expect (fun i => Y i ^ 2))
    {T : ℝ} (hT : 0 < T)
    (hStrict : ∀ t : ℝ, |t| ≤ T → t ≠ 0 → ‖characteristic p Y t‖ < 1) :
    ∃ c > 0, ∀ t : ℝ, |t| ≤ T → ‖characteristic p Y t‖ ≤ Real.exp (-c * t ^ 2) := by
  obtain ⟨δ, hδ, hlocal⟩ := characteristic_norm_near_zero p Y hMean hVar
  let d := min δ T
  let K := Icc (-T) T ∩ {x : ℝ | d ≤ |x|}
  let f (t : ℝ) := ‖characteristic p Y t‖
  have hd : 0 < d := lt_min hδ hT
  have hK : IsCompact K := isCompact_Icc.inter_right (isClosed_le continuous_const continuous_abs)
  have hKT : T ∈ K := by
    refine ⟨⟨by linarith only [hT], le_rfl⟩, ?_⟩
    change d ≤ |T|
    rw [abs_of_pos hT]
    exact min_le_right _ _
  obtain ⟨x, hx, hMax⟩ := hK.exists_isMaxOn ⟨T, hKT⟩
    ((characteristic_continuous p Y).norm.continuousOn (s := K))
  have hx₀ : x ≠ 0 := by
    intro hz
    have he : d ≤ |x| := hx.2
    rw [hz, abs_zero] at he
    exact hd.not_le he
  have hgap : f x < 1 := hStrict x (abs_le.mpr hx.1) hx₀
  let c₁ := Real.pi ^ 2 * p.expect (fun i => Y i ^ 2)
  let c₂ := (1 - f x) / T ^ 2
  have hc₁ : 0 < c₁ := mul_pos (pow_pos Real.pi_pos 2) hVar
  have hc₂ : 0 < c₂ := div_pos (sub_pos.mpr hgap) (pow_pos hT 2)
  let c := min c₁ c₂
  refine ⟨c, lt_min hc₁ hc₂, ?_⟩
  intro t ht
  by_cases ht' : |t| ≤ d
  · exact (hlocal t (ht'.trans (min_le_left _ _))).trans
      (Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_right
        (neg_le_neg (min_le_left c₁ c₂)) (sq_nonneg t)))
  · have htK : t ∈ K := ⟨abs_le.mp ht, (lt_of_not_ge ht').le⟩
    have htSq : t ^ 2 ≤ T ^ 2 := by
      rw [← sq_abs t]
      exact pow_le_pow_left₀ (abs_nonneg t) ht 2
    have hc : c₂ * T ^ 2 = 1 - f x := div_mul_cancel₀ _ (pow_pos hT 2).ne'
    have hm : f x ≤ 1 + (-c₂) * t ^ 2 := by
      nlinarith only [mul_le_mul_of_nonneg_left htSq hc₂.le, hc]
    have he : 1 + (-c₂) * t ^ 2 ≤ Real.exp (-c₂ * t ^ 2) := by
      simpa only [add_comm] using Real.add_one_le_exp (-c₂ * t ^ 2)
    have hExp : Real.exp (-c₂ * t ^ 2) ≤ Real.exp (-c * t ^ 2) :=
      Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_right
        (neg_le_neg (min_le_right c₁ c₂)) (sq_nonneg t))
    exact (hMax htK).trans (hm.trans (he.trans hExp))

theorem characteristic_gaussian_on_band (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (Y : κ → ℝ) (hNon : ¬ ArithmeticSupport Y)
    (hMean : p.expect Y = 0) (hVar : 0 < p.expect (fun i => Y i ^ 2))
    {T : ℝ} (hT : 0 < T) :
    ∃ c > 0, ∀ t : ℝ, |t| ≤ T → ‖characteristic p Y t‖ ≤ Real.exp (-c * t ^ 2) := by
  exact characteristic_gaussian_on_band_of_strict p Y hMean hVar hT
    (fun t _ ht => characteristic_norm_strict_nonarithmetic p hp Y hNon ht)

end RenyiProductOrderPhase
