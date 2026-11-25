import ProjectedAllocation
import Mathlib.Data.Fintype.Powerset
import Mathlib.Data.Real.Archimedean

open scoped BigOperators

namespace TwoColorNullity

variable {n m : ℕ}

def largeOwners (assign : Fin m → Fin n) : Finset (Fin n) :=
  Finset.univ.filter fun i => 3 ≤ (bundle assign i).card

@[simp] theorem mem_largeOwners {assign : Fin m → Fin n} {i : Fin n} :
    i ∈ largeOwners assign ↔ 3 ≤ (bundle assign i).card := by
  simp [largeOwners]

theorem finiteEFX_bundle_sizes (tag : Fin n → Fin (3 * n - 1) → Bool)
    (assign : Fin (3 * n - 1) → Fin n) (hn : 2 ≤ n) (a : ℝ) (h : ApproxEFX tag assign a) :
    (∀ i, 2 ≤ (bundle assign i).card) ∧ (largeOwners assign).Nonempty ∧
      ∃ j, (bundle assign j).card = 2 := by
  have totals := bundle_card_sum assign
  have hlarge : ∃ j, 3 ≤ (bundle assign j).card := by
    by_contra hnone
    push_neg at hnone
    have loads : (∑ i, (bundle assign i).card) ≤ ∑ _ : Fin n, (2 : ℕ) :=
      Finset.sum_le_sum fun j _ => by have hlt := hnone j; omega
    simp [totals] at loads
    omega
  obtain ⟨i, hi⟩ := hlarge
  have hmin := no_small_bundle tag assign a h i hi
  refine ⟨hmin, ⟨i, mem_largeOwners.mpr hi⟩, ?_⟩
  by_contra hnone
  push_neg at hnone
  have loads : (∑ _ : Fin n, (3 : ℕ)) ≤ ∑ i, (bundle assign i).card :=
    Finset.sum_le_sum fun j _ => by have := hmin j; have := hnone j; omega
  simp [totals] at loads
  omega

def trimmedMaximum (tag : Fin n → Fin m → Bool) (assign : Fin m → Fin n) : ℕ :=
  max 1 (Finset.univ.sup fun i => (bundle assign i).sup fun g => cost tag i ((bundle assign i).erase g))

/-- Under the pair agreement condition the least factor is an integer. -/
theorem least_factor_with_pairs (tag : Fin n → Fin m → Bool) (assign : Fin m → Fin n) (a : ℝ)
    (ha : 1 ≤ a) (hmin : ∀ i, 2 ≤ (bundle assign i).card)
    (hpair : ∃ j, (bundle assign j).card = 2)
    (hagrees : ∀ i ∈ largeOwners assign, ∀ j, (bundle assign j).card = 2 →
      ∀ g ∈ bundle assign j, ∀ h ∈ bundle assign j, tag i g = tag i h) :
    ApproxEFX tag assign a ↔ (trimmedMaximum tag assign : ℝ) ≤ a := by
  obtain ⟨j, hj⟩ := hpair
  have pair_cost (i : Fin n) (hi : i ∈ largeOwners assign) (p : Fin n)
      (hp : (bundle assign p).card = 2) : cost tag i (bundle assign p) = 1 :=
    (pair_cost_one_iff tag i _ hp).mpr (hagrees i hi p hp)
  have small_trim (i : Fin n) (hi : i ∉ largeOwners assign) (g : Fin m) (hg : g ∈ bundle assign i) :
      cost tag i ((bundle assign i).erase g) = 0 := by
    apply cost_eq_zero_of_small
    rw [Finset.card_erase_of_mem hg]
    rw [mem_largeOwners] at hi
    omega
  constructor
  · intro h
    have htrim (i : Fin n) (g : Fin m) (hg : g ∈ bundle assign i) :
        (cost tag i ((bundle assign i).erase g) : ℝ) ≤ a := by
      by_cases hi : i ∈ largeOwners assign
      · simpa [pair_cost i hi j hj] using h i j g hg
      · simpa [small_trim i hi g hg] using (show 0 ≤ a by linarith)
    unfold trimmedMaximum
    rw [Nat.cast_max, Nat.cast_one, max_le_iff]
    refine ⟨ha, ?_⟩
    have hs : (Finset.univ.sup fun i => (bundle assign i).sup
        fun g => cost tag i ((bundle assign i).erase g)) ≤ ⌊a⌋₊ := by
      apply Finset.sup_le
      intro i _
      apply Finset.sup_le
      intro g hg
      exact (Nat.le_floor_iff (by linarith)).mpr (htrim i g hg)
    have hcast : (((Finset.univ.sup fun i => (bundle assign i).sup
        fun g => cost tag i ((bundle assign i).erase g)) : ℕ) : ℝ) ≤ (⌊a⌋₊ : ℝ) := by exact_mod_cast hs
    exact hcast.trans (Nat.floor_le (by linarith))
  · intro h i p g hg
    by_cases hi : i ∈ largeOwners assign
    · have htrim : cost tag i ((bundle assign i).erase g) ≤ trimmedMaximum tag assign := by
        unfold trimmedMaximum
        apply le_trans _ (le_max_right _ _)
        apply le_trans (Finset.le_sup (f := fun item => cost tag i ((bundle assign i).erase item)) hg)
        exact Finset.le_sup (s := Finset.univ) (f := fun observer : Fin n =>
          (bundle assign observer).sup fun item => cost tag observer ((bundle assign observer).erase item))
          (Finset.mem_univ i)
      have hpos : (1 : ℕ) ≤ cost tag i (bundle assign p) := by
        by_cases hp : (bundle assign p).card = 2
        · simp [pair_cost i hi p hp]
        · have hb := image_card_le_two tag i (bundle assign p)
          have := hmin p
          unfold cost
          omega
      have hmul : a ≤ a * cost tag i (bundle assign p) := by
        simpa using mul_le_mul_of_nonneg_left (show (1 : ℝ) ≤ cost tag i (bundle assign p) by exact_mod_cast hpos)
          (show 0 ≤ a by linarith)
      have hcast : (cost tag i ((bundle assign i).erase g) : ℝ) ≤ (trimmedMaximum tag assign : ℝ) := by
        exact_mod_cast htrim
      exact (hcast.trans h).trans hmul
    · rw [small_trim i hi g hg]
      simp only [Nat.cast_zero]
      exact mul_nonneg (show 0 ≤ a by linarith) (Nat.cast_nonneg _)

def FeasibleOwners (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n)) : Prop :=
  0 < owners.card ∧ owners.card < n ∧ n - owners.card ≤ pairCapacity tag owners

noncomputable def feasibleOwnerSets (tag : Fin n → Fin m → Bool) : Finset (Finset (Fin n)) := by
  classical
  exact Finset.univ.filter (FeasibleOwners tag)

@[simp] theorem mem_feasibleOwnerSets (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n)) :
    owners ∈ feasibleOwnerSets tag ↔ FeasibleOwners tag owners := by
  classical
  simp [feasibleOwnerSets]

noncomputable def maximumFeasibleOwners (tag : Fin n → Fin m → Bool) : ℕ :=
  (feasibleOwnerSets tag).sup Finset.card

theorem feasibleOwnerSets_nonempty (tag : Fin n → Fin (3 * n - 1) → Bool) (hn : 2 ≤ n) :
    (feasibleOwnerSets tag).Nonempty := by
  let i : Fin n := ⟨0, by omega⟩
  have lower := pairCapacity_lower tag {i}
  simp only [Finset.card_singleton, pow_one] at lower
  refine ⟨{i}, (mem_feasibleOwnerSets _ _).mpr ?_⟩
  unfold FeasibleOwners
  rw [Finset.card_singleton]
  omega

theorem maximumFeasibleOwners_attained (tag : Fin n → Fin (3 * n - 1) → Bool) (hn : 2 ≤ n) :
    ∃ owners, FeasibleOwners tag owners ∧ maximumFeasibleOwners tag = owners.card := by
  obtain ⟨owners, hmem, hcard⟩ := Finset.exists_mem_eq_sup _ (feasibleOwnerSets_nonempty tag hn) Finset.card
  exact ⟨owners, (mem_feasibleOwnerSets _ _).mp hmem, hcard⟩

theorem FeasibleOwners.le_maximum {tag : Fin n → Fin m → Bool} {owners : Finset (Fin n)}
    (h : FeasibleOwners tag owners) : owners.card ≤ maximumFeasibleOwners tag :=
  Finset.le_sup ((mem_feasibleOwnerSets _ _).mpr h)

theorem feasibleOwners_from_allocation (tag : Fin n → Fin (3 * n - 1) → Bool)
    (assign : Fin (3 * n - 1) → Fin n) (hn : 2 ≤ n) (a : ℝ) (h : ApproxEFX tag assign a) :
    FeasibleOwners tag (largeOwners assign) := by
  classical
  obtain ⟨hmin, hlarge, j, hj⟩ := finiteEFX_bundle_sizes tag assign hn a h
  let owners := largeOwners assign
  let outside := ownersᶜ
  have small (i : Fin n) (hi : i ∈ outside) : (bundle assign i).card = 2 := by
    have hnot : i ∉ owners := Finset.mem_compl.mp hi
    have hlt : ¬ 3 ≤ (bundle assign i).card := fun hg => hnot (mem_largeOwners.mpr hg)
    have hb := hmin i
    omega
  let pairs := outside.image (bundle assign)
  have separate {i j : Fin n} (hne : i ≠ j) : Disjoint (bundle assign i) (bundle assign j) := by
    refine Finset.disjoint_left.mpr fun g gi gj => ?_
    exact hne ((mem_bundle_iff.mp gi).symm.trans (mem_bundle_iff.mp gj))
  have disjoint_pack : PairPacking (signature tag owners) Finset.univ pairs := by
    refine ⟨?_, fun p _ => p.subset_univ, ?_, ?_⟩
    · intro p hp
      obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp hp
      exact small i hi
    · intro p hp g hg t ht
      obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp hp
      funext j
      apply (pair_cost_one_iff tag j.val (bundle assign i) (small i hi)).mp _ g hg t ht
      exact pair_cost_one tag assign a h j.val i (mem_largeOwners.mp j.property) (small i hi)
    · intro p hp q hq hpq
      obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp hp
      obtain ⟨j, _, rfl⟩ := Finset.mem_image.mp hq
      exact separate fun he => hpq (congrArg (bundle assign) he)
  have hcard : pairs.card = outside.card := by
    apply Finset.card_image_of_injOn
    intro i hi j hj he
    by_contra hne
    obtain ⟨g, hg⟩ := Finset.card_pos.mp (show 0 < (bundle assign i).card by rw [small i hi]; decide)
    exact Finset.disjoint_left.mp (separate hne) hg (he ▸ hg)
  have hpool : n - owners.card ≤ pairCapacity tag owners := by
    simpa only [pairCapacity, hcard, outside, Finset.card_compl, Fintype.card_fin] using disjoint_pack.card_le
  have hlt : owners.card < n := by
    have hnmem : j ∉ owners := fun hmem => by have h := mem_largeOwners.mp hmem; omega
    have hsubset : owners ⊂ (Finset.univ : Finset (Fin n)) :=
      Finset.ssubset_iff_subset_ne.mpr ⟨owners.subset_univ, fun he => hnmem (he.symm ▸ Finset.mem_univ j)⟩
    simpa using Finset.card_lt_card hsubset
  exact ⟨Finset.card_pos.mpr hlarge, hlt, hpool⟩

theorem instance_factor_upper (tag : Fin n → Fin (3 * n - 1) → Bool) (hn : 2 ≤ n) :
    ∃ assign, ApproxEFX tag assign (((n - 1) ⌈/⌉ maximumFeasibleOwners tag : ℕ) : ℝ) := by
  obtain ⟨owners, ⟨hpos, hlt, hpairs⟩, hcard⟩ := maximumFeasibleOwners_attained tag hn
  rw [hcard]
  exact approxEFX_from_pairCapacity tag owners (n - 1) (by omega) hpos (by omega) hpairs

theorem instance_factor_lower (tag : Fin n → Fin (3 * n - 1) → Bool)
    (assign : Fin (3 * n - 1) → Fin n) (hn : 2 ≤ n) (k : ℕ) (hk : 1 ≤ k)
    (h : ApproxEFX tag assign (k : ℝ)) : max 1 ((n - 1) ⌈/⌉ maximumFeasibleOwners tag - 1) ≤ k := by
  have row := feasibleOwners_from_allocation tag assign hn k h
  have hmax := row.le_maximum
  have hpos : 0 < maximumFeasibleOwners tag := row.1.trans_le hmax
  have hexcess := excess_bound tag assign k hn h
  change (n : ℝ) - 1 ≤ ((largeOwners assign).card : ℝ) * ((k : ℝ) + 1) at hexcess
  rw [← Nat.cast_one (R := ℝ), ← Nat.cast_sub (by omega : 1 ≤ n), ← Nat.cast_add, ← Nat.cast_mul] at hexcess
  have hnat : n - 1 ≤ (largeOwners assign).card * (k + 1) := by exact_mod_cast hexcess
  have hdiv : (n - 1) ⌈/⌉ maximumFeasibleOwners tag ≤ k + 1 :=
    (ceilDiv_le_iff_le_mul hpos).mpr (hnat.trans (Nat.mul_le_mul_right _ hmax))
  exact max_le hk (by omega)

end TwoColorNullity
