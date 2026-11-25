import NormalizedFixedFactor

open Filter
open scoped Topology

namespace TwoColorNullity

noncomputable def denominatorCorrection (n : ℕ) : ℝ :=
  (2 * binaryLog (binaryLog n) + 1) / binaryLog n

theorem denominatorCorrection_zero :
    Tendsto denominatorCorrection atTop (𝓝 0) := by
  have hlog : Tendsto (fun x : ℝ => binaryLog x / x) atTop (𝓝 0) := by
    simpa only [binaryLog, zero_div, Function.comp_apply, id_eq, div_div, mul_comm] using
      Real.isLittleO_log_id_atTop.tendsto_div_nhds_zero.div_const (Real.log 2)
  have hone := tendsto_inv_atTop_zero.comp binaryLog_atTop
  have h := ((hlog.comp binaryLog_atTop).const_mul (2 : ℝ)).add hone
  change Tendsto (fun n : ℕ => (2 * binaryLog (binaryLog n) + 1) / binaryLog n) atTop (𝓝 0)
  simpa only [Function.comp_apply, mul_zero, zero_add, add_div, mul_div_assoc, one_div] using h

noncomputable def allCountsUpperEnvelope (n : ℕ) : ℝ :=
  max (2 * (binaryLog n / n))
    (max (binaryLog n)⁻¹ ((1 - denominatorCorrection n)⁻¹ + binaryLog n / n))

theorem allCountsUpperEnvelope_limit : Tendsto allCountsUpperEnvelope atTop (𝓝 1) := by
  have h0 := binaryLog_over_n_zero.const_mul (2 : ℝ)
  have h1 := tendsto_inv_atTop_zero.comp binaryLog_atTop
  have hden := (tendsto_const_nhds (x := (1 : ℝ))).sub denominatorCorrection_zero
  rw [sub_zero] at hden
  have h2 := (hden.inv₀ one_ne_zero).add binaryLog_over_n_zero
  simpa [allCountsUpperEnvelope, Function.comp_apply] using h0.max (h1.max h2)

private theorem all_counts_constructive_bound (n : ℕ) (hn : 2 ≤ n)
    (logLarge : 1 ≤ binaryLog n) (corrSmall : denominatorCorrection n < 1) (m : ℕ) :
    normalizedFactor n (constructiveFactor n m) ≤ allCountsUpperEnvelope n := by
  let logSize := binaryLog n
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have logpos : 0 < logSize := by dsimp [logSize]; linarith
  have hscale : 0 ≤ binaryLog n / (n : ℝ) := div_nonneg logpos.le hnR.le
  have hden : 0 < 1 - denominatorCorrection n := sub_pos.mpr corrSmall
  unfold constructiveFactor
  split
  · simp only [normalizedFactor, Nat.cast_one, one_mul]
    exact (show binaryLog n / (n : ℝ) ≤ 2 * (binaryLog n / (n : ℝ)) by linarith).trans (le_max_left _ _)
  · rename_i hsmall
    split
    · simp only [normalizedFactor, Nat.cast_ofNat]
      exact le_max_left _ _
    · rename_i hlarge
      let d := m - 2 * n
      let k := (d + 1).log2
      change normalizedFactor n ((d ⌈/⌉ k : ℕ) : ℝ) ≤ allCountsUpperEnvelope n
      have hd : 0 < d := by dsimp [d]; omega
      have hdn : (d : ℝ) ≤ n := by exact_mod_cast (show d ≤ n by dsimp [d]; omega)
      have hk : 0 < k := (Nat.le_log2 (by omega)).mpr (by omega)
      have hceil := ceilDiv_real_bounds d k hk
      by_cases hs : (d : ℝ) ≤ (n : ℝ) / logSize ^ 2
      · have hcd : d ⌈/⌉ k ≤ d := by
          apply (ceilDiv_le_iff_le_mul hk).mpr
          simpa only [one_mul] using Nat.mul_le_mul_right d (show 1 ≤ k by omega)
        have hcdR : ((d ⌈/⌉ k : ℕ) : ℝ) ≤ d := by exact_mod_cast hcd
        have hb := mul_le_mul_of_nonneg_right (hcdR.trans hs) hscale
        have heq : ((n : ℝ) / logSize ^ 2) * (binaryLog n / (n : ℝ)) = logSize⁻¹ := by
          change ((n : ℝ) / logSize ^ 2) * (logSize / (n : ℝ)) = logSize⁻¹
          field_simp [hnR.ne', logpos.ne']
        rw [heq] at hb
        exact hb.trans ((le_max_left _ _).trans (le_max_right _ _))
      · let denominator := logSize - 2 * binaryLog logSize - 1
        have hdz : denominator / logSize = 1 - denominatorCorrection n := by
          change (logSize - 2 * binaryLog logSize - 1) / logSize =
            1 - (2 * binaryLog logSize + 1) / logSize
          field_simp [logpos.ne']
          ring
        have hz : 0 < denominator / logSize := by rwa [hdz]
        have hdenpos : 0 < denominator :=
          ((div_pos_iff.mp hz).resolve_right fun h => (not_lt_of_ge logpos.le) h.2).1
        have hbig : (n : ℝ) / logSize ^ 2 ≤ ((d + 1 : ℕ) : ℝ) := by
          have hdp : (d : ℝ) ≤ ((d + 1 : ℕ) : ℝ) := by exact_mod_cast Nat.le_succ d
          exact (le_of_lt (lt_of_not_ge hs)).trans hdp
        have hlog := Real.log_le_log (div_pos hnR (by positivity)) hbig
        rw [Real.log_div hnR.ne' (pow_ne_zero _ logpos.ne'), Real.log_pow] at hlog
        have hlogs : binaryLog n - 2 * binaryLog logSize ≤ binaryLog ((d + 1 : ℕ) : ℝ) := by
          change Real.log (n : ℝ) / Real.log 2 - 2 * (Real.log logSize / Real.log 2) ≤
            Real.log ((d + 1 : ℕ) : ℝ) / Real.log 2
          rw [← mul_div_assoc, ← sub_div]
          exact div_le_div_of_nonneg_right (by simpa only [Nat.cast_ofNat] using hlog) log_two_pos.le
        have hfloor := (binaryLog_floor_bounds (d + 1) (by omega)).2
        have hdenLe : denominator ≤ (k : ℝ) := by
          change logSize - 2 * binaryLog logSize - 1 ≤ (k : ℝ)
          change logSize - 2 * binaryLog logSize ≤ _ at hlogs
          change _ < (k : ℝ) + 1 at hfloor
          linarith
        have hbound : ((d ⌈/⌉ k : ℕ) : ℝ) ≤ (n : ℝ) / denominator + 1 :=
          hceil.2.trans (add_le_add_right (div_le_div₀ (Nat.cast_nonneg _) hdn hdenpos hdenLe) 1)
        have hnorm := mul_le_mul_of_nonneg_right hbound hscale
        have hratio : logSize / denominator = (1 - denominatorCorrection n)⁻¹ := by
          rw [← hdz, inv_div]
        have heq : ((n : ℝ) / denominator + 1) * (binaryLog n / (n : ℝ)) =
            (1 - denominatorCorrection n)⁻¹ + binaryLog n / (n : ℝ) := by
          rw [← hratio]
          change ((n : ℝ) / denominator + 1) * (logSize / (n : ℝ)) =
            logSize / denominator + logSize / (n : ℝ)
          field_simp [hnR.ne', hdenpos.ne']
        rw [heq] at hnorm
        exact hnorm.trans ((le_max_right _ _).trans (le_max_right _ _))

theorem all_counts_worst_factor_limit :
    Tendsto (fun n : ℕ => normalizedFactor n (allCountsWorst n)) atTop (𝓝 1) := by
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' fixed_worst_factor_limit allCountsUpperEnvelope_limit
  · filter_upwards [eventually_ge_atTop (2 : ℕ), tendsto_atTop.1 binaryLog_atTop 1] with n hn hlo
    have h : 0 ≤ binaryLog n := by linarith
    exact mul_le_mul_of_nonneg_right (fixedItemWorst_le_allCounts n hn) (by positivity)
  · filter_upwards [eventually_ge_atTop (2 : ℕ), tendsto_atTop.1 binaryLog_atTop 1,
      denominatorCorrection_zero.eventually (gt_mem_nhds zero_lt_one)] with n hn hlo hcorr
    have hlog : 0 < binaryLog n := by linarith
    have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
    have hscale : 0 < binaryLog n / (n : ℝ) := div_pos hlog hnR
    apply (le_div_iff₀ hscale).mp
    apply upper_of_all_constructive n hn
    intro m
    exact (le_div_iff₀ hscale).mpr (all_counts_constructive_bound n hn hlo hcorr m)

theorem random_optimum_converges_in_probability (ε : ℝ) (hε : 0 < ε) :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
        ε ≤ |normalizedFactor n (optimalFactor (profileTag bits)) - 1|)) atTop (𝓝 0) := by
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity)
    ?_ bad_owner_sets_probability_vanishes
  filter_upwards [eventually_ge_atTop (2 : ℕ), tendsto_atTop.1 binaryLog_atTop 2,
    fixedLowerEnvelope_limit.eventually (lt_mem_nhds (show 1 - ε < 1 by linarith)),
    fixedUpperEnvelope_limit.eventually (gt_mem_nhds (show 1 < 1 + ε by linarith))] with n hn hlog hlo hhi
  have hlog0 : 0 ≤ binaryLog n := by linarith
  have hscale : 0 ≤ binaryLog n / (n : ℝ) := by positivity
  apply finiteProbability_mono
  intro bits hbad
  by_contra! hgood
  have hcut : 0 < largeSetThreshold n - 1 := by unfold largeSetThreshold; omega
  have hlower := (fixedLowerEnvelope_le n hn).trans
    (mul_le_mul_of_nonneg_right (good_profile_lower n hn _ hcut bits (by omega)) hscale)
  have hupper := (mul_le_mul_of_nonneg_right
    ((optimalFactor_le_fixedItemWorst n hn bits).trans (fixedItemWorst_upper n hn)) hscale).trans
      (normalizedFactor_le_fixedUpperEnvelope n hn (by linarith))
  unfold normalizedFactor at hbad
  have hnear : |optimalFactor (profileTag bits) * (binaryLog n / (n : ℝ)) - 1| < ε :=
    abs_lt.mpr ⟨by linarith, by linarith⟩
  exact (not_lt_of_ge hbad) hnear

theorem no_fixed_factor (factor : ℝ) :
    ∃ n ≥ 2, ∃ bits : BitProfile n (3 * n - 1), factor < optimalFactor (profileTag bits) := by
  have hc := binaryLog_over_n_zero.const_mul factor
  rw [mul_zero] at hc
  have h := (eventually_ge_atTop (2 : ℕ)).and (fixed_worst_factor_limit.eventually
    (lt_mem_nhds (show (1 / 2 : ℝ) < 1 by norm_num)))
  obtain ⟨n, ⟨hn, hw⟩, hf, hl⟩ :=
    (h.and ((hc.eventually (gt_mem_nhds (show (0 : ℝ) < 1 / 2 by norm_num))).and
      (tendsto_atTop.1 binaryLog_atTop 1))).exists
  obtain ⟨bits, heq⟩ := fixedItemWorst_attained n
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hscale : 0 < binaryLog n / (n : ℝ) := div_pos (by linarith) hnR
  refine ⟨n, hn, bits, ?_⟩
  apply lt_of_mul_lt_mul_right _ hscale.le
  rw [heq]
  exact hf.trans hw

end TwoColorNullity
