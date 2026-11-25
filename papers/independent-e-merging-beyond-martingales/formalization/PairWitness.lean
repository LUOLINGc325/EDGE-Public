import AdaptiveTree
import OptimalCapital
import Mathlib.Tactic.FinCases

open Finset
open scoped BigOperators

namespace IndependentMerging

abbrev PairAtom := Fin 3

noncomputable def witnessValue (t : ℝ) (a : PairAtom) (b : Bool) : ℝ :=
  if a = 0 then (if b then 1 else 0)
  else if a = 1 then (if b then 0 else 1)
  else t

noncomputable def witnessWeight (t : ℝ) (a : PairAtom) : ℝ :=
  if a = 2 then 1 else t * (t - 1)

noncomputable def witnessMass (t : ℝ) : ℝ := 2 * t * (t - 1) + 1

noncomputable def witnessInput {n : ℕ} (t : ℝ) (z : Fin n → PairAtom) : PairInput n :=
  fun c => witnessValue t (z c.1) c.2

@[simp] theorem witnessValue_zero (t : ℝ) (b : Bool) :
    witnessValue t 0 b = if b then 1 else 0 := by simp [witnessValue]

@[simp] theorem witnessValue_one (t : ℝ) (b : Bool) :
    witnessValue t 1 b = if b then 0 else 1 := by
  simp [witnessValue, (by decide : (1 : PairAtom) ≠ 0)]

@[simp] theorem witnessValue_two (t : ℝ) (b : Bool) : witnessValue t 2 b = t := by
  simp [witnessValue, (by decide : (2 : PairAtom) ≠ 0), (by decide : (2 : PairAtom) ≠ 1)]

@[simp] theorem witnessWeight_zero (t : ℝ) : witnessWeight t 0 = t * (t - 1) := by
  simp [witnessWeight, (by decide : (0 : PairAtom) ≠ 2)]

@[simp] theorem witnessWeight_one (t : ℝ) : witnessWeight t 1 = t * (t - 1) := by
  simp [witnessWeight, (by decide : (1 : PairAtom) ≠ 2)]

@[simp] theorem witnessWeight_two (t : ℝ) : witnessWeight t 2 = 1 := by simp [witnessWeight]

theorem witnessValue_box {t : ℝ} (ht : 1 < t) (a : PairAtom) (b : Bool) :
    0 ≤ witnessValue t a b ∧ witnessValue t a b ≤ t := by
  fin_cases a <;> cases b <;> norm_num [witnessValue] <;> linarith

theorem witnessWeight_nonnegative {t : ℝ} (ht : 1 < t) (a : PairAtom) :
    0 ≤ witnessWeight t a := by
  unfold witnessWeight
  split
  · norm_num
  · exact mul_nonneg (by linarith) (sub_nonneg.mpr ht.le)

theorem witnessWeight_sum (t : ℝ) : (∑ a : PairAtom, witnessWeight t a) = witnessMass t := by
  rw [Fin.sum_univ_three, witnessWeight_zero, witnessWeight_one, witnessWeight_two]
  unfold witnessMass
  ring

noncomputable def atomDelta (a b : PairAtom) : ℝ := if b = a then 1 else 0

theorem atomDelta_nonnegative (a b : PairAtom) : 0 ≤ atomDelta a b := by
  unfold atomDelta
  split <;> norm_num

theorem delta_sum_left (a : PairAtom) : (∑ b : PairAtom, atomDelta a b) = 1 := by
  classical
  simp [atomDelta]

theorem weighted_split_point (a : PairAtom) (f : PairAtom → ℝ) :
    (∑ b : PairAtom, atomDelta a b * f b) = f a := by
  classical
  simp [atomDelta, ite_mul]

variable {n : ℕ}

noncomputable def weightedSum (p : Fin n → PairAtom → ℝ) (g : (Fin n → PairAtom) → ℝ) : ℝ :=
  ∑ z, (∏ i, p i (z i)) * g z

/-- Split the product law by the atom at one selected pair. This identity
uses unnormalized weights and applies to zero-weight branches. -/
theorem weighted_sum_split (p : Fin n → PairAtom → ℝ) (j : Fin n)
    (g : PairAtom → (Fin n → PairAtom) → ℝ) :
    weightedSum p (fun z => g (z j) z) =
      ∑ a, p j a * weightedSum (Function.update p j (atomDelta a)) (g a) := by
  classical
  let rest (z : Fin n → PairAtom) : ℝ :=
    ∏ i ∈ (Finset.univ : Finset (Fin n)).erase j, p i (z i)
  have hp (z : Fin n → PairAtom) : (∏ i, p i (z i)) = p j (z j) * rest z :=
    (Finset.mul_prod_erase Finset.univ (fun i => p i (z i)) (Finset.mem_univ j)).symm
  have hupdate (a : PairAtom) (z : Fin n → PairAtom) :
      (∏ i, Function.update p j (atomDelta a) i (z i)) = atomDelta a (z j) * rest z := by
    rw [← Finset.mul_prod_erase Finset.univ _ (Finset.mem_univ j), Function.update_self]
    congr 1
    apply Finset.prod_congr rfl
    intro i hi
    rw [Function.update_of_ne (Finset.mem_erase.mp hi).1]
  unfold weightedSum
  simp_rw [Finset.mul_sum]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl (fun z _ => ?_)
  rw [hp]
  simp_rw [hupdate]
  symm
  calc
    (∑ a, p j a * (atomDelta a (z j) * rest z * g a z)) =
        ∑ a, atomDelta (z j) a * (p j a * (rest z * g a z)) := by
      apply Finset.sum_congr rfl
      intro a _
      have ha : atomDelta a (z j) = atomDelta (z j) a := by
        simp [atomDelta, eq_comm]
      rw [ha]
      ring
    _ = p j (z j) * rest z * g (z j) z := by rw [weighted_split_point]; ring

theorem weightedSum_mono {p : Fin n → PairAtom → ℝ} {g h : (Fin n → PairAtom) → ℝ}
    (hp : ∀ i a, 0 ≤ p i a) (hgh : ∀ z, g z ≤ h z) :
    weightedSum p g ≤ weightedSum p h :=
  Finset.sum_le_sum fun z _ =>
    mul_le_mul_of_nonneg_left (hgh z) (Finset.prod_nonneg fun i _ => hp i (z i))

theorem weightedSum_product (p q : Fin n → PairAtom → ℝ) :
    weightedSum p (fun z => ∏ i, q i (z i)) = ∏ i, ∑ a, p i a * q i a := by
  unfold weightedSum
  simp_rw [← Finset.prod_mul_distrib]
  exact (Fintype.prod_sum (fun i a => p i a * q i a)).symm

def BothUnread (R : Finset (PairCoord n)) (i : Fin n) : Prop :=
  (i, false) ∈ R ∧ (i, true) ∈ R

noncomputable instance (R : Finset (PairCoord n)) (i : Fin n) : Decidable (BothUnread R i) :=
  inferInstanceAs (Decidable ((i, false) ∈ R ∧ (i, true) ∈ R))

noncomputable def witnessProfile (t : ℝ) (R : Finset (PairCoord n))
    (k : Fin n → PairAtom) (i : Fin n) (a : PairAtom) : ℝ :=
  if BothUnread R i then witnessWeight t a else atomDelta (k i) a

noncomputable def remainingFactor (t : ℝ) (R : Finset (PairCoord n))
    (k : Fin n → PairAtom) (i : Fin n) : ℝ :=
  if BothUnread R i then threeDenominator t
  else if (i, false) ∈ R then max 1 (witnessValue t (k i) false)
  else if (i, true) ∈ R then max 1 (witnessValue t (k i) true)
  else 1

theorem witnessProfile_nonnegative {t : ℝ} (ht : 1 < t)
    (R : Finset (PairCoord n)) (k : Fin n → PairAtom) (i : Fin n) (a : PairAtom) :
    0 ≤ witnessProfile t R k i a := by
  unfold witnessProfile
  split
  · exact witnessWeight_nonnegative ht a
  · exact atomDelta_nonnegative (k i) a

theorem remainingFactor_nonnegative {t : ℝ} (ht : 1 < t)
    (R : Finset (PairCoord n)) (k : Fin n → PairAtom) (i : Fin n) :
    0 ≤ remainingFactor t R k i := by
  unfold remainingFactor
  split
  · exact (threeDenominator_pos ht).le
  · split
    · exact zero_le_one.trans (le_max_left ..)
    · split
      · exact zero_le_one.trans (le_max_left ..)
      · exact zero_le_one

theorem erase_other_membership (R : Finset (PairCoord n)) {i j : Fin n} (h : i ≠ j)
    (b c : Bool) : (i, b) ∈ R.erase (j, c) ↔ (i, b) ∈ R := by
  simp [Finset.mem_erase, show (i, b) ≠ (j, c) from fun he => h (congrArg Prod.fst he)]

theorem witness_profile_erase (t : ℝ) (R : Finset (PairCoord n)) (k : Fin n → PairAtom)
    (j : Fin n) (b : Bool) (a : PairAtom) :
    witnessProfile t (R.erase (j, b)) (Function.update k j a) =
      Function.update (witnessProfile t R k) j (atomDelta a) := by
  ext i z
  by_cases h : i = j
  · subst i
    cases b <;> simp [witnessProfile, BothUnread]
  · simp [witnessProfile, BothUnread, Function.update_of_ne h,
      erase_other_membership R h false b, erase_other_membership R h true b]

theorem remaining_factor_erase_other (t : ℝ) (R : Finset (PairCoord n))
    (k : Fin n → PairAtom) {i j : Fin n} (h : i ≠ j) (b : Bool) (a : PairAtom) :
    remainingFactor t (R.erase (j, b)) (Function.update k j a) i =
      remainingFactor t R k i := by
  simp [remainingFactor, BothUnread, Function.update_of_ne h,
    erase_other_membership R h false b, erase_other_membership R h true b]

end IndependentMerging
