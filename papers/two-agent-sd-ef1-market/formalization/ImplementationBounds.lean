import WeakRankings
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Data.Rat.Lemmas
import Mathlib.Data.Nat.Log

open Finset
open scoped BigOperators

namespace MarketFairDivision

/-- The number of inspected quota entries when the added item is in a given rank. -/
def affectedEntries (k qRank : ℕ) : ℕ := k - qRank / 2

theorem affectedEntries_le (k qRank : ℕ) : affectedEntries k qRank ≤ k := Nat.sub_le ..

noncomputable def greedyEntries {Goods : Type*} (p q : Goods ≃ Fin (2 * k)) : ℕ :=
  ∑ i, 2 * affectedEntries k (q (p.symm i)).val

theorem greedy_entries_le {Goods : Type*} (p q : Goods ≃ Fin (2 * k)) :
    greedyEntries p q ≤ 2 * k * (2 * k) := by
  calc
    greedyEntries p q ≤ ∑ _i : Fin (2 * k), 2 * k :=
      Finset.sum_le_sum fun i _ => Nat.mul_le_mul_left 2 (affectedEntries_le _ _)
    _ = _ := by simp [mul_comm, mul_assoc]

/-- Each exchange performs a fixed number of linear scans and copies. This budget
charges each scan up to the full input size, including the feasibility recheck. -/
def exchangeBudget (N swaps : ℕ) : ℕ := 16 * N * swaps

/-- A stored vertex costs at most N weight additions, and half-value scanning
costs at most two comparisons per vertex. -/
def crossingBudget (N swaps : ℕ) : ℕ := (N + 2) * (swaps + 1) + 8 * N

theorem fully_scanned_path_quadratic (k : ℕ) :
    16 * (2 * k) + 2 * k * (2 * k) + exchangeBudget (2 * k) k +
      crossingBudget (2 * k) k ≤ 50 * (2 * k + 1) ^ 2 := by
  unfold exchangeBudget crossingBudget
  nlinarith

theorem stored_vertex_budget (k : ℕ) :
    (2 * k) * (k + 1) ≤ (2 * k + 1) ^ 2 := by nlinarith

theorem padded_size_bound (m : ℕ) : m + m % 2 ≤ m + 1 := by omega

theorem core_output_sort_within_quadratic (N : ℕ) :
    N * Nat.clog 2 N ≤ N ^ 2 := by
  have hp : ∀ n : ℕ, n < 2 ^ n := by
    intro n
    induction n with
    | zero => decide
    | succ n ih => rw [pow_succ]; omega
  rw [pow_two]
  exact Nat.mul_le_mul_left _ ((Nat.le_pow_iff_clog_le (by decide : 1 < 2)).mp (hp N).le)

section ExactRational

variable {Goods : Type*} [DecidableEq Goods]

theorem sum_den_dvd (w : Goods → ℚ) (A : Finset Goods) :
    (∑ x ∈ A, w x).den ∣ ∏ x ∈ A, (w x).den := by
  induction A using Finset.induction_on with
  | empty => simp
  | insert x A hx ih =>
    rw [Finset.sum_insert hx, Finset.prod_insert hx]
    exact (Rat.add_den_dvd _ _).trans (Nat.mul_dvd_mul (dvd_refl _) ih)

theorem denominator_encoder_bound (w : Goods → ℚ)
    (bits : Goods → ℕ) (A : Finset Goods)
    (hd : ∀ x ∈ A, (w x).den ≤ 2 ^ bits x) :
    (∑ x ∈ A, w x).den ≤ 2 ^ (∑ x ∈ A, bits x) := by
  calc
    _ ≤ ∏ x ∈ A, (w x).den :=
      Nat.le_of_dvd (Finset.prod_pos (fun x _ => (w x).den_pos)) (sum_den_dvd w A)
    _ ≤ ∏ x ∈ A, 2 ^ bits x := Finset.prod_le_prod' hd
    _ = _ := by rw [Finset.prod_pow_eq_pow_sum]

theorem rational_abs_le_num (q : ℚ) : |q| ≤ (q.num.natAbs : ℚ) := by
  have hq : q = (q.num : ℚ) / q.den := (Rat.num_div_den q).symm
  have hd : (1 : ℚ) ≤ q.den := by exact_mod_cast q.den_pos
  have hdpos : (0 : ℚ) < q.den := by exact_mod_cast q.den_pos
  calc
    |q| = |(q.num : ℚ)| / q.den := by rw [← abs_of_pos hdpos, ← abs_div, ← hq]
    _ ≤ |(q.num : ℚ)| := (div_le_iff₀ hdpos).mpr
      (le_mul_of_one_le_right (abs_nonneg _) hd)
    _ = _ := by rw [← Int.cast_abs, Int.abs_eq_natAbs, Int.cast_natCast]

omit [DecidableEq Goods] in
theorem rational_sum_storage (w : Goods → ℚ) (L : ℕ) (A : Finset Goods)
    (hd : (∑ x ∈ A, w x).den ≤ 2 ^ L)
    (hn : ∀ x ∈ A, (w x).num.natAbs ≤ 2 ^ L) :
    (∑ x ∈ A, w x).num.natAbs ≤ A.card * 2 ^ (2 * L) := by
  let q := ∑ x ∈ A, w x
  have hsum : |q| ≤ (A.card : ℚ) * 2 ^ L := by
    calc
      |q| ≤ ∑ x ∈ A, |w x| := Finset.abs_sum_le_sum_abs _ _
      _ ≤ ∑ _x ∈ A, (2 : ℚ) ^ L := Finset.sum_le_sum fun x hx =>
        (rational_abs_le_num (w x)).trans (by exact_mod_cast hn x hx)
      _ = _ := by simp [nsmul_eq_mul]
  have hD : (q.den : ℚ) ≤ 2 ^ L := by exact_mod_cast hd
  have hdpos : (0 : ℚ) < q.den := by exact_mod_cast q.den_pos
  have hnum : (q.num.natAbs : ℚ) = |(q.num : ℚ)| := by
    rw [← Int.cast_abs, Int.abs_eq_natAbs, Int.cast_natCast]
  have he : (q.num : ℚ) = q * q.den := (eq_div_iff hdpos.ne').mp (Rat.num_div_den q).symm |>.symm
  have hb : (q.num.natAbs : ℚ) ≤ (A.card : ℚ) * 2 ^ (2 * L) := by
    rw [hnum, he, abs_mul, abs_of_nonneg hdpos.le]
    calc
      |q| * (q.den : ℚ) ≤ ((A.card : ℚ) * 2 ^ L) * 2 ^ L :=
        mul_le_mul hsum hD hdpos.le (by positivity)
      _ = _ := by rw [two_mul, pow_add, mul_assoc]
  exact_mod_cast hb

omit [DecidableEq Goods] in
theorem rational_sum_binary_width (w : Goods → ℚ) (L : ℕ) (A : Finset Goods)
    (hd : (∑ x ∈ A, w x).den ≤ 2 ^ L)
    (hn : ∀ x ∈ A, (w x).num.natAbs ≤ 2 ^ L) :
    (∑ x ∈ A, w x).num.natAbs ≤ 2 ^ (2 * L + Nat.clog 2 (A.card + 1)) := by
  have hc := (Nat.le_succ A.card).trans (Nat.le_pow_clog (by decide : 1 < 2) (A.card + 1))
  calc
    _ ≤ A.card * 2 ^ (2 * L) := rational_sum_storage w L A hd hn
    _ ≤ (2 : ℕ) ^ Nat.clog 2 (A.card + 1) * 2 ^ (2 * L) := Nat.mul_le_mul_right _ hc
    _ = _ := by rw [pow_add, mul_comm]

end ExactRational

end MarketFairDivision
