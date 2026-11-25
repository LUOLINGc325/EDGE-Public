import PriorBoundaryEstimates
import SmallPriorExclusion

/-! Exact least-likelihood product atoms and the finite-block endpoint sandwich. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

namespace FiniteMass

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

theorem expect_tensor_product [DecidableEq ι] (p : ι → FiniteMass κ) (f : ι → κ → ℝ) :
    (tensor p).expect (fun x => ∏ i, f i (x i)) =
      ∏ i, (p i).expect (f i) := by
  unfold expect
  calc
    _ = ∑ x : ι → κ, ∏ i, p i (x i) * f i (x i) := by
      refine Finset.sum_congr rfl fun x _ => ?_
      simp only [tensor_apply, Finset.prod_mul_distrib]
    _ = _ := (Fintype.prod_sum (fun (i : ι) (y : κ) => p i y * f i y)).symm

end FiniteMass

variable {κ : Type*} [Fintype κ]

noncomputable def endpointAtomMass (p q : FiniteMass κ) (M : ℝ) : ℝ := by
  classical
  exact p.expect (fun i => if logLikelihood p q i = -M then 1 else 0)

theorem endpoint_atom_mass_bounds (p q : FiniteMass κ) (hp : ∀ i, 0 < p i)
    {M : ℝ} (hAtom : ∃ i, logLikelihood p q i = -M) (hOther : ∃ i, logLikelihood p q i ≠ -M) :
    0 < endpointAtomMass p q M ∧ endpointAtomMass p q M < 1 := by
  classical
  obtain ⟨i, hi⟩ := hAtom
  obtain ⟨j, hj⟩ := hOther
  unfold endpointAtomMass
  constructor
  · exact p.expect_pos
      (fun _ => by split_ifs <;> norm_num)
      (hp i) (by rw [if_pos hi]; exact zero_lt_one)
  · calc
      _ < p.expect (fun _ => 1) := p.expect_strict
        (fun _ => by split_ifs <;> norm_num)
        (hp j) (by rw [if_neg hj]; exact zero_lt_one)
      _ = _ := p.expect_const 1

theorem likelihood_sum_at_endpoint_iff (p q : FiniteMass κ) {M : ℝ}
    (hM : ∀ i, -M ≤ logLikelihood p q i) {n : ℕ} (x : Fin n → κ) :
    likelihoodSum p q x = -(n : ℝ) * M ↔ ∀ i, logLikelihood p q (x i) = -M := by
  constructor
  · intro hs i
    have hZ : (∑ j : Fin n, (logLikelihood p q (x j) + M)) = 0 := by
      simp only [Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ,
        Fintype.card_fin, nsmul_eq_mul]
      change likelihoodSum p q x + (n : ℝ) * M = 0
      rw [hs]
      ring
    have he := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => by linarith only [hM (x j)])).1 hZ
      i (Finset.mem_univ i)
    linarith only [he]
  · intro hs
    unfold likelihoodSum
    simp only [hs, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, mul_neg, neg_mul]

theorem endpoint_atom_product_probability (p q : FiniteMass κ) {M : ℝ}
    (hM : ∀ i, -M ≤ logLikelihood p q i) (n : ℕ) :
    finiteSumEvent p (logLikelihood p q) n {-(n : ℝ) * M} = endpointAtomMass p q M ^ n := by
  classical
  let f (y : κ) : ℝ := if logLikelihood p q y = -M then 1 else 0
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  have hPoint (x : Fin n → κ) :
      ({-(n : ℝ) * M} : Set ℝ).indicator (fun _ => (1 : ℝ)) (iidSum (logLikelihood p q) x) =
        ∏ i, f (x i) := by
    by_cases h : ∀ i, logLikelihood p q (x i) = -M
    · have hSum : iidSum (logLikelihood p q) x ∈ ({-(n : ℝ) * M} : Set ℝ) :=
        (likelihood_sum_at_endpoint_iff p q hM x).2 h
      rw [indicator_of_mem hSum]
      simp only [f, if_pos (h _), Finset.prod_const_one]
    · obtain ⟨i, hi⟩ := not_forall.mp h
      have hSum : iidSum (logLikelihood p q) x ∉ ({-(n : ℝ) * M} : Set ℝ) :=
        fun hx => h ((likelihood_sum_at_endpoint_iff p q hM x).1 hx)
      rw [indicator_of_not_mem hSum]
      have hZero : f (x i) = 0 := if_neg hi
      exact (Finset.prod_eq_zero (Finset.mem_univ i) hZero).symm
  change P.expect _ = _
  simp_rw [hPoint]
  rw [FiniteMass.expect_tensor_product (fun _ : Fin n => p) (fun _ => f)]
  simp only [endpointAtomMass, f, Finset.prod_const, Finset.card_univ, Fintype.card_fin]

theorem log_prior_concavity_lower {ε a : ℝ} (hε₀ : 0 ≤ ε) (hε₁ : ε ≤ 1) (ha : 0 < a) :
    ε * Real.log (1 + a) ≤ Real.log (1 + a * ε) := by
  have hx : 1 + a ∈ Ioi (0 : ℝ) := by
    apply mem_Ioi.mpr
    linarith
  have hy : (1 : ℝ) ∈ Ioi 0 := mem_Ioi.mpr zero_lt_one
  have h := strictConcaveOn_log_Ioi.concaveOn.2 hx hy hε₀ (sub_nonneg.mpr hε₁)
    (show ε + (1 - ε) = 1 by ring)
  simp only [smul_eq_mul, Real.log_one, mul_zero, add_zero] at h
  have he : ε * (1 + a) + (1 - ε) * 1 = 1 + a * ε := by ring
  rwa [he] at h

noncomputable def endpointEpsilon (M : ℝ) (n : ℕ) := Real.exp (-(n : ℝ) * M)

noncomputable def endpointLogRate (p q : FiniteMass κ) (M : ℝ) : ℝ :=
  -Real.log (endpointAtomMass p q M)

theorem product_deficit_endpoint_sandwich (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i)
    {M a b : ℝ} (hM₀ : 0 ≤ M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hAtom : 0 < endpointAtomMass p q M)
    (ha : 0 < a) (hb : 0 < b) (n : ℕ) :
    endpointEpsilon M n ≤ productScalarDeficit p q n b a ∧
      productScalarDeficit p q n b a ≤
        ((n : ℝ) * endpointLogRate p q M + b * Real.log (1 + a * endpointEpsilon M n)) /
          (b * Real.log (1 + a)) := by
  let ε := endpointEpsilon M n
  have hε₀ : 0 < ε := Real.exp_pos _
  have hε₁ : ε ≤ 1 := by
    unfold ε endpointEpsilon
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr
      (mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (Nat.cast_nonneg n)) hM₀)
  have hLog : 0 < Real.log (1 + a) := Real.log_pos (by linarith)
  constructor
  · apply le_trans _ (product_deficit_finite_support_lower p q hp hq n hM hb ha)
    exact (le_div_iff₀ hLog).2 (log_prior_concavity_lower hε₀.le hε₁ ha)
  · let A := 1 + a * ε
    let P := FiniteMass.tensor (fun _ : Fin n => p)
    have hA : 0 < A := by unfold A; positivity
    let f (s : ℝ) := (1 + a * Real.exp s) ^ (-b)
    have hF₀ (s : ℝ) : 0 ≤ f s := by unfold f; positivity
    have hF (s : ℝ) (hs : s ∈ ({-(n : ℝ) * M} : Set ℝ)) : A ^ (-b) ≤ f s := by
      have hEq : s = -(n : ℝ) * M := hs
      rw [hEq]
      exact le_rfl
    have h := finite_sum_event_lower_expectation p (logLikelihood p q) n ({-(n : ℝ) * M})
      f (A ^ (-b)) hF₀ hF
    rw [endpoint_atom_product_probability p q hM] at h
    have hExact :
        (fun x : Fin n → κ => f (iidSum (logLikelihood p q) x)) =
          fun x => (1 + a * likelihoodProduct p q x) ^ (-b) := by
      funext x
      unfold f
      change (1 + a * Real.exp (likelihoodSum p q x)) ^ (-b) = _
      rw [exp_likelihood_sum p q hp hq]
    rw [hExact] at h
    change A ^ (-b) * endpointAtomMass p q M ^ n ≤ productScalarMoment p q n b a at h
    have hLogM := Real.log_le_log (mul_pos (Real.rpow_pos_of_pos hA _) (pow_pos hAtom n)) h
    rw [Real.log_mul (Real.rpow_pos_of_pos hA _).ne' (pow_pos hAtom n).ne',
      Real.log_rpow hA, Real.log_pow] at hLogM
    unfold productScalarDeficit
    apply div_le_div_of_nonneg_right _ (mul_nonneg hb.le hLog.le)
    change -Real.log (productScalarMoment p q n b a) ≤
      (n : ℝ) * (-Real.log (endpointAtomMass p q M)) + b * Real.log A
    linarith only [hLogM]

end RenyiProductOrderPhase
