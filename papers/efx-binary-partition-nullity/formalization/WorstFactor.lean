import AsymptoticWitness

open Filter
open scoped Topology

namespace TwoColorNullity

noncomputable def fixedItemWorst (n : ℕ) : ℝ :=
  sSup (Set.range fun bits : BitProfile n (3 * n - 1) => optimalFactor (profileTag bits))

noncomputable def allCountsWorst (n : ℕ) : ℝ :=
  sSup {a : ℝ | ∃ m, ∃ bits : BitProfile n m, a = optimalFactor (profileTag bits)}

theorem optimalFactor_le_constructive (tag : Fin n → Fin m → Bool) (hn : 2 ≤ n) :
    optimalFactor tag ≤ constructiveFactor n m := by
  obtain ⟨assign, ha⟩ := constructiveFactor_spec tag hn
  exact optimalFactor_le tag _ (by exact_mod_cast constructiveFactor_pos n m) ha

theorem constructiveFactor_bdd (n m : ℕ) : constructiveFactor n m ≤ max 2 n := by
  unfold constructiveFactor
  split
  · omega
  · rename_i hsmall
    split
    · omega
    · rename_i hlarge
      let d := m - 2 * n
      change d ⌈/⌉ (d + 1).log2 ≤ max 2 n
      have hlog : 0 < (d + 1).log2 := (Nat.le_log2 (by omega)).mpr (by dsimp [d]; omega)
      apply (ceilDiv_le_iff_le_mul hlog).mpr
      have hd : d ≤ n := by dsimp [d]; omega
      calc
        d ≤ max 2 n := hd.trans (le_max_right _ _)
        _ = 1 * max 2 n := (one_mul _).symm
        _ ≤ (d + 1).log2 * max 2 n := Nat.mul_le_mul_right _ (by omega)

private theorem fixed_bdd (n : ℕ) (hn : 2 ≤ n) :
    BddAbove (Set.range fun bits : BitProfile n (3 * n - 1) => optimalFactor (profileTag bits)) := by
  refine ⟨(max 2 n : ℕ), ?_⟩
  rintro a ⟨bits, rfl⟩
  apply (optimalFactor_le_constructive _ hn).trans
  exact_mod_cast constructiveFactor_bdd n (3 * n - 1)

private theorem all_bdd (n : ℕ) (hn : 2 ≤ n) :
    BddAbove {a : ℝ | ∃ m, ∃ bits : BitProfile n m, a = optimalFactor (profileTag bits)} := by
  refine ⟨(max 2 n : ℕ), ?_⟩
  rintro a ⟨m, bits, rfl⟩
  apply (optimalFactor_le_constructive _ hn).trans
  exact_mod_cast constructiveFactor_bdd n m

theorem optimalFactor_le_fixedItemWorst (n : ℕ) (hn : 2 ≤ n) (bits : BitProfile n (3 * n - 1)) :
    optimalFactor (profileTag bits) ≤ fixedItemWorst n := by
  unfold fixedItemWorst
  apply le_csSup
  · exact fixed_bdd n hn
  · exact Set.mem_range_self bits

theorem fixedItemWorst_upper (n : ℕ) (hn : 2 ≤ n) :
    fixedItemWorst n ≤ (((n - 1) ⌈/⌉ n.log2 : ℕ) : ℝ) := by
  unfold fixedItemWorst
  refine csSup_le (Set.range_nonempty _) ?_
  rintro a ⟨bits, rfl⟩
  obtain ⟨assign, ha⟩ := uniform_fixed_items_factor (profileTag bits) hn
  have hlog : 0 < n.log2 := (Nat.le_log2 (by omega)).mpr (by omega)
  have hpos : 1 ≤ (n - 1) ⌈/⌉ n.log2 := by
    by_contra! hzero
    have hz : (n - 1) ⌈/⌉ n.log2 = 0 := by omega
    have h := (ceilDiv_le_iff_le_mul hlog).mp (show (n - 1) ⌈/⌉ n.log2 ≤ 0 by omega)
    omega
  exact optimalFactor_le _ _ (by exact_mod_cast hpos) ha

theorem fixedItemWorst_attained (n : ℕ) :
    ∃ bits : BitProfile n (3 * n - 1), optimalFactor (profileTag bits) = fixedItemWorst n := by
  classical
  let candidates := Finset.univ.image fun bits : BitProfile n (3 * n - 1) => optimalFactor (profileTag bits)
  have hne : candidates.Nonempty := ⟨optimalFactor (profileTag (fun _ => false)), by
    exact Finset.mem_image.mpr ⟨(fun _ => false), Finset.mem_univ _, rfl⟩⟩
  obtain ⟨bits, _, hbits⟩ := Finset.mem_image.mp (candidates.max'_mem hne)
  refine ⟨bits, ?_⟩
  unfold fixedItemWorst
  have maximal : ∀ a ∈ Set.range (fun bits : BitProfile n (3 * n - 1) => optimalFactor (profileTag bits)),
      a ≤ candidates.max' hne := by
    rintro a ⟨profile, rfl⟩
    exact candidates.le_max' _ (Finset.mem_image.mpr ⟨profile, Finset.mem_univ _, rfl⟩)
  rw [hbits]
  exact le_antisymm
    (le_csSup ⟨candidates.max' hne, maximal⟩ ⟨bits, hbits⟩)
    (csSup_le (Set.range_nonempty _) maximal)

theorem fixedItemWorst_le_allCounts (n : ℕ) (hn : 2 ≤ n) : fixedItemWorst n ≤ allCountsWorst n := by
  obtain ⟨bits, heq⟩ := fixedItemWorst_attained n
  rw [← heq]
  unfold allCountsWorst
  exact le_csSup (all_bdd n hn) ⟨3 * n - 1, bits, rfl⟩

theorem upper_of_all_constructive (n : ℕ) (hn : 2 ≤ n) (upper : ℝ)
    (h : ∀ m : ℕ, (constructiveFactor n m : ℝ) ≤ upper) : allCountsWorst n ≤ upper := by
  unfold allCountsWorst
  refine csSup_le ⟨optimalFactor (profileTag (fun _ : Fin n × Fin 0 => false)), 0, fun _ => false, rfl⟩ ?_
  rintro a ⟨m, bits, rfl⟩
  exact (optimalFactor_le_constructive _ hn).trans (h m)

theorem good_profile_lower (n : ℕ) (hn : 2 ≤ n) (cutoff : ℕ) (hcut : 0 < cutoff)
    (bits : BitProfile n (3 * n - 1)) (good : maximumFeasibleOwners (profileTag bits) ≤ cutoff) :
    (((n - 1) ⌈/⌉ cutoff - 1 : ℕ) : ℝ) ≤ optimalFactor (profileTag bits) := by
  let s := maximumFeasibleOwners (profileTag bits)
  have hs : 0 < s := by
    obtain ⟨owners, ho, heq⟩ := maximumFeasibleOwners_attained (profileTag bits) hn
    change 0 < maximumFeasibleOwners (profileTag bits)
    rw [heq]
    exact ho.1
  have hceil : (n - 1) ⌈/⌉ cutoff ≤ (n - 1) ⌈/⌉ s := by
    apply (ceilDiv_le_iff_le_mul hcut).mpr
    exact ((ceilDiv_le_iff_le_mul hs).mp (le_refl _)).trans (Nat.mul_le_mul_right _ good)
  have hcast : (((n - 1) ⌈/⌉ cutoff - 1 : ℕ) : ℝ) ≤ ((max 1 ((n - 1) ⌈/⌉ s - 1) : ℕ) : ℝ) := by
    exact_mod_cast (Nat.sub_le_sub_right hceil 1).trans (le_max_right _ _)
  exact hcast.trans (optimalFactor_within_one (profileTag bits) hn).1

private theorem finiteProbability_eq_one_of_forall {Sample : Type*} [Fintype Sample] [Nonempty Sample]
    {event : Sample → Prop} (h : ∀ sample, event sample) : finiteProbability event = 1 := by
  classical
  let equiv : {sample // event sample} ≃ Sample :=
    ⟨Subtype.val, fun sample => ⟨sample, h sample⟩, fun _ => rfl, fun _ => rfl⟩
  have hc : Nat.card {sample // event sample} = Fintype.card Sample := by
    rw [Nat.card_congr equiv, Nat.card_eq_fintype_card]
  rw [finiteProbability, hc]
  exact div_self (by exact_mod_cast Fintype.card_ne_zero)

theorem exists_good_profile (n cutoff : ℕ)
    (h : finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
        cutoff ≤ maximumFeasibleOwners (profileTag bits)) < 1) :
    ∃ bits : BitProfile n (3 * n - 1), maximumFeasibleOwners (profileTag bits) < cutoff := by
  by_contra! bad
  exact (ne_of_lt h) (finiteProbability_eq_one_of_forall bad)

theorem eventual_worst_exact_bounds :
    ∀ᶠ n : ℕ in atTop,
      (((n - 1) ⌈/⌉ (largeSetThreshold n - 1) - 1 : ℕ) : ℝ) ≤ fixedItemWorst n ∧
        fixedItemWorst n ≤ (((n - 1) ⌈/⌉ n.log2 : ℕ) : ℝ) := by
  filter_upwards [eventually_ge_atTop (2 : ℕ),
    bad_owner_sets_probability_vanishes.eventually (gt_mem_nhds zero_lt_one)] with n hn hp
  obtain ⟨bits, hgood⟩ := exists_good_profile n (largeSetThreshold n) hp
  have hcut : 0 < largeSetThreshold n - 1 := by unfold largeSetThreshold; omega
  have hlo := good_profile_lower n hn (largeSetThreshold n - 1) hcut bits (by omega)
  exact ⟨hlo.trans (optimalFactor_le_fixedItemWorst n hn bits), fixedItemWorst_upper n hn⟩

theorem random_optimum_exact_bounds_probability :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      ¬ ((((n - 1) ⌈/⌉ (largeSetThreshold n - 1) - 1 : ℕ) : ℝ) ≤ optimalFactor (profileTag bits) ∧
        optimalFactor (profileTag bits) ≤ (((n - 1) ⌈/⌉ n.log2 : ℕ) : ℝ)))) atTop (𝓝 0) := by
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity)
    ?_ bad_owner_sets_probability_vanishes
  filter_upwards [eventually_ge_atTop (2 : ℕ)] with n hn
  apply finiteProbability_mono
  intro bits hbad
  by_contra! hgood
  have hcut : 0 < largeSetThreshold n - 1 := by unfold largeSetThreshold; omega
  exact hbad ⟨good_profile_lower n hn _ hcut bits (by omega),
    (optimalFactor_le_fixedItemWorst n hn bits).trans (fixedItemWorst_upper n hn)⟩

end TwoColorNullity
