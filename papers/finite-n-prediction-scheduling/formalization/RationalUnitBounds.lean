import RationalSizeBounds

/-! Height of the exact unit levels and their use in the finite output matrix. -/

open scoped BigOperators

namespace FiniteFrontier

namespace FractionHeight

theorem prod_range {x : ℕ → ℝ} {K : ℝ} :
    ∀ t, (∀ j < t, FractionHeight (x j) K) → FractionHeight (∏ j ∈ Finset.range t, x j) (K ^ t) := by
  intro t
  induction t with
  | zero => intro _; simpa using one 1 le_rfl
  | succ t ih =>
    intro h
    rw [Finset.prod_range_succ, pow_succ]
    exact (ih (fun j hj => h j (hj.trans (Nat.lt_succ_self t)))).mul (h t (Nat.lt_succ_self t))

theorem one_sub_of_unit {x K : ℝ} (h : FractionHeight x K) (h0 : 0 ≤ x) (h1 : x ≤ 1) :
    FractionHeight (1 - x) K := by
  obtain ⟨A, B, hB, _, hK, he⟩ := h
  have hb : 0 < (B : ℝ) := by exact_mod_cast hB
  have ha0 : 0 ≤ (A : ℝ) := by
    rw [he] at h0
    exact le_of_not_gt (fun hneg => (not_lt_of_ge h0) (div_neg_of_neg_of_pos hneg hb))
  have ha1 : (A : ℝ) ≤ B := by rw [he] at h1; exact (div_le_one hb).mp h1
  refine ⟨B - A, B, hB, ?_, hK, ?_⟩
  · push_cast
    rw [abs_of_nonneg (sub_nonneg.mpr ha1)]
    linarith only [hK, ha0]
  · push_cast
    rw [he, sub_div, div_self hb.ne']

end FractionHeight

noncomputable def encodingBase (n : ℕ) (B : ℝ) : ℝ := 16 * ((n : ℝ) + 1) * (B + 1)

theorem encoding_base_ge_two (n : ℕ) (B : ℝ) (hB : 1 ≤ B) :
    2 ≤ encodingBase n B := by
  have hprod : 0 ≤ (n : ℝ) * B := by positivity
  unfold encodingBase
  nlinarith only [hB, hprod, show 0 ≤ (n : ℝ) by positivity]

theorem encoding_base_ge_n (n : ℕ) (B : ℝ) (hB : 1 ≤ B) :
    (n : ℝ) ≤ encodingBase n B := by
  have hprod : 0 ≤ (n : ℝ) * B := by positivity
  unfold encodingBase
  nlinarith only [hB, hprod, show 0 ≤ (n : ℝ) by positivity]

theorem rational_unit_product_height {m n a i : ℕ} {R : ℝ}
    (b : UnitBranch m R a) (hmn : m ≤ n) (hi : i ≤ a)
    (P Q : ℤ) (hQ : 0 < Q) (hR : R = (P : ℝ) / (Q : ℝ))
    (B : ℝ) (hB : 1 ≤ B) (hP : |(P : ℝ)| ≤ B) (hQ' : |(Q : ℝ)| ≤ B) :
    FractionHeight (unitProduct m R i) (encodingBase n B ^ i) := by
  unfold unitProduct
  apply FractionHeight.prod_range
  intro j hj
  have hjm : j < m := hj.trans_le (hi.trans b.index.le)
  let D := integerBranchDenominator P Q m j
  have hDb := unit_integer_factors_bound P Q m j n hmn hjm B hB hP hQ'
  change |(D : ℝ)| ≤ encodingBase n B ∧ |((D - P : ℤ) : ℝ)| ≤ encodingBase n B at hDb
  have he := integer_branch_denominator_cast P Q m j hQ
  rw [← hR] at he
  have hd := unit_denominator_positive (m : ℝ) R ((j : ℝ) + 1) b.num_jobs_real b.robust (by linarith only [show (0 : ℝ) ≤ j by positivity])
  have hQpos : 0 < (Q : ℝ) := by exact_mod_cast hQ
  have hDr : 0 < (D : ℝ) := by rw [he]; positivity
  refine ⟨D - P, D, by exact_mod_cast hDr, hDb.2, ?_, ?_⟩
  · simpa only [abs_of_pos hDr] using hDb.1
  · push_cast
    rw [sub_div, div_self hDr.ne', he]
    let X := 2 * unitDenominator (m : ℝ) R ((j : ℝ) + 1)
    have hX : X ≠ 0 := (mul_pos (by norm_num) hd).ne'
    have hratio : (P : ℝ) / ((Q : ℝ) * X) = R / X := by
      calc
        _ = ((P : ℝ) / (Q : ℝ)) / X := by
          field_simp [hQpos.ne', hX]
        _ = _ := congrArg (fun t => t / X) hR.symm
    rw [hratio]

theorem rational_unit_level_height {m n a i : ℕ} {R : ℝ}
    (b : UnitBranch m R a) (hmn : m ≤ n) (hi : i ≤ a)
    (P Q : ℤ) (hQ : 0 < Q) (hR : R = (P : ℝ) / (Q : ℝ))
    (B : ℝ) (hB : 1 ≤ B) (hP : |(P : ℝ)| ≤ B) (hQ' : |(Q : ℝ)| ≤ B) :
    FractionHeight (activeUnitLevel m R i) (encodingBase n B ^ (i + 1)) := by
  let K := encodingBase n B
  have hni : i < m := hi.trans_lt b.index
  have hmi : (i : ℝ) < m := by exact_mod_cast hni
  have hK : (m : ℝ) ≤ K := (by exact_mod_cast hmn : (m : ℝ) ≤ n).trans (encoding_base_ge_n n B hB)
  have hquot : FractionHeight ((m : ℝ) / ((m : ℝ) - i)) K := by
    have hden : (0 : ℤ) < (m : ℤ) - (i : ℤ) := sub_pos.mpr (by exact_mod_cast hni)
    refine ⟨(m : ℤ), (m : ℤ) - (i : ℤ), hden, ?_, ?_, ?_⟩
    · push_cast
      simpa using hK
    · push_cast
      exact (sub_le_self _ (by positivity)).trans hK
    · push_cast
      rfl
  have hprod := rational_unit_product_height b hmn hi P Q hQ hR B hB hP hQ'
  have he := unit_survival_product (m : ℝ) R b.num_jobs_real b.robust i hmi
  have hslack : 1 - activeUnitLevel m R i =
      ((m : ℝ) / ((m : ℝ) - i)) * unitProduct m R i := by
    apply (mul_left_cancel₀ (sub_pos.mpr hmi).ne')
    calc
      _ = (m : ℝ) * unitProduct m R i := he
      _ = ((m : ℝ) / ((m : ℝ) - i) * ((m : ℝ) - i)) * unitProduct m R i := by
        rw [div_mul_cancel₀ _ (sub_pos.mpr hmi).ne']
      _ = _ := by ring
  have hf := hquot.mul hprod
  rw [← hslack, mul_comm K, ← pow_succ] at hf
  have hq := active_unit_level_interval (m : ℝ) R a b.num_jobs_real b.robust b.index_real b.active i hi
  have he' := hf.one_sub_of_unit (sub_nonneg.mpr hq.2) (by linarith only [hq.1])
  simpa only [sub_sub_cancel] using he'

theorem finite_assembly_height (n e : ℕ) (K : ℝ) (hK : 2 ≤ K) (v : Fin n → ℝ)
    (hv : ∀ i, FractionHeight (v i) (K ^ e)) :
    FractionHeight (∑ i, v i) (K ^ (n * (e + 1))) := by
  rw [Finset.sum_fin_eq_sum_range]
  apply FractionHeight.sum_range hK
  intro j hj
  simpa only [dif_pos hj] using hv ⟨j, hj⟩

end FiniteFrontier
