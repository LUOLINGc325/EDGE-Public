import ParameterContinuity

/-! Exact endpoint values and inversion of the attainable finite-job tradeoff. -/

open scoped BigOperators

namespace FiniteFrontier

theorem baseline_le_num_jobs (m : ℕ) (hm : 0 < m) :
    baselineRobustness (m : ℝ) ≤ (m : ℝ) := by
  have hpos : 0 < (m : ℝ) := by exact_mod_cast hm
  have hone : 1 ≤ (m : ℝ) := by exact_mod_cast hm
  unfold baselineRobustness
  apply (div_le_iff₀ (by positivity : 0 < (m : ℝ) + 1)).mpr
  have h := mul_nonneg hpos.le (sub_nonneg.mpr hone)
  nlinarith only [h]

@[simp] theorem frontier_at_serial (m : ℕ) :
    unitFrontier m (m : ℝ) = 1 := by simp [unitFrontier, unitIndex, unitValue]

theorem unit_first_level_at_baseline {m : ℕ} (hm : 1 < m) :
    clippedLevel m (baselineRobustness (m : ℝ)) 1 = 1 := by
  let R := baselineRobustness (m : ℝ)
  have hm₀ : 0 < (m : ℝ) := by exact_mod_cast (show 0 < m by omega)
  have hm₁ : 1 < (m : ℝ) := by exact_mod_cast hm
  have hR : R * ((m : ℝ) + 1) = 2 * m :=
    div_mul_cancel₀ _ (by positivity : ((m : ℝ) + 1) ≠ 0)
  have hz : unitDenominator (m : ℝ) R 0 + 1 = 0 := by
    unfold unitDenominator
    linarith only [hR]
  have h := unit_denominator_complement (m : ℝ) R 0
  rw [hz, mul_zero, zero_add] at h
  have hd : 0 < (((m : ℝ) - 1) * unitDenominator (m : ℝ) R 1) :=
    mul_pos (sub_pos.mpr hm₁) (unit_denominator_positive _ _ _ hm₀ le_rfl le_rfl)
  have hg := (sub_eq_zero.mp h).symm
  change clippedLevel m R 1 = 1
  simp only [clippedLevel, zero_add, sub_zero, mul_one, clippedFraction, Nat.cast_one]
  rw [hg, max_eq_right hd.le, div_self hd.ne']

theorem frontier_at_baseline {m : ℕ} (hm : 1 < m) :
    unitFrontier m (baselineRobustness (m : ℝ)) = baselineRobustness (m : ℝ) := by
  let R := baselineRobustness (m : ℝ)
  have hm₀ : 0 < m := by omega
  let b := unit_index_is_branch m R hm₀ le_rfl
  have h1 := unit_first_level_at_baseline hm
  change clippedLevel m R 1 = 1 at h1
  have hlevels (i : ℕ) (hi : 1 ≤ i) : clippedLevel m R i = 1 := by
    apply le_antisymm (clipped_level_interval hm₀ le_rfl i).2
    rw [← h1, clipped_level_eq_capped b, clipped_level_eq_capped b]
    exact capped_unit_level_monotone m R _ b.num_jobs_real b.robust b.index_real b.active hi
  have hterms (i : ℕ) :
      ((m : ℝ) - i) * clippedLevel m R i = ((m : ℝ) - i) - (if i = 0 then (m : ℝ) else 0) := by
    by_cases hi : i = 0
    · simp [hi, clippedLevel]
    · simp [hi, hlevels i (Nat.pos_of_ne_zero hi)]
  have hsum :
      (∑ i ∈ Finset.range m, ((m : ℝ) - i) * clippedLevel m R i) =
        triangularCost (m : ℝ) - m := by
    calc
      _ = ∑ i ∈ Finset.range m, (((m : ℝ) - i) - (if i = 0 then (m : ℝ) else 0)) :=
        Finset.sum_congr rfl fun i _ => hterms i
      _ = _ := by
        rw [Finset.sum_sub_distrib, triangular_sum_descending]
        simp only [Finset.sum_ite_eq', Finset.mem_range, hm₀, if_true]
  change unitFrontier m R = R
  rw [frontier_clipped_formula hm₀ (le_rfl : baselineRobustness (m : ℝ) ≤ R), hsum]
  have hm' : 0 < (m : ℝ) := by exact_mod_cast hm₀
  have hmp : 0 < (m : ℝ) + 1 := by positivity
  unfold R triangularCost baselineRobustness
  field_simp [hm'.ne', hmp.ne']
  ring

theorem robust_has_nonnegative_parameter {m : ℕ} (hm : 0 < m)
    {A : Policy (Fin m)} {R : ℝ} (hA : Robust A R) : 0 ≤ R := by
  let ones : PositiveSizes (Fin m) := ⟨fun _ => 1, fun _ => zero_lt_one⟩
  have hQ : 0 < triangularCost (m : ℝ) := by
    have hr : 0 < (m : ℝ) := by exact_mod_cast hm
    unfold triangularCost
    positivity
  have h := (A.run ones ones).frozen_le_cost.trans (hA ones ones)
  change frozenCost (fun _ : Fin m => (1 : ℝ)) ≤
    R * frozenCost (fun _ : Fin m => (1 : ℝ)) at h
  rw [frozen_ones] at h
  have h1 : 1 ≤ R := (mul_le_mul_right hQ).mp (by simpa only [one_mul] using h)
  exact zero_le_one.trans h1

theorem baseline_with_no_parameter_assumption {m : ℕ} (hm : 0 < m)
    {A : Policy (Fin m)} {R : ℝ} (h : Robust A R) :
    baselineRobustness (m : ℝ) ≤ R := by
  letI : Nonempty (Fin m) := ⟨⟨0, hm⟩⟩
  simpa only [Fintype.card_fin] using
    (robustness_baseline A R (robust_has_nonnegative_parameter hm h) h)

def robustnessBounds (m : ℕ) (C : ℝ) : Set ℝ :=
  {R | ∃ A : Policy (Fin m), Robust A R ∧ Consistent A C}

theorem frontier_has_unique_parameter {m : ℕ} (hm : 1 < m) (C : ℝ)
    (hC₀ : 1 ≤ C) (hC₁ : C ≤ baselineRobustness (m : ℝ)) :
    ∃! R, R ∈ Set.Icc (baselineRobustness (m : ℝ)) (m : ℝ) ∧ unitFrontier m R = C := by
  have hp : 0 < m := by omega
  have hnonempty := baseline_le_num_jobs m hp
  let D := Set.Icc (baselineRobustness (m : ℝ)) (m : ℝ)
  have hc : ContinuousOn (unitFrontier m) D :=
    (frontier_continuous m hp).mono fun _ h => h.1
  have hmem : C ∈ Set.Icc (unitFrontier m (m : ℝ))
      (unitFrontier m (baselineRobustness (m : ℝ))) := by
    rw [frontier_at_serial, frontier_at_baseline hm]
    exact ⟨hC₀, hC₁⟩
  obtain ⟨R, hR, h⟩ := intermediate_value_Icc' hnonempty hc hmem
  exact ⟨R, ⟨hR, h⟩, fun T ⟨hT, he⟩ =>
    (frontier_strict_antitone m hm).injOn hT hR (he.trans h.symm)⟩

theorem inverse_attained {m : ℕ} (hm : 1 < m) (R C : ℝ)
    (hR : R ∈ Set.Icc (baselineRobustness (m : ℝ)) (m : ℝ))
    (hRC : unitFrontier m R = C) : IsLeast (robustnessBounds m C) R := by
  refine ⟨⟨optimumPolicy R hR.1, optimum_policy_robust R hR.1,
    hRC ▸ optimum_policy_consistent R hR.1⟩, ?_⟩
  intro T hT
  obtain ⟨A, ht, hc⟩ := hT
  by_contra! hlt
  have hm' : 0 < m := by omega
  have hT₀ := baseline_with_no_parameter_assumption hm' ht
  have hT₁ := hlt.le.trans hR.2
  have hv := frontier_strict_antitone m hm ⟨hT₀, hT₁⟩ hR hlt
  have hlo := consistency_lower hm' T C hT₀ A ht hc
  rw [hRC] at hv
  exact (not_lt_of_ge hlo) hv

end FiniteFrontier
