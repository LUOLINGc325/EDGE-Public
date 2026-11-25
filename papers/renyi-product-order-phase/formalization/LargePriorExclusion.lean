import SmallPriorExclusion

/-! Moderate and extreme large-prior exclusion for every real order in the sub-KL phases. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

theorem quadratic_exp_lower {x : ℝ} (hx : 0 ≤ x) : x ^ 2 / 4 ≤ Real.exp x := by
  have h := Real.add_one_le_exp (x / 2)
  have h' : x / 2 ≤ Real.exp (x / 2) := by linarith only [h]
  calc
    _ = (x / 2) ^ 2 := by ring
    _ ≤ Real.exp (x / 2) ^ 2 := pow_le_pow_left₀ (div_nonneg hx (by norm_num)) h' 2
    _ = _ := by rw [pow_two, ← Real.exp_add, show x / 2 + x / 2 = x by ring]

theorem exp_ratio_lower_linear {θ t : ℝ} (hθ : 0 < θ) (ht : 1 ≤ t) :
    θ ^ 2 * t / 8 ≤ Real.exp (θ * t) / (t + 1) := by
  have ht₀ : 0 ≤ t := zero_le_one.trans ht
  apply (le_div_iff₀ (by positivity : 0 < t + 1)).2
  calc
    _ ≤ (θ ^ 2 * t / 8) * (2 * t) :=
      mul_le_mul_of_nonneg_left (by linarith only [ht]) (by positivity)
    _ = (θ * t) ^ 2 / 4 := by ring
    _ ≤ _ := quadratic_exp_lower (mul_nonneg hθ.le ht₀)

variable {κ : Type*} [Fintype κ]

theorem eventually_exclude_large_priors (p : FiniteMass κ) (Y : κ → ℝ)
    (V : ℕ → ℝ → ℝ) (g : ℕ → ℝ → ℝ) {θ w C M : ℝ}
    (hθ : 0 < θ) (hM : 0 ≤ M)
    (hg : ∀ n z, 0 ≤ z → min z 1 / 2 ≤ g n z)
    (hLower : ∀ n a, 0 < a →
      Real.sqrt ((n + 1 : ℕ) : ℝ) * (FiniteMass.tensor (fun _ : Fin (n + 1) => p)).expect
        (fun i => Real.exp (-(θ * iidSum Y i)) * g n (a * Real.exp (iidSum Y i)) / Real.log (1 + a)) ≤ V n a)
    (hWindow : ∃ P > 0, ∀ᶠ n : ℕ in atTop, ∀ x : ℝ,
      |x| ≤ (2 / θ) * Real.log ((n + 1 : ℕ) : ℝ) →
      P ≤ Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent p Y (n + 1) (Ico x (x + w)))
    (hExtreme : ∀ᶠ n : ℕ in atTop, ∀ a, 0 < a →
      2 * ((n + 1 : ℕ) : ℝ) * M + 1 ≤ Real.log a → C < V n a) :
    ∃ u > 0, ∀ᶠ n in atTop, ∀ a, u ≤ a → C < V n a := by
  obtain ⟨P, hP, hWindow'⟩ := hWindow
  let k := P * Real.exp (-(θ * w)) / 2
  have hk : 0 < k := div_pos (mul_pos hP (Real.exp_pos _)) (by norm_num)
  let T := max 1 (8 * (C + 1) / (k * θ ^ 2))
  let u := Real.exp T
  have hT : 1 ≤ T := le_max_left _ _
  have hθk : 0 < k * θ ^ 2 := mul_pos hk (pow_pos hθ _)
  have hM₁ : 0 < M + 1 := by linarith
  refine ⟨u, Real.exp_pos _, ?_⟩
  have hS : Tendsto (fun n : ℕ => n + 1) atTop atTop := tendsto_atTop.2 fun m =>
    (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n))
  have hN : Tendsto (fun n : ℕ => ((n + 1 : ℕ) : ℝ)) atTop atTop := tendsto_natCast_atTop_atTop.comp hS
  have hLater : ∀ᶠ n : ℕ in atTop,
      2 * (M + 1) * (C + 1) / k ≤ ((n + 1 : ℕ) : ℝ) := hN.eventually (eventually_ge_atTop _)
  filter_upwards [hWindow', hExtreme, hLater] with n hn he hCal
  intro a hua
  have ha : 0 < a := (Real.exp_pos T).trans_le hua
  let t := Real.log a
  have hta : T ≤ t := by
    have h := Real.log_le_log (Real.exp_pos T) hua
    change Real.log (Real.exp T) ≤ t at h
    rwa [Real.log_exp] at h
  have ht₁ : 1 ≤ t := hT.trans hta
  let N : ℝ := ((n + 1 : ℕ) : ℝ)
  have hN₁ : 1 ≤ N := by
    unfold N
    exact_mod_cast (show 1 ≤ n + 1 from Nat.succ_le_succ (Nat.zero_le n))
  have hNpos : 0 < N := zero_lt_one.trans_le hN₁
  by_cases he' : 2 * N * M + 1 ≤ t
  · exact he a ha he'
  have hUpper : t ≤ 2 * N * M + 1 := (lt_of_not_ge he').le
  have ha₁ : 1 ≤ a := by
    rw [← Real.exp_zero, ← Real.exp_log ha, Real.exp_le_exp]
    exact zero_le_one.trans ht₁
  let D := (2 / θ) * Real.log N
  have hD : 0 ≤ D := mul_nonneg (by positivity) (Real.log_nonneg hN₁)
  let m := min t D
  have hm : 0 ≤ m := le_min (zero_le_one.trans ht₁) hD
  let x := -m
  have hx : |x| ≤ D := by
    unfold x
    rw [abs_neg, abs_of_nonneg hm]
    exact min_le_right _ _
  let d := Real.exp (θ * (m - w)) / (2 * (t + 1))
  have hDen : 0 < t + 1 := by linarith only [ht₁]
  have hd : 0 ≤ d := div_nonneg (Real.exp_nonneg _) (by positivity)
  have hStep : d * P ≤ V n a := by
    apply le_trans _ (hLower n a ha)
    apply scaled_window_kernel_lower p Y (n + 1) (g n) ha hd (hg n) (hn x hx)
    intro s hs
    have hLoc : -t ≤ s := (neg_le_neg (min_le_left t D)).trans hs.1
    apply le_trans _ (large_prior_kernel_lower ha₁ hLoc (hg n _ (mul_nonneg ha.le (Real.exp_nonneg _))))
    apply div_le_div_of_nonneg_right _ (by positivity)
    apply Real.exp_le_exp.2
    have hs' : s < -m + w := hs.2
    nlinarith only [mul_le_mul_of_nonneg_left hs'.le hθ.le]
  have hEq : d * P = k * (Real.exp (θ * m) / (t + 1)) := by
    unfold d k
    rw [show θ * (m - w) = θ * m + -(θ * w) by ring, Real.exp_add, ← div_div]
    ring
  rw [hEq] at hStep
  rcases le_or_gt t D with h | h
  · have hcal : 8 * (C + 1) ≤ t * (k * θ ^ 2) :=
      (div_le_iff₀ hθk).1 ((le_max_right _ _).trans hta)
    have hQ : C + 1 ≤ k * (θ ^ 2 * t / 8) := by nlinarith only [hcal]
    have hR := mul_le_mul_of_nonneg_left (exp_ratio_lower_linear hθ ht₁) hk.le
    have hm' : m = t := min_eq_left h
    rw [hm'] at hStep
    exact (lt_add_of_pos_right C zero_lt_one).trans_le (hQ.trans (hR.trans hStep))
  · have hm' : m = D := min_eq_right h.le
    have hDexp : Real.exp (θ * D) = N ^ 2 := by
      have hFactor : θ * D = 2 * Real.log N := by
        unfold D
        rw [← mul_assoc, mul_div_cancel₀ _ hθ.ne']
      rw [hFactor, show 2 * Real.log N = Real.log N + Real.log N by ring,
        Real.exp_add, Real.exp_log hNpos, pow_two]
    have hTmax : t + 1 ≤ 2 * N * (M + 1) := by
      nlinarith only [hUpper, hN₁]
    have hDen' : 0 < 2 * N * (M + 1) := by positivity
    have hR : N / (2 * (M + 1)) ≤ N ^ 2 / (t + 1) := by
      calc
        _ = N ^ 2 / (2 * N * (M + 1)) := by
          field_simp [hNpos.ne', hM₁.ne']
          ring
        _ ≤ _ := div_le_div_of_nonneg_left (sq_nonneg N) hDen hTmax
    have hCal' : 2 * (M + 1) * (C + 1) ≤ N * k := (div_le_iff₀ hk).1 hCal
    have hQ : C + 1 ≤ k * (N / (2 * (M + 1))) := by
      rw [← mul_div_assoc]
      apply (le_div_iff₀ (by positivity : 0 < 2 * (M + 1))).2
      nlinarith only [hCal']
    rw [hm', hDexp] at hStep
    exact (lt_add_of_pos_right C zero_lt_one).trans_le
      (hQ.trans ((mul_le_mul_of_nonneg_left hR hk.le).trans hStep))

end RenyiProductOrderPhase
