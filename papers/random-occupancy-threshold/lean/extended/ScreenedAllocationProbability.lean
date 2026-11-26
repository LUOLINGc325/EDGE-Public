import FallbackAllocation

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

def selectedScreenedGroup (n : ℕ) (bits : BitProfile n (3 * n - 1)) :
    Option (Σ s : ℕ, Fin (n / s)) := do
  let s ← selectMeanSize n
  let group ← firstSuccessfulBlock n s bits
  pure ⟨s, group⟩


/-- Run the rational screen and use the deterministic matching fallback if needed. -/
def runRandomEFXAllocation (n : ℕ) (hn : 2 ≤ n) (bits : BitProfile n (3 * n - 1)) :
    Fin (3 * n - 1) → Fin n :=
  let fallback := runFallbackAllocation n hn (profileTag bits)
  match selectedScreenedGroup n bits with
  | none => fallback
  | some ⟨s, group⟩ =>
    if h : 0 < s ∧ s < n then
      if hcheck : firstSuccessfulBlock n s bits = some group then
        (runScreenedAllocation n s h.1 h.2 bits group hcheck).getD fallback
      else fallback
    else fallback

/-- The actual tested group supports an allocation at the optimum with its computed agreeing pairs. -/
def ScreenedOptimalCertificate (n : ℕ) (bits : BitProfile n (3 * n - 1)) : Prop :=
  ∃ s : ℕ, ∃ group : Fin (n / s),
    selectedScreenedGroup n bits = some ⟨s, group⟩ ∧
    ∃ hs : 0 < s, ∃ hsn : s < n, ∃ hcheck : firstSuccessfulBlock n s bits = some group,
    ∃ assign, runScreenedAllocation n s hs hsn bits group hcheck = some assign ∧
      ApproxEFX (profileTag bits) assign (optimalFactor (profileTag bits)) ∧
      (∀ i ∉ blockOwners (disjointCoordinateBlocks n s) group,
        ∃ pair ∈ screenedPairs n s bits group, bundle assign i = pair) ∧
      (∀ i ∈ blockOwners (disjointCoordinateBlocks n s) group, HasTwoOfEachColor (profileTag bits) assign i)

theorem screened_fallback_valid (n : ℕ) (hn : 2 ≤ n) (bits : BitProfile n (3 * n - 1)) :
    ∃ assign, ApproxEFX (profileTag bits) assign (((n - 1) ⌈/⌉ n.log2 : ℕ) : ℝ) :=
  ⟨runFallbackAllocation n hn (profileTag bits), runFallbackAllocation_valid n hn (profileTag bits)⟩

theorem screened_typical_optimum (n : ℕ) (hn : 2 ≤ n) (hw : OutsideTransitionWindows n)
    (hadm : 0 < transitionFloor n ∧ transitionFloor n < n ∧ 2 * transitionFloor n ≤ n - 1)
    (hsize : selectMeanSize n = some (transitionFloor n))
    (hreserve : ((4 * transitionFloor n : ℕ) : ℝ) ≤ colorSupplyCoefficient * (n : ℝ) / 2)
    (bits : BitProfile n (3 * n - 1))
    (hsharp : transitionFloor n ≤ maximumFeasibleOwners (profileTag bits) ∧
      maximumFeasibleOwners (profileTag bits) ≤ windowUpper n ∧
      optimalFactor (profileTag bits) = typicalOptimum n bits)
    (hcolor : ¬ SomeColorDeficit n bits)
    (hscreen : firstSuccessfulBlock n (transitionFloor n) bits ≠ none) :
    ScreenedOptimalCertificate n bits := by
  let s := transitionFloor n
  have hs : maximumFeasibleOwners (profileTag bits) = s :=
    le_antisymm (hsharp.2.1.trans_eq (windowUpper_eq_floor_of_outside n (by omega) hw)) hsharp.1
  cases hfound : firstSuccessfulBlock n s bits with
  | none => exact (hscreen hfound).elim
  | some group =>
    have hlog : n.log2 ≤ s := transitionFloor_at_least_log2 n (by omega)
    have hmem := (Finset.mem_Icc.mp (floor_mem_meanCandidateRange n (by omega))).2
    change s ≤ largeSetThreshold n - 1 at hmem
    have ht := show 0 < largeSetThreshold n by unfold largeSetThreshold; omega
    have hcut : s < largeSetThreshold n := by omega
    have hres := screened_construction_attains_optimum n s hadm.1 hadm.2.1 hadm.2.2
      bits group hfound hs hsharp.2.2 hcolor hlog hcut hreserve
    refine ⟨s, group, ?_, hadm.1, hadm.2.1, hfound, hres⟩
    unfold selectedScreenedGroup
    rw [hsize]
    change (firstSuccessfulBlock n s bits).bind
      (fun g => some (Sigma.mk s g : Σ t : ℕ, Fin (n / t))) = some (Sigma.mk s group)
    rw [hfound]
    rfl

/-- Outside the transition windows, screening finds a protected optimum with high probability. -/
theorem screened_optimum_failure_probability_zero :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      OutsideTransitionWindows n ∧ ¬ ScreenedOptimalCertificate n bits)) atTop (𝓝 0) := by
  have hright := any_color_deficit_probability_zero.add firstSuccessfulBlock_failure_probability_zero
  rw [zero_add] at hright
  have h := sharp_random_efx_threshold.add hright
  rw [zero_add] at h
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity) ?_ h
  filter_upwards [eventually_ge_atTop (2 : ℕ), transitionFloor_eventually_admissible,
    selectMeanSize_outside_eventually, transitionFloor_eventually_small
      (show 0 < colorSupplyCoefficient / 8 from div_pos colorSupplyCoefficient_pos (by norm_num))]
    with n hn hroom hsize hreserve
  let badTheorem (bits : BitProfile n (3 * n - 1)) :=
    ¬ (transitionFloor n ≤ maximumFeasibleOwners (profileTag bits) ∧
      maximumFeasibleOwners (profileTag bits) ≤ windowUpper n ∧
      optimalFactor (profileTag bits) = typicalOptimum n bits)
  let badSearch (bits : BitProfile n (3 * n - 1)) := firstSuccessfulBlock n (transitionFloor n) bits = none
  have hcover (bits : BitProfile n (3 * n - 1))
      (bad : OutsideTransitionWindows n ∧ ¬ ScreenedOptimalCertificate n bits) :
      badTheorem bits ∨ SomeColorDeficit n bits ∨ badSearch bits := by
    by_cases hb : badTheorem bits
    · exact Or.inl hb
    · by_cases hc : SomeColorDeficit n bits
      · exact Or.inr (Or.inl hc)
      · by_cases he : badSearch bits
        · exact Or.inr (Or.inr he)
        · exfalso
          apply bad.2
          have hcasting : ((4 * transitionFloor n : ℕ) : ℝ) ≤ colorSupplyCoefficient * (n : ℝ) / 2 := by
            push_cast
            linarith only [hreserve]
          exact screened_typical_optimum n hn bad.1 hroom (hsize bad.1) hcasting bits
            (not_not.mp hb) hc he
  exact (finiteProbability_mono hcover).trans ((finiteProbability_union_two badTheorem
    (fun bits => SomeColorDeficit n bits ∨ badSearch bits)).trans
      (add_le_add_left (finiteProbability_union_two (SomeColorDeficit n) badSearch) _))

theorem runRandomEFXAllocation_optimal_of_certificate (n : ℕ) (hn : 2 ≤ n)
    (bits : BitProfile n (3 * n - 1)) (certificate : ScreenedOptimalCertificate n bits) :
    ApproxEFX (profileTag bits) (runRandomEFXAllocation n hn bits) (optimalFactor (profileTag bits)) := by
  obtain ⟨s, group, hselect, hs, hsn, hcheck, assign, hrun, hopt, _, _⟩ := certificate
  unfold runRandomEFXAllocation
  rw [hselect]
  let fallback := runFallbackAllocation n hn (profileTag bits)
  change ApproxEFX (profileTag bits)
    (if h : 0 < s ∧ s < n then
      if he : firstSuccessfulBlock n s bits = some group then
        (runScreenedAllocation n s h.1 h.2 bits group he).getD fallback
      else fallback
    else fallback)
    (optimalFactor (profileTag bits))
  rw [dif_pos (And.intro hs hsn), dif_pos hcheck, hrun]
  exact hopt

/-- The output of the deterministic algorithm attains the optimum outside the windows with high probability. -/
theorem runRandomEFXAllocation_failure_probability_zero :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      OutsideTransitionWindows n ∧
        ∃ hn : 2 ≤ n, ¬ ApproxEFX (profileTag bits) (runRandomEFXAllocation n hn bits)
          (optimalFactor (profileTag bits)))) atTop (𝓝 0) := by
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity) ?_
    screened_optimum_failure_probability_zero
  filter_upwards with n
  apply finiteProbability_mono
  rintro bits ⟨hw, hn, hbad⟩
  exact ⟨hw, fun h => hbad (runRandomEFXAllocation_optimal_of_certificate n hn bits h)⟩

end TwoColorNullity.Occupancy
