import FrontierInverse

/-! Identification with Li, Christianson and Li, arXiv:2610.29037v2,
Definitions 3.7–3.8 (equations (6), (7), and (10)). -/

open scoped BigOperators

namespace FiniteFrontier

/-- The source chooses the shallower of adjacent depths at shared endpoints.
Depth one includes the serial endpoint. -/
structure PublishedDepth (n : ℕ) (R : ℝ) (a : ℕ) : Prop where
  branch : UnitBranch n R a
  positive : 0 < a
  endpoint_owner : a = 1 ∨ 0 < unitGap (n : ℝ) R a
  admissible : baselineRobustness (n : ℝ) < R

theorem equivalent_branch_value {m a b : ℕ} {R : ℝ}
    (ha : UnitBranch m R a) (hb : UnitBranch m R b) :
    unitValue m R a = unitValue m R b := by
  have hRp := ha.parameter_positive
  have hR : 0 < R + 1 := by linarith
  have had := ha.active
  have hai := ha.inactive
  have hbd := hb.active
  have hbi := hb.inactive
  unfold unitGap at had hai hbd hbi
  have hl : (a : ℝ) ≤ (b : ℝ) + 1 :=
    (mul_le_mul_left hR).mp (by linarith only [had, hbi])
  have hu : (b : ℝ) ≤ (a : ℝ) + 1 :=
    (mul_le_mul_left hR).mp (by linarith only [hbd, hai])
  have hl' : a ≤ b + 1 := by exact_mod_cast hl
  have hu' : b ≤ a + 1 := by exact_mod_cast hu
  by_cases he : a = b
  · rw [he]
  have hcase : a = b + 1 ∨ b = a + 1 := by omega
  rw [unit_value_eq_branch_value _ _ _ ha.num_jobs_real ha.robust ha.index_real,
    unit_value_eq_branch_value _ _ _ hb.num_jobs_real hb.robust hb.index_real]
  rcases hcase with hab | hba
  · rw [hab, Nat.cast_succ] at had
    have hh : (m : ℝ) + 1 = (R + 1) * ((b : ℝ) + 1) := by linarith only [had, hbi]
    rw [hab, hh, branch_value_agrees_at_cutoff R b hRp]
  · rw [hba, Nat.cast_succ] at hbd
    have hh : (m : ℝ) + 1 = (R + 1) * ((a : ℝ) + 1) := by linarith only [hbd, hai]
    rw [hba, hh, branch_value_agrees_at_cutoff R a hRp]

theorem has_published_depth {n : ℕ} (hn : 1 < n) (R : ℝ)
    (hRb : baselineRobustness (n : ℝ) < R) (hRn : R ≤ n) :
    ∃ a, PublishedDepth n R a := by
  have hn₀ : 0 < n := by omega
  have hn₁ : (1 : ℝ) < n := by exact_mod_cast hn
  by_cases hserial : R = (n : ℝ)
  · refine ⟨1, ⟨⟨hn₀, hRb.le, hn, ?_, ?_⟩, by omega, Or.inl rfl, hRb⟩⟩
    · rw [hserial]
      simp only [unitGap, Nat.cast_one]
      ring_nf
      exact le_rfl
    · rw [hserial]
      simp only [unitGap, Nat.cast_one]
      linarith only [hn₁]
  have hlt : R < (n : ℝ) := lt_of_le_of_ne hRn hserial
  let b := unit_index_is_branch n R hn₀ hRb.le
  let a := unitIndex n R
  have ha : 0 < a := by
    by_contra! hz
    have hzero : a = 0 := by omega
    have h := b.inactive
    change unitGap (n : ℝ) R ((a : ℝ) + 1) ≤ 0 at h
    rw [hzero, Nat.cast_zero, zero_add] at h
    unfold unitGap at h
    linarith only [h, hlt]
  by_cases ha1 : a = 1
  · exact ⟨a, ⟨b, ha, Or.inl ha1, hRb⟩⟩
  rcases eq_or_lt_of_le b.active with hEq | hgt
  · let k := a - 1
    have hk : k + 1 = a := by omega
    have hk₀ : 0 < k := by omega
    have hkn : k < n := by have h := b.index; omega
    have hcast : (k : ℝ) + 1 = (a : ℝ) := by exact_mod_cast hk
    have hRpos := b.parameter_positive
    have hd : unitGap (n : ℝ) R k = R + 1 := by
      change 0 = unitGap (n : ℝ) R a at hEq
      unfold unitGap at hEq ⊢
      rw [← hcast] at hEq
      linarith only [hEq]
    have hkp : 0 < unitGap (n : ℝ) R k := by rw [hd]; linarith
    have hnext : unitGap (n : ℝ) R ((k : ℝ) + 1) ≤ 0 := by
      rw [hcast]
      exact hEq.ge
    exact ⟨k, ⟨⟨hn₀, hRb.le, hkn, hkp.le, hnext⟩, hk₀, Or.inr hkp, hRb⟩⟩
  · exact ⟨a, ⟨b, ha, Or.inr hgt, hRb⟩⟩

/-- Literal Order-a equations on the published depth domain. The auxiliary zero
index makes the sum start at zero while retaining exactly the published terms. -/
def PublishedOrderEquations (n a : ℕ) (excess R : ℝ) (p : ℕ → ℝ) : Prop :=
  p 0 = 0 ∧ (∀ i ≤ a, p i ∈ Set.Icc 0 1) ∧
  (∀ i, 0 < i → i ≤ a →
    (2 * (n : ℝ) + 1 - i) * i / 2 +
      (∑ j ∈ Finset.range i, ((n : ℝ) - j) * p j) +
      ((n : ℝ) + 1 - i) * ((n : ℝ) - i) * p i =
      R * ((i : ℝ) * ((i : ℝ) + 1) / 2 +
        ((n : ℝ) + i + 1) * ((n : ℝ) - i) * p i / 2)) ∧
  excess * triangularCost (n : ℝ) =
    (∑ j ∈ Finset.range a, ((n : ℝ) - j) * p j) +
      ((n : ℝ) + 1 - a) * ((n : ℝ) - a) * p a / 2

theorem published_order_system_exists {n a : ℕ} {R : ℝ} (h : PublishedDepth n R a) :
    PublishedOrderEquations n a (unitFrontier n R - 1) R (activeUnitLevel n R) := by
  let b := h.branch
  have hC :
      unitFrontier n R = unitValue n R a :=
    equivalent_branch_value (unit_index_is_branch n R b.numJobs b.robust) b
  refine ⟨rfl, active_unit_level_interval _ _ _ b.num_jobs_real b.robust b.index_real b.active,
    ?_, ?_⟩
  · intro i hi hia
    obtain ⟨j, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (Nat.ne_of_gt hi)
    have hh := active_unit_prefix_equality (n : ℝ) R a b.num_jobs_real b.robust b.index_real j hia
    unfold unitIntercept unitDenominator activeUnitTailSum activeUnitTail at hh
    simp only [Nat.succ_eq_add_one, Nat.cast_add, Nat.cast_one] at hh ⊢
    linear_combination -hh
  rw [hC]
  rcases a with _ | j
  · exact (Nat.lt_irrefl 0 h.positive).elim
  rw [unitValue]
  have hQ : 0 < triangularCost (n : ℝ) := by
    have hh := b.num_jobs_real
    unfold triangularCost
    positivity
  have he (S : ℝ) :
      (1 + S / triangularCost (n : ℝ) - 1) * triangularCost (n : ℝ) = S := by
    rw [show 1 + S / triangularCost (n : ℝ) - 1 =
      S / triangularCost (n : ℝ) by ring, div_mul_cancel₀ _ hQ.ne']
  rw [he]
  unfold activeUnitTailSum activeUnitTail
  ring

theorem published_order_system_unique_at_depth {n a : ℕ} {R excess : ℝ}
    (h : PublishedDepth n R a) (p : ℕ → ℝ) (hp : PublishedOrderEquations n a excess R p) :
    (∀ i ≤ a, p i = activeUnitLevel n R i) ∧ excess = unitFrontier n R - 1 := by
  let b := h.branch
  obtain ⟨hp₀, _, hpR, hpexcess⟩ := hp
  have hs := (published_order_system_exists h).2.2.1
  have hexcess := (published_order_system_exists h).2.2.2
  have hpq : ∀ i ≤ a, p i = activeUnitLevel n R i := by
    intro i
    induction i using Nat.strong_induction_on with
    | h i ih =>
      intro hi
      by_cases hz : i = 0
      · simpa [hz, activeUnitLevel] using hp₀
      have hip := Nat.pos_of_ne_zero hz
      have hpE := hpR i hip hi
      have hqE := hs i hip hi
      have hsum :
          (∑ j ∈ Finset.range i, ((n : ℝ) - j) * p j) =
            ∑ j ∈ Finset.range i, ((n : ℝ) - j) * activeUnitLevel n R j := by
        exact Finset.sum_congr rfl fun j hj => by
          rw [ih j (Finset.mem_range.mp hj) ((Finset.mem_range.mp hj).le.trans hi)]
      rw [hsum] at hpE
      have hid : (1 : ℝ) ≤ i := by exact_mod_cast hip
      have hin : (i : ℝ) < n := by exact_mod_cast hi.trans_lt b.index
      have hden := unit_denominator_positive (n : ℝ) R i b.num_jobs_real b.robust hid
      have hw := mul_pos (sub_pos.mpr hin) hden
      apply (mul_left_cancel₀ hw.ne')
      unfold unitDenominator
      nlinarith only [hpE, hqE]
  refine ⟨hpq, ?_⟩
  have hunif : (∑ j ∈ Finset.range a, ((n : ℝ) - j) * p j) =
      ∑ j ∈ Finset.range a, ((n : ℝ) - j) * activeUnitLevel n R j :=
    Finset.sum_congr rfl fun j hj => by rw [hpq j (Nat.le_of_lt (Finset.mem_range.mp hj))]
  rw [hunif, hpq a le_rfl] at hpexcess
  have hQ : 0 < triangularCost (n : ℝ) := by
    have hh := b.num_jobs_real
    unfold triangularCost
    positivity
  exact mul_right_cancel₀ hQ.ne' (hpexcess.trans hexcess.symm)

/-- The published branch equations pick exactly the attainable inverse frontier.
The open upper bound on excess consistency ensures a published admissible depth. -/
theorem published_phi_attained {n : ℕ} (hn : 1 < n) (excess : ℝ)
    (hexcess₀ : 0 ≤ excess) (hexcess₁ : excess < baselineRobustness (n : ℝ) - 1) :
    ∃ R, IsLeast (robustnessBounds n (1 + excess)) R ∧
      (∃ a p, PublishedDepth n R a ∧ PublishedOrderEquations n a excess R p) ∧
      ∀ T a p, PublishedDepth n T a → PublishedOrderEquations n a excess T p → T = R := by
  obtain ⟨R, ⟨hR, hval⟩, huniq⟩ := frontier_has_unique_parameter hn (1 + excess)
    (by linarith only [hexcess₀]) (by linarith only [hexcess₁])
  have hstrict : baselineRobustness (n : ℝ) < R := by
    refine lt_of_le_of_ne hR.1 (fun he => ?_)
    rw [← he, frontier_at_baseline hn] at hval
    linarith only [hexcess₁, hval]
  obtain ⟨a, ha⟩ := has_published_depth hn R hstrict hR.2
  have hx : unitFrontier n R - 1 = excess := by linarith only [hval]
  refine ⟨R, inverse_attained hn R (1 + excess) hR hval,
    ⟨a, activeUnitLevel n R, ha, hx ▸ published_order_system_exists ha⟩, ?_⟩
  intro T k p hT hEq
  have hexcess := (published_order_system_unique_at_depth hT p hEq).2
  have hl := hT.branch.active
  have hRp := hT.branch.parameter_positive
  have hk : (1 : ℝ) ≤ k := by exact_mod_cast hT.positive
  have hmul := mul_le_mul_of_nonneg_left hk (show 0 ≤ T + 1 by linarith)
  unfold unitGap at hl
  have ht : T ≤ (n : ℝ) := by linarith only [hl, hmul]
  exact huniq T ⟨⟨hT.branch.robust, ht⟩, by linarith only [hexcess]⟩

end FiniteFrontier
