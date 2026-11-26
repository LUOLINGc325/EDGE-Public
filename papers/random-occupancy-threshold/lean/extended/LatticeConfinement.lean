import LatticeLimitAttainment

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

theorem centered_reciprocal_near_limit_interval {ε : ℝ} (hε : 0 < ε) :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      centeredEFX n bits < binaryLog criticalRatio - 1 - ε ∨
        binaryLog criticalRatio + ε < centeredEFX n bits)) atTop (𝓝 0) := by
  have hbound := reciprocalEnvelope_zero.add (boundaryWidth_zero thresholdWindowConstant)
  rw [zero_add] at hbound
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity)
    ?_ sharp_random_efx_threshold
  filter_upwards [eventually_ge_atTop (2 : ℕ), transitionFloor_eventually_admissible,
    windowUpper_eventually_le_thinCandidate,
    thinCandidate_eventually_small (show (0 : ℝ) < 1 / 4 by norm_num),
    hbound.eventually (gt_mem_nhds hε)] with n hn hpos hwindow hcand hb
  apply finiteProbability_mono
  intro bits hbad hgood
  let s := maximumFeasibleOwners (profileTag bits)
  have hs : 0 < s := hpos.1.trans_le hgood.1
  have hup : s ≤ thinCandidate n := hgood.2.1.trans hwindow
  have hsR : (s : ℝ) ≤ (thinCandidate n : ℝ) := by exact_mod_cast hup
  have h4 : 4 * s ≤ n := by exact_mod_cast (show 4 * (s : ℝ) ≤ (n : ℝ) by linarith only [hcand, hsR])
  have hsize : (s : ℝ) ≤ binaryLog n + 3 := by
    have ht := transitionFloor_le_log_add_two n (by omega)
    unfold thinCandidate at hsR
    push_cast at hsR
    linarith only [ht, hsR]
  have herr := reciprocal_error_le_envelope n s hn hs (by omega) hsize
  have hlow : -1 < (s : ℝ) - transitionLog n := by
    have hcast : (transitionFloor n : ℝ) ≤ (s : ℝ) := by exact_mod_cast hgood.1
    linarith only [hcast, (transitionFloor_bounds n (by omega)).2]
  have hw₀ : 0 ≤ boundaryWidth thresholdWindowConstant n :=
    mul_nonneg thresholdWindowConstant_pos.le (div_nonneg
      (Real.log_nonneg (by exact_mod_cast (show 1 ≤ n by omega))) (Real.sqrt_nonneg _))
  have hhigh : (s : ℝ) - transitionLog n ≤ boundaryWidth thresholdWindowConstant n := by
    have hcast : (s : ℝ) ≤ (windowUpper n : ℝ) := by exact_mod_cast hgood.2.1
    have hfloor : (windowUpper n : ℝ) ≤ transitionLog n + boundaryWidth thresholdWindowConstant n :=
      Nat.floor_le (add_nonneg (transitionLog_nonnegative n (by omega)) hw₀)
    linarith only [hcast, hfloor]
  have hcenter : centeredEFX n bits =
      ((n : ℝ) / (((n - 1) ⌈/⌉ s - 1 : ℕ) : ℝ) - (s : ℝ)) +
        ((s : ℝ) - transitionLog n) + binaryLog criticalRatio := by
    unfold centeredEFX
    rw [hgood.2.2, transitionLog_shift n (by omega)]
    unfold typicalOptimum s
    ring
  rw [hcenter] at hbad
  obtain ⟨he₁, he₂⟩ := abs_le.mp herr
  rcases hbad with hbad | hbad
  · linarith only [hbad, hlow, he₁, hw₀, hb]
  · linarith only [hbad, hhigh, he₂, hb]

private theorem union_of_two_vanishing_cannot_cover (population : ℕ → ℕ)
    (first second : (j : ℕ) → BitProfile (population j) (3 * population j - 1) → Prop)
    (hfirst : Tendsto (fun j => finiteProbability (first j)) atTop (𝓝 0))
    (hsecond : Tendsto (fun j => finiteProbability (second j)) atTop (𝓝 0))
    (hcover : ∀ j bits, first j bits ∨ second j bits) : False := by
  have h := hfirst.add hsecond
  rw [zero_add] at h
  obtain ⟨j, hj⟩ := (h.eventually (gt_mem_nhds (show (0 : ℝ) < 1 by norm_num))).exists
  classical
  have heq : (fun bits => first j bits ∨ second j bits) = fun _ => True := by
    funext bits
    exact propext (iff_true_intro (hcover j bits))
  have hone : finiteProbability (fun _ : BitProfile (population j) (3 * population j - 1) => True) = 1 := by
    rw [finiteProbability_eq_mean_indicator]
    simp only [if_true, finiteMean_const]
  have hb := finiteProbability_union_two (first j) (second j)
  rw [heq, hone] at hb
  exact (not_lt_of_ge hb) hj

theorem centered_limit_in_interval (population : ℕ → ℕ) (htop : Tendsto population atTop atTop)
    (target : ℝ) (hprob : CenteredConvergesInProbability population target) :
    target ∈ Set.Icc (binaryLog criticalRatio - 1) (binaryLog criticalRatio) := by
  constructor
  · by_contra! hlt
    let ε := (binaryLog criticalRatio - 1 - target) / 3
    have hε : 0 < ε := div_pos (sub_pos.mpr hlt) (by norm_num)
    let first (j : ℕ) (bits : BitProfile (population j) (3 * population j - 1)) :=
      centeredEFX (population j) bits < binaryLog criticalRatio - 1 - ε ∨
        binaryLog criticalRatio + ε < centeredEFX (population j) bits
    let second (j : ℕ) (bits : BitProfile (population j) (3 * population j - 1)) :=
      ε ≤ |centeredEFX (population j) bits - target|
    apply union_of_two_vanishing_cannot_cover population first second
      ((centered_reciprocal_near_limit_interval hε).comp htop) (hprob ε hε)
    intro j bits
    by_cases ha : centeredEFX (population j) bits < binaryLog criticalRatio - 1 - ε
    · exact Or.inl (Or.inl ha)
    · apply Or.inr
      unfold second
      have hm := le_of_not_gt ha
      have hh : 0 ≤ centeredEFX (population j) bits - target := by dsimp [ε] at hm; linarith
      rw [abs_of_nonneg hh]
      unfold ε at hm ⊢
      linarith
  · by_contra! hgt
    let ε := (target - binaryLog criticalRatio) / 3
    have hε : 0 < ε := div_pos (sub_pos.mpr hgt) (by norm_num)
    let first (j : ℕ) (bits : BitProfile (population j) (3 * population j - 1)) :=
      centeredEFX (population j) bits < binaryLog criticalRatio - 1 - ε ∨
        binaryLog criticalRatio + ε < centeredEFX (population j) bits
    let second (j : ℕ) (bits : BitProfile (population j) (3 * population j - 1)) :=
      ε ≤ |centeredEFX (population j) bits - target|
    apply union_of_two_vanishing_cannot_cover population first second
      ((centered_reciprocal_near_limit_interval hε).comp htop) (hprob ε hε)
    intro j bits
    by_cases ha : binaryLog criticalRatio + ε < centeredEFX (population j) bits
    · exact Or.inl (Or.inr ha)
    · apply Or.inr
      unfold second
      have hm := le_of_not_gt ha
      have hh : centeredEFX (population j) bits - target ≤ 0 := by dsimp [ε] at hm; linarith
      rw [abs_of_nonpos hh]
      unfold ε at hm ⊢
      linarith

theorem centered_subsequence_limits_exactly (value : ℝ) :
    (∃ population : ℕ → ℕ, StrictMono population ∧ Tendsto population atTop atTop ∧
      CenteredConvergesInProbability population value) ↔
      value ∈ Set.Icc (binaryLog criticalRatio - 1) (binaryLog criticalRatio) := by
  constructor
  · rintro ⟨population, _, htop, h⟩
    exact centered_limit_in_interval population htop value h
  · intro h
    let phase := binaryLog criticalRatio - value
    have hp : phase ∈ Set.Icc (0 : ℝ) 1 := ⟨by dsimp [phase]; linarith [h.2], by dsimp [phase]; linarith [h.1]⟩
    have hf := all_closed_interval_phases_attained phase hp
    have hvalue : binaryLog criticalRatio - phase = value := by unfold phase; ring
    rwa [hvalue] at hf

theorem centered_probability_limit_unique (population : ℕ → ℕ) (a b : ℝ)
    (ha : CenteredConvergesInProbability population a) (hb : CenteredConvergesInProbability population b) :
    a = b := by
  by_contra hn
  let ε := |a - b| / 3
  have hp : 0 < ε := div_pos (abs_pos.mpr (sub_ne_zero.mpr hn)) (by norm_num)
  let first (j : ℕ) (bits : BitProfile (population j) (3 * population j - 1)) :=
    ε ≤ |centeredEFX (population j) bits - a|
  let second (j : ℕ) (bits : BitProfile (population j) (3 * population j - 1)) :=
    ε ≤ |centeredEFX (population j) bits - b|
  apply union_of_two_vanishing_cannot_cover population first second (ha ε hp) (hb ε hp)
  intro j bits
  by_cases ht : first j bits
  · exact Or.inl ht
  · apply Or.inr
    unfold first at ht
    unfold second
    by_contra! hs
    have hl := lt_of_not_ge ht
    have htri := abs_sub_le a (centeredEFX (population j) bits) b
    rw [abs_sub_comm a (centeredEFX (population j) bits)] at htri
    unfold ε at hl hs
    linarith only [hl, hs, htri, abs_pos.mpr (sub_ne_zero.mpr hn)]

theorem centered_no_constant_probability_limit (target : ℝ) :
    ¬ CenteredConvergesInProbability (fun n => n) target := by
  intro h
  have heach (phase : ℝ) : CenteredConvergesInProbability (phasePopulation phase) target := by
    intro ε hε
    exact (h ε hε).comp (phasePopulation_atTop phase)
  have hfirst := centered_probability_limit_unique (phasePopulation (1 / 4)) target _
    (heach (1 / 4)) (centered_phase_limit (1 / 4) (by norm_num) (by norm_num))
  have hsecond := centered_probability_limit_unique (phasePopulation (3 / 4)) target _
    (heach (3 / 4)) (centered_phase_limit (3 / 4) (by norm_num) (by norm_num))
  linarith only [hfirst, hsecond]

end TwoColorNullity.Occupancy

