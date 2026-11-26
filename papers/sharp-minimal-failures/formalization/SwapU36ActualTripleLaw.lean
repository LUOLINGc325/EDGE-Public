import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

namespace SwapRoundingMinimalFailures

/-- The adaptive three-coin law in Section 3. The false first coin uses the
matching (2,5),(3,6); the true coin uses (2,6),(3,5). -/
noncomputable def U36Outcome : Bool × Bool × Bool → Finset ℕ
  | (true, true, true) => {1, 2, 3}
  | (true, true, false) => {1, 2, 5}
  | (true, false, true) => {1, 6, 3}
  | (true, false, false) => {1, 6, 5}
  | (false, true, true) => {4, 2, 3}
  | (false, true, false) => {4, 2, 6}
  | (false, false, true) => {4, 5, 3}
  | (false, false, false) => {4, 5, 6}

noncomputable def U36Coin (p : ℝ) (b : Bool) : ℝ :=
  if b then p else 1-p

noncomputable def U36Expectation (p : ℝ) (f : Bool × Bool × Bool → ℝ) : ℝ :=
  ∑ x, U36Coin p x.1 * U36Coin p x.2.1 * U36Coin p x.2.2 * f x

noncomputable def U36Ind (i : ℕ) (x : Bool × Bool × Bool) : ℝ :=
  if i ∈ U36Outcome x then 1 else 0

theorem U36_outcome_card (x : Bool × Bool × Bool) : (U36Outcome x).card = 3 := by
  rcases x with ⟨a,b,c⟩
  cases a <;> cases b <;> cases c <;> decide

theorem U36_ambient_mass_one (p : ℝ) : U36Expectation p (fun _ => 1) = 1 := by
  simp only [U36Expectation, Fintype.sum_prod_type, Fintype.sum_bool, U36Coin]
  norm_num
  ring

theorem U36_mean_one (p : ℝ) : U36Expectation p (U36Ind 1) = p := by
  simp only [U36Expectation, Fintype.sum_prod_type, Fintype.sum_bool]
  norm_num [U36Coin, U36Outcome, U36Ind, Finset.mem_insert, Finset.mem_singleton]
  ring

theorem U36_mean_two_five (p : ℝ) :
    U36Expectation p (fun x => U36Ind 2 x * U36Ind 5 x) = p^2*(1-p) := by
  simp only [U36Expectation, Fintype.sum_prod_type, Fintype.sum_bool]
  norm_num [U36Coin, U36Outcome, U36Ind, Finset.mem_insert, Finset.mem_singleton]
  ring_nf
  simp

theorem U36_mean_one_two_five (p : ℝ) :
    U36Expectation p (fun x => U36Ind 1 x * (U36Ind 2 x * U36Ind 5 x)) = p^2*(1-p) := by
  simp only [U36Expectation, Fintype.sum_prod_type, Fintype.sum_bool]
  norm_num [U36Coin, U36Outcome, U36Ind, Finset.mem_insert, Finset.mem_singleton]
  ring_nf
  simp

/-- Positive covariance of the adaptive two-base witness. -/
theorem U36_covariance (p : ℝ) :
    U36Expectation p (fun x => U36Ind 1 x * (U36Ind 2 x * U36Ind 5 x)) -
      U36Expectation p (U36Ind 1) *
        U36Expectation p (fun x => U36Ind 2 x * U36Ind 5 x) = p^2*(1-p)^2 := by
  rw [U36_mean_one_two_five, U36_mean_one, U36_mean_two_five]
  ring

theorem U36_positive_covariance {p : ℝ} (hp : 0 < p) (hp1 : p < 1) :
    0 < p^2*(1-p)^2 :=
  mul_pos (pow_pos hp _) (pow_pos (sub_pos.mpr hp1) _)

end SwapRoundingMinimalFailures
