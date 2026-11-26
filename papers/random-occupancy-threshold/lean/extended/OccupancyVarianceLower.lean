import BinVarianceApproximation
import OneSidedMomentBound

namespace TwoColorNullity.Occupancy

private theorem varianceCurve_hasDerivAt (x : ℝ) :
    HasDerivAt varianceCurve (16 * x * Real.exp (-(4 * x))) x := by
  have hm : HasDerivAt (fun y : ℝ => 4 * y) 4 x := by
    simpa only [id_eq, mul_one] using (hasDerivAt_id x).const_mul (4 : ℝ)
  have h := (hasDerivAt_const x (1 : ℝ)).sub
    (((hasDerivAt_const x (1 : ℝ)).add hm).mul hm.neg.exp)
  convert h using 1
  simp only [Pi.add_apply, Pi.neg_apply, zero_add, zero_sub]
  ring

theorem varianceCurve_monotone : MonotoneOn varianceCurve (Set.Ioi 0) := by
  apply (strictMonoOn_of_deriv_pos (convex_Ioi 0) ?_ ?_).monotoneOn
  · intro x _
    exact (varianceCurve_hasDerivAt x).continuousAt.continuousWithinAt
  · intro x hx
    rw [interior_Ioi] at hx
    rw [(varianceCurve_hasDerivAt x).deriv]
    exact mul_pos (mul_pos (by norm_num) hx) (Real.exp_pos _)

theorem oddBinVariance_lower (m k : ℕ) (hm : 0 < m) (hk : 8 ≤ k)
    (lower upper : ℝ) (hlower : 0 < lower) (h₁ : lower ≤ (m : ℝ) / (k : ℝ))
    (h₂ : (m : ℝ) / (k : ℝ) ≤ upper)
    (hlarge : 32 * upper / varianceCurve lower ≤ (k : ℝ)) :
    varianceCurve lower * (k : ℝ) / 8 ≤ oddBinVariance (Fin m) (Fin k) := by
  letI : NeZero k := ⟨by omega⟩
  have hpositive := varianceCurve_pos hlower
  have hkR : (0 : ℝ) < k := by exact_mod_cast (show 0 < k by omega)
  have hlt : 0 < (m : ℝ) / (k : ℝ) := lt_of_lt_of_le hlower h₁
  have hmon := varianceCurve_monotone hlower hlt h₁
  have h := (oddBinVariance_approximation m k hm hk).1
  have herr : 16 * ((m : ℝ) / (k : ℝ)) / (k : ℝ) ≤ varianceCurve lower / 2 := by
    have hs := (div_le_iff₀ hpositive).mp hlarge
    apply (div_le_iff₀ hkR).mpr
    nlinarith only [h₂, hs]
  have hhalf : varianceCurve lower / 2 ≤ 4 * oddBinVariance (Fin m) (Fin k) / (k : ℝ) := by
    linarith only [h, hmon, herr]
  have hscaled := (le_div_iff₀ hkR).mp hhalf
  linarith only [hscaled]

noncomputable def varianceCoefficient (a b : ℝ) : ℝ := varianceCurve (2 / b) * a / 8

noncomputable def fourthCoefficient : ℝ := 432 * Real.exp (1 / 2)

theorem varianceCoefficient_pos {a b : ℝ} (ha : 0 < a) (hb : 0 < b) :
    0 < varianceCoefficient a b := by
  unfold varianceCoefficient
  exact div_pos (mul_pos (varianceCurve_pos (div_pos (by norm_num) hb)) ha) (by norm_num)

theorem fourthCoefficient_pos : 0 < fourthCoefficient := by unfold fourthCoefficient; positivity

theorem n_scaled_odd_variance_lower (n k : ℕ) (hn : 1 ≤ n) (hk : 8 ≤ k) (a b : ℝ)
    (ha : 0 < a) (hb : 0 < b)
    (hlo : a * (n : ℝ) ≤ k) (hhi : (k : ℝ) ≤ b * (n : ℝ))
    (hlarge : 32 * (3 / a) / varianceCurve (2 / b) ≤ (k : ℝ)) :
    varianceCoefficient a b * (n : ℝ) ≤ oddBinVariance (Fin (3 * n - 1)) (Fin k) := by
  let m := 3 * n - 1
  have hm : 0 < m := by dsimp [m]; omega
  have hnR : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hkR : (0 : ℝ) < k := by exact_mod_cast (show 0 < k by omega)
  have hmlo : 2 * (n : ℝ) ≤ m := by exact_mod_cast (show 2 * n ≤ m by dsimp [m]; omega)
  have hmhi : (m : ℝ) ≤ 3 * (n : ℝ) := by exact_mod_cast (show m ≤ 3 * n by dsimp [m]; omega)
  have hlow : 2 / b ≤ (m : ℝ) / (k : ℝ) := by
    apply (div_le_div_iff₀ hb hkR).mpr
    have h1 := mul_le_mul_of_nonneg_left hhi (show (0 : ℝ) ≤ 2 by norm_num)
    have h2 := mul_le_mul_of_nonneg_right hmlo hb.le
    nlinarith only [h1, h2]
  have hupper : (m : ℝ) / (k : ℝ) ≤ 3 / a := by
    apply (div_le_div_iff₀ hkR ha).mpr
    have h1 := mul_le_mul_of_nonneg_right hmhi ha.le
    have h2 := mul_le_mul_of_nonneg_left hlo (show (0 : ℝ) ≤ 3 by norm_num)
    nlinarith only [h1, h2]
  have var := oddBinVariance_lower m k hm hk (2 / b) (3 / a) (div_pos (by norm_num) hb) hlow hupper hlarge
  have hfactor : 0 ≤ varianceCurve (2 / b) := (varianceCurve_pos (div_pos (by norm_num) hb)).le
  have hs := mul_le_mul_of_nonneg_left hlo hfactor
  unfold varianceCoefficient
  linarith only [var, hs]

/-- Uniform positive probability of a downward fluctuation on a compact ratio range. -/
theorem oddBinCount_small_deviation (n k : ℕ) (hn : 1 ≤ n) (hk : 8 ≤ k) (a b : ℝ)
    (ha : 0 < a) (hb : 0 < b) (hlo : a * (n : ℝ) ≤ k) (hhi : (k : ℝ) ≤ b * (n : ℝ))
    (hlarge : 32 * (3 / a) / varianceCurve (2 / b) ≤ (k : ℝ)) :
    let m := 3 * n - 1
    let f (draws : Fin m → Fin k) := (oddBinCount draws : ℝ)
    leftTailMass (varianceCoefficient a b) fourthCoefficient ≤
      finiteProbability (fun draws => f draws ≤ finiteMean f -
        leftTailShift (varianceCoefficient a b) fourthCoefficient * Real.sqrt (n : ℝ)) := by
  dsimp only
  let m := 3 * n - 1
  letI : NeZero k := ⟨by omega⟩
  let f (draws : Fin m → Fin k) := (oddBinCount draws : ℝ)
  let centered (draws : Fin m → Fin k) := f draws - finiteMean f
  have hz : finiteMean centered = 0 := by simp [centered, finiteMean_sub, finiteMean_const]
  have hm : 0 < m := by dsimp [m]; omega
  have hscale : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have htwo : varianceCoefficient a b * (n : ℝ) ≤ finiteMean (fun draws => centered draws ^ 2) :=
    n_scaled_odd_variance_lower n k hn hk a b ha hb hlo hhi hlarge
  have hfour : finiteMean (fun draws => centered draws ^ 4) ≤ fourthCoefficient * (n : ℝ) ^ 2 := by
    have h₄ := finiteMean_boundedDifferences_fourthMoment m hm f oddBinCount_bounded_difference
    have hmul : (m : ℝ) ≤ 3 * (n : ℝ) := by exact_mod_cast (show m ≤ 3 * n by dsimp [m]; omega)
    have hpow := pow_le_pow_left₀ (Nat.cast_nonneg m) hmul 2
    have hfinal := mul_le_mul_of_nonneg_left hpow (show 0 ≤ 48 * Real.exp (1 / 2) by positivity)
    refine h₄.trans (hfinal.trans_eq ?_)
    unfold fourthCoefficient
    ring
  have hprob := finiteProbability_leftTail_scaled centered hz (varianceCoefficient a b) fourthCoefficient
    (n : ℝ) (varianceCoefficient_pos ha hb) fourthCoefficient_pos.le hscale htwo hfour
  exact hprob.trans (finiteProbability_mono fun draws h => by dsimp [centered] at h; linarith)

end TwoColorNullity.Occupancy
