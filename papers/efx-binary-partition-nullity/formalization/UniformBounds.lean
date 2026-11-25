import InstanceBounds
import Mathlib.Data.Nat.Log

namespace TwoColorNullity

variable {n m : ℕ}

theorem balanced_allocation (hn : 0 < n) : ∃ assign : Fin m → Fin n,
    ∀ i, m / n ≤ (bundle assign i).card ∧ (bundle assign i).card ≤ m ⌈/⌉ n := by
  obtain ⟨assign, bounds⟩ := balanced_owners (Fin m) (Fin n) (by simpa using hn)
  refine ⟨assign, fun i => ?_⟩
  simpa [Fintype.card_subtype, bundle] using bounds i

theorem small_case_exact (tag : Fin n → Fin m → Bool) (hn : 0 < n) (hm : m ≤ 2 * n) :
    ∃ assign, ApproxEFX tag assign 1 := by
  obtain ⟨assign, bounds⟩ := balanced_allocation (m := m) hn
  have hfloor : m ⌈/⌉ n ≤ 2 := (ceilDiv_le_iff_le_mul hn).mpr (by simpa [Nat.mul_comm] using hm)
  refine ⟨assign, fun i j g hg => ?_⟩
  have hs := (bounds i).2.trans hfloor
  have hsize : ((bundle assign i).erase g).card ≤ 1 := by
    rw [Finset.card_erase_of_mem hg]
    omega
  rw [cost_eq_zero_of_small tag i _ hsize]
  simp only [Nat.cast_zero, one_mul]
  exact Nat.cast_nonneg _

theorem large_case_factor_two (tag : Fin n → Fin m → Bool) (hn : 0 < n) (hm : 3 * n ≤ m) :
    ∃ assign, ApproxEFX tag assign 2 := by
  obtain ⟨assign, bounds⟩ := balanced_allocation (m := m) hn
  let q := m / n
  have hq : 3 ≤ q := (Nat.le_div_iff_mul_le hn).mpr hm
  have hceil : m ⌈/⌉ n ≤ q + 1 := by
    apply (ceilDiv_le_iff_le_mul hn).mpr
    have hrem := Nat.mod_lt m hn
    have hsplit := Nat.div_add_mod m n
    change n * q + m % n = m at hsplit
    rw [Nat.mul_add, Nat.mul_one]
    omega
  refine ⟨assign, fun i j g hg => ?_⟩
  let trimmed := (bundle assign i).erase g
  have htrim_size : trimmed.card ≤ q := by
    have hi := (bounds i).2.trans hceil
    change (bundle assign i).card ≤ q + 1 at hi
    dsimp [trimmed]
    rw [Finset.card_erase_of_mem hg]
    omega
  have hnonempty : trimmed.Nonempty := by
    apply Finset.card_pos.mp
    have hi : q ≤ (bundle assign i).card := (bounds i).1
    dsimp [trimmed]
    rw [Finset.card_erase_of_mem hg]
    omega
  obtain ⟨one, hone⟩ := hnonempty
  have hseen : 1 ≤ (trimmed.image (tag i)).card :=
    Finset.card_pos.mpr ⟨tag i one, Finset.mem_image_of_mem _ hone⟩
  have hj : q ≤ (bundle assign j).card := (bounds j).1
  have hcompare := image_card_le_two tag i (bundle assign j)
  have hnat : cost tag i trimmed ≤ 2 * cost tag i (bundle assign j) := by
    unfold cost
    omega
  exact_mod_cast hnat

theorem large_divisible_case_exact (tag : Fin n → Fin m → Bool) (hn : 0 < n)
    (hm : 3 * n ≤ m) (hdiv : n ∣ m) : ∃ assign, ApproxEFX tag assign 1 := by
  obtain ⟨assign, bounds⟩ := balanced_allocation (m := m) hn
  let q := m / n
  have hq : 3 ≤ q := (Nat.le_div_iff_mul_le hn).mpr hm
  have heq : m = n * q := by
    have hsplit := Nat.div_add_mod m n
    dsimp [q]
    rw [Nat.mod_eq_zero_of_dvd hdiv, Nat.add_zero] at hsplit
    exact hsplit.symm
  have hceil : m ⌈/⌉ n ≤ q := (ceilDiv_le_iff_le_mul hn).mpr (le_of_eq heq)
  have exactLoad (i) : (bundle assign i).card = q := le_antisymm ((bounds i).2.trans hceil) (bounds i).1
  refine ⟨assign, fun i j g hg => ?_⟩
  let trimmed := (bundle assign i).erase g
  have htrim_size : trimmed.card = q - 1 := by
    dsimp [trimmed]
    rw [Finset.card_erase_of_mem hg, exactLoad i]
  obtain ⟨one, hone⟩ := Finset.card_pos.mp (show 0 < trimmed.card by omega)
  have hseen : 1 ≤ (trimmed.image (tag i)).card :=
    Finset.card_pos.mpr ⟨tag i one, Finset.mem_image_of_mem _ hone⟩
  have hcompare := image_card_le_two tag i (bundle assign j)
  have hnat : cost tag i trimmed ≤ cost tag i (bundle assign j) := by
    unfold cost
    rw [exactLoad j]
    omega
  rw [one_mul]
  exact_mod_cast hnat

theorem middle_case_factor (tag : Fin n → Fin m → Bool) (d : ℕ)
    (hd : 1 ≤ d) (hdn : d < n) (hm : m = 2 * n + d) :
    ∃ assign, ApproxEFX tag assign ((d ⌈/⌉ (d + 1).log2 : ℕ) : ℝ) := by
  have hlog1 : 1 ≤ (d + 1).log2 := (Nat.le_log2 (by omega)).mpr (by simpa using Nat.succ_le_succ hd)
  have hlogd : (d + 1).log2 ≤ d := by
    have hlt : (d + 1).log2 < d + 1 := (Nat.log2_lt (by omega)).mpr Nat.lt_two_pow_self
    omega
  have hlogn : (d + 1).log2 ≤ (Finset.univ : Finset (Fin n)).card := by simp; omega
  obtain ⟨owners, _, hsize⟩ := Finset.exists_subset_card_eq hlogn
  have hpow : 2 ^ owners.card ≤ d + 1 := by
    rw [hsize]
    exact Nat.log2_self_le (by omega)
  have hcapacity := pairCapacity_lower tag owners
  have hpairs : n ≤ pairCapacity tag owners := by omega
  rw [← hsize]
  exact approxEFX_from_pairCapacity tag owners d hm
    (by omega) (by omega) ((Nat.sub_le _ _).trans hpairs)

theorem uniform_fixed_items_factor (tag : Fin n → Fin (3 * n - 1) → Bool) (hn : 2 ≤ n) :
    ∃ assign, ApproxEFX tag assign (((n - 1) ⌈/⌉ n.log2 : ℕ) : ℝ) := by
  have h := middle_case_factor tag (n - 1) (by omega) (by omega) (by omega)
  simpa only [show n - 1 + 1 = n by omega] using h

theorem two_agents_exact (tag : Fin 2 → Fin 5 → Bool) : ∃ assign, ApproxEFX tag assign 1 := by
  have h := uniform_fixed_items_factor tag (by decide)
  have factor : (2 - 1) ⌈/⌉ Nat.log2 2 = 1 := by decide
  simpa only [factor, Nat.cast_one] using h

def constructiveFactor (n m : ℕ) : ℕ :=
  if m ≤ 2 * n then 1 else if 3 * n ≤ m then 2 else (m - 2 * n) ⌈/⌉ (m - 2 * n + 1).log2

theorem constructiveFactor_spec (tag : Fin n → Fin m → Bool) (hn : 2 ≤ n) :
    ∃ assign, ApproxEFX tag assign (constructiveFactor n m : ℝ) := by
  unfold constructiveFactor
  split
  · rename_i hm
    simpa using small_case_exact tag (by omega) hm
  · rename_i hlarge
    split
    · rename_i hm
      simpa using large_case_factor_two tag (by omega) hm
    · rename_i hsmall
      exact middle_case_factor tag (m - 2 * n) (by omega) (by omega) (by omega)

end TwoColorNullity
