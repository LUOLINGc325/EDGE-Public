import EndpointAtomicSandwich
import PriorAttainment

/-! The superendpoint prior and its exact finite-block quantitative sandwich. -/

namespace RenyiProductOrderPhase

noncomputable def superEndpointTime (M r ell : ℝ) (n : ℕ) : ℝ :=
  Real.sqrt (2 * (n : ℝ) * ell / Real.exp ((n : ℝ) * (r - M)))

noncomputable def superEndpointPrior (M r ell : ℝ) (n : ℕ) : ℝ :=
  Real.exp (superEndpointTime M r ell n) - 1

theorem super_endpoint_time_pos {M r ell : ℝ} (hEll : 0 < ell) {n : ℕ} (hn : 0 < n) :
    0 < superEndpointTime M r ell n := by
  unfold superEndpointTime
  have hN : 0 < (n : ℝ) := by exact_mod_cast hn
  exact Real.sqrt_pos.2 (div_pos (by positivity) (Real.exp_pos _))

theorem super_endpoint_prior_pos {M r ell : ℝ} (hEll : 0 < ell) {n : ℕ} (hn : 0 < n) :
    0 < superEndpointPrior M r ell n := by
  unfold superEndpointPrior
  apply sub_pos.mpr
  simpa only [Real.exp_zero] using Real.exp_lt_exp.mpr
    (super_endpoint_time_pos (M := M) (r := r) hEll hn)

theorem super_endpoint_log_prior {M r ell : ℝ} (n : ℕ) :
    Real.log (1 + superEndpointPrior M r ell n) = superEndpointTime M r ell n := by
  unfold superEndpointPrior
  rw [show 1 + (Real.exp (superEndpointTime M r ell n) - 1) =
    Real.exp (superEndpointTime M r ell n) by ring, Real.log_exp]

variable {κ : Type*} [Fintype κ]

theorem super_endpoint_quantitative_bound (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {M r : ℝ} (hM₀ : 0 ≤ M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hAtom : 0 < endpointAtomMass p q M) (hAtom' : endpointAtomMass p q M < 1)
    {n : ℕ} (hn : 0 < n) :
    let ε := endpointEpsilon M n
    let b := Real.exp ((n : ℝ) * r)
    let ell := endpointLogRate p q M
    let U := superEndpointTime M r ell n
    let a := superEndpointPrior M r ell n
    1 ≤ sInf (productDeficitValues p q n b) / ε ∧
      sInf (productDeficitValues p q n b) / ε ≤ productScalarDeficit p q n b a / ε ∧
      productScalarDeficit p q n b a / ε ≤ U / 2 + (Real.exp U - 1) / U := by
  let ε := endpointEpsilon M n
  let b := Real.exp ((n : ℝ) * r)
  let ell := endpointLogRate p q M
  let U := superEndpointTime M r ell n
  let a := superEndpointPrior M r ell n
  let v := Real.exp ((n : ℝ) * (r - M))
  have hε : 0 < ε := Real.exp_pos _
  have hb : 0 < b := Real.exp_pos _
  have hv : 0 < v := Real.exp_pos _
  have hEll : 0 < ell := neg_pos.mpr (Real.log_neg hAtom hAtom')
  have hU : 0 < U := super_endpoint_time_pos hEll hn
  have ha : 0 < a := super_endpoint_prior_pos hEll hn
  have hlog : Real.log (1 + a) = U := super_endpoint_log_prior n
  obtain ⟨x, hx, hX⟩ := product_deficit_attained p q hp hq hne hn b hb
  have hntr : (0 : ℝ) < n := by exact_mod_cast hn
  have hbε : b * ε = v := by
    unfold b ε endpointEpsilon v
    rw [← Real.exp_add]
    congr 1
    ring
  have hUSq : U ^ 2 * v = 2 * (n : ℝ) * ell := by
    have he : U ^ 2 = 2 * (n : ℝ) * ell / v := by
      apply Real.sq_sqrt
      exact div_nonneg (by positivity) hv.le
    rw [he, div_mul_cancel₀ _ hv.ne']
  have hCal : (n : ℝ) * ell / (v * U) = U / 2 := by
    apply (div_eq_iff (mul_pos hv hU).ne').2
    nlinarith only [hUSq]
  change 1 ≤ sInf (productDeficitValues p q n b) / ε ∧
    sInf (productDeficitValues p q n b) / ε ≤ productScalarDeficit p q n b a / ε ∧
    productScalarDeficit p q n b a / ε ≤ U / 2 + a / U
  have hAt := product_deficit_endpoint_sandwich p q hp hq hM₀ hM hAtom hx hb n
  have hTest := product_deficit_endpoint_sandwich p q hp hq hM₀ hM hAtom ha hb n
  rw [hX.csInf_eq]
  refine ⟨(le_div_iff₀ hε).2 (by simpa only [one_mul] using hAt.1),
    div_le_div_of_nonneg_right (hX.2 ⟨a, ha, rfl⟩) hε.le, ?_⟩
  calc
    _ ≤ (((n : ℝ) * ell + b * Real.log (1 + a * ε)) / (b * U)) / ε :=
      div_le_div_of_nonneg_right (by simpa only [hlog] using hTest.2) hε.le
    _ = (n : ℝ) * ell / (v * U) + Real.log (1 + a * ε) / (ε * U) := by
      rw [← hbε]
      field_simp [hb.ne', hε.ne', hU.ne']
      ring
    _ ≤ U / 2 + a / U := by
      rw [hCal]
      apply add_le_add_left
      have h := (log_one_add_bounds (mul_nonneg ha.le hε.le)).2
      calc
        _ ≤ (a * ε) / (ε * U) := div_le_div_of_nonneg_right h (mul_nonneg hε.le hU.le)
        _ = _ := by
          field_simp [hε.ne', hU.ne']
          ring

theorem exp_sub_one_div_upper {u : ℝ} (hu : 0 < u) :
    (Real.exp u - 1) / u ≤ Real.exp u := by
  have h : 1 - Real.exp (-u) ≤ u := by linarith only [Real.add_one_le_exp (-u)]
  apply (div_le_iff₀ hu).2
  calc
    _ = Real.exp u * (1 - Real.exp (-u)) := by
      rw [mul_sub, mul_one, ← Real.exp_add, add_neg_cancel, Real.exp_zero]
    _ ≤ Real.exp u * u := mul_le_mul_of_nonneg_left h (Real.exp_nonneg _)

end RenyiProductOrderPhase
