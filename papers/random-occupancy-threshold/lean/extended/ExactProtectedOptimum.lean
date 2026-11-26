import ProtectedAllocation
import WorstFactor

namespace TwoColorNullity.Occupancy

theorem protected_endpoint_at_least_two (n s : ℕ) (hs : 0 < s) (hroom : 2 * s ≤ n - 1) :
    2 ≤ (n - 1) ⌈/⌉ s := by
  let q := (n - 1) ⌈/⌉ s
  have hcover : n - 1 ≤ s * q := (ceilDiv_le_iff_le_mul hs).mp le_rfl
  by_contra! hbad
  have hsmall := Nat.mul_le_mul_left s (show q ≤ 1 by omega)
  rw [Nat.mul_one] at hsmall
  omega

/-- The computed assignment attains the lower endpoint using the specified reservations. -/
theorem protected_assignment_approxEFX (tag : Fin n → Fin (3 * n - 1) → Bool)
    (owners : Finset (Fin n)) (hs : 0 < owners.card) (hroom : 2 * owners.card ≤ n - 1)
    (pairs : Finset (Finset (Fin (3 * n - 1))))
    (packing : PairPacking (signature tag owners) Finset.univ pairs)
    (hpairs : pairs.card = n - owners.card)
    (chosen : (↥owners × Bool × Fin 2) → Fin (3 * n - 1)) (hinj : Function.Injective chosen)
    (hchosen : ∀ r, chosen r ∉ usedItems pairs ∧ tag r.1.val (chosen r) = r.2.1) :
    let assign := protectedAssignment tag owners hs pairs packing hpairs chosen
    ApproxEFX tag assign ((((n - 1) ⌈/⌉ owners.card - 1 : ℕ)) : ℝ) ∧
      (∀ i ∉ owners, ∃ p ∈ pairs, bundle assign i = p) ∧
      (∀ i ∈ owners, HasTwoOfEachColor tag assign i) ∧
      (∀ r, assign (chosen r) = r.1.val) := by
  let v := (n - 1) ⌈/⌉ owners.card
  let a := v - 1
  have hcover : n - 1 ≤ owners.card * v := (ceilDiv_le_iff_le_mul hs).mp le_rfl
  have hv : 2 ≤ v := protected_endpoint_at_least_two n owners.card hs hroom
  have hrem : (n - 1 - 2 * owners.card) ⌈/⌉ owners.card ≤ v - 2 := by
    apply (ceilDiv_le_iff_le_mul hs).mpr
    rw [Nat.mul_sub, Nat.mul_comm owners.card 2]
    exact Nat.sub_le_sub_right hcover _
  let assign := protectedAssignment tag owners hs pairs packing hpairs chosen
  obtain ⟨outside, inside, reserved⟩ := protectedAssignment_spec tag owners hs pairs packing hpairs chosen hinj hchosen
  have small (i : Fin n) (hi : i ∉ owners) : (bundle assign i).card = 2 := by
    obtain ⟨pair, hp, he⟩ := outside i hi
    rw [he, packing.two pair hp]
  have hmin (i : Fin n) : 2 ≤ (bundle assign i).card := by
    by_cases hi : i ∈ owners
    · exact le_trans (by decide) (inside i hi).2.1
    · rw [small i hi]
  have hmax (i : Fin n) : (bundle assign i).card ≤ a + 3 := by
    by_cases hi : i ∈ owners
    · have h : (bundle assign i).card ≤ 4 + ((n - 1 - 2 * owners.card) ⌈/⌉ owners.card) :=
        (inside i hi).2.2
      dsimp [a]
      omega
    · rw [small i hi]
      omega
  have hprotected (i : Fin n) (hi : 3 ≤ (bundle assign i).card) :
      HasTwoOfEachColor tag assign i := by
    have hinside : i ∈ owners := by by_contra hn; have := small i hn; omega
    exact (inside i hinside).1
  have hagreed (i j : Fin n) (hi : 3 ≤ (bundle assign i).card) (hj : (bundle assign j).card = 2) :
      ∀ x ∈ bundle assign j, ∀ y ∈ bundle assign j, tag i x = tag i y := by
    have hin : i ∈ owners := by by_contra h; have := small i h; omega
    have hout : j ∉ owners := fun h => by
      have hload : 4 ≤ (bundle assign j).card := (inside j h).2.1
      omega
    obtain ⟨p, hp, he⟩ := outside j hout
    intro x hx y hy
    rw [he] at hx hy
    exact congrFun (packing.homogeneous p hp x hx y hy) ⟨i, hin⟩
  have hvalid := approxEFX_of_protected_pairs tag assign a hmin hmax hprotected hagreed
  exact ⟨hvalid, outside, fun i hi => (inside i hi).1, reserved⟩

/-- The protected construction uses the specified agreeing pairs. -/
theorem protected_pair_allocation_factor (tag : Fin n → Fin (3 * n - 1) → Bool)
    (owners : Finset (Fin n)) (hs : 0 < owners.card) (hroom : 2 * owners.card ≤ n - 1)
    (pairs : Finset (Finset (Fin (3 * n - 1))))
    (packing : PairPacking (signature tag owners) Finset.univ pairs)
    (hpairs : pairs.card = n - owners.card)
    (hcolors : ∀ owner : ↥owners, ∀ color : Bool,
      4 * owners.card ≤ restrictedOddCount
        (Finset.univ.filter fun label : ↥owners → Bool => label owner = color) (signature tag owners)) :
    ∃ assign, ApproxEFX tag assign ((((n - 1) ⌈/⌉ owners.card - 1 : ℕ)) : ℝ) ∧
      (∀ i ∉ owners, ∃ p ∈ pairs, bundle assign i = p) ∧
      (∀ i ∈ owners, HasTwoOfEachColor tag assign i) := by
  obtain ⟨chosen, hinj, hchosen⟩ := reserve_two_each_color tag owners pairs packing hcolors
  obtain ⟨hvalid, outside, inside, _⟩ :=
    protected_assignment_approxEFX tag owners hs hroom pairs packing hpairs chosen hinj hchosen
  exact ⟨protectedAssignment tag owners hs pairs packing hpairs chosen, hvalid, outside, inside⟩

/-- Enough unused representatives of both colors attain the lower endpoint of the instance bound. -/
theorem optimum_eq_lower_endpoint (tag : Fin n → Fin (3 * n - 1) → Bool) (hn : 2 ≤ n)
    (owners : Finset (Fin n)) (hfeasible : FeasibleOwners tag owners)
    (hmaximum : owners.card = maximumFeasibleOwners tag) (hroom : 2 * owners.card ≤ n - 1)
    (hcolors : ∀ owner : ↥owners, ∀ color : Bool,
      4 * owners.card ≤ restrictedOddCount
        (Finset.univ.filter fun label : ↥owners → Bool => label owner = color) (signature tag owners)) :
    optimalFactor tag = (((n - 1) ⌈/⌉ maximumFeasibleOwners tag - 1 : ℕ) : ℝ) := by
  classical
  let a := (n - 1) ⌈/⌉ owners.card - 1
  have hv := protected_endpoint_at_least_two n owners.card hfeasible.1 hroom
  have ha : 1 ≤ a := by unfold a; omega
  obtain ⟨pairs, packing, hpairs⟩ := pairCapacity_choose tag owners _ hfeasible.2.2
  obtain ⟨assign, hvalid, _, _⟩ := protected_pair_allocation_factor tag owners hfeasible.1 hroom pairs packing hpairs hcolors
  rw [← hmaximum]
  change optimalFactor tag = (a : ℝ)
  apply le_antisymm
  · exact optimalFactor_le tag _ (by exact_mod_cast ha) hvalid
  · have lower := (optimalFactor_within_one tag hn).1
    rw [← hmaximum] at lower
    change ((max 1 a : ℕ) : ℝ) ≤ optimalFactor tag at lower
    rwa [max_eq_right ha] at lower

end TwoColorNullity.Occupancy
