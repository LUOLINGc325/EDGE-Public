import SnapshotGuarantees

/-! Velocity on event-free intervals of the actual service clocks. -/

open scoped BigOperators

namespace FiniteFrontier

variable {ι : Type*} [Fintype ι]

theorem Run.paid_increment_event_free {x : ι → ℝ} (r : Run x) (u t : ℝ)
    (h : ∀ i, u < r.completion i → t ≤ r.completion i) (hut : u ≤ t) :
    r.paidCost t - r.paidCost u =
      ((Finset.univ.filter fun i => u < r.completion i).card : ℝ) * (t - u) := by
  unfold Run.paidCost
  rw [← Finset.sum_sub_distrib]
  calc
    _ = ∑ i, if u < r.completion i then t - u else 0 := by
      apply Finset.sum_congr rfl
      intro i _
      by_cases hi : u < r.completion i
      · rw [if_pos hi, min_eq_left (h i hi), min_eq_left hi.le]
      · have h' := le_of_not_gt hi
        rw [if_neg hi, min_eq_right (h'.trans hut), min_eq_right h', sub_self]
    _ = _ := by
      rw [← Finset.sum_filter]
      simp [nsmul_eq_mul]
      ring

noncomputable def equalIncrement (active : Finset ι) (δ : ℝ) (i : ι) : ℝ := by
  classical
  exact if i ∈ active then δ else 0

theorem sum_equal_increment (active : Finset ι) (δ : ℝ) :
    (∑ i, equalIncrement active δ i) = (active.card : ℝ) * δ := by
  classical
  unfold equalIncrement
  rw [← Finset.sum_filter]
  simp [nsmul_eq_mul]

theorem frozen_equal_increment (active : Finset ι) (δ : ℝ) (hδ : 0 ≤ δ) :
    frozenCost (equalIncrement active δ) = triangularCost (active.card : ℝ) * δ := by
  classical
  have hmin (i j : ι) :
      min (equalIncrement active δ i) (equalIncrement active δ j) =
        if i ∈ active then equalIncrement active δ j else 0 := by
    by_cases hi : i ∈ active <;> by_cases hj : j ∈ active <;>
      simp [equalIncrement, hi, hj, min_eq_left hδ, min_eq_right hδ]
  have hpair :
      (∑ i, ∑ j, min (equalIncrement active δ i) (equalIncrement active δ j)) =
        (active.card : ℝ) * ((active.card : ℝ) * δ) := by
    simp only [hmin, Finset.sum_ite_irrel, Finset.sum_const_zero, sum_equal_increment]
    change (∑ i, equalIncrement active ((active.card : ℝ) * δ) i) = _
    rw [sum_equal_increment]
  unfold frozenCost triangularCost
  rw [sum_equal_increment, hpair]
  ring

theorem round_robin_quantum_segment (r : ι → ℝ) (q s : ℝ) (hqs : q ≤ s)
    (h : ∀ i, q < r i → s ≤ r i) :
    (fun i => roundRobinIncrement r s i - roundRobinIncrement r q i) =
      equalIncrement (Finset.univ.filter fun i => q < r i) (s - q) := by
  classical
  funext i
  unfold roundRobinIncrement equalIncrement
  by_cases hi : q < r i
  · simp [hi, min_eq_right hi.le, min_eq_right (h i hi)]
  have hi' := le_of_not_gt hi
  simp [hi, min_eq_left hi', min_eq_left (hi'.trans hqs)]

theorem round_robin_segment_clock (r : ι → ℝ) (q s : ℝ) (hqs : q ≤ s)
    (h : ∀ i, q < r i → s ≤ r i) :
    roundRobinClock r s - roundRobinClock r q =
      ((Finset.univ.filter fun i => q < r i).card : ℝ) * (s - q) := by
  unfold roundRobinClock
  rw [← Finset.sum_sub_distrib]
  change (∑ i, (fun j => roundRobinIncrement r s j - roundRobinIncrement r q j) i) = _
  rw [round_robin_quantum_segment r q s hqs h, sum_equal_increment]

/-- The lower bound on frozen-cost increase in a round-robin interval, with the
actual number of residual jobs. This is the finite-increment form of equation (3). -/
theorem round_robin_frozen_segment (base r : ι → ℝ) (q s : ℝ) (hqs : q ≤ s)
    (h : ∀ i, q < r i → s ≤ r i) :
    frozenCost (fun i => base i + roundRobinIncrement r q i) +
      (((Finset.univ.filter fun i => q < r i).card : ℝ) + 1) / 2 *
        (roundRobinClock r s - roundRobinClock r q) ≤
      frozenCost (fun i => base i + roundRobinIncrement r s i) := by
  let a := Finset.univ.filter fun i => q < r i
  have hinc : (fun i => base i + roundRobinIncrement r q i + equalIncrement a (s - q) i) =
      (fun i => base i + roundRobinIncrement r s i) := by
    funext i
    have hh := congrFun (round_robin_quantum_segment r q s hqs h) i
    change roundRobinIncrement r s i - roundRobinIncrement r q i = equalIncrement a (s - q) i at hh
    linarith only [hh]
  have hF := frozen_superadditive (fun i => base i + roundRobinIncrement r q i)
    (equalIncrement a (s - q))
  rw [hinc, frozen_equal_increment a _ (sub_nonneg.mpr hqs)] at hF
  rw [round_robin_segment_clock r q s hqs h]
  change frozenCost (fun i => base i + roundRobinIncrement r q i) +
    (((a.card : ℝ) + 1) / 2) * ((a.card : ℝ) * (s - q)) ≤ _
  unfold triangularCost at hF
  linarith only [hF]

theorem Run.service_is_unit_lipschitz {x : ι → ℝ} (r : Run x) (i : ι) (u t : ℝ)
    (hu : 0 ≤ u) (ht : 0 ≤ t) :
    |r.service t i - r.service u i| ≤ |t - u| := by
  classical
  rcases le_total u t with hut | htu
  · rw [abs_of_nonneg (sub_nonneg.mpr (r.service_mono i u t hu hut)),
      abs_of_nonneg (sub_nonneg.mpr hut)]
    exact r.service_increment_le i u t hu hut
  · rw [abs_of_nonpos (sub_nonpos.mpr (r.service_mono i t u ht htu)),
      abs_of_nonpos (sub_nonpos.mpr htu), neg_sub, neg_sub]
    exact r.service_increment_le i t u ht htu

namespace SnapshotPlan

variable {n : ℕ} {y : Fin n → ℝ} (p : SnapshotPlan y)

noncomputable def phaseRate (k : ℕ) (i : Fin n) : ℝ :=
  (p.attained (k + 1) i - p.attained k i) / (p.time (k + 1) - p.time k)

theorem phase_rate_nonneg (k : ℕ) (i : Fin n) : 0 ≤ p.phaseRate k i :=
  div_nonneg (sub_nonneg.mpr (p.monotone i (Nat.le_succ k)))
    (sub_nonneg.mpr (p.time_monotone (Nat.le_succ k)))

theorem phase_rates_sum_to_one (k : ℕ) (h : p.time k < p.time (k + 1)) :
    (∑ i, p.phaseRate k i) = 1 := by
  unfold phaseRate
  rw [← Finset.sum_div, Finset.sum_sub_distrib]
  exact div_self (sub_pos.mpr h).ne'

theorem planned_service_linear_increment (k : ℕ) (hk : k < n) (u t : ℝ)
    (hphase : p.time k < p.time (k + 1)) (hku : p.time k ≤ u) (hut : u ≤ t)
    (htk : t ≤ p.time (k + 1)) (i : Fin n) :
    p.plannedService t i - p.plannedService u i = (t - u) * p.phaseRate k i := by
  rw [p.planned_service_on_phase k hk t (hku.trans hut) htk,
    p.planned_service_on_phase k hk u hku (hut.trans htk)]
  let d := p.time (k + 1) - p.time k
  have hd : 0 < d := sub_pos.mpr hphase
  have he₀ := p.phase_fraction_elapsed k u
  have he₁ := p.phase_fraction_elapsed k t
  rw [min_eq_left (hut.trans htk), min_eq_right hku] at he₀
  rw [min_eq_left htk, min_eq_right (hku.trans hut)] at he₁
  have hc : p.phaseFraction k t - p.phaseFraction k u = (t - u) / d := by
    apply (eq_div_iff hd.ne').mpr
    change d * p.phaseFraction k u = u - p.time k at he₀
    change d * p.phaseFraction k t = t - p.time k at he₁
    linarith only [he₀, he₁]
  calc
    _ = (p.phaseFraction k t - p.phaseFraction k u) *
          (p.attained (k + 1) i - p.attained k i) := by unfold interpolation; ring
    _ = _ := by rw [hc]; unfold phaseRate; change (t - u) / d * _ = (t - u) * (_ / d); ring

end SnapshotPlan

end FiniteFrontier
