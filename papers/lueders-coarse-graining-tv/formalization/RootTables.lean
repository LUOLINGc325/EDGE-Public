import ExactModel

namespace Lueders

theorem rmat_congr {a b d u v w : ℝ} (ha : a=u) (hb : b=v) (hd : d=w) :
    rmat a b d=rmat u v w := by rw [ha,hb,hd]

theorem sqrt468 : Real.sqrt (468:ℝ)=6*Real.sqrt 13 := by
  rw [show (468:ℝ)=36*13 by norm_num, Real.sqrt_mul (by norm_num)]
  rw [show (36:ℝ)=(6:ℝ)^2 by norm_num, Real.sqrt_sq (by norm_num)]

theorem sqrt180 : Real.sqrt (180:ℝ)=6*Real.sqrt 5 := by
  rw [show (180:ℝ)=36*5 by norm_num, Real.sqrt_mul (by norm_num)]
  rw [show (36:ℝ)=(6:ℝ)^2 by norm_num, Real.sqrt_sq (by norm_num)]

theorem divide_sqrt (a r : ℝ) : a/Real.sqrt r = a*Real.sqrt r/r := by
  rw [div_eq_mul_inv, ← Real.sqrt_div_self]
  ring

theorem K0_table : K0=rmat (2/Real.sqrt 6) 0 0 := by
  rw [divide_sqrt,K0]
  ring_nf

theorem K1_table : K1=rmat (11/Real.sqrt 468) (3/Real.sqrt 468) (15/Real.sqrt 468) := by
  simp only [divide_sqrt]
  rw [sqrt468,K1]
  ring_nf

theorem K2_table : K2=rmat (1/Real.sqrt 180) (-3/Real.sqrt 180) (9/Real.sqrt 180) := by
  simp only [divide_sqrt]
  rw [sqrt180,K2]
  ring_nf

theorem J0_table : J0=rmat (29/Real.sqrt 900) (3/Real.sqrt 900) (21/Real.sqrt 900) := by
  rw [show (900:ℝ)=(30:ℝ)^2 by norm_num, Real.sqrt_sq (by norm_num)]
  norm_num [J0]

theorem L0_table : L0=rmat (4/Real.sqrt 25) 0 (5/Real.sqrt 25) := by
  rw [show (25:ℝ)=(5:ℝ)^2 by norm_num, Real.sqrt_sq (by norm_num)]
  norm_num [L0]
theorem L1_table : L1=rmat (3/Real.sqrt 25) 0 0 := by
  rw [show (25:ℝ)=(5:ℝ)^2 by norm_num, Real.sqrt_sq (by norm_num)]
  norm_num [L1]

theorem numerator_certificates :
    IsPositive (rmat 2 0 0) ∧ IsPositive (rmat 11 3 15) ∧
    IsPositive (rmat 1 (-3) 9) ∧ IsPositive (rmat 29 3 21) ∧
    IsPositive (rmat 4 0 5) ∧ IsPositive (rmat 3 0 0) ∧
    (11:ℝ)*15-3^2=156 ∧ (29:ℝ)*21-3^2=600 ∧ (4:ℝ)*5=20 := by
  norm_num [rmat_positive]

noncomputable def determinant2Real (M : M2) : ℝ := (M 0 0*M 1 1-M 0 1*M 1 0).re

theorem effect_determinants : determinant2Real A0=0 ∧ determinant2Real A1=1/9 ∧
    determinant2Real A2=0 ∧ determinant2Real B0=16/25 ∧ determinant2Real B1=0 ∧
    determinant2Real C0=4/9 := by
  norm_num [determinant2Real,A0,A1,A2,B0,B1,C0,rmat,Herm2.matrix]

end Lueders
