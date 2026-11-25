import GeometricSearchModel

/-! Exact prefix/suffix decomposition and conditional payoffs for the manuscript. -/

set_option autoImplicit false

open Finset Filter
open scoped ENNReal Topology

namespace PureSearch

def suffix (s : ℕ → Bool) (n : ℕ) : ℕ → Bool := fun k => s (n + k)

lemma visits_suffix (s : ℕ → Bool) (b : Bool) (n k : ℕ) :
    visits s b (n + k) = visits s b n + visits (suffix s n) b k := by
  induction k with
  | zero => simp [visits]
  | succ k ih =>
    rw [Nat.add_succ, visits, visits, ih]
    simp only [suffix, add_assoc]

theorem expected_time_prefix_suffix (m : ℝ) (hm : 1 < m) (s : ℕ → Bool)
    (b : Bool) (n : ℕ) :
    expectedDetectionTime m s b = ENNReal.ofReal (prefixCost m s b n) +
      ENNReal.ofReal (survival m s b n) * expectedDetectionTime m (suffix s n) b := by
  have hm0 : 0 < m := by linarith
  rw [expected_detection_time_eq_survival_cost m hm, expected_detection_time_eq_survival_cost m hm]
  unfold survivalCost prefixCost
  rw [ENNReal.ofReal_sum_of_nonneg (fun i _ => (survival_pos m hm0 s b i).le),
    ← ENNReal.tsum_mul_left]
  rw [← ENNReal.summable.sum_add_tsum_nat_add' (k := n)
    (f := fun k => ENNReal.ofReal (survival m s b k))]
  congr 1
  apply tsum_congr
  intro k
  rw [Nat.add_comm k n, ← ENNReal.ofReal_mul (survival_pos m hm0 s b n).le]
  simp only [survival, visits_suffix, pow_add]

theorem expected_time_ge_search_mean (m : ℝ) (hm : 1 < m) (s : ℕ → Bool) (b : Bool) :
    ENNReal.ofReal (searchMean m) ≤ expectedDetectionTime m s b := by
  rw [expected_detection_time_eq_survival_cost m hm]
  simpa [prefixCost, survival, visits] using prefix_plus_remaining_le_cost m hm s b 0

theorem expected_time_eq_top_of_finitely_many_visits (m : ℝ) (hm : 1 < m)
    (s : ℕ → Bool) (b : Bool) (N : ℕ) (h : ∀ k ≥ N, s k ≠ b) :
    expectedDetectionTime m s b = ∞ := by
  have hm0 : 0 < m := by linarith
  have hv (k : ℕ) : visits s b (N + k) = visits s b N := by
    induction k with
    | zero => rfl
    | succ k ih =>
      rw [Nat.add_succ, visits, ih, if_neg (h _ (Nat.le_add_right N k)), Nat.add_zero]
  rw [expected_detection_time_eq_survival_cost m hm]
  by_contra hfin
  have hz := ENNReal.tendsto_atTop_zero_of_tsum_ne_top hfin
  have hp := ENNReal.ofReal_pos.mpr (survival_pos m hm0 s b N)
  obtain ⟨M, hM⟩ := eventually_atTop.mp (hz.eventually_lt_const hp)
  have hbad := hM (N + M) (Nat.le_add_left M N)
  change ENNReal.ofReal (survival m s b (N + M)) < ENNReal.ofReal (survival m s b N) at hbad
  unfold survival at hbad
  rw [hv M] at hbad
  exact (lt_irrefl _ hbad).elim

theorem expected_time_ge_one_add_search_mean (m : ℝ) (hm : 1 < m)
    (s : ℕ → Bool) (b : Bool) (hwrong : s 0 ≠ b) :
    ENNReal.ofReal (1 + searchMean m) ≤ expectedDetectionTime m s b := by
  rw [expected_time_prefix_suffix m hm s b 1,
    ENNReal.ofReal_add zero_le_one (search_mean_pos m hm).le]
  have hprefix : prefixCost m s b 1 = 1 := by
    simp [prefixCost, survival, visits]
  have hsurvival : survival m s b 1 = 1 := by
    simp [survival, visits, hwrong]
  rw [hprefix, hsurvival, ENNReal.ofReal_one, one_mul]
  exact add_le_add_left (expected_time_ge_search_mean m hm _ _) _

/-- Equation (7) in terms of the actual conditional suffix payoff. -/
theorem first_departure_from_finite_reference (m V : ℝ) (hm : 1 < m) (hV : 0 ≤ V)
    (s t : ℕ → Bool) (b : Bool) (n : ℕ)
    (hprefix : prefixCost m s b n = prefixCost m t b n)
    (hcount : visits s b n = visits t b n)
    (hwrong : s n ≠ b) (href : expectedDetectionTime m t b = ENNReal.ofReal V)
    {C : ℝ} (hC : 0 ≤ C) (hsuffix : expectedDetectionTime m (suffix t n) b = ENNReal.ofReal C)
    (hstrict : C < 1 + searchMean m) :
    ENNReal.ofReal V < ENNReal.ofReal (V + survival m t b n * (1 + searchMean m - C)) ∧
      ENNReal.ofReal (V + survival m t b n * (1 + searchMean m - C)) ≤
        expectedDetectionTime m s b := by
  have hm0 : 0 < m := by linarith
  have hp := prefix_cost_nonneg m hm0 t b n
  have hr := survival_pos m hm0 t b n
  have hg := search_mean_pos m hm
  have hid := expected_time_prefix_suffix m hm t b n
  rw [href, hsuffix, ← ENNReal.ofReal_mul hr.le, ← ENNReal.ofReal_add hp (mul_nonneg hr.le hC)] at hid
  have heq := (ENNReal.ofReal_eq_ofReal_iff hV (add_nonneg hp (mul_nonneg hr.le hC))).mp hid
  have hmargin := mul_pos hr (sub_pos.mpr hstrict)
  constructor
  · exact ENNReal.ofReal_lt_ofReal_iff_of_nonneg hV |>.2 (lt_add_of_pos_right V hmargin)
  · have hd := expected_time_ge_one_add_search_mean m hm (suffix s n) b (by simpa [suffix] using hwrong)
    have hrs : survival m s b n = survival m t b n := by simp only [survival, hcount]
    rw [expected_time_prefix_suffix m hm s b n, hprefix, hrs]
    calc
      _ = ENNReal.ofReal (prefixCost m t b n + survival m t b n * (1 + searchMean m)) := by
        congr 1
        rw [heq]
        ring
      _ ≤ _ := by
        rw [ENNReal.ofReal_add hp (mul_nonneg hr.le (by linarith)), ENNReal.ofReal_mul hr.le]
        exact add_le_add_left (mul_le_mul_left' hd _) _

lemma candidate_suffix_payoff (m : ℕ) (hm : 3 ≤ m) (b : Bool) (n : ℕ) :
    expectedDetectionTime m (suffix (candidate m) n) b =
      ENNReal.ofReal (searchMean m + coordinate (budgetState m (candidateValue m) (candidate m) n) b) := by
  have hm1 : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have hm0 : (0 : ℝ) < m := by linarith
  have hp := prefix_cost_nonneg m hm0 (candidate m) b n
  have hr := survival_pos m hm0 (candidate m) b n
  have hc := (candidate_coordinate_bounded m hm n b).1
  have hq : 0 ≤ searchMean m + coordinate (budgetState m (candidateValue m) (candidate m) n) b := by
    rw [candidate_budget_state]
    exact add_nonneg (search_mean_pos m hm1).le hc
  have hbudget := congrArg ENNReal.ofReal (budget_conservation m (candidateValue m) hm1 (candidate m) n b)
  rw [ENNReal.ofReal_add hp (mul_nonneg hr.le hq), ENNReal.ofReal_mul hr.le] at hbudget
  have hcost := expected_time_prefix_suffix m hm1 (candidate m) b n
  rw [candidate_expected_detection_time m hm b, ← hbudget] at hcost
  exact ((ENNReal.mul_right_inj (ne_of_gt (ENNReal.ofReal_pos.mpr hr)) ENNReal.ofReal_ne_top).mp
    ((ENNReal.add_right_inj ENNReal.ofReal_ne_top).mp hcost)).symm

theorem periodic_suffix_payoffs (m q j : ℕ) (hm : 3 ≤ m) (hj : j ≤ m - 1) :
    let n := 2 + (q * (m - 1) + j)
    let A := searchMean m + ((m - 1 : ℕ) : ℝ) + candidateDelta m
    let C := searchMean m + (m : ℝ) ^ j * candidateDelta m
    let payoff (b : Bool) := expectedDetectionTime m (suffix (candidate m) n) b
    (payoff true, payoff false) =
      if blockAction q then (ENNReal.ofReal C, ENNReal.ofReal (A - j))
      else (ENNReal.ofReal (A - j), ENNReal.ofReal C) := by
  dsimp only
  rw [candidate_suffix_payoff m hm true, candidate_suffix_payoff m hm false,
    candidate_budget_state, candidate_tail_state m hm,
    periodic_block_state (m : ℝ) (m - 1) (candidateDelta m) (by omega)
      (candidate_delta_return m hm) q j hj]
  cases h : blockAction q <;>
    simp only [h, Bool.false_eq_true, ↓reduceIte, coordinate, Prod.mk.injEq, true_and, and_true] <;>
    congr 1 <;> ring

theorem candidate_initial_suffix_payoffs (m : ℕ) (hm : 3 ≤ m) :
    expectedDetectionTime m (suffix (candidate m) 1) false = ENNReal.ofReal (candidateValue m - 1) ∧
      expectedDetectionTime m (suffix (candidate m) 2) true =
        ENNReal.ofReal (searchMean m + ((m - 1 : ℕ) : ℝ) + candidateDelta m) ∧
      expectedDetectionTime m (suffix (candidate m) 2) false =
        ENNReal.ofReal (searchMean m + candidateDelta m) := by
  have h := periodic_suffix_payoffs m 0 0 hm (Nat.zero_le _)
  simp [blockAction] at h
  refine ⟨?_, h.1, h.2⟩
  rw [candidate_suffix_payoff m hm, candidate_budget_state]
  simp [coordinate, candidateValue, state, step, candidate, candidateInitial]
  congr 1
  ring

end PureSearch

#print axioms PureSearch.visits_suffix
#print axioms PureSearch.expected_time_prefix_suffix
#print axioms PureSearch.expected_time_ge_search_mean
#print axioms PureSearch.expected_time_eq_top_of_finitely_many_visits
#print axioms PureSearch.expected_time_ge_one_add_search_mean
#print axioms PureSearch.first_departure_from_finite_reference
#print axioms PureSearch.candidate_suffix_payoff
#print axioms PureSearch.periodic_suffix_payoffs
#print axioms PureSearch.candidate_initial_suffix_payoffs
