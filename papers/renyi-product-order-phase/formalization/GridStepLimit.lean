import GridStep

/-! Uniform finite-step limits for every bounded set of grid coefficients. -/

open scoped BigOperators
open Set MeasureTheory

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem finite_grid_cell_limit (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (Y : κ → ℝ) (hNon : ¬ ArithmeticSupport Y) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) {h ε : ℝ} (hh : 0 < h) (hε : 0 < ε)
    (J : Finset ℤ) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ j ∈ J,
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent p Y (n + 1) (gridCell h j) -
        h * gaussianHeight (p.expect (fun i => Y i ^ 2))| < ε := by
  let E := ∑ j ∈ J, |h * (j : ℝ)|
  let v := p.expect (fun i => Y i ^ 2)
  obtain ⟨N₁, h₁⟩ := finite_nonarithmetic_interval_local_limit p hp Y hNon hm hv hh
    (div_pos hε (by norm_num : (0 : ℝ) < 2))
  have hε' : 0 < ε / (2 * h) := div_pos hε (by positivity)
  obtain ⟨N₂, h₂⟩ := gaussian_profile_log_window v 0 E hε'
  refine ⟨max N₁ N₂, ?_⟩
  intro n hn j hj
  let x := h * (j : ℝ)
  have hXE : |x| ≤ E := Finset.single_le_sum
    (f := fun j : ℤ => |h * (j : ℝ)|) (fun _ _ => abs_nonneg _) hj
  have hCell : gridCell h j = Ico x (x + h) := by
    unfold gridCell x
    rw [mul_add, mul_one]
  rw [hCell]
  have hA := h₁ n ((le_max_left _ _).trans hn) x
  have hB := h₂ n ((le_max_right _ _).trans hn) x
    (by simpa only [zero_mul, zero_add] using hXE)
  have hMul : h * (ε / (2 * h)) = ε / 2 := by
    rw [← div_div, mul_div_cancel₀ _ hh.ne']
  have hErr : |h * gaussianProfile v (n + 1) x - h * gaussianHeight v| < ε / 2 := by
    rw [← mul_sub, abs_mul, abs_of_pos hh, ← hMul]
    exact mul_lt_mul_of_pos_left hB hh
  have hTri := abs_sub_le
    (Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent p Y (n + 1) (Ico x (x + h)))
    (h * gaussianProfile v (n + 1) x) (h * gaussianHeight v)
  exact hTri.trans_lt (by linarith only [hA, hErr])

theorem uniform_finite_grid_step_limit (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (Y : κ → ℝ) (hNon : ¬ ArithmeticSupport Y) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) {h A ε : ℝ}
    (hh : 0 < h) (hA : 0 ≤ A) (hε : 0 < ε) (J : Finset ℤ) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ f : ℝ → ℝ, (∀ j ∈ J, |f (h * (j : ℝ))| ≤ A) →
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * (FiniteMass.tensor (fun _ : Fin (n + 1) => p)).expect
        (fun x => gridStep h J f (iidSum Y x)) -
        gaussianHeight (p.expect (fun i => Y i ^ 2)) * (∫ x, gridStep h J f x)| < ε := by
  let C := A * (J.card : ℝ) + 1
  have hC : 0 < C := by unfold C; positivity
  let δ := ε / C
  have hδ : 0 < δ := div_pos hε hC
  obtain ⟨N, hN⟩ := finite_grid_cell_limit p hp Y hNon hm hv hh hδ J
  refine ⟨N, ?_⟩
  intro n hn f hf
  let r := Real.sqrt ((n + 1 : ℕ) : ℝ)
  let G := gaussianHeight (p.expect (fun i => Y i ^ 2))
  let E (j : ℤ) := r * finiteSumEvent p Y (n + 1) (gridCell h j) - h * G
  rw [finite_sum_expect_grid_step, integral_grid_step hh.le, Finset.mul_sum, Finset.mul_sum,
    ← Finset.sum_sub_distrib]
  have hEq :
      (∑ j ∈ J, (r * (f (h * (j : ℝ)) * finiteSumEvent p Y (n + 1) (gridCell h j)) -
          G * (f (h * (j : ℝ)) * h))) =
        ∑ j ∈ J, f (h * (j : ℝ)) * E j := by
    refine Finset.sum_congr rfl fun j _ => ?_
    unfold E
    ring
  change |∑ j ∈ J, (r * (f (h * (j : ℝ)) * finiteSumEvent p Y (n + 1) (gridCell h j)) -
    G * (f (h * (j : ℝ)) * h))| < ε
  rw [hEq]
  calc
    _ ≤ ∑ j ∈ J, |f (h * (j : ℝ)) * E j| := Finset.abs_sum_le_sum_abs _ J
    _ ≤ ∑ _ ∈ J, A * δ := by
      refine Finset.sum_le_sum (fun j hj => ?_)
      rw [abs_mul]
      exact mul_le_mul (hf j hj) (hN n hn j hj).le (abs_nonneg _) hA
    _ = (J.card : ℝ) * (A * δ) := by rw [Finset.sum_const, nsmul_eq_mul]
    _ < ε := by
      have hE : C * δ = ε := mul_div_cancel₀ _ hC.ne'
      unfold C at hE
      nlinarith only [hE, hδ]

end RenyiProductOrderPhase
