import MeanScreening

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

theorem selectMeanSize_outside_eventually :
    ∀ᶠ n : ℕ in atTop, OutsideTransitionWindows n → selectMeanSize n = some (transitionFloor n) := by
  filter_upwards [eventually_ge_atTop (128 : ℕ), count_correction_eventually_below_scale] with n hn hc
  intro hw
  let s := transitionFloor n
  let k := 2 ^ s
  have hklo : (n : ℝ) ≤ (k : ℝ) := by
    simpa only [k, s, Nat.cast_pow, Nat.cast_ofNat] using (transitionFloor_bin_range n (by omega)).1
  have hkcrit : (k : ℝ) ≤ criticalRatio * (n : ℝ) := by
    simpa only [k, s, Nat.cast_pow, Nat.cast_ofNat] using (transition_power_bounds n (by omega)).1
  have hk4 : 4 ≤ k := by
    have h : n ≤ k := by exact_mod_cast hklo
    omega
  have hf := expectedOddCount_le_floor_regime n k (by omega) hk4 hklo hkcrit
  have h7 : 7 ≤ n.log2 := (Nat.le_log2 (by omega)).mpr (by norm_num; omega)
  have hs7 : 7 ≤ s := h7.trans (transitionFloor_at_least_log2 n (by omega))
  have ht : (n : ℝ) + 13 ≤ ((n + 2 * s - 1 : ℕ) : ℝ) := by
    exact_mod_cast (show n + 13 ≤ n + 2 * s - 1 by omega)
  have hpass : meanPasses n s = true :=
    (meanPasses_spec n s (by omega)).mpr (hf.trans ht)
  have hs : s ∈ passingMeanCandidates n :=
    Finset.mem_filter.mpr ⟨floor_mem_meanCandidateRange n (by omega), hpass⟩
  apply selectMeanSize_of_max n s hs
  intro t ht
  by_contra! hgt
  obtain ⟨hin, hpassT⟩ := Finset.mem_filter.mp ht
  have hb := Finset.mem_Icc.mp hin
  change n.log2 ≤ t ∧ t ≤ largeSetThreshold n - 1 at hb
  have hcap : t < largeSetThreshold n := by
    have h0 : 0 < largeSetThreshold n := by unfold largeSetThreshold; omega
    omega
  have hpass' := (meanPasses_spec n t (by omega)).mp hpassT
  have hwT : windowUpper n < t := by rwa [windowUpper_eq_floor_of_outside n (by omega) hw]
  have hgap := upper_mean_gap n t (by omega) hc.1 hc.2 hcap hwT
  have hpos : 0 < concentrationScale n := by
    unfold concentrationScale
    have hd := deviationCoefficient_pos
    have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
    have hln : 0 < Real.log (n : ℝ) := by linarith [hc.1]
    positivity
  linarith only [hpass', hgap, hpos]

def successfulBlocks (n s : ℕ) (bits : BitProfile n (3 * n - 1)) : Finset (Fin (n / s)) :=
  Finset.univ.filter fun group =>
    oddBinCount (groupedWords (disjointCoordinateBlocks n s) bits group) ≤ n + 2 * s - 1

def firstSuccessfulBlock (n s : ℕ) (bits : BitProfile n (3 * n - 1)) : Option (Fin (n / s)) :=
  if h : (successfulBlocks n s bits).Nonempty then some ((successfulBlocks n s bits).min' h) else none

theorem firstSuccessfulBlock_matches (n s : ℕ) (bits : BitProfile n (3 * n - 1)) (group : Fin (n / s))
    (h : firstSuccessfulBlock n s bits = some group) :
    oddBinCount (groupedWords (disjointCoordinateBlocks n s) bits group) ≤ n + 2 * s - 1 := by
  unfold firstSuccessfulBlock at h
  split at h
  next hne =>
    have heq := Option.some.inj h
    rw [← heq]
    exact (Finset.mem_filter.mp ((successfulBlocks n s bits).min'_mem hne)).2
  next _ => contradiction

theorem screened_group_failure_geometric :
    ∀ᶠ n : ℕ in atTop, finiteProbability
      (fun bits : BitProfile n (3 * n - 1) => firstSuccessfulBlock n (transitionFloor n) bits = none) ≤
      (1 - thresholdDescentMass) ^ (n / transitionFloor n) := by
  filter_upwards [floor_candidate_success_mass_eventually] with n hmass
  let s := transitionFloor n
  let coords := disjointCoordinateBlocks n s
  let event (_ : Fin (n / s)) (data : Fin (3 * n - 1) → (Fin s → Bool)) :=
    oddBinCount data ≤ n + 2 * s - 1
  have hbound := groupedWords_none_le coords (3 * n - 1) event thresholdDescentMass (fun i => by
    unfold event
    rw [binary_words_occupancy_uniform]
    exact hmass)
  have h : finiteProbability (fun bits : BitProfile n (3 * n - 1) => firstSuccessfulBlock n s bits = none) ≤
      finiteProbability (fun bits : BitProfile n (3 * n - 1) => ∀ group, ¬ event group (groupedWords coords bits group)) := by
    apply finiteProbability_mono
    intro bits hnone group hsuccess
    have hmem : group ∈ successfulBlocks n s bits := Finset.mem_filter.mpr ⟨Finset.mem_univ _, hsuccess⟩
    have hne : (successfulBlocks n s bits).Nonempty := ⟨group, hmem⟩
    unfold firstSuccessfulBlock at hnone
    rw [dif_pos hne] at hnone
    contradiction
  simpa only [Fintype.card_fin] using h.trans hbound

theorem firstSuccessfulBlock_failure_probability_zero :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      firstSuccessfulBlock n (transitionFloor n) bits = none)) atTop (𝓝 0) := by
  have hmass := thresholdDescentMass_bounds
  have hgeo := (tendsto_pow_atTop_nhds_zero_of_lt_one
    (show 0 ≤ 1 - thresholdDescentMass by linarith [hmass.2])
    (show 1 - thresholdDescentMass < 1 by linarith [hmass.1])).comp transition_group_count_atTop
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity) ?_ hgeo

  exact screened_group_failure_geometric

/-- The chance of rejecting all tested groups decays exponentially in the number of disjoint blocks of logarithmic size. -/
theorem screened_group_failure_exponential :
    ∀ᶠ n : ℕ in atTop, finiteProbability
      (fun bits : BitProfile n (3 * n - 1) => firstSuccessfulBlock n (transitionFloor n) bits = none) ≤
      Real.exp (-(thresholdDescentMass / 2) * ((n : ℝ) / (binaryLog n + 2))) := by
  filter_upwards [screened_group_failure_geometric, transitionFloor_eventually_admissible,
    eventually_ge_atTop (1 : ℕ)] with n hgood hadm hn
  let s := transitionFloor n
  let q := n / s
  let p := thresholdDescentMass
  have hp : 0 < p ∧ p ≤ 1 := ⟨thresholdDescentMass_bounds.1, thresholdDescentMass_bounds.2.trans (by norm_num)⟩
  have hgeo : (1 - p) ^ q ≤ Real.exp (-p * (q : ℝ)) := by
    have h : 1 - p ≤ Real.exp (-p) := by linarith only [Real.add_one_le_exp (-p)]
    have hpow := pow_le_pow_left₀ (sub_nonneg.mpr hp.2) h q
    rw [mul_comm, Real.exp_nat_mul]
    exact hpow
  have hq : 1 ≤ q := (Nat.le_div_iff_mul_le hadm.1).mpr (by simpa only [one_mul] using hadm.2.1.le)
  have hs : 0 < s := hadm.1
  have hnat : n ≤ 2 * (s * q) := by
    have hdecompose : s * q + n % s = n := Nat.div_add_mod n s
    have hmod := Nat.mod_lt n hs
    have hmul := Nat.mul_le_mul_left s hq
    rw [Nat.mul_one] at hmul
    omega
  have hreal : (n : ℝ) ≤ 2 * ((s : ℝ) * (q : ℝ)) := by exact_mod_cast hnat
  have hsR : (0 : ℝ) < s := by exact_mod_cast hs
  have hden : (s : ℝ) ≤ binaryLog n + 2 := transitionFloor_le_log_add_two n hn
  have hsmall : (n : ℝ) / (binaryLog n + 2) ≤ 2 * (q : ℝ) := by
    refine (div_le_div_of_nonneg_left (Nat.cast_nonneg n) hsR hden).trans ?_
    exact (div_le_iff₀ hsR).mpr (by nlinarith only [hreal])
  have he := (Real.exp_le_exp).mpr
    (mul_le_mul_of_nonpos_left hsmall (show -(p / 2) ≤ 0 by linarith only [hp.1]))
  have heq : -(p / 2) * (2 * (q : ℝ)) = -p * (q : ℝ) := by ring
  rw [heq] at he
  exact hgood.trans (hgeo.trans he)

end TwoColorNullity.Occupancy
