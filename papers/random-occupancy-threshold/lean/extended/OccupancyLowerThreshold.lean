import LatticeScale
import FeasibilityIndependentBlocks
import OccupancyVarianceLower

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

noncomputable def thresholdDescent : ℝ := leftTailShift (varianceCoefficient 1 3) fourthCoefficient

noncomputable def thresholdDescentMass : ℝ := min (1 / 2) (leftTailMass (varianceCoefficient 1 3) fourthCoefficient)

theorem thresholdDescent_pos : 0 < thresholdDescent :=
  leftTailShift_pos (varianceCoefficient_pos (by norm_num) (by norm_num)) fourthCoefficient_pos.le

theorem thresholdDescentMass_bounds : 0 < thresholdDescentMass ∧ thresholdDescentMass ≤ 1 / 2 := by
  have h := leftTailMass_pos (varianceCoefficient_pos (by norm_num : (0 : ℝ) < 1)
    (by norm_num : (0 : ℝ) < 3)) fourthCoefficient_pos.le
  unfold thresholdDescentMass
  exact ⟨lt_min (by norm_num) h, min_le_left _ _⟩

theorem expectedOddCount_le_floor_regime (n k : ℕ) (hn : 1 ≤ n) (hk : 4 ≤ k)
    (hnk : (n : ℝ) ≤ (k : ℝ)) (hupper : (k : ℝ) ≤ criticalRatio * (n : ℝ)) :
    finiteMean (fun draws : Fin (3 * n - 1) → Fin k => (oddBinCount draws : ℝ)) ≤ (n : ℝ) + 13 := by
  let m := 3 * n - 1
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hkr : 0 < (k : ℝ) := by exact_mod_cast (show 0 < k by omega)
  have hrat : 0 < (k : ℝ) / (n : ℝ) := div_pos hkr hnR
  have hcmp : (k : ℝ) / (n : ℝ) ≤ criticalRatio := (div_le_iff₀ hnR).mpr hupper
  have hcurve := occupancyCurve_strictMono.monotoneOn hrat criticalRatio_pos hcmp
  rw [occupancyCurve_criticalRatio] at hcurve
  have hweighted := mul_le_mul_of_nonneg_left hcurve hnR.le
  have hmed := (abs_le.mp (expectedOddCount_approximation n k hn hk)).2
  have hmR : (m : ℝ) ≤ 3 * (k : ℝ) := by
    have hm : (m : ℝ) ≤ 3 * (n : ℝ) := by exact_mod_cast (show m ≤ 3 * n by dsimp [m]; omega)
    linarith [mul_le_mul_of_nonneg_left hnk (show (0 : ℝ) ≤ 3 by norm_num)]
  have herr : 4 * (m : ℝ) / (k : ℝ) + 1 ≤ 13 := by
    have h : 4 * (m : ℝ) / (k : ℝ) ≤ 12 := (div_le_iff₀ hkr).mpr (by linarith)
    linarith
  change _ - (n : ℝ) * occupancyCurve ((k : ℝ) / (n : ℝ)) ≤ 4 * (m : ℝ) / (k : ℝ) + 1 at hmed
  linarith only [hmed, hweighted, herr]

theorem eventually_descent_large (c : ℝ) :
    ∀ᶠ n : ℕ in atTop, c ≤ thresholdDescent * Real.sqrt (n : ℝ) := by
  let size := max 0 (c / thresholdDescent)
  have hsize : 0 ≤ size := le_max_left _ _
  have hcast : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop := tendsto_natCast_atTop_atTop
  filter_upwards [tendsto_atTop.1 hcast (size ^ 2)] with n hn
  have h := (Real.le_sqrt hsize (Nat.cast_nonneg n)).mpr hn
  have h' := (div_le_iff₀ thresholdDescent_pos).mp ((le_max_right (0 : ℝ) (c / thresholdDescent)).trans h)
  simpa only [mul_comm] using h'

theorem floor_candidate_success_mass_eventually :
    ∀ᶠ n : ℕ in atTop, thresholdDescentMass ≤ finiteProbability
      (fun draws : Fin (3 * n - 1) → Fin (2 ^ transitionFloor n) =>
        oddBinCount draws ≤ n + 2 * transitionFloor n - 1) := by
  have hcast : Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop := tendsto_natCast_atTop_atTop
  filter_upwards [eventually_ge_atTop (8 : ℕ), transitionFloor_eventually_admissible,
    tendsto_atTop.1 hcast (32 * (3 / (1 : ℝ)) / varianceCurve (2 / 3)), eventually_descent_large 14]
    with n hn hadm hlarge hdescent
  let s := transitionFloor n
  let k := 2 ^ s
  have hklo : (n : ℝ) ≤ (k : ℝ) := by simpa only [k, s, Nat.cast_pow, Nat.cast_ofNat] using
    (transitionFloor_bin_range n (by omega)).1
  have hkhi : (k : ℝ) ≤ 3 * (n : ℝ) := by simpa only [k, s, Nat.cast_pow, Nat.cast_ofNat] using
    (transitionFloor_bin_range n (by omega)).2
  have hkcrit : (k : ℝ) ≤ criticalRatio * (n : ℝ) := by simpa only [k, s, Nat.cast_pow, Nat.cast_ofNat] using
    (transition_power_bounds n (by omega)).1
  have hk8 : 8 ≤ k := hn.trans (by exact_mod_cast hklo)
  have hlargeK := hlarge.trans hklo
  have htail := oddBinCount_small_deviation n k (by omega) hk8 1 3 (by norm_num) (by norm_num)
    (by simpa only [one_mul] using hklo) hkhi hlargeK
  have hmean := expectedOddCount_le_floor_regime n k (by omega) (by omega) hklo hkcrit
  have hmassEvent : thresholdDescentMass ≤ finiteProbability (fun draws : Fin (3 * n - 1) → Fin k =>
      oddBinCount draws ≤ n + 2 * s - 1) := by
    apply (min_le_right (1 / 2) _).trans (htail.trans ?_)
    apply finiteProbability_mono
    intro draws hd
    have hcount : (oddBinCount draws : ℝ) ≤ (n : ℝ) := by
      change (oddBinCount draws : ℝ) ≤
        finiteMean (fun d : Fin (3 * n - 1) → Fin k => (oddBinCount d : ℝ)) -
          thresholdDescent * Real.sqrt (n : ℝ) at hd
      linarith only [hd, hmean, hdescent]
    exact (show oddBinCount draws ≤ n by exact_mod_cast hcount).trans (by dsimp [s]; omega)
  exact hmassEvent

theorem lower_floor_fails_probability_zero :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      maximumFeasibleOwners (profileTag bits) < transitionFloor n)) atTop (𝓝 0) := by
  have hmass := thresholdDescentMass_bounds
  have hgeo := (tendsto_pow_atTop_nhds_zero_of_lt_one
    (show 0 ≤ 1 - thresholdDescentMass by linarith [hmass.2])
    (show 1 - thresholdDescentMass < 1 by linarith [hmass.1])).comp transition_group_count_atTop
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity) ?_ hgeo
  filter_upwards [transitionFloor_eventually_admissible, floor_candidate_success_mass_eventually] with n hadm hm
  exact probability_sStar_below_from_independent_blocks n (transitionFloor n)
    hadm.1 hadm.2.1 thresholdDescentMass hm

end TwoColorNullity.Occupancy
