import TVBounds

open scoped BigOperators

namespace Lueders

noncomputable def rmat (a b d : ℝ) : M2 := (Herm2.mk a b 0 d).matrix

theorem rmat_add (a b d u v w : ℝ) :
    rmat a b d + rmat u v w = rmat (a+u) (b+v) (d+w) := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [rmat, Herm2.matrix]

theorem rmat_sub (a b d u v w : ℝ) :
    rmat a b d - rmat u v w = rmat (a-u) (b-v) (d-w) := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [rmat, Herm2.matrix]

theorem rmat_one : rmat 1 0 1 = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;> norm_num [rmat, Herm2.matrix, Matrix.one_apply]

theorem rmat_zero : rmat 0 0 0 = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;> norm_num [rmat, Herm2.matrix]

theorem rmat_positive (a b d : ℝ) :
    IsPositive (rmat a b d) ↔ 0 ≤ a ∧ 0 ≤ d ∧ b^2 ≤ a*d := by
  simpa [rmat, Herm2.Positive] using (Herm2.mk a b 0 d).positive_iff_matrix.symm

theorem rmat_sandwich (a b d u v w : ℝ) :
    rmat a b d * rmat u v w * rmat a b d =
      rmat (a^2*u+2*a*b*v+b^2*w)
        (a*b*u+(a*d+b^2)*v+b*d*w)
        (b^2*u+2*b*d*v+d^2*w) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [rmat, Herm2.matrix, Matrix.mul_apply, Fin.sum_univ_two] <;> ring

theorem rmat_square (a b d : ℝ) :
    rmat a b d * rmat a b d = rmat (a^2+b^2) (a*b+b*d) (b^2+d^2) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [rmat, Herm2.matrix, Matrix.mul_apply, Fin.sum_univ_two] <;> ring

noncomputable def A0 : M2 := rmat (2/3) 0 0
noncomputable def A1 : M2 := rmat (5/18) (1/6) (1/2)
noncomputable def A2 : M2 := rmat (1/18) (-1/6) (1/2)
noncomputable def B0 : M2 := rmat (16/25) 0 1
noncomputable def B1 : M2 := rmat (9/25) 0 0
noncomputable def C0 : M2 := rmat (17/18) (1/6) (1/2)

noncomputable def K0 : M2 := rmat (Real.sqrt 6/3) 0 0
noncomputable def K1 : M2 := rmat (11*Real.sqrt 13/78) (3*Real.sqrt 13/78) (15*Real.sqrt 13/78)
noncomputable def K2 : M2 := rmat (Real.sqrt 5/30) (-3*Real.sqrt 5/30) (9*Real.sqrt 5/30)
noncomputable def L0 : M2 := rmat (4/5) 0 1
noncomputable def L1 : M2 := rmat (3/5) 0 0
noncomputable def J0 : M2 := rmat (29/30) (1/10) (7/10)

theorem effects_positive : IsPositive A0 ∧ IsPositive A1 ∧ IsPositive A2 ∧
    IsPositive B0 ∧ IsPositive B1 ∧ IsPositive C0 := by
  norm_num [A0,A1,A2,B0,B1,C0,rmat_positive]

theorem merge_identity : C0 = A0+A1 := by
  rw [A0,A1,rmat_add]
  norm_num [C0]

theorem effects_A_sum : A0+A1+A2 = 1 := by
  rw [← merge_identity, C0,A2,rmat_add]
  norm_num
  exact rmat_one

theorem effects_B_sum : B0+B1 = 1 := by
  rw [B0,B1,rmat_add]
  norm_num
  exact rmat_one

theorem effects_C_sum : C0+A2 = 1 := by
  rw [merge_identity]
  exact effects_A_sum

theorem roots_positive : IsPositive K0 ∧ IsPositive K1 ∧ IsPositive K2 ∧
    IsPositive L0 ∧ IsPositive L1 ∧ IsPositive J0 := by
  have h6 := Real.sqrt_nonneg (6:ℝ)
  have h13 := Real.sqrt_nonneg (13:ℝ)
  have h5 := Real.sqrt_nonneg (5:ℝ)
  have s6 := Real.sq_sqrt (show (0:ℝ)≤6 by norm_num)
  have s13 := Real.sq_sqrt (show (0:ℝ)≤13 by norm_num)
  have s5 := Real.sq_sqrt (show (0:ℝ)≤5 by norm_num)
  simp only [K0,K1,K2,L0,L1,J0,rmat_positive]
  refine ⟨⟨?_,?_,?_⟩,⟨?_,?_,?_⟩,⟨?_,?_,?_⟩,⟨?_,?_,?_⟩,⟨?_,?_,?_⟩,⟨?_,?_,?_⟩⟩ <;> nlinarith

theorem K0_square : K0*K0=A0 := by
  rw [K0, rmat_square]
  unfold A0
  ring_nf
  all_goals norm_num [Real.sq_sqrt]

theorem K1_square : K1*K1=A1 := by
  rw [K1,rmat_square]
  unfold A1
  ring_nf
  all_goals norm_num [Real.sq_sqrt]

theorem K2_square : K2*K2=A2 := by
  rw [K2,rmat_square]
  unfold A2
  ring_nf
  all_goals norm_num [Real.sq_sqrt]

theorem L0_square : L0*L0=B0 := by rw [L0,rmat_square]; norm_num [B0]
theorem L1_square : L1*L1=B1 := by rw [L1,rmat_square]; norm_num [B1]
theorem J0_square : J0*J0=C0 := by rw [J0,rmat_square]; norm_num [C0]

theorem diff00 : K0*B0*K0-L0*A0*L0=0 := by
  rw [K0,B0,L0,A0,rmat_sandwich,rmat_sandwich,rmat_sub]
  rw [← rmat_zero]
  ring_nf
  all_goals norm_num [Real.sq_sqrt]

theorem diff01 : K0*B1*K0-L1*A0*L1=0 := by
  rw [K0,B1,L1,A0,rmat_sandwich,rmat_sandwich,rmat_sub]
  rw [← rmat_zero]
  ring_nf
  all_goals norm_num [Real.sq_sqrt]

theorem diff10 : K1*B0*K1-L0*A1*L0=rmat (9/1300) (31/3900) (-9/1300) := by
  rw [K1,B0,L0,A1,rmat_sandwich,rmat_sandwich,rmat_sub]
  ring_nf
  all_goals norm_num [Real.sq_sqrt]

theorem diff11 : K1*B1*K1-L1*A1*L1=rmat (-9/1300) (33/1300) (9/1300) := by
  rw [K1,B1,L1,A1,rmat_sandwich,rmat_sandwich,rmat_sub]
  ring_nf
  all_goals norm_num [Real.sq_sqrt]

theorem diff20 : K2*B0*K2-L0*A2*L0=rmat (9/500) (-41/1500) (-9/500) := by
  rw [K2,B0,L0,A2,rmat_sandwich,rmat_sandwich,rmat_sub]
  ring_nf
  all_goals norm_num [Real.sq_sqrt]

theorem diff21 : K2*B1*K2-L1*A2*L1=rmat (-9/500) (-3/500) (9/500) := by
  rw [K2,B1,L1,A2,rmat_sandwich,rmat_sandwich,rmat_sub]
  ring_nf
  all_goals norm_num [Real.sq_sqrt]

theorem coarse_diff00 : J0*B0*J0-L0*C0*L0=rmat (9/2500) (-11/7500) (-9/2500) := by
  rw [J0,B0,L0,C0,rmat_sandwich,rmat_sandwich,rmat_sub]
  norm_num

theorem coarse_diff01 : J0*B1*J0-L1*C0*L1=rmat (-9/2500) (87/2500) (9/2500) := by
  rw [J0,B1,L1,C0,rmat_sandwich,rmat_sandwich,rmat_sub]
  norm_num

theorem coarse_forward_gap : J0*B0*J0-(K0*B0*K0+K1*B0*K1)=
    rmat (-27/8125) (-153/16250) (27/8125) := by
  rw [J0,B0,K0,K1,rmat_sandwich,rmat_sandwich,rmat_sandwich,rmat_add,rmat_sub]
  ring_nf
  norm_num [Real.sq_sqrt]

theorem coarse_forward_different : J0*B0*J0 ≠ K0*B0*K0+K1*B0*K1 := by
  intro h
  have hg := coarse_forward_gap
  rw [h,sub_self] at hg
  have he := congrArg (fun M : M2 => (M 0 0).re) hg
  norm_num [rmat,Herm2.matrix] at he

end Lueders
