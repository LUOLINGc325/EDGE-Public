import UniformBounds
import Mathlib.Order.ConditionallyCompleteLattice.Basic

namespace TwoColorNullity

variable {n m : ℕ}

def ZeroComparisonsValid (tag : Fin n → Fin m → Bool) (assign : Fin m → Fin n) : Prop :=
  ∀ i j, ∀ g ∈ bundle assign i, cost tag i (bundle assign j) = 0 →
    cost tag i ((bundle assign i).erase g) = 0

noncomputable def comparedRatio (tag : Fin n → Fin m → Bool) (assign : Fin m → Fin n)
    (index : Fin n × Fin n × Fin m) : ℝ := by
  classical
  exact if index.2.2 ∈ bundle assign index.1 then
    (cost tag index.1 ((bundle assign index.1).erase index.2.2) : ℝ) /
      (cost tag index.1 (bundle assign index.2.1) : ℝ)
  else 0

noncomputable def comparedRatios (tag : Fin n → Fin m → Bool) (assign : Fin m → Fin n) : Finset ℝ := by
  classical
  exact insert 1 (Finset.univ.image (comparedRatio tag assign))

noncomputable def factorOfAllocation (tag : Fin n → Fin m → Bool) (assign : Fin m → Fin n) : ℝ :=
  (comparedRatios tag assign).max' (by
    classical
    simp [comparedRatios])

theorem one_le_factorOfAllocation (tag : Fin n → Fin m → Bool) (assign : Fin m → Fin n) :
    1 ≤ factorOfAllocation tag assign := by
  classical
  apply Finset.le_max'
  simp [comparedRatios]

theorem factorOfAllocation_iff (tag : Fin n → Fin m → Bool) (assign : Fin m → Fin n) (a : ℝ)
    (ha : 1 ≤ a) : ApproxEFX tag assign a ↔
      ZeroComparisonsValid tag assign ∧ factorOfAllocation tag assign ≤ a := by
  classical
  constructor
  · intro h
    refine ⟨?_, ?_⟩
    · intro i j g hg hzero
      have hle := h i j g hg
      simpa [hzero] using hle
    · unfold factorOfAllocation
      apply Finset.max'_le
      intro ratio hr
      change ratio ∈ insert 1 (Finset.univ.image (comparedRatio tag assign)) at hr
      rcases Finset.mem_insert.mp hr with he | he
      · simpa [he] using ha
      · obtain ⟨⟨i, j, g⟩, _, rfl⟩ := Finset.mem_image.mp he
        by_cases hg : g ∈ bundle assign i
        · simp only [comparedRatio, hg, if_pos]
          by_cases hz : cost tag i (bundle assign j) = 0
          · simp [hz, show 0 ≤ a by linarith]
          · have hpos : (0 : ℝ) < cost tag i (bundle assign j) := by exact_mod_cast Nat.pos_of_ne_zero hz
            exact (div_le_iff₀ hpos).mpr (h i j g hg)
        · simp [comparedRatio, hg, show 0 ≤ a by linarith]
  · rintro ⟨valid, threshold⟩ i j g hg
    by_cases hz : cost tag i (bundle assign j) = 0
    · simp [hz, valid i j g hg hz]
    · have hpos : (0 : ℝ) < cost tag i (bundle assign j) := by exact_mod_cast Nat.pos_of_ne_zero hz
      have hmem : comparedRatio tag assign (i, j, g) ∈ comparedRatios tag assign := by simp [comparedRatios]
      have hle : comparedRatio tag assign (i, j, g) ≤ factorOfAllocation tag assign := Finset.le_max' _ _ hmem
      apply (div_le_iff₀ hpos).mp
      simpa [comparedRatio, hg] using hle.trans threshold

noncomputable def validAllocations (tag : Fin n → Fin m → Bool) : Finset (Fin m → Fin n) := by
  classical
  exact Finset.univ.filter (ZeroComparisonsValid tag)

/-- The real-valued optimum over all complete allocations. -/
noncomputable def optimalFactor (tag : Fin n → Fin m → Bool) : ℝ :=
  sInf {a | 1 ≤ a ∧ ∃ assign : Fin m → Fin n, ApproxEFX tag assign a}

theorem constructiveFactor_pos (n m : ℕ) : 1 ≤ constructiveFactor n m := by
  unfold constructiveFactor
  split
  · omega
  · split
    · omega
    · rename_i hgreater hless
      let d := m - 2 * n
      have hd : 0 < d := by dsimp [d]; omega
      have hlog : 0 < (d + 1).log2 := (Nat.le_log2 (by omega)).mpr (by omega)
      have positive : d ≤ (d + 1).log2 * (d ⌈/⌉ (d + 1).log2) :=
        (ceilDiv_le_iff_le_mul hlog).mp le_rfl
      change 1 ≤ d ⌈/⌉ (d + 1).log2
      by_contra hzero
      have hz : d ⌈/⌉ (d + 1).log2 = 0 := by omega
      rw [hz, Nat.mul_zero] at positive
      omega

theorem optimalFactor_attained (tag : Fin n → Fin m → Bool) (hn : 2 ≤ n) :
    1 ≤ optimalFactor tag ∧ ∃ assign, ApproxEFX tag assign (optimalFactor tag) := by
  classical
  let candidates := (validAllocations tag).image (factorOfAllocation tag)
  obtain ⟨assign0, valid0⟩ := constructiveFactor_spec tag hn
  have hfactor : (1 : ℝ) ≤ (constructiveFactor n m : ℕ) := by
    exact_mod_cast constructiveFactor_pos n m
  have hz : ZeroComparisonsValid tag assign0 := ((factorOfAllocation_iff _ _ _ hfactor).mp valid0).1
  have nonempty : candidates.Nonempty :=
    ⟨factorOfAllocation tag assign0, Finset.mem_image.mpr ⟨assign0, by simp [validAllocations, hz], rfl⟩⟩
  let least := candidates.min' nonempty
  obtain ⟨assign, hmem, hall⟩ := Finset.mem_image.mp (Finset.min'_mem candidates nonempty)
  have hvalid : ZeroComparisonsValid tag assign := by simpa [validAllocations] using hmem
  have hleast : 1 ≤ least := (one_le_factorOfAllocation tag assign).trans hall.le
  have hfeasible : ApproxEFX tag assign least := (factorOfAllocation_iff _ _ _ hleast).mpr ⟨hvalid, hall.le⟩
  have helper : IsLeast {a | 1 ≤ a ∧ ∃ assign : Fin m → Fin n, ApproxEFX tag assign a} least := by
    refine ⟨⟨hleast, assign, hfeasible⟩, ?_⟩
    intro a ha
    obtain ⟨hpos, witness, hwitness⟩ := ha
    obtain ⟨hzero, hbound⟩ := (factorOfAllocation_iff _ _ _ hpos).mp hwitness
    exact (candidates.min'_le _ (Finset.mem_image.mpr ⟨witness, by simp [validAllocations, hzero], rfl⟩)).trans hbound
  have heq : optimalFactor tag = least := helper.isGLB.csInf_eq ⟨least, helper.1⟩
  rw [heq]
  exact ⟨hleast, assign, hfeasible⟩

theorem optimalFactor_le (tag : Fin n → Fin m → Bool) (a : ℝ) (ha : 1 ≤ a)
    {assign : Fin m → Fin n} (h : ApproxEFX tag assign a) : optimalFactor tag ≤ a := by
  apply csInf_le
  · exact ⟨1, fun x hx => hx.1⟩
  · exact ⟨ha, assign, h⟩

theorem optimal_fixed_scope_integer (tag : Fin n → Fin (3 * n - 1) → Bool) (hn : 2 ≤ n) :
    ∃ k : ℕ, 1 ≤ k ∧ optimalFactor tag = k := by
  obtain ⟨ha, assign, h⟩ := optimalFactor_attained tag hn
  obtain ⟨hmin, _, hpair⟩ := finiteEFX_bundle_sizes tag assign hn _ h
  let k := ⌊optimalFactor tag⌋₊
  have hk : 1 ≤ k := (Nat.le_floor_iff (by linarith)).mpr (by simpa using ha)
  have hround := approxEFX_round_down_of_pair tag assign _ k h (Nat.lt_floor_add_one _) hmin hpair
  exact ⟨k, hk, le_antisymm (optimalFactor_le tag k (by exact_mod_cast hk) hround) (Nat.floor_le (by linarith))⟩

theorem optimalFactor_within_one (tag : Fin n → Fin (3 * n - 1) → Bool) (hn : 2 ≤ n) :
    ((max 1 ((n - 1) ⌈/⌉ maximumFeasibleOwners tag - 1) : ℕ) : ℝ) ≤ optimalFactor tag ∧
      optimalFactor tag ≤ ((n - 1) ⌈/⌉ maximumFeasibleOwners tag : ℕ) := by
  obtain ⟨ha, assign, h⟩ := optimalFactor_attained tag hn
  obtain ⟨k, hk, heq⟩ := optimal_fixed_scope_integer tag hn
  refine ⟨?_, ?_⟩
  · rw [heq] at h ⊢
    exact_mod_cast instance_factor_lower tag assign hn k hk h
  · obtain ⟨assign, bound⟩ := instance_factor_upper tag hn
    obtain ⟨owners, ⟨hpos, hlt, _⟩, hcard⟩ := maximumFeasibleOwners_attained tag hn
    have hpos' : 0 < maximumFeasibleOwners tag := by simpa [hcard] using hpos
    have hcover := (ceilDiv_le_iff_le_mul hpos').mp
      (le_refl ((n - 1) ⌈/⌉ maximumFeasibleOwners tag))
    have hb : 1 ≤ (n - 1) ⌈/⌉ maximumFeasibleOwners tag := by
      by_contra! hbad
      have hz : (n - 1) ⌈/⌉ maximumFeasibleOwners tag = 0 := by omega
      rw [hz, Nat.mul_zero] at hcover
      omega
    exact optimalFactor_le tag _ (by exact_mod_cast hb) bound

theorem two_agents_maximum_feasible (tag : Fin 2 → Fin 5 → Bool) : maximumFeasibleOwners tag = 1 := by
  obtain ⟨owners, ho, heq⟩ := maximumFeasibleOwners_attained tag (by decide)
  have hp := ho.1
  have ht := ho.2.1
  rw [heq]
  omega

end TwoColorNullity
