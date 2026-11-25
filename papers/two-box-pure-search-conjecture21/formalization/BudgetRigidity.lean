import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum

/-!
# Residual-budget rigidity for deterministic two-box search

The state is the pair of centered normalized residual budgets
`z_i = (V - P_i) / r^(N_i) - Q`, where `Q = 1/q`.
Thus the initial coordinates are `1 + delta/m`, not the uncentered budgets.
`true` means search box 1 and `false` means search box 2. The infinite-schedule theorem is conditional
on explicit state inequalities. This file does not formalize expected search
times, infinite survival sums, or the candidate's modular schedule.
-/

set_option autoImplicit false

namespace PureSearch

abbrev State := ℝ × ℝ

def step (m : ℝ) (action : Bool) (s : State) : State :=
  if action then (m * s.1, s.2 - 1) else (s.1 - 1, m * s.2)

def state (m : ℝ) (initial : State) (schedule : ℕ → Bool) : ℕ → State
  | 0 => initial
  | n + 1 => step m (schedule n) (state m initial schedule n)

def Nonnegative (s : State) : Prop := 0 ≤ s.1 ∧ 0 ≤ s.2

def SmallActive (s : State) (action : Bool) : Prop :=
  if action then s.1 < 1 else s.2 < 1

/-- If the coordinate that should be searched is below one, the opposite action
would make it negative. Every feasible next action is therefore determined. -/
theorem forced_action (m : ℝ) (s : State) (desired actual : Bool)
    (hsmall : SmallActive s desired)
    (hfeasible : Nonnegative (step m actual s)) : actual = desired := by
  cases desired <;> cases actual <;>
    simp_all [SmallActive, Nonnegative, step] <;> linarith

/-- Actual recursive state trajectories, not merely finite words: all feasible
infinite schedules with the candidate's first action coincide with it, provided
the candidate's prescribed active budget is strictly below one at later times. -/
theorem infinite_schedule_rigidity
    (m : ℝ) (initial : State) (schedule candidate : ℕ → Bool)
    (hfirst : schedule 0 = candidate 0)
    (hsmall : ∀ n, 0 < n →
      SmallActive (state m initial candidate n) (candidate n))
    (hfeasible : ∀ n, Nonnegative (state m initial schedule n)) :
    schedule = candidate := by
  have h : ∀ n, state m initial schedule n = state m initial candidate n ∧
      schedule n = candidate n := by
    intro n
    induction n with
    | zero => exact ⟨rfl, hfirst⟩
    | succ n ih =>
      have heq : state m initial schedule (n + 1) =
          state m initial candidate (n + 1) := by
        simp only [state]
        rw [ih.1, ih.2]
      refine ⟨heq, ?_⟩
      apply forced_action m (state m initial candidate (n + 1))
        (candidate (n + 1)) (schedule (n + 1))
        (hsmall (n + 1) (Nat.succ_pos n))
      have hn := hfeasible (n + 2)
      change Nonnegative
        (step m (schedule (n + 1)) (state m initial schedule (n + 1))) at hn
      rw [heq] at hn
      exact hn
  funext n
  exact (h n).2

/-- A wrong action with active centered budget `z<1` gives a strict payoff
deficit. Here `X` is the prefix contribution AFTER the wrong action, while
`probability` is unchanged because that action did not search the active box.
The expected-value lower bound for the residual tail remains an explicit premise. -/
theorem first_deviation_strict_loss
    (U V X probability Q z : ℝ)
    (hprobability : 0 < probability) (hsmall : z < 1)
    (hbudget : V = X + probability * (Q + z - 1))
    (htail : X + probability * Q ≤ U) :
    V + probability * (1 - z) ≤ U ∧ V < U := by
  constructor
  · nlinarith [hbudget]
  · nlinarith [mul_pos hprobability (sub_pos.mpr hsmall)]

def repeatAction (m : ℝ) (action : Bool) (s : State) : ℕ → State
  | 0 => s
  | n + 1 => step m action (repeatAction m action s n)

/-- The complete state after an arbitrary finite block of box-2 searches. -/
theorem repeat_false (m x y : ℝ) (n : ℕ) :
    repeatAction m false (x, y) n = (x - n, m ^ n * y) := by
  induction n with
  | zero => simp [repeatAction]
  | succ n ih =>
    simp only [repeatAction, ih, step, Bool.false_eq_true, ↓reduceIte,
      Nat.cast_add, Nat.cast_one, pow_succ]
    apply Prod.ext <;> dsimp <;> ring

/-- The symmetric finite-block state identity. -/
theorem repeat_true (m x y : ℝ) (n : ℕ) :
    repeatAction m true (x, y) n = (m ^ n * x, y - n) := by
  induction n with
  | zero => simp [repeatAction]
  | succ n ih =>
    simp only [repeatAction, ih, step, ↓reduceIte,
      Nat.cast_add, Nat.cast_one, pow_succ]
    apply Prod.ext <;> dsimp <;> ring

/-- The normalized budget after the initial searches 1 then 2. -/
theorem initial_two_actions (m delta : ℝ) (hm : m ≠ 0) :
    step m false (step m true (1 + delta / m, 1 + delta / m)) =
      (m - 1 + delta, delta) := by
  simp only [step, ↓reduceIte, Bool.false_eq_true]
  apply Prod.ext
  · dsimp
    field_simp
    ring
  · dsimp
    field_simp

/-- The exact geometric return identity used at every block boundary. -/
theorem power_budget_return (m : ℝ) (h : ℕ) (hden : m ^ h ≠ 1) :
    m ^ h * ((h : ℝ) / (m ^ h - 1)) =
      (h : ℝ) + (h : ℝ) / (m ^ h - 1) := by
  have hnonzero : m ^ h - 1 ≠ 0 := sub_ne_zero.mpr hden
  field_simp
  ring

/-- A complete block exchanges the two residual budgets. -/
theorem block_exchange (m : ℝ) (h : ℕ) (hden : m ^ h ≠ 1) :
    repeatAction m false
      ((h : ℝ) + (h : ℝ) / (m ^ h - 1), (h : ℝ) / (m ^ h - 1)) h =
      ((h : ℝ) / (m ^ h - 1), (h : ℝ) + (h : ℝ) / (m ^ h - 1)) := by
  rw [repeat_false, power_budget_return m h hden]
  apply Prod.ext
  · dsimp
    ring
  · rfl

/-- The strict last-step margin, valid uniformly in a positive natural exponent.
Taking `n=m-2` gives the strict margin in Conjecture 21. -/
theorem power_margin (m : ℝ) (n : ℕ) (hm : 1 < m) (hn : 0 < n) :
    m ^ n * ((m - 1) / (m ^ (n + 1) - 1)) < 1 := by
  have hp : 1 < m ^ n := one_lt_pow₀ hm (Nat.ne_zero_of_lt hn)
  have hd : 0 < m ^ (n + 1) - 1 := by
    rw [pow_succ]
    nlinarith
  rw [← mul_div_assoc]
  apply (div_lt_one hd).mpr
  rw [pow_succ]
  nlinarith

/-- The precise all-integer margin of the manuscript. -/
theorem conjecture21_power_margin (m : ℕ) (hm : 3 ≤ m) :
    (m : ℝ) ^ (m - 2) *
      (((m : ℝ) - 1) / ((m : ℝ) ^ (m - 1) - 1)) < 1 := by
  have hmreal : (1 : ℝ) < m := by exact_mod_cast (show 1 < m by omega)
  have hn : 0 < m - 2 := by omega
  have heq : m - 2 + 1 = m - 1 := by omega
  simpa only [heq] using power_margin (m : ℝ) (m - 2) hmreal hn

#print axioms forced_action
#print axioms infinite_schedule_rigidity
#print axioms first_deviation_strict_loss
#print axioms repeat_false
#print axioms repeat_true
#print axioms initial_two_actions
#print axioms power_budget_return
#print axioms block_exchange
#print axioms power_margin
#print axioms conjecture21_power_margin

end PureSearch
