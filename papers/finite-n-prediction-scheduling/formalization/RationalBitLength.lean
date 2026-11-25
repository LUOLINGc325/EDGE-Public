import StreamingBudget

/-! Converting the explicit rational heights to polynomial bit bounds. -/

namespace FiniteFrontier

theorem nat_succ_le_power_two (n : ℕ) : (n : ℝ) + 1 ≤ 2 ^ n := by
  induction n with
  | zero => norm_num
  | succ n ih =>
    rw [Nat.cast_succ, pow_succ]
    have hn : 0 ≤ (n : ℝ) := by positivity
    linarith only [hn, ih]

theorem encoding_base_le_power_two (n b : ℕ) (B : ℝ)
    (hB₀ : 1 ≤ B) (hB : B ≤ (2 : ℝ) ^ b) :
    encodingBase n B ≤ (2 : ℝ) ^ (b + n + 5) := by
  have hp : 1 ≤ (2 : ℝ) ^ b := by exact one_le_pow₀ (by norm_num)
  have hb : B + 1 ≤ (2 : ℝ) ^ (b + 1) := by
    rw [pow_succ]
    linarith only [hB, hp]
  unfold encodingBase
  calc
    _ ≤ 16 * (2 : ℝ) ^ n * (2 : ℝ) ^ (b + 1) :=
      mul_le_mul (mul_le_mul_of_nonneg_left (nat_succ_le_power_two n) (by norm_num))
        hb (by linarith only [hB₀]) (by positivity)
    _ = _ := by
      rw [show (16 : ℝ) = (2 : ℝ) ^ (4 : ℕ) by norm_num,
        ← pow_add, ← pow_add]
      congr 1
      omega

/-- The output entries admit signed numerator and positive denominator encodings
with at most this polynomial exponent plus two sign and endpoint bits. -/
theorem scheduling_snapshot_entry_bit_length {n : ℕ} (b : ℕ) (B : ℝ)
    (hB₀ : 1 ≤ B) (hB : B ≤ (2 : ℝ) ^ b) (y : Fin n → ℝ)
    (hy : ∀ i, 0 ≤ y i) (hs : Monotone y) (R : ℝ)
    (hR : baselineRobustness (n : ℝ) ≤ R) (P Q : ℤ) (hQ : 0 < Q)
    (hRrat : R = (P : ℝ) / (Q : ℝ)) (hP : |(P : ℝ)| ≤ B)
    (hQb : |(Q : ℝ)| ≤ B) (hpred : ∀ i, FractionHeight (y i) B)
    (k : ℕ) (i : Fin n) :
    FractionHeight ((synthesizeSorted y hy hs R hR).attained k i)
      ((2 : ℝ) ^ ((b + n + 5) * (n * (n + 3)))) := by
  apply (synthesized_entry_height y hy hs R hR P Q hQ hRrat B hB₀ hP hQb hpred k i).mono
  calc
    _ ≤ ((2 : ℝ) ^ (b + n + 5)) ^ (n * (n + 3)) :=
      pow_le_pow_left₀ (by unfold encodingBase; positivity)
        (encoding_base_le_power_two n b B hB₀ hB) _
    _ = _ := (pow_mul _ _ _).symm

end FiniteFrontier
