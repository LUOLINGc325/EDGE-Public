import Mathlib.Data.Real.Sqrt
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace ToroidalSIC

open scoped BigOperators

private noncomputable def majorant (h y : ℝ) : ℝ :=
  (-(y^4) + (3*h^2 + 2*h + 1)*y^2 + h^2*(1+2*h)) / (2*h*(1+h)^2)

private theorem majorantDeficit (h y : ℝ) :
    y * (2*h*(1+h)^2) + (y-h)^2*(1-y)*(y+1+2*h) =
      -(y^4) + (3*h^2 + 2*h + 1)*y^2 + h^2*(1+2*h) := by
  ring

/-- Hermite majorant for the square root, with contact at 1 and
tangency at h², written using y = sqrt(x). -/
theorem hermiteMajorant {h y : ℝ} (hh : 0 < h) (hy : 0 ≤ y) (hy₁ : y ≤ 1) :
    y ≤ (-(y^4) + (3*h^2 + 2*h + 1)*y^2 + h^2*(1+2*h)) /
      (2*h*(1+h)^2) := by
  have hden : 0 < 2*h*(1+h)^2 := by positivity
  apply (le_div_iff₀ hden).2
  have hprod : 0 ≤ (y-h)^2*(1-y)*(y+1+2*h) :=
    mul_nonneg (mul_nonneg (sq_nonneg _) (sub_nonneg.mpr hy₁)) (by linarith)
  calc
    y * (2*h*(1+h)^2) ≤ y * (2*h*(1+h)^2) + (y-h)^2*(1-y)*(y+1+2*h) :=
      le_add_of_nonneg_right hprod
    _ = -(y^4) + (3*h^2 + 2*h + 1)*y^2 + h^2*(1+2*h) := by ring

/-- The Hermite majorant contacts the square root only at the two
prescribed amplitudes. -/
theorem hermiteEquality {h y : ℝ} (hh : 0 < h) (hy : 0 ≤ y) :
    y = (-(y^4) + (3*h^2 + 2*h + 1)*y^2 + h^2*(1+2*h)) /
      (2*h*(1+h)^2) ↔ y = h ∨ y = 1 := by
  have hden : 0 < 2*h*(1+h)^2 := by positivity
  rw [eq_div_iff (ne_of_gt hden), ← majorantDeficit h y]
  constructor
  · intro heq
    have hzero : (y-h)^2*(1-y)*(y+1+2*h) = 0 :=
      add_left_cancel (heq.symm.trans (add_zero _).symm)
    rcases mul_eq_zero.mp hzero with h | h
    · rcases mul_eq_zero.mp h with h | h
      · left
        exact sub_eq_zero.mp ((sq_eq_zero_iff).mp h)
      · right
        exact (sub_eq_zero.mp h).symm
    · linarith
  · rintro (rfl | rfl) <;> ring

/-- Among vectors with fixed second and fourth moments, any vector with
entries in {h,1} maximizes the first moment on [0,1]. -/
theorem hermiteMomentComparison {ι : Type*} [Fintype ι] {h : ℝ} (hh : 0 < h)
    (y z : ι → ℝ) (hy : ∀ i, 0 ≤ y i) (hy₁ : ∀ i, y i ≤ 1)
    (hz : ∀ i, z i = h ∨ z i = 1)
    (h₂ : ∑ i, (y i)^2 = ∑ i, (z i)^2)
    (h₄ : ∑ i, (y i)^4 = ∑ i, (z i)^4) :
    (∑ i, y i) ≤ ∑ i, z i := by
  have hden : 0 < 2*h*(1+h)^2 := by positivity
  have hcontact (i : ι) : majorant h (z i) = z i := by
    apply (div_eq_iff (ne_of_gt hden)).2
    have hid := majorantDeficit h (z i)
    rcases hz i with hzi | hzi
    · rw [hzi] at hid ⊢
      simpa [majorant] using hid.symm
    · rw [hzi] at hid ⊢
      simpa [majorant] using hid.symm
  calc
    (∑ i, y i) ≤ ∑ i, majorant h (y i) :=
      Finset.sum_le_sum (fun i _ => hermiteMajorant hh (hy i) (hy₁ i))
    _ = ∑ i, majorant h (z i) := by
      simp only [majorant, div_eq_mul_inv, ← Finset.sum_mul, Finset.sum_add_distrib,
        Finset.sum_neg_distrib, ← Finset.mul_sum, h₂, h₄]
    _ = ∑ i, z i := Finset.sum_congr rfl (fun i _ => hcontact i)

/-- A quadratic majorant for the square root on [0,1], with contact at
1 and tangency at 1/3. The variables are expressed using y = sqrt(x). -/
theorem sqrtMajorant {y : ℝ} (hy : 0 ≤ y) (hy₁ : y ≤ 1) :
    y ≤ (9/4 - 3 * Real.sqrt 3 / 2) * y^4 +
      (3 * Real.sqrt 3 / 2 - 3/2) * y^2 + 1/4 := by
  let s := Real.sqrt 3
  have hs : s ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hs₀ : 0 ≤ s := Real.sqrt_nonneg _
  have hs₁ : 3/2 ≤ s := by nlinarith
  change y ≤ (9/4 - 3*s/2) * y^4 + (3*s/2 - 3/2) * y^2 + 1/4
  have hfac : (9/4 - 3*s/2) * y^4 + (3*s/2 - 3/2) * y^2 + 1/4 - y =
      (3*s/2 - 9/4) * (1-y) * (y-s/3)^2 * (y+1+2*s/3) := by
    linear_combination
      (s^2 * (y/9 - 1/9) + s * (-y^2/2 + y/2) - y^2/4 + y/3 - 1/12) * hs
  have hpos : 0 ≤ (3*s/2 - 9/4) * (1-y) * (y-s/3)^2 * (y+1+2*s/3) :=
    mul_nonneg (mul_nonneg (mul_nonneg (by linarith) (by linarith)) (sq_nonneg _))
      (by linarith)
  linarith [hfac]

/-- The exact first-moment bound from the two SIC moment identities. -/
theorem sicMomentBound (y : Fin 4 → ℝ) (hy : ∀ i, 0 ≤ y i)
    (hy₁ : ∀ i, y i ≤ 1)
    (h₂ : ∑ i, (y i)^2 = 2) (h₄ : ∑ i, (y i)^4 = 4/3) :
    ∑ i, y i ≤ 1 + Real.sqrt 3 := by
  calc
    (∑ i, y i) ≤ ∑ i, ((9/4 - 3 * Real.sqrt 3 / 2) * (y i)^4 +
        (3 * Real.sqrt 3 / 2 - 3/2) * (y i)^2 + 1/4) :=
      Finset.sum_le_sum (fun i _ => sqrtMajorant (hy i) (hy₁ i))
    _ = 1 + Real.sqrt 3 := by
      simp only [Finset.sum_add_distrib, ← Finset.mul_sum, h₂, h₄,
        Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
      norm_num
      ring

end ToroidalSIC

#print axioms ToroidalSIC.sqrtMajorant
#print axioms ToroidalSIC.sicMomentBound
#print axioms ToroidalSIC.hermiteMajorant
#print axioms ToroidalSIC.hermiteMomentComparison
#print axioms ToroidalSIC.hermiteEquality
