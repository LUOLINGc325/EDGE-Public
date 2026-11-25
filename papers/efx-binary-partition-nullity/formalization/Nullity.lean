import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Finset.Card
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Push
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

open scoped BigOperators

namespace TwoColorNullity

variable {n m : ℕ}

def bundle (x : Fin m → Fin n) (i : Fin n) : Finset (Fin m) :=
  Finset.univ.filter fun g => x g = i

def cost (tag : Fin n → Fin m → Bool) (i : Fin n) (s : Finset (Fin m)) : ℕ :=
  s.card - (s.image (tag i)).card

def ApproxEFX (tag : Fin n → Fin m → Bool) (x : Fin m → Fin n) (a : ℝ) : Prop :=
  ∀ i j, ∀ g ∈ bundle x i,
    (cost tag i ((bundle x i).erase g) : ℝ) ≤ a * cost tag i (bundle x j)

theorem image_card_le_two (tag : Fin n → Fin m → Bool) (i : Fin n)
    (s : Finset (Fin m)) : (s.image (tag i)).card ≤ 2 := by
  simpa using (Finset.card_le_univ (s.image (tag i)))

private theorem image_card_pos (tag : Fin n → Fin m → Bool) (i : Fin n)
    (s : Finset (Fin m)) (hs : 0 < s.card) : 0 < (s.image (tag i)).card := by
  obtain ⟨g, hg⟩ := Finset.card_pos.mp hs
  exact Finset.card_pos.mpr ⟨tag i g, Finset.mem_image_of_mem _ hg⟩

theorem cost_eq_zero_of_small (tag : Fin n → Fin m → Bool) (i : Fin n)
    (s : Finset (Fin m)) (hs : s.card ≤ 1) : cost tag i s = 0 := by
  unfold cost
  by_cases hz : s.card = 0
  · simp [hz]
  · have h := image_card_pos tag i s (by omega)
    omega

private theorem positive_trim (tag : Fin n → Fin m → Bool) (i : Fin n)
    (s : Finset (Fin m)) (hs : 3 ≤ s.card) :
    ∃ g ∈ s, 0 < cost tag i (s.erase g) := by
  classical
  have hni : ¬Set.InjOn (tag i) (↑s : Set (Fin m)) := by
    intro hi
    have hCard := Finset.card_image_of_injOn hi
    have hTwo := image_card_le_two tag i s
    omega
  unfold Set.InjOn at hni
  push_neg at hni
  obtain ⟨p, hp, q, hq, hpq, hpne⟩ := hni
  have hex : ∃ g ∈ s, g ∉ ({p, q} : Finset (Fin m)) := by
    by_contra h
    push_neg at h
    have hc := Finset.card_le_card (show s ⊆ {p, q} from h)
    simp [hpne] at hc
    omega
  obtain ⟨g, hg, hgpq⟩ := hex
  have hCard := Finset.card_erase_of_mem hg
  by_cases hbig : 4 ≤ s.card
  · exact ⟨g, hg, by have hb := image_card_le_two tag i (s.erase g); unfold cost; omega⟩
  · have heq : ({p, q} : Finset (Fin m)) = s.erase g := by
      apply Finset.eq_of_subset_of_card_le
      · intro u hu
        apply Finset.mem_erase.mpr
        refine ⟨fun he => hgpq (he ▸ hu), ?_⟩
        rcases Finset.mem_insert.mp hu with rfl | hu
        · exact hp
        · simpa only [Finset.mem_singleton.mp hu] using hq
      · simp [hpne]
        omega
    exact ⟨g, hg, by simp [← heq, cost, hpne, hpq]⟩

/-- A finite approximation cannot have a bundle of size zero or one
if some bundle has at least three chores. -/
theorem no_small_bundle (tag : Fin n → Fin m → Bool) (x : Fin m → Fin n) (a : ℝ)
    (h : ApproxEFX tag x a) (i : Fin n) (hi : 3 ≤ (bundle x i).card) :
    ∀ j, 2 ≤ (bundle x j).card := by
  intro j
  by_contra hj
  have hsmall : (bundle x j).card ≤ 1 := by omega
  obtain ⟨g, hg, hcost⟩ := positive_trim tag i (bundle x i) hi
  have hc := h i j g hg
  rw [cost_eq_zero_of_small tag i _ hsmall] at hc
  simp at hc
  exact (Nat.ne_of_gt hcost) hc

/-- Every owner of a large bundle incurs cost one on every pair bundle. -/
theorem pair_cost_one (tag : Fin n → Fin m → Bool) (x : Fin m → Fin n) (a : ℝ)
    (h : ApproxEFX tag x a) (i j : Fin n)
    (hi : 3 ≤ (bundle x i).card) (hj : (bundle x j).card = 2) :
    cost tag i (bundle x j) = 1 := by
  obtain ⟨g, hg, hcost⟩ := positive_trim tag i (bundle x i) hi
  have hc := h i j g hg
  have hpos : 0 < cost tag i (bundle x j) := by
    by_contra hne
    have hz : cost tag i (bundle x j) = 0 := by omega
    rw [hz] at hc
    simp at hc
    exact (Nat.ne_of_gt hcost) hc
  have hcard := image_card_pos tag i (bundle x j) (by omega)
  unfold cost at *
  omega

/-- Large bundles have size at most a + 3 when a pair bundle exists. -/
theorem large_bundle_bound (tag : Fin n → Fin m → Bool) (x : Fin m → Fin n) (a : ℝ)
    (h : ApproxEFX tag x a) (i j : Fin n)
    (hi : 3 ≤ (bundle x i).card) (hj : (bundle x j).card = 2) :
    ((bundle x i).card : ℝ) ≤ a + 3 := by
  obtain ⟨g, hg⟩ := Finset.card_pos.mp (show 0 < (bundle x i).card by omega)
  have hc := h i j g hg
  rw [pair_cost_one tag x a h i j hi hj] at hc
  simp only [Nat.cast_one, mul_one] at hc
  have hb := image_card_le_two tag i ((bundle x i).erase g)
  have hn : (bundle x i).card ≤ cost tag i ((bundle x i).erase g) + 3 := by
    unfold cost
    have hr := Finset.card_erase_of_mem hg
    omega
  have hr : ((bundle x i).card : ℝ) ≤ (cost tag i ((bundle x i).erase g) : ℝ) + 3 := by
    exact_mod_cast hn
  exact hr.trans (add_le_add_right hc _)

theorem bundle_card_sum (x : Fin m → Fin n) : (∑ i, (bundle x i).card) = m := by
  classical
  have h := Finset.card_eq_sum_card_fiberwise (s := Finset.univ)
    (t := Finset.univ) (f := x) (fun _ _ => Finset.mem_univ (x _))
  simpa [bundle] using h.symm

/-- On 3n-1 chores, every finite-approximation allocation has size-two
bundles, and the excess n-1 is bounded by the number of large bundles
times a + 1. -/
theorem excess_bound (tag : Fin n → Fin (3*n-1) → Bool)
    (x : Fin (3*n-1) → Fin n) (a : ℝ) (hn : 2 ≤ n)
    (h : ApproxEFX tag x a) :
    (n : ℝ) - 1 ≤ ((Finset.univ.filter fun i => 3 ≤ (bundle x i).card).card : ℝ) * (a + 1) := by
  classical
  have hsum := bundle_card_sum x
  have hlarge : ∃ i, 3 ≤ (bundle x i).card := by
    by_contra he
    push_neg at he
    have hu : (∑ i, (bundle x i).card) ≤ ∑ _ : Fin n, (2 : ℕ) :=
      Finset.sum_le_sum fun i _ => by have hlt := he i; omega
    simp [hsum] at hu
    omega
  obtain ⟨i, hi⟩ := hlarge
  have hall := no_small_bundle tag x a h i hi
  have hpair : ∃ j, (bundle x j).card = 2 := by
    by_contra he
    push_neg at he
    have hl : (∑ _ : Fin n, (3 : ℕ)) ≤ ∑ j, (bundle x j).card :=
      Finset.sum_le_sum fun j _ => by have ha := hall j; have hb := he j; omega
    simp [hsum] at hl
    omega
  obtain ⟨j, hj⟩ := hpair
  have hp (i : Fin n) : ((bundle x i).card : ℝ) - 2 ≤
      (if 3 ≤ (bundle x i).card then a + 1 else 0) := by
    split
    · rename_i hbig
      have hb := large_bundle_bound tag x a h i j hbig hj
      linarith
    · rename_i hsmall
      have he : (bundle x i).card = 2 := by have hh := hall i; omega
      simp [he]
  have ht := Finset.sum_le_sum (fun i (_ : i ∈ Finset.univ) => hp i)
  rw [Finset.sum_sub_distrib, ← Finset.sum_filter] at ht
  have hcast : (∑ i, ((bundle x i).card : ℝ)) = (3 * (n : ℝ) - 1) := by
    rw [← Nat.cast_sum, hsum, Nat.cast_sub (by omega)]
    simp
  rw [hcast] at ht
  simp [nsmul_eq_mul] at ht
  linarith

/-- Pair-cost one is equivalent to agreement of every item pair
on the observer's coordinate. -/
theorem pair_cost_one_iff (tag : Fin n → Fin m → Bool) (i : Fin n)
    (s : Finset (Fin m)) (hs : s.card = 2) :
    cost tag i s = 1 ↔ ∀ g ∈ s, ∀ h ∈ s, tag i g = tag i h := by
  have hpos := image_card_pos tag i s (by omega)
  have hb := image_card_le_two tag i s
  constructor
  · intro hc g hg h hh
    have hle : (s.image (tag i)).card ≤ 1 := by unfold cost at hc; omega
    exact Finset.card_le_one.mp hle _ (Finset.mem_image_of_mem _ hg) _
      (Finset.mem_image_of_mem _ hh)
  · intro he
    have hle : (s.image (tag i)).card ≤ 1 := by
      apply Finset.card_le_one.mpr
      intro a ha b hb
      obtain ⟨g, hg, rfl⟩ := Finset.mem_image.mp ha
      obtain ⟨h, hh, rfl⟩ := Finset.mem_image.mp hb
      exact he g hg h hh
    unfold cost
    omega

/-- The projected pairing and balanced size conditions imply approximate EFX. -/
theorem approxEFX_of_projected_pairing (tag : Fin n → Fin m → Bool)
    (x : Fin m → Fin n) (a : ℕ)
    (hmin : ∀ j, 2 ≤ (bundle x j).card)
    (hmax : ∀ i, (bundle x i).card ≤ a + 2)
    (agreement : ∀ i j, 3 ≤ (bundle x i).card → (bundle x j).card = 2 →
      ∀ g ∈ bundle x j, ∀ h ∈ bundle x j, tag i g = tag i h) :
    ApproxEFX tag x a := by
  intro i j g hg
  have hcard := Finset.card_erase_of_mem hg
  by_cases hi : (bundle x i).card = 2
  · rw [cost_eq_zero_of_small tag i _ (by omega)]
    exact_mod_cast (Nat.zero_le (a * cost tag i (bundle x j)))
  · have hbig : 3 ≤ (bundle x i).card := by have h := hmin i; omega
    have hpos : 0 < cost tag i (bundle x j) := by
      by_cases hj : (bundle x j).card = 2
      · rw [(pair_cost_one_iff tag i _ hj).mpr (agreement i j hbig hj)]
        decide
      · have hh := image_card_le_two tag i (bundle x j)
        have h := hmin j
        unfold cost
        omega
    have htrim : cost tag i ((bundle x i).erase g) ≤ a := by
      have hh := image_card_pos tag i ((bundle x i).erase g) (by omega)
      have hm := hmax i
      unfold cost
      omega
    have hc : cost tag i ((bundle x i).erase g) ≤
        a * cost tag i (bundle x j) := by
      exact htrim.trans (by simpa using Nat.mul_le_mul_left a hpos)
    exact_mod_cast hc

/-- For a feasible allocation with a pair bundle and all bundles of size
at least two, the sharp multiplicative factor is integral: any real factor
strictly below k+1 can be rounded down to k. -/
theorem approxEFX_round_down_of_pair (tag : Fin n → Fin m → Bool)
    (x : Fin m → Fin n) (a : ℝ) (k : ℕ)
    (h : ApproxEFX tag x a) (ha : a < (k : ℝ) + 1)
    (hmin : ∀ j, 2 ≤ (bundle x j).card)
    (hpair : ∃ j, (bundle x j).card = 2) :
    ApproxEFX tag x k := by
  obtain ⟨q, hq⟩ := hpair
  intro i j g hg
  have hcard := Finset.card_erase_of_mem hg
  by_cases hi : (bundle x i).card = 2
  · rw [cost_eq_zero_of_small tag i _ (by omega)]
    exact_mod_cast (Nat.zero_le (k * cost tag i (bundle x j)))
  · have hbig : 3 ≤ (bundle x i).card := by have h := hmin i; omega
    have hpos : 0 < cost tag i (bundle x j) := by
      by_cases hj : (bundle x j).card = 2
      · rw [pair_cost_one tag x a h i j hbig hj]
        decide
      · have hh := image_card_le_two tag i (bundle x j)
        have h := hmin j
        unfold cost
        omega
    have ht := h i q g hg
    rw [pair_cost_one tag x a h i q hbig hq] at ht
    simp only [Nat.cast_one, mul_one] at ht
    have hlt : cost tag i ((bundle x i).erase g) < k + 1 := by
      exact_mod_cast ht.trans_lt ha
    have hc : cost tag i ((bundle x i).erase g) ≤ k * cost tag i (bundle x j) := by
      have hk : cost tag i ((bundle x i).erase g) ≤ k := by omega
      exact hk.trans (by simpa using Nat.mul_le_mul_left k hpos)
    exact_mod_cast hc

#print axioms no_small_bundle
#print axioms pair_cost_one
#print axioms large_bundle_bound
#print axioms excess_bound
#print axioms pair_cost_one_iff
#print axioms approxEFX_of_projected_pairing
#print axioms approxEFX_round_down_of_pair

end TwoColorNullity
