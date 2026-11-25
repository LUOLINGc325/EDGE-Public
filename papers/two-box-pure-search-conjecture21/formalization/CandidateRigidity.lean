import BudgetRigidity

/-!
# The concrete periodic candidate

This module fills the global deterministic-state link: it defines the actual
word `12 (2^(m-1) 1^(m-1))^infinity`, proves its state at every block position,
and derives the strict active-coordinate condition used by BudgetRigidity.
The passage from stochastic detection times to these residual-budget states
remains outside this module.
-/

set_option autoImplicit false

namespace PureSearch

/-- The action in alternating blocks; even blocks search box 2. -/
def blockAction (q : ℕ) : Bool := q % 2 == 1

/-- The infinite periodic tail, with each block of length `h`. -/
def periodicAction (h n : ℕ) : Bool := blockAction (n / h)

/-- Genuine state evolution across any interval of identical actions. -/
theorem state_add_of_constant
    (m : ℝ) (initial : State) (schedule : ℕ → Bool)
    (start count : ℕ) (action : Bool)
    (hconstant : ∀ j < count, schedule (start + j) = action) :
    state m initial schedule (start + count) =
      repeatAction m action (state m initial schedule start) count := by
  induction count with
  | zero => simp [repeatAction]
  | succ count ih =>
    rw [Nat.add_succ, state, hconstant count (Nat.lt_succ_self count)]
    rw [ih (fun j hj => hconstant j (Nat.lt_trans hj (Nat.lt_succ_self count)))]
    rfl

theorem periodic_action_in_block (h q j : ℕ) (hh : 0 < h) (hj : j < h) :
    periodicAction h (q * h + j) = blockAction q := by
  rw [Nat.mul_comm q h]
  simp [periodicAction, Nat.mul_add_div hh, Nat.div_eq_of_lt hj]

theorem block_action_successor (q : ℕ) :
    blockAction (q + 1) = !(blockAction q) := by
  have hq := Nat.mod_lt q (by omega : 0 < 2)
  have hnext : (q + 1) % 2 = (q % 2 + 1) % 2 := by omega
  rcases (show q % 2 = 0 ∨ q % 2 = 1 by omega) with h | h <;>
    simp [blockAction, hnext, h]

/-- Every block boundary is the same pair of budgets, with the two labels
exchanged after every block. The return equation is a scalar hypothesis here;
the concrete integer candidate supplies it below. -/
theorem periodic_boundary_state
    (m : ℝ) (h : ℕ) (delta : ℝ) (hh : 0 < h)
    (hreturn : m ^ h * delta = (h : ℝ) + delta) (q : ℕ) :
    state m ((h : ℝ) + delta, delta) (periodicAction h) (q * h) =
      if blockAction q then (delta, (h : ℝ) + delta)
      else ((h : ℝ) + delta, delta) := by
  induction q with
  | zero => simp [blockAction, state]
  | succ q ih =>
    rw [Nat.succ_mul]
    rw [state_add_of_constant m _ _ (q * h) h (blockAction q)
      (fun j hj => periodic_action_in_block h q j hh hj)]
    rw [ih, block_action_successor]
    cases hb : blockAction q <;> simp only [hb, Bool.not_false, Bool.not_true,
      Bool.false_eq_true, ↓reduceIte]
    · rw [repeat_false, hreturn]
      exact Prod.ext (by dsimp; ring) rfl
    · rw [repeat_true, hreturn]
      exact Prod.ext rfl (by dsimp; ring)

/-- Exact trajectory at any position within any block of the infinite word. -/
theorem periodic_block_state
    (m : ℝ) (h : ℕ) (delta : ℝ) (hh : 0 < h)
    (hreturn : m ^ h * delta = (h : ℝ) + delta)
    (q j : ℕ) (hj : j ≤ h) :
    state m ((h : ℝ) + delta, delta) (periodicAction h) (q * h + j) =
      if blockAction q then (m ^ j * delta, (h : ℝ) + delta - j)
      else ((h : ℝ) + delta - j, m ^ j * delta) := by
  rw [state_add_of_constant m _ _ (q * h) j (blockAction q)
    (fun k hk => periodic_action_in_block h q k hh (Nat.lt_of_lt_of_le hk hj))]
  rw [periodic_boundary_state m h delta hh hreturn q]
  cases hb : blockAction q <;> simp only [hb, Bool.false_eq_true, ↓reduceIte]
  · exact repeat_false m ((h : ℝ) + delta) delta j
  · exact repeat_true m delta ((h : ℝ) + delta) j

/-- A uniform bound for the active coordinate on one block extends to every
position of the actual infinite periodic trajectory. -/
theorem periodic_small_active
    (m : ℝ) (h : ℕ) (delta : ℝ) (hh : 0 < h)
    (hreturn : m ^ h * delta = (h : ℝ) + delta)
    (hmargin : ∀ j < h, m ^ j * delta < 1) (n : ℕ) :
    SmallActive
      (state m ((h : ℝ) + delta, delta) (periodicAction h) n)
      (periodicAction h n) := by
  have hj : n % h < h := Nat.mod_lt n hh
  have hdecomp : n / h * h + n % h = n := by
    simpa only [Nat.mul_comm, Nat.add_comm] using Nat.mod_add_div n h
  rw [← hdecomp, periodic_block_state m h delta hh hreturn (n / h) (n % h) hj.le,
    periodic_action_in_block h (n / h) (n % h) hh hj]
  cases hb : blockAction (n / h) <;> simpa [SmallActive, hb] using hmargin (n % h) hj

/-- The periodic trajectory is genuinely feasible, including the inactive
coordinate; this is independent of the strict active-coordinate argument. -/
theorem periodic_nonnegative
    (m : ℝ) (h : ℕ) (delta : ℝ) (hh : 0 < h)
    (hm : 0 ≤ m) (hdelta : 0 ≤ delta)
    (hreturn : m ^ h * delta = (h : ℝ) + delta) (n : ℕ) :
    Nonnegative (state m ((h : ℝ) + delta, delta) (periodicAction h) n) := by
  have hj : n % h < h := Nat.mod_lt n hh
  have hdecomp : n / h * h + n % h = n := by
    simpa only [Nat.mul_comm, Nat.add_comm] using Nat.mod_add_div n h
  have hpower : 0 ≤ m ^ (n % h) * delta := mul_nonneg (pow_nonneg hm _) hdelta
  have hcast : ((n % h : ℕ) : ℝ) ≤ h := by exact_mod_cast hj.le
  have hinactive : 0 ≤ (h : ℝ) + delta - (n % h : ℕ) := by linarith
  rw [← hdecomp, periodic_block_state m h delta hh hreturn (n / h) (n % h) hj.le]
  cases hb : blockAction (n / h) <;>
    simp only [hb, Bool.false_eq_true, ↓reduceIte, Nonnegative] <;>
    exact ⟨by assumption, by assumption⟩

noncomputable def candidateDelta (m : ℕ) : ℝ :=
  ((m : ℝ) - 1) / ((m : ℝ) ^ (m - 1) - 1)

/-- The candidate word in Conjecture 21, with positions indexed from zero. -/
def candidate (m n : ℕ) : Bool :=
  if n = 0 then true else if n = 1 then false else periodicAction (m - 1) (n - 2)

noncomputable def candidateInitial (m : ℕ) : State :=
  (1 + candidateDelta m / m, 1 + candidateDelta m / m)

theorem candidate_tail_action (m n : ℕ) :
    candidate m (2 + n) = periodicAction (m - 1) n := by
  simp [candidate, show 2 + n ≠ 0 by omega, show 2 + n ≠ 1 by omega]

theorem candidate_delta_nonnegative (m : ℕ) (hm : 3 ≤ m) :
    0 ≤ candidateDelta m := by
  have hmreal : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have hpower : (1 : ℝ) < (m : ℝ) ^ (m - 1) :=
    one_lt_pow₀ hmreal (by omega)
  exact div_nonneg (by linarith) (by linarith)

theorem candidate_delta_return (m : ℕ) (hm : 3 ≤ m) :
    (m : ℝ) ^ (m - 1) * candidateDelta m = (m - 1 : ℕ) + candidateDelta m := by
  have hmreal : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have hden : (m : ℝ) ^ (m - 1) ≠ 1 :=
    ne_of_gt (one_lt_pow₀ hmreal (by omega))
  have hcast : ((m - 1 : ℕ) : ℝ) = (m : ℝ) - 1 := by
    rw [Nat.cast_sub (by omega : 1 ≤ m), Nat.cast_one]
  simpa only [candidateDelta, hcast] using power_budget_return (m : ℝ) (m - 1) hden

theorem candidate_block_margin (m : ℕ) (hm : 3 ≤ m) (j : ℕ) (hj : j < m - 1) :
    (m : ℝ) ^ j * candidateDelta m < 1 := by
  have hmreal : (1 : ℝ) ≤ m := by exact_mod_cast (show 1 ≤ m by omega)
  have hpower : (m : ℝ) ^ j ≤ (m : ℝ) ^ (m - 2) :=
    pow_le_pow_right₀ hmreal (by omega)
  exact lt_of_le_of_lt
    (mul_le_mul_of_nonneg_right hpower (candidate_delta_nonnegative m hm))
    (conjecture21_power_margin m hm)

theorem candidate_tail_state (m : ℕ) (hm : 3 ≤ m) (n : ℕ) :
    state (m : ℝ) (candidateInitial m) (candidate m) (2 + n) =
      state (m : ℝ) ((m - 1 : ℕ) + candidateDelta m, candidateDelta m)
        (periodicAction (m - 1)) n := by
  induction n with
  | zero =>
    have hmzero : (m : ℝ) ≠ 0 := by exact_mod_cast (show m ≠ 0 by omega)
    have hcast : ((m - 1 : ℕ) : ℝ) = (m : ℝ) - 1 := by
      rw [Nat.cast_sub (by omega : 1 ≤ m), Nat.cast_one]
    simpa only [Nat.add_zero, state, candidate, candidateInitial, ↓reduceIte,
      show (1 : ℕ) ≠ 0 by omega, hcast] using
      initial_two_actions (m : ℝ) (candidateDelta m) hmzero
  | succ n ih =>
    rw [Nat.add_succ, state, candidate_tail_action, ih, state]

/-- The concrete candidate satisfies the strict active-coordinate condition at
EVERY positive time. No infinite family of candidate inequalities is assumed. -/
theorem candidate_small_active (m : ℕ) (hm : 3 ≤ m) (n : ℕ) (hn : 0 < n) :
    SmallActive (state (m : ℝ) (candidateInitial m) (candidate m) n) (candidate m n) := by
  by_cases hn1 : n = 1
  · subst n
    have hd : candidateDelta m < 1 := by
      simpa using candidate_block_margin m hm 0 (by omega)
    have hmreal : (1 : ℝ) ≤ m := by exact_mod_cast (show 1 ≤ m by omega)
    have hdiv : candidateDelta m / m ≤ candidateDelta m :=
      div_le_self (candidate_delta_nonnegative m hm) hmreal
    simp only [state, candidate, candidateInitial, SmallActive, step, ↓reduceIte,
      show (1 : ℕ) ≠ 0 by omega, Bool.false_eq_true]
    linarith
  · obtain ⟨k, hk⟩ : ∃ k : ℕ, n = 2 + k := ⟨n - 2, by omega⟩
    rw [hk, candidate_tail_state m hm k, candidate_tail_action]
    exact periodic_small_active (m : ℝ) (m - 1) (candidateDelta m) (by omega)
      (candidate_delta_return m hm) (candidate_block_margin m hm) k

/-- Uniqueness for the specific ultimately periodic candidate in the residual-
budget model. The old generic theorem's `hsmall` hypothesis is now discharged. -/
theorem concrete_candidate_rigidity (m : ℕ) (hm : 3 ≤ m) (schedule : ℕ → Bool)
    (hfirst : schedule 0 = true)
    (hfeasible : ∀ n, Nonnegative
      (state (m : ℝ) (candidateInitial m) schedule n)) :
    schedule = candidate m := by
  apply infinite_schedule_rigidity (m : ℝ) (candidateInitial m) schedule (candidate m)
  · simpa [candidate] using hfirst
  · exact candidate_small_active m hm
  · exact hfeasible

/-- The explicit candidate itself has nonnegative budgets at every time, so the
feasible class in concrete_candidate_rigidity is nonempty. -/
theorem candidate_nonnegative (m : ℕ) (hm : 3 ≤ m) (n : ℕ) :
    Nonnegative (state (m : ℝ) (candidateInitial m) (candidate m) n) := by
  have hm0 : (0 : ℝ) ≤ m := Nat.cast_nonneg m
  have hd0 := candidate_delta_nonnegative m hm
  have hdiv0 : 0 ≤ candidateDelta m / m := div_nonneg hd0 hm0
  rcases n with _ | (_ | n)
  · simp only [state, candidateInitial, Nonnegative]
    constructor <;> linarith
  · simp only [state, candidateInitial, candidate, step, Nonnegative, ↓reduceIte]
    constructor
    · exact mul_nonneg hm0 (by linarith)
    · linarith
  · rw [show n + 1 + 1 = 2 + n by omega, candidate_tail_state m hm]
    exact periodic_nonnegative (m : ℝ) (m - 1) (candidateDelta m) (by omega)
      hm0 hd0 (candidate_delta_return m hm) n

/-- Exact characterization of all feasible residual-budget trajectories with
first action box 1. Both implications are kernel checked. -/
theorem candidate_feasibility_iff (m : ℕ) (hm : 3 ≤ m) (schedule : ℕ → Bool)
    (hfirst : schedule 0 = true) :
    (∀ n, Nonnegative (state (m : ℝ) (candidateInitial m) schedule n)) ↔
      schedule = candidate m := by
  constructor
  · exact concrete_candidate_rigidity m hm schedule hfirst
  · intro heq
    subst schedule
    exact candidate_nonnegative m hm

end PureSearch

#print axioms PureSearch.state_add_of_constant
#print axioms PureSearch.periodic_action_in_block
#print axioms PureSearch.block_action_successor
#print axioms PureSearch.candidate_tail_action
#print axioms PureSearch.periodic_boundary_state
#print axioms PureSearch.periodic_block_state
#print axioms PureSearch.periodic_small_active
#print axioms PureSearch.periodic_nonnegative
#print axioms PureSearch.candidate_delta_nonnegative
#print axioms PureSearch.candidate_delta_return
#print axioms PureSearch.candidate_block_margin
#print axioms PureSearch.candidate_tail_state
#print axioms PureSearch.candidate_small_active
#print axioms PureSearch.concrete_candidate_rigidity
#print axioms PureSearch.candidate_nonnegative
#print axioms PureSearch.candidate_feasibility_iff
