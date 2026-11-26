import Mathlib.Algebra.BigOperators.Group.Finset.Sigma
import Mathlib.Tactic.Ring
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.Fin
import Mathlib.Data.Real.Basic
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith

namespace StockoutPoissonBridge

open Finset

/-- The pointwise counting identity for utilization in equation (6). -/
theorem layer_cake_min_div (k d : ℕ) (hk : 0 < k) :
    min ((d : ℝ) / k) 1
      = 1 - (((range k).filter (fun j => d ≤ j)).card : ℝ) / k := by
  have hkR : 0 < (k : ℝ) := by exact_mod_cast hk
  have hfilt : (range k).filter (fun j => d ≤ j) = Ico d k := by
    ext j
    simp [and_comm]
  rw [hfilt, Nat.card_Ico]
  by_cases hd : d ≤ k
  · have hdR : (d : ℝ) ≤ k := by exact_mod_cast hd
    rw [Nat.cast_sub hd, min_eq_left ((div_le_one hkR).2 hdR)]
    field_simp
  · have hdR : (k : ℝ) ≤ d := by exact_mod_cast (le_of_lt (Nat.lt_of_not_ge hd))
    rw [Nat.sub_eq_zero_of_le (le_of_lt (Nat.lt_of_not_ge hd)), Nat.cast_zero, zero_div, sub_zero]
    exact min_eq_right ((le_div_iff₀ hkR).2 (by simpa using hdR))

/-- Equation (6) for an arbitrary finite weighted count distribution. -/
theorem layer_cake_weighted {ι : Type*} [Fintype ι] {k : ℕ} (hk : 0 < k)
    (p : ι → ℝ) (hp : ∑ i, p i = 1) (Y : ι → ℕ) :
    (∑ i, p i * min ((Y i : ℝ) / k) 1)
      = 1 - (∑ j ∈ range k, ∑ i, p i * (if Y i ≤ j then (1 : ℝ) else 0)) / k := by
  have count_as_sum (i : ι) :
      (((range k).filter (fun j => Y i ≤ j)).card : ℝ)
        = ∑ j ∈ range k, if Y i ≤ j then (1 : ℝ) else 0 :=
    (Finset.sum_boole (fun j => Y i ≤ j) (range k)).symm
  simp only [layer_cake_min_div k _ hk, count_as_sum, mul_sub, mul_one, sum_sub_distrib, hp]
  congr 1
  simp_rw [div_eq_mul_inv, ← mul_assoc, Finset.mul_sum]
  simp_rw [← Finset.sum_mul]
  rw [Finset.sum_comm]

end StockoutPoissonBridge
