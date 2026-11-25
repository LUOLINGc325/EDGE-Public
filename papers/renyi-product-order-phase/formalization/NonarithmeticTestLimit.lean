import GridApproximationError

/-! Compact-uniform tilted expectations for a finite nonarithmetic law. -/

open Set MeasureTheory

namespace RenyiProductOrderPhase

variable {κ α : Type*} [Fintype κ]

theorem uniform_nonarithmetic_test_limit (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (Y : κ → ℝ) (hNon : ¬ ArithmeticSupport Y) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) (F : α → ℝ → ℝ)
    {c A : ℝ} (hc : 0 < c) (hA : 0 ≤ A) (hMeas : ∀ a, Measurable (F a))
    (hEnv : ∀ a x, |F a x| ≤ A * exponentialEnvelope c x)
    (hUniform : ∀ L : ℕ, ∀ ε > 0, ∃ δ > 0, ∀ a x y,
      x ∈ Icc (-(L : ℝ)) (L : ℝ) → y ∈ Icc (-(L : ℝ)) (L : ℝ) →
      |x - y| < δ → |F a x - F a y| < ε)
    {ε : ℝ} (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ a : α,
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * (FiniteMass.tensor (fun _ : Fin (n + 1) => p)).expect
        (fun x => F a (iidSum Y x)) -
        gaussianHeight (p.expect (fun i => Y i ^ 2)) * (∫ x, F a x)| < ε := by
  let G := gaussianHeight (p.expect (fun i => Y i ^ 2))
  have hG : 0 < G := gaussian_height_pos hv
  let D := ε / (8 * (A + 1))
  let E := ε / (8 * (G * A + 1))
  have hDPos : 0 < 8 * (A + 1) := by positivity
  have hEPos : 0 < 8 * (G * A + 1) := by positivity
  have hD : 0 < D := div_pos hε hDPos
  have hE : 0 < E := div_pos hε hEPos
  obtain ⟨C₀, hC₀, N₀, hUnit⟩ := finite_closed_interval_concentration p hp Y hNon hm hv
    (show (0 : ℝ) < 1 by norm_num)
  obtain ⟨K₀, hK₀, hTailP⟩ := exponential_scaled_expectation_tails p Y hc hC₀.le hD
  obtain ⟨K₁, _, hTailV⟩ := exponential_envelope_tail_small hc hE
  let K := max K₀ K₁
  have hK : 0 < K := hK₀.trans_le (le_max_left _ _)
  obtain ⟨L, hL⟩ := exists_nat_gt K
  have hLPos : 0 < (L : ℝ) := hK.trans hL
  obtain ⟨C, hC, N₁, hWindow⟩ := finite_closed_interval_concentration p hp Y hNon hm hv
    (show 0 < 2 * (L : ℝ) by positivity)
  let B := C + G * (2 * (L : ℝ))
  have hBPos : 0 < 8 * (B + 1) := by unfold B; positivity
  let η := ε / (8 * (B + 1))
  have hη : 0 < η := div_pos hε hBPos
  obtain ⟨h, hh, J, hApprox⟩ := exists_grid_approximation F L hη (hUniform L)
  obtain ⟨N₂, hStep⟩ := uniform_finite_grid_step_limit p hp Y hNon hm hv hh hA
    (div_pos hε (by norm_num : (0 : ℝ) < 2)) J
  refine ⟨max N₀ (max N₁ N₂), ?_⟩
  intro n hn a
  have hn₀ := (le_max_left N₀ (max N₁ N₂)).trans hn
  have hn₁ := ((le_max_left N₁ N₂).trans (le_max_right N₀ (max N₁ N₂))).trans hn
  have hn₂ := ((le_max_right N₁ N₂).trans (le_max_right N₀ (max N₁ N₂))).trans hn
  let r := Real.sqrt ((n + 1 : ℕ) : ℝ)
  have hR : 0 ≤ r := Real.sqrt_nonneg _
  have hConc : r * finiteSumEvent p Y (n + 1) (Ico (-(L : ℝ)) (L : ℝ)) ≤ C := by
    apply le_trans (mul_le_mul_of_nonneg_left (finite_sum_event_mono p Y (n + 1) Ico_subset_Icc_self) hR)
    simpa only [show -(L : ℝ) + 2 * (L : ℝ) = (L : ℝ) by ring] using hWindow n hn₁ (-(L : ℝ))
  let P := FiniteMass.tensor (fun _ : Fin (n + 1) => p)
  have hTail : r * P.expect
      (fun x => if K ≤ |iidSum Y x| then exponentialEnvelope c (iidSum Y x) else 0) ≤ D := by
    apply le_trans _ (hTailP (n + 1) (fun x =>
      (mul_le_mul_of_nonneg_left (finite_sum_event_mono p Y (n + 1) Ico_subset_Icc_self) hR).trans
        (hUnit n hn₀ x))).le
    apply mul_le_mul_of_nonneg_left _ hR
    apply P.expect_mono
    intro x
    change (if K ≤ |iidSum Y x| then exponentialEnvelope c (iidSum Y x) else 0) ≤
      (if K₀ ≤ |iidSum Y x| then exponentialEnvelope c (iidSum Y x) else 0)
    by_cases hx : K ≤ |iidSum Y x|
    · rw [if_pos hx, if_pos ((le_max_left K₀ K₁).trans hx)]
    · rw [if_neg hx]
      split_ifs
      · exact Real.exp_nonneg _
      · exact le_rfl
  have hMeasureTail : (∫ x in {s : ℝ | K ≤ |s|}, exponentialEnvelope c x) ≤ E :=
    (hTailV K (le_max_right _ _)).le
  let f := F a
  let g := gridStep h J f
  have hNear (x : ℝ) (hx : x ∈ Ico (-(L : ℝ)) (L : ℝ)) : |f x - g x| ≤ η :=
    ((hApprox a x).1 hx).le
  have hFar (x : ℝ) (hx : x ∉ Ico (-(L : ℝ)) (L : ℝ)) : g x = 0 := (hApprox a x).2 hx
  have hErr := simultaneous_grid_error_bounds p Y (n + 1) hc hA hη.le hK hL.le
    hConc hTail hMeasureTail (hMeas a) (grid_step_integrable h J f) (hEnv a) hNear hFar
  have hF (j : ℤ) (_ : j ∈ J) : |f (h * (j : ℝ))| ≤ A := by
    apply le_trans (hEnv a _)
    have hx : exponentialEnvelope c (h * (j : ℝ)) ≤ 1 := by
      unfold exponentialEnvelope
      simpa only [Real.exp_zero] using Real.exp_le_exp.mpr
        (mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr hc.le) (abs_nonneg (h * (j : ℝ))))
    exact mul_le_of_le_one_right hA hx
  let O := r * P.expect (fun x => f (iidSum Y x))
  let U := r * P.expect (fun x => g (iidSum Y x))
  let V := G * ∫ x, g x
  let Q := G * ∫ x, f x
  have hOU : |O - U| ≤ η * C + A * D := by
    unfold O U
    rw [← mul_sub, abs_mul, abs_of_nonneg hR]
    exact hErr.1
  have hUV : |U - V| < ε / 2 := hStep n hn₂ f hF
  have hVQ : |V - Q| ≤ G * (η * (2 * (L : ℝ)) + A * E) := by
    unfold V Q
    rw [← mul_sub, abs_mul, abs_of_nonneg hG.le, abs_sub_comm]
    exact mul_le_mul_of_nonneg_left hErr.2 hG.le
  have hA1 : A * D < ε / 8 := by
    have hEq : (8 * (A + 1)) * D = ε := mul_div_cancel₀ _ hDPos.ne'
    nlinarith only [hEq, hD]
  have hA2 : G * A * E < ε / 8 := by
    have hEq : (8 * (G * A + 1)) * E = ε := mul_div_cancel₀ _ hEPos.ne'
    nlinarith only [hEq, hE]
  have hA3 : η * B < ε / 8 := by
    have hEq : (B + 1) * η = ε / 8 := by
      apply (eq_div_iff (by norm_num : (8 : ℝ) ≠ 0)).2
      calc
        _ = (8 * (B + 1)) * η := by ring
        _ = ε := mul_div_cancel₀ _ hBPos.ne'
    calc
      _ = B * η := mul_comm _ _
      _ < (B + 1) * η := mul_lt_mul_of_pos_right (lt_add_of_pos_right _ zero_lt_one) hη
      _ = _ := hEq
  have hSum : η * C + A * D + (ε / 2 + G * (η * (2 * (L : ℝ)) + A * E)) < ε := by
    calc
      _ = η * B + A * D + G * A * E + ε / 2 := by unfold B; ring
      _ < _ := by linarith only [hA1, hA2, hA3, hε]
  change |O - Q| < ε
  exact (abs_sub_le O U Q).trans_lt ((add_le_add_left (abs_sub_le U V Q) _).trans_lt
    (by linarith only [hOU, hUV, hVQ, hSum]))

end RenyiProductOrderPhase
