import Mathlib.Data.Complex.Basic
import Mathlib.Data.Matrix.Notation
import Mathlib.Data.Matrix.ConjTranspose
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FinCases

/-! Elementary coordinate lemmas for complex qubits. No spectral library is needed. -/
namespace Lueders

abbrev M2 := Matrix (Fin 2) (Fin 2) ℂ

structure Herm2 where
  a : ℝ
  b : ℝ
  c : ℝ
  d : ℝ

noncomputable def Herm2.matrix (H : Herm2) : M2 :=
  !![(H.a : ℂ), (H.b : ℂ) + (H.c : ℂ) * Complex.I;
     (H.b : ℂ) - (H.c : ℂ) * Complex.I, (H.d : ℂ)]

noncomputable def Herm2.quad (H : Herm2) (x y u v : ℝ) : ℝ :=
  H.a * (x ^ 2 + y ^ 2) + H.d * (u ^ 2 + v ^ 2) +
    2 * H.b * (x * u + y * v) + 2 * H.c * (y * u - x * v)

noncomputable def Herm2.Positive (H : Herm2) : Prop :=
  0 ≤ H.a ∧ 0 ≤ H.d ∧ H.b ^ 2 + H.c ^ 2 ≤ H.a * H.d

noncomputable def matrixQuad (M : M2) (z w : ℂ) : ℝ :=
  ((starRingEnd ℂ) z * (M 0 0 * z + M 0 1 * w) +
    (starRingEnd ℂ) w * (M 1 0 * z + M 1 1 * w)).re

noncomputable def IsPositive (M : M2) : Prop :=
  M.conjTranspose = M ∧ ∀ z w : ℂ, 0 ≤ matrixQuad M z w

noncomputable def IsDensity (M : M2) : Prop :=
  IsPositive M ∧ Matrix.trace M = 1

theorem real_psd_necessity {a b d : ℝ}
    (h : ∀ x u : ℝ, 0 ≤ a * x ^ 2 + 2 * b * x * u + d * u ^ 2) :
    0 ≤ a ∧ 0 ≤ d ∧ b ^ 2 ≤ a * d := by
  have ha : 0 ≤ a := by simpa using h 1 0
  have hd : 0 ≤ d := by simpa using h 0 1
  refine ⟨ha, hd, ?_⟩
  by_cases haz : a = 0
  · have h1 := h (-(d + 1)) b
    have h2 : 0 ≤ d * b ^ 2 := mul_nonneg hd (sq_nonneg b)
    simp only [haz, zero_mul, zero_add] at h1
    nlinarith [sq_nonneg b]
  · have hap : 0 < a := lt_of_le_of_ne ha (Ne.symm haz)
    have h1 := h (-b) a
    have hid : a * (-b) ^ 2 + 2 * b * (-b) * a + d * a ^ 2 =
        a * (a * d - b ^ 2) := by ring
    rw [hid] at h1
    exact sub_nonneg.mp (nonneg_of_mul_nonneg_right h1 hap)

theorem Herm2.positive_of_quad (H : Herm2)
    (h : ∀ x y u v : ℝ, 0 ≤ H.quad x y u v) : H.Positive := by
  have hr := real_psd_necessity (a := H.a) (b := H.b) (d := H.d)
    (by intro x u; simpa [Herm2.quad, mul_assoc, add_comm, add_left_comm, add_assoc] using h x 0 u 0)
  have hi := real_psd_necessity (a := H.a) (b := H.c) (d := H.d)
    (by intro y u; simpa [Herm2.quad, mul_assoc, add_comm, add_left_comm, add_assoc] using h 0 y u 0)
  refine ⟨hr.1, hr.2.1, ?_⟩
  by_cases haz : H.a = 0
  · rw [haz, zero_mul] at hr hi ⊢
    nlinarith [sq_nonneg H.b, sq_nonneg H.c]
  · have hap : 0 < H.a := lt_of_le_of_ne hr.1 (Ne.symm haz)
    have h1 := h (-H.b) (-H.c) H.a 0
    have hid : H.quad (-H.b) (-H.c) H.a 0 =
        H.a * (H.a * H.d - (H.b ^ 2 + H.c ^ 2)) := by
      unfold Herm2.quad
      ring
    rw [hid] at h1
    exact sub_nonneg.mp (nonneg_of_mul_nonneg_right h1 hap)

theorem Herm2.quad_nonneg (H : Herm2) (h : H.Positive) (x y u v : ℝ) :
    0 ≤ H.quad x y u v := by
  rcases h with ⟨ha, hd, hdet⟩
  by_cases haz : H.a = 0
  · have hb : H.b = 0 := by rw [haz, zero_mul] at hdet; nlinarith [sq_nonneg H.c]
    have hc : H.c = 0 := by rw [haz, zero_mul] at hdet; nlinarith [sq_nonneg H.b]
    simp only [Herm2.quad, haz, hb, hc, zero_mul, zero_add, mul_zero, add_zero]
    exact mul_nonneg hd (add_nonneg (sq_nonneg u) (sq_nonneg v))
  · have hap : 0 < H.a := lt_of_le_of_ne ha (Ne.symm haz)
    have hscale : H.a * H.quad x y u v =
        (H.a * x + H.b * u - H.c * v) ^ 2 +
        (H.a * y + H.c * u + H.b * v) ^ 2 +
        (H.a * H.d - (H.b ^ 2 + H.c ^ 2)) * (u ^ 2 + v ^ 2) := by
      unfold Herm2.quad
      ring
    have hs : 0 ≤ H.a * H.quad x y u v := by
      rw [hscale]
      exact add_nonneg (add_nonneg (sq_nonneg _) (sq_nonneg _))
        (mul_nonneg (sub_nonneg.mpr hdet) (add_nonneg (sq_nonneg u) (sq_nonneg v)))
    exact nonneg_of_mul_nonneg_right hs hap

theorem Herm2.positive_iff_quad (H : Herm2) :
    H.Positive ↔ ∀ x y u v : ℝ, 0 ≤ H.quad x y u v :=
  ⟨H.quad_nonneg, H.positive_of_quad⟩

theorem Herm2.bloch_ball (H : Herm2) (h : H.Positive) (htr : H.a + H.d = 1) :
    (2 * H.b) ^ 2 + (2 * H.c) ^ 2 + (H.a - H.d) ^ 2 ≤ 1 := by
  rcases h with ⟨ha, hd, hdet⟩
  nlinarith [sq_nonneg (H.a + H.d - 1)]

theorem Herm2.real_projection_ball (H : Herm2) (h : H.Positive)
    (htr : H.a + H.d = 1) : (2 * H.b) ^ 2 + (H.a - H.d) ^ 2 ≤ 1 := by
  have hb := H.bloch_ball h htr
  nlinarith [sq_nonneg (2 * H.c)]

theorem planar_dot_bound {a b x z u : ℝ} (hball : x ^ 2 + z ^ 2 ≤ 1)
    (hu : 0 ≤ u) (hnorm : a ^ 2 + b ^ 2 ≤ u ^ 2) : |a * x + b * z| ≤ u := by
  have hcauchy : (a * x + b * z) ^ 2 ≤
      (a ^ 2 + b ^ 2) * (x ^ 2 + z ^ 2) := by
    nlinarith [sq_nonneg (a * z - b * x)]
  have hprod : (a ^ 2 + b ^ 2) * (x ^ 2 + z ^ 2) ≤ a ^ 2 + b ^ 2 := by
    nlinarith [mul_nonneg (add_nonneg (sq_nonneg a) (sq_nonneg b))
      (sub_nonneg.mpr hball)]
  apply abs_le.mpr
  constructor <;> nlinarith

theorem Herm2.matrix_hermitian (H : Herm2) : H.matrix.conjTranspose = H.matrix := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Herm2.matrix, Matrix.conjTranspose_apply, sub_eq_add_neg]

theorem Herm2.matrix_quad (H : Herm2) (z w : ℂ) :
    matrixQuad H.matrix z w = H.quad z.re z.im w.re w.im := by
  simp [matrixQuad, Herm2.matrix, Herm2.quad, Complex.mul_re, Complex.mul_im]
  ring

theorem Herm2.positive_iff_matrix (H : Herm2) : H.Positive ↔ IsPositive H.matrix := by
  constructor
  · intro hp
    refine ⟨H.matrix_hermitian, ?_⟩
    intro z w
    rw [H.matrix_quad]
    exact H.quad_nonneg hp _ _ _ _
  · intro hp
    apply H.positive_of_quad
    intro x y u v
    have h := hp.2 ((x : ℂ) + (y : ℂ) * Complex.I) ((u : ℂ) + (v : ℂ) * Complex.I)
    rw [H.matrix_quad] at h
    simpa using h

theorem Herm2.matrix_trace (H : Herm2) : Matrix.trace H.matrix = (H.a + H.d : ℝ) := by
  simp [Matrix.trace, Fin.sum_univ_succ, Herm2.matrix]

theorem Herm2.density_iff (H : Herm2) :
    IsDensity H.matrix ↔ H.Positive ∧ H.a + H.d = 1 := by
  rw [IsDensity, ← H.positive_iff_matrix, H.matrix_trace]
  constructor
  · intro h
    refine ⟨h.1, ?_⟩
    exact_mod_cast h.2
  · intro h
    exact ⟨h.1, by exact_mod_cast h.2⟩


noncomputable def coordinates (M : M2) : Herm2 :=
  ⟨(M 0 0).re, (M 0 1).re, (M 0 1).im, (M 1 1).re⟩

theorem coordinates_matrix (M : M2) (hh : M.conjTranspose = M) :
    (coordinates M).matrix = M := by
  have h00 := congrArg (fun A : M2 => (A 0 0).im) hh
  have h11 := congrArg (fun A : M2 => (A 1 1).im) hh
  simp only [Matrix.conjTranspose_apply, Complex.star_def, Complex.conj_im] at h00 h11
  have hi00 : (M 0 0).im = 0 := by linarith
  have hi11 : (M 1 1).im = 0 := by linarith
  have h10 : M 1 0 = (starRingEnd ℂ) (M 0 1) := by
    have h := congrArg (fun A : M2 => A 1 0) hh
    exact h.symm
  ext i j
  fin_cases i <;> fin_cases j <;>
    apply Complex.ext <;> simp [coordinates, Herm2.matrix, hi00, hi11, h10]

theorem density_coordinates (M : M2) (h : IsDensity M) :
    (coordinates M).Positive ∧ (coordinates M).a + (coordinates M).d = 1 := by
  apply (coordinates M).density_iff.mp
  rw [coordinates_matrix M h.1.1]
  exact h

theorem density_real_projection_ball (M : M2) (h : IsDensity M) :
    (2 * (M 0 1).re) ^ 2 + ((M 0 0).re - (M 1 1).re) ^ 2 ≤ 1 := by
  exact (coordinates M).real_projection_ball (density_coordinates M h).1
    (density_coordinates M h).2

theorem Herm2.trace_mul (H K : Herm2) :
    Matrix.trace (H.matrix * K.matrix) =
      (H.a * K.a + H.d * K.d + 2 * H.b * K.b + 2 * H.c * K.c : ℝ) := by
  rw [Matrix.trace_fin_two]
  apply Complex.ext <;>
    simp [Herm2.matrix, Matrix.mul_apply, Fin.sum_univ_succ, Complex.mul_re, Complex.mul_im] <;> ring

theorem density_traceless_trace (M : M2) (h : IsDensity M) (x z : ℝ) :
    Matrix.trace (M * (Herm2.mk z x 0 (-z)).matrix) =
      ((2 * (M 0 1).re) * x + ((M 0 0).re - (M 1 1).re) * z : ℝ) := by
  conv_lhs => rw [← coordinates_matrix M h.1.1]
  rw [Herm2.trace_mul]
  congr 1
  simp [coordinates]
  ring

theorem Herm2.square_entries (H : Herm2) :
    (H.matrix * H.matrix) 0 0 = (H.a ^ 2 + H.b ^ 2 + H.c ^ 2 : ℝ) ∧
    (H.matrix * H.matrix) 1 1 = (H.d ^ 2 + H.b ^ 2 + H.c ^ 2 : ℝ) ∧
    ((H.matrix * H.matrix) 0 1).re = H.b * (H.a + H.d) ∧
    ((H.matrix * H.matrix) 0 1).im = H.c * (H.a + H.d) := by
  constructor
  · apply Complex.ext <;>
      simp [Herm2.matrix, Matrix.mul_apply, Fin.sum_univ_succ, Complex.mul_re, Complex.mul_im, ← Complex.ofReal_pow] <;> ring
  constructor
  · apply Complex.ext <;>
      simp [Herm2.matrix, Matrix.mul_apply, Fin.sum_univ_succ, Complex.mul_re, Complex.mul_im, ← Complex.ofReal_pow] <;> ring
  constructor <;>
    simp [Herm2.matrix, Matrix.mul_apply, Fin.sum_univ_succ, Complex.mul_re, Complex.mul_im, ← Complex.ofReal_pow] <;> ring

theorem roots_unique (H K : Herm2) (hH : H.Positive) (hK : K.Positive)
    (hsq : H.matrix * H.matrix = K.matrix * K.matrix) : H.matrix = K.matrix := by
  have h00 := congrArg (fun A : M2 => (A 0 0).re) hsq
  have h11 := congrArg (fun A : M2 => (A 1 1).re) hsq
  have h01r := congrArg (fun A : M2 => (A 0 1).re) hsq
  have h01i := congrArg (fun A : M2 => (A 0 1).im) hsq
  dsimp only at h00 h11 h01r h01i
  rw [H.square_entries.1, K.square_entries.1] at h00
  rw [H.square_entries.2.1, K.square_entries.2.1] at h11
  simp only [Complex.ofReal_re] at h00 h11
  rw [H.square_entries.2.2.1, K.square_entries.2.2.1] at h01r
  rw [H.square_entries.2.2.2, K.square_entries.2.2.2] at h01i
  have hdet2 : (H.a * H.d - (H.b ^ 2 + H.c ^ 2)) ^ 2 =
      (K.a * K.d - (K.b ^ 2 + K.c ^ 2)) ^ 2 := by
    calc
      _ = (H.a ^ 2 + H.b ^ 2 + H.c ^ 2) * (H.d ^ 2 + H.b ^ 2 + H.c ^ 2) -
        (H.b * (H.a + H.d)) ^ 2 - (H.c * (H.a + H.d)) ^ 2 := by ring
      _ = (K.a ^ 2 + K.b ^ 2 + K.c ^ 2) * (K.d ^ 2 + K.b ^ 2 + K.c ^ 2) -
        (K.b * (K.a + K.d)) ^ 2 - (K.c * (K.a + K.d)) ^ 2 := by
          rw [h00, h11, h01r, h01i]
      _ = _ := by ring
  have hdet : H.a * H.d - (H.b ^ 2 + H.c ^ 2) =
      K.a * K.d - (K.b ^ 2 + K.c ^ 2) :=
    (sq_eq_sq₀ (sub_nonneg.mpr hH.2.2) (sub_nonneg.mpr hK.2.2)).mp hdet2
  have ht2 : (H.a + H.d) ^ 2 = (K.a + K.d) ^ 2 := by
    calc
      _ = (H.a ^ 2 + H.b ^ 2 + H.c ^ 2) +
          (H.d ^ 2 + H.b ^ 2 + H.c ^ 2) +
          2 * (H.a * H.d - (H.b ^ 2 + H.c ^ 2)) := by ring
      _ = (K.a ^ 2 + K.b ^ 2 + K.c ^ 2) +
          (K.d ^ 2 + K.b ^ 2 + K.c ^ 2) +
          2 * (K.a * K.d - (K.b ^ 2 + K.c ^ 2)) := by rw [h00, h11, hdet]
      _ = _ := by ring
  have ht : H.a + H.d = K.a + K.d :=
    (sq_eq_sq₀ (add_nonneg hH.1 hH.2.1) (add_nonneg hK.1 hK.2.1)).mp ht2
  have hb : H.b = K.b := by
    by_cases hz : K.a + K.d = 0
    · have hzH : H.a + H.d = 0 := ht.trans hz
      have hbH : H.b = 0 := by
        have haH : H.a = 0 := by linarith only [hH.1, hH.2.1, hzH]
        have hdH : H.d = 0 := by linarith only [hH.1, hH.2.1, hzH]
        have hp := hH.2.2
        rw [haH, hdH] at hp
        nlinarith only [hp, sq_nonneg H.c, sq_nonneg H.b]
      have hbK : K.b = 0 := by
        have haK : K.a = 0 := by linarith only [hK.1, hK.2.1, hz]
        have hdK : K.d = 0 := by linarith only [hK.1, hK.2.1, hz]
        have hp := hK.2.2
        rw [haK, hdK] at hp
        nlinarith only [hp, sq_nonneg K.c, sq_nonneg K.b]
      exact hbH.trans hbK.symm
    · apply mul_right_cancel₀ hz
      simpa only [ht] using h01r
  have hc : H.c = K.c := by
    by_cases hz : K.a + K.d = 0
    · have hzH : H.a + H.d = 0 := ht.trans hz
      have hcH : H.c = 0 := by
        have haH : H.a = 0 := by linarith only [hH.1, hH.2.1, hzH]
        have hdH : H.d = 0 := by linarith only [hH.1, hH.2.1, hzH]
        have hp := hH.2.2
        rw [haH, hdH] at hp
        nlinarith only [hp, sq_nonneg H.b, sq_nonneg H.c]
      have hcK : K.c = 0 := by
        have haK : K.a = 0 := by linarith only [hK.1, hK.2.1, hz]
        have hdK : K.d = 0 := by linarith only [hK.1, hK.2.1, hz]
        have hp := hK.2.2
        rw [haK, hdK] at hp
        nlinarith only [hp, sq_nonneg K.b, sq_nonneg K.c]
      exact hcH.trans hcK.symm
    · apply mul_right_cancel₀ hz
      simpa only [ht] using h01i
  have ha : H.a = K.a := by
    have heq : H.a ^ 2 = K.a ^ 2 := by simpa [hb, hc] using h00
    exact (sq_eq_sq₀ hH.1 hK.1).mp heq
  have hd : H.d = K.d := by linarith only [ht, ha]
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Herm2.matrix, ha, hb, hc, hd]

theorem positive_roots_unique {R S : M2} (hR : IsPositive R) (hS : IsPositive S)
    (hsq : R * R = S * S) : R = S := by
  have hr := coordinates_matrix R hR.1
  have hs := coordinates_matrix S hS.1
  have hpr : (coordinates R).Positive := by
    apply (coordinates R).positive_iff_matrix.mpr
    simpa [hr] using hR
  have hps : (coordinates S).Positive := by
    apply (coordinates S).positive_iff_matrix.mpr
    simpa [hs] using hS
  have h := roots_unique (coordinates R) (coordinates S) hpr hps
    (by simpa [hr, hs] using hsq)
  simpa [hr, hs] using h



theorem Herm2.trace_mul_nonneg (H J : Herm2) (hH : H.Positive) (hJ : J.Positive) :
    0 ≤ (Matrix.trace (H.matrix * J.matrix)).re := by
  rw [Herm2.trace_mul, Complex.ofReal_re]
  have hq : (H.b * J.b + H.c * J.c) ^ 2 ≤
      (H.b ^ 2 + H.c ^ 2) * (J.b ^ 2 + J.c ^ 2) := by
    nlinarith only [sq_nonneg (H.b * J.c - H.c * J.b)]
  have hp : (H.b ^ 2 + H.c ^ 2) * (J.b ^ 2 + J.c ^ 2) ≤
      (H.a * H.d) * (J.a * J.d) :=
    mul_le_mul hH.2.2 hJ.2.2 (add_nonneg (sq_nonneg J.b) (sq_nonneg J.c))
      (mul_nonneg hH.1 hH.2.1)
  have ht0 : 0 ≤ H.a * J.a + H.d * J.d :=
    add_nonneg (mul_nonneg hH.1 hJ.1) (mul_nonneg hH.2.1 hJ.2.1)
  have hsq : (2 * (H.b * J.b + H.c * J.c)) ^ 2 ≤ (H.a * J.a + H.d * J.d) ^ 2 := by
    nlinarith only [hq, hp, sq_nonneg (H.a * J.a - H.d * J.d)]
  have habs : |2 * (H.b * J.b + H.c * J.c)| ≤ H.a * J.a + H.d * J.d :=
    (sq_le_sq₀ (abs_nonneg _) ht0).mp (by simpa only [sq_abs] using hsq)
  have hlo := (abs_le.mp habs).1
  nlinarith only [hlo]

theorem trace_mul_nonneg {M N : M2} (hM : IsPositive M) (hN : IsPositive N) :
    0 ≤ (Matrix.trace (M * N)).re := by
  have hm := coordinates_matrix M hM.1
  have hn := coordinates_matrix N hN.1
  have hpM : (coordinates M).Positive :=
    (coordinates M).positive_iff_matrix.mpr (by simpa only [hm] using hM)
  have hpN : (coordinates N).Positive :=
    (coordinates N).positive_iff_matrix.mpr (by simpa only [hn] using hN)
  simpa only [hm, hn] using (coordinates M).trace_mul_nonneg (coordinates N) hpM hpN

theorem matrixQuad_conj_sandwich (E K : M2) (z w : ℂ) :
    matrixQuad (K.conjTranspose * E * K) z w =
      matrixQuad E (K 0 0 * z + K 0 1 * w) (K 1 0 * z + K 1 1 * w) := by
  unfold matrixQuad
  congr 1
  simp [Matrix.mul_apply, Fin.sum_univ_succ, Matrix.conjTranspose_apply, Complex.star_def]
  ring

theorem positive_conj_sandwich {E : M2} (hE : IsPositive E) (K : M2) :
    IsPositive (K.conjTranspose * E * K) := by
  refine ⟨?_, ?_⟩
  · simp [Matrix.conjTranspose_mul, hE.1, Matrix.mul_assoc]
  · intro z w
    rw [matrixQuad_conj_sandwich]
    exact hE.2 _ _

theorem positive_sandwich {E K : M2} (hE : IsPositive E) (hK : K.conjTranspose = K) :
    IsPositive (K * E * K) := by
  simpa only [hK] using positive_conj_sandwich hE K

theorem sequential_probability_nonneg {rho E K : M2}
    (hrho : IsDensity rho) (hE : IsPositive E) (hK : K.conjTranspose = K) :
    0 ≤ (Matrix.trace (rho * (K * E * K))).re :=
  trace_mul_nonneg hrho.1 (positive_sandwich hE hK)


theorem trace_mul_im_zero {M N : M2}
    (hM : M.conjTranspose = M) (hN : N.conjTranspose = N) :
    (Matrix.trace (M * N)).im = 0 := by
  have hm := coordinates_matrix M hM
  have hn := coordinates_matrix N hN
  rw [← hm, ← hn, Herm2.trace_mul, Complex.ofReal_im]

theorem positive_trace_mul_im_zero {M N : M2}
    (hM : IsPositive M) (hN : IsPositive N) :
    (Matrix.trace (M * N)).im = 0 :=
  trace_mul_im_zero hM.1 hN.1

end Lueders
