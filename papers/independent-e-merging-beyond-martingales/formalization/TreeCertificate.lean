import PairWitness

open Finset
open scoped BigOperators

namespace IndependentMerging

variable {n : ℕ}

theorem remaining_factor_after_read (t : ℝ) (R : Finset (PairCoord n))
    (k : Fin n → PairAtom) (j : Fin n) (b : Bool) (a : PairAtom) :
    remainingFactor t (R.erase (j, b)) (Function.update k j a) j =
      if (j, !b) ∈ R then max 1 (witnessValue t a (!b)) else 1 := by
  cases b <;> simp [remainingFactor, BothUnread, Finset.mem_erase]

theorem unread_pair_scalar_identity {t : ℝ} (ht : 1 < t) (b : Bool)
    (s : Set.Icc (0 : ℝ) 1) :
    (∑ a, witnessWeight t a * (betFactor s (witnessValue t a b) *
      max 1 (witnessValue t a (!b)))) = threeDenominator t := by
  rw [Fin.sum_univ_three]
  cases b <;> norm_num [betFactor, threeDenominator,
    max_eq_right ht.le] <;> ring

/-- The potential bound for one choice of unread coordinate, under its
current restricted pair law. -/
theorem pair_read_potential {t : ℝ} (ht : 1 < t) (R : Finset (PairCoord n))
    (k : Fin n → PairAtom) (j : Fin n) (b : Bool) (hc : (j, b) ∈ R)
    (s : Set.Icc (0 : ℝ) 1) :
    (∑ a, witnessProfile t R k j a * (betFactor s (witnessValue t a b) *
      remainingFactor t (R.erase (j, b)) (Function.update k j a) j)) ≤
      remainingFactor t R k j := by
  have hpair : BothUnread R j ↔ (j, !b) ∈ R := by
    cases b <;> simp [BothUnread, hc]
  by_cases hop : (j, !b) ∈ R
  · have hfull := hpair.mpr hop
    simp_rw [witnessProfile, if_pos hfull, remaining_factor_after_read, if_pos hop]
    rw [unread_pair_scalar_identity ht b s, remainingFactor, if_pos hfull]
  · have hhalf : ¬BothUnread R j := fun h => hop (hpair.mp h)
    simp_rw [witnessProfile, if_neg hhalf, remaining_factor_after_read, if_neg hop, mul_one]
    rw [weighted_split_point]
    have hu : remainingFactor t R k j = max 1 (witnessValue t (k j) b) := by
      cases b <;> simp_all [remainingFactor]
    rw [hu]
    exact ReadTree.factor_le_max s _

theorem weightedSum_const_mul (p : Fin n → PairAtom → ℝ) (c : ℝ)
    (g : (Fin n → PairAtom) → ℝ) :
    weightedSum p (fun z => c * g z) = c * weightedSum p g := by
  unfold weightedSum
  rw [Finset.mul_sum]
  exact Finset.sum_congr rfl fun z _ => by ring

/-- Certificate for every adaptive reveal tree and every compatible reference
assignment for the already revealed pairs. -/
theorem ReadTree.witness_certificate {R : Finset (PairCoord n)} (T : ReadTree n R)
    {t : ℝ} (ht : 1 < t) (k : Fin n → PairAtom) :
    weightedSum (witnessProfile t R k) (fun z => T.unitPayoff (witnessInput t z)) ≤
      ∏ i, remainingFactor t R k i := by
  classical
  induction T generalizing k with
  | done =>
    have he : (fun z : Fin n → PairAtom =>
        (ReadTree.done (n := n)).unitPayoff (witnessInput t z)) = (fun z => ∏ _i : Fin n, (1 : ℝ)) := by
      funext z
      simp
    rw [he, weightedSum_product _ (fun _ _ => (1 : ℝ))]
    simp [witnessProfile, BothUnread, remainingFactor, delta_sum_left]
  | @bet R c hc s next ih =>
    obtain ⟨j, b⟩ := c
    let rest := ∏ i ∈ (Finset.univ : Finset (Fin n)).erase j, remainingFactor t R k i
    have hrest : 0 ≤ rest :=
      Finset.prod_nonneg fun i _ => remainingFactor_nonnegative ht R k i
    have hafter (a : PairAtom) :
        (∏ i, remainingFactor t (R.erase (j, b)) (Function.update k j a) i) =
          remainingFactor t (R.erase (j, b)) (Function.update k j a) j * rest := by
      rw [← Finset.mul_prod_erase Finset.univ _ (Finset.mem_univ j)]
      congr 1
      apply Finset.prod_congr rfl
      intro i hi
      exact remaining_factor_erase_other t R k (Finset.mem_erase.mp hi).1 b a
    have hstart :
        (∏ i, remainingFactor t R k i) = remainingFactor t R k j * rest :=
      (Finset.mul_prod_erase Finset.univ _ (Finset.mem_univ j)).symm
    simp only [ReadTree.unitPayoff_bet, witnessInput]
    rw [weighted_sum_split (witnessProfile t R k) j
      (fun a z => betFactor s (witnessValue t a b) *
        (next (witnessValue t a b)).unitPayoff (witnessInput t z))]
    simp_rw [weightedSum_const_mul, ← witness_profile_erase t R k j b]
    calc
      _ ≤ ∑ a, witnessProfile t R k j a * (betFactor s (witnessValue t a b) *
          (∏ i, remainingFactor t (R.erase (j, b)) (Function.update k j a) i)) := by
        apply Finset.sum_le_sum
        intro a _
        exact mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left
          (ih (witnessValue t a b) (Function.update k j a))
          (ReadTree.factor_nonnegative s (witnessValue_box ht a b).1))
          (witnessProfile_nonnegative ht R k j a)
      _ = (∑ a, witnessProfile t R k j a * (betFactor s (witnessValue t a b) *
          remainingFactor t (R.erase (j, b)) (Function.update k j a) j)) * rest := by
        rw [Finset.sum_mul]
        apply Finset.sum_congr rfl
        intro a _
        rw [hafter a]
        ring
      _ ≤ _ := by
        rw [hstart]
        exact mul_le_mul_of_nonneg_right (pair_read_potential ht R k j b hc s) hrest

theorem ReadTree.root_witness_certificate (T : ReadTree n Finset.univ) {t : ℝ} (ht : 1 < t) :
    weightedSum (fun _ : Fin n => witnessWeight t) (fun z => T.unitPayoff (witnessInput t z)) ≤
      threeDenominator t ^ n := by
  have h := T.witness_certificate ht (fun _ => 0)
  have hp : witnessProfile t Finset.univ (fun _ : Fin n => 0) =
      (fun _ => witnessWeight t) := by
    funext i a
    simp [witnessProfile, BothUnread]
  rw [hp] at h
  simpa [remainingFactor, BothUnread] using h

end IndependentMerging
