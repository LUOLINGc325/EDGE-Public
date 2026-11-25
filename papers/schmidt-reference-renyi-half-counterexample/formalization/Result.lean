import Lean
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Data.Matrix.Notation
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FinCases
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Data.Real.Sqrt
import Mathlib.Analysis.Complex.Basic
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Data.Matrix.ConjTranspose
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Topology.Order.Basic
import Mathlib.Topology.Algebra.Ring.Basic
import Mathlib.Tactic.FunProp

set_option autoImplicit false

-- BEGIN PauliMoment
/- Exact finite Pauli-moment certificate for an 8-qubit pure-state counterexample.
All finite equalities use kernel reduction, never native_decide.
The Walsh reduction is proved for arbitrary integer and real amplitudes.
The real bridge transports the exact integer certificate without floating point. -/

set_option maxRecDepth 100000
set_option maxHeartbeats 0

namespace SchmidtHalf

abbrev Idx := Fin 16

noncomputable def xor (x y : Idx) : Idx := x ^^^ y

noncomputable def chi (v x : Idx) : ℤ :=
  ∏ k : Fin 4, if v.val.testBit k.val && x.val.testBit k.val then -1 else 1

theorem xor_inv : ∀ u x : Idx, xor (xor x u) u = x := by decide +kernel

theorem xor_comm : ∀ x y : Idx, xor x y = xor y x := by decide +kernel

theorem chi_mul : ∀ u v x : Idx, chi u x * chi v x = chi (xor u v) x := by decide +kernel

theorem chi_eq_one_or_neg_one : ∀ v x : Idx, chi v x = 1 ∨ chi v x = -1 := by decide +kernel

theorem chi_sq : ∀ v x : Idx, chi v x * chi v x = 1 := by decide +kernel

noncomputable def source : Idx → ℤ := ![18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,1]

noncomputable def swap : Equiv.Perm Idx := Equiv.swap 11 12

noncomputable def target (i : Idx) : ℤ := source (swap i)

noncomputable def energy (a : Idx → ℤ) : ℤ := ∑ x, a x * a x

noncomputable def walsh (a : Idx → ℤ) (u v : Idx) : ℤ :=
  ∑ x, a x * a (xor x u) * chi v x

noncomputable def walshL1 (a : Idx → ℤ) : ℤ := ∑ u, ∑ v, |walsh a u v|

theorem source_energy : energy source = 2096 := by decide +kernel

theorem target_energy : energy target = 2096 := by decide +kernel

theorem source_sorted : ∀ i j : Idx, i ≤ j → source j ≤ source i := by decide +kernel

theorem source_strict : ∀ i j : Idx, i < j → source j < source i := by decide +kernel

theorem source_pos : ∀ i : Idx, 0 < source i := by decide +kernel

theorem source_walshL1 : walshL1 source = 55920 := by decide +kernel

theorem target_walshL1 : walshL1 target = 55916 := by decide +kernel


theorem xor_left_cancel : ∀ i u r : Idx, xor i u = xor i r ↔ u = r := by decide +kernel

noncomputable def xorPerm (u : Idx) : Equiv.Perm Idx where
  toFun := fun x => xor u x
  invFun := fun x => xor u x
  left_inv x := by change xor u (xor u x) = x; rw [xor_comm u (xor u x), xor_comm u x]; exact xor_inv u x
  right_inv x := by change xor u (xor u x) = x; rw [xor_comm u (xor u x), xor_comm u x]; exact xor_inv u x

theorem sum_xor (f : Idx → ℤ) (u : Idx) : (∑ x, f (xor u x)) = ∑ x, f x :=
  Equiv.sum_comp (xorPerm u) f

noncomputable def raw (a : Idx → ℤ) (i j : Idx) : ℤ := if i = j then a i else 0

noncomputable def rawPauliNumerator (a : Idx → ℤ) (u v r s : Idx) : ℤ :=
  ∑ i, ∑ j, raw a i j * raw a (xor i u) (xor j r) * chi v i * chi s j

theorem rawPauliNumerator_eq (a : Idx → ℤ) (u v r s : Idx) :
    rawPauliNumerator a u v r s = if u = r then walsh a u (xor v s) else 0 := by
  have hdiag : ∀ i : Idx,
      (∑ j, raw a i j * raw a (xor i u) (xor j r) * chi v i * chi s j) =
      a i * raw a (xor i u) (xor i r) * chi v i * chi s i := by
    intro i
    rw [Finset.sum_eq_single i]
    · simp [raw]
    · intro j hj hji
      simp [raw, Ne.symm hji]
    · intro h
      exact (h (Finset.mem_univ i)).elim
  unfold rawPauliNumerator
  simp_rw [hdiag]
  by_cases h : u = r
  · subst r
    simp only [if_pos rfl]
    unfold walsh
    apply Finset.sum_congr rfl
    intro i hi
    simp only [raw, ite_true]
    rw [← chi_mul]
    ring
  · simp only [if_neg h]
    apply Finset.sum_eq_zero
    intro i hi
    have hn : xor i u ≠ xor i r := by
      intro he
      exact h ((xor_left_cancel i u r).mp he)
    simp [raw, hn]

noncomputable def fullRawL1 (a : Idx → ℤ) : ℤ :=
  ∑ u, ∑ v, ∑ r, ∑ s, |rawPauliNumerator a u v r s|

theorem fullRawL1_eq (a : Idx → ℤ) : fullRawL1 a = 16 * walshL1 a := by
  unfold fullRawL1
  simp_rw [rawPauliNumerator_eq]
  have hr (u v : Idx) :
      (∑ r, ∑ s, |if u = r then walsh a u (xor v s) else 0|) =
      ∑ s, |walsh a u (xor v s)| := by
    rw [Finset.sum_eq_single u]
    · simp
    · intro r hr hru
      simp [Ne.symm hru]
    · intro h
      exact (h (Finset.mem_univ u)).elim
  have hs (u v : Idx) : (∑ s, |walsh a u (xor v s)|) = ∑ s, |walsh a u s| :=
    sum_xor (fun s => |walsh a u s|) v
  simp_rw [hr, hs]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  rw [← Finset.mul_sum]
  rfl

theorem source_fullRawL1 : fullRawL1 source = 894720 := by
  rw [fullRawL1_eq, source_walshL1]
  norm_num

theorem target_fullRawL1 : fullRawL1 target = 894656 := by
  rw [fullRawL1_eq, target_walshL1]
  norm_num



/-- Squared norm of the diagonal amplitude matrix, before normalization. -/
noncomputable def energyR (a : Idx → ℝ) : ℝ := ∑ x, a x * a x

/-- The actual unnormalized bipartite computational-basis vector. -/
noncomputable def rawR (a : Idx → ℝ) (i j : Idx) : ℝ := if i = j then a i else 0

/-- Walsh coefficient of the product with a binary translate. -/
noncomputable def walshR (a : Idx → ℝ) (u v : Idx) : ℝ :=
  ∑ x, a x * a (xor x u) * (chi v x : ℝ)

noncomputable def walshL1R (a : Idx → ℝ) : ℝ := ∑ u, ∑ v, |walshR a u v|

/-- Expectation numerator for the complete pair of projective Pauli operators. -/
noncomputable def rawPauliNumeratorR (a : Idx → ℝ) (u v r s : Idx) : ℝ :=
  ∑ i, ∑ j, rawR a i j * rawR a (xor i u) (xor j r) * (chi v i : ℝ) * (chi s j : ℝ)

noncomputable def fullRawL1R (a : Idx → ℝ) : ℝ :=
  ∑ u, ∑ v, ∑ r, ∑ s, |rawPauliNumeratorR a u v r s|

theorem energyR_int (a : Idx → ℤ) :
    energyR (fun i => (a i : ℝ)) = (energy a : ℝ) := by
  simp [energyR, energy, Int.cast_sum, Int.cast_mul]

theorem rawR_int (a : Idx → ℤ) (i j : Idx) :
    rawR (fun k => (a k : ℝ)) i j = (raw a i j : ℝ) := by
  simp [rawR, raw]

theorem walshR_int (a : Idx → ℤ) (u v : Idx) :
    walshR (fun i => (a i : ℝ)) u v = (walsh a u v : ℝ) := by
  simp [walshR, walsh, Int.cast_sum, Int.cast_mul]

theorem walshL1R_int (a : Idx → ℤ) :
    walshL1R (fun i => (a i : ℝ)) = (walshL1 a : ℝ) := by
  simp [walshL1R, walshL1, walshR_int, Int.cast_sum]

theorem rawPauliNumeratorR_int (a : Idx → ℤ) (u v r s : Idx) :
    rawPauliNumeratorR (fun i => (a i : ℝ)) u v r s =
      (rawPauliNumerator a u v r s : ℝ) := by
  simp [rawPauliNumeratorR, rawPauliNumerator, rawR_int, Int.cast_sum, Int.cast_mul]

theorem fullRawL1R_int (a : Idx → ℤ) :
    fullRawL1R (fun i => (a i : ℝ)) = (fullRawL1 a : ℝ) := by
  simp [fullRawL1R, fullRawL1, rawPauliNumeratorR_int, Int.cast_sum]

theorem chiR_mul (u v x : Idx) :
    (chi u x : ℝ) * (chi v x : ℝ) = (chi (xor u v) x : ℝ) := by
  rw [← Int.cast_mul, chi_mul]

theorem sum_xorR (f : Idx → ℝ) (u : Idx) :
    (∑ x, f (xor u x)) = ∑ x, f x := Equiv.sum_comp (xorPerm u) f

theorem rawPauliNumeratorR_eq (a : Idx → ℝ) (u v r s : Idx) :
    rawPauliNumeratorR a u v r s = if u = r then walshR a u (xor v s) else 0 := by
  have hdiag : ∀ i : Idx,
      (∑ j, rawR a i j * rawR a (xor i u) (xor j r) *
        (chi v i : ℝ) * (chi s j : ℝ)) =
      a i * rawR a (xor i u) (xor i r) * (chi v i : ℝ) * (chi s i : ℝ) := by
    intro i
    rw [Finset.sum_eq_single i]
    · simp [rawR]
    · intro j hj hji
      simp [rawR, Ne.symm hji]
    · intro h
      exact (h (Finset.mem_univ i)).elim
  unfold rawPauliNumeratorR
  simp_rw [hdiag]
  by_cases h : u = r
  · subst r
    simp only [if_pos rfl]
    unfold walshR
    apply Finset.sum_congr rfl
    intro i hi
    simp only [rawR, ite_true]
    rw [← chiR_mul]
    ring
  · simp only [if_neg h]
    apply Finset.sum_eq_zero
    intro i hi
    have hn : xor i u ≠ xor i r := by
      intro he
      exact h ((xor_left_cancel i u r).mp he)
    simp [rawR, hn]

theorem fullRawL1R_eq (a : Idx → ℝ) : fullRawL1R a = 16 * walshL1R a := by
  unfold fullRawL1R
  simp_rw [rawPauliNumeratorR_eq]
  have hr (u v : Idx) :
      (∑ r, ∑ s, |if u = r then walshR a u (xor v s) else 0|) =
      ∑ s, |walshR a u (xor v s)| := by
    rw [Finset.sum_eq_single u]
    · simp
    · intro r hr hru
      simp [Ne.symm hru]
    · intro h
      exact (h (Finset.mem_univ u)).elim
  have hs (u v : Idx) : (∑ s, |walshR a u (xor v s)|) = ∑ s, |walshR a u s| :=
    sum_xorR (fun s => |walshR a u s|) v
  simp_rw [hr, hs]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  rw [← Finset.mul_sum]
  rfl

noncomputable def sourceR : Idx → ℝ := fun i => (source i : ℝ)
noncomputable def targetR : Idx → ℝ := fun i => (target i : ℝ)

theorem targetR_swap (i : Idx) : targetR i = sourceR (swap i) := rfl

theorem sourceR_energy : energyR sourceR = 2096 := by
  unfold sourceR
  rw [energyR_int, source_energy]
  norm_num

theorem targetR_energy : energyR targetR = 2096 := by
  unfold targetR
  rw [energyR_int, target_energy]
  norm_num

theorem sourceR_walshL1 : walshL1R sourceR = 55920 := by
  unfold sourceR
  rw [walshL1R_int, source_walshL1]
  norm_num

theorem targetR_walshL1 : walshL1R targetR = 55916 := by
  unfold targetR
  rw [walshL1R_int, target_walshL1]
  norm_num

theorem sourceR_fullRawL1 : fullRawL1R sourceR = 894720 := by
  unfold sourceR
  rw [fullRawL1R_int, source_fullRawL1]
  norm_num

theorem targetR_fullRawL1 : fullRawL1R targetR = 894656 := by
  unfold targetR
  rw [fullRawL1R_int, target_fullRawL1]
  norm_num

theorem sourceR_pos (i : Idx) : 0 < sourceR i := by
  unfold sourceR
  exact_mod_cast source_pos i

theorem sourceR_strict (i j : Idx) (h : i < j) : sourceR j < sourceR i := by
  unfold sourceR
  exact_mod_cast source_strict i j h

end SchmidtHalf
-- END PauliMoment

-- BEGIN StateEntropy
/-
Complex-state and physical Pauli bridge for the half-order Schmidt-reference counterexample.
The normalized states, local unitary matrices, reduced density matrices and Schmidt
expansions are proved explicitly. The stabilizer entropy is connected to actual
Hermitian Pauli tensor-product matrix expectations before using the exact certificate.
All proofs are kernel checked. No additional axioms or native_decide are used.
-/

set_option maxRecDepth 100000
set_option maxHeartbeats 0

namespace SchmidtHalf
noncomputable section
open scoped BigOperators ComplexConjugate

abbrev BipartiteState := Idx → Idx → ℂ

noncomputable def denominator (a : Idx → ℝ) : ℝ := Real.sqrt (energyR a)

theorem denominator_pos (a : Idx → ℝ) (h : 0 < energyR a) : 0 < denominator a :=
  Real.sqrt_pos.2 h

theorem denominator_sq (a : Idx → ℝ) (h : 0 ≤ energyR a) :
    denominator a ^ 2 = energyR a := Real.sq_sqrt h

noncomputable def coeff (a : Idx → ℝ) (i : Idx) : ℝ := a i / denominator a

noncomputable def psi (a : Idx → ℝ) : BipartiteState :=
  fun i j => if i = j then (coeff a i : ℂ) else 0

noncomputable def stateNormSq (φ : BipartiteState) : ℝ := ∑ i, ∑ j, Complex.normSq (φ i j)

theorem psi_normalized (a : Idx → ℝ) (h : 0 < energyR a) :
    stateNormSq (psi a) = 1 := by
  simp only [stateNormSq, psi, apply_ite, Complex.normSq_zero]
  simp only [Finset.sum_ite_eq, Finset.mem_univ, if_true, Complex.normSq_ofReal]
  simp only [coeff, div_mul_div_comm]
  simp_rw [← pow_two]
  rw [← Finset.sum_div, denominator_sq a h.le]
  convert div_self (ne_of_gt h) using 1
  simp [energyR, pow_two]

noncomputable def ket (k i : Idx) : ℂ := if i = k then 1 else 0

theorem ket_orthonormal (i j : Idx) :
    (∑ x, conj (ket i x) * ket j x) = if i = j then 1 else 0 := by
  simp [ket, eq_comm]

theorem psi_schmidt_expansion (a : Idx → ℝ) (i j : Idx) :
    psi a i j = ∑ k, (coeff a k : ℂ) * ket k i * ket k j := by
  by_cases hij : i = j
  · subst j; simp [psi, ket]
  · simp [psi, ket, hij]

theorem coeff_pos (a : Idx → ℝ) (ha : ∀ i, 0 < a i) (h : 0 < energyR a) (i : Idx) :
    0 < coeff a i := div_pos (ha i) (denominator_pos a h)

theorem coeff_strict_sorted (a : Idx → ℝ) (h : 0 < energyR a)
    (hs : ∀ i j : Idx, i < j → a j < a i) (i j : Idx) (hij : i < j) :
    coeff a j < coeff a i := div_lt_div_of_pos_right (hs i j hij) (denominator_pos a h)

noncomputable def permGate (e : Equiv.Perm Idx) : Matrix Idx Idx ℂ :=
  fun i j => if e i = j then 1 else 0

theorem permGate_unitary (e : Equiv.Perm Idx) :
    (permGate e).conjTranspose * permGate e = 1 ∧
    permGate e * (permGate e).conjTranspose = 1 := by
  constructor
  · ext i j
    change (∑ k, star (if e k = i then (1:ℂ) else 0) *
      (if e k = j then (1:ℂ) else 0)) = if i = j then 1 else 0
    rw [Equiv.sum_comp (e : Idx ≃ Idx)
      (fun k => star (if k = i then (1:ℂ) else 0) * (if k = j then 1 else 0))]
    simp [eq_comm]
  · ext i j
    simp [Matrix.mul_apply, Matrix.conjTranspose_apply, permGate, Matrix.one_apply]

noncomputable def localAction (U V : Matrix Idx Idx ℂ) (φ : BipartiteState) : BipartiteState :=
  fun i j => ∑ k, ∑ l, U i k * V j l * φ k l

theorem permGate_action (e f : Equiv.Perm Idx) (φ : BipartiteState) (i j : Idx) :
    localAction (permGate e) (permGate f) φ i j = φ (e i) (f j) := by
  simp [localAction, permGate]

theorem energyR_perm (a : Idx → ℝ) (e : Equiv.Perm Idx) : energyR (a ∘ e) = energyR a := by
  exact Equiv.sum_comp (e : Idx ≃ Idx) (fun i => a i * a i)

theorem permGate_psi (e : Equiv.Perm Idx) (a : Idx → ℝ) :
    localAction (permGate e) (permGate e) (psi a) = psi (a ∘ e) := by
  funext i j
  simp [permGate_action, psi, coeff, denominator, energyR_perm]


theorem psi_eq_raw (a : Idx → ℝ) (i j : Idx) :
    psi a i j = ((rawR a i j / denominator a : ℝ) : ℂ) := by
  by_cases h : i = j
  · simp [psi, rawR, h, coeff]
  · simp [psi, rawR, h]

/-- The expectation of the tensor product X^u Z^v ⊗ X^r Z^s.
    The character is evaluated on the input ket, before its XOR shift. -/
noncomputable def projectiveExpectation (φ : BipartiteState) (u v r s : Idx) : ℂ :=
  ∑ i, ∑ j, conj (φ (xor i u) (xor j r)) * φ i j *
    ((chi v i : ℝ) : ℂ) * ((chi s j : ℝ) : ℂ)

theorem projectiveExpectation_psi (a : Idx → ℝ) (ha : 0 < energyR a)
    (u v r s : Idx) :
    projectiveExpectation (psi a) u v r s =
      ((rawPauliNumeratorR a u v r s / energyR a : ℝ) : ℂ) := by
  have ht (i j : Idx) :
      rawR a (xor i u) (xor j r) / denominator a *
        (rawR a i j / denominator a) * (chi v i : ℝ) * (chi s j : ℝ) =
      (rawR a i j * rawR a (xor i u) (xor j r) *
        (chi v i : ℝ) * (chi s j : ℝ)) / energyR a := by
    calc
      _ = (rawR a i j * rawR a (xor i u) (xor j r) *
        (chi v i : ℝ) * (chi s j : ℝ)) / (denominator a)^2 := by ring
      _ = _ := by rw [denominator_sq a ha.le]
  unfold projectiveExpectation rawPauliNumeratorR
  simp_rw [psi_eq_raw, Complex.conj_ofReal, ← Complex.ofReal_mul, ht]
  simp only [← Complex.ofReal_sum, ← Finset.sum_div]

/-- Half-order stabilizer moment, initially evaluated from the actual Pauli expectations. -/
noncomputable def halfMoment (φ : BipartiteState) : ℝ :=
  (∑ u, ∑ v, ∑ r, ∑ s, ‖projectiveExpectation φ u v r s‖) / 256

noncomputable def halfEntropy (φ : BipartiteState) : ℝ := 2 * Real.log (halfMoment φ) / Real.log 2

theorem halfMoment_psi (a : Idx → ℝ) (ha : 0 < energyR a) :
    halfMoment (psi a) = fullRawL1R a / (256 * energyR a) := by
  unfold halfMoment
  simp_rw [projectiveExpectation_psi a ha, Complex.norm_real, Real.norm_eq_abs,
    abs_div, abs_of_pos ha]
  simp only [← Finset.sum_div, fullRawL1R]
  ring

theorem halfMoment_walsh (a : Idx → ℝ) (ha : 0 < energyR a) :
    halfMoment (psi a) = walshL1R a / (16 * energyR a) := by
  rw [halfMoment_psi a ha, fullRawL1R_eq]
  ring



theorem xor_zero : ∀ i : Idx, xor i 0 = i := by decide +kernel
theorem chi_zero : ∀ i : Idx, chi 0 i = 1 := by decide +kernel

theorem walshR_zero_zero (a : Idx → ℝ) : walshR a 0 0 = energyR a := by
  simp [walshR, xor_zero, chi_zero, energyR]

theorem walshL1R_ge_energy (a : Idx → ℝ) : energyR a ≤ walshL1R a := by
  have h1 : |walshR a 0 0| ≤ ∑ v, |walshR a 0 v| :=
    Finset.single_le_sum (fun v _ => abs_nonneg (walshR a 0 v)) (Finset.mem_univ 0)
  have h2 : (∑ v, |walshR a 0 v|) ≤ walshL1R a := by
    unfold walshL1R
    exact Finset.single_le_sum (fun u _ => Finset.sum_nonneg
      (fun v _ => abs_nonneg (walshR a u v))) (Finset.mem_univ 0)
  rw [walshR_zero_zero] at h1
  exact le_trans (le_abs_self _) (le_trans h1 h2)

theorem halfMoment_pos (a : Idx → ℝ) (ha : 0 < energyR a) :
    0 < halfMoment (psi a) := by
  rw [halfMoment_walsh a ha]
  exact div_pos (lt_of_lt_of_le ha (walshL1R_ge_energy a)) (mul_pos (by norm_num) ha)

theorem perm_entropy_lt_of_walsh (a : Idx → ℝ) (e : Equiv.Perm Idx)
    (ha : 0 < energyR a) (hlt : walshL1R (a ∘ e) < walshL1R a) :
    halfEntropy (localAction (permGate e) (permGate e) (psi a)) < halfEntropy (psi a) := by
  rw [permGate_psi]
  have hae : 0 < energyR (a ∘ e) := by rw [energyR_perm]; exact ha
  have hmoment : halfMoment (psi (a ∘ e)) < halfMoment (psi a) := by
    rw [halfMoment_walsh _ hae, halfMoment_walsh _ ha, energyR_perm]
    exact div_lt_div_of_pos_right hlt (mul_pos (by norm_num) ha)
  unfold halfEntropy
  exact div_lt_div_of_pos_right
    (mul_lt_mul_of_pos_left (Real.log_lt_log (halfMoment_pos _ hae) hmoment) (by norm_num))
    (Real.log_pos (by norm_num))

theorem source_normalized : stateNormSq (psi sourceR) = 1 :=
  psi_normalized sourceR (by rw [sourceR_energy]; norm_num)

theorem target_normalized : stateNormSq (psi targetR) = 1 :=
  psi_normalized targetR (by rw [targetR_energy]; norm_num)

theorem source_coeff_pos (i : Idx) : 0 < coeff sourceR i :=
  coeff_pos sourceR sourceR_pos (by rw [sourceR_energy]; norm_num) i

theorem source_coeff_strict_sorted (i j : Idx) (hij : i < j) :
    coeff sourceR j < coeff sourceR i :=
  coeff_strict_sorted sourceR (by rw [sourceR_energy]; norm_num) sourceR_strict i j hij

theorem swap_psi :
    localAction (permGate swap) (permGate swap) (psi sourceR) = psi targetR :=
  permGate_psi swap sourceR

theorem source_halfMoment : halfMoment (psi sourceR) = 13980 / 8384 := by
  rw [halfMoment_walsh sourceR (by rw [sourceR_energy]; norm_num),
    sourceR_energy, sourceR_walshL1]
  norm_num

theorem target_halfMoment : halfMoment (psi targetR) = 13979 / 8384 := by
  rw [halfMoment_walsh targetR (by rw [targetR_energy]; norm_num),
    targetR_energy, targetR_walshL1]
  norm_num

theorem entropy_drop_exact :
    halfEntropy (psi sourceR) - halfEntropy (psi targetR) =
      2 * Real.log (13980 / 13979) / Real.log 2 := by
  unfold halfEntropy
  rw [source_halfMoment, target_halfMoment]
  have hr : (13980 / 13979 : ℝ) = (13980 / 8384) / (13979 / 8384) := by norm_num
  have hlog : Real.log (13980 / 13979 : ℝ) =
      Real.log (13980 / 8384) - Real.log (13979 / 8384) := by
    rw [hr, Real.log_div (by norm_num) (by norm_num)]
  rw [hlog]
  ring

theorem entropy_drop_positive :
    0 < halfEntropy (psi sourceR) - halfEntropy (psi targetR) := by
  rw [entropy_drop_exact]
  exact div_pos (mul_pos (by norm_num) (Real.log_pos (by norm_num)))
    (Real.log_pos (by norm_num))

theorem counterexample_entropy_strict :
    halfEntropy (localAction (permGate swap) (permGate swap) (psi sourceR)) <
      halfEntropy (psi sourceR) := by
  rw [swap_psi]
  exact sub_pos.mp entropy_drop_positive



/-- Partial trace of the rank-one density matrix over the second subsystem. -/
noncomputable def reducedDensityA (φ : BipartiteState) : Matrix Idx Idx ℂ :=
  fun i k => ∑ j, φ i j * conj (φ k j)

theorem reducedDensityA_psi (a : Idx → ℝ) (ha : 0 < energyR a) (i k : Idx) :
    reducedDensityA (psi a) i k =
      if i = k then ((a i * a i / energyR a : ℝ) : ℂ) else 0 := by
  by_cases hik : i = k
  · subst k
    have hreal : coeff a i * coeff a i = a i * a i / energyR a := by
      unfold coeff
      rw [div_mul_div_comm]
      rw [show denominator a * denominator a = energyR a from by
        simpa [pow_two] using denominator_sq a ha.le]
    simpa [reducedDensityA, psi, Complex.conj_ofReal] using congrArg Complex.ofReal hreal
  · simp [reducedDensityA, psi, Complex.conj_ofReal, hik, Ne.symm hik]

theorem permuted_ket_orthonormal (e : Equiv.Perm Idx) (i j : Idx) :
    (∑ x, conj (ket i (e x)) * ket j (e x)) = if i = j then 1 else 0 := by
  rw [Equiv.sum_comp (e : Idx ≃ Idx) (fun x => conj (ket i x) * ket j x)]
  exact ket_orthonormal i j

theorem localAction_schmidt_expansion (e : Equiv.Perm Idx) (a : Idx → ℝ) (i j : Idx) :
    localAction (permGate e) (permGate e) (psi a) i j =
      ∑ k, (coeff a k : ℂ) * ket k (e i) * ket k (e j) := by
  rw [permGate_action]
  exact psi_schmidt_expansion a (e i) (e j)


end
end SchmidtHalf


set_option maxRecDepth 100000
set_option maxHeartbeats 0

namespace SchmidtHalf
noncomputable section
open scoped BigOperators ComplexConjugate

/-- The conventional positive Pauli phase: each Y bit contributes one factor i. -/
noncomputable def jointBits (u v : Idx) : ℕ :=
  ∑ k : Fin 4, if u.val.testBit k.val && v.val.testBit k.val then 1 else 0

noncomputable def pauliPhase (u v : Idx) : ℂ := Complex.I ^ jointBits u v

/-- Matrix entries of the Hermitian Pauli string i^(u dot v) X^u Z^v. -/
noncomputable def pauliMatrix (u v : Idx) : Matrix Idx Idx ℂ :=
  fun i j => if i = xor j u then pauliPhase u v * ((chi v j : ℝ) : ℂ) else 0

theorem pauliPhase_norm (u v : Idx) : ‖pauliPhase u v‖ = 1 := by
  simp [pauliPhase, norm_pow]

theorem chi_jointBits (u v : Idx) : chi v u = (-1 : ℤ) ^ jointBits u v := by
  unfold chi jointBits
  rw [← Finset.prod_pow_eq_pow_sum]
  apply Finset.prod_congr rfl
  intro k hk
  cases h1 : u.val.testBit k.val <;> cases h2 : v.val.testBit k.val <;> simp [h1, h2]

theorem chi_comm : ∀ v u : Idx, chi v u = chi u v := by decide +kernel

theorem chi_translate (v x u : Idx) : chi v (xor x u) = chi v x * chi v u := by
  rw [chi_comm v (xor x u), ← chi_mul, chi_comm x v, chi_comm u v]

theorem pauliPhase_conj (u v : Idx) :
    conj (pauliPhase u v) = pauliPhase u v * ((chi v u : ℝ) : ℂ) := by
  rw [chi_jointBits]
  simp only [pauliPhase, map_pow, Complex.conj_I]
  have hi : -Complex.I = (-1 : ℂ) * Complex.I := by ring
  rw [hi, mul_pow]
  simp [mul_comm]

theorem pauliPhase_sq (u v : Idx) :
    pauliPhase u v * pauliPhase u v = ((chi v u : ℝ) : ℂ) := by
  rw [chi_jointBits]
  simp only [pauliPhase, ← pow_add, ← two_mul, pow_mul, Complex.I_sq]
  norm_cast

theorem pauliMatrix_hermitian (u v : Idx) :
    (pauliMatrix u v).conjTranspose = pauliMatrix u v := by
  ext i j
  change conj (pauliMatrix u v j i) = pauliMatrix u v i j
  by_cases h : j = xor i u
  · have h' : i = xor j u := by rw [h, xor_inv]
    simp only [pauliMatrix, if_pos h, if_pos h', map_mul,
      Complex.conj_ofReal, pauliPhase_conj]
    rw [h, chi_translate]
    push_cast
    ring
  · have h' : i ≠ xor j u := by
      intro hi
      apply h
      rw [hi, xor_inv]
    simp [pauliMatrix, h, h']

theorem pauliMatrix_sq (u v : Idx) : pauliMatrix u v * pauliMatrix u v = 1 := by
  ext i j
  simp only [Matrix.mul_apply, pauliMatrix, mul_ite, mul_zero, Finset.sum_ite_eq',
    Finset.mem_univ, if_true, xor_inv, Matrix.one_apply]
  by_cases h : i = j
  · subst j
    simp only [if_pos rfl]
    rw [chi_translate]
    push_cast
    have hc : ((chi v i : ℝ) : ℂ) * ((chi v i : ℝ) : ℂ) = 1 := by
      exact_mod_cast chi_sq v i
    calc
      _ = (pauliPhase u v * pauliPhase u v) * ((chi v u : ℝ) : ℂ) *
          (((chi v i : ℝ) : ℂ) * ((chi v i : ℝ) : ℂ)) := by push_cast; ring
      _ = 1 := by rw [pauliPhase_sq, hc]; norm_cast; simp [chi_sq]
  · simp [h]

theorem pauliMatrix_unitary (u v : Idx) :
    (pauliMatrix u v).conjTranspose * pauliMatrix u v = 1 ∧
    pauliMatrix u v * (pauliMatrix u v).conjTranspose = 1 := by
  rw [pauliMatrix_hermitian]
  exact ⟨pauliMatrix_sq u v, pauliMatrix_sq u v⟩

/-- Expanded matrix expression for <phi|(P tensor Q)|phi>, input indices first. -/
noncomputable def matrixExpectation (φ : BipartiteState) (P Q : Matrix Idx Idx ℂ) : ℂ :=
  ∑ x, ∑ y, ∑ i, ∑ j, conj (φ i j) * P i x * Q j y * φ x y

theorem matrixExpectation_eq_inner (φ : BipartiteState) (P Q : Matrix Idx Idx ℂ) :
    matrixExpectation φ P Q =
      ∑ i, ∑ j, conj (φ i j) * localAction P Q φ i j := by
  have hs (f : Idx → Idx → Idx → Idx → ℂ) :
      (∑ x, ∑ y, ∑ i, ∑ j, f x y i j) = ∑ i, ∑ j, ∑ x, ∑ y, f x y i j := by
    calc
      _ = ∑ x, ∑ i, ∑ j, ∑ y, f x y i j := by
        apply Finset.sum_congr rfl
        intro x hx
        rw [Finset.sum_comm]
        apply Finset.sum_congr rfl
        intro i hi
        rw [Finset.sum_comm]
      _ = ∑ i, ∑ x, ∑ j, ∑ y, f x y i j := by rw [Finset.sum_comm]
      _ = _ := by
        apply Finset.sum_congr rfl
        intro i hi
        rw [Finset.sum_comm]
  unfold matrixExpectation localAction
  simp only [Finset.mul_sum]
  rw [hs]
  apply Finset.sum_congr rfl
  intro i hi
  apply Finset.sum_congr rfl
  intro j hj
  apply Finset.sum_congr rfl
  intro x hx
  apply Finset.sum_congr rfl
  intro y hy
  ring

theorem pauliExpectation_projective (φ : BipartiteState) (u v r s : Idx) :
    matrixExpectation φ (pauliMatrix u v) (pauliMatrix r s) =
      pauliPhase u v * pauliPhase r s * projectiveExpectation φ u v r s := by
  unfold matrixExpectation pauliMatrix projectiveExpectation
  simp only [mul_ite, mul_zero, ite_mul, zero_mul,
    Finset.sum_ite_eq', Finset.mem_univ, if_true, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i hi
  apply Finset.sum_congr rfl
  intro j hj
  ring

noncomputable def physicalHalfMoment (φ : BipartiteState) : ℝ :=
  (∑ u, ∑ v, ∑ r, ∑ s,
    ‖matrixExpectation φ (pauliMatrix u v) (pauliMatrix r s)‖) / 256

theorem physicalHalfMoment_eq (φ : BipartiteState) : physicalHalfMoment φ = halfMoment φ := by
  simp [physicalHalfMoment, pauliExpectation_projective, norm_mul, pauliPhase_norm, halfMoment]

noncomputable def physicalHalfEntropy (φ : BipartiteState) : ℝ :=
  2 * Real.log (physicalHalfMoment φ) / Real.log 2

theorem physicalHalfEntropy_eq (φ : BipartiteState) : physicalHalfEntropy φ = halfEntropy φ := by
  rw [physicalHalfEntropy, physicalHalfMoment_eq, halfEntropy]


/-- Both inverse equations are required; this is the usual finite matrix unitary condition. -/
noncomputable def IsUnitaryGate (U : Matrix Idx Idx ℂ) : Prop :=
  U.conjTranspose * U = 1 ∧ U * U.conjTranspose = 1

theorem swap_gate_unitary : IsUnitaryGate (permGate swap) := permGate_unitary swap

theorem physical_entropy_drop_exact :
    physicalHalfEntropy (psi sourceR) - physicalHalfEntropy (psi targetR) =
      2 * Real.log (13980 / 13979) / Real.log 2 := by
  simp only [physicalHalfEntropy_eq]
  exact entropy_drop_exact

theorem physical_counterexample_strict :
    physicalHalfEntropy (localAction (permGate swap) (permGate swap) (psi sourceR)) <
      physicalHalfEntropy (psi sourceR) := by
  simp only [physicalHalfEntropy_eq]
  exact counterexample_entropy_strict

/-- The half-order specialization of global optimality on the full local-unitary orbit.
    It uses the actual positive-phase Pauli matrices, normalized complex pure states,
    nonnegative sorted Schmidt amplitudes, and arbitrary local complex unitary gates. -/
noncomputable def HalfOrderReferenceOptimality : Prop :=
  ∀ a : Idx → ℝ, 0 < energyR a → (∀ i, 0 ≤ a i) →
    (∀ i j : Idx, i ≤ j → a j ≤ a i) →
    ∀ U V : Matrix Idx Idx ℂ, IsUnitaryGate U → IsUnitaryGate V →
      physicalHalfEntropy (psi a) ≤ physicalHalfEntropy (localAction U V (psi a))

theorem not_halfOrderReferenceOptimality : ¬ HalfOrderReferenceOptimality := by
  intro h
  have hs : ∀ i j : Idx, i ≤ j → sourceR j ≤ sourceR i := by
    intro i j hij
    unfold sourceR
    exact_mod_cast source_sorted i j hij
  have hle := h sourceR (by rw [sourceR_energy]; norm_num)
    (fun i => (sourceR_pos i).le) hs (permGate swap) (permGate swap)
    swap_gate_unitary swap_gate_unitary
  exact (not_le_of_gt physical_counterexample_strict) hle


end
end SchmidtHalf
-- END StateEntropy

-- BEGIN CertificateRows
set_option maxRecDepth 100000
set_option maxHeartbeats 0

namespace SchmidtHalf

/-- Each of the sixteen source rows in the manuscript's integer checksum table. -/
theorem source_row_sums :
    (fun u : Idx => ∑ v, |walsh source u v|) =
      ![5200, 4896, 4608, 4448, 4056, 3936, 3728, 3632,
        2960, 2912, 2808, 2768, 2568, 2528, 2456, 2416] := by
  funext u
  fin_cases u <;> decide +kernel

/-- Each of the sixteen permuted rows, with the same zero-based shift labels. -/
theorem target_row_sums :
    (fun u : Idx => ∑ v, |walsh target u v|) =
      ![5220, 4896, 4608, 4440, 4032, 3904, 3688, 3632,
        2988, 2932, 2800, 2744, 2596, 2548, 2468, 2420] := by
  funext u
  fin_cases u <;> decide +kernel

/-- The four masks index all projective Pauli labels on the bipartite system. -/
theorem full_pauli_label_count : Fintype.card (Idx × Idx × Idx × Idx) = 65536 := by
  simp only [Fintype.card_prod, Fintype.card_fin]

/-- Cardinality of the actual bipartite computational basis. -/
theorem bipartite_basis_count : Fintype.card (Idx × Idx) = 256 := by
  simp only [Fintype.card_prod, Fintype.card_fin]

end SchmidtHalf
-- END CertificateRows

-- BEGIN Robustness
namespace SchmidtHalf

theorem continuous_walshR (u v : Idx) :
    Continuous (fun a : Idx → ℝ => walshR a u v) := by
  unfold walshR
  fun_prop

theorem continuous_walshL1R : Continuous walshL1R := by
  unfold walshL1R
  apply continuous_finset_sum
  intro u hu
  apply continuous_finset_sum
  intro v hv
  exact (continuous_walshR u v).abs

theorem continuous_swap_amplitudes :
    Continuous (fun a : Idx → ℝ => fun i => a (swap i)) := by
  fun_prop

noncomputable def amplitudeWitnessSet : Set (Idx → ℝ) :=
  {a | (∀ i, 0 < a i) ∧
       (∀ i j, i < j → a j < a i) ∧
       walshL1R (fun i => a (swap i)) < walshL1R a}

theorem isOpen_positive_amplitudes :
    IsOpen {a : Idx → ℝ | ∀ i, 0 < a i} := by
  have heq : {a : Idx → ℝ | ∀ i, 0 < a i} =
      ⋂ i : Idx, {a : Idx → ℝ | 0 < a i} := by
    ext a
    simp
  rw [heq]
  exact isOpen_iInter_of_finite fun i =>
    isOpen_lt continuous_const (continuous_apply i)

theorem isOpen_strict_amplitudes :
    IsOpen {a : Idx → ℝ | ∀ i j, i < j → a j < a i} := by
  have heq : {a : Idx → ℝ | ∀ i j, i < j → a j < a i} =
      ⋂ i : Idx, ⋂ j : Idx, {a : Idx → ℝ | i < j → a j < a i} := by
    ext a
    simp
  rw [heq]
  apply isOpen_iInter_of_finite
  intro i
  apply isOpen_iInter_of_finite
  intro j
  by_cases hij : i < j
  · simpa only [hij, true_implies] using
      (isOpen_lt (continuous_apply j) (continuous_apply i))
  · simpa only [hij, false_implies, Set.setOf_true] using
      (isOpen_univ : IsOpen (Set.univ : Set (Idx → ℝ)))

theorem isOpen_amplitudeWitnessSet : IsOpen amplitudeWitnessSet := by
  have himprove : IsOpen {a : Idx → ℝ |
      walshL1R (fun i => a (swap i)) < walshL1R a} :=
    isOpen_lt (continuous_walshL1R.comp continuous_swap_amplitudes)
      continuous_walshL1R
  exact isOpen_positive_amplitudes.inter (isOpen_strict_amplitudes.inter himprove)

theorem sourceR_mem_amplitudeWitnessSet : sourceR ∈ amplitudeWitnessSet := by
  refine ⟨sourceR_pos, sourceR_strict, ?_⟩
  have hswap : (fun i => sourceR (swap i)) = targetR := by
    funext i
    exact (targetR_swap i).symm
  rw [hswap, sourceR_walshL1, targetR_walshL1]
  norm_num

theorem nonempty_open_amplitude_counterexamples :
    ∃ U : Set (Idx → ℝ), IsOpen U ∧ sourceR ∈ U ∧
      ∀ a ∈ U, (∀ i, 0 < a i) ∧
        (∀ i j, i < j → a j < a i) ∧
        walshL1R (fun i => a (swap i)) < walshL1R a := by
  exact ⟨amplitudeWitnessSet, isOpen_amplitudeWitnessSet,
    sourceR_mem_amplitudeWitnessSet, fun _ h => h⟩

theorem energyR_pos_of_all_pos (a : Idx → ℝ) (ha : ∀ i, 0 < a i) :
    0 < energyR a := by
  have hterm : 0 < a 0 * a 0 := mul_pos (ha 0) (ha 0)
  have hsum : a 0 * a 0 ≤ energyR a := by
    unfold energyR
    exact Finset.single_le_sum (fun i _ => mul_self_nonneg (a i)) (Finset.mem_univ 0)
  exact lt_of_lt_of_le hterm hsum

theorem open_family_entropy_counterexamples :
    ∃ U : Set (Idx → ℝ), IsOpen U ∧ sourceR ∈ U ∧
      ∀ a ∈ U, stateNormSq (psi a) = 1 ∧
        (∀ i, 0 < coeff a i) ∧
        (∀ i j, i < j → coeff a j < coeff a i) ∧
        halfEntropy (localAction (permGate swap) (permGate swap) (psi a)) <
          halfEntropy (psi a) := by
  refine ⟨amplitudeWitnessSet, isOpen_amplitudeWitnessSet,
    sourceR_mem_amplitudeWitnessSet, ?_⟩
  intro a ha
  have he := energyR_pos_of_all_pos a ha.1
  exact ⟨psi_normalized a he, coeff_pos a ha.1 he,
    coeff_strict_sorted a he ha.2.1,
    perm_entropy_lt_of_walsh a swap he ha.2.2⟩

end SchmidtHalf
-- END Robustness

-- BEGIN Claims
namespace SchmidtHalf
open scoped BigOperators

theorem source_probability_pos (i : Idx) : 0 < sourceR i * sourceR i / 2096 := by
  exact div_pos (mul_pos (sourceR_pos i) (sourceR_pos i)) (by norm_num)

theorem source_probability_strict (i j : Idx) (hij : i < j) :
    sourceR j * sourceR j / 2096 < sourceR i * sourceR i / 2096 := by
  apply (div_lt_div_iff_of_pos_right (show (0 : ℝ) < 2096 by norm_num)).2
  have hp := sourceR_pos i
  have hq := sourceR_pos j
  have hs := sourceR_strict i j hij
  nlinarith

theorem open_family_physical_counterexamples :
    ∃ U : Set (Idx → ℝ), IsOpen U ∧ sourceR ∈ U ∧
      ∀ a ∈ U, stateNormSq (psi a) = 1 ∧
        (∀ i, 0 < coeff a i) ∧
        (∀ i j, i < j → coeff a j < coeff a i) ∧
        physicalHalfEntropy (localAction (permGate swap) (permGate swap) (psi a)) <
          physicalHalfEntropy (psi a) := by
  simpa only [physicalHalfEntropy_eq] using open_family_entropy_counterexamples

theorem physical_pauli_sum_walsh (a : Idx → ℝ) (ha : 0 < energyR a) :
    (∑ u, ∑ v, ∑ r, ∑ s,
      ‖matrixExpectation (psi a) (pauliMatrix u v) (pauliMatrix r s)‖) =
      16 / energyR a * walshL1R a := by
  have h := halfMoment_walsh a ha
  rw [← physicalHalfMoment_eq, physicalHalfMoment] at h
  have h' := (div_eq_iff (show (256 : ℝ) ≠ 0 by norm_num)).mp h
  rw [h']
  field_simp [ne_of_gt ha]
  ring

end SchmidtHalf

namespace EDEGFormalization
open SchmidtHalf
open scoped BigOperators

theorem Example1 :
    ∃ a : Idx → ℝ, 0 < energyR a ∧ (∀ i, 0 < a i) ∧
      (∀ i j, i < j → a j < a i) ∧ stateNormSq (psi a) = 1 := by
  exact ⟨sourceR, by rw [sourceR_energy]; norm_num,
    sourceR_pos, sourceR_strict, source_normalized⟩

theorem Claim1 :
    stateNormSq (psi sourceR) = 1 ∧ stateNormSq (psi targetR) = 1 ∧
    (∀ i, 0 < sourceR i * sourceR i / 2096) ∧
    (∀ i j, i < j → sourceR j * sourceR j / 2096 < sourceR i * sourceR i / 2096) ∧
    IsUnitaryGate (permGate swap) ∧
    localAction (permGate swap) (permGate swap) (psi sourceR) = psi targetR ∧
    physicalHalfMoment (psi sourceR) = 13980 / 8384 ∧
    physicalHalfMoment (psi targetR) = 13979 / 8384 ∧
    physicalHalfEntropy (psi sourceR) - physicalHalfEntropy (psi targetR) =
      2 * Real.log (13980 / 13979) / Real.log 2 ∧
    0 < physicalHalfEntropy (psi sourceR) - physicalHalfEntropy (psi targetR) := by
  refine ⟨source_normalized, target_normalized, source_probability_pos,
    source_probability_strict, swap_gate_unitary, swap_psi, ?_, ?_,
    physical_entropy_drop_exact, ?_⟩
  · rw [physicalHalfMoment_eq]; exact source_halfMoment
  · rw [physicalHalfMoment_eq]; exact target_halfMoment
  · simpa only [physicalHalfEntropy_eq] using entropy_drop_positive

theorem Claim2 (a : Idx → ℝ) (ha : 0 < energyR a) :
    (∑ u, ∑ v, ∑ r, ∑ s,
      ‖matrixExpectation (psi a) (pauliMatrix u v) (pauliMatrix r s)‖) =
      16 / energyR a * walshL1R a ∧
    physicalHalfMoment (psi a) = walshL1R a / (16 * energyR a) := by
  refine ⟨physical_pauli_sum_walsh a ha, ?_⟩
  rw [physicalHalfMoment_eq]
  exact halfMoment_walsh a ha

theorem Claim3 :
    energy source = 2096 ∧ energy target = 2096 ∧
    walshL1 source = 55920 ∧ walshL1 target = 55916 ∧
    fullRawL1 source = 894720 ∧ fullRawL1 target = 894656 := by
  exact ⟨source_energy, target_energy, source_walshL1, target_walshL1,
    source_fullRawL1, target_fullRawL1⟩

theorem Claim4 :
    ∃ U : Set (Idx → ℝ), IsOpen U ∧ sourceR ∈ U ∧
      ∀ a ∈ U, stateNormSq (psi a) = 1 ∧
        (∀ i, 0 < coeff a i) ∧
        (∀ i j, i < j → coeff a j < coeff a i) ∧
        physicalHalfEntropy (localAction (permGate swap) (permGate swap) (psi a)) <
          physicalHalfEntropy (psi a) := open_family_physical_counterexamples

theorem Claim5 : ¬ HalfOrderReferenceOptimality := not_halfOrderReferenceOptimality

end EDEGFormalization
-- END Claims


-- Collect dependencies of all declarations created in this module, including compiler auxiliaries.
open Lean in
run_cmd do
  let env ← getEnv
  let mut entries : Array (String × Array String) := #[]
  for (name, _) in env.constants.map₂.toList do
    let axioms ← Lean.collectAxioms name
    entries := entries.push (name.toString, axioms.map Name.toString)
  logInfo m!"EDEG_KERNEL_AXIOMS: {(toJson entries).compress}"
