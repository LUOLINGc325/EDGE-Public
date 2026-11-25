import LogLinearization
import SaddleRates

/-! The exact rescaling of the finite deficits for the two sub-KL orders. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

noncomputable def blockScale (I : ℝ) (n : ℕ) : ℝ :=
  Real.sqrt (n : ℝ) * Real.exp ((n : ℝ) * I)

theorem block_scale_tendsto_atTop {I : ℝ} (hI : 0 < I) :
    Tendsto (fun n : ℕ => blockScale I (n + 1)) atTop atTop := by
  have hSucc : Tendsto (fun n : ℕ => n + 1) atTop atTop := tendsto_atTop.2 fun m =>
    (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n))
  have hNat : Tendsto (fun n : ℕ => ((n + 1 : ℕ) : ℝ)) atTop atTop :=
    tendsto_natCast_atTop_atTop.comp hSucc
  have hExp : Tendsto (fun n : ℕ => Real.exp (((n + 1 : ℕ) : ℝ) * I)) atTop atTop := by
    simpa only [Function.comp_apply, mul_comm] using Real.tendsto_exp_atTop.comp (hNat.const_mul_atTop hI)
  apply tendsto_atTop.2
  intro M
  filter_upwards [hExp.eventually (eventually_ge_atTop M)] with n hn
  apply hn.trans
  unfold blockScale
  apply le_mul_of_one_le_left (Real.exp_nonneg _)
  exact (Real.le_sqrt (show (0 : ℝ) ≤ 1 by norm_num) (Nat.cast_nonneg _)).mpr (by
    rw [one_pow]
    exact_mod_cast (show 1 ≤ n + 1 from Nat.succ_le_succ (Nat.zero_le n)))

theorem uniform_scaled_log_follows {α : Type*} (S : ℕ → ℝ) (B G : ℕ → α → ℝ)
    (hS : Tendsto S atTop atTop) {C : ℝ} (hC : 0 ≤ C)
    (hB : ∀ᶠ n in atTop, ∀ a, 0 ≤ B n a ∧ B n a < 1)
    (hG : ∀ᶠ n in atTop, ∀ a, G n a ≤ C)
    (hLimit : ∀ ε > 0, ∀ᶠ n in atTop, ∀ a, |S n * B n a - G n a| < ε)
    {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop, ∀ a, |S n * (-Real.log (1 - B n a)) - G n a| < ε := by
  have hUB : ∀ᶠ n in atTop, ∀ a, 0 ≤ B n a ∧ B n a < 1 ∧ S n * B n a ≤ C + 1 := by
    filter_upwards [hB, hG, hLimit 1 zero_lt_one] with n hn hn' hn''
    intro a
    exact ⟨(hn a).1, (hn a).2, by linarith only [(abs_lt.mp (hn'' a)).2, hn' a]⟩
  have hHalf : 0 < ε / 2 := div_pos hε (by norm_num)
  have hLog := uniform_scaled_log_linearization S B hS (add_nonneg hC zero_le_one) hUB hHalf
  filter_upwards [hLog, hLimit (ε / 2) hHalf] with n hn hn'
  intro a
  exact (abs_sub_le (S n * (-Real.log (1 - B n a))) (S n * B n a) (G n a)).trans_lt
    (by linarith only [hn a, hn' a])

theorem uniform_divide_by_positive_family {α : Type*} (f g : ℕ → α → ℝ) (d : α → ℝ)
    {m : ℝ} (hm : 0 < m) (hD : ∀ a, m ≤ d a)
    (hLimit : ∀ ε > 0, ∀ᶠ n in atTop, ∀ a, |f n a - g n a| < ε)
    {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop, ∀ a, |f n a / d a - g n a / d a| < ε := by
  filter_upwards [hLimit (ε * m) (mul_pos hε hm)] with n hn
  intro a
  have hPos : 0 < d a := hm.trans_le (hD a)
  rw [← sub_div, abs_div, abs_of_pos hPos]
  exact (div_lt_iff₀ hPos).2 ((hn a).trans_le (mul_le_mul_of_nonneg_left (hD a) hε.le))

variable {κ : Type*} [Fintype κ]

theorem product_missing_probability_bounds (p q : FiniteMass κ)
    (hq : ∀ i, 0 < q i) (n : ℕ) {b a : ℝ} (hb : 0 < b) (ha : 0 < a) :
    0 ≤ productMissing p q n b a ∧ productMissing p q n b a < 1 := by
  unfold productMissing
  rw [← scalar_moment_of_products]
  have hPos := scalar_moment_pos (FiniteMass.tensor (fun _ : Fin n => p))
    (FiniteMass.tensor (fun _ : Fin n => q)) b ha
  have hLt := scalar_moment_lt_one (FiniteMass.tensor (fun _ : Fin n => p))
    (FiniteMass.tensor (fun _ : Fin n => q)) b hb ha (FiniteMass.tensor_pos _ (fun _ i => hq i))
  exact ⟨sub_nonneg.mpr hLt.le, by linarith only [hPos]⟩

theorem fixed_scaled_product_missing (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (n : ℕ) (b a θ : ℝ) :
    blockScale (-logCumulant p q θ) n * productMissing p q n b a =
      Real.sqrt (n : ℝ) * (FiniteMass.tensor (fun _ : Fin n => tiltedMass p q θ)).expect
        (fun x => tiltedKernel b a θ (iidSum (logLikelihood p q) x)) := by
  have hZ : (tiltNormalizer p q θ) ^ n = Real.exp ((n : ℝ) * logCumulant p q θ) := by
    rw [Real.exp_nat_mul, logCumulant, Real.exp_log (tilt_normalizer_pos p q θ)]
  rw [product_missing_tilt p q hp hq n b a θ, hZ]
  unfold blockScale
  have hE : Real.exp ((n : ℝ) * -logCumulant p q θ) * Real.exp ((n : ℝ) * logCumulant p q θ) = 1 := by
    rw [← Real.exp_add, mul_neg, neg_add_cancel, Real.exp_zero]
  rw [mul_assoc, ← mul_assoc (Real.exp _), hE, one_mul]
  simp only [iidSum, likelihoodSum]

theorem growing_scaled_product_missing (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (n : ℕ) (a θ r : ℝ) :
    blockScale (-(logCumulant p q θ + θ * r)) n *
        productMissing p q n (Real.exp ((n : ℝ) * r)) a =
      Real.sqrt (n : ℝ) * (FiniteMass.tensor (fun _ : Fin n => tiltedMass p q θ)).expect
        (fun x => growingTiltedKernel (Real.exp ((n : ℝ) * r)) a θ
          (iidSum (fun i => logLikelihood p q i + r) x)) := by
  rw [product_missing_centered_tilt p q hp hq n a θ r]
  unfold blockScale
  have hE : Real.exp ((n : ℝ) * -(logCumulant p q θ + θ * r)) *
      Real.exp ((n : ℝ) * (logCumulant p q θ + θ * r)) = 1 := by
    rw [← Real.exp_add, mul_neg, neg_add_cancel, Real.exp_zero]
  rw [mul_assoc, ← mul_assoc (Real.exp _), hE, one_mul]
  have hPoint (x : Fin n → κ) :
      iidSum (fun i => logLikelihood p q i + r) x = likelihoodSum p q x + (n : ℝ) * r := by
    rw [iid_sum_shift]
    simp only [iidSum, likelihoodSum]
  simp_rw [hPoint]

end RenyiProductOrderPhase
