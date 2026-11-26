import StabilityBounds
import Numeric

open scoped BigOperators
noncomputable section
namespace OrdinaryEF1

/-- A quantitative transfer theorem with separate budgets for zero and one
deletion; its hypothesis is subsequently proved for the concrete tensor. -/
theorem robust_nonexistence_of_margins
    (u v : Fin 3 → Fin 3 → Fin 3 → ℝ) (ε : ℝ)
    (he : ε < 1 / 4) (hclose : closeProfile u v ε)
    (hmargins : ∀ A : Fin 3 → Fin 3, ∃ i j : Fin 3, i ≠ j ∧
      ∀ d : Fin 4, (if d.val = 3 then (3 : ℝ) else 1) ≤ gap u A i j d) :
    ¬ ∃ A : Fin 3 → Fin 3, EF1 v A := by
  rintro ⟨A, hA⟩
  obtain ⟨i, j, hij, hm⟩ := hmargins A
  obtain ⟨d, hd⟩ := hA i j hij
  have hdiff := (abs_lt.mp (three_item_gap_perturbation_bound u v A i j d ε hclose)).1
  have hmargin := hm d
  by_cases hnone : d.val = 3
  · simp only [if_pos hnone] at hdiff hmargin
    linarith
  · simp only [if_neg hnone] at hdiff hmargin
    linarith

/-- Section 6, unshifted profile: every independent entry perturbation smaller
than ε<1/4 preserves nonexistence for all 27 complete allocations. -/
theorem counterexample_stable (v : Fin 3 → Fin 3 → Fin 3 → ℝ) (ε : ℝ)
    (he : ε < 1 / 4) (hclose : closeProfile (cyclicProfile 2 1 2 2) v ε) :
    ¬ ∃ A : Fin 3 → Fin 3, EF1 v A :=
  robust_nonexistence_of_margins _ v ε he hclose integer_witness_margin

theorem shifted_witness_margin (A : Fin 3 → Fin 3) :
    ∃ i j : Fin 3, i ≠ j ∧ ∀ d : Fin 4,
      (if d.val = 3 then (3 : ℝ) else 1) ≤
        gap (fun i r x => cyclicProfile 2 1 2 2 i r x + 1) A i j d := by
  obtain ⟨i, j, hij, hm⟩ := integer_witness_margin A
  refine ⟨i, j, hij, ?_⟩
  intro d
  simpa only [gap_add_recipient_constant] using hm d

/-- The same radius works after adding one to every utility entry. -/
theorem shifted_counterexample_stable (v : Fin 3 → Fin 3 → Fin 3 → ℝ) (ε : ℝ)
    (he : ε < 1 / 4)
    (hclose : closeProfile (fun i r x => cyclicProfile 2 1 2 2 i r x + 1) v ε) :
    ¬ ∃ A : Fin 3 → Fin 3, EF1 v A :=
  robust_nonexistence_of_margins _ v ε he hclose shifted_witness_margin

theorem shifted_nearby_profile_positive (v : Fin 3 → Fin 3 → Fin 3 → ℝ) (ε : ℝ)
    (he : ε < 1 / 4)
    (hclose : closeProfile (fun i r x => cyclicProfile 2 1 2 2 i r x + 1) v ε) :
    ∀ i r x, 0 < v i r x := by
  intro i r x
  have h := (abs_lt.mp (hclose i r x)).1
  change -ε < v i r x - (cyclicProfile 2 1 2 2 i r x + 1) at h
  have hbase := integer_profile_nonnegative i r x
  linarith

/-- An explicit nonempty open box of strictly positive counterexamples. -/
theorem positive_counterexample_neighborhood :
    ∃ (u : Fin 3 → Fin 3 → Fin 3 → ℝ) (ε : ℝ), 0 < ε ∧
      closeProfile u u ε ∧
      ∀ v : Fin 3 → Fin 3 → Fin 3 → ℝ, closeProfile u v ε →
        (∀ i r x, 0 < v i r x) ∧ ¬ ∃ A : Fin 3 → Fin 3, EF1 v A := by
  refine ⟨fun i r x => cyclicProfile 2 1 2 2 i r x + 1, 1 / 8,
    by norm_num, ?_, ?_⟩
  · intro i r x
    norm_num
  · intro v hv
    exact ⟨shifted_nearby_profile_positive v (1 / 8) (by norm_num) hv,
      shifted_counterexample_stable v (1 / 8) (by norm_num) hv⟩

#print axioms counterexample_stable
#print axioms positive_counterexample_neighborhood

end OrdinaryEF1
