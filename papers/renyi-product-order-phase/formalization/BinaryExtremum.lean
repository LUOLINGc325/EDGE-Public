import BinaryMoments

/-! The least-order maximizer used in the binary endpoint argument. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem log_power_gap_le_iff (q : FiniteMass Bool) (w : Bool → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (f : Bool → ℝ) (a c d : ℝ)
    (hA : 0 < inputPower q f a) (hB : 0 < outputPower q w hw f a) :
    logPowerGap q w hw c a f ≤ d ↔
      outputPower q w hw f a ≤ Real.exp d * inputPower q f a ^ c := by
  have hx := Real.rpow_pos_of_pos hA c
  rw [← Real.log_le_log_iff hB (mul_pos (Real.exp_pos d) hx),
    Real.log_mul (Real.exp_pos d).ne' hx.ne', Real.log_exp, Real.log_rpow hA]
  unfold logPowerGap
  constructor <;> intro h <;> linarith only [h]

theorem log_power_gap_at_one (q : FiniteMass Bool) (w : Bool → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (f : Bool → ℝ) (hf : q.expect f = 1) (c : ℝ) :
    logPowerGap q w hw c 1 f = 0 := by
  unfold logPowerGap inputPower outputPower
  simp only [Real.rpow_one, FiniteMass.expect_conditional_mean, hf, Real.log_one,
    mul_zero, sub_zero]

theorem binary_gap_continuous (q : FiniteMass Bool) (hq : ∀ i, 0 < q i)
    (w : Bool → FiniteMass κ) (hw : ∀ i y, 0 < w i y) (c Q : ℝ) :
    ContinuousOn (fun x : ℝ × ℝ => logPowerGap q w hw c x.1 (binaryDensity q x.2))
      (Icc (1 : ℝ) Q ×ˢ Icc (0 : ℝ) 1) := by
  let S := Icc (1 : ℝ) Q ×ˢ Icc (0 : ℝ) 1
  have hF (i : Bool) : Continuous (fun x : ℝ × ℝ => binaryDensity q x.2 i) := by
    cases i
    · exact continuous_snd.div_const _
    · exact (continuous_const.sub continuous_snd).div_const _
  have hG (y : κ) :
      Continuous (fun x : ℝ × ℝ => q.conditionalMean w hw (binaryDensity q x.2) y) := by
    unfold FiniteMass.conditionalMean FiniteMass.expect
    exact continuous_finset_sum _ fun i _ => continuous_const.mul (hF i)
  have hPow (f : ℝ × ℝ → ℝ) (hf : Continuous f) :
      ContinuousOn (fun x : ℝ × ℝ => f x ^ x.1) S :=
    hf.continuousOn.rpow continuous_fst.continuousOn
      (fun x hx => Or.inr (zero_lt_one.trans_le hx.1.1))
  have hA : ContinuousOn (fun x : ℝ × ℝ => inputPower q (binaryDensity q x.2) x.1) S := by
    unfold inputPower FiniteMass.expect
    exact continuousOn_finset_sum _ fun i _ => continuousOn_const.mul (hPow _ (hF i))
  have hB : ContinuousOn (fun x : ℝ × ℝ =>
      outputPower q w hw (binaryDensity q x.2) x.1) S := by
    unfold outputPower FiniteMass.expect
    exact continuousOn_finset_sum _ fun y _ => continuousOn_const.mul (hPow _ (hG y))
  have hA' (x : ℝ × ℝ) (hx : x ∈ S) : 0 < inputPower q (binaryDensity q x.2) x.1 :=
    zero_lt_one.trans_le (input_power_ge_one q _ (binary_density_nonneg q hx.2)
      (binary_density_mean q hq x.2) hx.1.1)
  have hB' (x : ℝ × ℝ) (hx : x ∈ S) :
      0 < outputPower q w hw (binaryDensity q x.2) x.1 :=
    zero_lt_one.trans_le (output_power_ge_one q w hw _ (binary_density_nonneg q hx.2)
      (binary_density_mean q hq x.2) hx.1.1)
  exact (hB.log (fun x hx => (hB' x hx).ne')).sub
    (continuousOn_const.mul (hA.log (fun x hx => (hA' x hx).ne')))

theorem binary_endpoint_all_orders (q : FiniteMass Bool) (hq : ∀ i, 0 < q i)
    (w : Bool → FiniteMass κ) (hw : ∀ i y, 0 < w i y) (i : Bool) (c : ℝ)
    {a Q : ℝ} (ha : 1 ≤ a) (haQ : a ≤ Q) (hQ : 1 < Q)
    (h : outputPower q w hw (binaryDensity q (if i then 0 else 1)) Q ≤
      inputPower q (binaryDensity q (if i then 0 else 1)) Q ^ c) :
    logPowerGap q w hw c a (binaryDensity q (if i then 0 else 1)) ≤ 0 := by
  let z : ℝ := if i then 0 else 1
  let f := binaryDensity q z
  let t := (a - 1) / (Q - 1)
  have ht : 0 ≤ t := div_nonneg (sub_nonneg.mpr ha) (sub_pos.mpr hQ).le
  have hz : z ∈ Icc (0 : ℝ) 1 := by cases i <;> norm_num [z]
  have hf := binary_density_nonneg q hz
  have hfm := binary_density_mean q hq z
  have hA := input_power_ge_one q f hf hfm ha
  have hB := output_power_ge_one q w hw f hf hfm ha
  have hAQ := input_power_ge_one q f hf hfm hQ.le
  have hBQ := output_power_ge_one q w hw f hf hfm hQ.le
  have hAInterpolation : inputPower q f Q ^ t = inputPower q f a := by
    dsimp only [f, z]
    rw [binary_endpoint_power q hq i hQ.le, binary_endpoint_power q hq i ha,
      ← Real.rpow_mul (hq i).le]
    have he : (1 - Q) * t = 1 - a := by
      have hcancel : (Q - 1) * t = a - 1 := mul_div_cancel₀ _ (sub_pos.mpr hQ).ne'
      linarith only [hcancel, show (1 - Q) * t = -((Q - 1) * t) by ring]
    rw [he]
  have hBInterpolation : outputPower q w hw f a ≤ outputPower q w hw f Q ^ t :=
    (q.push w).expect_power_interpolation (q.conditionalMean w hw f)
      (conditional_mean_pos q hq w hw f hf hfm)
      ((q.expect_conditional_mean w hw f).trans hfm) ha haQ hQ
  apply (log_power_gap_le_iff q w hw f a c 0 (zero_lt_one.trans_le hA)
    (zero_lt_one.trans_le hB)).2
  rw [Real.exp_zero, one_mul, ← hAInterpolation]
  refine hBInterpolation.trans ((Real.rpow_le_rpow (zero_le_one.trans hBQ) h ht).trans_eq ?_)
  rw [← Real.rpow_mul (zero_le_one.trans hAQ), ← Real.rpow_mul (zero_le_one.trans hAQ),
    mul_comm c t]

theorem binary_positive_maximum (q : FiniteMass Bool) (hq : ∀ i, 0 < q i)
    (w : Bool → FiniteMass κ) (hw : ∀ i y, 0 < w i y) (c Q : ℝ) (hQ : 1 < Q)
    (hEnds : ∀ i : Bool, outputPower q w hw (binaryDensity q (if i then 0 else 1)) Q ≤
      inputPower q (binaryDensity q (if i then 0 else 1)) Q ^ c)
    (hBad : ∃ z ∈ Icc (0 : ℝ) 1, 0 < logPowerGap q w hw c Q (binaryDensity q z)) :
    ∃ r ∈ Ioc (1 : ℝ) Q, ∃ z ∈ Ioo (0 : ℝ) 1,
      0 < logPowerGap q w hw c r (binaryDensity q z) ∧
      ∀ (a : ℝ), a ∈ Icc (1 : ℝ) Q → ∀ (f : Bool → ℝ), (∀ i, 0 ≤ f i) →
        q.expect f = 1 →
          logPowerGap q w hw c a f ≤ logPowerGap q w hw c r (binaryDensity q z) ∧
          (a < r → logPowerGap q w hw c a f < logPowerGap q w hw c r (binaryDensity q z)) := by
  let S := Icc (1 : ℝ) Q ×ˢ Icc (0 : ℝ) 1
  let F (x : ℝ × ℝ) := logPowerGap q w hw c x.1 (binaryDensity q x.2)
  have hS : IsCompact S := isCompact_Icc.prod isCompact_Icc
  have hNE : S.Nonempty := ⟨(1, 0), ⟨⟨le_rfl, hQ.le⟩, ⟨le_rfl, zero_le_one⟩⟩⟩
  obtain ⟨⟨r, z⟩, hrz, hmax, hmin⟩ :=
    least_first_coordinate_maximizer hS hNE F (binary_gap_continuous q hq w hw c Q)
  have hr : r ∈ Icc (1 : ℝ) Q := hrz.1
  have hz : z ∈ Icc (0 : ℝ) 1 := hrz.2
  obtain ⟨zBad, hzBad, hpos⟩ := hBad
  have hM : 0 < F (r, z) := hpos.trans_le (hmax (Q, zBad) ⟨⟨hQ.le, le_rfl⟩, hzBad⟩)
  have hR : 1 < r := by
    refine lt_of_le_of_ne hr.1 (fun he => ?_)
    have hzero := log_power_gap_at_one q w hw (binaryDensity q z)
      (binary_density_mean q hq z) c
    have h : F (r, z) = 0 := by simpa only [F, ← he] using hzero
    exact hM.ne' h
  have hZ₀ : 0 < z := by
    refine lt_of_le_of_ne hz.1 (fun he => ?_)
    have h := binary_endpoint_all_orders q hq w hw true c hr.1 hr.2 hQ (hEnds true)
    exact (not_le_of_gt hM) (by simpa only [F, ← he, if_true] using h)
  have hZ₁ : z < 1 := by
    refine lt_of_le_of_ne hz.2 (fun he => ?_)
    have h := binary_endpoint_all_orders q hq w hw false c hr.1 hr.2 hQ (hEnds false)
    exact (not_le_of_gt hM) (by simpa only [F, he, Bool.false_eq_true, if_false] using h)
  refine ⟨r, ⟨hR, hr.2⟩, z, ⟨hZ₀, hZ₁⟩, hM, ?_⟩
  intro a ha f hf hfmean
  obtain ⟨z', hz', rfl⟩ := every_binary_density q hq f hf hfmean
  have hmem : (a, z') ∈ S := ⟨ha, hz'⟩
  have hle := hmax (a, z') hmem
  refine ⟨hle, fun hlt => lt_of_le_of_ne hle (fun he => ?_)⟩
  exact (not_le_of_gt hlt) (hmin (a, z') hmem he)

end RenyiProductOrderPhase
