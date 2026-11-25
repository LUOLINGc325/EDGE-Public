import RandomWitnessEstimates
import Mathlib.Tactic.GCongr

open scoped BigOperators

namespace TwoColorNullity

def largeSetThreshold (n : ℕ) : ℕ := Nat.clog 2 n + 6

noncomputable def smallWitnessBase (n : ℕ) : ℝ :=
  9 * (n : ℝ) ^ 3 * ((1 : ℝ) / 2) ^ (n - n / 2)

noncomputable def largeWitnessBase : ℝ := 27 * Real.exp 1 / 128

theorem largeWitnessBase_bounds : 0 < largeWitnessBase ∧ largeWitnessBase < 1 := by
  constructor
  · unfold largeWitnessBase
    positivity
  · unfold largeWitnessBase
    have e := Real.exp_one_lt_d9
    linarith

private def witnessEvent (n s r : ℕ) (bits : BitProfile n (3 * n - 1)) : Prop :=
  ∃ owners : Finset (Fin n), owners.card = s ∧
    ∃ matching : UnorderedMatching (Fin (3 * n - 1)) r, MatchingAgrees owners matching bits

private theorem finiteProbability_or_le {Sample : Type*} [Fintype Sample] (p q : Sample → Prop) :
    finiteProbability (fun sample => p sample ∨ q sample) ≤ finiteProbability p + finiteProbability q := by
  classical
  let event (side : Bool) (sample : Sample) := if side then p sample else q sample
  let sides : Finset Bool := {true, false}
  have equal (sample : Sample) : (p sample ∨ q sample) ↔ ∃ side ∈ sides, event side sample := by
    constructor
    · rintro (hp | hq)
      · exact ⟨true, by simp [sides], by simpa [event] using hp⟩
      · exact ⟨false, by simp [sides], by simpa [event] using hq⟩
    · rintro ⟨side, _, he⟩
      cases side
      · exact Or.inr (by simpa [event] using he)
      · exact Or.inl (by simpa [event] using he)
  rw [show (fun sample => p sample ∨ q sample) = _ from funext fun sample => propext (equal sample)]
  simpa [sides, event, Finset.sum_insert] using (finiteProbability_union_bound (witnesses := sides) event)

private theorem restrict_matching {n m r : ℕ} (bits : BitProfile n m) (owners subset : Finset (Fin n))
    (hsubset : subset ⊆ owners) (matching : UnorderedMatching (Fin m) r)
    (hagrees : MatchingAgrees owners matching bits) (t : ℕ) (ht : t ≤ r) :
    ∃ reduced : UnorderedMatching (Fin m) t, MatchingAgrees subset reduced bits := by
  obtain ⟨pairs, hpairs, hcard⟩ := Finset.exists_subset_card_eq
    (show t ≤ matching.val.card by rw [matching.property.1]; exact ht)
  let reduced : UnorderedMatching (Fin m) t := ⟨pairs, hcard, matching.property.2.subpacking hpairs⟩
  refine ⟨reduced, ?_⟩
  intro pair hp a ha b hb
  funext coord
  exact congrFun (hagrees pair (hpairs hp) a ha b hb) ⟨coord.val, hsubset coord.property⟩

private theorem smallWitness_weight (n r : ℕ) (hr : r ≤ n / 2) :
    (n.choose (n - r) : ℝ) * (Fintype.card (UnorderedMatching (Fin (3 * n - 1)) r) : ℝ) *
      ((1 : ℝ) / 2) ^ (r * (n - r)) ≤ smallWitnessBase n ^ r := by
  have hrn : r ≤ n := by omega
  have choose_bound : (n.choose (n - r) : ℝ) ≤ (n : ℝ) ^ r := by
    rw [Nat.choose_symm hrn]
    exact_mod_cast Nat.choose_le_pow n r
  have m_le : ((3 * n - 1 : ℕ) : ℝ) ≤ 3 * (n : ℝ) := by
    exact_mod_cast (show 3 * n - 1 ≤ 3 * n by omega)
  have matching_bound : (Fintype.card (UnorderedMatching (Fin (3 * n - 1)) r) : ℝ) ≤
      (3 * (n : ℝ)) ^ (2 * r) := by
    have count : (Fintype.card (UnorderedMatching (Fin (3 * n - 1)) r) : ℝ) ≤
        ((3 * n - 1 : ℕ) : ℝ) ^ (2 * r) := by
      exact_mod_cast unordered_matchings_count_le_pow (3 * n - 1) r
    exact count.trans (pow_le_pow_left₀ (by positivity) m_le _)
  have agreement : ((1 : ℝ) / 2) ^ (r * (n - r)) ≤ (((1 : ℝ) / 2) ^ (n - n / 2)) ^ r := by
    rw [Nat.mul_comm r (n - r), pow_mul]
    exact pow_le_pow_left₀ (by positivity) (pow_le_pow_of_le_one (by norm_num) (by norm_num) (by omega)) _
  calc
    _ ≤ (n : ℝ) ^ r * (3 * (n : ℝ)) ^ (2 * r) * (((1 : ℝ) / 2) ^ (n - n / 2)) ^ r := by
      gcongr
    _ = smallWitnessBase n ^ r := by
      unfold smallWitnessBase
      rw [pow_mul (3 * (n : ℝ)), ← mul_pow, ← mul_pow]
      congr 1
      ring

private theorem largeWitness_weight (n : ℕ) (hn : 3 ≤ n) :
    let h := n / 2
    let t := largeSetThreshold n
    (n.choose t : ℝ) * (Fintype.card (UnorderedMatching (Fin (3 * n - 1)) h) : ℝ) *
      ((1 : ℝ) / 2) ^ (h * t) ≤ (n : ℝ) ^ t * largeWitnessBase ^ h := by
  dsimp only
  let h := n / 2
  let t := largeSetThreshold n
  have hh : 0 < h := by dsimp [h]; omega
  have m_lt : ((3 * n - 1 : ℕ) : ℝ) ≤ 3 * (n : ℝ) := by
    exact_mod_cast (show 3 * n - 1 ≤ 3 * n by omega)
  have hthird : (n : ℝ) ≤ 3 * (h : ℝ) := by
    exact_mod_cast (show n ≤ 3 * h by dsimp [h]; omega)
  have hpow : 64 * (n : ℝ) ≤ (2 : ℝ) ^ t := by
    have nat_pow : 64 * n ≤ (2 : ℕ) ^ t := by
      unfold t largeSetThreshold
      rw [pow_add]
      change 2 ^ 6 * n ≤ 2 ^ Nat.clog 2 n * 2 ^ 6
      rw [Nat.mul_comm (2 ^ 6) n]
      exact Nat.mul_le_mul_right (2 ^ 6) (Nat.le_pow_clog (by decide : 1 < 2) n)
    exact_mod_cast nat_pow
  have hbase : Real.exp 1 * ((3 * n - 1 : ℕ) : ℝ) ^ 2 / (2 * (h : ℝ)) * ((1 : ℝ) / 2) ^ t ≤
      largeWitnessBase := by
    rw [div_pow, one_pow, mul_one_div, div_div]
    apply (div_le_iff₀ (by positivity)).mpr
    have hsquare : ((3 * n - 1 : ℕ) : ℝ) ^ 2 ≤ 9 * (n : ℝ) ^ 2 := by
      have hh := pow_le_pow_left₀ (by positivity) m_lt 2
      nlinarith
    have hp := mul_le_mul hthird hpow (by positivity) (by positivity)
    unfold largeWitnessBase
    calc
      _ ≤ Real.exp 1 * (9 * (n : ℝ) ^ 2) := mul_le_mul_of_nonneg_left hsquare (by positivity)
      _ ≤ _ := by
        have scaled := mul_le_mul_of_nonneg_left hp (show 0 ≤ Real.exp 1 by positivity)
        nlinarith only [scaled]
  have choose_bound : (n.choose t : ℝ) ≤ (n : ℝ) ^ t := by exact_mod_cast Nat.choose_le_pow n t
  have matching_bound := unordered_matchings_count_le_exp (3 * n - 1) h hh
  change (n.choose t : ℝ) * (Fintype.card (UnorderedMatching (Fin (3 * n - 1)) h) : ℝ) *
      ((1 : ℝ) / 2) ^ (h * t) ≤ (n : ℝ) ^ t * largeWitnessBase ^ h
  calc
    _ ≤ (n : ℝ) ^ t *
        (Real.exp 1 * ((3 * n - 1 : ℕ) : ℝ) ^ 2 / (2 * (h : ℝ))) ^ h *
          ((1 : ℝ) / 2) ^ (h * t) := by gcongr
    _ = (n : ℝ) ^ t *
        (Real.exp 1 * ((3 * n - 1 : ℕ) : ℝ) ^ 2 / (2 * (h : ℝ)) * ((1 : ℝ) / 2) ^ t) ^ h := by
      rw [Nat.mul_comm h t, pow_mul, mul_pow, mul_assoc]
    _ ≤ _ := mul_le_mul_of_nonneg_left (pow_le_pow_left₀ (by positivity) hbase _) (by positivity)

theorem large_set_threshold_probability_bound (n : ℕ) (hn : 3 ≤ n) :
    finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
        largeSetThreshold n ≤ maximumFeasibleOwners (profileTag bits)) ≤
      (∑ r ∈ Finset.Icc 1 (n / 2), smallWitnessBase n ^ r) +
        (n : ℝ) ^ largeSetThreshold n * largeWitnessBase ^ (n / 2) := by
  let small (bits : BitProfile n (3 * n - 1)) := ∃ r ∈ Finset.Icc 1 (n / 2), witnessEvent n (n - r) r bits
  let large := witnessEvent n (largeSetThreshold n) (n / 2)
  have contain (bits : BitProfile n (3 * n - 1)) (bad : largeSetThreshold n ≤ maximumFeasibleOwners (profileTag bits)) :
      small bits ∨ large bits := by
    obtain ⟨owners, feasible, max_eq⟩ := maximumFeasibleOwners_attained (profileTag bits) (by omega)
    obtain ⟨matching, agrees⟩ := feasibleOwner_matching bits owners feasible
    have hc := feasible.2.1
    let r := n - owners.card
    by_cases hr : r ≤ n / 2
    · apply Or.inl
      have hrpos : 1 ≤ r := by dsimp [r]; omega
      have hcard : owners.card = n - r := by dsimp [r]; omega
      exact ⟨r, Finset.mem_Icc.mpr ⟨hrpos, hr⟩, owners, hcard, matching, agrees⟩
    · apply Or.inr
      rw [max_eq] at bad
      obtain ⟨subset, hsub, hcard⟩ := Finset.exists_subset_card_eq bad
      exact ⟨subset, hcard, restrict_matching bits owners subset hsub matching agrees (n / 2) (by omega)⟩
  have hsmall : finiteProbability small ≤ ∑ r ∈ Finset.Icc 1 (n / 2), smallWitnessBase n ^ r := by
    refine (finiteProbability_union_bound (witnesses := Finset.Icc 1 (n / 2))
      (fun r => witnessEvent n (n - r) r)).trans ?_
    apply Finset.sum_le_sum
    intro r hr
    exact (fixed_sizes_bound (n - r) r).trans (smallWitness_weight n r (Finset.mem_Icc.mp hr).2)
  have hlarge : finiteProbability large ≤ (n : ℝ) ^ largeSetThreshold n * largeWitnessBase ^ (n / 2) :=
    (fixed_sizes_bound (largeSetThreshold n) (n / 2)).trans (largeWitness_weight n hn)
  exact (finiteProbability_mono contain).trans ((finiteProbability_or_le small large).trans (add_le_add hsmall hlarge))

end TwoColorNullity
