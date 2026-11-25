import FinitePowerTools
import Mathlib.Topology.Order.Compact
import Mathlib.Analysis.SpecialFunctions.Pow.Continuity

/-! The compact binary reference problem and its input and output power moments. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

noncomputable def inputPower (q : FiniteMass ι) (f : ι → ℝ) (a : ℝ) : ℝ :=
  q.expect (fun i => f i ^ a)

noncomputable def outputPower (q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (f : ι → ℝ) (a : ℝ) : ℝ :=
  (q.push w).expect (fun y => (q.conditionalMean w hw f y) ^ a)

noncomputable def logPowerGap (q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (c a : ℝ) (f : ι → ℝ) : ℝ :=
  Real.log (outputPower q w hw f a) - c * Real.log (inputPower q f a)

theorem input_power_ge_one (q : FiniteMass ι) (f : ι → ℝ) (hf : ∀ i, 0 ≤ f i)
    (hm : q.expect f = 1) {a : ℝ} (ha : 1 ≤ a) :
    1 ≤ inputPower q f a :=
  q.expect_power_ge_one f hf hm ha

theorem conditional_mean_nonneg (q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (f : ι → ℝ) (hf : ∀ i, 0 ≤ f i) (y : κ) :
    0 ≤ q.conditionalMean w hw f y :=
  (q.posterior w hw y).expect_nonneg hf

theorem conditional_mean_pos (q : FiniteMass ι) (hq : ∀ i, 0 < q i)
    (w : ι → FiniteMass κ) (hw : ∀ i y, 0 < w i y) (f : ι → ℝ)
    (hf : ∀ i, 0 ≤ f i) (hm : q.expect f = 1) (y : κ) :
    0 < q.conditionalMean w hw f y := by
  obtain ⟨i, hi⟩ : ∃ i, 0 < f i := by
    by_contra! hn
    have he := q.expect_mono (g := fun _ => 0) hn
    rw [hm, FiniteMass.expect_const] at he
    exact zero_lt_one.not_le he
  apply (q.posterior w hw y).expect_pos hf _ hi
  rw [FiniteMass.posterior_apply]
  exact div_pos (mul_pos (hq i) (hw i y)) (q.push_pos w hw y)

theorem output_power_ge_one (q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (f : ι → ℝ) (hf : ∀ i, 0 ≤ f i)
    (hm : q.expect f = 1) {a : ℝ} (ha : 1 ≤ a) :
    1 ≤ outputPower q w hw f a :=
  (q.push w).expect_power_ge_one (q.conditionalMean w hw f)
    (conditional_mean_nonneg q w hw f hf)
    ((q.expect_conditional_mean w hw f).trans hm) ha

noncomputable def binaryDensity (q : FiniteMass Bool) (z : ℝ) (i : Bool) : ℝ :=
  if i then (1 - z) / q true else z / q false

theorem binary_density_mean (q : FiniteMass Bool) (hq : ∀ i, 0 < q i) (z : ℝ) :
    q.expect (binaryDensity q z) = 1 := by
  unfold FiniteMass.expect
  rw [Fintype.sum_bool]
  change q true * ((1 - z) / q true) + q false * (z / q false) = 1
  rw [mul_div_cancel₀ _ (hq true).ne', mul_div_cancel₀ _ (hq false).ne']
  ring

theorem binary_density_nonneg (q : FiniteMass Bool) {z : ℝ}
    (hz : z ∈ Icc (0 : ℝ) 1) (i : Bool) : 0 ≤ binaryDensity q z i := by
  cases i
  · exact div_nonneg hz.1 (q.weight_nonneg false)
  · exact div_nonneg (sub_nonneg.mpr hz.2) (q.weight_nonneg true)

theorem binary_density_positive (q : FiniteMass Bool) (hq : ∀ i, 0 < q i) {z : ℝ}
    (hz : z ∈ Ioo (0 : ℝ) 1) (i : Bool) : 0 < binaryDensity q z i := by
  cases i
  · exact div_pos hz.1 (hq false)
  · exact div_pos (sub_pos.mpr hz.2) (hq true)

theorem every_binary_density (q : FiniteMass Bool) (hq : ∀ i, 0 < q i)
    (f : Bool → ℝ) (hf : ∀ i, 0 ≤ f i) (hm : q.expect f = 1) :
    ∃ z ∈ Icc (0 : ℝ) 1, f = binaryDensity q z := by
  have hsum : q true * f true + q false * f false = 1 := by
    simpa only [FiniteMass.expect, Fintype.sum_bool] using hm
  refine ⟨q false * f false,
    ⟨mul_nonneg (hq false).le (hf false),
      by linarith only [hsum, mul_nonneg (hq true).le (hf true)]⟩, ?_⟩
  funext i
  cases i
  · change f false = q false * f false / q false
    exact ((div_eq_iff (hq false).ne').2 (mul_comm _ _)).symm
  · change f true = (1 - q false * f false) / q true
    exact ((div_eq_iff (hq true).ne').2 (by linarith only [hsum])).symm

theorem binary_weight_lt_one (q : FiniteMass Bool) (hq : ∀ i, 0 < q i) (i : Bool) :
    q i < 1 := by
  have ht : q true + q false = 1 := by simpa only [Fintype.sum_bool] using q.total
  cases i
  · linarith only [ht, hq true]
  · linarith only [ht, hq false]

theorem binary_endpoint_power (q : FiniteMass Bool) (hq : ∀ i, 0 < q i)
    (i : Bool) {a : ℝ} (ha : 1 ≤ a) :
    inputPower q (binaryDensity q (if i then 0 else 1)) a = q i ^ (1 - a) := by
  have ha₀ : a ≠ 0 := (zero_lt_one.trans_le ha).ne'
  have hrecip (x : ℝ) (hx : 0 < x) : x * x⁻¹ ^ a = x ^ (1 - a) := by
    calc
      x * x⁻¹ ^ a = x ^ (1 : ℝ) * x ^ (-a) := by
        rw [Real.rpow_one, Real.inv_rpow hx.le, Real.rpow_neg hx.le]
      _ = _ := by rw [← Real.rpow_add hx, sub_eq_add_neg]
  cases i
  · simp [inputPower, FiniteMass.expect, Fintype.sum_bool, binaryDensity,
      Real.zero_rpow ha₀, hrecip (q false) (hq false)]
  · simp [inputPower, FiniteMass.expect, Fintype.sum_bool, binaryDensity,
      Real.zero_rpow ha₀, hrecip (q true) (hq true)]

theorem least_first_coordinate_maximizer {s : Set (ℝ × ℝ)} (hs : IsCompact s)
    (hn : s.Nonempty) (F : ℝ × ℝ → ℝ) (hF : ContinuousOn F s) :
    ∃ x ∈ s, (∀ y ∈ s, F y ≤ F x) ∧ (∀ y ∈ s, F y = F x → x.1 ≤ y.1) := by
  obtain ⟨x, hx, hMax⟩ := hs.exists_isMaxOn hn hF
  let G (z : ℝ × ℝ) := (F z, z.1)
  let E := (G '' s) ∩ {z : ℝ × ℝ | z.1 = F x}
  have hG : ContinuousOn G s := hF.prodMk continuous_fst.continuousOn
  have hE : IsCompact E :=
    (hs.image_of_continuousOn hG).inter_right (isClosed_eq continuous_fst continuous_const)
  obtain ⟨p, hp, hMin⟩ := hE.exists_isMinOn
    ⟨G x, ⟨⟨x, hx, rfl⟩, rfl⟩⟩ continuous_snd.continuousOn
  obtain ⟨y, hy, hGy⟩ := hp.1
  have hey : F y = F x :=
    (congrArg Prod.fst hGy).trans hp.2
  refine ⟨y, hy, ?_, ?_⟩
  · intro z hz
    exact (hMax hz).trans_eq hey.symm
  · intro z hz hzF
    have hm : G z ∈ E := ⟨⟨z, hz, rfl⟩, hzF.trans hey⟩
    have hmin : p.2 ≤ z.1 := hMin hm
    exact (congrArg Prod.snd hGy).le.trans hmin

end RenyiProductOrderPhase
