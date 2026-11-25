import ExactFrontier
import RationalUnitBounds

/-! Rational witnesses for every entry and every partial accumulation in the
actual suffix synthesis. The exponent is polynomial in the number of jobs. -/

open scoped BigOperators

namespace FiniteFrontier

variable {n m : ℕ}

theorem encoding_base_ge_twice_input (n : ℕ) (B : ℝ) (hB : 1 ≤ B) :
    2 * B ≤ encodingBase n B := by
  have hmul : 0 ≤ (n : ℝ) * B := by positivity
  unfold encodingBase
  nlinarith only [hB, hmul, show 0 ≤ (n : ℝ) by positivity]

theorem prediction_stage_height (y : Fin n → ℝ) (B : ℝ) (hB : 1 ≤ B)
    (hy : ∀ i, FractionHeight (y i) B) (k : ℕ) :
    FractionHeight (orderedPredictionStage y k) B := by
  cases k with
  | zero => exact FractionHeight.zero B hB
  | succ k =>
    rw [orderedPredictionStage]
    split
    · exact hy _
    · exact FractionHeight.zero B hB

theorem prediction_gap_height (y : Fin n → ℝ) (B : ℝ) (hB : 1 ≤ B)
    (hy : ∀ i, FractionHeight (y i) B) (i : Fin n) :
    FractionHeight (predictionGap y i) (encodingBase n B ^ 2) := by
  unfold predictionGap
  have h := (prediction_stage_height y B hB hy (i.val + 1)).sub
    (prediction_stage_height y B hB hy i.val)
  apply h.mono
  rw [pow_two]
  exact mul_le_mul (encoding_base_ge_twice_input n B hB)
    (by linarith only [hB, encoding_base_ge_twice_input n B hB]) (by positivity)
    (by linarith only [hB, encoding_base_ge_twice_input n B hB])

namespace SnapshotPlan

@[simp] theorem cast_attained {x z : Fin n → ℝ} (h : x = z) (p : SnapshotPlan x) (k : ℕ) :
    (castPrediction h p).attained k = p.attained k := by subst z; rfl

theorem prepend_attained_height {y : Fin m → ℝ} (p : SnapshotPlan y) (H : ℝ)
    (hH : 1 ≤ H) (hp : ∀ k i, FractionHeight (p.attained k i) H) (k : ℕ) (i : Fin (m + 1)) :
    FractionHeight (p.zeroPrepend.attained k i) H := by
  refine Fin.cases ?_ (fun j => ?_) i
  · exact FractionHeight.zero H hH
  · simpa only [zeroPrepend, prepend_zero_succ] using hp (k - 1) j

theorem pad_attained_height {y : Fin m → ℝ} (p : SnapshotPlan y) (H : ℝ)
    (hH : 1 ≤ H) (hp : ∀ k i, FractionHeight (p.attained k i) H) :
    ∀ d k i, FractionHeight ((p.pad d).attained k i) H := by
  intro d
  induction d with
  | zero => exact hp
  | succ d ih => exact prepend_attained_height (p.pad d) H hH ih

end SnapshotPlan

theorem unit_plan_height {R : ℝ} {a : ℕ}
    (b : UnitBranch m R a) (hmn : m ≤ n) (P Q : ℤ) (hQ : 0 < Q)
    (hR : R = (P : ℝ) / (Q : ℝ)) (B : ℝ) (hB : 1 ≤ B)
    (hP : |(P : ℝ)| ≤ B) (hQb : |(Q : ℝ)| ≤ B) (k : ℕ) (i : Fin m) :
    FractionHeight (b.plan.attained k i) (encodingBase n B ^ n) := by
  let K := encodingBase n B
  have hK : 1 ≤ K := (by norm_num : (1 : ℝ) ≤ 2).trans (encoding_base_ge_two n B hB)
  have hp : 1 ≤ K ^ n := one_le_pow₀ hK
  change FractionHeight (if i.val < k then 1 else cappedUnitLevel m R a k) (K ^ n)
  split
  · exact FractionHeight.one _ hp
  let j := min k a
  have hj : j ≤ a := min_le_right _ _
  have h := rational_unit_level_height b hmn hj P Q hQ hR B hB hP hQb
  change FractionHeight (activeUnitLevel m R j) (K ^ n)
  exact h.mono (pow_le_pow_right₀ hK ((Nat.succ_le_of_lt (hj.trans_lt b.index)).trans hmn))

theorem unit_suffix_height (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R)
    (P Q : ℤ) (hQ : 0 < Q) (hRrat : R = (P : ℝ) / (Q : ℝ)) (B : ℝ)
    (hB : 1 ≤ B) (hP : |(P : ℝ)| ≤ B) (hQb : |(Q : ℝ)| ≤ B)
    (i : Fin n) (k : ℕ) (j : Fin n) :
    FractionHeight ((unitSuffixPlan R hR i).attained k j) (encodingBase n B ^ n) := by
  let b := unit_index_is_branch (n - i.val) R (Nat.sub_pos_of_lt i.isLt) (suffix_size_robust hR i)
  have hK : 1 ≤ encodingBase n B := (by norm_num : (1 : ℝ) ≤ 2).trans (encoding_base_ge_two n B hB)
  have h := unit_plan_height b (Nat.sub_le n i.val) P Q hQ hRrat B hB hP hQb
  have hd : 1 ≤ encodingBase n B ^ n := one_le_pow₀ hK
  have lift :
      ∀ (m d : ℕ) (h : m + d = n) (p : SnapshotPlan (fun _ : Fin m => 1)),
        (∀ k i, FractionHeight (p.attained k i) (encodingBase n B ^ n)) →
        FractionHeight ((asSuffixPlan d h p).attained k j) (encodingBase n B ^ n) := by
    intro m d he p hp
    subst n
    simp only [asSuffixPlan, SnapshotPlan.cast_attained]
    exact SnapshotPlan.pad_attained_height p _ hd hp d k j
  exact lift _ i.val (Nat.sub_add_cancel i.isLt.le) b.plan h

theorem synthesized_entry_height (y : Fin n → ℝ) (hy : ∀ i, 0 ≤ y i) (hs : Monotone y)
    (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R)
    (P Q : ℤ) (hQ : 0 < Q) (hRrat : R = (P : ℝ) / (Q : ℝ)) (B : ℝ)
    (hB : 1 ≤ B) (hP : |(P : ℝ)| ≤ B) (hQb : |(Q : ℝ)| ≤ B)
    (hpred : ∀ i, FractionHeight (y i) B) (k : ℕ) (j : Fin n) :
    FractionHeight ((synthesizeSorted y hy hs R hR).attained k j) (encodingBase n B ^ (n * (n + 3))) := by
  unfold synthesizeSorted
  rw [SnapshotPlan.cast_attained]
  change FractionHeight (∑ i : Fin n, predictionGap y i * (unitSuffixPlan R hR i).attained k j) _
  apply finite_assembly_height n (n + 2) _ (encoding_base_ge_two n B hB)
  intro i
  rw [add_comm n 2, pow_add]
  exact (prediction_gap_height y B hB hpred i).mul
    (unit_suffix_height R hR P Q hQ hRrat B hB hP hQb i k j)

theorem synthesized_time_height (y : Fin n → ℝ) (hy : ∀ i, 0 ≤ y i) (hs : Monotone y)
    (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R)
    (P Q : ℤ) (hQ : 0 < Q) (hRrat : R = (P : ℝ) / (Q : ℝ)) (B : ℝ)
    (hB : 1 ≤ B) (hP : |(P : ℝ)| ≤ B) (hQb : |(Q : ℝ)| ≤ B)
    (hpred : ∀ i, FractionHeight (y i) B) (k : ℕ) :
    FractionHeight ((synthesizeSorted y hy hs R hR).time k)
      (encodingBase n B ^ (n * (n * (n + 3) + 1))) := by
  apply finite_assembly_height n (n * (n + 3)) _ (encoding_base_ge_two n B hB)
  intro j
  exact synthesized_entry_height y hy hs R hR P Q hQ hRrat B hB hP hQb hpred k j

end FiniteFrontier
