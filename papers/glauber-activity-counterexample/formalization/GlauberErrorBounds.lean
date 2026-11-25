import DoubleCliqueLimits

open scoped BigOperators

namespace GlauberAnnealing

theorem exp_excess_le (x : ℝ) (hx : 0 ≤ x) (hx' : x ≤ 1 / 2) :
    Real.exp x - 1 ≤ 2 * x := by
  have hp : 0 < 1 - x := by linarith
  have h := Real.exp_bound_div_one_sub_of_interval hx (by linarith : x < 1)
  have hratio : 1 / (1 - x) ≤ 1 + 2 * x := by
    apply (div_le_iff₀ hp).2
    nlinarith [mul_nonneg hx (show 0 ≤ 1 - 2 * x by linarith)]
  linarith [h.trans hratio]

theorem centered_le_small_nonneg (x : ℝ) (hx : 0 ≤ x) (hx' : x ≤ 1 / 2) :
    0 ≤ centered x ∧ centered x ≤ x := by
  have hexp := Real.one_le_exp hx
  have hd : 0 < 1 + Real.exp x := by positivity
  have heq : centered x = (Real.exp x - 1) / (1 + Real.exp x) := by
    unfold centered acceptance
    field_simp [ne_of_gt hd]
    ring
  rw [heq]
  refine ⟨div_nonneg (by linarith) hd.le, (div_le_iff₀ hd).2 ?_⟩
  have htwo : (2 : ℝ) ≤ 1 + Real.exp x := by linarith
  exact (exp_excess_le x hx hx').trans
    (by simpa only [mul_comm x 2] using (mul_le_mul_of_nonneg_left htwo hx))

theorem abs_centered_le_small (x : ℝ) (hx : |x| ≤ 1 / 2) : |centered x| ≤ |x| := by
  rcases le_total 0 x with h | h
  · rw [abs_of_nonneg h] at hx ⊢
    obtain ⟨h₀, h₁⟩ := centered_le_small_nonneg x h hx
    simpa [abs_of_nonneg h₀] using h₁
  · have hn : 0 ≤ -x := neg_nonneg.mpr h
    have hx' : -x ≤ 1 / 2 := by simpa [abs_of_nonpos h] using hx
    obtain ⟨h₀, h₁⟩ := centered_le_small_nonneg (-x) hn hx'
    have hh : |centered x| = |centered (-x)| := by rw [centered_neg, abs_neg]
    rw [hh, abs_of_nonneg h₀, abs_of_nonpos h]
    exact h₁

theorem centered_tail (x : ℝ) : |centered x - 1| ≤ 2 * Real.exp (-x) := by
  have h : centered x - 1 = -(2 * acceptance x) := by unfold centered; ring
  rw [h, abs_neg, abs_of_nonneg (mul_nonneg (by norm_num) (acceptance_pos x).le), Real.exp_neg]
  apply mul_le_mul_of_nonneg_left _ (by norm_num)
  unfold acceptance
  rw [← one_div]
  exact one_div_le_one_div_of_le (Real.exp_pos _) (by linarith)

theorem centered_tail_negative (x : ℝ) : |centered (-x) - (-1)| ≤ 2 * Real.exp (-x) := by
  rw [centered_neg, show -centered x - (-1) = -(centered x - 1) by ring, abs_neg]
  exact centered_tail x

theorem exponential_tail_square (x : ℝ) (hx : 0 < x) :
    Real.exp (-x) ≤ 2 / x ^ 2 := by
  rw [Real.exp_neg, ← one_div]
  have h := Real.quadratic_le_exp_of_nonneg hx.le
  have hp : 0 < x ^ 2 / 2 := by positivity
  have hh := one_div_le_one_div_of_le hp (show x ^ 2 / 2 ≤ Real.exp x by linarith)
  simpa [div_div_eq_mul_div] using hh

theorem exponential_tail_linear (x : ℝ) (hx : 0 < x) :
    Real.exp (-x) ≤ 1 / x := by
  rw [Real.exp_neg, ← one_div]
  exact one_div_le_one_div_of_le hx (by linarith [Real.add_one_le_exp x])

namespace RegularGraph

variable {V : Type*} [Fintype V] [Nonempty V]

theorem gibbs_distance_bound (E : V → ℝ) (β U : ℝ) (hβ : 0 ≤ β) (hU : 0 ≤ U)
    (hE : ∀ i, 0 ≤ E i ∧ E i ≤ U) (hsmall : β * U ≤ 1 / 2) :
    (∑ i, |gibbs E β i - uniform V i|) ≤ 2 * (β * U) := by
  let m : ℝ := β * U
  let n : ℝ := Fintype.card V
  let Z : ℝ := ∑ j, weight E β j
  have hm : 0 ≤ m := mul_nonneg hβ hU
  have hn : 0 < n := card_pos_real
  have hZ : 0 < Z := gibbs_normalizer_pos E β
  have hw (i : V) : Real.exp (-m) ≤ weight E β i ∧ weight E β i ≤ 1 := by
    constructor
    · unfold weight
      apply Real.exp_le_exp.mpr
      dsimp [m]
      linarith [mul_le_mul_of_nonneg_left (hE i).2 hβ]
    · unfold weight
      rw [← Real.exp_zero]
      apply Real.exp_le_exp.mpr
      exact mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr hβ) (hE i).1
  have hZbounds : n * Real.exp (-m) ≤ Z ∧ Z ≤ n := by
    constructor
    · simpa [n, Z, nsmul_eq_mul] using (Finset.sum_le_sum
        (fun j (_ : j ∈ (Finset.univ : Finset V)) => (hw j).1))
    · simpa [n, Z] using (Finset.sum_le_sum
        (fun j (_ : j ∈ (Finset.univ : Finset V)) => (hw j).2))
  have hpoint (i : V) : |gibbs E β i - uniform V i| ≤ (Real.exp m - 1) / n := by
    have hlow : Real.exp (-m) / n ≤ gibbs E β i := by
      unfold gibbs
      exact (div_le_div_of_nonneg_right (hw i).1 hn.le).trans
        (by apply div_le_div_of_nonneg_left (weight_pos E β i).le hZ hZbounds.2)
    have hhigh : gibbs E β i ≤ Real.exp m / n := by
      unfold gibbs
      apply (div_le_iff₀ hZ).mpr
      have hh := mul_le_mul_of_nonneg_left hZbounds.1 (by positivity : 0 ≤ Real.exp m / n)
      have hk : Real.exp m / n * (n * Real.exp (-m)) = 1 := by
        rw [Real.exp_neg]
        field_simp [hn.ne', Real.exp_ne_zero]
      exact (hw i).2.trans (hk ▸ hh)
    have hs : 1 - Real.exp (-m) ≤ Real.exp m - 1 := by
      have hp : Real.exp (-m) ≤ 1 := by
        rw [← Real.exp_zero]
        exact Real.exp_le_exp.mpr (neg_nonpos.mpr hm)
      have hr := mul_le_of_le_one_left (sub_nonneg.mpr (Real.one_le_exp hm)) hp
      have hEq : Real.exp (-m) * (Real.exp m - 1) = 1 - Real.exp (-m) := by
        rw [mul_sub, ← Real.exp_add, neg_add_cancel, Real.exp_zero, mul_one]
      rwa [hEq] at hr
    apply abs_le.mpr
    change -( (Real.exp m - 1) / n) ≤ gibbs E β i - 1 / n ∧
      gibbs E β i - 1 / n ≤ (Real.exp m - 1) / n
    rw [sub_div]
    have hs' := div_le_div_of_nonneg_right hs hn.le
    rw [sub_div, sub_div] at hs'
    constructor <;> linarith
  calc
    _ ≤ ∑ i : V, (Real.exp m - 1) / n := Finset.sum_le_sum fun i _ => hpoint i
    _ = Real.exp m - 1 := by
      simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
      change n * ((Real.exp m - 1) / n) = _
      field_simp [hn.ne']
    _ ≤ _ := exp_excess_le m hm hsmall

end RegularGraph
end GlauberAnnealing
