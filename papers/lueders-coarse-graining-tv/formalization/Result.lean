import ExactModel
import Mathlib.Data.Complex.BigOperators

open scoped BigOperators

namespace Lueders

noncomputable def effectsA : Fin 3 → M2 := ![A0,A1,A2]
noncomputable def effectsB : Fin 2 → M2 := ![B0,B1]
noncomputable def effectsC : Fin 2 → M2 := ![C0,A2]
noncomputable def rootsA : Fin 3 → M2 := ![K0,K1,K2]
noncomputable def rootsB : Fin 2 → M2 := ![L0,L1]
noncomputable def rootsC : Fin 2 → M2 := ![J0,K2]

noncomputable def ValidLuders {n : ℕ} (E K : Fin n → M2) : Prop :=
  (∀ i, IsPositive (E i)) ∧ (∑ i, E i)=1 ∧
  (∀ i, IsPositive (K i)) ∧ ∀ i, K i*K i=E i

noncomputable def jointAB {n m : ℕ} (K : Fin n → M2) (F : Fin m → M2)
    (rho : M2) (i : Fin n) (j : Fin m) : ℝ :=
  (Matrix.trace (rho*(K i*F j*K i))).re

noncomputable def jointBA {n m : ℕ} (E : Fin n → M2) (L : Fin m → M2)
    (rho : M2) (i : Fin n) (j : Fin m) : ℝ :=
  (Matrix.trace (rho*(L j*E i*L j))).re

noncomputable def orderTV {n m : ℕ} (E K : Fin n → M2) (F L : Fin m → M2)
    (rho : M2) : ℝ :=
  (∑ i, ∑ j, |jointAB K F rho i j-jointBA E L rho i j|)/2

noncomputable def HasOptimalScore {n m : ℕ} (E K : Fin n → M2) (F L : Fin m → M2)
    (t : ℝ) : Prop :=
  (∀ rho, IsDensity rho → orderTV E K F L rho ≤ t) ∧
  ∃ rho, IsDensity rho ∧ orderTV E K F L rho=t

theorem validA : ValidLuders effectsA rootsA := by
  refine ⟨?_,?_,?_,?_⟩
  · intro i; fin_cases i
    · exact effects_positive.1
    · exact effects_positive.2.1
    · exact effects_positive.2.2.1
  · simpa [effectsA, Fin.sum_univ_succ, add_assoc] using effects_A_sum
  · intro i; fin_cases i
    · exact roots_positive.1
    · exact roots_positive.2.1
    · exact roots_positive.2.2.1
  · intro i; fin_cases i <;> simp [effectsA,rootsA,K0_square,K1_square,K2_square]

theorem validB : ValidLuders effectsB rootsB := by
  refine ⟨?_,?_,?_,?_⟩
  · intro i; fin_cases i
    · exact effects_positive.2.2.2.1
    · exact effects_positive.2.2.2.2.1
  · simpa [effectsB,Fin.sum_univ_succ] using effects_B_sum
  · intro i; fin_cases i
    · exact roots_positive.2.2.2.1
    · exact roots_positive.2.2.2.2.1
  · intro i; fin_cases i <;> simp [effectsB,rootsB,L0_square,L1_square]

theorem validC : ValidLuders effectsC rootsC := by
  refine ⟨?_,?_,?_,?_⟩
  · intro i; fin_cases i
    · exact effects_positive.2.2.2.2.2
    · exact effects_positive.2.2.1
  · simpa [effectsC,Fin.sum_univ_succ] using effects_C_sum
  · intro i; fin_cases i
    · exact roots_positive.2.2.2.2.2
    · exact roots_positive.2.2.1
  · intro i; fin_cases i <;> simp [effectsC,rootsC,J0_square,K2_square]

theorem valid_root_is_unique {n : ℕ} {E K : Fin n → M2} (h : ValidLuders E K)
    (i : Fin n) (R : M2) (hR : IsPositive R) (hsq : R*R=E i) : R=K i := by
  exact positive_roots_unique hR (h.2.2.1 i) (hsq.trans (h.2.2.2 i).symm)

theorem exact_coarsening : effectsC 0=effectsA 0+effectsA 1 ∧ effectsC 1=effectsA 2 := by
  simpa [effectsC,effectsA] using (show C0=A0+A1 ∧ A2=A2 from ⟨merge_identity,rfl⟩)

theorem jointAB_nonnegative {n m : ℕ} {E K : Fin n → M2} {F L : Fin m → M2}
    (hE : ValidLuders E K) (hF : ValidLuders F L) {rho : M2} (hr : IsDensity rho)
    (i : Fin n) (j : Fin m) : 0 ≤ jointAB K F rho i j := by
  exact sequential_probability_nonneg hr (hF.1 j) (hE.2.2.1 i).1

theorem jointBA_nonnegative {n m : ℕ} {E K : Fin n → M2} {F L : Fin m → M2}
    (hE : ValidLuders E K) (hF : ValidLuders F L) {rho : M2} (hr : IsDensity rho)
    (i : Fin n) (j : Fin m) : 0 ≤ jointBA E L rho i j := by
  exact sequential_probability_nonneg hr (hE.1 i) (hF.2.2.1 j).1

theorem jointAB_trace_real {n m : ℕ} {E K : Fin n → M2} {F L : Fin m → M2}
    (hE : ValidLuders E K) (hF : ValidLuders F L) {rho : M2} (hr : IsDensity rho)
    (i : Fin n) (j : Fin m) :
    Matrix.trace (rho*(K i*F j*K i)) = (jointAB K F rho i j : ℂ) := by
  apply Complex.ext
  · rfl
  · simpa using positive_trace_mul_im_zero hr.1
      (positive_sandwich (hF.1 j) (hE.2.2.1 i).1)

theorem jointBA_trace_real {n m : ℕ} {E K : Fin n → M2} {F L : Fin m → M2}
    (hE : ValidLuders E K) (hF : ValidLuders F L) {rho : M2} (hr : IsDensity rho)
    (i : Fin n) (j : Fin m) :
    Matrix.trace (rho*(L j*E i*L j)) = (jointBA E L rho i j : ℂ) := by
  apply Complex.ext
  · rfl
  · simpa using positive_trace_mul_im_zero hr.1
      (positive_sandwich (hE.1 i) (hF.2.2.1 j).1)

theorem AB_effects_normalized {n m : ℕ} {E K : Fin n → M2} {F L : Fin m → M2}
    (hE : ValidLuders E K) (hF : ValidLuders F L) :
    (∑ i, ∑ j, K i*F j*K i) = 1 := by
  calc
    _ = ∑ i, K i*(∑ j, F j)*K i := by simp only [Finset.sum_mul, Finset.mul_sum]
    _ = ∑ i, E i := by simp only [hF.2.1,mul_one,hE.2.2.2]
    _ = 1 := hE.2.1

theorem BA_effects_normalized {n m : ℕ} {E K : Fin n → M2} {F L : Fin m → M2}
    (hE : ValidLuders E K) (hF : ValidLuders F L) :
    (∑ i, ∑ j, L j*E i*L j) = 1 := by
  rw [Finset.sum_comm]
  exact AB_effects_normalized hF hE

theorem jointAB_normalized {n m : ℕ} {E K : Fin n → M2} {F L : Fin m → M2}
    (hE : ValidLuders E K) (hF : ValidLuders F L) {rho : M2} (hr : IsDensity rho) :
    (∑ i, ∑ j, jointAB K F rho i j) = 1 := by
  simp only [jointAB, ← Complex.re_sum, ← Matrix.trace_sum, ← Finset.mul_sum]
  rw [AB_effects_normalized hE hF, mul_one, hr.2]
  rfl

theorem jointBA_normalized {n m : ℕ} {E K : Fin n → M2} {F L : Fin m → M2}
    (hE : ValidLuders E K) (hF : ValidLuders F L) {rho : M2} (hr : IsDensity rho) :
    (∑ i, ∑ j, jointBA E L rho i j) = 1 := by
  simp only [jointBA, ← Complex.re_sum, ← Matrix.trace_sum, ← Finset.mul_sum]
  rw [BA_effects_normalized hE hF, mul_one, hr.2]
  rfl

theorem trace_difference (rho S T : M2) :
    (Matrix.trace (rho*S)).re-(Matrix.trace (rho*T)).re =
      (Matrix.trace (rho*(S-T))).re := by
  simp [Matrix.mul_sub]

theorem density_rmat_trace (rho : M2) (h : IsDensity rho) (x z : ℝ) :
    (Matrix.trace (rho*rmat z x (-z))).re =
      x*(2*(rho 0 1).re)+z*((rho 0 0).re-(rho 1 1).re) := by
  simpa [rmat,mul_comm] using congrArg Complex.re (density_traceless_trace rho h x z)

theorem density_rmat_trace_general (rho : M2) (h : IsDensity rho) (a b d : ℝ) :
    (Matrix.trace (rho*rmat a b d)).re =
      (rho 0 0).re*a+(rho 1 1).re*d+2*(rho 0 1).re*b := by
  conv_lhs => rw [← coordinates_matrix rho h.1.1]
  rw [rmat,Herm2.trace_mul]
  simp [coordinates]

theorem fine_native_formula (rho : M2) (h : IsDensity rho) :
    orderTV effectsA rootsA effectsB rootsB rho =
      fineTV (2*(rho 0 1).re) ((rho 0 0).re-(rho 1 1).re) := by
  simp only [orderTV,jointAB,jointBA,Fin.sum_univ_succ,effectsA,rootsA,effectsB,rootsB,
    Matrix.cons_val_zero, Matrix.cons_val_succ,
    Fin.sum_univ_zero, add_zero, trace_difference]
  rw [diff00,diff01,diff10,diff11,diff20,diff21]
  simp only [Matrix.mul_zero,Matrix.trace_zero,Complex.zero_re,abs_zero,zero_add]
  simp only [density_rmat_trace_general rho h]
  simp only [fineTV,sub_eq_add_neg,neg_mul]
  ring

theorem coarse_native_formula (rho : M2) (h : IsDensity rho) :
    orderTV effectsC rootsC effectsB rootsB rho =
      coarseTV (2*(rho 0 1).re) ((rho 0 0).re-(rho 1 1).re) := by
  simp only [orderTV,jointAB,jointBA,Fin.sum_univ_succ,effectsC,rootsC,effectsB,rootsB,
    Matrix.cons_val_zero, Matrix.cons_val_succ, Fin.sum_univ_zero,add_zero,trace_difference]
  rw [coarse_diff00,coarse_diff01,diff20,diff21]
  simp only [density_rmat_trace_general rho h]
  simp only [coarseTV,sub_eq_add_neg,neg_mul]
  ring

noncomputable def rhoFine : M2 := rmat (1/2) (1/2) (1/2)
noncomputable def rhoCoarse : M2 := rmat (1/5) (2/5) (4/5)

theorem rhoFine_density : IsDensity rhoFine := by
  apply (Herm2.mk (1/2) (1/2) 0 (1/2)).density_iff.mpr
  norm_num [Herm2.Positive]

theorem rhoCoarse_density : IsDensity rhoCoarse := by
  apply (Herm2.mk (1/5) (2/5) 0 (4/5)).density_iff.mpr
  norm_num [Herm2.Positive]

theorem fine_all_density_bound (rho : M2) (h : IsDensity rho) :
    orderTV effectsA rootsA effectsB rootsB rho ≤ 1/30 := by
  rw [fine_native_formula rho h]
  exact fineTV_upper _ _ (density_real_projection_ball rho h)

theorem coarse_all_density_bound (rho : M2) (h : IsDensity rho) :
    orderTV effectsC rootsC effectsB rootsB rho ≤ 9/250 := by
  rw [coarse_native_formula rho h]
  exact coarseTV_upper _ _ (density_real_projection_ball rho h)

theorem fine_witness : orderTV effectsA rootsA effectsB rootsB rhoFine=1/30 := by
  rw [fine_native_formula rhoFine rhoFine_density]
  simpa [rhoFine,rmat,Herm2.matrix] using fineTV_attained

theorem coarse_witness : orderTV effectsC rootsC effectsB rootsB rhoCoarse=9/250 := by
  rw [coarse_native_formula rhoCoarse rhoCoarse_density]
  convert coarseTV_attained using 1
  norm_num [rhoCoarse,rmat,Herm2.matrix]

theorem fine_exact_optimum : HasOptimalScore effectsA rootsA effectsB rootsB (1/30) :=
  ⟨fine_all_density_bound, rhoFine, rhoFine_density, fine_witness⟩

theorem coarse_exact_optimum : HasOptimalScore effectsC rootsC effectsB rootsB (9/250) :=
  ⟨coarse_all_density_bound, rhoCoarse, rhoCoarse_density, coarse_witness⟩

theorem optimum_unique {n m : ℕ} {E K : Fin n → M2} {F L : Fin m → M2}
    {s t : ℝ} (hs : HasOptimalScore E K F L s) (ht : HasOptimalScore E K F L t) : s=t := by
  rcases hs.2 with ⟨r,hr,he⟩
  rcases ht.2 with ⟨r',hr',he'⟩
  have hst := ht.1 r hr
  have hts := hs.1 r' hr'
  rw [he] at hst
  rw [he'] at hts
  exact le_antisymm hst hts

theorem lueders_coarse_graining_counterexample :
    ValidLuders effectsA rootsA ∧ ValidLuders effectsB rootsB ∧
    ValidLuders effectsC rootsC ∧
    effectsC 0=effectsA 0+effectsA 1 ∧ effectsC 1=effectsA 2 ∧
    HasOptimalScore effectsA rootsA effectsB rootsB (1/30) ∧
    HasOptimalScore effectsC rootsC effectsB rootsB (9/250) ∧
    (9/250:ℝ)-(1/30)=1/375 ∧ (1/30:ℝ)<9/250 := by
  exact ⟨validA,validB,validC,exact_coarsening.1,exact_coarsening.2,
    fine_exact_optimum,coarse_exact_optimum,strict_gap.1,strict_gap.2⟩

theorem not_coarse_graining_monotone :
    ¬ (∀ (E K : Fin 3 → M2) (F L C J : Fin 2 → M2) (s t : ℝ),
      ValidLuders E K → ValidLuders F L → ValidLuders C J →
      C 0=E 0+E 1 → C 1=E 2 →
      HasOptimalScore E K F L s → HasOptimalScore C J F L t → t≤s) := by
  intro hm
  have h := hm effectsA rootsA effectsB rootsB effectsC rootsC (1/30) (9/250)
    validA validB validC exact_coarsening.1 exact_coarsening.2 fine_exact_optimum coarse_exact_optimum
  norm_num at h

theorem witness_idempotence : rhoFine*rhoFine=rhoFine ∧ rhoCoarse*rhoCoarse=rhoCoarse := by
  constructor <;> simp only [rhoFine,rhoCoarse,rmat_square] <;> norm_num

end Lueders
