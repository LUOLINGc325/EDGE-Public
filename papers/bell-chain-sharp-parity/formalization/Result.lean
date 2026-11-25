import Lean
import Mathlib.Data.Complex.Norm
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity.Basic
import Mathlib.Tactic.Abel
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.EquivFin
import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise

-- Native execution; only endpoint wrappers use the canonical serializer.
-- No scope, kernel, hostile-review or publication pass is asserted by source generation.
-- Native snapshot seal SHA-256: d1248fd8a5cceb7c53caf2c5edc23d4c2153afea3b593ba52230dbfa32036f40
set_option autoImplicit false

/- Native source snapshot: Definitions.lean; SHA-256 aba3889384cd875d96472464f3f11210ea2f8c8270b2499fcda348f63378520a -/

/-!
Shared definitions for the Bell-chain manuscript blueprint.
These definitions contain no theorem claims or assumed conclusions.
-/

open scoped BigOperators

namespace BellChain

variable {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
variable {I : Type*} [Fintype I]

/-- Magnitude autocorrelation at a group displacement. -/
noncomputable def correlation (c : G → ℂ) (r : G) : ℝ :=
  ∑ x : G, ‖c x‖ * ‖c (x + r)‖

/-- Total autocorrelation on nonzero displacements. -/
noncomputable def correlationMass (c : G → ℂ) : ℝ :=
  ∑ r ∈ Finset.univ.erase (0 : G), correlation c r

/-- Product correlation of a finite collection of actual complex amplitudes. -/
noncomputable def correlationMoment (c : I → G → ℂ) : ℝ :=
  ∑ r ∈ Finset.univ.erase (0 : G), ∏ i : I, correlation (c i) r

/-- A nonzero difference realized by two nonzero amplitudes. -/
def nonzeroDifference (c : G → ℂ) (r : G) : Prop :=
  r ≠ 0 ∧ ∃ x : G, c x ≠ 0 ∧ c (x + r) ≠ 0

/-- A normalized two-point witness when the displacement is nonzero. -/
noncomputable def twoPoint (r : G) (x : G) : ℂ :=
  if x = 0 then (3 / 5 : ℂ) else if x = r then (4 / 5 : ℂ) else 0

end BellChain


/- Native source snapshot: BridgeDefinitions.lean; SHA-256 c07d8f24411ab718d641cd4f674cdf310c3eb7d3789dee1751a91ba4ececf65b -/

open scoped BigOperators

namespace BellChain

noncomputable def stateNormSq {G : Type*} [Fintype G] (v : G → ℂ) : ℝ :=
  ∑ k, ‖v k‖ ^ 2

noncomputable def el1 {G : Type*} [Fintype G] [DecidableEq G] (v : G → ℂ) : ℝ :=
  ∑ j, ∑ k, if j = k then 0 else ‖v j‖ * ‖v k‖

noncomputable def normalizeState {G : Type*} [Fintype G] (v : G → ℂ) : G → ℂ :=
  fun k => v k / (Real.sqrt (stateNormSq v) : ℂ)

noncomputable def weightedEl1 {G : Type*} [Fintype G] [DecidableEq G]
    (v : G → ℂ) : ℝ := stateNormSq v * el1 (normalizeState v)

def nextLabel {G : Type*} {n : ℕ} (x : Fin n → G) (k : G) (i : Fin n) : G :=
  if h : i.val + 1 < n then x ⟨i.val + 1, h⟩ else k

def localLabels {G : Type*} [AddGroup G] {n : ℕ} (s : Fin n → G) : Fin n → G :=
  fun i => s i - nextLabel s 0 i

noncomputable def bellPhase {d : ℕ} (q x : ZMod d) : ℂ :=
  Complex.exp (((-2 * Real.pi * (q.val : ℝ) * (x.val : ℝ) / (d : ℝ)) : ℂ) * Complex.I)

noncomputable def bellBra {d : ℕ} [NeZero d] (p q u v : ZMod d) : ℂ :=
  if u = p + v then (Real.sqrt (d : ℝ) : ℂ)⁻¹ * bellPhase q v else 0

noncomputable def rawCoefficient {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) (p q : Fin n → ZMod d) (k : ZMod d) : ℂ :=
  ∑ x : Fin n → ZMod d,
    c none k * ∏ i, c (some i) (x i) * bellBra (p i) (q i) (x i) (nextLabel x k i)

noncomputable def rawEndpoint {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) (p q : Fin n → ZMod d)
    (u k : ZMod d) : ℂ :=
  ∑ x : Fin n → ZMod d,
    if (if h : 0 < n then x ⟨0, h⟩ else k) = u then
      c none k * ∏ i, c (some i) (x i) * bellBra (p i) (q i) (x i) (nextLabel x k i)
    else 0

noncomputable def shiftCoefficient {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) (s q : Fin n → ZMod d) (k : ZMod d) : ℂ :=
  ((Real.sqrt (d : ℝ) : ℂ)⁻¹)^n * c none k *
    ∏ i, c (some i) (k + s i) * bellPhase (q i) (k + nextLabel s 0 i)

noncomputable def physicalAverage {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) : ℝ :=
  ∑ p : Fin n → ZMod d, ∑ q : Fin n → ZMod d,
    weightedEl1 (rawCoefficient c p q)

end BellChain


/- Native source snapshot: Bridge.lean; SHA-256 1fcd99538e69dc981d0c9c38e42e7bfff1ab07e151cbde0ccd9e6183a271cef6 -/

open scoped BigOperators

namespace BellChain

variable {G : Type*}

theorem stateNormSq_nonneg [Fintype G] [DecidableEq G] (v : G → ℂ) : 0 ≤ stateNormSq v := by
  exact Finset.sum_nonneg (fun _ _ => sq_nonneg _)

theorem stateNormSq_eq_zero_iff [Fintype G] [DecidableEq G] (v : G → ℂ) :
    stateNormSq v = 0 ↔ ∀ k, v k = 0 := by
  simp only [stateNormSq, Finset.sum_eq_zero_iff_of_nonneg (fun k _ => sq_nonneg ‖v k‖),
    Finset.mem_univ, forall_const, sq_eq_zero_iff, norm_eq_zero]

theorem weightedEl1_eq_el1 [Fintype G] [DecidableEq G] (v : G → ℂ) : weightedEl1 v = el1 v := by
  by_cases hz : stateNormSq v = 0
  · have hv := (stateNormSq_eq_zero_iff v).mp hz
    simp [weightedEl1, hz, el1, hv]
  · have hn : 0 ≤ stateNormSq v := stateNormSq_nonneg v
    have hs : 0 ≤ Real.sqrt (stateNormSq v) := Real.sqrt_nonneg _
    have hs0 : Real.sqrt (stateNormSq v) ≠ 0 := by
      intro h
      have hh := Real.sq_sqrt hn
      rw [h] at hh
      exact hz (by simpa using hh.symm)
    have hc : ‖(Real.sqrt (stateNormSq v) : ℂ)‖ = Real.sqrt (stateNormSq v) := by
      simp [Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hs]
    simp only [weightedEl1, el1, normalizeState, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro j _
    apply Finset.sum_congr rfl
    intro k _
    by_cases hjk : j = k
    · simp [hjk]
    · simp only [if_neg hjk, norm_div, hc]
      rw [div_mul_div_comm]
      rw [← pow_two, Real.sq_sqrt hn]
      field_simp [hz]

theorem bellPhase_norm {d : ℕ} (q x : ZMod d) : ‖bellPhase q x‖ = 1 := by
  simpa only [bellPhase, Complex.ofReal_div, Complex.ofReal_mul, Complex.ofReal_neg,
    Complex.ofReal_ofNat, Complex.ofReal_natCast] using
    Complex.norm_exp_ofReal_mul_I (-2 * Real.pi * (q.val : ℝ) * (x.val : ℝ) / (d : ℝ))

theorem nextLabel_translate [Fintype G] [DecidableEq G] [AddZeroClass G] {n : ℕ} (s : Fin n → G) (k : G) (i : Fin n) :
    nextLabel (fun j => k + s j) k i = k + nextLabel s 0 i := by
  unfold nextLabel
  split_ifs <;> simp

theorem chain_constraints_unique [Fintype G] [DecidableEq G] [AddCommGroup G] {n : ℕ}
    (s x : Fin n → G) (k : G)
    (h : ∀ i, x i = localLabels s i + nextLabel x k i) :
    x = fun i => k + s i := by
  have hdist : ∀ t : ℕ, ∀ i : Fin n, n ≤ i.val + t → x i = k + s i := by
    intro t
    induction t with
    | zero =>
        intro i hi
        have := i.isLt
        omega
    | succ t ih =>
        intro i hi
        by_cases hn : i.val + 1 < n
        · have hnxt := ih ⟨i.val + 1, hn⟩ (by simp only [Fin.val_mk]; omega)
          have he := h i
          simp only [localLabels, nextLabel, dif_pos hn] at he
          rw [hnxt] at he
          calc x i = s i - s ⟨i.val + 1, hn⟩ + (k + s ⟨i.val + 1, hn⟩) := he
               _ = k + s i := by abel
        · have he := h i
          simpa [localLabels, nextLabel, hn, add_comm] using he
  funext i
  exact hdist n i (by omega)

theorem localLabels_injective [Fintype G] [DecidableEq G] [AddCommGroup G] {n : ℕ} :
    Function.Injective (localLabels (G := G) (n := n)) := by
  intro x s h
  have hc : ∀ i, x i = localLabels s i + nextLabel x 0 i := by
    intro i
    have he := congrFun h i
    change x i - nextLabel x 0 i = localLabels s i at he
    calc x i = (x i - nextLabel x 0 i) + nextLabel x 0 i := (sub_add_cancel _ _).symm
         _ = localLabels s i + nextLabel x 0 i := by rw [he]
  simpa using chain_constraints_unique s x 0 hc

theorem localLabels_bijective [Fintype G] [DecidableEq G] [AddCommGroup G] {n : ℕ} :
    Function.Bijective (localLabels (G := G) (n := n)) := by
  exact Finite.injective_iff_bijective.mp localLabels_injective

theorem translated_contraction {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) (s q : Fin n → ZMod d) (k : ZMod d) :
    (c none k * ∏ i, c (some i) (k + s i) *
        bellBra (localLabels s i) (q i) (k + s i)
          (nextLabel (fun j => k + s j) k i)) = shiftCoefficient c s q k := by
  have hc : ∀ i, k + s i = localLabels s i + (k + nextLabel s 0 i) := by
    intro i
    dsimp [localLabels]
    abel
  simp only [nextLabel_translate, bellBra, if_pos (hc _), shiftCoefficient]
  have hp : (∏ i : Fin n,
      c (some i) (k + s i) *
        ((Real.sqrt (d : ℝ) : ℂ)⁻¹ * bellPhase (q i) (k + nextLabel s 0 i))) =
      ((Real.sqrt (d : ℝ) : ℂ)⁻¹)^n *
        ∏ i : Fin n, c (some i) (k + s i) * bellPhase (q i) (k + nextLabel s 0 i) := by
    calc
      _ = ∏ i : Fin n, ((Real.sqrt (d : ℝ) : ℂ)⁻¹) *
          (c (some i) (k + s i) * bellPhase (q i) (k + nextLabel s 0 i)) := by
            apply Finset.prod_congr rfl
            intro i _
            ring
      _ = _ := by rw [Finset.prod_mul_distrib]; simp
  rw [hp]
  ring

theorem off_assignment_contraction_zero {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) (s q x : Fin n → ZMod d) (k : ZMod d)
    (hx : x ≠ fun i => k + s i) :
    c none k * ∏ i, c (some i) (x i) *
      bellBra (localLabels s i) (q i) (x i) (nextLabel x k i) = 0 := by
  have hn : ¬ ∀ i, x i = localLabels s i + nextLabel x k i := by
    intro h
    exact hx (chain_constraints_unique s x k h)
  push_neg at hn
  obtain ⟨i, hi⟩ := hn
  have hp : (∏ j, c (some j) (x j) *
      bellBra (localLabels s j) (q j) (x j) (nextLabel x k j)) = 0 := by
    apply Finset.prod_eq_zero (Finset.mem_univ i)
    simp [bellBra, hi]
  rw [hp, mul_zero]

theorem rawCoefficient_eq_shift {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) (s q : Fin n → ZMod d) (k : ZMod d) :
    rawCoefficient c (localLabels s) q k = shiftCoefficient c s q k := by
  unfold rawCoefficient
  rw [Finset.sum_eq_single (fun i => k + s i)]
  · exact translated_contraction c s q k
  · intro x _ hx
    exact off_assignment_contraction_zero c s q x k hx
  · simp

theorem rawEndpoint_eq_shift {d n : ℕ} [NeZero d]
    (hn : 0 < n) (c : Option (Fin n) → ZMod d → ℂ)
    (s q : Fin n → ZMod d) (u k : ZMod d) :
    rawEndpoint c (localLabels s) q u k =
      if k + s ⟨0, hn⟩ = u then shiftCoefficient c s q k else 0 := by
  unfold rawEndpoint
  rw [Finset.sum_eq_single (fun i => k + s i)]
  · simp only [dif_pos hn]
    split_ifs
    · exact translated_contraction c s q k
    · rfl
  · intro x _ hx
    split_ifs
    · exact off_assignment_contraction_zero c s q x k hx
    · rfl
  · simp

theorem rawEndpoint_normSq {d n : ℕ} [NeZero d]
    (hn : 0 < n) (c : Option (Fin n) → ZMod d → ℂ)
    (s q : Fin n → ZMod d) :
    (∑ u, ∑ k, ‖rawEndpoint c (localLabels s) q u k‖ ^ 2) =
      stateNormSq (rawCoefficient c (localLabels s) q) := by
  rw [show rawCoefficient c (localLabels s) q = shiftCoefficient c s q from
    funext (rawCoefficient_eq_shift c s q)]
  simp_rw [rawEndpoint_eq_shift hn]
  rw [Finset.sum_comm]
  simp [stateNormSq, apply_ite]

theorem endpointPairing_bijective [Fintype G] [DecidableEq G] [AddCommGroup G] (a : G) :
    Function.Bijective (fun k : G => k + a) :=
  (Equiv.addRight a).bijective

theorem sum_excluding_zero [Fintype G] [DecidableEq G] [Zero G] (f : G → ℝ) :
    (∑ r, if r = 0 then 0 else f r) = ∑ r ∈ Finset.univ.erase (0 : G), f r := by
  have h := Finset.sum_erase_add Finset.univ (fun r => if r = 0 then 0 else f r)
    (Finset.mem_univ (0 : G))
  simp only [ite_true, add_zero] at h
  rw [← h]
  apply Finset.sum_congr rfl
  intro r hr
  exact if_neg (Finset.mem_erase.mp hr).1

theorem el1_eq_correlationMass [Fintype G] [DecidableEq G] [AddCommGroup G] (c : G → ℂ) :
    el1 c = correlationMass c := by
  unfold el1 correlationMass correlation
  have hre : ∀ x : G,
      (∑ y, if x = y then 0 else ‖c x‖ * ‖c y‖) =
      ∑ r, if r = 0 then 0 else ‖c x‖ * ‖c (x + r)‖ := by
    intro x
    symm
    apply Fintype.sum_equiv (Equiv.addLeft x)
    intro r
    simp [add_eq_left]
  simp_rw [hre, sum_excluding_zero]
  exact Finset.sum_comm

theorem sum_translate_product [Fintype G] [DecidableEq G] [AddCommGroup G]
    {I : Type*} [Fintype I] [DecidableEq I] (f : I → G → ℝ) (k : G) :
    (∑ s : I → G, ∏ i, f i (k + s i)) = ∏ i, ∑ x, f i x := by
  classical
  rw [← Fintype.prod_sum (fun i x => f i (k + x))]
  apply Finset.prod_congr rfl
  intro i _
  exact Equiv.sum_comp (Equiv.addLeft k) (f i)

theorem sum_shift_families [Fintype G] [DecidableEq G] [AddCommGroup G]
    {I : Type*} [Fintype I] [DecidableEq I] (f : Option I → G → ℝ) :
    (∑ s : I → G, ∑ k, f none k * ∏ i, f (some i) (k + s i)) =
      ∏ i : Option I, ∑ x, f i x := by
  classical
  rw [Finset.sum_comm]
  simp_rw [← Finset.mul_sum, sum_translate_product]
  rw [← Finset.sum_mul]
  simp [Fintype.prod_option]

theorem norm_shiftCoefficient {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ)
    (s q : Fin n → ZMod d) (k : ZMod d) :
    ‖shiftCoefficient c s q k‖ =
      (Real.sqrt (d : ℝ))⁻¹ ^ n * ‖c none k‖ * ∏ i, ‖c (some i) (k + s i)‖ := by
  simp [shiftCoefficient, norm_mul, norm_prod, norm_pow, norm_inv, bellPhase_norm,
    Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _)]

theorem norm_shiftCoefficient_pair {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ)
    (s q : Fin n → ZMod d) (j k : ZMod d) :
    ‖shiftCoefficient c s q j‖ * ‖shiftCoefficient c s q k‖ =
      ((d : ℝ)^n)⁻¹ * (‖c none j‖ * ‖c none k‖ *
        ∏ i, ‖c (some i) (j + s i)‖ * ‖c (some i) (k + s i)‖) := by
  have hd : 0 ≤ (d : ℝ) := Nat.cast_nonneg d
  have hh : ((Real.sqrt (d : ℝ))⁻¹ ^ n) * ((Real.sqrt (d : ℝ))⁻¹ ^ n) =
      ((d : ℝ)^n)⁻¹ := by
    rw [← mul_pow, ← pow_two, inv_pow, Real.sq_sqrt hd, inv_pow]
  rw [norm_shiftCoefficient, norm_shiftCoefficient, Finset.prod_mul_distrib]
  calc
    _ = (((Real.sqrt (d : ℝ))⁻¹ ^ n) * ((Real.sqrt (d : ℝ))⁻¹ ^ n)) *
        (‖c none j‖ * ‖c none k‖ *
          ((∏ i, ‖c (some i) (j + s i)‖) * ∏ i, ‖c (some i) (k + s i)‖)) := by ring
    _ = _ := by rw [hh]

theorem shift_ent_sum_phase {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) (s : Fin n → ZMod d) :
    (∑ q : Fin n → ZMod d, el1 (shiftCoefficient c s q)) =
      ∑ j, ∑ k, if j = k then 0 else
        ‖c none j‖ * ‖c none k‖ *
          ∏ i, ‖c (some i) (j + s i)‖ * ‖c (some i) (k + s i)‖ := by
  have hd0 : (d : ℝ) ≠ 0 := by exact_mod_cast (NeZero.ne d)
  have he : ∀ q : Fin n → ZMod d, el1 (shiftCoefficient c s q) =
      ((d : ℝ)^n)⁻¹ *
        (∑ j, ∑ k, if j = k then 0 else
          ‖c none j‖ * ‖c none k‖ *
            ∏ i, ‖c (some i) (j + s i)‖ * ‖c (some i) (k + s i)‖) := by
    intro q
    unfold el1
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro j _
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro k _
    split_ifs
    · simp
    · exact norm_shiftCoefficient_pair c s q j k
  simp_rw [he]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fun, Fintype.card_fin,
    ZMod.card, nsmul_eq_mul, Nat.cast_pow]
  rw [← mul_assoc, mul_inv_cancel₀ (pow_ne_zero _ hd0), one_mul]

theorem shift_normSq_sum_phase {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) (s : Fin n → ZMod d) :
    (∑ q : Fin n → ZMod d, stateNormSq (shiftCoefficient c s q)) =
      ∑ k, ‖c none k‖ ^ 2 * ∏ i, ‖c (some i) (k + s i)‖ ^ 2 := by
  have hd0 : (d : ℝ) ≠ 0 := by exact_mod_cast (NeZero.ne d)
  have he : ∀ q : Fin n → ZMod d, stateNormSq (shiftCoefficient c s q) =
      ((d : ℝ)^n)⁻¹ * (∑ k, ‖c none k‖ ^ 2 * ∏ i, ‖c (some i) (k + s i)‖ ^ 2) := by
    intro q
    unfold stateNormSq
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro k _
    simpa only [pow_two, Finset.prod_mul_distrib] using norm_shiftCoefficient_pair c s q k k
  simp_rw [he]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fun, Fintype.card_fin,
    ZMod.card, nsmul_eq_mul, Nat.cast_pow]
  rw [← mul_assoc, mul_inv_cancel₀ (pow_ne_zero _ hd0), one_mul]

theorem all_outcome_probabilities {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) :
    (∑ p : Fin n → ZMod d, ∑ q : Fin n → ZMod d,
      stateNormSq (rawCoefficient c p q)) = ∏ i, stateNormSq (c i) := by
  rw [← (localLabels_bijective (G := ZMod d) (n := n)).sum_comp
    (fun p => ∑ q : Fin n → ZMod d, stateNormSq (rawCoefficient c p q))]
  have hraw : ∀ s q, rawCoefficient c (localLabels s) q = shiftCoefficient c s q :=
    fun s q => funext (rawCoefficient_eq_shift c s q)
  simp_rw [hraw, shift_normSq_sum_phase]
  exact sum_shift_families (fun i k => ‖c i k‖ ^ 2)

theorem all_outcome_probabilities_one {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) (hc : ∀ i, stateNormSq (c i) = 1) :
    (∑ p : Fin n → ZMod d, ∑ q : Fin n → ZMod d,
      stateNormSq (rawCoefficient c p q)) = 1 := by
  rw [all_outcome_probabilities]
  simp [hc]

theorem all_endpoint_probabilities {d n : ℕ} [NeZero d]
    (hn : 0 < n) (c : Option (Fin n) → ZMod d → ℂ) :
    (∑ p : Fin n → ZMod d, ∑ q : Fin n → ZMod d,
      ∑ u, ∑ k, ‖rawEndpoint c p q u k‖ ^ 2) = ∏ i, stateNormSq (c i) := by
  rw [← (localLabels_bijective (G := ZMod d) (n := n)).sum_comp
    (fun p => ∑ q : Fin n → ZMod d, ∑ u, ∑ k, ‖rawEndpoint c p q u k‖ ^ 2)]
  simp_rw [rawEndpoint_normSq hn]
  rw [(localLabels_bijective (G := ZMod d) (n := n)).sum_comp
    (fun p => ∑ q : Fin n → ZMod d, stateNormSq (rawCoefficient c p q))]
  exact all_outcome_probabilities c

theorem all_endpoint_probabilities_one {d n : ℕ} [NeZero d]
    (hn : 0 < n) (c : Option (Fin n) → ZMod d → ℂ)
    (hc : ∀ i, stateNormSq (c i) = 1) :
    (∑ p : Fin n → ZMod d, ∑ q : Fin n → ZMod d,
      ∑ u, ∑ k, ‖rawEndpoint c p q u k‖ ^ 2) = 1 := by
  rw [all_endpoint_probabilities hn]
  simp [hc]

theorem offdiag_shift_factorization [Fintype G] [DecidableEq G] [AddCommGroup G]
    {I : Type*} [Fintype I] [DecidableEq I] (f : Option I → G → ℝ) :
    (∑ s : I → G, ∑ j, ∑ k, if j = k then 0 else
      f none j * f none k * ∏ i, f (some i) (j + s i) * f (some i) (k + s i)) =
      ∑ r ∈ Finset.univ.erase (0 : G),
        ∏ i : Option I, ∑ x, f i x * f i (x + r) := by
  classical
  have hre : ∀ (s : I → G) (j : G),
      (∑ k, if j = k then 0 else
        f none j * f none k * ∏ i, f (some i) (j + s i) * f (some i) (k + s i)) =
      ∑ r ∈ Finset.univ.erase (0 : G),
        f none j * f none (j + r) *
          ∏ i, f (some i) (j + s i) * f (some i) (j + s i + r) := by
    intro s j
    calc
      _ = ∑ r, if r = 0 then 0 else
          f none j * f none (j + r) *
            ∏ i, f (some i) (j + s i) * f (some i) (j + s i + r) := by
        symm
        apply Fintype.sum_equiv (Equiv.addLeft j)
        intro r
        simp [add_eq_left, add_assoc, add_left_comm, add_comm]
      _ = _ := sum_excluding_zero _
  simp_rw [hre]
  calc
    _ = ∑ s : I → G, ∑ r ∈ Finset.univ.erase (0 : G), ∑ j,
        f none j * f none (j + r) *
          ∏ i, f (some i) (j + s i) * f (some i) (j + s i + r) := by
      apply Finset.sum_congr rfl
      intro s _
      exact Finset.sum_comm
    _ = ∑ r ∈ Finset.univ.erase (0 : G), ∑ s : I → G, ∑ j,
        f none j * f none (j + r) *
          ∏ i, f (some i) (j + s i) * f (some i) (j + s i + r) := Finset.sum_comm
    _ = _ := by
      apply Finset.sum_congr rfl
      intro r _
      exact sum_shift_families (fun i x => f i x * f i (x + r))

theorem physicalAverage_eq_correlationMoment {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) :
    physicalAverage c = correlationMoment c := by
  unfold physicalAverage
  rw [← (localLabels_bijective (G := ZMod d) (n := n)).sum_comp
    (fun p => ∑ q : Fin n → ZMod d, weightedEl1 (rawCoefficient c p q))]
  have hraw : ∀ s q, rawCoefficient c (localLabels s) q = shiftCoefficient c s q :=
    fun s q => funext (rawCoefficient_eq_shift c s q)
  simp_rw [hraw, weightedEl1_eq_el1, shift_ent_sum_phase]
  exact offdiag_shift_factorization (fun i x => ‖c i x‖)

end BellChain


/- Native source snapshot: Bounds.lean; SHA-256 61dadc04605a86ff9c5a0f6c720af437def513e030164b02a743ba0a0b38e687 -/

open scoped BigOperators

namespace BellChain


theorem correlation_nonneg
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G] (c : G → ℂ) (r : G) :
    0 ≤ correlation c r := by
  exact Finset.sum_nonneg fun x _ => mul_nonneg (norm_nonneg _) (norm_nonneg _)

theorem correlation_neg
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G] (c : G → ℂ) (r : G) :
    correlation c (-r) = correlation c r := by
  unfold correlation
  calc
    (∑ x : G, ‖c x‖ * ‖c (x + -r)‖) =
        ∑ x : G, ‖c (x + r)‖ * ‖c ((x + r) + -r)‖ := by
          symm
          exact Equiv.sum_comp (Equiv.addRight r) (fun x : G => ‖c x‖ * ‖c (x + -r)‖)
    _ = ∑ x : G, ‖c x‖ * ‖c (x + r)‖ := by
      apply Finset.sum_congr rfl
      intro x _
      simp [add_assoc, mul_comm]

private theorem sum_pos_iff_exists {R : Type*} (s : Finset R) (f : R → ℝ)
    (hf : ∀ r ∈ s, 0 ≤ f r) :
    0 < ∑ r ∈ s, f r ↔ ∃ r ∈ s, 0 < f r := by
  constructor
  · intro hp
    by_contra hn
    have hz : ∀ r ∈ s, f r = 0 := by
      intro r hr
      exact le_antisymm (le_of_not_gt fun h => hn ⟨r, hr, h⟩) (hf r hr)
    have hs : ∑ r ∈ s, f r = 0 := Finset.sum_eq_zero hz
    exact (ne_of_gt hp) hs
  · rintro ⟨r, hr, hp⟩
    exact hp.trans_le (Finset.single_le_sum hf hr)

theorem correlation_pos_iff
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G] (c : G → ℂ) (r : G) :
    0 < correlation c r ↔ ∃ x : G, c x ≠ 0 ∧ c (x + r) ≠ 0 := by
  unfold correlation
  rw [sum_pos_iff_exists _ _ (fun x _ => mul_nonneg (norm_nonneg _) (norm_nonneg _))]
  constructor
  · rintro ⟨x, _, hx⟩
    refine ⟨x, ?_, ?_⟩
    · intro hz
      simp [hz] at hx
    · intro hz
      simp [hz] at hx
  · rintro ⟨x, hx, hxr⟩
    exact ⟨x, Finset.mem_univ _, mul_pos (norm_pos_iff.mpr hx) (norm_pos_iff.mpr hxr)⟩

theorem nonzeroDifference_iff
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G] (c : G → ℂ) (r : G) :
    nonzeroDifference c r ↔ r ≠ 0 ∧ 0 < correlation c r := by
  simp only [nonzeroDifference, correlation_pos_iff]

theorem correlationMass_nonneg
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G] (c : G → ℂ) :
    0 ≤ correlationMass c := by
  exact Finset.sum_nonneg fun r _ => correlation_nonneg c r

theorem correlationMoment_nonneg
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
    {I : Type*} [Fintype I] [DecidableEq I] (c : I → G → ℂ) :
    0 ≤ correlationMoment c := by
  exact Finset.sum_nonneg fun r _ =>
    Finset.prod_nonneg fun i _ => correlation_nonneg (c i) r

private theorem profile_term_le
    {I : Type*} [Fintype I] [DecidableEq I] {R : Type*}
    (s : Finset R) (f : I → R → ℝ) (M : I → ℝ) (b : ℝ)
    (hf : ∀ i r, r ∈ s → 0 ≤ f i r)
    (hcap : ∀ i r, r ∈ s → f i r ≤ b * M i)
    (j : I) (r : R) (hr : r ∈ s) :
    (∏ i : I, f i r) ≤
      f j r * (b ^ (Fintype.card I - 1) * ∏ i ∈ Finset.univ.erase j, M i) := by
  classical
  rw [← Finset.mul_prod_erase Finset.univ (fun i => f i r) (Finset.mem_univ j)]
  apply mul_le_mul_of_nonneg_left _ (hf j r hr)
  calc
    (∏ i ∈ Finset.univ.erase j, f i r) ≤
        ∏ i ∈ Finset.univ.erase j, b * M i := by
      exact Finset.prod_le_prod (fun i _ => hf i r hr) (fun i _ => hcap i r hr)
    _ = b ^ (Fintype.card I - 1) * ∏ i ∈ Finset.univ.erase j, M i := by
      rw [Finset.prod_mul_distrib, Finset.prod_const]
      simp

private theorem profile_upper_sum
    {I : Type*} [Fintype I] [DecidableEq I] {R : Type*}
    (s : Finset R) (f : I → R → ℝ) (M : I → ℝ) (b : ℝ)
    (hmass : ∀ i, ∑ r ∈ s, f i r = M i) (j : I) :
    (∑ r ∈ s, f j r *
      (b ^ (Fintype.card I - 1) * ∏ i ∈ Finset.univ.erase j, M i)) =
      b ^ (Fintype.card I - 1) * ∏ i : I, M i := by
  classical
  rw [← Finset.sum_mul, hmass]
  calc
    M j * (b ^ (Fintype.card I - 1) * ∏ i ∈ Finset.univ.erase j, M i) =
        b ^ (Fintype.card I - 1) * (M j * ∏ i ∈ Finset.univ.erase j, M i) := by rw [mul_left_comm]
    _ = b ^ (Fintype.card I - 1) * ∏ i : I, M i := by
      rw [Finset.mul_prod_erase _ _ (Finset.mem_univ j)]

private theorem profile_bound
    {I : Type*} [Fintype I] [DecidableEq I] {R : Type*}
    (s : Finset R) (f : I → R → ℝ) (M : I → ℝ) (b : ℝ)
    (hf : ∀ i r, r ∈ s → 0 ≤ f i r)
    (hmass : ∀ i, ∑ r ∈ s, f i r = M i)
    (hcap : ∀ i r, r ∈ s → f i r ≤ b * M i)
    (j : I) :
    (∑ r ∈ s, ∏ i : I, f i r) ≤ b ^ (Fintype.card I - 1) * ∏ i : I, M i := by
  classical
  calc
    (∑ r ∈ s, ∏ i : I, f i r) ≤
        ∑ r ∈ s, f j r *
          (b ^ (Fintype.card I - 1) * ∏ i ∈ Finset.univ.erase j, M i) :=
      Finset.sum_le_sum fun r hr => profile_term_le s f M b hf hcap j r hr
    _ = b ^ (Fintype.card I - 1) * ∏ i : I, M i :=
      profile_upper_sum s f M b hmass j

private theorem profile_saturation
    {I : Type*} [Fintype I] [DecidableEq I] {R : Type*}
    (s : Finset R) (f : I → R → ℝ) (M : I → ℝ) (b : ℝ)
    (hf : ∀ i r, r ∈ s → 0 ≤ f i r)
    (hmass : ∀ i, ∑ r ∈ s, f i r = M i)
    (hcap : ∀ i r, r ∈ s → f i r ≤ b * M i)
    (hI : 2 ≤ Fintype.card I)
    (heq : (∑ r ∈ s, ∏ i : I, f i r) =
      b ^ (Fintype.card I - 1) * ∏ i : I, M i)
    (r : R) (hr : r ∈ s) (hpos : ∀ i : I, 0 < f i r) :
    ∀ i : I, f i r = b * M i := by
  classical
  letI : Nontrivial I := Fintype.one_lt_card_iff_nontrivial.mp hI
  intro i
  obtain ⟨j, hji⟩ := exists_ne i
  have hle := fun x hx => profile_term_le s f M b hf hcap j x hx
  have hsum : (∑ x ∈ s, ∏ k : I, f k x) =
      ∑ x ∈ s, f j x *
        (b ^ (Fintype.card I - 1) * ∏ k ∈ Finset.univ.erase j, M k) := by
    rw [profile_upper_sum s f M b hmass j]
    exact heq
  have hterm := (Finset.sum_eq_sum_iff_of_le hle).mp hsum r hr
  rw [← Finset.mul_prod_erase Finset.univ (fun k => f k r) (Finset.mem_univ j)] at hterm
  have hprod : (∏ k ∈ Finset.univ.erase j, f k r) =
      ∏ k ∈ Finset.univ.erase j, b * M k := by
    have hh := mul_left_cancel₀ (ne_of_gt (hpos j)) hterm
    rw [Finset.prod_mul_distrib, Finset.prod_const]
    simpa using hh
  rcases (hcap i r hr).eq_or_lt with he | hl
  · exact he
  · have hlt : (∏ k ∈ Finset.univ.erase j, f k r) <
        ∏ k ∈ Finset.univ.erase j, b * M k := by
      apply Finset.prod_lt_prod
        (fun k _ => hpos k) (fun k _ => hcap k r hr)
      exact ⟨i, by simp [Ne.symm hji], hl⟩
    exact False.elim (ne_of_lt hlt hprod)

private theorem support_of_subsum_eq {R : Type*} [DecidableEq R]
    (s t : Finset R) (f : R → ℝ) (hsub : t ⊆ s)
    (hf : ∀ r ∈ s, 0 ≤ f r)
    (hsum : ∑ r ∈ t, f r = ∑ r ∈ s, f r) :
    ∀ r ∈ s, r ∉ t → f r = 0 := by
  intro r hr hrt
  have hfilter : s.filter (fun x => x ∈ t) = t := by
    ext x
    simp only [Finset.mem_filter]
    exact ⟨And.right, fun hx => ⟨hsub hx, hx⟩⟩
  have heq : (∑ x ∈ s, if x ∈ t then f x else 0) = ∑ x ∈ s, f x := by
    rw [← Finset.sum_filter, hfilter]
    exact hsum
  have hle : ∀ x ∈ s, (if x ∈ t then f x else 0) ≤ f x := by
    intro x hx
    split_ifs
    · exact le_refl _
    · exact hf x hx
  have hh := (Finset.sum_eq_sum_iff_of_le hle).mp heq r hr
  simpa [hrt] using hh.symm

theorem correlation_le_mass
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G] (c : G → ℂ) (r : G) (hr : r ≠ 0) :
    correlation c r ≤ correlationMass c := by
  exact Finset.single_le_sum (fun s _ => correlation_nonneg c s) (by simp [hr])

theorem correlation_le_half_mass
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G] (c : G → ℂ)
    (hno : ∀ r : G, r ≠ 0 → r ≠ -r) (r : G) (hr : r ≠ 0) :
    correlation c r ≤ (1 / 2 : ℝ) * correlationMass c := by
  have hp : ({r, -r} : Finset G) ⊆ Finset.univ.erase 0 := by
    intro x hx
    simp only [Finset.mem_insert, Finset.mem_singleton] at hx
    rcases hx with rfl | rfl <;> simp [hr]
  have hh : correlation c r + correlation c (-r) ≤ correlationMass c := by
    calc
      correlation c r + correlation c (-r) =
          ∑ x ∈ ({r, -r} : Finset G), correlation c x := by simp [hno r hr]
      _ ≤ ∑ x ∈ Finset.univ.erase (0 : G), correlation c x :=
        Finset.sum_le_sum_of_subset_of_nonneg hp (fun x _ _ => correlation_nonneg c x)
  rw [correlation_neg] at hh
  have hd : correlation c r ≤ correlationMass c / 2 :=
    (le_div_iff₀ (zero_lt_two : (0 : ℝ) < 2)).mpr (by simpa [mul_two] using hh)
  simpa [div_eq_mul_inv, mul_comm] using hd

theorem correlationMoment_le_product
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
    {I : Type*} [Fintype I] [DecidableEq I]
    (c : I → G → ℂ) (hI : 2 ≤ Fintype.card I) :
    correlationMoment c ≤ ∏ i : I, correlationMass (c i) := by
  classical
  letI : Nontrivial I := Fintype.one_lt_card_iff_nontrivial.mp hI
  let j : I := Classical.arbitrary I
  have h := profile_bound (Finset.univ.erase (0 : G))
    (fun i r => correlation (c i) r) (fun i => correlationMass (c i)) 1
    (fun i r _ => correlation_nonneg (c i) r) (fun _ => rfl)
    (fun i r hr => by simpa using correlation_le_mass (c i) r (Finset.mem_erase.mp hr).1) j
  simpa [correlationMoment] using h

theorem correlationMoment_le_half_power
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
    {I : Type*} [Fintype I] [DecidableEq I]
    (c : I → G → ℂ) (hI : 2 ≤ Fintype.card I)
    (hno : ∀ r : G, r ≠ 0 → r ≠ -r) :
    correlationMoment c ≤
      (1 / 2 : ℝ) ^ (Fintype.card I - 1) *
        ∏ i : I, correlationMass (c i) := by
  classical
  letI : Nontrivial I := Fintype.one_lt_card_iff_nontrivial.mp hI
  let j : I := Classical.arbitrary I
  exact profile_bound (Finset.univ.erase (0 : G))
    (fun i r => correlation (c i) r) (fun i => correlationMass (c i)) (1 / 2)
    (fun i r _ => correlation_nonneg (c i) r) (fun _ => rfl)
    (fun i r hr => correlation_le_half_mass (c i) hno r (Finset.mem_erase.mp hr).1) j

private theorem positive_factors
    {I : Type*} [Fintype I] [DecidableEq I] (u : I → ℝ) (hn : ∀ i, 0 ≤ u i)
    (hp : 0 < ∏ i : I, u i) : ∀ i, 0 < u i := by
  intro i
  have hne : u i ≠ 0 := (Finset.prod_ne_zero_iff.mp (ne_of_gt hp)) i (Finset.mem_univ i)
  exact lt_of_le_of_ne (hn i) (Ne.symm hne)

private theorem correlation_zero_of_not_difference
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G] (c : G → ℂ) (r : G)
    (hr : r ≠ 0) (hn : ¬ nonzeroDifference c r) : correlation c r = 0 := by
  apply le_antisymm _ (correlation_nonneg c r)
  apply le_of_not_gt
  intro hp
  exact hn ((nonzeroDifference_iff c r).mpr ⟨hr, hp⟩)

theorem correlationMoment_eq_zero_of_mass_eq_zero
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
    {I : Type*} [Fintype I] [DecidableEq I]
    (c : I → G → ℂ) (i : I) (hi : correlationMass (c i) = 0) :
    correlationMoment c = 0 := by
  classical
  change (∑ r ∈ Finset.univ.erase (0 : G), correlation (c i) r) = 0 at hi
  have hz := (Finset.sum_eq_zero_iff_of_nonneg
    (fun r _ => correlation_nonneg (c i) r)).mp hi
  apply Finset.sum_eq_zero
  intro r hr
  exact Finset.prod_eq_zero_iff.mpr ⟨i, Finset.mem_univ i, hz r hr⟩

theorem correlationMoment_eq_zero_iff
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
    {I : Type*} [Fintype I] [DecidableEq I]
    (c : I → G → ℂ) :
    correlationMoment c = 0 ↔
      ¬ ∃ r : G, r ≠ 0 ∧
        ∀ i : I, ∃ x : G, c i x ≠ 0 ∧ c i (x + r) ≠ 0 := by
  classical
  change (∑ r ∈ Finset.univ.erase (0 : G), ∏ i : I, correlation (c i) r) = 0 ↔ _
  rw [Finset.sum_eq_zero_iff_of_nonneg
    (fun r _ => Finset.prod_nonneg (fun i _ => correlation_nonneg (c i) r))]
  constructor
  · intro hz
    rintro ⟨r, hr, hall⟩
    have hp : 0 < ∏ i : I, correlation (c i) r :=
      Finset.prod_pos (fun i _ => (correlation_pos_iff (c i) r).mpr (hall i))
    exact (ne_of_gt hp) (hz r (by simp [hr]))
  · intro h r hr
    by_contra hn
    have hall : ∀ i, 0 < correlation (c i) r := by
      intro i
      have hi : correlation (c i) r ≠ 0 :=
        (Finset.prod_ne_zero_iff.mp hn) i (Finset.mem_univ i)
      exact lt_of_le_of_ne (correlation_nonneg (c i) r) (Ne.symm hi)
    exact h ⟨r, (Finset.mem_erase.mp hr).1,
      fun i => (correlation_pos_iff (c i) r).mp (hall i)⟩

theorem correlationMoment_eq_product_iff
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
    {I : Type*} [Fintype I] [DecidableEq I]
    (c : I → G → ℂ) (hI : 2 ≤ Fintype.card I)
    (hpos : ∀ i : I, 0 < correlationMass (c i)) :
    correlationMoment c = ∏ i : I, correlationMass (c i) ↔
      ∃ r : G, r ≠ 0 ∧ -r = r ∧
        ∀ (i : I) (s : G), nonzeroDifference (c i) s ↔ s = r := by
  classical
  letI : Nontrivial I := Fintype.one_lt_card_iff_nontrivial.mp hI
  let j : I := Classical.arbitrary I
  constructor
  · intro heq
    have hp : 0 < correlationMoment c := heq.symm ▸ Finset.prod_pos (fun i _ => hpos i)
    obtain ⟨r, hr, hprod⟩ := (sum_pos_iff_exists (Finset.univ.erase (0 : G))
      (fun s => ∏ i : I, correlation (c i) s)
      (fun s _ => Finset.prod_nonneg (fun i _ => correlation_nonneg (c i) s))).mp hp
    have hr0 : r ≠ 0 := (Finset.mem_erase.mp hr).1
    have hpr : ∀ i : I, 0 < correlation (c i) r :=
      positive_factors (fun i => correlation (c i) r) (fun i => correlation_nonneg (c i) r) hprod
    have hs : ∀ i : I, correlation (c i) r = correlationMass (c i) := by
      have hh := profile_saturation (Finset.univ.erase (0 : G))
        (fun i s => correlation (c i) s) (fun i => correlationMass (c i)) 1
        (fun i s _ => correlation_nonneg (c i) s) (fun _ => rfl)
        (fun i s hs => by simpa using correlation_le_mass (c i) s (Finset.mem_erase.mp hs).1)
        hI (by simpa [correlationMoment] using heq) r hr hpr
      simpa using hh
    have hsupport : ∀ (i : I) (s : G), nonzeroDifference (c i) s ↔ s = r := by
      intro i s
      constructor
      · intro hd
        by_contra hsr
        have hzero : correlation (c i) s = 0 := support_of_subsum_eq
          (Finset.univ.erase (0 : G)) {r} (correlation (c i))
          (by simpa using hr) (fun x _ => correlation_nonneg (c i) x)
          (by simpa [correlationMass] using hs i) s
          (by simp [((nonzeroDifference_iff (c i) s).mp hd).1]) (by simpa using hsr)
        exact (ne_of_gt ((nonzeroDifference_iff (c i) s).mp hd).2) hzero
      · intro hsr
        subst s
        exact (nonzeroDifference_iff (c i) r).mpr ⟨hr0, hpr i⟩
    refine ⟨r, hr0, ?_, hsupport⟩
    apply (hsupport j (-r)).mp
    apply (nonzeroDifference_iff (c j) (-r)).mpr
    exact ⟨neg_ne_zero.mpr hr0, by simpa [correlation_neg] using hpr j⟩
  · rintro ⟨r, hr0, _, hsupport⟩
    have hoff : ∀ i s, s ≠ 0 → s ≠ r → correlation (c i) s = 0 := by
      intro i s hs0 hsr
      apply correlation_zero_of_not_difference (c i) s hs0
      exact fun h => hsr ((hsupport i s).mp h)
    have hmass : ∀ i, correlationMass (c i) = correlation (c i) r := by
      intro i
      apply Finset.sum_eq_single r
      · intro s hs hsr
        exact hoff i s (Finset.mem_erase.mp hs).1 hsr
      · intro hn
        exact False.elim (hn (by simp [hr0]))
    calc
      correlationMoment c = ∏ i : I, correlation (c i) r := by
        apply Finset.sum_eq_single r
        · intro s hs hsr
          exact Finset.prod_eq_zero_iff.mpr
            ⟨j, Finset.mem_univ j, hoff j s (Finset.mem_erase.mp hs).1 hsr⟩
        · intro hn
          exact False.elim (hn (by simp [hr0]))
      _ = ∏ i : I, correlationMass (c i) := by
        apply Finset.prod_congr rfl
        intro i _
        exact (hmass i).symm

private theorem half_power_mul_two_power (m : ℕ) (hm : 1 ≤ m) :
    (1 / 2 : ℝ) ^ (m - 1) * (2 : ℝ) ^ m = 2 := by
  have hm' : m = (m - 1) + 1 := (Nat.sub_add_cancel hm).symm
  have hpow : (2 : ℝ) ^ m = (2 : ℝ) ^ (m - 1) * 2 := by
    calc
      (2 : ℝ) ^ m = (2 : ℝ) ^ ((m - 1) + 1) := congrArg (fun k : ℕ => (2 : ℝ) ^ k) hm'
      _ = (2 : ℝ) ^ (m - 1) * 2 := pow_succ _ _
  calc
    (1 / 2 : ℝ) ^ (m - 1) * (2 : ℝ) ^ m =
        (1 / 2 : ℝ) ^ (m - 1) * ((2 : ℝ) ^ (m - 1) * 2) := by
      rw [hpow]
    _ = ((1 / 2 : ℝ) ^ (m - 1) * (2 : ℝ) ^ (m - 1)) * 2 := by rw [mul_assoc]
    _ = ((1 / 2 : ℝ) * 2) ^ (m - 1) * 2 := by rw [mul_pow]
    _ = 2 := by simp

theorem correlationMoment_eq_half_power_iff
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
    {I : Type*} [Fintype I] [DecidableEq I]
    (c : I → G → ℂ) (hI : 2 ≤ Fintype.card I)
    (hno : ∀ r : G, r ≠ 0 → r ≠ -r)
    (hpos : ∀ i : I, 0 < correlationMass (c i)) :
    correlationMoment c =
        (1 / 2 : ℝ) ^ (Fintype.card I - 1) *
          ∏ i : I, correlationMass (c i) ↔
      ∃ r : G, r ≠ 0 ∧
        ∀ (i : I) (s : G), nonzeroDifference (c i) s ↔
          s = r ∨ s = -r := by
  classical
  letI : Nontrivial I := Fintype.one_lt_card_iff_nontrivial.mp hI
  let j : I := Classical.arbitrary I
  constructor
  · intro heq
    have hcoef : 0 < (1 / 2 : ℝ) ^ (Fintype.card I - 1) :=
      pow_pos (div_pos zero_lt_one zero_lt_two) _
    have hp : 0 < correlationMoment c :=
      heq.symm ▸ mul_pos hcoef (Finset.prod_pos (fun i _ => hpos i))
    obtain ⟨r, hr, hprod⟩ := (sum_pos_iff_exists (Finset.univ.erase (0 : G))
      (fun s => ∏ i : I, correlation (c i) s)
      (fun s _ => Finset.prod_nonneg (fun i _ => correlation_nonneg (c i) s))).mp hp
    have hr0 : r ≠ 0 := (Finset.mem_erase.mp hr).1
    have hpr : ∀ i : I, 0 < correlation (c i) r :=
      positive_factors (fun i => correlation (c i) r) (fun i => correlation_nonneg (c i) r) hprod
    have hs : ∀ i : I, correlation (c i) r = (1 / 2 : ℝ) * correlationMass (c i) :=
      profile_saturation (Finset.univ.erase (0 : G))
        (fun i s => correlation (c i) s) (fun i => correlationMass (c i)) (1 / 2)
        (fun i s _ => correlation_nonneg (c i) s) (fun _ => rfl)
        (fun i s hs => correlation_le_half_mass (c i) hno s (Finset.mem_erase.mp hs).1)
        hI heq r hr hpr
    have hpairs : ({r, -r} : Finset G) ⊆ Finset.univ.erase 0 := by
      intro x hx
      simp only [Finset.mem_insert, Finset.mem_singleton] at hx
      rcases hx with rfl | rfl <;> simp [hr0]
    have hsum : ∀ i : I,
        (∑ s ∈ ({r, -r} : Finset G), correlation (c i) s) =
          ∑ s ∈ Finset.univ.erase (0 : G), correlation (c i) s := by
      intro i
      change _ = correlationMass (c i)
      rw [Finset.sum_pair (hno r hr0), correlation_neg, hs i]
      simpa [div_eq_mul_inv, mul_comm] using add_halves (correlationMass (c i))
    refine ⟨r, hr0, ?_⟩
    intro i s
    constructor
    · intro hd
      by_contra hout
      have hzero : correlation (c i) s = 0 := support_of_subsum_eq
        (Finset.univ.erase (0 : G)) {r, -r} (correlation (c i)) hpairs
        (fun x _ => correlation_nonneg (c i) x) (hsum i) s
        (by simp [((nonzeroDifference_iff (c i) s).mp hd).1])
        (by simpa only [Finset.mem_insert, Finset.mem_singleton] using hout)
      exact (ne_of_gt ((nonzeroDifference_iff (c i) s).mp hd).2) hzero
    · intro hor
      rcases hor with hsr | hsr
      · subst s
        exact (nonzeroDifference_iff (c i) r).mpr ⟨hr0, hpr i⟩
      · subst s
        exact (nonzeroDifference_iff (c i) (-r)).mpr
          ⟨neg_ne_zero.mpr hr0, by simpa [correlation_neg] using hpr i⟩
  · rintro ⟨r, hr0, hsupport⟩
    have hpairs : ({r, -r} : Finset G) ⊆ Finset.univ.erase 0 := by
      intro x hx
      simp only [Finset.mem_insert, Finset.mem_singleton] at hx
      rcases hx with rfl | rfl <;> simp [hr0]
    have hoff : ∀ i s, s ≠ 0 → s ∉ ({r, -r} : Finset G) → correlation (c i) s = 0 := by
      intro i s hs0 hs
      apply correlation_zero_of_not_difference (c i) s hs0
      intro hd
      exact hs (by simpa only [Finset.mem_insert, Finset.mem_singleton] using (hsupport i s).mp hd)
    have hmass : ∀ i : I, correlationMass (c i) = 2 * correlation (c i) r := by
      intro i
      calc
        correlationMass (c i) = ∑ s ∈ ({r, -r} : Finset G), correlation (c i) s := by
          symm
          exact Finset.sum_subset hpairs
            (fun s hs hsn => hoff i s (Finset.mem_erase.mp hs).1 hsn)
        _ = 2 * correlation (c i) r := by
          rw [Finset.sum_pair (hno r hr0), correlation_neg, two_mul]
    have hmoment : correlationMoment c = 2 * ∏ i : I, correlation (c i) r := by
      calc
        correlationMoment c = ∑ s ∈ ({r, -r} : Finset G), ∏ i : I, correlation (c i) s := by
          symm
          apply Finset.sum_subset hpairs
          intro s hs hsn
          exact Finset.prod_eq_zero_iff.mpr
            ⟨j, Finset.mem_univ j, hoff j s (Finset.mem_erase.mp hs).1 hsn⟩
        _ = 2 * ∏ i : I, correlation (c i) r := by
          rw [Finset.sum_pair (hno r hr0)]
          simp_rw [correlation_neg]
          rw [two_mul]
    have hprod : (∏ i : I, correlationMass (c i)) =
        (2 : ℝ) ^ Fintype.card I * ∏ i : I, correlation (c i) r := by
      calc
        (∏ i : I, correlationMass (c i)) = ∏ i : I, 2 * correlation (c i) r := by
          exact Finset.prod_congr rfl (fun i _ => hmass i)
        _ = (2 : ℝ) ^ Fintype.card I * ∏ i : I, correlation (c i) r := by
          rw [Finset.prod_mul_distrib, Finset.prod_const, Finset.card_univ]
    rw [hmoment, hprod, ← mul_assoc,
      half_power_mul_two_power (Fintype.card I) (Nat.le_trans (by decide) hI)]

end BellChain


/- Native source snapshot: Witness.lean; SHA-256 b0ce2912f7b4c5ab6779a170a4ea773830e02d63f79f62b7387c2010f4540dee -/

open scoped BigOperators

namespace BellChain

theorem twoPoint_norm {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
    (r x : G) :
    ‖twoPoint r x‖ =
      if x = 0 then (3 / 5 : ℝ) else if x = r then (4 / 5 : ℝ) else 0 := by
  unfold twoPoint
  split_ifs <;> norm_num [Complex.norm_div]

section

variable {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
variable {I : Type*} [Fintype I] [DecidableEq I]

private theorem sum_supported_two (r : G) (hr : r ≠ 0) (f : G → ℝ)
    (hf : ∀ x, x ≠ 0 → x ≠ r → f x = 0) :
    (∑ x : G, f x) = f 0 + f r := by
  have hs : (∑ x ∈ ({0, r} : Finset G), f x) = ∑ x : G, f x := by
    apply Finset.sum_subset (Finset.subset_univ _)
    intro x _ hx
    have hx0 : x ≠ 0 := by
      intro he
      exact hx (by simp [he])
    have hxr : x ≠ r := by
      intro he
      exact hx (by simp [he])
    exact hf x hx0 hxr
  rw [← hs]
  simp [Ne.symm hr]

theorem twoPoint_normalized (r : G) (hr : r ≠ 0) :
    (∑ x : G, ‖twoPoint r x‖ ^ 2) = 1 := by
  rw [sum_supported_two r hr (fun x => ‖twoPoint r x‖ ^ 2)]
  · norm_num [twoPoint_norm, hr]
  · intro x hx0 hxr
    simp [twoPoint_norm, hx0, hxr]

theorem twoPoint_correlation (r s : G) (hr : r ≠ 0) :
    correlation (twoPoint r) s =
      (if s = 0 then (1 : ℝ) else 0) +
      (12 / 25 : ℝ) * (if s = r then 1 else 0) +
      (12 / 25 : ℝ) * (if s = -r then 1 else 0) := by
  unfold correlation
  rw [sum_supported_two r hr (fun x => ‖twoPoint r x‖ * ‖twoPoint r (x + s)‖)]
  · have hzero : r + s = 0 ↔ s = -r := by
      constructor
      · intro h
        calc
          s = -r + (r + s) := by simp
          _ = -r := by rw [h, add_zero]
      · intro h
        simp [h]
    have heq : r + s = r ↔ s = 0 := by
      constructor
      · intro h
        exact add_left_cancel (h.trans (add_zero r).symm)
      · intro h
        simp [h]
    simp only [twoPoint_norm, if_pos rfl, zero_add, if_neg hr, hzero, heq]
    by_cases hs0 : s = 0
    · subst s
      norm_num [hr, Ne.symm hr, neg_ne_zero.mpr hr]
    · by_cases hsr : s = r <;> by_cases hsneg : s = -r <;>
        norm_num [hr, hs0, hsr, hsneg]
  · intro x hx0 hxr
    simp [twoPoint_norm, hx0, hxr]

theorem twoPoint_mass (r : G) (hr : r ≠ 0) :
    correlationMass (twoPoint r) = 24 / 25 := by
  unfold correlationMass
  simp_rw [twoPoint_correlation r _ hr]
  rw [Finset.sum_add_distrib, Finset.sum_add_distrib,
    ← Finset.mul_sum, ← Finset.mul_sum]
  simp [hr, neg_ne_zero.mpr hr]
  norm_num

theorem twoPoint_mass_pos (r : G) (hr : r ≠ 0) :
    0 < correlationMass (twoPoint r) := by
  rw [twoPoint_mass r hr]
  norm_num

end

theorem twoPoint_ne_zero_iff {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
    (r x : G) :
    twoPoint r x ≠ 0 ↔ x = 0 ∨ x = r := by
  unfold twoPoint
  split_ifs with hx0 hxr
  · norm_num [hx0]
  · norm_num [hx0, hxr]
  · norm_num [hx0, hxr]

section

variable {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
variable {I : Type*} [Fintype I] [DecidableEq I]

theorem twoPoint_nonzeroDifference (r s : G) (hr : r ≠ 0) :
    nonzeroDifference (twoPoint r) s ↔ s = r ∨ s = -r := by
  simp only [nonzeroDifference, twoPoint_ne_zero_iff]
  constructor
  · rintro ⟨hs, x, hx, hxs⟩
    rcases hx with hx | hx
    · rw [hx, zero_add] at hxs
      rcases hxs with hz | heq
      · exact (hs hz).elim
      · exact Or.inl heq
    · rw [hx] at hxs
      rcases hxs with hz | heq
      · right
        calc
          s = -r + (r + s) := by simp
          _ = -r := by rw [hz, add_zero]
      · have hz : s = 0 := add_left_cancel (heq.trans (add_zero r).symm)
        exact (hs hz).elim
  · rintro (hs | hs)
    · subst s
      exact ⟨hr, 0, Or.inl rfl, Or.inr (zero_add r)⟩
    · subst s
      exact ⟨neg_ne_zero.mpr hr, r, Or.inr rfl, Or.inl (add_neg_cancel r)⟩

theorem zmod_one_nonzero (d : ℕ) (hd : 2 ≤ d) :
    (1 : ZMod d) ≠ 0 := by
  rw [ne_eq, ZMod.one_eq_zero_iff]
  omega

theorem zmod_odd_no_nonzero_involution (d : ℕ) (hd : Odd d) :
    ∀ r : ZMod d, r ≠ 0 → r ≠ -r := by
  intro r hr hself
  have hv : 2 * r.val = d := ((ZMod.neg_eq_self_iff r).mp hself.symm).resolve_left hr
  rcases hd with ⟨k, hk⟩
  omega

theorem zmod_even_half_nonzero (d : ℕ) (hd : 2 ≤ d) (heven : Even d) :
    (↑(d / 2) : ZMod d) ≠ 0 := by
  rcases heven with ⟨k, hk⟩
  have hlt : d / 2 < d := by omega
  have hpos : 0 < d / 2 := by omega
  intro hz
  have hv := congrArg ZMod.val hz
  rw [ZMod.val_natCast_of_lt hlt, ZMod.val_zero] at hv
  omega

theorem zmod_even_half_neg (d : ℕ) (hd : 2 ≤ d) (heven : Even d) :
    -(↑(d / 2) : ZMod d) = (↑(d / 2) : ZMod d) := by
  apply (ZMod.neg_eq_self_iff _).mpr
  right
  rw [ZMod.val_natCast_of_lt (show d / 2 < d by omega)]
  rcases heven with ⟨k, hk⟩
  omega

theorem zmod_even_nonzero_involution_iff (d : ℕ) (hd : 2 ≤ d) (heven : Even d)
    (r : ZMod d) (hr : r ≠ 0) :
    -r = r ↔ r = (↑(d / 2) : ZMod d) := by
  letI : NeZero d := ⟨by omega⟩
  constructor
  · intro hself
    have hv : 2 * r.val = d := ((ZMod.neg_eq_self_iff r).mp hself).resolve_left hr
    calc
      r = (↑r.val : ZMod d) := (ZMod.natCast_zmod_val r).symm
      _ = (↑(d / 2) : ZMod d) := by congr 1; omega
  · intro heq
    rw [heq]
    exact zmod_even_half_neg d hd heven

end

end BellChain


/- Native source snapshot: Main.lean; SHA-256 176c2fd30f3aa45170baf2e16061ecfe07119efd9d1318a43903044bbf23a210 -/

open scoped BigOperators

namespace BellChain

theorem twoPoint_even_attains
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
    {I : Type*} [Fintype I]
    (r : G) (hr : r ≠ 0) (hself : -r = r)
    (hI : 2 ≤ Fintype.card I) :
    correlationMoment (fun _ : I => twoPoint r) =
      ∏ _i : I, correlationMass (twoPoint r) := by
  classical
  apply (correlationMoment_eq_product_iff (fun _ : I => twoPoint r) hI
    (fun _ => twoPoint_mass_pos r hr)).mpr
  refine ⟨r, hr, hself, ?_⟩
  intro i s
  simpa [hself] using twoPoint_nonzeroDifference r s hr

theorem twoPoint_odd_attains
    {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
    {I : Type*} [Fintype I]
    (r : G) (hr : r ≠ 0)
    (hno : ∀ s : G, s ≠ 0 → s ≠ -s)
    (hI : 2 ≤ Fintype.card I) :
    correlationMoment (fun _ : I => twoPoint r) =
      (1 / 2 : ℝ) ^ (Fintype.card I - 1) *
        ∏ _i : I, correlationMass (twoPoint r) := by
  classical
  apply (correlationMoment_eq_half_power_iff (fun _ : I => twoPoint r)
    hI hno (fun _ => twoPoint_mass_pos r hr)).mpr
  exact ⟨r, hr, fun _ s => twoPoint_nonzeroDifference r s hr⟩

/-- The coefficient for n internal Bell measurements and n+1 physical links. -/
noncomputable def parityCoefficient (d n : ℕ) : ℝ := by
  classical
  exact if Even d then 1 else (1 / 2 : ℝ) ^ n

/-- A concrete displacement used by the normalized sharp input family. -/
noncomputable def sharpDisplacement (d : ℕ) : ZMod d := by
  classical
  exact if Even d then (↑(d / 2) : ZMod d) else 1

/-- Every link is the actual complex 3/5, 4/5 two-point state. -/
noncomputable def sharpInput (d n : ℕ) [NeZero d] :
    Option (Fin n) → ZMod d → ℂ :=
  fun _ => twoPoint (sharpDisplacement d)

private theorem link_card_ge_two {n : ℕ} (hn : 1 ≤ n) :
    2 ≤ Fintype.card (Option (Fin n)) := by
  simpa using (show 2 ≤ n + 1 by omega)

theorem parityCoefficient_pos (d n : ℕ) : 0 < parityCoefficient d n := by
  classical
  unfold parityCoefficient
  split_ifs
  · norm_num
  · exact pow_pos (by norm_num) n

theorem el1_nonneg {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
    (c : G → ℂ) : 0 ≤ el1 c := by
  rw [el1_eq_correlationMass]
  exact correlationMass_nonneg c

theorem physicalAverage_nonneg {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) : 0 ≤ physicalAverage c := by
  rw [physicalAverage_eq_correlationMoment]
  exact correlationMoment_nonneg c

theorem physicalAverage_le_parity {d n : ℕ} [NeZero d]
    (_hd : 2 ≤ d) (hn : 1 ≤ n)
    (c : Option (Fin n) → ZMod d → ℂ) :
    physicalAverage c ≤ parityCoefficient d n * ∏ i, el1 (c i) := by
  classical
  rw [physicalAverage_eq_correlationMoment]
  simp only [el1_eq_correlationMass]
  by_cases heven : Even d
  · simpa [parityCoefficient, heven] using
      correlationMoment_le_product c (link_card_ge_two hn)
  · have hodd : Odd d := Nat.not_even_iff_odd.mp heven
    simpa [parityCoefficient, heven] using
      correlationMoment_le_half_power c (link_card_ge_two hn)
        (zmod_odd_no_nonzero_involution d hodd)

theorem physicalAverage_even_equality_iff {d n : ℕ} [NeZero d]
    (hd : 2 ≤ d) (hn : 1 ≤ n) (heven : Even d)
    (c : Option (Fin n) → ZMod d → ℂ)
    (hpos : ∀ i, 0 < el1 (c i)) :
    physicalAverage c = ∏ i, el1 (c i) ↔
      ∀ i s, nonzeroDifference (c i) s ↔ s = (↑(d / 2) : ZMod d) := by
  rw [physicalAverage_eq_correlationMoment]
  simp only [el1_eq_correlationMass] at hpos ⊢
  rw [correlationMoment_eq_product_iff c (link_card_ge_two hn) hpos]
  constructor
  · rintro ⟨r, hr, hself, hsupport⟩
    have heq : r = (↑(d / 2) : ZMod d) :=
      (zmod_even_nonzero_involution_iff d hd heven r hr).mp hself
    simpa [heq] using hsupport
  · intro hsupport
    exact ⟨(↑(d / 2) : ZMod d), zmod_even_half_nonzero d hd heven,
      zmod_even_half_neg d hd heven, hsupport⟩

theorem physicalAverage_odd_equality_iff {d n : ℕ} [NeZero d]
    (_hd : 2 ≤ d) (hn : 1 ≤ n) (hodd : Odd d)
    (c : Option (Fin n) → ZMod d → ℂ)
    (hpos : ∀ i, 0 < el1 (c i)) :
    physicalAverage c = (1 / 2 : ℝ) ^ n * ∏ i, el1 (c i) ↔
      ∃ r : ZMod d, r ≠ 0 ∧
        ∀ i s, nonzeroDifference (c i) s ↔ s = r ∨ s = -r := by
  rw [physicalAverage_eq_correlationMoment]
  simp only [el1_eq_correlationMass] at hpos ⊢
  simpa using correlationMoment_eq_half_power_iff c (link_card_ge_two hn)
    (zmod_odd_no_nonzero_involution d hodd) hpos

theorem physicalAverage_eq_parity_iff_of_pos {d n : ℕ} [NeZero d]
    (hd : 2 ≤ d) (hn : 1 ≤ n)
    (c : Option (Fin n) → ZMod d → ℂ)
    (hpos : ∀ i, 0 < el1 (c i)) :
    physicalAverage c = parityCoefficient d n * ∏ i, el1 (c i) ↔
      if Even d then
        ∀ i s, nonzeroDifference (c i) s ↔ s = (↑(d / 2) : ZMod d)
      else
        ∃ r : ZMod d, r ≠ 0 ∧
          ∀ i s, nonzeroDifference (c i) s ↔ s = r ∨ s = -r := by
  classical
  by_cases heven : Even d
  · simpa [parityCoefficient, heven] using
      physicalAverage_even_equality_iff hd hn heven c hpos
  · simpa [parityCoefficient, heven] using
      physicalAverage_odd_equality_iff hd hn (Nat.not_even_iff_odd.mp heven) c hpos

theorem physicalAverage_zero_input {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) (i : Option (Fin n))
    (hi : el1 (c i) = 0) :
    physicalAverage c = 0 ∧ parityCoefficient d n * ∏ j, el1 (c j) = 0 := by
  constructor
  · rw [physicalAverage_eq_correlationMoment]
    apply correlationMoment_eq_zero_of_mass_eq_zero c i
    rwa [el1_eq_correlationMass] at hi
  · have hp : (∏ j, el1 (c j)) = 0 :=
      Finset.prod_eq_zero_iff.mpr ⟨i, Finset.mem_univ i, hi⟩
    rw [hp, mul_zero]

theorem physicalAverage_eq_parity_iff {d n : ℕ} [NeZero d]
    (hd : 2 ≤ d) (hn : 1 ≤ n)
    (c : Option (Fin n) → ZMod d → ℂ) :
    physicalAverage c = parityCoefficient d n * ∏ i, el1 (c i) ↔
      (∃ i, el1 (c i) = 0) ∨
      ((∀ i, 0 < el1 (c i)) ∧
        if Even d then
          ∀ i s, nonzeroDifference (c i) s ↔ s = (↑(d / 2) : ZMod d)
        else
          ∃ r : ZMod d, r ≠ 0 ∧
            ∀ i s, nonzeroDifference (c i) s ↔ s = r ∨ s = -r) := by
  classical
  by_cases hz : ∃ i, el1 (c i) = 0
  · obtain ⟨i, hi⟩ := hz
    have hzero := physicalAverage_zero_input c i hi
    constructor
    · intro _
      exact Or.inl ⟨i, hi⟩
    · intro _
      exact hzero.1.trans hzero.2.symm
  · have hpos : ∀ i, 0 < el1 (c i) := by
      intro i
      have hne : el1 (c i) ≠ 0 := fun heq => hz ⟨i, heq⟩
      exact lt_of_le_of_ne (el1_nonneg (c i)) (Ne.symm hne)
    simpa [hz, hpos] using physicalAverage_eq_parity_iff_of_pos hd hn c hpos

theorem physicalAverage_eq_zero_iff {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) :
    physicalAverage c = 0 ↔
      ¬ ∃ r : ZMod d, r ≠ 0 ∧
        ∀ i, ∃ x : ZMod d, c i x ≠ 0 ∧ c i (x + r) ≠ 0 := by
  rw [physicalAverage_eq_correlationMoment]
  exact correlationMoment_eq_zero_iff c

theorem physicalAverage_eq_zero_iff_D {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) :
    physicalAverage c = 0 ↔
      ¬ ∃ r : ZMod d, ∀ i, nonzeroDifference (c i) r := by
  rw [physicalAverage_eq_zero_iff]
  constructor
  · intro h
    rintro ⟨r, hD⟩
    exact h ⟨r, (hD none).1, fun i => (hD i).2⟩
  · intro h
    rintro ⟨r, hr, hD⟩
    exact h ⟨r, fun i => ⟨hr, hD i⟩⟩

theorem sharpDisplacement_nonzero {d : ℕ} (hd : 2 ≤ d) :
    sharpDisplacement d ≠ 0 := by
  classical
  by_cases heven : Even d
  · simpa [sharpDisplacement, heven] using zmod_even_half_nonzero d hd heven
  · simpa [sharpDisplacement, heven] using zmod_one_nonzero d hd

theorem sharpInput_normalized {d n : ℕ} [NeZero d] (hd : 2 ≤ d)
    (i : Option (Fin n)) :
    stateNormSq (sharpInput d n i) = 1 := by
  exact twoPoint_normalized (sharpDisplacement d) (sharpDisplacement_nonzero hd)

theorem sharpInput_el1 {d n : ℕ} [NeZero d] (hd : 2 ≤ d)
    (i : Option (Fin n)) :
    el1 (sharpInput d n i) = 24 / 25 := by
  rw [el1_eq_correlationMass]
  exact twoPoint_mass (sharpDisplacement d) (sharpDisplacement_nonzero hd)

theorem sharpInput_el1_pos {d n : ℕ} [NeZero d] (hd : 2 ≤ d)
    (i : Option (Fin n)) :
    0 < el1 (sharpInput d n i) := by
  rw [sharpInput_el1 hd i]
  norm_num

theorem sharpInput_attains {d n : ℕ} [NeZero d]
    (hd : 2 ≤ d) (hn : 1 ≤ n) :
    physicalAverage (sharpInput d n) =
      parityCoefficient d n * ∏ i, el1 (sharpInput d n i) := by
  classical
  apply (physicalAverage_eq_parity_iff_of_pos hd hn (sharpInput d n)
    (sharpInput_el1_pos hd)).mpr
  by_cases heven : Even d
  · simp only [if_pos heven]
    intro i s
    change nonzeroDifference (twoPoint (sharpDisplacement d)) s ↔ _
    rw [show sharpDisplacement d = (↑(d / 2) : ZMod d) by
      simp [sharpDisplacement, heven]]
    rw [twoPoint_nonzeroDifference _ _ (zmod_even_half_nonzero d hd heven),
      zmod_even_half_neg d hd heven, or_self]
  · simp only [if_neg heven]
    refine ⟨1, zmod_one_nonzero d hd, ?_⟩
    intro i s
    simpa [sharpInput, sharpDisplacement, heven] using
      twoPoint_nonzeroDifference (1 : ZMod d) s (zmod_one_nonzero d hd)

theorem sharpInput_value {d n : ℕ} [NeZero d]
    (hd : 2 ≤ d) (hn : 1 ≤ n) :
    physicalAverage (sharpInput d n) =
      parityCoefficient d n * (24 / 25 : ℝ) ^ (n + 1) := by
  rw [sharpInput_attains hd hn]
  simp_rw [sharpInput_el1 hd]
  simp [div_pow]

theorem sharpInput_even_value {d n : ℕ} [NeZero d]
    (hd : 2 ≤ d) (hn : 1 ≤ n) (heven : Even d) :
    physicalAverage (sharpInput d n) = (24 / 25 : ℝ) ^ (n + 1) := by
  simpa [parityCoefficient, heven] using sharpInput_value hd hn

theorem sharpInput_odd_value {d n : ℕ} [NeZero d]
    (hd : 2 ≤ d) (hn : 1 ≤ n) (hodd : Odd d) :
    physicalAverage (sharpInput d n) = 2 * (12 / 25 : ℝ) ^ (n + 1) := by
  rw [sharpInput_value hd hn]
  have heven : ¬ Even d := Nat.not_even_iff_odd.mpr hodd
  simp only [parityCoefficient, if_neg heven]
  rw [show (24 / 25 : ℝ) = 2 * (12 / 25 : ℝ) by norm_num,
    mul_pow, pow_succ (2 : ℝ) n, ← mul_assoc, ← mul_assoc, ← mul_pow]
  norm_num

/-- Genuine optimality over every normalized complex input chain. -/
theorem physicalAverage_uniform_bound_iff {d n : ℕ} [NeZero d]
    (hd : 2 ≤ d) (hn : 1 ≤ n) (K : ℝ) :
    (∀ c : Option (Fin n) → ZMod d → ℂ,
      (∀ i, stateNormSq (c i) = 1) →
        physicalAverage c ≤ K * ∏ i, el1 (c i)) ↔
      parityCoefficient d n ≤ K := by
  constructor
  · intro hbound
    have hw := hbound (sharpInput d n) (sharpInput_normalized hd)
    have hp : 0 < ∏ i, el1 (sharpInput d n i) :=
      Finset.prod_pos (fun i _ => sharpInput_el1_pos hd i)
    rw [sharpInput_attains hd hn] at hw
    exact (mul_le_mul_right hp).mp hw
  · intro hK c _
    exact (physicalAverage_le_parity hd hn c).trans
      (mul_le_mul_of_nonneg_right hK (Finset.prod_nonneg (fun i _ => el1_nonneg (c i))))

/-- Two occupied labels per link, with disjoint nonzero difference sets in ZMod 5. -/
noncomputable def disjointFiveInputs : Option (Fin 1) → ZMod 5 → ℂ
  | none => twoPoint 2
  | some _ => twoPoint 1

theorem disjointFiveInputs_normalized (i : Option (Fin 1)) :
    stateNormSq (disjointFiveInputs i) = 1 := by
  cases i with
  | none => exact twoPoint_normalized (2 : ZMod 5) (by decide)
  | some i => exact twoPoint_normalized (1 : ZMod 5) (by decide)

theorem disjointFiveInputs_el1 (i : Option (Fin 1)) :
    el1 (disjointFiveInputs i) = 24 / 25 := by
  rw [el1_eq_correlationMass]
  cases i with
  | none => exact twoPoint_mass (2 : ZMod 5) (by decide)
  | some i => exact twoPoint_mass (1 : ZMod 5) (by decide)

theorem disjointFiveInputs_none_differences (s : ZMod 5) :
    nonzeroDifference (disjointFiveInputs none) s ↔ s = 2 ∨ s = 3 := by
  change nonzeroDifference (twoPoint (2 : ZMod 5)) s ↔ _
  rw [twoPoint_nonzeroDifference _ _ (by decide : (2 : ZMod 5) ≠ 0)]
  rw [show -(2 : ZMod 5) = 3 by decide]

theorem disjointFiveInputs_some_differences (i : Fin 1) (s : ZMod 5) :
    nonzeroDifference (disjointFiveInputs (some i)) s ↔ s = 1 ∨ s = 4 := by
  change nonzeroDifference (twoPoint (1 : ZMod 5)) s ↔ _
  rw [twoPoint_nonzeroDifference _ _ (by decide : (1 : ZMod 5) ≠ 0)]
  rw [show -(1 : ZMod 5) = 4 by decide]

theorem disjointFiveInputs_average_zero :
    physicalAverage disjointFiveInputs = 0 := by
  apply (physicalAverage_eq_zero_iff_D disjointFiveInputs).mpr
  rintro ⟨r, hD⟩
  have hlast := (disjointFiveInputs_none_differences r).mp (hD none)
  have hfirst := (disjointFiveInputs_some_differences ⟨0, by decide⟩ r).mp
    (hD (some ⟨0, by decide⟩))
  have hdisjoint : ∀ r : ZMod 5, (r = 1 ∨ r = 4) → ¬ (r = 2 ∨ r = 3) := by
    decide
  exact hdisjoint r hfirst hlast

theorem disjointFiveInputs_certificate :
    (∀ i, stateNormSq (disjointFiveInputs i) = 1) ∧
    (∀ i, el1 (disjointFiveInputs i) = 24 / 25) ∧
    physicalAverage disjointFiveInputs = 0 :=
  ⟨disjointFiveInputs_normalized, disjointFiveInputs_el1, disjointFiveInputs_average_zero⟩

/-- The normalized three-term amplitude vector (2/3, 2/3, 1/3). -/
noncomputable def rankThreeInput (i : Fin 3) : ℂ :=
  if i = 2 then (1 / 3 : ℂ) else (2 / 3 : ℂ)

theorem rankThreeInput_normalized : stateNormSq rankThreeInput = 1 := by
  have h02 : (0 : Fin 3) ≠ 2 := by decide
  have h12 : (1 : Fin 3) ≠ 2 := by decide
  norm_num [stateNormSq, rankThreeInput, Fin.sum_univ_succ, Complex.norm_div, h02, h12]

theorem rankThreeInput_nonzero (i : Fin 3) : rankThreeInput i ≠ 0 := by
  unfold rankThreeInput
  split_ifs <;> norm_num

theorem rankThreeInput_el1 : el1 rankThreeInput = 16 / 9 := by
  have h01 : (0 : Fin 3) ≠ 1 := by decide
  have h02 : (0 : Fin 3) ≠ 2 := by decide
  have h12 : (1 : Fin 3) ≠ 2 := by decide
  norm_num [el1, rankThreeInput, Fin.sum_univ_succ, Complex.norm_div,
    h01, h02, h12, Ne.symm h01, Ne.symm h02, Ne.symm h12]

theorem rankThreeInput_el1_gt_one : 1 < el1 rankThreeInput := by
  rw [rankThreeInput_el1]
  norm_num

theorem rankThreeInput_certificate :
    stateNormSq rankThreeInput = 1 ∧
    (∀ i, rankThreeInput i ≠ 0) ∧
    el1 rankThreeInput = 16 / 9 ∧ 1 < el1 rankThreeInput :=
  ⟨rankThreeInput_normalized, rankThreeInput_nonzero,
    rankThreeInput_el1, rankThreeInput_el1_gt_one⟩

end BellChain


/- Native source snapshot: Profiles.lean; SHA-256 cfbccbd7f9f944d269328d61be2cc32459743c9a234ba8b7b2125dfa8b00931b -/

open scoped BigOperators

namespace BellChain

variable {G : Type*} [Fintype G] [DecidableEq G] [AddCommGroup G]
variable {I : Type*} [Fintype I]

/-- The manuscript's displacement probability distribution when the mass is positive. -/
noncomputable def displacementDistribution (c : G → ℂ) (r : G) : ℝ :=
  correlation c r / correlationMass c

theorem displacementDistribution_nonneg (c : G → ℂ) (r : G) :
    0 ≤ displacementDistribution c r :=
  div_nonneg (correlation_nonneg c r) (correlationMass_nonneg c)

theorem displacementDistribution_neg (c : G → ℂ) (r : G) :
    displacementDistribution c (-r) = displacementDistribution c r := by
  simp only [displacementDistribution, correlation_neg]

theorem displacementDistribution_sum (c : G → ℂ)
    (hp : 0 < correlationMass c) :
    (∑ r ∈ Finset.univ.erase (0 : G), displacementDistribution c r) = 1 := by
  unfold displacementDistribution
  simp_rw [div_eq_mul_inv]
  rw [← Finset.sum_mul]
  exact mul_inv_cancel₀ (ne_of_gt hp)

theorem displacementDistribution_pos_iff (c : G → ℂ) (r : G)
    (hp : 0 < correlationMass c) :
    0 < displacementDistribution c r ↔ ∃ x, c x ≠ 0 ∧ c (x + r) ≠ 0 := by
  rw [displacementDistribution, div_pos_iff_of_pos_right hp]
  exact correlation_pos_iff c r

theorem displacementDistribution_le_one (c : G → ℂ) (r : G)
    (hr : r ≠ 0) (hp : 0 < correlationMass c) :
    displacementDistribution c r ≤ 1 := by
  rw [displacementDistribution, div_le_iff₀ hp, one_mul]
  exact correlation_le_mass c r hr

theorem displacementDistribution_le_half (c : G → ℂ)
    (hno : ∀ r : G, r ≠ 0 → r ≠ -r)
    (r : G) (hr : r ≠ 0) (hp : 0 < correlationMass c) :
    displacementDistribution c r ≤ (1 / 2 : ℝ) := by
  rw [displacementDistribution, div_le_iff₀ hp]
  exact correlation_le_half_mass c hno r hr

theorem displacementDistribution_ratio (c : I → G → ℂ) :
    correlationMoment c / (∏ i : I, correlationMass (c i)) =
      ∑ r ∈ Finset.univ.erase (0 : G), ∏ i : I, displacementDistribution (c i) r := by
  simp_rw [displacementDistribution, Finset.prod_div_distrib]
  simp_rw [div_eq_mul_inv]
  rw [← Finset.sum_mul]
  rfl

theorem displacementDistribution_product_le_one (c : I → G → ℂ)
    (hI : 2 ≤ Fintype.card I) (hp : ∀ i, 0 < correlationMass (c i)) :
    (∑ r ∈ Finset.univ.erase (0 : G), ∏ i : I, displacementDistribution (c i) r) ≤ 1 := by
  classical
  rw [← displacementDistribution_ratio]
  have hprod : 0 < ∏ i : I, correlationMass (c i) :=
    Finset.prod_pos (fun i _ => hp i)
  rw [div_le_iff₀ hprod, one_mul]
  exact correlationMoment_le_product c hI

theorem displacementDistribution_product_le_half_power (c : I → G → ℂ)
    (hI : 2 ≤ Fintype.card I)
    (hno : ∀ r : G, r ≠ 0 → r ≠ -r)
    (hp : ∀ i, 0 < correlationMass (c i)) :
    (∑ r ∈ Finset.univ.erase (0 : G), ∏ i : I, displacementDistribution (c i) r) ≤
      (1 / 2 : ℝ) ^ (Fintype.card I - 1) := by
  classical
  rw [← displacementDistribution_ratio]
  have hprod : 0 < ∏ i : I, correlationMass (c i) :=
    Finset.prod_pos (fun i _ => hp i)
  rw [div_le_iff₀ hprod]
  exact correlationMoment_le_half_power c hI hno

theorem physicalAverage_ratio {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) :
    physicalAverage c / (∏ i, el1 (c i)) =
      ∑ r ∈ Finset.univ.erase (0 : ZMod d), ∏ i, displacementDistribution (c i) r := by
  simp_rw [physicalAverage_eq_correlationMoment, el1_eq_correlationMass]
  exact displacementDistribution_ratio c

end BellChain


/- Native source snapshot: PhaseConventions.lean; SHA-256 fbb094f778e6ff3d65e0ab35052f37f496d723b3deee9d7f564c94b737a9e060 -/

open scoped BigOperators ComplexConjugate

namespace BellChain

/-- The negative Bell phase written with an arbitrary integer exponent. -/
noncomputable def integerPhase (d : ℕ) (z : ℤ) : ℂ :=
  Complex.exp ((-2 : ℂ) * (Real.pi : ℂ) * (z : ℂ) / (d : ℂ) * Complex.I)

theorem integerPhase_add_multiple {d : ℕ} [NeZero d] (z t : ℤ) :
    integerPhase d (z + (d : ℤ) * t) = integerPhase d z := by
  have hd : (d : ℂ) ≠ 0 := by exact_mod_cast (NeZero.ne d)
  have harg :
      (-2 : ℂ) * (Real.pi : ℂ) * ((z + (d : ℤ) * t : ℤ) : ℂ) /
          (d : ℂ) * Complex.I =
        (-2 : ℂ) * (Real.pi : ℂ) * (z : ℂ) / (d : ℂ) * Complex.I +
          ((-t : ℤ) : ℂ) * (2 * (Real.pi : ℂ) * Complex.I) := by
    simp only [Int.cast_add, Int.cast_mul, Int.cast_natCast, Int.cast_neg]
    field_simp [hd]
    ring
  unfold integerPhase
  rw [harg, Complex.exp_add, Complex.exp_int_mul_two_pi_mul_I, mul_one]

theorem integerPhase_mul_representatives {d : ℕ} [NeZero d] (Q X a b : ℤ) :
    integerPhase d ((Q + (d : ℤ) * a) * (X + (d : ℤ) * b)) =
      integerPhase d (Q * X) := by
  have hexp :
      (Q + (d : ℤ) * a) * (X + (d : ℤ) * b) =
        Q * X + (d : ℤ) * (Q * b + X * a + (d : ℤ) * a * b) := by ring
  rw [hexp, integerPhase_add_multiple]

theorem bellPhase_eq_integerPhase {d : ℕ} (q x : ZMod d) :
    bellPhase q x = integerPhase d ((q.val : ℤ) * (x.val : ℤ)) := by
  unfold bellPhase integerPhase
  congr 1
  simp only [Complex.ofReal_div, Complex.ofReal_mul, Complex.ofReal_neg,
    Complex.ofReal_ofNat, Complex.ofReal_natCast, Int.cast_mul, Int.cast_natCast]
  ring

theorem bellPhase_shifted_representatives {d : ℕ} [NeZero d]
    (q x : ZMod d) (a b : ℤ) :
    integerPhase d
        (((q.val : ℤ) + (d : ℤ) * a) * ((x.val : ℤ) + (d : ℤ) * b)) =
      bellPhase q x := by
  rw [integerPhase_mul_representatives]
  exact (bellPhase_eq_integerPhase q x).symm

theorem bellPhase_arbitrary_representatives {d : ℕ} [NeZero d]
    (q x : ZMod d) (Q X : ℤ)
    (hQ : (Q : ZMod d) = q) (hX : (X : ZMod d) = x) :
    integerPhase d (Q * X) = bellPhase q x := by
  obtain ⟨a, ha⟩ := (ZMod.intCast_eq_iff d Q q).mp hQ
  obtain ⟨b, hb⟩ := (ZMod.intCast_eq_iff d X x).mp hX
  rw [ha, hb]
  exact bellPhase_shifted_representatives q x a b

theorem integerPhase_neg (d : ℕ) (z : ℤ) :
    integerPhase d (-z) = conj (integerPhase d z) := by
  unfold integerPhase
  rw [← Complex.exp_conj]
  congr 1
  simp [Complex.conj_ofNat]
  ring

theorem bellPhase_neg_integer {d : ℕ} [NeZero d] (q x : ZMod d) :
    bellPhase (-q) x = integerPhase d (-((q.val : ℤ) * (x.val : ℤ))) := by
  have hq : ((-(q.val : ℤ) : ℤ) : ZMod d) = -q := by
    simp [ZMod.natCast_zmod_val]
  have hx : ((x.val : ℤ) : ZMod d) = x := by
    simp [ZMod.natCast_zmod_val]
  have h := bellPhase_arbitrary_representatives (-q) x (-(q.val : ℤ)) (x.val : ℤ)
    hq hx
  simpa only [neg_mul] using h.symm

theorem bellPhase_neg_eq_conj {d : ℕ} [NeZero d] (q x : ZMod d) :
    bellPhase (-q) x = conj (bellPhase q x) := by
  rw [bellPhase_neg_integer, integerPhase_neg, bellPhase_eq_integerPhase]

theorem bellBra_neg_eq_conj {d : ℕ} [NeZero d] (p q u v : ZMod d) :
    bellBra p (-q) u v = conj (bellBra p q u v) := by
  unfold bellBra
  split_ifs <;> simp [bellPhase_neg_eq_conj]

theorem sum_phase_labels_neg {d n : ℕ} [NeZero d]
    (f : (Fin n → ZMod d) → ℝ) :
    (∑ q : Fin n → ZMod d, f (-q)) = ∑ q : Fin n → ZMod d, f q := by
  exact (neg_involutive :
    Function.Involutive (fun q : Fin n → ZMod d => -q)).bijective.sum_comp f

/-- Opposite signs for every Bell phase give the same complete physical average. -/
theorem physicalAverage_neg_phase_labels {d n : ℕ} [NeZero d]
    (c : Option (Fin n) → ZMod d → ℂ) :
    (∑ p : Fin n → ZMod d, ∑ q : Fin n → ZMod d,
      weightedEl1 (rawCoefficient c p (-q))) = physicalAverage c := by
  unfold physicalAverage
  apply Finset.sum_congr rfl
  intro p _
  exact sum_phase_labels_neg (fun q => weightedEl1 (rawCoefficient c p q))

end BellChain

-- Audited formalization plan SHA-256: c4a573af89fea18a262a0f50e350c22fc52b49f382f8906f6c057b2de15c8503
set_option autoImplicit false

namespace EDEGFormalization

theorem Example1 :
  (∀ i : Option (Fin 1), BellChain.stateNormSq (BellChain.sharpInput 2 1 i) = 1) ∧
    (∀ i : Option (Fin 1), BellChain.el1 (BellChain.sharpInput 2 1 i) = 24 / 25 ∧
      0 < BellChain.el1 (BellChain.sharpInput 2 1 i)) ∧
    BellChain.physicalAverage (BellChain.sharpInput 2 1) = (24 / 25 : ℝ) ^ 2 :=
  by
    refine ⟨?_, ?_, ?_⟩
    · intro i
      exact BellChain.sharpInput_normalized (by decide) i
    · intro i
      exact ⟨BellChain.sharpInput_el1 (by decide) i, BellChain.sharpInput_el1_pos (by decide) i⟩
    · exact BellChain.sharpInput_even_value (d := 2) (n := 1) (by decide) (by decide) (by decide)

theorem Example2 :
  (∀ i : Option (Fin 1), BellChain.stateNormSq (BellChain.sharpInput 3 1 i) = 1) ∧
    (∀ i : Option (Fin 1), BellChain.el1 (BellChain.sharpInput 3 1 i) = 24 / 25 ∧
      0 < BellChain.el1 (BellChain.sharpInput 3 1 i)) ∧
    BellChain.physicalAverage (BellChain.sharpInput 3 1) = 2 * (12 / 25 : ℝ) ^ 2 :=
  by
    refine ⟨?_, ?_, ?_⟩
    · intro i
      exact BellChain.sharpInput_normalized (by decide) i
    · intro i
      exact ⟨BellChain.sharpInput_el1 (by decide) i, BellChain.sharpInput_el1_pos (by decide) i⟩
    · exact BellChain.sharpInput_odd_value (d := 3) (n := 1) (by decide) (by decide) (by decide)

theorem Example3 :
  (∀ i, BellChain.stateNormSq (BellChain.disjointFiveInputs i) = 1) ∧
    (∀ i, BellChain.el1 (BellChain.disjointFiveInputs i) = 24 / 25) ∧
    BellChain.physicalAverage BellChain.disjointFiveInputs = 0 ∧
    (∀ s : ZMod 5, BellChain.nonzeroDifference (BellChain.disjointFiveInputs none) s ↔ s = 2 ∨ s = 3) ∧
    (∀ (i : Fin 1) (s : ZMod 5), BellChain.nonzeroDifference (BellChain.disjointFiveInputs (some i)) s ↔ s = 1 ∨ s = 4) :=
  by
    exact ⟨BellChain.disjointFiveInputs_normalized, BellChain.disjointFiveInputs_el1,
      BellChain.disjointFiveInputs_average_zero, BellChain.disjointFiveInputs_none_differences,
      BellChain.disjointFiveInputs_some_differences⟩

theorem Example4 :
  BellChain.stateNormSq BellChain.rankThreeInput = 1 ∧
      (∀ i, BellChain.rankThreeInput i ≠ 0) ∧
      BellChain.el1 BellChain.rankThreeInput = 16 / 9 ∧ 1 < BellChain.el1 BellChain.rankThreeInput :=
  by
    exact BellChain.rankThreeInput_certificate

theorem Claim1 :
  ∀ (d : ℕ) [NeZero d] (c : ZMod d → ℂ),
    (∀ r, 0 ≤ BellChain.correlation c r) ∧
    (∀ r, BellChain.correlation c (-r) = BellChain.correlation c r) ∧
    BellChain.el1 c = BellChain.correlationMass c ∧
    (∀ r, BellChain.nonzeroDifference c r ↔ r ≠ 0 ∧ 0 < BellChain.correlation c r) ∧
    (∀ r, 0 < BellChain.correlation c r ↔ ∃ x, c x ≠ 0 ∧ c (x + r) ≠ 0) :=
  by
    intro d _ c
    exact ⟨BellChain.correlation_nonneg c, BellChain.correlation_neg c,
      BellChain.el1_eq_correlationMass c, BellChain.nonzeroDifference_iff c, BellChain.correlation_pos_iff c⟩

theorem Claim2 :
  ∀ (d : ℕ) (_hd : 2 ≤ d) (_heven : Even d),
    (↑(d / 2) : ZMod d) ≠ 0 ∧
    -(↑(d / 2) : ZMod d) = (↑(d / 2) : ZMod d) ∧
    (∀ (r : ZMod d), r ≠ 0 →
      (-r = r ↔ r = (↑(d / 2) : ZMod d))) :=
  by
    intro d hd heven
    exact ⟨BellChain.zmod_even_half_nonzero d hd heven,
      BellChain.zmod_even_half_neg d hd heven,
      fun r hr => BellChain.zmod_even_nonzero_involution_iff d hd heven r hr⟩

theorem Claim3 :
  ∀ (d : ℕ) (_hd : Odd d),
    ∀ r : ZMod d, r ≠ 0 → r ≠ -r :=
  by
    exact @BellChain.zmod_odd_no_nonzero_involution

theorem Claim4 :
  ∀ {d : ℕ} [NeZero d]
      (q x : ZMod d) (Q X : ℤ)
      (_hQ : (Q : ZMod d) = q) (_hX : (X : ZMod d) = x),
    BellChain.integerPhase d (Q * X) = BellChain.bellPhase q x :=
  by
    exact @BellChain.bellPhase_arbitrary_representatives

theorem Claim5 :
  ∀ {d : ℕ} [NeZero d] (q x : ZMod d),
    BellChain.bellPhase (-q) x = conj (BellChain.bellPhase q x) :=
  by
    exact @BellChain.bellPhase_neg_eq_conj

theorem Claim6 :
  ∀ {d n : ℕ} [NeZero d]
      (c : Option (Fin n) → ZMod d → ℂ),
    (∑ p : Fin n → ZMod d, ∑ q : Fin n → ZMod d,
        BellChain.weightedEl1 (BellChain.rawCoefficient c p (-q))) = BellChain.physicalAverage c :=
  by
    exact @BellChain.physicalAverage_neg_phase_labels

theorem Claim7 :
  ∀ (d : ℕ) [NeZero d] (v : ZMod d → ℂ),
    (BellChain.stateNormSq v = 0 ↔ ∀ k, v k = 0) ∧ BellChain.weightedEl1 v = BellChain.el1 v :=
  by
    intro d _ v
    exact ⟨BellChain.stateNormSq_eq_zero_iff v, BellChain.weightedEl1_eq_el1 v⟩

theorem Claim8 :
  ∀ (d n : ℕ) [NeZero d] (s x : Fin n → ZMod d) (k : ZMod d),
    (∀ i, x i = BellChain.localLabels s i + BellChain.nextLabel x k i) →
      x = fun i => k + s i :=
  by
    intro d n _ s x k h
    exact BellChain.chain_constraints_unique s x k h

theorem Claim9 :
  ∀ (d n : ℕ) [NeZero d],
    Function.Bijective (BellChain.localLabels (G := ZMod d) (n := n)) :=
  by
    intro d n _
    exact BellChain.localLabels_bijective

theorem Claim10 :
  ∀ {d n : ℕ} [NeZero d]
      (hn : 0 < n) (c : Option (Fin n) → ZMod d → ℂ)
      (s q : Fin n → ZMod d) (u k : ZMod d),
    BellChain.rawEndpoint c (BellChain.localLabels s) q u k =
        if k + s ⟨0, hn⟩ = u then BellChain.shiftCoefficient c s q k else 0 :=
  by
    exact @BellChain.rawEndpoint_eq_shift

theorem Claim11 :
  ∀ {d n : ℕ} [NeZero d] (hn : 0 < n)
    (c : Option (Fin n) → ZMod d → ℂ) (s q : Fin n → ZMod d),
    Function.Bijective (fun k : ZMod d => k + s ⟨0, hn⟩) ∧
    (∑ u, ∑ k, ‖BellChain.rawEndpoint c (BellChain.localLabels s) q u k‖ ^ 2) =
      BellChain.stateNormSq (BellChain.rawCoefficient c (BellChain.localLabels s) q) :=
  by
    intro d n _ hn c s q
    exact ⟨BellChain.endpointPairing_bijective _, BellChain.rawEndpoint_normSq hn c s q⟩

theorem Claim12 :
  ∀ {d n : ℕ} [NeZero d]
      (c : Option (Fin n) → ZMod d → ℂ)
      (s q : Fin n → ZMod d) (k : ZMod d),
    ‖BellChain.shiftCoefficient c s q k‖ =
        (Real.sqrt (d : ℝ))⁻¹ ^ n * ‖c none k‖ * ∏ i, ‖c (some i) (k + s i)‖ :=
  by
    exact @BellChain.norm_shiftCoefficient

theorem Claim13 :
  ∀ {d n : ℕ} [NeZero d]
      (c : Option (Fin n) → ZMod d → ℂ)
      (s q : Fin n → ZMod d) (j k : ZMod d),
    ‖BellChain.shiftCoefficient c s q j‖ * ‖BellChain.shiftCoefficient c s q k‖ =
        ((d : ℝ)^n)⁻¹ * (‖c none j‖ * ‖c none k‖ *
          ∏ i, ‖c (some i) (j + s i)‖ * ‖c (some i) (k + s i)‖) :=
  by
    exact @BellChain.norm_shiftCoefficient_pair

theorem Claim14 :
  ∀ {d n : ℕ} [NeZero d]
      (c : Option (Fin n) → ZMod d → ℂ) (s : Fin n → ZMod d),
    (∑ q : Fin n → ZMod d, BellChain.el1 (BellChain.shiftCoefficient c s q)) =
        ∑ j, ∑ k, if j = k then 0 else
          ‖c none j‖ * ‖c none k‖ *
            ∏ i, ‖c (some i) (j + s i)‖ * ‖c (some i) (k + s i)‖ :=
  by
    exact @BellChain.shift_ent_sum_phase

theorem Claim15 :
  ∀ {d n : ℕ} [NeZero d]
      (c : Option (Fin n) → ZMod d → ℂ),
    BellChain.physicalAverage c = BellChain.correlationMoment c :=
  by
    exact @BellChain.physicalAverage_eq_correlationMoment

theorem Claim16 :
  ∀ {d n : ℕ} [NeZero d]
      (_hn : 0 < n) (c : Option (Fin n) → ZMod d → ℂ)
      (_hc : ∀ i, BellChain.stateNormSq (c i) = 1),
    (∑ p : Fin n → ZMod d, ∑ q : Fin n → ZMod d,
        ∑ u, ∑ k, ‖BellChain.rawEndpoint c p q u k‖ ^ 2) = 1 :=
  by
    exact @BellChain.all_endpoint_probabilities_one

theorem Claim17 :
  ∀ {d n : ℕ} [NeZero d]
      (_hd : 2 ≤ d) (_hn : 1 ≤ n)
      (c : Option (Fin n) → ZMod d → ℂ),
    BellChain.physicalAverage c ≤ BellChain.parityCoefficient d n * ∏ i, BellChain.el1 (c i) :=
  by
    exact @BellChain.physicalAverage_le_parity

theorem Claim18 :
  ∀ {d n : ℕ} [NeZero d]
      (_hd : 2 ≤ d) (_hn : 1 ≤ n) (K : ℝ),
    (∀ c : Option (Fin n) → ZMod d → ℂ,
        (∀ i, BellChain.stateNormSq (c i) = 1) →
          BellChain.physicalAverage c ≤ K * ∏ i, BellChain.el1 (c i)) ↔
        BellChain.parityCoefficient d n ≤ K :=
  by
    exact @BellChain.physicalAverage_uniform_bound_iff

theorem Claim19 :
  ∀ {d n : ℕ} [NeZero d]
      (c : Option (Fin n) → ZMod d → ℂ) (i : Option (Fin n))
      (_hi : BellChain.el1 (c i) = 0),
    BellChain.physicalAverage c = 0 ∧ BellChain.parityCoefficient d n * ∏ j, BellChain.el1 (c j) = 0 :=
  by
    exact @BellChain.physicalAverage_zero_input

theorem Claim20 :
  ∀ (d : ℕ) [NeZero d] (c : ZMod d → ℂ) (_hp : 0 < BellChain.correlationMass c),
    (∀ r, 0 ≤ BellChain.displacementDistribution c r) ∧
    (∀ r, BellChain.displacementDistribution c (-r) = BellChain.displacementDistribution c r) ∧
    (∑ r ∈ Finset.univ.erase (0 : ZMod d), BellChain.displacementDistribution c r) = 1 ∧
    (∀ r, 0 < BellChain.displacementDistribution c r ↔
      ∃ x, c x ≠ 0 ∧ c (x + r) ≠ 0) :=
  by
    intro d _ c hp
    exact ⟨BellChain.displacementDistribution_nonneg c, BellChain.displacementDistribution_neg c,
      BellChain.displacementDistribution_sum c hp,
      fun r => BellChain.displacementDistribution_pos_iff c r hp⟩

theorem Claim21 :
  ∀ {d n : ℕ} [NeZero d]
      (c : Option (Fin n) → ZMod d → ℂ),
    BellChain.physicalAverage c / (∏ i, BellChain.el1 (c i)) =
        ∑ r ∈ Finset.univ.erase (0 : ZMod d), ∏ i, BellChain.displacementDistribution (c i) r :=
  by
    exact @BellChain.physicalAverage_ratio

theorem Claim22 :
  ∀ (d : ℕ) [NeZero d] (c : ZMod d → ℂ) (r : ZMod d)
    (_hr : r ≠ 0) (_hp : 0 < BellChain.correlationMass c),
    BellChain.displacementDistribution c r ≤ 1 ∧
    (Odd d → BellChain.displacementDistribution c r ≤ (1 / 2 : ℝ)) :=
  by
    intro d _ c r hr hp
    exact ⟨BellChain.displacementDistribution_le_one c r hr hp,
      fun hd => BellChain.displacementDistribution_le_half c
        (BellChain.zmod_odd_no_nonzero_involution d hd) r hr hp⟩

theorem Claim23 :
  ∀ (d : ℕ) [NeZero d] {I : Type*} [Fintype I] [DecidableEq I]
    (c : I → ZMod d → ℂ) (_hI : 2 ≤ Fintype.card I)
    (_hp : ∀ i, 0 < BellChain.correlationMass (c i)),
    (∑ r ∈ Finset.univ.erase (0 : ZMod d),
      ∏ i : I, BellChain.displacementDistribution (c i) r) ≤ 1 :=
  by
    intro d _ I _ _ c hI hp
    exact BellChain.displacementDistribution_product_le_one c hI hp

theorem Claim24 :
  ∀ (d : ℕ) [NeZero d] (_hd : Odd d)
    {I : Type*} [Fintype I] [DecidableEq I]
    (c : I → ZMod d → ℂ) (_hI : 2 ≤ Fintype.card I)
    (_hp : ∀ i, 0 < BellChain.correlationMass (c i)),
    (∑ r ∈ Finset.univ.erase (0 : ZMod d),
      ∏ i : I, BellChain.displacementDistribution (c i) r) ≤
        (1 / 2 : ℝ) ^ (Fintype.card I - 1) :=
  by
    intro d _ hd I _ _ c hI hp
    exact BellChain.displacementDistribution_product_le_half_power c hI
      (BellChain.zmod_odd_no_nonzero_involution d hd) hp

theorem Claim25 :
  ∀ (d : ℕ) [NeZero d] (r : ZMod d) (_hr : r ≠ 0),
    (∑ x : ZMod d, ‖BellChain.twoPoint r x‖ ^ 2) = 1 ∧
    BellChain.correlationMass (BellChain.twoPoint r) = 24 / 25 ∧
    (∀ s, BellChain.nonzeroDifference (BellChain.twoPoint r) s ↔ s = r ∨ s = -r) ∧
    (∀ s, BellChain.correlation (BellChain.twoPoint r) s =
      (if s = 0 then (1 : ℝ) else 0) +
      (12 / 25 : ℝ) * (if s = r then 1 else 0) +
      (12 / 25 : ℝ) * (if s = -r then 1 else 0)) :=
  by
    intro d _ r hr
    exact ⟨BellChain.twoPoint_normalized r hr, BellChain.twoPoint_mass r hr,
      fun s => BellChain.twoPoint_nonzeroDifference r s hr,
      fun s => BellChain.twoPoint_correlation r s hr⟩

theorem Claim26 :
  ∀ {d n : ℕ} [NeZero d] (_hd : 2 ≤ d),
    (∀ i : Option (Fin n), BellChain.stateNormSq (BellChain.sharpInput d n i) = 1 ∧
      BellChain.el1 (BellChain.sharpInput d n i) = 24 / 25 ∧ 0 < BellChain.el1 (BellChain.sharpInput d n i)) ∧
    0 < ∏ i : Option (Fin n), BellChain.el1 (BellChain.sharpInput d n i) :=
  by
    intro d n _ hd
    constructor
    · intro i
      exact ⟨BellChain.sharpInput_normalized hd i, BellChain.sharpInput_el1 hd i, BellChain.sharpInput_el1_pos hd i⟩
    · exact Finset.prod_pos (fun i _ => BellChain.sharpInput_el1_pos hd i)

theorem Claim27 :
  ∀ {d n : ℕ} [NeZero d]
      (_hd : 2 ≤ d) (_hn : 1 ≤ n) (_heven : Even d),
    BellChain.physicalAverage (BellChain.sharpInput d n) = (24 / 25 : ℝ) ^ (n + 1) :=
  by
    exact @BellChain.sharpInput_even_value

theorem Claim28 :
  ∀ {d n : ℕ} [NeZero d]
      (_hd : 2 ≤ d) (_hn : 1 ≤ n) (_hodd : Odd d),
    BellChain.physicalAverage (BellChain.sharpInput d n) = 2 * (12 / 25 : ℝ) ^ (n + 1) :=
  by
    exact @BellChain.sharpInput_odd_value

theorem Claim29 :
  ∀ {d n : ℕ} [NeZero d]
      (_hd : 2 ≤ d) (_hn : 1 ≤ n) (_heven : Even d)
      (c : Option (Fin n) → ZMod d → ℂ)
      (_hpos : ∀ i, 0 < BellChain.el1 (c i)),
    BellChain.physicalAverage c = ∏ i, BellChain.el1 (c i) ↔
        ∀ i s, BellChain.nonzeroDifference (c i) s ↔ s = (↑(d / 2) : ZMod d) :=
  by
    exact @BellChain.physicalAverage_even_equality_iff

theorem Claim30 :
  ∀ {d n : ℕ} [NeZero d]
      (_hd : 2 ≤ d) (_hn : 1 ≤ n) (_hodd : Odd d)
      (c : Option (Fin n) → ZMod d → ℂ)
      (_hpos : ∀ i, 0 < BellChain.el1 (c i)),
    BellChain.physicalAverage c = (1 / 2 : ℝ) ^ n * ∏ i, BellChain.el1 (c i) ↔
        ∃ r : ZMod d, r ≠ 0 ∧
          ∀ i s, BellChain.nonzeroDifference (c i) s ↔ s = r ∨ s = -r :=
  by
    exact @BellChain.physicalAverage_odd_equality_iff

theorem Claim31 :
  ∀ {d n : ℕ} [NeZero d]
      (_hd : 2 ≤ d) (_hn : 1 ≤ n)
      (c : Option (Fin n) → ZMod d → ℂ),
    BellChain.physicalAverage c = BellChain.parityCoefficient d n * ∏ i, BellChain.el1 (c i) ↔
        (∃ i, BellChain.el1 (c i) = 0) ∨
        ((∀ i, 0 < BellChain.el1 (c i)) ∧
          if Even d then
            ∀ i s, BellChain.nonzeroDifference (c i) s ↔ s = (↑(d / 2) : ZMod d)
          else
            ∃ r : ZMod d, r ≠ 0 ∧
              ∀ i s, BellChain.nonzeroDifference (c i) s ↔ s = r ∨ s = -r) :=
  by
    exact @BellChain.physicalAverage_eq_parity_iff

theorem Claim32 :
  ∀ {d n : ℕ} [NeZero d]
      (c : Option (Fin n) → ZMod d → ℂ),
    BellChain.physicalAverage c = 0 ↔
        ¬ ∃ r : ZMod d, ∀ i, BellChain.nonzeroDifference (c i) r :=
  by
    exact @BellChain.physicalAverage_eq_zero_iff_D

theorem Claim33 :
  (∀ i, BellChain.stateNormSq (BellChain.disjointFiveInputs i) = 1) ∧
      (∀ i, BellChain.el1 (BellChain.disjointFiveInputs i) = 24 / 25) ∧
      BellChain.physicalAverage BellChain.disjointFiveInputs = 0 :=
  by
    exact @BellChain.disjointFiveInputs_certificate

theorem Claim34 :
  BellChain.stateNormSq BellChain.rankThreeInput = 1 ∧
      (∀ i, BellChain.rankThreeInput i ≠ 0) ∧
      BellChain.el1 BellChain.rankThreeInput = 16 / 9 ∧ 1 < BellChain.el1 BellChain.rankThreeInput :=
  by
    exact @BellChain.rankThreeInput_certificate

end EDEGFormalization

-- Collect dependencies of all declarations created in this module, including compiler auxiliaries.
open Lean in
run_cmd do
  let env ← getEnv
  let mut entries : Array (String × Array String) := #[]
  for (name, _) in env.constants.map₂.toList do
    let axioms ← Lean.collectAxioms name
    entries := entries.push (name.toString, axioms.map Name.toString)
  logInfo m!"EDEG_KERNEL_AXIOMS: {(toJson entries).compress}"
