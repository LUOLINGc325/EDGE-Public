import OccupancyLowerThreshold
import ColorSupplyProbability
import ExactProtectedOptimum

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

theorem largeSetThreshold_fraction_zero :
    Tendsto (fun n : ℕ => (largeSetThreshold n : ℝ) / (n : ℝ)) atTop (𝓝 0) := by
  have h₁ : Tendsto (fun n : ℕ => ((n : ℝ))⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_zero.comp tendsto_natCast_atTop_atTop
  have h₂ := binaryLog_over_n_zero.add (h₁.const_mul (7 : ℝ))
  simp only [mul_zero, add_zero] at h₂
  apply squeeze_zero' (Eventually.of_forall fun _ => by positivity) ?_ h₂
  filter_upwards [eventually_ge_atTop (1 : ℕ)] with n hn
  have h := div_le_div_of_nonneg_right (threshold_le_binaryLog_add n (by omega)) (Nat.cast_nonneg n)
  simpa only [div_eq_mul_inv, add_mul] using h

theorem largeSetThreshold_eventually_fraction {c : ℝ} (hc : 0 < c) :
    ∀ᶠ n : ℕ in atTop, (largeSetThreshold n : ℝ) ≤ c * (n : ℝ) := by
  filter_upwards [eventually_ge_atTop (1 : ℕ), largeSetThreshold_fraction_zero.eventually (gt_mem_nhds hc)]
    with n hn h
  have hnR : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  exact ((div_lt_iff₀ hnR).mp h).le

noncomputable def typicalOptimum (n : ℕ) (bits : BitProfile n (3 * n - 1)) : ℝ :=
  (((n - 1) ⌈/⌉ maximumFeasibleOwners (profileTag bits) - 1 : ℕ) : ℝ)

theorem exact_factor_failure_probability_zero :
    Tendsto (fun n : ℕ => finiteProbability (fun bits =>
      optimalFactor (profileTag bits) ≠ typicalOptimum n bits)) atTop (𝓝 0) := by
  have hright := bad_owner_sets_probability_vanishes.add any_color_deficit_probability_zero
  rw [zero_add] at hright
  have hprobs := lower_floor_fails_probability_zero.add hright
  rw [zero_add] at hprobs
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity) ?_ hprobs
  filter_upwards [eventually_ge_atTop (2 : ℕ),
    largeSetThreshold_eventually_fraction (show (0 : ℝ) < 1 / 4 by norm_num),
    largeSetThreshold_eventually_fraction
      (show 0 < colorSupplyCoefficient / 8 from div_pos colorSupplyCoefficient_pos (by norm_num))]
    with n hn hroom hcolor
  let badFloor (bits : BitProfile n (3 * n - 1)) := maximumFeasibleOwners (profileTag bits) < transitionFloor n
  let badCutoff (bits : BitProfile n (3 * n - 1)) := largeSetThreshold n ≤ maximumFeasibleOwners (profileTag bits)
  have inclusion (bits : BitProfile n (3 * n - 1))
      (hbad : optimalFactor (profileTag bits) ≠ typicalOptimum n bits) :
      badFloor bits ∨ badCutoff bits ∨ SomeColorDeficit n bits := by
    by_cases hlo : badFloor bits
    · exact Or.inl hlo
    · by_cases hhi : badCutoff bits
      · exact Or.inr (Or.inl hhi)
      · by_cases hmissing : SomeColorDeficit n bits
        · exact Or.inr (Or.inr hmissing)
        · exfalso
          apply hbad
          obtain ⟨owners, hfeas, hcard⟩ := maximumFeasibleOwners_attained (profileTag bits) hn
          have hlt : owners.card < largeSetThreshold n := by
            dsimp [badCutoff] at hhi
            omega
          have hge : n.log2 ≤ owners.card := by
            have h₁ := transitionFloor_at_least_log2 n (by omega)
            dsimp [badFloor] at hlo
            omega
          have hcardR : (owners.card : ℝ) ≤ (largeSetThreshold n : ℝ) := by exact_mod_cast hlt.le
          have hsmall : 4 * owners.card ≤ n := by
            exact_mod_cast (show 4 * (owners.card : ℝ) ≤ (n : ℝ) by linarith only [hroom, hcardR])
          have hreserve : 4 * (owners.card : ℝ) ≤ colorSupplyCoefficient * (n : ℝ) / 2 := by
            linarith only [hcardR, hcolor]
          have hsupply (owner : ↥owners) (color : Bool) :
              4 * owners.card ≤ restrictedOddCount (designatedColorBins owner color)
                (signature (profileTag bits) owners) := by
            have hEnough : colorSupplyCoefficient * (n : ℝ) / 2 ≤
                (restrictedOddCount (designatedColorBins owner color) (signature (profileTag bits) owners) : ℝ) :=
              le_of_not_gt (fun h => hmissing ⟨owners, hlt, hge, owner, color, h⟩)
            exact_mod_cast hreserve.trans hEnough
          exact optimum_eq_lower_endpoint (profileTag bits) hn owners hfeas hcard.symm (by omega) hsupply
  have h := (finiteProbability_mono inclusion).trans (finiteProbability_union_two badFloor
    (fun bits => badCutoff bits ∨ SomeColorDeficit n bits))
  exact h.trans (add_le_add_left (finiteProbability_union_two badCutoff (SomeColorDeficit n)) _)

/-- The discrete matching window and exact optimal factor hold with probability tending to one. -/
theorem sharp_random_efx_threshold :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      ¬ (transitionFloor n ≤ maximumFeasibleOwners (profileTag bits) ∧
        maximumFeasibleOwners (profileTag bits) ≤ windowUpper n ∧
        optimalFactor (profileTag bits) = typicalOptimum n bits))) atTop (𝓝 0) := by
  have hright := upper_window_fails_probability_zero.add exact_factor_failure_probability_zero
  rw [zero_add] at hright
  have h := lower_floor_fails_probability_zero.add hright
  rw [zero_add] at h
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity) ?_ h
  refine Eventually.of_forall fun n => ?_
  let badFloor (bits : BitProfile n (3 * n - 1)) := maximumFeasibleOwners (profileTag bits) < transitionFloor n
  let badUpper (bits : BitProfile n (3 * n - 1)) := windowUpper n < maximumFeasibleOwners (profileTag bits)
  let badFactor (bits : BitProfile n (3 * n - 1)) := optimalFactor (profileTag bits) ≠ typicalOptimum n bits
  have cover (bits : BitProfile n (3 * n - 1))
      (hbad : ¬ (transitionFloor n ≤ maximumFeasibleOwners (profileTag bits) ∧
        maximumFeasibleOwners (profileTag bits) ≤ windowUpper n ∧
        optimalFactor (profileTag bits) = typicalOptimum n bits)) :
      badFloor bits ∨ badUpper bits ∨ badFactor bits := by
    by_cases hlo : badFloor bits
    · exact Or.inl hlo
    · by_cases hhi : badUpper bits
      · exact Or.inr (Or.inl hhi)
      · exact Or.inr (Or.inr (fun he => hbad ⟨le_of_not_gt hlo, le_of_not_gt hhi, he⟩))
  exact (finiteProbability_mono cover).trans ((finiteProbability_union_two badFloor
    (fun bits => badUpper bits ∨ badFactor bits)).trans (add_le_add_left (finiteProbability_union_two badUpper badFactor) _))

end TwoColorNullity.Occupancy
