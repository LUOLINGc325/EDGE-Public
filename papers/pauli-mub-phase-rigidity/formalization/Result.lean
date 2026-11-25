import Lean
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.NoncommRing
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Data.Matrix.ConjTranspose
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.FinCases
import Mathlib.Algebra.Ring.Commute
import Mathlib.Data.Rat.Lemmas
import Mathlib.Tactic.Linarith
import Mathlib.Data.Int.ModEq
import Mathlib.Tactic.FieldSimp
import Mathlib.Logic.Equiv.Fin.Basic

noncomputable section

/-! ## TraceAlgebra -/
set_option autoImplicit false

namespace PauliMUBTrace

open Matrix

noncomputable def IsGaussian (z : ℂ) : Prop :=
  ∃ a b : ℤ, z = (a : ℂ) + (b : ℂ) * Complex.I

noncomputable def GaussianMatrix {ι κ : Type*} (A : Matrix ι κ ℂ) : Prop :=
  ∀ i j, IsGaussian (A i j)

theorem gaussian_zero : IsGaussian (0 : ℂ) := by
  exact ⟨0, 0, by simp⟩

theorem gaussian_one : IsGaussian (1 : ℂ) := by
  exact ⟨1, 0, by simp⟩

theorem gaussian_intCast (a : ℤ) : IsGaussian (a : ℂ) := by
  exact ⟨a, 0, by simp⟩

theorem gaussian_I : IsGaussian Complex.I := by
  exact ⟨0, 1, by simp⟩

theorem gaussian_add {z w : ℂ} (hz : IsGaussian z) (hw : IsGaussian w) :
    IsGaussian (z + w) := by
  obtain ⟨a, b, rfl⟩ := hz
  obtain ⟨c, d, rfl⟩ := hw
  refine ⟨a + c, b + d, ?_⟩
  push_cast
  ring

theorem gaussian_neg {z : ℂ} (hz : IsGaussian z) : IsGaussian (-z) := by
  obtain ⟨a, b, rfl⟩ := hz
  refine ⟨-a, -b, ?_⟩
  push_cast
  ring

theorem gaussian_sub {z w : ℂ} (hz : IsGaussian z) (hw : IsGaussian w) :
    IsGaussian (z - w) := by
  simpa only [sub_eq_add_neg] using gaussian_add hz (gaussian_neg hw)

theorem gaussian_mul {z w : ℂ} (hz : IsGaussian z) (hw : IsGaussian w) :
    IsGaussian (z * w) := by
  obtain ⟨a, b, rfl⟩ := hz
  obtain ⟨c, d, rfl⟩ := hw
  refine ⟨a * c - b * d, a * d + b * c, ?_⟩
  push_cast
  calc
    _ = (a : ℂ) * c + ((a : ℂ) * d + b * c) * Complex.I +
      (b : ℂ) * d * Complex.I ^ 2 := by ring
    _ = _ := by rw [Complex.I_sq]; ring

theorem gaussian_sum {α : Type*} (s : Finset α) (f : α → ℂ)
    (h : ∀ a ∈ s, IsGaussian (f a)) : IsGaussian (∑ a ∈ s, f a) := by
  classical
  induction s using Finset.induction_on with
  | empty => simpa using gaussian_zero
  | @insert a s ha ih =>
    rw [Finset.sum_insert ha]
    exact gaussian_add (h a (by simp)) (ih (fun b hb => h b (by simp [hb])))

theorem gaussian_re {z : ℂ} (hz : IsGaussian z) : ∃ a : ℤ, z.re = (a : ℝ) := by
  obtain ⟨a, b, rfl⟩ := hz
  exact ⟨a, by simp⟩

theorem gaussian_im {z : ℂ} (hz : IsGaussian z) : ∃ b : ℤ, z.im = (b : ℝ) := by
  obtain ⟨a, b, rfl⟩ := hz
  exact ⟨b, by simp⟩

theorem gaussian_prod {α : Type*} (s : Finset α) (f : α → ℂ)
    (h : ∀ a ∈ s, IsGaussian (f a)) : IsGaussian (∏ a ∈ s, f a) := by
  classical
  induction s using Finset.induction_on with
  | empty => simpa using gaussian_one
  | @insert a s ha ih =>
    rw [Finset.prod_insert ha]
    exact gaussian_mul (h a (by simp)) (ih (fun b hb => h b (by simp [hb])))

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

omit [DecidableEq ι] in
theorem gaussianMatrix_mul {A B : Matrix ι ι ℂ} (hA : GaussianMatrix A)
    (hB : GaussianMatrix B) : GaussianMatrix (A * B) := by
  intro i j
  exact gaussian_sum Finset.univ (fun l => A i l * B l j)
    (fun l _ => gaussian_mul (hA i l) (hB l j))

omit [DecidableEq ι] in
theorem gaussianMatrix_trace {A : Matrix ι ι ℂ} (hA : GaussianMatrix A) :
    IsGaussian (Matrix.trace A) := by
  exact gaussian_sum Finset.univ (fun i => A i i) (fun i _ => hA i i)

theorem gaussianMatrix_cube_trace {A : Matrix ι ι ℂ} (hA : GaussianMatrix A) :
    IsGaussian (Matrix.trace (A ^ 3)) := by
  have hid : A ^ 3 = (A * A) * A := by noncomm_ring
  rw [hid]
  exact gaussianMatrix_trace (gaussianMatrix_mul (gaussianMatrix_mul hA hA) hA)

theorem idempotent_cube (rho : Matrix ι ι ℂ) (h : rho * rho = rho) :
    rho ^ 3 = rho := by
  calc
    rho ^ 3 = (rho * rho) * rho := by noncomm_ring
    _ = rho := by rw [h, h]

theorem shifted_cube (A : Matrix ι ι ℂ) :
    (A - 1) ^ 3 = A ^ 3 - (3 : ℂ) • (A ^ 2) + (3 : ℂ) • A - 1 := by
  simp only [show (3 : ℂ) = 1 + 1 + 1 by norm_num, add_smul, one_smul]
  noncomm_ring

theorem scaled_idempotent_cube (rho : Matrix ι ι ℂ) (h : rho * rho = rho)
    (d : ℂ) :
    (d • rho - 1) ^ 3 = (d ^ 3 - 3 * d ^ 2 + 3 * d) • rho - 1 := by
  rw [shifted_cube]
  simp only [smul_pow, idempotent_cube rho h, pow_two, smul_mul_assoc,
    mul_smul_comm, h, smul_smul]
  rw [← sub_smul, ← add_smul]

theorem trace_scaled_idempotent_cube (rho : Matrix ι ι ℂ)
    (h : rho * rho = rho) (ht : Matrix.trace rho = 1) :
    Matrix.trace (((Fintype.card ι : ℂ) • rho - 1) ^ 3) =
      (Fintype.card ι : ℂ) * ((Fintype.card ι : ℂ) - 1) *
        ((Fintype.card ι : ℂ) - 2) := by
  rw [scaled_idempotent_cube rho h, Matrix.trace_sub, Matrix.trace_smul, ht,
    Matrix.trace_one]
  simp only [smul_eq_mul, mul_one]
  ring

theorem trace_cubic_obstruction_identity (rho : Matrix ι ι ℂ)
    (h : rho * rho = rho) (ht : Matrix.trace rho = 1)
    (t : ℂ) (htsq : t ^ 2 = (Fintype.card ι : ℂ)) :
    Matrix.trace ((t • ((Fintype.card ι : ℂ) • rho - 1)) ^ 3) =
      (Fintype.card ι : ℂ) ^ 2 * ((Fintype.card ι : ℂ) - 1) *
        ((Fintype.card ι : ℂ) - 2) * t := by
  rw [smul_pow, Matrix.trace_smul, trace_scaled_idempotent_cube rho h ht]
  simp only [smul_eq_mul]
  calc
    t ^ 3 * ((Fintype.card ι : ℂ) * ((Fintype.card ι : ℂ) - 1) *
        ((Fintype.card ι : ℂ) - 2)) =
      t ^ 2 * (Fintype.card ι : ℂ) * ((Fintype.card ι : ℂ) - 1) *
        ((Fintype.card ι : ℂ) - 2) * t := by ring
    _ = _ := by rw [htsq]; ring

end PauliMUBTrace

/-! ## Pauli -/
/-! Actual tensor products of the four Hermitian one-qubit Pauli matrices.
    The reconstruction formula is proved entrywise from a finite tensor
    kernel identity, without assuming a matrix-basis axiom. -/

set_option autoImplicit false

open scoped BigOperators Matrix ComplexConjugate

namespace PauliMUB

abbrev Qubit (n : ℕ) := Fin n → Fin 2
abbrev Label (n : ℕ) := Fin n → Fin 4

noncomputable def single (a : Fin 4) (i j : Fin 2) : ℂ :=
  if a.val = 0 then if i = j then 1 else 0
  else if a.val = 1 then if i = j then 0 else 1
  else if a.val = 2 then if i = j then 0 else if i = 0 then -Complex.I else Complex.I
  else if i = j then if i = 0 then 1 else -1 else 0

noncomputable def P {n : ℕ} (s : Label n) : Matrix (Qubit n) (Qubit n) ℂ :=
  fun x y => ∏ k, single (s k) (x k) (y k)

theorem cardQubit (n : ℕ) : Fintype.card (Qubit n) = 2 ^ n := by
  simp [Qubit]

theorem cardLabel (n : ℕ) : Fintype.card (Label n) = 4 ^ n := by
  simp [Label]

theorem single_conj (a : Fin 4) (i j : Fin 2) :
    conj (single a j i) = single a i j := by
  fin_cases a <;> fin_cases i <;> fin_cases j <;> norm_num [single]

theorem single_kernel (i j u v : Fin 2) :
    (∑ a : Fin 4, single a i j * single a u v) =
      if i = v ∧ j = u then 2 else 0 := by
  fin_cases i <;> fin_cases j <;> fin_cases u <;> fin_cases v <;>
    norm_num [Fin.sum_univ_succ, single, Complex.I_mul_I]

theorem P_zero {n : ℕ} : P (0 : Label n) = 1 := by
  classical
  ext x y
  by_cases h : x = y
  · subst y
    simp [P, single]
  · obtain ⟨k, hk⟩ : ∃ k, x k ≠ y k := by
      by_contra hh
      apply h
      funext k
      exact not_not.mp (not_exists.mp hh k)
    rw [Matrix.one_apply_ne h]
    exact Finset.prod_eq_zero (Finset.mem_univ k) (by simp [single, hk])

theorem P_hermitian {n : ℕ} (s : Label n) : (P s)ᴴ = P s := by
  ext x y
  simp only [Matrix.conjTranspose_apply, P, Complex.star_def, map_prod]
  apply Finset.prod_congr rfl
  intro k hk
  exact single_conj (s k) (x k) (y k)

theorem P_kernel {n : ℕ} (x y u v : Qubit n) :
    (∑ s : Label n, P s x y * P s u v) =
      if x = v ∧ y = u then (2 : ℂ) ^ n else 0 := by
  classical
  calc
    (∑ s : Label n, P s x y * P s u v) =
        ∏ k : Fin n, ∑ a : Fin 4, single a (x k) (y k) * single a (u k) (v k) := by
      rw [Fintype.prod_sum]
      apply Finset.sum_congr rfl
      intro s hs
      exact (Finset.prod_mul_distrib).symm
    _ = ∏ k : Fin n, if x k = v k ∧ y k = u k then (2 : ℂ) else 0 := by
      simp only [single_kernel]
    _ = if x = v ∧ y = u then (2 : ℂ) ^ n else 0 := by
      by_cases h : x = v ∧ y = u
      · simp [h, h.1, h.2]
      · rw [if_neg h]
        obtain ⟨k, hk⟩ : ∃ k, ¬ (x k = v k ∧ y k = u k) := by
          by_contra hh
          apply h
          have he : ∀ k, x k = v k ∧ y k = u k := by simpa using hh
          exact ⟨funext (fun k => (he k).1), funext (fun k => (he k).2)⟩
        exact Finset.prod_eq_zero (Finset.mem_univ k) (if_neg hk)

theorem reconstruction {n : ℕ} (A : Matrix (Qubit n) (Qubit n) ℂ) :
    ((2 ^ n : ℕ) : ℂ) • A = ∑ s : Label n, Matrix.trace (A * P s) • P s := by
  classical
  ext i j
  simp only [Matrix.smul_apply, Matrix.sum_apply, smul_eq_mul,
    Matrix.trace, Matrix.diag_apply, Matrix.mul_apply]
  symm
  calc
    (∑ s : Label n, (∑ x : Qubit n, ∑ y : Qubit n, A x y * P s y x) * P s i j) =
        ∑ x : Qubit n, ∑ y : Qubit n, A x y * (∑ s : Label n, P s y x * P s i j) := by
      simp only [Finset.sum_mul, Finset.mul_sum]
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro x hx
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro y hy
      apply Finset.sum_congr rfl
      intro s hs
      ring
    _ = ∑ x : Qubit n, ∑ y : Qubit n,
        A x y * (if y = j ∧ x = i then (2 : ℂ) ^ n else 0) := by
      simp only [P_kernel]
    _ = ((2 ^ n : ℕ) : ℂ) * A i j := by
      simp only [mul_ite, mul_zero]
      simp [and_comm, ite_and, Finset.sum_ite_irrel, mul_comm]

theorem reconstruction_erase {n : ℕ} (A : Matrix (Qubit n) (Qubit n) ℂ)
    (ht : Matrix.trace A = 1) :
    ((2 ^ n : ℕ) : ℂ) • A - 1 =
      ∑ s ∈ Finset.univ.erase (0 : Label n), Matrix.trace (A * P s) • P s := by
  classical
  have h := Finset.sum_erase_add (s := Finset.univ)
    (f := fun s : Label n => Matrix.trace (A * P s) • P s) (Finset.mem_univ 0)
  rw [← reconstruction A] at h
  simp only [P_zero, mul_one, ht, one_smul] at h
  exact (eq_sub_iff_add_eq.mpr h).symm

theorem single_mem (a : Fin 4) (i j : Fin 2) :
    single a i j = 0 ∨ single a i j = 1 ∨ single a i j = -1 ∨
      single a i j = Complex.I ∨ single a i j = -Complex.I := by
  fin_cases a <;> fin_cases i <;> fin_cases j <;> norm_num [single]

theorem single_gaussian (a : Fin 4) (i j : Fin 2) :
    PauliMUBTrace.IsGaussian (single a i j) := by
  rcases single_mem a i j with h | h | h | h | h
  · rw [h]; exact PauliMUBTrace.gaussian_zero
  · rw [h]; exact PauliMUBTrace.gaussian_one
  · rw [h]; exact PauliMUBTrace.gaussian_neg PauliMUBTrace.gaussian_one
  · rw [h]; exact PauliMUBTrace.gaussian_I
  · rw [h]; exact PauliMUBTrace.gaussian_neg PauliMUBTrace.gaussian_I

theorem P_gaussian {n : ℕ} (s : Label n) : PauliMUBTrace.GaussianMatrix (P s) := by
  intro x y
  exact PauliMUBTrace.gaussian_prod Finset.univ
    (fun k => single (s k) (x k) (y k)) (fun k _ => single_gaussian (s k) (x k) (y k))

theorem single_mul_self (a : Fin 4) (i j : Fin 2) :
    (∑ k : Fin 2, single a i k * single a k j) = if i = j then 1 else 0 := by
  fin_cases a <;> fin_cases i <;> fin_cases j <;>
    norm_num [Fin.sum_univ_succ, single, Complex.I_mul_I]

theorem P_mul_self {n : ℕ} (s : Label n) : P s * P s = 1 := by
  classical
  ext x y
  simp only [Matrix.mul_apply, Matrix.one_apply]
  calc
    (∑ z : Qubit n, P s x z * P s z y) =
        ∏ k : Fin n, ∑ b : Fin 2, single (s k) (x k) b * single (s k) b (y k) := by
      rw [Fintype.prod_sum]
      apply Finset.sum_congr rfl
      intro z hz
      exact (Finset.prod_mul_distrib).symm
    _ = ∏ k : Fin n, if x k = y k then (1 : ℂ) else 0 := by
      simp only [single_mul_self]
    _ = if x = y then 1 else 0 := by
      by_cases h : x = y
      · simp [h]
      · rw [if_neg h]
        obtain ⟨k, hk⟩ : ∃ k, x k ≠ y k := by
          by_contra hh
          apply h
          funext k
          exact not_not.mp (not_exists.mp hh k)
        exact Finset.prod_eq_zero (Finset.mem_univ k) (if_neg hk)

end PauliMUB

/-! ## PureStateBridge -/
/-! Generic finite-dimensional bridge from a MUB orbit to its pure-state
    density matrix.  No structural premise about the Pauli family is built
    into this file. -/

set_option autoImplicit false

open scoped BigOperators Matrix ComplexConjugate

namespace PauliMUB

variable {ι : Type*} [Fintype ι]

noncomputable def overlap (v w : ι → ℂ) : ℂ := ∑ i, conj (v i) * w i

noncomputable def projector (v : ι → ℂ) : Matrix ι ι ℂ := fun i j => v i * conj (v j)

theorem overlap_smul (v w : ι → ℂ) (a b : ℂ) :
    overlap (a • v) (b • w) = conj a * b * overlap v w := by
  simp only [overlap, Pi.smul_apply, smul_eq_mul, map_mul, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i hi
  ring

theorem normSq_overlap_smul (v w : ι → ℂ) (a b : ℂ)
    (ha : Complex.normSq a = 1) (hb : Complex.normSq b = 1) :
    Complex.normSq (overlap (a • v) (b • w)) = Complex.normSq (overlap v w) := by
  rw [overlap_smul]
  simp only [Complex.normSq_mul, Complex.normSq_conj, ha, hb, one_mul]

theorem overlap_mulVec (A : Matrix ι ι ℂ) (v w : ι → ℂ) :
    overlap (A *ᵥ v) (A *ᵥ w) = overlap v ((Aᴴ * A) *ᵥ w) := by
  change dotProduct (star (A *ᵥ v)) (A *ᵥ w) =
    dotProduct (star v) ((Aᴴ * A) *ᵥ w)
  rw [Matrix.star_mulVec, ← Matrix.dotProduct_mulVec, Matrix.mulVec_mulVec]

theorem projector_trace (v : ι → ℂ) :
    Matrix.trace (projector v) = overlap v v := by
  simp only [Matrix.trace, Matrix.diag_apply, projector, overlap]
  apply Finset.sum_congr rfl
  intro i hi
  exact mul_comm _ _

theorem projector_idempotent (v : ι → ℂ) (hv : overlap v v = 1) :
    projector v * projector v = projector v := by
  ext i j
  simp only [Matrix.mul_apply, projector]
  calc
    (∑ k, v i * conj (v k) * (v k * conj (v j))) =
        v i * (∑ k, conj (v k) * v k) * conj (v j) := by
      rw [Finset.mul_sum, Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro k hk
      ring
    _ = v i * conj (v j) := by rw [show (∑ k, conj (v k) * v k) = 1 from hv]; simp

omit [Fintype ι] in
theorem projector_conjTranspose (v : ι → ℂ) :
    (projector v)ᴴ = projector v := by
  ext i j
  simp [projector, Matrix.conjTranspose_apply, mul_comm]

theorem trace_projector_mul (v : ι → ℂ) (A : Matrix ι ι ℂ) :
    Matrix.trace (projector v * A) = overlap v (A *ᵥ v) := by
  simp only [Matrix.trace, Matrix.diag_apply, Matrix.mul_apply,
    projector, overlap, Matrix.mulVec, dotProduct]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j hj
  ring

theorem trace_projector_mul_conj (v : ι → ℂ) (A : Matrix ι ι ℂ)
    (hA : Aᴴ = A) :
    conj (Matrix.trace (projector v * A)) = Matrix.trace (projector v * A) := by
  change star (Matrix.trace (projector v * A)) = Matrix.trace (projector v * A)
  rw [← Matrix.trace_conjTranspose, Matrix.conjTranspose_mul, hA,
    projector_conjTranspose, Matrix.trace_mul_comm]

theorem normSq_trace_projector_mul (v : ι → ℂ) (A : Matrix ι ι ℂ)
    (hA : Aᴴ = A) :
    ((Complex.normSq (Matrix.trace (projector v * A))) : ℂ) =
      (Matrix.trace (projector v * A)) ^ 2 := by
  rw [Complex.normSq_eq_conj_mul_self, trace_projector_mul_conj v A hA, pow_two]

variable {L : Type*}

/-- An actual partition of the labelled orbit into `card ι` mutually
    unbiased orthonormal bases, each containing `card ι` vectors.  The
    equivalence records both the basis number and the vector number.
    The original orbit vectors themselves are used as representatives;
    their arbitrary scalar phases have no effect on the condition. -/
structure OrbitMUB (U : L → Matrix ι ι ℂ) (v : ι → ℂ) where
  enumerate : L ≃ ι × ι
  normalized : ∀ b i,
    overlap (U (enumerate.symm (b, i)) *ᵥ v)
      (U (enumerate.symm (b, i)) *ᵥ v) = 1
  orthogonal : ∀ b i j, i ≠ j →
    overlap (U (enumerate.symm (b, i)) *ᵥ v)
      (U (enumerate.symm (b, j)) *ᵥ v) = 0
  unbiased : ∀ b c, b ≠ c → ∀ i j,
    Complex.normSq (overlap (U (enumerate.symm (b, i)) *ᵥ v)
      (U (enumerate.symm (c, j)) *ᵥ v)) = 1 / (Fintype.card ι : ℝ)

/-- Independent changes of phase of all orbit representatives preserve
    the MUB partition.  This makes the definition invariant on rays. -/
noncomputable def OrbitMUB.rephase {U : L → Matrix ι ι ℂ} {v : ι → ℂ}
    (h : OrbitMUB U v) (phase : L → ℂ)
    (hphase : ∀ a, Complex.normSq (phase a) = 1) :
    OrbitMUB (fun a => phase a • U a) v where
  enumerate := h.enumerate
  normalized b i := by
    rw [Matrix.smul_mulVec_assoc, overlap_smul, h.normalized, mul_one,
      ← Complex.normSq_eq_conj_mul_self, hphase]
    rfl
  orthogonal b i j hij := by
    rw [Matrix.smul_mulVec_assoc, Matrix.smul_mulVec_assoc, overlap_smul,
      h.orthogonal b i j hij, mul_zero]
  unbiased b c hbc i j := by
    rw [Matrix.smul_mulVec_assoc, Matrix.smul_mulVec_assoc,
      normSq_overlap_smul _ _ _ _ (hphase _) (hphase _)]
    exact h.unbiased b c hbc i j

theorem orbitMUB_rephase_iff {U : L → Matrix ι ι ℂ} {v : ι → ℂ}
    (phase : L → ℂ) (hphase : ∀ a, Complex.normSq (phase a) = 1) :
    Nonempty (OrbitMUB (fun a => phase a • U a) v) ↔
      Nonempty (OrbitMUB U v) := by
  constructor
  · rintro ⟨h⟩
    have hc : ∀ a, Complex.normSq (conj (phase a)) = 1 := by
      intro a
      rw [Complex.normSq_conj, hphase]
    have hback := h.rephase (fun a => conj (phase a)) hc
    have hcancel : (fun a => conj (phase a) • (phase a • U a)) = U := by
      funext a
      rw [smul_smul, ← Complex.normSq_eq_conj_mul_self, hphase]
      simp
    rw [hcancel] at hback
    exact ⟨hback⟩
  · rintro ⟨h⟩
    exact ⟨h.rephase phase hphase⟩

theorem OrbitMUB.orbit_normalized {U : L → Matrix ι ι ℂ} {v : ι → ℂ}
    (h : OrbitMUB U v) (a : L) : overlap (U a *ᵥ v) (U a *ᵥ v) = 1 := by
  simpa using h.normalized (h.enumerate a).1 (h.enumerate a).2

theorem OrbitMUB.pair_normSq {U : L → Matrix ι ι ℂ} {v : ι → ℂ}
    (h : OrbitMUB U v) {a b : L} (hab : a ≠ b) :
    Complex.normSq (overlap (U a *ᵥ v) (U b *ᵥ v)) = 0 ∨
      Complex.normSq (overlap (U a *ᵥ v) (U b *ᵥ v)) =
        1 / (Fintype.card ι : ℝ) := by
  by_cases hrow : (h.enumerate a).1 = (h.enumerate b).1
  · left
    have hcol : (h.enumerate a).2 ≠ (h.enumerate b).2 := by
      intro hcol
      exact hab (h.enumerate.injective (Prod.ext hrow hcol))
    have ho := h.orthogonal (h.enumerate a).1
      (h.enumerate a).2 (h.enumerate b).2 hcol
    have hb : h.enumerate.symm ((h.enumerate a).1, (h.enumerate b).2) = b := by
      rw [hrow]
      simp
    simp only [Prod.mk.eta, Equiv.symm_apply_apply, hb] at ho
    rw [ho]
    exact Complex.normSq_zero
  · right
    simpa using h.unbiased (h.enumerate a).1 (h.enumerate b).1 hrow
      (h.enumerate a).2 (h.enumerate b).2

variable [DecidableEq ι]

theorem OrbitMUB.unit_fiducial {U : L → Matrix ι ι ℂ} {v : ι → ℂ}
    (h : OrbitMUB U v) (e : L) (he : U e = 1) : overlap v v = 1 := by
  simpa only [he, Matrix.one_mulVec] using h.orbit_normalized e

theorem OrbitMUB.sparse_projector_spectrum {U : L → Matrix ι ι ℂ} {v : ι → ℂ}
    (h : OrbitMUB U v) (e : L) (he : U e = 1)
    (hHermitian : ∀ a, (U a)ᴴ = U a) :
    ∀ a, a ≠ e → (Matrix.trace (projector v * U a)) ^ 2 = 0 ∨
      (Matrix.trace (projector v * U a)) ^ 2 = 1 / (Fintype.card ι : ℂ) := by
  intro a ha
  have hp := h.pair_normSq (Ne.symm ha)
  rw [he, Matrix.one_mulVec, ← trace_projector_mul] at hp
  have heq := normSq_trace_projector_mul v (U a) (hHermitian a)
  rcases hp with hp | hp
  · left
    rw [← heq, hp]
    rfl
  · right
    rw [← heq, hp]
    simp

theorem OrbitMUB.projector_certificate {U : L → Matrix ι ι ℂ} {v : ι → ℂ}
    (h : OrbitMUB U v) (e : L) (he : U e = 1)
    (hHermitian : ∀ a, (U a)ᴴ = U a) :
    projector v * projector v = projector v ∧
    Matrix.trace (projector v) = 1 ∧
    (∀ a, a ≠ e → (Matrix.trace (projector v * U a)) ^ 2 = 0 ∨
      (Matrix.trace (projector v * U a)) ^ 2 = 1 / (Fintype.card ι : ℂ)) := by
  refine ⟨projector_idempotent v (h.unit_fiducial e he), ?_,
    h.sparse_projector_spectrum e he hHermitian⟩
  exact (projector_trace v).trans (h.unit_fiducial e he)

end PauliMUB

/-! ## PauliOrbit -/
set_option autoImplicit false

open scoped Matrix

namespace PauliMUB

/-- The physical condition: the actual tensor-Pauli orbit is partitioned
    into `2^n` mutually unbiased orthonormal bases of size `2^n`. -/
abbrev PauliOrbitMUB {n : ℕ} (v : Qubit n → ℂ) := OrbitMUB P v

theorem pauli_preserves_overlap {n : ℕ} (s : Label n) (v w : Qubit n → ℂ) :
    overlap (P s *ᵥ v) (P s *ᵥ w) = overlap v w := by
  rw [overlap_mulVec, P_hermitian, P_mul_self, Matrix.one_mulVec]

theorem pauli_preserves_normalization {n : ℕ} (s : Label n) (v : Qubit n → ℂ)
    (hv : overlap v v = 1) : overlap (P s *ᵥ v) (P s *ᵥ v) = 1 := by
  rw [pauli_preserves_overlap, hv]

theorem pauli_orbit_projector_certificate {n : ℕ} {v : Qubit n → ℂ}
    (h : PauliOrbitMUB v) :
    projector v * projector v = projector v ∧
    Matrix.trace (projector v) = 1 ∧
    (∀ s : Label n, s ≠ 0 →
      (Matrix.trace (projector v * P s)) ^ 2 = 0 ∨
      (Matrix.trace (projector v * P s)) ^ 2 = 1 / ((2 ^ n : ℕ) : ℂ)) := by
  simpa only [cardQubit] using
    h.projector_certificate (0 : Label n) P_zero P_hermitian

theorem pauli_orbit_normalized {n : ℕ} {v : Qubit n → ℂ}
    (h : PauliOrbitMUB v) : overlap v v = 1 :=
  h.unit_fiducial (0 : Label n) P_zero

end PauliMUB

/-! ## PauliIntegrality -/
/-! The sparse-flat spectral hypothesis implies Gaussian integrality of
    the scaled traceless projector, using the actual Pauli reconstruction. -/

set_option autoImplicit false

open scoped BigOperators

namespace PauliMUB

open PauliMUBTrace

theorem gaussian_scaled_coefficient (d t r : ℂ)
    (htsq : t ^ 2 = d) (htne : t ≠ 0)
    (hr : r ^ 2 = 0 ∨ r ^ 2 = 1 / d) : IsGaussian (t * r) := by
  rcases hr with hr | hr
  · have hz : r = 0 := pow_eq_zero hr
    rw [hz, mul_zero]
    exact gaussian_zero
  · have hd : d ≠ 0 := by
      rw [← htsq]
      exact pow_ne_zero 2 htne
    have hsq : (t * r) ^ 2 = 1 := by
      rw [mul_pow, htsq, hr]
      simp [hd]
    rcases sq_eq_one_iff.mp hsq with h | h
    · rw [h]
      exact gaussian_one
    · rw [h]
      exact gaussian_neg gaussian_one

theorem pauli_spectrum_integrality {n : ℕ}
    (A : Matrix (Qubit n) (Qubit n) ℂ)
    (ht : Matrix.trace A = 1)
    (hspec : ∀ s : Label n, s ≠ 0 →
      (Matrix.trace (A * P s)) ^ 2 = 0 ∨
        (Matrix.trace (A * P s)) ^ 2 = 1 / ((2 ^ n : ℕ) : ℂ))
    (t : ℂ) (htsq : t ^ 2 = ((2 ^ n : ℕ) : ℂ)) (htne : t ≠ 0) :
    GaussianMatrix (t • (((2 ^ n : ℕ) : ℂ) • A - 1)) := by
  classical
  rw [reconstruction_erase A ht, Finset.smul_sum]
  intro i j
  simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul]
  apply gaussian_sum
  intro s hs
  rw [← mul_assoc]
  exact gaussian_mul
    (gaussian_scaled_coefficient ((2 ^ n : ℕ) : ℂ) t
      (Matrix.trace (A * P s)) htsq htne (hspec s (Finset.ne_of_mem_erase hs)))
    (P_gaussian s i j)

end PauliMUB

/-! ## NumberTheoryLite -/
/-! Elementary irrationality facts used by the cubic trace obstruction.
    `NotRational x` explicitly says that no rational number casts to `x`.
    This is the usual mathematical definition of irrationality.  The
    square-root argument uses only rational and natural square arithmetic. -/

set_option autoImplicit false

namespace PauliMUBTrace

noncomputable def NotRational (x : ℝ) : Prop := ∀ q : ℚ, (q : ℝ) ≠ x

theorem NotRational.ne_int {x : ℝ} (h : NotRational x) (z : ℤ) :
    x ≠ (z : ℝ) := by
  intro hz
  apply h (z : ℚ)
  simpa only [Rat.cast_intCast] using hz.symm

theorem NotRational.intCast_mul {x : ℝ} (h : NotRational x)
    {m : ℤ} (hm : m ≠ 0) : NotRational ((m : ℝ) * x) := by
  intro q hq
  have hmR : (m : ℝ) ≠ 0 := by exact_mod_cast hm
  apply h (q / (m : ℚ))
  push_cast
  apply (div_eq_iff hmR).2
  simpa only [mul_comm] using hq

theorem NotRational.natCast_mul {x : ℝ} (h : NotRational x)
    {m : ℕ} (hm : m ≠ 0) : NotRational ((m : ℝ) * x) := by
  have hmZ : (m : ℤ) ≠ 0 := by exact_mod_cast hm
  simpa only [Int.cast_natCast] using h.intCast_mul hmZ

theorem sqrt_two_not_rational : NotRational (Real.sqrt 2) := by
  intro q hq
  have hsq : q * q = (2 : ℚ) := by
    apply Rat.cast_injective (α := ℝ)
    simpa only [Rat.cast_mul, Rat.cast_ofNat, hq] using
      Real.mul_self_sqrt (by norm_num : (0 : ℝ) ≤ 2)
  have hsQ : IsSquare (2 : ℚ) := ⟨q, hsq.symm⟩
  have hsN : IsSquare (2 : ℕ) := Rat.isSquare_natCast_iff.mp hsQ
  obtain ⟨a, ha⟩ := hsN
  have ha0 : a ≠ 0 := by intro h; subst a; norm_num at ha
  have ha1 : a ≤ 1 := by nlinarith
  have hae : a = 1 := by omega
  subst a
  norm_num at ha

end PauliMUBTrace

/-! ## TraceObstruction -/
set_option autoImplicit false

namespace PauliMUBTrace

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem no_gaussian_scaled_idempotent (rho : Matrix ι ι ℂ)
    (hrho : rho * rho = rho) (htrace : Matrix.trace rho = 1)
    (t : ℝ) (hirr : NotRational t) (hsq : t ^ 2 = (Fintype.card ι : ℝ))
    (hdim : 2 < Fintype.card ι) :
    ¬ GaussianMatrix ((t : ℂ) • ((Fintype.card ι : ℂ) • rho - 1)) := by
  intro hG
  obtain ⟨a, ha⟩ := gaussian_re (gaussianMatrix_cube_trace hG)
  have hsqC : (t : ℂ) ^ 2 = (Fintype.card ι : ℂ) := by exact_mod_cast hsq
  rw [trace_cubic_obstruction_identity rho hrho htrace (t : ℂ) hsqC] at ha
  simp [pow_two] at ha
  let c : ℤ := (Fintype.card ι : ℤ) ^ 2 * ((Fintype.card ι : ℤ) - 1) *
    ((Fintype.card ι : ℤ) - 2)
  have hdimZ : (2 : ℤ) < (Fintype.card ι : ℤ) := by exact_mod_cast hdim
  have hc : c ≠ 0 := by
    apply mul_ne_zero
    · apply mul_ne_zero
      · exact pow_ne_zero _ (by omega)
      · omega
    · omega
  apply (hirr.intCast_mul hc).ne_int a
  simpa [c, pow_two] using ha

theorem sqrt_two_pow_odd (m : ℕ) :
    Real.sqrt ((2 : ℝ) ^ (2 * m + 1)) = (2 : ℝ) ^ m * Real.sqrt 2 := by
  rw [pow_succ, Nat.mul_comm 2 m, pow_mul,
    Real.sqrt_mul (sq_nonneg ((2 : ℝ) ^ m)),
    Real.sqrt_sq (pow_nonneg (by norm_num) m)]

theorem irrational_sqrt_two_pow_odd_index (m : ℕ) :
    NotRational (Real.sqrt (((2 : ℕ) ^ (2 * m + 1) : ℕ) : ℝ)) := by
  simp only [Nat.cast_pow, Nat.cast_ofNat]
  rw [sqrt_two_pow_odd]
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using
    sqrt_two_not_rational.natCast_mul (m := (2 : ℕ) ^ m) (pow_ne_zero _ (by decide))

theorem irrational_sqrt_two_pow {n : ℕ} (hn : Odd n) :
    NotRational (Real.sqrt (((2 : ℕ) ^ n : ℕ) : ℝ)) := by
  obtain ⟨m, rfl⟩ := hn
  exact irrational_sqrt_two_pow_odd_index m

theorem two_pow_gt_two {n : ℕ} (hn : 3 ≤ n) : 2 < (2 : ℕ) ^ n := by
  have hle : (2 : ℕ) ^ 3 ≤ 2 ^ n := pow_le_pow_right' (by norm_num) hn
  norm_num at hle ⊢
  omega

theorem no_gaussian_odd_qubit_scaled_idempotent {n : ℕ}
    (hn : Odd n) (hn3 : 3 ≤ n) (hcard : Fintype.card ι = (2 : ℕ) ^ n)
    (rho : Matrix ι ι ℂ) (hrho : rho * rho = rho) (htrace : Matrix.trace rho = 1) :
    ¬ GaussianMatrix ((Real.sqrt (((2 : ℕ) ^ n : ℕ) : ℝ) : ℂ) •
      ((((2 : ℕ) ^ n : ℕ) : ℂ) • rho - 1)) := by
  have hsq : Real.sqrt (((2 : ℕ) ^ n : ℕ) : ℝ) ^ 2 = (Fintype.card ι : ℝ) := by
    rw [Real.sq_sqrt (by positivity)]
    simp only [hcard, Nat.cast_pow, Nat.cast_ofNat]
  simpa only [hcard] using no_gaussian_scaled_idempotent rho hrho htrace
    (Real.sqrt (((2 : ℕ) ^ n : ℕ) : ℝ)) (irrational_sqrt_two_pow hn) hsq
    (by rw [hcard]; exact two_pow_gt_two hn3)

theorem no_gaussian_odd_qubit_scaled_idempotent_ge_five {n : ℕ}
    (hn : Odd n) (hn5 : 5 ≤ n) (hcard : Fintype.card ι = (2 : ℕ) ^ n)
    (rho : Matrix ι ι ℂ) (hrho : rho * rho = rho) (htrace : Matrix.trace rho = 1) :
    ¬ GaussianMatrix ((Real.sqrt (((2 : ℕ) ^ n : ℕ) : ℝ) : ℂ) •
      ((((2 : ℕ) ^ n : ℕ) : ℂ) • rho - 1)) :=
  no_gaussian_odd_qubit_scaled_idempotent hn (by omega) hcard rho hrho htrace

end PauliMUBTrace

/-! ## PhaseArithmetic -/
set_option autoImplicit false

namespace PauliMUBPhase

theorem fourth_power_eq_one_iff (z : ℂ) :
    z ^ 4 = 1 ↔ z = 1 ∨ z = -1 ∨ z = Complex.I ∨ z = -Complex.I := by
  constructor
  · intro h
    have hs : (z ^ 2) ^ 2 = 1 := by simpa only [← pow_mul] using h
    rcases sq_eq_one_iff.mp hs with hp | hn
    · rcases sq_eq_one_iff.mp hp with hp | hn
      · exact Or.inl hp
      · exact Or.inr (Or.inl hn)
    · have hi : z ^ 2 = Complex.I ^ 2 := by rw [Complex.I_sq]; exact hn
      rcases sq_eq_sq_iff_eq_or_eq_neg.mp hi with hp | hn
      · exact Or.inr (Or.inr (Or.inl hp))
      · exact Or.inr (Or.inr (Or.inr hn))
  · rintro (rfl | rfl | rfl | rfl) <;>
      norm_num [neg_pow, show Complex.I ^ 4 = (Complex.I ^ 2) ^ 2 by ring, Complex.I_sq]

theorem even_of_sq_add_sq_mod_four (a b : ℤ)
    (h : (a ^ 2 + b ^ 2) % 4 = 0) : a % 2 = 0 ∧ b % 2 = 0 := by
  have ha : 0 ≤ a % 4 ∧ a % 4 < 4 := ⟨Int.emod_nonneg _ (by norm_num), Int.emod_lt_of_pos _ (by norm_num)⟩
  have hb : 0 ≤ b % 4 ∧ b % 4 < 4 := ⟨Int.emod_nonneg _ (by norm_num), Int.emod_lt_of_pos _ (by norm_num)⟩
  have hab : ((a % 4) ^ 2 + (b % 4) ^ 2) % 4 = 0 := by
    simpa only [pow_two, Int.add_emod, Int.mul_emod, Int.emod_emod] using h
  have ha' : a % 4 = 0 ∨ a % 4 = 1 ∨ a % 4 = 2 ∨ a % 4 = 3 := by omega
  have hb' : b % 4 = 0 ∨ b % 4 = 1 ∨ b % 4 = 2 ∨ b % 4 = 3 := by omega
  rcases ha' with ha' | ha' | ha' | ha' <;>
    rcases hb' with hb' | hb' | hb' | hb' <;>
    norm_num [ha', hb'] at hab <;> omega

theorem gaussian_norm_four_power (m : ℕ) (a b : ℤ)
    (h : a ^ 2 + b ^ 2 = (4 : ℤ) ^ m) :
    (a = (2 : ℤ) ^ m ∧ b = 0) ∨
    (a = -(2 : ℤ) ^ m ∧ b = 0) ∨
    (a = 0 ∧ b = (2 : ℤ) ^ m) ∨
    (a = 0 ∧ b = -(2 : ℤ) ^ m) := by
  induction m generalizing a b with
  | zero =>
      norm_num at h ⊢
      have ha : -1 ≤ a ∧ a ≤ 1 := by constructor <;> nlinarith [sq_nonneg b]
      have hb : -1 ≤ b ∧ b ≤ 1 := by constructor <;> nlinarith [sq_nonneg a]
      have ha' : a = -1 ∨ a = 0 ∨ a = 1 := by omega
      have hb' : b = -1 ∨ b = 0 ∨ b = 1 := by omega
      rcases ha' with rfl | rfl | rfl <;>
        rcases hb' with rfl | rfl | rfl <;> norm_num at h ⊢
  | succ m ih =>
      have hmod : (a ^ 2 + b ^ 2) % 4 = 0 := by
        rw [h, pow_succ]
        simp
      obtain ⟨ha, hb⟩ := even_of_sq_add_sq_mod_four a b hmod
      have ha2 : a = 2 * (a / 2) := by omega
      have hb2 : b = 2 * (b / 2) := by omega
      have hhalf : (a / 2) ^ 2 + (b / 2) ^ 2 = (4 : ℤ) ^ m := by
        have hh := h
        rw [ha2, hb2, pow_succ (4 : ℤ) m] at hh
        nlinarith [hh]
      rcases ih (a / 2) (b / 2) hhalf with h1 | h2 | h3 | h4
      · left
        rcases h1 with ⟨h1a, h1b⟩
        constructor
        · rw [ha2, h1a, pow_succ]; ring
        · rw [hb2, h1b]; ring
      · right; left
        rcases h2 with ⟨h2a, h2b⟩
        constructor
        · rw [ha2, h2a, pow_succ]; ring
        · rw [hb2, h2b]; ring
      · right; right; left
        rcases h3 with ⟨h3a, h3b⟩
        constructor
        · rw [ha2, h3a]; ring
        · rw [hb2, h3b, pow_succ]; ring
      · right; right; right
        rcases h4 with ⟨h4a, h4b⟩
        constructor
        · rw [ha2, h4a]; ring
        · rw [hb2, h4b, pow_succ]; ring

theorem complex_gaussian_norm_four_power (m : ℕ) (a b : ℤ)
    (h : Complex.normSq ((a : ℂ) + (b : ℂ) * Complex.I) = (4 : ℝ) ^ m) :
    ((a : ℂ) + (b : ℂ) * Complex.I) = (2 : ℂ) ^ m ∨
    ((a : ℂ) + (b : ℂ) * Complex.I) = -(2 : ℂ) ^ m ∨
    ((a : ℂ) + (b : ℂ) * Complex.I) = (2 : ℂ) ^ m * Complex.I ∨
    ((a : ℂ) + (b : ℂ) * Complex.I) = -((2 : ℂ) ^ m * Complex.I) := by
  have hreal : (a : ℝ) ^ 2 + (b : ℝ) ^ 2 = (4 : ℝ) ^ m := by
    simpa [Complex.normSq_apply, pow_two] using h
  have hint : a ^ 2 + b ^ 2 = (4 : ℤ) ^ m := by exact_mod_cast hreal
  rcases gaussian_norm_four_power m a b hint with h1 | h2 | h3 | h4
  · rcases h1 with ⟨rfl, rfl⟩; simp
  · rcases h2 with ⟨rfl, rfl⟩; simp
  · rcases h3 with ⟨rfl, rfl⟩; simp
  · rcases h4 with ⟨rfl, rfl⟩; simp

theorem complex_gaussian_fourth_power (m : ℕ) (z : ℂ)
    (hz : ∃ a b : ℤ, z = (a : ℂ) + (b : ℂ) * Complex.I)
    (hn : Complex.normSq z = (4 : ℝ) ^ m) : z ^ 4 = ((2 : ℂ) ^ m) ^ 4 := by
  obtain ⟨a, b, rfl⟩ := hz
  have hi4 : Complex.I ^ 4 = 1 := by
    calc
      Complex.I ^ 4 = (Complex.I ^ 2) ^ 2 := by ring
      _ = 1 := by rw [Complex.I_sq]; norm_num
  rcases complex_gaussian_norm_four_power m a b hn with h1 | h2 | h3 | h4
  · rw [h1]
  · rw [h2]; ring
  · rw [h3, mul_pow, hi4, mul_one]
  · rw [h4, neg_pow, mul_pow, hi4]; norm_num

end PauliMUBPhase

/-! ## PhaseRigidity -/
set_option autoImplicit false

open scoped BigOperators Matrix ComplexConjugate

namespace PauliMUBPhase

variable {ι : Type*} [Fintype ι] [DecidableEq ι] [Nonempty ι]

noncomputable def FourthRootPhases (t : ℝ) (v : ι → ℂ) : Prop :=
  ∃ phase : ℂ, Complex.normSq phase = 1 ∧
    ∀ i, ((t : ℂ) * phase * v i) ^ 4 = 1

theorem phase_rigid_of_integral_scaled_projector (m : ℕ) (v : ι → ℂ)
    (hcard : Fintype.card ι = 4 ^ m)
    (heq : ∀ i, Complex.normSq (v i) = 1 / (4 : ℝ) ^ m)
    (hG : PauliMUBTrace.GaussianMatrix
      (((2 : ℂ) ^ m) • ((Fintype.card ι : ℂ) • PauliMUB.projector v - 1))) :
    FourthRootPhases ((2 : ℝ) ^ m) v := by
  classical
  have ht : (2 : ℂ) ^ m ≠ 0 := pow_ne_zero _ (by norm_num)
  have hd : (4 : ℂ) ^ m ≠ 0 := pow_ne_zero _ (by norm_num)
  have hdr : (4 : ℝ) ^ m ≠ 0 := pow_ne_zero _ (by norm_num)
  have htr : ((2 : ℝ) ^ m) ^ 2 = (4 : ℝ) ^ m := by
    rw [← pow_mul, Nat.mul_comm m 2, pow_mul]
    norm_num
  have htc : ((2 : ℂ) ^ m) ^ 2 = (4 : ℂ) ^ m := by
    rw [← pow_mul, Nat.mul_comm m 2, pow_mul]
    norm_num
  let j : ι := Classical.arbitrary ι
  have hpair : ∀ i, ((4 : ℂ) ^ m * v i * conj (v j)) ^ 4 = 1 := by
    intro i
    by_cases hij : i = j
    · subst i
      have hn : conj (v j) * v j = 1 / (4 : ℂ) ^ m := by
        simpa only [Complex.normSq_eq_conj_mul_self, Complex.ofReal_div,
          Complex.ofReal_one, Complex.ofReal_pow, Complex.ofReal_ofNat] using
          congrArg (fun x : ℝ => (x : ℂ)) (heq j)
      have hw : (4 : ℂ) ^ m * v j * conj (v j) = 1 := by
        calc
          _ = (4 : ℂ) ^ m * (conj (v j) * v j) := by ring
          _ = 1 := by rw [hn]; field_simp
      rw [hw]; norm_num
    · have hgi : PauliMUBTrace.IsGaussian
          ((2 : ℂ) ^ m * ((4 : ℂ) ^ m * v i * conj (v j))) := by
        have hh := hG i j
        simpa [Matrix.smul_apply, Matrix.sub_apply, Matrix.one_apply_ne hij,
          hcard, PauliMUB.projector, smul_eq_mul, mul_assoc] using hh
      have hn : Complex.normSq
          ((2 : ℂ) ^ m * ((4 : ℂ) ^ m * v i * conj (v j))) = (4 : ℝ) ^ m := by
        simp only [Complex.normSq_mul, Complex.normSq_conj, heq]
        norm_num
        have h16 : (16 : ℝ) ^ m = ((4 : ℝ) ^ m) ^ 2 := by
          calc
            (16 : ℝ) ^ m = ((4 : ℝ) ^ 2) ^ m := by norm_num
            _ = ((4 : ℝ) ^ m) ^ 2 := by
              simp only [← pow_mul]
              congr 1
              omega
        rw [h16]
        field_simp
        ring
      have hfour := complex_gaussian_fourth_power m _ hgi hn
      rw [mul_pow] at hfour
      apply mul_left_cancel₀ (pow_ne_zero 4 ht)
      simpa only [mul_one] using hfour
  refine ⟨(2 : ℂ) ^ m * conj (v j), ?_, ?_⟩
  · simp only [Complex.normSq_mul, Complex.normSq_conj, heq]
    norm_num
  · intro i
    have he : (((2 : ℝ) ^ m : ℝ) : ℂ) * ((2 : ℂ) ^ m * conj (v j)) * v i =
        (4 : ℂ) ^ m * v i * conj (v j) := by
      push_cast
      calc
        (2 : ℂ) ^ m * ((2 : ℂ) ^ m * conj (v j)) * v i =
            ((2 : ℂ) ^ m) ^ 2 * v i * conj (v j) := by ring
        _ = _ := by rw [htc]
    rw [he]
    exact hpair i

end PauliMUBPhase

/-! ## MainTheorems -/
set_option autoImplicit false

namespace PauliMUB

open PauliMUBTrace PauliMUBPhase

/-- The square spectrum of actual tensor Pauli matrices is impossible for
    odd qubit number at least three, even for a general trace-one idempotent. -/
theorem no_sparse_pauli_idempotent_odd {n : ℕ} (hn : Odd n) (hn3 : 3 ≤ n)
    (rho : Matrix (Qubit n) (Qubit n) ℂ)
    (hrho : rho * rho = rho) (htrace : Matrix.trace rho = 1)
    (hspec : ∀ s : Label n, s ≠ 0 →
      (Matrix.trace (rho * P s)) ^ 2 = 0 ∨
        (Matrix.trace (rho * P s)) ^ 2 = 1 / ((2 ^ n : ℕ) : ℂ)) : False := by
  have hpos : (0 : ℝ) < ((2 ^ n : ℕ) : ℝ) := by positivity
  have htne : (Real.sqrt ((2 ^ n : ℕ) : ℝ) : ℂ) ≠ 0 := by
    exact_mod_cast ne_of_gt (Real.sqrt_pos.2 hpos)
  have htsq : (Real.sqrt ((2 ^ n : ℕ) : ℝ) : ℂ) ^ 2 =
      ((2 ^ n : ℕ) : ℂ) := by
    exact_mod_cast Real.sq_sqrt (le_of_lt hpos)
  exact no_gaussian_odd_qubit_scaled_idempotent hn hn3 (cardQubit n)
    rho hrho htrace (pauli_spectrum_integrality rho htrace hspec _ htsq htne)

/-- No arbitrary-amplitude actual Pauli orbit can form the required MUB
    partition in an odd number of qubits at least three. -/
theorem no_pauli_mub_odd {n : ℕ} (hn : Odd n) (hn3 : 3 ≤ n)
    (v : Qubit n → ℂ) (h : PauliOrbitMUB v) : False := by
  obtain ⟨hrho, htrace, hspec⟩ := pauli_orbit_projector_certificate h
  exact no_sparse_pauli_idempotent_odd hn hn3 (projector v) hrho htrace hspec

/-- The primary higher-dimensional odd-qubit range of this project. -/
theorem no_pauli_mub_odd_ge_five {n : ℕ} (hn : Odd n) (hn5 : 5 ≤ n) :
    ¬ ∃ v : Qubit n → ℂ, Nonempty (PauliOrbitMUB v) := by
  rintro ⟨v, ⟨h⟩⟩
  exact no_pauli_mub_odd hn (by omega) v h

theorem cardQubit_even (m : ℕ) : Fintype.card (Qubit (2 * m)) = 4 ^ m := by
  rw [cardQubit, pow_mul]
  norm_num

/-- All equimodular even-qubit fiducials have fourth-root phases after
    one global rephasing. This is a necessary condition, not nonexistence. -/
theorem pauli_mub_even_phase_rigidity {m : ℕ} (v : Qubit (2 * m) → ℂ)
    (h : PauliOrbitMUB v)
    (heq : ∀ x, Complex.normSq (v x) = 1 / (4 : ℝ) ^ m) :
    FourthRootPhases ((2 : ℝ) ^ m) v := by
  obtain ⟨_, htrace, hspec⟩ := pauli_orbit_projector_certificate h
  have htsq : ((2 : ℂ) ^ m) ^ 2 = ((2 ^ (2 * m) : ℕ) : ℂ) := by
    push_cast
    rw [← pow_mul, Nat.mul_comm m 2]
  have htne : (2 : ℂ) ^ m ≠ 0 := pow_ne_zero _ (by norm_num)
  have hG := pauli_spectrum_integrality (projector v) htrace hspec
    ((2 : ℂ) ^ m) htsq htne
  apply phase_rigid_of_integral_scaled_projector m v (cardQubit_even m) heq
  simpa only [cardQubit] using hG

end PauliMUB

/-! ## BoundaryExamples -/
set_option autoImplicit false
set_option maxRecDepth 4096
set_option maxHeartbeats 4000000

open scoped BigOperators Matrix ComplexConjugate

namespace PauliMUB

/-- The first component records an X flip; the second a Z phase.
    The order is exactly the actual Pauli order I, X, Y, Z. -/
noncomputable def singleSplit : Fin 4 ≃ Fin 2 × Fin 2 where
  toFun a := ![(0,0), (1,0), (1,1), (0,1)] a
  invFun ab := if ab.1 = 0 then
    (if ab.2 = 0 then ⟨0, by decide⟩ else ⟨3, by decide⟩)
    else (if ab.2 = 0 then ⟨1, by decide⟩ else ⟨2, by decide⟩)
  left_inv a := by fin_cases a <;> decide
  right_inv ab := by
    rcases ab with ⟨a,b⟩
    fin_cases a <;> fin_cases b <;> decide

/-- The Pauli labels, arranged into a flip row and a phase column. -/
noncomputable def pauliSplit {n : ℕ} : Label n ≃ Qubit n × Qubit n where
  toFun s := (fun k => (singleSplit (s k)).1, fun k => (singleSplit (s k)).2)
  invFun ab := fun k => singleSplit.symm (ab.1 k, ab.2 k)
  left_inv s := by funext k; simp
  right_inv ab := by apply Prod.ext <;> funext k <;> simp

theorem qubit_two_eta (x : Qubit 2) : x = ![x 0, x 1] := by
  funext k
  fin_cases k <;> rfl

theorem forall_qubit_two {p : Qubit 2 → Prop} :
    (∀ x, p x) ↔ p ![0,0] ∧ p ![0,1] ∧ p ![1,0] ∧ p ![1,1] := by
  constructor
  · intro h
    exact ⟨h _, h _, h _, h _⟩
  · rintro ⟨h00, h01, h10, h11⟩ x
    rw [qubit_two_eta x]
    generalize x 0 = a
    generalize x 1 = b
    fin_cases a <;> fin_cases b <;> assumption

theorem sum_qubit_two (f : Qubit 2 → ℂ) :
    (∑ x, f x) = f ![0,0] + f ![0,1] + f ![1,0] + f ![1,1] := by
  calc
    _ = ∑ ab : Fin 2 × Fin 2, f ((finTwoArrowEquiv (Fin 2)).symm ab) := by
      apply Fintype.sum_equiv (finTwoArrowEquiv (Fin 2))
      intro x
      exact congrArg f ((finTwoArrowEquiv (Fin 2)).symm_apply_apply x).symm
    _ = _ := by
      simp [Fintype.sum_prod_type, Fin.sum_univ_two, finTwoArrowEquiv]
      ring

/-- The published two-qubit fiducial `(1,i,i,i)/2`, in binary indexing. -/
noncomputable def fiducialTwo (x : Qubit 2) : ℂ :=
  if x 0 = 0 ∧ x 1 = 0 then 1 / 2 else Complex.I / 2

theorem fiducialTwo_equimodular :
    ∀ x, Complex.normSq (fiducialTwo x) = 1 / 4 := by
  rw [forall_qubit_two]
  norm_num [fiducialTwo, Complex.normSq_div]

theorem fiducialTwo_normalized : overlap fiducialTwo fiducialTwo = 1 := by
  norm_num [overlap, sum_qubit_two, fiducialTwo, Complex.ext_iff,
    Complex.div_re, Complex.div_im, Complex.normSq_apply]

theorem fiducialTwo_orbit_normalized :
    ∀ a b : Qubit 2,
      overlap (P (pauliSplit.symm (a,b)) *ᵥ fiducialTwo)
        (P (pauliSplit.symm (a,b)) *ᵥ fiducialTwo) = 1 := by
  intro a b
  exact pauli_preserves_normalization _ _ fiducialTwo_normalized

theorem fiducialTwo_orbit_orthogonal :
    ∀ a b c : Qubit 2, b ≠ c →
      overlap (P (pauliSplit.symm (a,b)) *ᵥ fiducialTwo)
        (P (pauliSplit.symm (a,c)) *ᵥ fiducialTwo) = 0 := by
  simp only [forall_qubit_two]
  repeat' apply And.intro
  all_goals
    intro hne
    norm_num [funext_iff, Fin.forall_fin_two] at hne
  all_goals norm_num [overlap, Matrix.mulVec, dotProduct, sum_qubit_two,
    P, Fin.prod_univ_two, single, pauliSplit, singleSplit, fiducialTwo,
    funext_iff, Fin.forall_fin_two, Complex.ext_iff,
    Complex.div_re, Complex.div_im, Complex.normSq_apply]

theorem fiducialTwo_orbit_unbiased :
    ∀ a c : Qubit 2, a ≠ c → ∀ b d : Qubit 2,
      Complex.normSq (overlap (P (pauliSplit.symm (a,b)) *ᵥ fiducialTwo)
        (P (pauliSplit.symm (c,d)) *ᵥ fiducialTwo)) = 1 / 4 := by
  simp only [forall_qubit_two]
  repeat' apply And.intro
  all_goals
    intro hne
    norm_num [funext_iff, Fin.forall_fin_two] at hne
  all_goals repeat' apply And.intro
  all_goals norm_num [overlap, Matrix.mulVec, dotProduct, sum_qubit_two,
    P, Fin.prod_univ_two, single, pauliSplit, singleSplit, fiducialTwo,
    funext_iff, Fin.forall_fin_two, Complex.normSq_apply,
    Complex.div_re, Complex.div_im]

/-- A nonvacuous boundary example: the actual two-qubit Pauli orbit of
    `(1,i,i,i)/2` is exactly four mutually unbiased orthonormal bases.
    Every arithmetic step above is checked by the Lean kernel. -/
noncomputable def fiducialTwo_mub : PauliOrbitMUB fiducialTwo where
  enumerate := pauliSplit
  normalized := fiducialTwo_orbit_normalized
  orthogonal := fiducialTwo_orbit_orthogonal
  unbiased a c hac b d := by
    have hc : (Fintype.card (Qubit 2) : ℝ) = 4 := by norm_num [cardQubit]
    rw [hc]
    exact fiducialTwo_orbit_unbiased a c hac b d

theorem exists_two_qubit_pauli_mub :
    ∃ v : Qubit 2 → ℂ, Nonempty (PauliOrbitMUB v) ∧
      (∀ x, Complex.normSq (v x) = 1 / 4) :=
  ⟨fiducialTwo, ⟨fiducialTwo_mub⟩, fiducialTwo_equimodular⟩

end PauliMUB

end


/-! ## Complete recursive axiom audit

The second constant map contains every declaration introduced by this file,
including auxiliary and compiler-generated declarations. Imported constants
are not counted as new declarations; their dependencies are traversed by
`collectAxioms` for every new declaration.
-/
open Lean Elab Command in
run_cmd do
  let env ← getEnv
  let allowed : Array Name := #[`Classical.choice, `Quot.sound, `propext]
  let required : Array Name := #[
    `PauliMUB.no_pauli_mub_odd_ge_five,
    `PauliMUB.pauli_mub_even_phase_rigidity,
    `PauliMUB.exists_two_qubit_pauli_mub]
  let mut records : Array Json := #[]
  let mut names : Array Name := #[]
  let mut rejected : Array String := #[]
  for (name, _) in env.constants.map₂.toList do
    names := names.push name
    let axioms ← collectAxioms name
    let unexpected := axioms.filter fun ax => !allowed.contains ax
    records := records.push <| Json.mkObj [
      ("declaration", toJson name.toString),
      ("axioms", toJson (axioms.map Name.toString)),
      ("unexpected_axioms", toJson (unexpected.map Name.toString))]
    unless unexpected.isEmpty do
      rejected := rejected.push name.toString
  for name in required do
    unless names.contains name do
      throwError "Required project theorem missing from audit: {name}"
  if records.isEmpty then
    throwError "No project declarations were audited"
  let report := Json.mkObj [
    ("schema_version", toJson (1 : Nat)),
    ("status", toJson (if rejected.isEmpty then "passed" else "failed")),
    ("allowed_axioms", toJson (allowed.map Name.toString)),
    ("declaration_count", toJson records.size),
    ("required_declarations", toJson (required.map Name.toString)),
    ("declarations", Json.arr records),
    ("rejected_declarations", toJson rejected)]
  logInfo m!"EDEG_KERNEL_AXIOMS: {report.compress}"
  unless rejected.isEmpty do
    throwError "Unexpected axiom dependencies in project declarations: {rejected}"
