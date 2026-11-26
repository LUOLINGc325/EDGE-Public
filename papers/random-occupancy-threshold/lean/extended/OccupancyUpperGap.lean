import CriticalGapEstimates
import OwnerOccupancyLaw

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

noncomputable def deviationCoefficient : ℝ := 12 * (1 + 1 / Real.log 2)

theorem deviationCoefficient_pos : 0 < deviationCoefficient := by
  unfold deviationCoefficient
  have := log_two_pos
  positivity

noncomputable def thresholdWindowConstant : ℝ :=
  2 * deviationCoefficient / (criticalSlope * criticalRatio * Real.log 2)

theorem thresholdWindowConstant_pos : 0 < thresholdWindowConstant :=
  div_pos (mul_pos (by norm_num) deviationCoefficient_pos)
    (mul_pos (mul_pos criticalSlope_pos criticalRatio_pos) log_two_pos)

noncomputable def windowUpper (n : ℕ) : ℕ :=
  ⌊transitionLog n + boundaryWidth thresholdWindowConstant n⌋₊

noncomputable def concentrationScale (n : ℕ) : ℝ :=
  deviationCoefficient * Real.sqrt (n : ℝ) * Real.log (n : ℝ)

theorem count_correction_eventually_below_scale :
    ∀ᶠ n : ℕ in atTop,
      1 ≤ Real.log (n : ℝ) ∧ 2 * (binaryLog n + 6) + 13 ≤ concentrationScale n := by
  let c := (2 / Real.log 2 + 25) / deviationCoefficient
  have hc : 0 ≤ c := by
    unfold c
    have h₁ := log_two_pos
    have h₂ := deviationCoefficient_pos
    positivity
  have hcast : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop := tendsto_natCast_atTop_atTop
  have hlog := Real.tendsto_log_atTop.comp hcast
  filter_upwards [tendsto_atTop.1 hcast (c ^ 2), tendsto_atTop.1 hlog 1] with n hn hln
  change 1 ≤ Real.log (n : ℝ) at hln
  refine ⟨hln, ?_⟩
  have hs := (Real.le_sqrt hc (Nat.cast_nonneg n)).mpr hn
  have hsum : 2 / Real.log 2 + 25 ≤ deviationCoefficient * Real.sqrt (n : ℝ) := by
    unfold c at hs
    have h := (div_le_iff₀ deviationCoefficient_pos).mp hs
    rwa [mul_comm] at h
  have hmult := mul_le_mul_of_nonneg_right hsum (show 0 ≤ Real.log (n : ℝ) by linarith)
  have he : (2 / Real.log 2 + 25) * Real.log (n : ℝ) =
      2 * binaryLog n + 25 * Real.log (n : ℝ) := by unfold binaryLog; ring
  rw [he] at hmult
  unfold concentrationScale
  linarith only [hln, hmult]

theorem upper_mean_gap (n s : ℕ) (hn : 4 ≤ n) (hln : 1 ≤ Real.log (n : ℝ))
    (hcount : 2 * (binaryLog n + 6) + 13 ≤ concentrationScale n)
    (hnear : s < largeSetThreshold n) (hfar : windowUpper n < s) :
    ((n + 2 * s - 1 : ℕ) : ℝ) + concentrationScale n ≤
      finiteMean (fun draws : Fin (3 * n - 1) → Fin (2 ^ s) => (oddBinCount draws : ℝ)) := by
  let ratio := (2 : ℝ) ^ s / (n : ℝ)
  let width := boundaryWidth thresholdWindowConstant n
  let k := 2 ^ s
  have hnR : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hroot : 0 < Real.sqrt (n : ℝ) := Real.sqrt_pos.mpr hnR
  have hwidth : 0 ≤ width := by
    unfold width boundaryWidth
    exact mul_nonneg thresholdWindowConstant_pos.le (div_nonneg (by linarith) hroot.le)
  have hall : width ≤ (s : ℝ) - transitionLog n := by
    have hf := Nat.lt_floor_add_one (transitionLog n + width)
    have hi : (windowUpper n : ℝ) + 1 ≤ (s : ℝ) := by
      exact_mod_cast (show windowUpper n + 1 ≤ s by omega)
    change transitionLog n + width < (windowUpper n : ℝ) + 1 at hf
    linarith
  have hexp : 1 + Real.log 2 * width ≤ Real.exp (Real.log 2 * ((s : ℝ) - transitionLog n)) := by
    have h := Real.add_one_le_exp (Real.log 2 * ((s : ℝ) - transitionLog n))
    have hi := mul_le_mul_of_nonneg_left hall log_two_pos.le
    linarith
  have hr := mul_le_mul_of_nonneg_left hexp criticalRatio_pos.le
  rw [← bins_ratio_from_logGap n s (by omega)] at hr
  change criticalRatio * (1 + Real.log 2 * width) ≤ ratio at hr
  have hdifference : criticalRatio * (Real.log 2 * width) ≤ ratio - criticalRatio := by nlinarith only [hr]
  have hpositive : 0 ≤ criticalRatio * (Real.log 2 * width) :=
    mul_nonneg criticalRatio_pos.le (mul_nonneg log_two_pos.le hwidth)
  have hlo : criticalRatio ≤ ratio := by linarith only [hdifference, hpositive]
  have hhi : ratio ≤ 64 := bins_ratio_le_sixty_four_of_before_cutoff n s (by omega) hnear
  have hkn : (n : ℝ) ≤ (k : ℝ) := by
    have h := (le_div_iff₀ hnR).mp (show (1 : ℝ) ≤ ratio by linarith [hlo, criticalRatio_mem_Ioo.1])
    simpa only [one_mul, k, Nat.cast_pow, Nat.cast_ofNat] using h
  have hk : 4 ≤ k := hn.trans (by exact_mod_cast hkn)
  have hc := occupancyCurve_gap_lower ratio hlo hhi
  have hproduct := mul_le_mul_of_nonneg_left hdifference
    (mul_nonneg hnR.le criticalSlope_pos.le)
  have hcoeff : criticalSlope * criticalRatio * Real.log 2 * thresholdWindowConstant = 2 * deviationCoefficient := by
    unfold thresholdWindowConstant
    field_simp [criticalSlope_pos.ne', criticalRatio_pos.ne', log_two_pos.ne']
  have hsqrtDiv : (n : ℝ) / Real.sqrt (n : ℝ) = Real.sqrt (n : ℝ) := by
    apply (div_eq_iff hroot.ne').mpr
    simpa only [pow_two] using (Real.sq_sqrt hnR.le).symm
  have hscale : (n : ℝ) * criticalSlope * (criticalRatio * (Real.log 2 * width)) =
      2 * concentrationScale n := by
    unfold width boundaryWidth concentrationScale
    calc
      _ = (criticalSlope * criticalRatio * Real.log 2 * thresholdWindowConstant) *
          ((n : ℝ) / Real.sqrt (n : ℝ)) * Real.log (n : ℝ) := by ring
      _ = _ := by rw [hcoeff, hsqrtDiv]; ring
  rw [hscale] at hproduct
  have hcurve := mul_le_mul_of_nonneg_left hc hnR.le
  have happrox := (abs_le.mp (expectedOddCount_approximation n k (by omega) hk)).1
  have heqRatio : (k : ℝ) / (n : ℝ) = ratio := by simp [k, ratio]
  rw [heqRatio] at happrox
  have hm : (((3 * n - 1 : ℕ) : ℝ)) ≤ 3 * (k : ℝ) := by
    have hx : ((3 * n - 1 : ℕ) : ℝ) ≤ 3 * (n : ℝ) := by exact_mod_cast Nat.sub_le (3 * n) 1
    linarith [mul_le_mul_of_nonneg_left hkn (show (0 : ℝ) ≤ 3 by norm_num)]
  have hkR : 0 < (k : ℝ) := hnR.trans_le hkn
  have herr : 4 * ((3 * n - 1 : ℕ) : ℝ) / (k : ℝ) + 1 ≤ 13 := by
    have hb : 4 * ((3 * n - 1 : ℕ) : ℝ) / (k : ℝ) ≤ 12 :=
      (div_le_iff₀ hkR).mpr (by linarith only [hm])
    linarith
  have hss : (s : ℝ) + 1 ≤ (largeSetThreshold n : ℝ) := by
    exact_mod_cast (show s + 1 ≤ largeSetThreshold n by omega)
  have hdegree : (s : ℝ) ≤ binaryLog n + 6 := by
    linarith only [hss, threshold_le_binaryLog_add n (by omega)]
  have hthreshold : ((n + 2 * s - 1 : ℕ) : ℝ) ≤ (n : ℝ) + 2 * (s : ℝ) := by
    exact_mod_cast Nat.sub_le (n + 2 * s) 1
  change _ ≤ finiteMean (fun draws : Fin (3 * n - 1) → Fin k => (oddBinCount draws : ℝ))
  nlinarith only [hcurve, hproduct, happrox, herr, hdegree, hthreshold, hcount]

theorem far_owner_feasibility_tail (n : ℕ) (owners : Finset (Fin n)) (hn : 4 ≤ n)
    (hln : 1 ≤ Real.log (n : ℝ)) (hcount : 2 * (binaryLog n + 6) + 13 ≤ concentrationScale n)
    (hsize : owners.card < n) (hnear : owners.card < largeSetThreshold n)
    (hfar : windowUpper n < owners.card) :
    finiteProbability (fun bits : BitProfile n (3 * n - 1) => FeasibleOwners (profileTag bits) owners) ≤
      Real.exp (-(deviationCoefficient ^ 2 / 6 * (Real.log (n : ℝ)) ^ 2)) := by
  have hscale : 0 ≤ concentrationScale n := by
    unfold concentrationScale
    have h₁ := deviationCoefficient_pos
    have h₂ : 0 ≤ Real.log (n : ℝ) := by linarith
    positivity
  have ht := owner_feasibility_tail n owners (by omega) hsize (concentrationScale n) hscale
    (upper_mean_gap n owners.card hn hln hcount hnear hfar)
  refine ht.trans (Real.exp_le_exp.mpr ?_)
  have hm : (((3 * n - 1 : ℕ) : ℝ)) ≤ 3 * (n : ℝ) := by exact_mod_cast Nat.sub_le (3 * n) 1
  have hm0 : 0 < ((3 * n - 1 : ℕ) : ℝ) := by exact_mod_cast (show 0 < 3 * n - 1 by omega)
  have hsquare : concentrationScale n ^ 2 =
      deviationCoefficient ^ 2 * (Real.log (n : ℝ)) ^ 2 * (n : ℝ) := by
    unfold concentrationScale
    rw [mul_pow, mul_pow, Real.sq_sqrt (Nat.cast_nonneg n)]
    ring
  rw [neg_div]
  apply neg_le_neg
  apply (le_div_iff₀ (mul_pos (by norm_num : (0 : ℝ) < 2) hm0)).mpr
  rw [hsquare]
  have hbase : 0 ≤ deviationCoefficient ^ 2 * (Real.log (n : ℝ)) ^ 2 := by positivity
  have hmul := mul_le_mul_of_nonneg_left hm hbase
  nlinarith only [hmul]

end TwoColorNullity.Occupancy
