import SchedulingModel

/-! Equal-rate continuation, using attained common service as a clock. -/

open scoped BigOperators

namespace FiniteFrontier

variable {ι : Type*} [Fintype ι]

/-- Equal-rate continuation from a nonnegative residual vector. A job leaves when the
common attained increment reaches its residual demand. -/
def roundRobinIncrement (residual : ι → ℝ) (q : ℝ) (i : ι) : ℝ := min (residual i) q

noncomputable def roundRobinClock (residual : ι → ℝ) (q : ℝ) : ℝ :=
  ∑ i, roundRobinIncrement residual q i

theorem round_robin_clock_zero (r : ι → ℝ) (hr : ∀ i, 0 ≤ r i) :
    roundRobinClock r 0 = 0 := by
  simp [roundRobinClock, roundRobinIncrement, min_eq_right (hr _)]

theorem round_robin_clock_monotone (r : ι → ℝ) : Monotone (roundRobinClock r) := by
  intro s t h
  exact Finset.sum_le_sum fun i _ => min_le_min_left (r i) h

theorem round_robin_clock_at_completion (r : ι → ℝ) (q : ℝ) (i : ι) :
    min (roundRobinClock r q) (roundRobinClock r (r i)) =
      ∑ j, min (roundRobinIncrement r q i) (roundRobinIncrement r q j) := by
  have hm : min (roundRobinClock r q) (roundRobinClock r (r i)) =
      roundRobinClock r (min (r i) q) := by
    rcases le_total q (r i) with h | h
    · rw [min_eq_left (round_robin_clock_monotone r h), min_eq_right h]
    · rw [min_eq_right (round_robin_clock_monotone r h), min_eq_left h]
  rw [hm]
  apply Finset.sum_congr rfl
  intro j _
  unfold roundRobinIncrement
  exact le_antisymm
    (le_min (min_le_right _ _) (le_min (min_le_left _ _) ((min_le_right _ _).trans (min_le_right _ _))))
    (le_min ((min_le_right _ _).trans (min_le_left _ _)) (min_le_left _ _))

/-- Actual total completion cost accrued in a round-robin prefix. Each summand is
elapsed physical time clipped at the corresponding job's completion time. -/
noncomputable def roundRobinPaid (r : ι → ℝ) (q : ℝ) : ℝ :=
  ∑ i, min (roundRobinClock r q) (roundRobinClock r (r i))

theorem round_robin_paid_pair_sum (r : ι → ℝ) (q : ℝ) :
    roundRobinPaid r q =
      ∑ i, ∑ j, min (roundRobinIncrement r q i) (roundRobinIncrement r q j) :=
  Finset.sum_congr rfl fun i _ => round_robin_clock_at_completion r q i

theorem round_robin_bound (r : ι → ℝ) (q : ℝ) :
    roundRobinPaid r q ≤
      baselineRobustness (Fintype.card ι : ℝ) * frozenCost (roundRobinIncrement r q) := by
  rw [round_robin_paid_pair_sum]
  let w := roundRobinIncrement r q
  let N : ℝ := Fintype.card ι
  have hn : 0 < N + 1 := by
    unfold N
    positivity
  have hb : (∑ i, ∑ j, min (w i) (w j)) ≤ N * ∑ i, w i := by
    calc
      _ ≤ ∑ i, ∑ _j : ι, w i :=
        Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun _ _ => min_le_left _ _
      _ = _ := by simp [N, Finset.mul_sum]
  change (∑ i, ∑ j, min (w i) (w j)) ≤ baselineRobustness N * frozenCost w
  have hscaled : baselineRobustness N * frozenCost w * (N + 1) =
      N * ((∑ i, w i) + ∑ i, ∑ j, min (w i) (w j)) := by
    unfold baselineRobustness frozenCost
    calc
      _ = (2 * N / (N + 1) * (N + 1)) *
          (((∑ i, w i) + ∑ i, ∑ j, min (w i) (w j)) / 2) := by ring
      _ = _ := by rw [div_mul_cancel₀ (2 * N) hn.ne']; ring
  apply (mul_le_mul_right hn).mp
  rw [hscaled]
  nlinarith only [hb]

/-- The frozen invariant is preserved throughout round-robin continuation.
The proof sums the exact pair charges over a prefix, including ties and already completed jobs. -/
theorem round_robin_preserves_frozen (base residual : ι → ℝ) (paid R q : ℝ)
    (hR : baselineRobustness (Fintype.card ι : ℝ) ≤ R)
    (hR₀ : 0 ≤ R) (hpaid : paid ≤ R * frozenCost base)
    (hr : ∀ i, 0 ≤ residual i) (hq : 0 ≤ q) :
    paid + roundRobinPaid residual q ≤
      R * frozenCost (fun i => base i + roundRobinIncrement residual q i) := by
  let w := roundRobinIncrement residual q
  have hw : 0 ≤ frozenCost w := frozen_nonneg w (fun i => le_min (hr i) hq)
  calc
    _ ≤ R * frozenCost base + baselineRobustness (Fintype.card ι : ℝ) * frozenCost w :=
      add_le_add hpaid (round_robin_bound residual q)
    _ ≤ R * frozenCost base + R * frozenCost w :=
      add_le_add_left (mul_le_mul_of_nonneg_right hR hw) _
    _ = R * (frozenCost base + frozenCost w) := by ring
    _ ≤ _ := mul_le_mul_of_nonneg_left (frozen_superadditive base w) hR₀

end FiniteFrontier
