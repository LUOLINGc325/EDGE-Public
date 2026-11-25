import GeometricSearchModel

/-!
# First-departure penalties in the geometric search model

The extra cost is proved in the actual extended nonnegative expectation model.
In particular, a competing schedule with infinite cost also satisfies the bound.
-/

set_option autoImplicit false

open Finset Filter
open scoped ENNReal Topology

namespace PureSearch

lemma visits_eq_before {s t : ℕ → Bool} {n : ℕ} (b : Bool)
    (h : ∀ k < n, s k = t k) : visits s b n = visits t b n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [visits, visits, h n (Nat.lt_succ_self n)]
    rw [ih (fun k hk => h k (Nat.lt.step hk))]

lemma prefix_cost_eq_before (m : ℝ) {s t : ℕ → Bool} {n : ℕ} (b : Bool)
    (h : ∀ k < n, s k = t k) : prefixCost m s b n = prefixCost m t b n := by
  unfold prefixCost
  apply sum_congr rfl
  intro k hk
  unfold survival
  rw [visits_eq_before b (fun j hj => h j (hj.trans (mem_range.mp hk)))]

/-- After a missed search the conditional continuation costs at least one step
plus the geometric waiting time. The bound is given relative to the reference
budget at the same prefix, which can be read from the actual candidate. -/
theorem conditional_departure_bound (m V : ℝ) (hm : 1 < m)
    {s t : ℕ → Bool} {n : ℕ} (b : Bool)
    (h : ∀ k < n, s k = t k) (hwrong : s n ≠ b) :
    ENNReal.ofReal (V + survival m t b n * (1 - coordinate (budgetState m V t n) b)) ≤
      expectedDetectionTime m s b := by
  rw [expected_detection_time_eq_survival_cost m hm]
  have hlower := prefix_plus_remaining_le_cost m hm s b (n + 1)
  rw [prefix_cost_succ, survival_succ, if_neg hwrong, prefix_cost_eq_before m b h] at hlower
  have hs : survival m s b n = survival m t b n := by
    unfold survival
    rw [visits_eq_before b h]
  rw [hs] at hlower
  refine le_trans (ENNReal.ofReal_le_ofReal ?_) hlower
  linarith [budget_conservation m V hm t n b]

noncomputable def departureMargin (m n : ℕ) : ℝ :=
  if n = 1 then 1 - candidateDelta m / m
  else 1 - (m : ℝ) ^ ((n - 2) % (m - 1)) * candidateDelta m

noncomputable def uniformDepartureMargin (m : ℕ) : ℝ :=
  1 - (m : ℝ) ^ (m - 2) * candidateDelta m

theorem uniform_departure_margin_pos (m : ℕ) (hm : 3 ≤ m) :
    0 < uniformDepartureMargin m :=
  sub_pos.mpr (conjecture21_power_margin m hm)

lemma candidate_active_coordinate (m n : ℕ) (hm : 3 ≤ m) (hn : 0 < n) :
    1 - coordinate (budgetState m (candidateValue m) (candidate m) n) (candidate m n) =
      departureMargin m n := by
  rw [candidate_budget_state]
  by_cases hn1 : n = 1
  · subst n
    simp [candidate, state, step, candidateInitial, coordinate, departureMargin]
  · let k := n - 2
    let h := m - 1
    have hn' : n = 2 + k := by dsimp [k]; omega
    have hh : 0 < h := by dsimp [h]; omega
    have hj : k % h < h := Nat.mod_lt k hh
    have hk : k / h * h + k % h = k := by
      simpa only [Nat.mul_comm, Nat.add_comm] using Nat.mod_add_div k h
    have hstate := periodic_block_state (m : ℝ) h (candidateDelta m) hh
      (candidate_delta_return m hm) (k / h) (k % h) hj.le
    have haction := periodic_action_in_block h (k / h) (k % h) hh hj
    rw [hk] at hstate haction
    have hbudget : state (m : ℝ) (candidateInitial m) (candidate m) n =
        state (m : ℝ) (candidateInitial m) (candidate m) (2 + k) :=
      congrArg (state (m : ℝ) (candidateInitial m) (candidate m)) hn'
    have hcand : candidate m n = periodicAction h k :=
      (congrArg (candidate m) hn').trans (candidate_tail_action m k)
    rw [hbudget, candidate_tail_state m hm k, hcand]
    change 1 - coordinate (state (m : ℝ) ((h : ℝ) + candidateDelta m, candidateDelta m)
      (periodicAction h) k) (periodicAction h k) = departureMargin m n
    rw [hstate, haction]
    cases hc : blockAction (k / h) <;>
      simp [coordinate, departureMargin, hn1, hc, k, h]

lemma uniform_margin_le_departure_margin (m n : ℕ) (hm : 3 ≤ m) :
    uniformDepartureMargin m ≤ departureMargin m n := by
  have hm1 : (1 : ℝ) ≤ m := by exact_mod_cast (show 1 ≤ m by omega)
  have hd := candidate_delta_nonnegative m hm
  unfold uniformDepartureMargin departureMargin
  split_ifs
  · have hpower : (1 : ℝ) ≤ (m : ℝ) ^ (m - 2) := one_le_pow₀ hm1
    nlinarith [div_le_self hd hm1, mul_le_mul_of_nonneg_right hpower hd]
  · have hj : (n - 2) % (m - 1) ≤ m - 2 := by
      have := Nat.mod_lt (n - 2) (show 0 < m - 1 by omega)
      omega
    have hpower := pow_le_pow_right₀ hm1 hj
    linarith [mul_le_mul_of_nonneg_right hpower hd]

/-- The exact lower bounds of (17) and (18), including the candidate's
position-specific discount. Addition expresses the same loss bound at infinity. -/
theorem candidate_departure_loss (m : ℕ) (hm : 3 ≤ m) (s : ℕ → Bool)
    (n : ℕ) (hn : 0 < n) (heq : ∀ k < n, s k = candidate m k)
    (hne : s n ≠ candidate m n) :
    ENNReal.ofReal (candidateValue m +
      survival m (candidate m) (candidate m n) n * departureMargin m n) ≤
        worstExpectedTime m s := by
  have hmreal : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have h := conditional_departure_bound (m : ℝ) (candidateValue m) hmreal (candidate m n) heq hne
  rw [candidate_active_coordinate m n hm hn] at h
  apply h.trans
  unfold worstExpectedTime
  cases candidate m n
  · exact le_max_right _ _
  · exact le_max_left _ _

theorem candidate_departure_uniform_loss (m : ℕ) (hm : 3 ≤ m) (s : ℕ → Bool)
    (n : ℕ) (hn : 0 < n) (heq : ∀ k < n, s k = candidate m k)
    (hne : s n ≠ candidate m n) :
    ENNReal.ofReal (candidateValue m + (1 / (m : ℝ)) ^ n * uniformDepartureMargin m) ≤
      worstExpectedTime m s := by
  have hm0 : (0 : ℝ) < m := by exact_mod_cast (show 0 < m by omega)
  have hm1 : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have hcount : visits (candidate m) (candidate m n) n ≤ n := by
    simpa [visits] using visits_add_le (candidate m) (candidate m n) 0 n
  have hr := one_div_pos.mpr hm0
  have hpow : (1 / (m : ℝ)) ^ n ≤ survival m (candidate m) (candidate m n) n := by
    exact pow_le_pow_of_le_one hr.le ((div_lt_one hm0).mpr hm1).le hcount
  apply le_trans _ (candidate_departure_loss m hm s n hn heq hne)
  exact ENNReal.ofReal_le_ofReal (add_le_add_left
    (mul_le_mul hpow (uniform_margin_le_departure_margin m n hm)
      (uniform_departure_margin_pos m hm).le (survival_pos m hm0 _ _ _).le) _)

theorem candidate_departure_initial_loss (m : ℕ) (hm : 3 ≤ m)
    (s : ℕ → Bool) (hfirst : s 0 = true) (hsecond : s 1 = true) :
    ENNReal.ofReal (candidateValue m + (1 - candidateDelta m / m)) ≤ worstExpectedTime m s := by
  have h := candidate_departure_loss m hm s 1 (by omega)
    (fun k hk => by
      obtain rfl : k = 0 := by omega
      exact hfirst)
    (by simp [hsecond, candidate])
  simpa [survival, visits, candidate, departureMargin] using h

theorem candidate_departure_visit_discount (m : ℕ) (hm : 3 ≤ m) (s : ℕ → Bool)
    (n : ℕ) (hn : 0 < n) (heq : ∀ k < n, s k = candidate m k)
    (hne : s n ≠ candidate m n) :
    ENNReal.ofReal (candidateValue m +
      survival m (candidate m) (candidate m n) n * uniformDepartureMargin m) ≤ worstExpectedTime m s := by
  have hm0 : (0 : ℝ) < m := by exact_mod_cast (show 0 < m by omega)
  apply le_trans _ (candidate_departure_loss m hm s n hn heq hne)
  exact ENNReal.ofReal_le_ofReal (add_le_add_left (mul_le_mul_of_nonneg_left
    (uniform_margin_le_departure_margin m n hm) (survival_pos m hm0 _ _ _).le) _)

theorem normalized_nearly_optimal_prefix (m : ℕ) (hm : 3 ≤ m) (s : ℕ → Bool)
    (L : ℕ) (epsilon : ℝ) (he0 : 0 ≤ epsilon)
    (hsmall : epsilon < uniformDepartureMargin m * (1 / (m : ℝ)) ^ (L - 1))
    (hfirst : s 0 = true)
    (hcost : worstExpectedTime m s ≤ ENNReal.ofReal (candidateValue m + epsilon)) :
    ∀ k < L, s k = candidate m k := by
  by_contra! bad
  obtain ⟨k, hk, hkne⟩ := bad
  have hex : ∃ i, s i ≠ candidate m i := ⟨k, hkne⟩
  let n := Nat.find hex
  have hn : s n ≠ candidate m n := Nat.find_spec hex
  have hnk : n ≤ k := Nat.find_min' hex hkne
  have hne0 : n ≠ 0 := by
    intro hn0
    apply hn
    rw [hn0]
    exact hfirst
  have heq : ∀ i < n, s i = candidate m i := by
    intro i hi
    by_cases h : s i = candidate m i
    · exact h
    · exact ((not_le_of_gt hi) (Nat.find_min' hex h)).elim
  have hbound := (candidate_departure_uniform_loss m hm s n (Nat.pos_of_ne_zero hne0) heq hn).trans hcost
  have hreal := (ENNReal.ofReal_le_ofReal_iff (add_nonneg (candidate_value_pos m hm).le he0)).mp hbound
  have hm0 : (0 : ℝ) < m := by exact_mod_cast (show 0 < m by omega)
  have hm1 : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have hpow := pow_le_pow_of_le_one (one_div_pos.mpr hm0).le
    ((div_lt_one hm0).mpr hm1).le (show n ≤ L - 1 by omega)
  have hmul := mul_le_mul_of_nonneg_left hpow (uniform_departure_margin_pos m hm).le
  linarith

/-- The prefix agreement holds up to exchanging the box labels. -/
theorem nearly_optimal_prefix (m : ℕ) (hm : 3 ≤ m) (s : ℕ → Bool)
    (L : ℕ) (epsilon : ℝ) (he0 : 0 ≤ epsilon)
    (hsmall : epsilon < uniformDepartureMargin m * (1 / (m : ℝ)) ^ (L - 1))
    (hcost : worstExpectedTime m s ≤ ENNReal.ofReal (candidateValue m + epsilon)) :
    (∀ k < L, s k = candidate m k) ∨
      (∀ k < L, s k = complementSchedule (candidate m) k) := by
  by_cases hfirst : s 0 = true
  · exact Or.inl (normalized_nearly_optimal_prefix m hm s L epsilon he0 hsmall hfirst hcost)
  · have hcfirst : complementSchedule s 0 = true := by
      cases hs : s 0 <;> simp_all [complementSchedule]
    have hm1 : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
    have hcomplement : worstExpectedTime m (complementSchedule s) = worstExpectedTime m s := by
      simp only [worst_expected_time_eq_survival_cost m hm1, worst_survival_cost_complement]
    rw [← hcomplement] at hcost
    have hp := normalized_nearly_optimal_prefix m hm (complementSchedule s)
      L epsilon he0 hsmall hcfirst hcost
    right
    intro k hk
    simpa only [complementSchedule, Bool.not_not] using congrArg Bool.not (hp k hk)

def swapAdjacent (s : ℕ → Bool) (n k : ℕ) : Bool :=
  if k = n then s (n + 1) else if k = n + 1 then s n else s k

lemma swapped_visits_off_middle (s : ℕ → Bool) (n k : ℕ) (b : Bool) (hk : k ≠ n + 1) :
    visits (swapAdjacent s n) b k = visits s b k := by
  by_cases hkn : k ≤ n
  · apply visits_eq_before b
    intro i hi
    simp [swapAdjacent, show i ≠ n by omega, show i ≠ n + 1 by omega]
  · obtain ⟨d, rfl⟩ := Nat.exists_eq_add_of_le (show n + 2 ≤ k by omega)
    induction d with
    | zero =>
      have hp := visits_eq_before b (s := swapAdjacent s n) (t := s) (n := n)
        (fun i hi => by
          simp [swapAdjacent, show i ≠ n by omega, show i ≠ n + 1 by omega])
      simp only [Nat.add_zero, show n + 2 = (n + 1) + 1 by omega, visits, hp,
        swapAdjacent, Nat.succ_ne_self, ↓reduceIte]
      omega
    | succ d ih =>
      rw [Nat.add_succ, visits, visits, ih (by omega) (by omega)]
      simp [swapAdjacent, show n + 2 + d ≠ n by omega, show n + 2 + d ≠ n + 1 by omega]

lemma swapped_survival_middle (m : ℝ) (s : ℕ → Bool) (n : ℕ) (b : Bool) :
    survival m (swapAdjacent s n) b (n + 1) =
      if s (n + 1) = b then survival m s b n / m else survival m s b n := by
  rw [survival_succ]
  simp only [swapAdjacent, ↓reduceIte]
  have hp : survival m (swapAdjacent s n) b n = survival m s b n := by
    unfold survival
    rw [swapped_visits_off_middle s n n b (by omega)]
  split_ifs <;> rw [hp]

lemma swapped_survival_cost_identity (m : ℝ) (s : ℕ → Bool) (n : ℕ) (b : Bool) :
    survivalCost m (swapAdjacent s n) b + ENNReal.ofReal (survival m s b (n + 1)) =
      survivalCost m s b + ENNReal.ofReal (survival m (swapAdjacent s n) b (n + 1)) := by
  unfold survivalCost
  rw [ENNReal.tsum_eq_add_tsum_ite (f := fun k =>
      ENNReal.ofReal (survival m (swapAdjacent s n) b k)) (n + 1),
    ENNReal.tsum_eq_add_tsum_ite (f := fun k => ENNReal.ofReal (survival m s b k)) (n + 1)]
  have heq : (∑' k, @ite ℝ≥0∞ (k = n + 1) (Classical.propDecidable _) 0
      (ENNReal.ofReal (survival m (swapAdjacent s n) b k))) =
      ∑' k, @ite ℝ≥0∞ (k = n + 1) (Classical.propDecidable _) 0
        (ENNReal.ofReal (survival m s b k)) := by
    apply tsum_congr
    intro k
    split_ifs with hk
    · rfl
    · unfold survival
      rw [swapped_visits_off_middle s n k b hk]
  rw [heq]
  ac_rfl

lemma swapped_survival_cost_le (m : ℝ) (hm : 1 < m) (s : ℕ → Bool) (n : ℕ) (b : Bool) :
    survivalCost m (swapAdjacent s n) b ≤ survivalCost m s b + ENNReal.ofReal (survival m s b n) := by
  have hp := (survival_pos m (by linarith) s b n).le
  have hnew : survival m (swapAdjacent s n) b (n + 1) ≤ survival m s b n := by
    rw [swapped_survival_middle]
    split_ifs
    · exact div_le_self hp hm.le
    · exact le_rfl
  calc
    _ ≤ survivalCost m (swapAdjacent s n) b + ENNReal.ofReal (survival m s b (n + 1)) :=
      le_self_add
    _ = _ := swapped_survival_cost_identity m s n b
    _ ≤ _ := add_le_add_left (ENNReal.ofReal_le_ofReal hnew) _

/-- The sole changed survival term gives the two signed payoff changes claimed
in the manuscript, with no approximation of the infinite sum. -/
theorem candidate_adjacent_swap_change (m : ℕ) (hm : 3 ≤ m) (n : ℕ)
    (hpair : candidate m n ≠ candidate m (n + 1)) (b : Bool) :
    (expectedDetectionTime m (swapAdjacent (candidate m) n) b).toReal - candidateValue m =
      if candidate m n = b then (1 - 1 / (m : ℝ)) * survival m (candidate m) b n
      else -((1 - 1 / (m : ℝ)) * survival m (candidate m) b n) := by
  have hm1 : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have hm0 : (0 : ℝ) < m := by linarith
  rw [expected_detection_time_eq_survival_cost m hm1]
  have hfin : survivalCost m (swapAdjacent (candidate m) n) b ≠ ∞ := by
    apply ne_of_lt
    apply (swapped_survival_cost_le m hm1 (candidate m) n b).trans_lt
    rw [candidate_survival_cost_eq m hm b]
    simp
  have hid := congrArg ENNReal.toReal (swapped_survival_cost_identity (m : ℝ) (candidate m) n b)
  rw [ENNReal.toReal_add hfin ENNReal.ofReal_ne_top, candidate_survival_cost_eq m hm b,
    ENNReal.toReal_add ENNReal.ofReal_ne_top ENNReal.ofReal_ne_top,
    ENNReal.toReal_ofReal (candidate_value_pos m hm).le,
    ENNReal.toReal_ofReal (survival_pos m hm0 _ _ _).le,
    ENNReal.toReal_ofReal (survival_pos m hm0 _ _ _).le, survival_succ,
    swapped_survival_middle] at hid
  by_cases hb : candidate m n = b
  · have hb' : candidate m (n + 1) ≠ b := fun h => hpair (hb.trans h.symm)
    rw [if_pos hb, if_neg hb'] at hid
    rw [if_pos hb]
    rw [sub_mul, one_mul, div_mul_eq_mul_div, one_mul]
    linarith
  · have hb' : candidate m (n + 1) = b := by
      cases ha : candidate m n <;> cases hc : candidate m (n + 1) <;> cases b <;> simp_all
    rw [if_neg hb, if_pos hb'] at hid
    rw [if_neg hb]
    rw [sub_mul, one_mul, div_mul_eq_mul_div, one_mul]
    linarith

lemma candidate_has_late_unlike_pair (m : ℕ) (hm : 3 ≤ m) (N : ℕ) :
    ∃ n, N ≤ n ∧ 0 < n ∧ candidate m n ≠ candidate m (n + 1) := by
  let h := m - 1
  have hh : 0 < h := by dsimp [h]; omega
  let n := 2 + (N * h + (h - 1))
  have hn : N ≤ n := (Nat.le_mul_of_pos_right N hh).trans (by dsimp [n]; omega)
  refine ⟨n, hn, by dsimp [n]; omega, ?_⟩
  have hn' : n + 1 = 2 + ((N + 1) * h + 0) := by
    dsimp [n]
    rw [Nat.succ_mul]
    omega
  have ha : candidate m n = blockAction N := by
    unfold n
    rw [candidate_tail_action]
    exact periodic_action_in_block h N (h - 1) hh (by omega)
  have hb : candidate m (n + 1) = blockAction (N + 1) := by
    rw [hn', candidate_tail_action]
    exact periodic_action_in_block h (N + 1) 0 hh hh
  rw [ha, hb, block_action_successor]
  cases blockAction N <;> decide

/-- Arbitrarily small positive losses occur outside the two minimizing words. -/
theorem no_uniform_positive_gap (m : ℕ) (hm : 3 ≤ m) (epsilon : ℝ) (he : 0 < epsilon) :
    ∃ s : ℕ → Bool, s ≠ candidate m ∧ s ≠ complementSchedule (candidate m) ∧
      ENNReal.ofReal (candidateValue m) < worstExpectedTime m s ∧
      worstExpectedTime m s < ENNReal.ofReal (candidateValue m + epsilon) := by
  have hm1 : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have hsmall (b : Bool) : ∃ N, ∀ n ≥ N,
      ENNReal.ofReal (survival m (candidate m) b n) < ENNReal.ofReal epsilon := by
    have hfin : survivalCost m (candidate m) b ≠ ∞ := by
      rw [candidate_survival_cost_eq m hm b]
      exact ENNReal.ofReal_ne_top
    exact eventually_atTop.mp ((ENNReal.tendsto_atTop_zero_of_tsum_ne_top hfin).eventually_lt_const
      (ENNReal.ofReal_pos.mpr he))
  obtain ⟨Nt, ht⟩ := hsmall true
  obtain ⟨Nf, hf⟩ := hsmall false
  obtain ⟨n, hN, hn, hpair⟩ := candidate_has_late_unlike_pair m hm (max Nt Nf)
  let s := swapAdjacent (candidate m) n
  have hs : s ≠ candidate m := by
    intro heq
    have h := congrFun heq n
    exact hpair (by simpa [s, swapAdjacent] using h.symm)
  have hc : s ≠ complementSchedule (candidate m) := by
    intro heq
    have h := congrFun heq 0
    simp [s, swapAdjacent, show 0 ≠ n by omega, show 0 ≠ n + 1 by omega,
      complementSchedule, candidate] at h
  refine ⟨s, hs, hc, ?_, ?_⟩
  · exact lt_of_le_of_ne (pure_search_global_optimality m hm s) (fun h =>
      ((pure_search_global_minimizers m hm s).1 h.symm).elim hs hc)
  · have hcost (b : Bool) : expectedDetectionTime m s b <
        ENNReal.ofReal (candidateValue m + epsilon) := by
      rw [expected_detection_time_eq_survival_cost m hm1,
        ENNReal.ofReal_add (candidate_value_pos m hm).le he.le]
      apply (swapped_survival_cost_le m hm1 (candidate m) n b).trans_lt
      rw [candidate_survival_cost_eq m hm b]
      apply ENNReal.add_lt_add_left ENNReal.ofReal_ne_top
      cases b
      · exact hf n ((le_max_right _ _).trans hN)
      · exact ht n ((le_max_left _ _).trans hN)
    exact max_lt (hcost true) (hcost false)

end PureSearch

#print axioms PureSearch.visits_eq_before
#print axioms PureSearch.prefix_cost_eq_before
#print axioms PureSearch.conditional_departure_bound
#print axioms PureSearch.uniform_departure_margin_pos
#print axioms PureSearch.candidate_active_coordinate
#print axioms PureSearch.uniform_margin_le_departure_margin
#print axioms PureSearch.candidate_departure_loss
#print axioms PureSearch.candidate_departure_uniform_loss
#print axioms PureSearch.candidate_departure_initial_loss
#print axioms PureSearch.candidate_departure_visit_discount
#print axioms PureSearch.normalized_nearly_optimal_prefix
#print axioms PureSearch.nearly_optimal_prefix
#print axioms PureSearch.swapped_visits_off_middle
#print axioms PureSearch.swapped_survival_middle
#print axioms PureSearch.swapped_survival_cost_identity
#print axioms PureSearch.swapped_survival_cost_le
#print axioms PureSearch.candidate_adjacent_swap_change
#print axioms PureSearch.candidate_has_late_unlike_pair
#print axioms PureSearch.no_uniform_positive_gap
