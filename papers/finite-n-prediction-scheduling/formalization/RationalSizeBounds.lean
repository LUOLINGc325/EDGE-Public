import UnitOptimality

/-! Explicit integer witnesses for polynomial rational bit length. -/

open scoped BigOperators

namespace FiniteFrontier

/-- A rational encoded by a numerator and a positive denominator of bounded height.
The bound is stated over reals, but both witnesses are integers. -/
def FractionHeight (x K : ℝ) : Prop :=
  ∃ P Q : ℤ, 0 < Q ∧ |(P : ℝ)| ≤ K ∧ (Q : ℝ) ≤ K ∧ x = (P : ℝ) / (Q : ℝ)

namespace FractionHeight

theorem mono {x K L : ℝ} (h : FractionHeight x K) (hKL : K ≤ L) :
    FractionHeight x L := by
  obtain ⟨P, Q, hQ, hP, hL, he⟩ := h
  exact ⟨P, Q, hQ, hP.trans hKL, hL.trans hKL, he⟩

theorem one_le {x K : ℝ} (h : FractionHeight x K) : 1 ≤ K := by
  obtain ⟨_, Q, hQ, _, hK, _⟩ := h
  exact (show (1 : ℝ) ≤ (Q : ℝ) by exact_mod_cast (show (1 : ℤ) ≤ Q by omega)).trans hK

theorem integer (P : ℤ) (K : ℝ) (hK : 1 ≤ K) (hP : |(P : ℝ)| ≤ K) :
    FractionHeight (P : ℝ) K := ⟨P, 1, by decide, hP, by exact_mod_cast hK, by simp⟩

theorem zero (K : ℝ) (hK : 1 ≤ K) : FractionHeight 0 K := by
  simpa using integer 0 K hK (by simpa using zero_le_one.trans hK)

theorem one (K : ℝ) (hK : 1 ≤ K) : FractionHeight 1 K := by
  simpa using integer 1 K hK (by simpa using hK)

theorem mul {x y H K : ℝ} (hx : FractionHeight x H) (hy : FractionHeight y K) :
    FractionHeight (x * y) (H * K) := by
  have hH := hx.one_le
  obtain ⟨A, B, hB, hA, hBH, hx⟩ := hx
  obtain ⟨C, D, hD, hC, hDK, hy⟩ := hy
  refine ⟨A * C, B * D, mul_pos hB hD, ?_, ?_, ?_⟩
  · push_cast
    rw [abs_mul]
    exact mul_le_mul hA hC (abs_nonneg _) (zero_le_one.trans hH)
  · push_cast
    exact mul_le_mul hBH hDK (by exact_mod_cast hD.le) (by linarith only [hBH, show (0 : ℝ) ≤ B by exact_mod_cast hB.le])
  · push_cast
    rw [hx, hy, mul_div_mul_comm]

theorem add {x y H K : ℝ} (hx : FractionHeight x H) (hy : FractionHeight y K) :
    FractionHeight (x + y) (2 * H * K) := by
  have hH := hx.one_le
  have hK := hy.one_le
  obtain ⟨A, B, hB, hA, hBH, hx⟩ := hx
  obtain ⟨C, D, hD, hC, hDK, hy⟩ := hy
  have hBr : 0 < (B : ℝ) := by exact_mod_cast hB
  have hDr : 0 < (D : ℝ) := by exact_mod_cast hD
  refine ⟨A * D + C * B, B * D, mul_pos hB hD, ?_, ?_, ?_⟩
  · push_cast
    apply (abs_add_le _ _).trans
    rw [abs_mul, abs_mul, abs_of_pos hDr, abs_of_pos hBr]
    have h₁ := mul_le_mul hA hDK hDr.le (zero_le_one.trans hH)
    have h₂ := mul_le_mul hC hBH hBr.le (zero_le_one.trans hK)
    nlinarith only [h₁, h₂]
  · push_cast
    have h := mul_le_mul hBH hDK hDr.le (zero_le_one.trans hH)
    have hHK := mul_nonneg (zero_le_one.trans hH) (zero_le_one.trans hK)
    linarith only [h, hHK]
  · push_cast
    rw [hx, hy, div_add_div _ _ hBr.ne' hDr.ne', mul_comm (B : ℝ) (C : ℝ)]

theorem neg {x K : ℝ} (h : FractionHeight x K) : FractionHeight (-x) K := by
  obtain ⟨P, Q, hQ, hP, hK, he⟩ := h
  exact ⟨-P, Q, hQ, by simpa using hP, hK, by rw [he, Int.cast_neg, neg_div]⟩

theorem sub {x y H K : ℝ} (hx : FractionHeight x H) (hy : FractionHeight y K) :
    FractionHeight (x - y) (2 * H * K) := by
  rw [sub_eq_add_neg]
  exact hx.add hy.neg

theorem sum_range {x : ℕ → ℝ} {K : ℝ} (hK : 2 ≤ K) (e : ℕ) :
    ∀ t, (∀ j < t, FractionHeight (x j) (K ^ e)) →
      FractionHeight (∑ j ∈ Finset.range t, x j) (K ^ (t * (e + 1))) := by
  intro t
  induction t with
  | zero => intro _; simpa using zero 1 le_rfl
  | succ t ih =>
    intro h
    rw [Finset.sum_range_succ]
    have hp := ih (fun j hj => h j (hj.trans (Nat.lt_succ_self t)))
    have hc := hp.add (h t (Nat.lt_succ_self t))
    apply hc.mono
    rw [Nat.succ_mul, pow_add, pow_succ]
    have hn : 0 ≤ K ^ (t * (e + 1)) * K ^ e := by positivity
    calc
      _ = 2 * (K ^ (t * (e + 1)) * K ^ e) := by ring
      _ ≤ K * (K ^ (t * (e + 1)) * K ^ e) := mul_le_mul_of_nonneg_right hK hn
      _ = _ := by ring

end FractionHeight

noncomputable def integerBranchDenominator (P Q : ℤ) (m j : ℕ) : ℤ :=
  (P - 2 * Q) * (m + 1) + (P + 2 * Q) * (j + 1)

theorem integer_branch_denominator_cast (P Q : ℤ) (m j : ℕ) (hQ : 0 < Q) :
    (integerBranchDenominator P Q m j : ℝ) =
      (Q : ℝ) * (2 * unitDenominator (m : ℝ) ((P : ℝ) / (Q : ℝ)) ((j : ℝ) + 1)) := by
  have hQr : 0 < (Q : ℝ) := by exact_mod_cast hQ
  unfold integerBranchDenominator unitDenominator
  push_cast
  field_simp [hQr.ne']
  ring

theorem unit_integer_factors_bound (P Q : ℤ) (m j n : ℕ) (hn : m ≤ n) (hj : j < m)
    (B : ℝ) (hB : 1 ≤ B) (hP : |(P : ℝ)| ≤ B) (hQ : |(Q : ℝ)| ≤ B) :
    let K := 16 * ((n : ℝ) + 1) * (B + 1)
    |(integerBranchDenominator P Q m j : ℝ)| ≤ K ∧
      |((integerBranchDenominator P Q m j - P : ℤ) : ℝ)| ≤ K := by
  let D := (integerBranchDenominator P Q m j : ℝ)
  have hm : (m : ℝ) ≤ n := by exact_mod_cast hn
  have hj' : (j : ℝ) + 1 ≤ m := by exact_mod_cast Nat.succ_le_of_lt hj
  have hp₁ : |(P : ℝ) - 2 * (Q : ℝ)| ≤ 3 * B := by
    calc
      _ ≤ |(P : ℝ)| + |2 * (Q : ℝ)| := abs_sub _ _
      _ ≤ _ := by rw [abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 2)]; linarith only [hP, hQ]
  have hp₂ : |(P : ℝ) + 2 * (Q : ℝ)| ≤ 3 * B := by
    calc
      _ ≤ |(P : ℝ)| + |2 * (Q : ℝ)| := abs_add_le _ _
      _ ≤ _ := by rw [abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 2)]; linarith only [hP, hQ]
  have hd : |D| ≤ 6 * B * ((n : ℝ) + 1) := by
    unfold D integerBranchDenominator
    push_cast
    apply (abs_add_le _ _).trans
    rw [abs_mul, abs_mul, abs_of_nonneg (by positivity : 0 ≤ (m : ℝ) + 1),
      abs_of_nonneg (by positivity : 0 ≤ (j : ℝ) + 1)]
    have hl := mul_le_mul hp₁ (add_le_add_right hm 1) (by positivity) (by positivity)
    have hr := mul_le_mul hp₂ (show (j : ℝ) + 1 ≤ (n : ℝ) + 1 by linarith only [hj', hm])
      (by positivity) (by positivity)
    linarith only [hl, hr]
  have hK : 6 * B * ((n : ℝ) + 1) + B ≤ 16 * ((n : ℝ) + 1) * (B + 1) := by
    have hprod : 0 ≤ B * (n : ℝ) := by positivity
    nlinarith only [hB, hprod, show (0 : ℝ) ≤ n by positivity]
  constructor
  · exact hd.trans (le_trans (le_add_of_nonneg_right (by positivity)) hK)
  push_cast
  exact (abs_sub D (P : ℝ)).trans ((add_le_add hd hP).trans hK)

end FiniteFrontier
