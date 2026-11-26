import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

namespace EvenCycleReplicaBranchSeparationResearchProof1

/-- The normalized scaled difference of the two branches in Section 4. -/
noncomputable def scaledBranchGap (n : ℝ) (k : ℕ) : ℝ :=
  2*((n-1)^2/(n+1))^k + n^2*(n-3)*((n-1)/(n+1))^k -
    (n-1)*(n-2)^2 - 2*(n-1)*(n-3)*(1/(n+1))^k

/-- The two branches coincide at the four-cycle base k=2. -/
theorem scaled_gap_two (n : ℝ) (hn : n+1 ≠ 0) : scaledBranchGap n 2 = 0 := by
  unfold scaledBranchGap
  field_simp [hn]
  ring

/-- The first two terms' increment at k=2, after multiplication by (n+1)^3. -/
theorem two_term_base_increment (n : ℝ) (hn : n+1 ≠ 0) :
    (n+1)^3 * (2*((n-1)^2/(n+1))^2*(((n-1)^2/(n+1))-1) -
      n^2*(n-3)*((n-1)/(n+1))^2*(1-(n-1)/(n+1))) =
    2*n*(n-3)*(n-1)^2*(n^2-3*n+1) := by
  field_simp [hn]
  ring

theorem scaled_branch_positive (n : ℝ) (hn : 3 < n) {k : ℕ} (hk : 3 ≤ k) :
    0 < scaledBranchGap n k := by
  let A : ℝ := (n-1)^2/(n+1)
  let B : ℝ := (n-1)/(n+1)
  let H : ℝ := 1/(n+1)
  let C : ℝ := n^2*(n-3)
  let M : ℝ := 2*(n-1)*(n-3)
  have hden : 0 < n+1 := by linarith
  have hn0 : 0 < n := by linarith
  have hn3 : 0 < n-3 := by linarith
  have hn1 : 0 < n-1 := by linarith
  have hA : 1 ≤ A := by
    apply (le_div_iff₀ hden).2
    nlinarith [mul_nonneg hn0.le hn3.le]
  have hB0 : 0 ≤ B := div_nonneg hn1.le hden.le
  have hB1 : B ≤ 1 := (div_le_one hden).2 (by linarith)
  have hH0 : 0 ≤ H := div_nonneg zero_le_one hden.le
  have hH1 : H ≤ 1 := (div_le_one hden).2 (by linarith)
  have hC : 0 ≤ C := mul_nonneg (sq_nonneg n) hn3.le
  have hM : 0 ≤ M := mul_nonneg (mul_nonneg (by norm_num) hn1.le) hn3.le
  have base : 0 < 2*A^2*(A-1) - C*B^2*(1-B) := by
    have eq := two_term_base_increment n hden.ne'
    change (n+1)^3*(2*A^2*(A-1)-C*B^2*(1-B)) = _ at eq
    have hquad : 0 < n^2-3*n+1 := by nlinarith [mul_pos hn0 hn3]
    have rhs : 0 < 2*n*(n-3)*(n-1)^2*(n^2-3*n+1) :=
      mul_pos (mul_pos (mul_pos (mul_pos (by norm_num) hn0) hn3) (pow_pos hn1 _)) hquad
    have hprod : 0 < (n+1)^3*(2*A^2*(A-1)-C*B^2*(1-B)) := eq ▸ rhs
    by_contra! h
    exact (not_le_of_gt hprod) (mul_nonpos_of_nonneg_of_nonpos (pow_pos hden _).le h)
  have increase (j : ℕ) (hj : 2 ≤ j) : scaledBranchGap n j < scaledBranchGap n (j+1) := by
    have hA' := mul_le_mul_of_nonneg_left (pow_le_pow_right₀ hA hj)
      (show 0 ≤ 2*(A-1) from mul_nonneg (by norm_num) (sub_nonneg.mpr hA))
    have hB' := mul_le_mul_of_nonneg_left (pow_le_pow_of_le_one hB0 hB1 hj)
      (show 0 ≤ C*(1-B) from mul_nonneg hC (sub_nonneg.mpr hB1))
    have hH' : 0 ≤ M*H^j*(1-H) :=
      mul_nonneg (mul_nonneg hM (pow_nonneg hH0 _)) (sub_nonneg.mpr hH1)
    have hd : scaledBranchGap n (j+1)-scaledBranchGap n j =
        2*A^j*(A-1)-C*B^j*(1-B)+M*H^j*(1-H) := by
      change (2*A^(j+1)+C*B^(j+1)-(n-1)*(n-2)^2-M*H^(j+1)) -
        (2*A^j+C*B^j-(n-1)*(n-2)^2-M*H^j) = _
      simp only [pow_succ]
      ring
    nlinarith only [base,hA',hB',hH',hd]
  have baseThree : 0 < scaledBranchGap n 3 := by
    rw [← scaled_gap_two n hden.ne']
    exact increase 2 (by norm_num)
  have chain : ∀ d : ℕ, 0 < scaledBranchGap n (3+d) := by
    intro d
    induction d with
    | zero => simpa using baseThree
    | succ d ih => exact lt_trans ih (increase (3+d) (by omega))
  obtain ⟨d, rfl⟩ := Nat.exists_eq_add_of_le hk
  exact chain d

end EvenCycleReplicaBranchSeparationResearchProof1
