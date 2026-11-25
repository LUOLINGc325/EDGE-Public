import BinaryVariation

/-! Power comparisons at the least maximizer and the order-at-least-two case. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem log_power_gap_lt_iff (q : FiniteMass Bool) (w : Bool → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (f : Bool → ℝ) (a c d : ℝ)
    (hA : 0 < inputPower q f a) (hB : 0 < outputPower q w hw f a) :
    logPowerGap q w hw c a f < d ↔
      outputPower q w hw f a < Real.exp d * inputPower q f a ^ c := by
  have hx := Real.rpow_pos_of_pos hA c
  rw [← Real.log_lt_log_iff hB (mul_pos (Real.exp_pos d) hx),
    Real.log_mul (Real.exp_pos d).ne' hx.ne', Real.log_exp, Real.log_rpow hA]
  unfold logPowerGap
  constructor <;> intro h <;> linarith only [h]

theorem output_power_eq_exp_gap (q : FiniteMass Bool) (w : Bool → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (f : Bool → ℝ) (a c : ℝ)
    (hA : 0 < inputPower q f a) (hB : 0 < outputPower q w hw f a) :
    outputPower q w hw f a = Real.exp (logPowerGap q w hw c a f) * inputPower q f a ^ c := by
  unfold logPowerGap
  rw [Real.exp_sub, Real.exp_log hB, Real.rpow_def_of_pos hA,
    mul_comm (Real.log (inputPower q f a)) c,
    div_mul_cancel₀ _ (Real.exp_pos _).ne']

theorem higher_order_maximum_impossible (q : FiniteMass Bool) (hq : ∀ i, 0 < q i)
    (w : Bool → FiniteMass κ) (hw : ∀ i y, 0 < w i y) (c r : ℝ)
    (hc : c ∈ Icc (0 : ℝ) 1) (hr : 2 ≤ r)
    (f : Bool → ℝ) (hf : ∀ i, 0 < f i) (hfm : q.expect f = 1)
    (hmax : ∀ g : Bool → ℝ, (∀ i, 0 ≤ g i) → q.expect g = 1 →
      logPowerGap q w hw c r g ≤ logPowerGap q w hw c r f)
    (hLower : logPowerGap q w hw c (r - 1) f < logPowerGap q w hw c r f) : False := by
  have hR : 1 ≤ r := by linarith
  have hLow : 1 ≤ r - 1 := by linarith
  have hA (a : ℝ) (ha : 1 ≤ a) : 0 < inputPower q f a :=
    zero_lt_one.trans_le (input_power_ge_one q f (fun i => (hf i).le) hfm ha)
  have hB (a : ℝ) (ha : 1 ≤ a) : 0 < outputPower q w hw f a :=
    zero_lt_one.trans_le (output_power_ge_one q w hw f (fun i => (hf i).le) hfm ha)
  let M := logPowerGap q w hw c r f
  let X := inputPower q f (r - 1) / inputPower q f r
  have hX : 0 < X := div_pos (hA _ hLow) (hA _ hR)
  have hSmall := (log_power_gap_lt_iff q w hw f (r - 1) c M (hA _ hLow) (hB _ hLow)).mp hLower
  have hEq := output_power_eq_exp_gap q w hw f r c (hA _ hR) (hB _ hR)
  have hRatio : outputPower q w hw f (r - 1) / outputPower q w hw f r < X ^ c := by
    calc
      _ < (Real.exp M * inputPower q f (r - 1) ^ c) / outputPower q w hw f r :=
        (div_lt_div_iff_of_pos_right (hB _ hR)).2 hSmall
      _ = _ := by
        change (Real.exp (logPowerGap q w hw c r f) * inputPower q f (r - 1) ^ c) /
          outputPower q w hw f r = X ^ c
        unfold X
        rw [hEq, mul_div_mul_left _ _ (Real.exp_pos _).ne',
          Real.div_rpow (hA _ hLow).le (hA _ hR).le]
  have hAM : X ^ c ≤ (1 - c) + c * X := by
    simpa only [Real.one_rpow, one_mul, mul_one] using
      (Real.geom_mean_le_arith_mean2_weighted (sub_nonneg.mpr hc.2) hc.1
        (zero_le_one : (0 : ℝ) ≤ 1) hX.le (by ring))
  have hT (y : κ) : q.conditionalMean w hw (fun _ => 1) y = 1 :=
    (q.posterior w hw y).expect_const 1
  have hDeriv := binary_stationarity q hq w hw c r hR f hf hfm hmax (fun _ => 1)
  simp only [hT, one_mul, FiniteMass.expect_const, mul_one] at hDeriv
  change outputPower q w hw f (r - 1) / outputPower q w hw f r =
    (1 - c) + c * X at hDeriv
  exact (not_lt_of_ge hDeriv.ge) (hRatio.trans_le hAM)

end RenyiProductOrderPhase
