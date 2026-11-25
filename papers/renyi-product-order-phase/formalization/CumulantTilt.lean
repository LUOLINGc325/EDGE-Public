import HammingReduction

/-! Exact exponential tilting and changes of finite product measure. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def logLikelihood (p q : FiniteMass κ) (y : κ) : ℝ :=
  Real.log (q y / p y)

noncomputable def likelihoodSum {n : ℕ} (p q : FiniteMass κ) (x : Fin n → κ) : ℝ :=
  ∑ i, logLikelihood p q (x i)

theorem exp_likelihood_sum {n : ℕ} (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) (x : Fin n → κ) :
    Real.exp (likelihoodSum p q x) = likelihoodProduct p q x := by
  unfold likelihoodSum likelihoodProduct
  rw [Real.exp_sum]
  refine Finset.prod_congr rfl fun i _ => ?_
  exact Real.exp_log (div_pos (hq (x i)) (hp (x i)))

noncomputable def tiltNormalizer (p q : FiniteMass κ) (s : ℝ) : ℝ :=
  p.expect (fun y => Real.exp (s * logLikelihood p q y))

noncomputable def logCumulant (p q : FiniteMass κ) (s : ℝ) : ℝ :=
  Real.log (tiltNormalizer p q s)

theorem tilt_normalizer_pos (p q : FiniteMass κ) (s : ℝ) : 0 < tiltNormalizer p q s := by
  obtain ⟨y, h⟩ := p.exists_weight_pos
  exact p.expect_pos (fun _ => (Real.exp_pos _).le) h (Real.exp_pos _)

theorem tilt_normalizer_at_zero (p q : FiniteMass κ) : tiltNormalizer p q 0 = 1 := by
  simp only [tiltNormalizer, zero_mul, Real.exp_zero, FiniteMass.expect_const]

noncomputable def tiltedMass (p q : FiniteMass κ) (s : ℝ) : FiniteMass κ where
  weight y := p y * Real.exp (s * logLikelihood p q y) / tiltNormalizer p q s
  weight_nonneg y := div_nonneg (mul_nonneg (p.weight_nonneg y) (Real.exp_pos _).le)
    (tilt_normalizer_pos p q s).le
  total := by
    rw [← Finset.sum_div]
    exact div_self (tilt_normalizer_pos p q s).ne'

@[simp] theorem tilted_mass_apply (p q : FiniteMass κ) (s : ℝ) (y : κ) :
    tiltedMass p q s y = p y * Real.exp (s * logLikelihood p q y) / tiltNormalizer p q s := rfl

theorem tilted_mass_pos (p q : FiniteMass κ) (hp : ∀ y, 0 < p y) (s : ℝ) (y : κ) :
    0 < tiltedMass p q s y :=
  div_pos (mul_pos (hp y) (Real.exp_pos _)) (tilt_normalizer_pos p q s)

theorem tilted_expectation (p q : FiniteMass κ) (s : ℝ) (g : κ → ℝ) :
    (tiltedMass p q s).expect g =
      p.expect (fun y => Real.exp (s * logLikelihood p q y) * g y) / tiltNormalizer p q s := by
  unfold FiniteMass.expect
  rw [Finset.sum_div]
  refine Finset.sum_congr rfl fun y _ => ?_
  simp only [tilted_mass_apply]
  ring

theorem remove_tilt (p q : FiniteMass κ) (s : ℝ) (y : κ) :
    p y = tiltNormalizer p q s * Real.exp (-(s * logLikelihood p q y)) * tiltedMass p q s y := by
  let Z := tiltNormalizer p q s
  let u := s * logLikelihood p q y
  have hZ : 0 < Z := tilt_normalizer_pos p q s
  change p y = Z * Real.exp (-u) * (p y * Real.exp u / Z)
  symm
  calc
    _ = Real.exp (-u) * (Z * (p y * Real.exp u / Z)) := by ring
    _ = Real.exp (-u) * (p y * Real.exp u) := by rw [mul_div_cancel₀ _ hZ.ne']
    _ = p y * (Real.exp (-u) * Real.exp u) := by ring
    _ = _ := by rw [← Real.exp_add, neg_add_cancel, Real.exp_zero, mul_one]

theorem tensor_remove_tilt (p q : FiniteMass κ) (s : ℝ) {n : ℕ} (x : Fin n → κ) :
    FiniteMass.tensor (fun _ : Fin n => p) x =
      (tiltNormalizer p q s) ^ n * Real.exp (-(s * likelihoodSum p q x)) *
        FiniteMass.tensor (fun _ : Fin n => tiltedMass p q s) x := by
  simp only [FiniteMass.tensor_apply]
  calc
    _ = ∏ i, tiltNormalizer p q s * Real.exp (-(s * logLikelihood p q (x i))) *
        tiltedMass p q s (x i) :=
      Finset.prod_congr rfl (fun i _ => remove_tilt p q s (x i))
    _ = _ := by
      simp only [Finset.prod_mul_distrib, Finset.prod_const, Finset.card_univ, Fintype.card_fin]
      rw [← Real.exp_sum, likelihoodSum, Finset.mul_sum, Finset.sum_neg_distrib]

theorem tensor_expect_remove_tilt (p q : FiniteMass κ) (s : ℝ) {n : ℕ} (g : (Fin n → κ) → ℝ) :
    (FiniteMass.tensor (fun _ : Fin n => p)).expect g =
      (tiltNormalizer p q s) ^ n *
        (FiniteMass.tensor (fun _ : Fin n => tiltedMass p q s)).expect
          (fun x => Real.exp (-(s * likelihoodSum p q x)) * g x) := by
  unfold FiniteMass.expect
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun x _ => ?_
  rw [tensor_remove_tilt p q s]
  ring

namespace BinarySymmetricChannel

theorem log_likelihood_flip (w : BinarySymmetricChannel κ) (i : κ) :
    logLikelihood (w.channel false) (w.channel true) (w.flip i) =
      -logLikelihood (w.channel false) (w.channel true) i := by
  unfold logLikelihood
  rw [← w.swaps_reverse i, ← w.swaps i,
    Real.log_div (w.positive false i).ne' (w.positive true i).ne',
    Real.log_div (w.positive true i).ne' (w.positive false i).ne']
  ring

theorem tilt_normalizer_symmetric (w : BinarySymmetricChannel κ) (s : ℝ) :
    tiltNormalizer (w.channel false) (w.channel true) s =
      tiltNormalizer (w.channel false) (w.channel true) (1 - s) := by
  let Y := logLikelihood (w.channel false) (w.channel true)
  unfold tiltNormalizer FiniteMass.expect
  calc
    _ = ∑ i, w.channel false (w.flip i) * Real.exp (s * Y (w.flip i)) :=
      (Equiv.sum_comp w.flip (fun i => w.channel false i * Real.exp (s * Y i))).symm
    _ = _ := by
      refine Finset.sum_congr rfl fun i _ => ?_
      change w.channel false (w.flip i) * Real.exp (s * Y (w.flip i)) =
        w.channel false i * Real.exp ((1 - s) * Y i)
      have hflip : Y (w.flip i) = -Y i := w.log_likelihood_flip i
      have hratio : Real.exp (Y i) = w.channel true i / w.channel false i :=
        Real.exp_log (div_pos (w.positive true i) (w.positive false i))
      rw [← w.swaps i, hflip]
      calc
        _ = w.channel false i * (Real.exp (Y i) * Real.exp (s * -Y i)) := by
          rw [hratio, ← mul_assoc, mul_div_cancel₀ _ (w.positive false i).ne']
        _ = _ := by
          rw [← Real.exp_add, show Y i + s * -Y i = (1 - s) * Y i by ring]

theorem log_cumulant_symmetric (w : BinarySymmetricChannel κ) (s : ℝ) :
    logCumulant (w.channel false) (w.channel true) s =
      logCumulant (w.channel false) (w.channel true) (1 - s) :=
  congrArg Real.log (w.tilt_normalizer_symmetric s)

end BinarySymmetricChannel

end RenyiProductOrderPhase
