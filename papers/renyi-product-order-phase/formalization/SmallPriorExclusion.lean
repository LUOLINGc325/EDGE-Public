import PriorBoundaryEstimates
import GridApproximationError
import DeficitScaling

/-! Uniform exclusion of arbitrarily small priors by displaced central windows. -/

open scoped Topology
open Set Filter

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem finite_sum_event_lower_expectation (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    (S : Set ℝ) (f : ℝ → ℝ) (d : ℝ) (h₀ : ∀ x, 0 ≤ f x) (hS : ∀ x ∈ S, d ≤ f x) :
    d * finiteSumEvent p Y n S ≤
      (FiniteMass.tensor (fun _ : Fin n => p)).expect (fun x => f (iidSum Y x)) := by
  classical
  unfold finiteSumEvent
  rw [← FiniteMass.expect_scale_function]
  apply FiniteMass.expect_mono
  intro x
  change d * S.indicator (fun _ => (1 : ℝ)) (iidSum Y x) ≤ f (iidSum Y x)
  by_cases hx : iidSum Y x ∈ S
  · rw [indicator_of_mem hx, mul_one]
    exact hS _ hx
  · rw [indicator_of_not_mem hx, mul_zero]
    exact h₀ _

theorem normalized_tilted_gap_nonneg {g : ℝ → ℝ} {a θ s : ℝ} (ha : 0 < a)
    (hg : min (a * Real.exp s) 1 / 2 ≤ g (a * Real.exp s)) :
    0 ≤ Real.exp (-(θ * s)) * g (a * Real.exp s) / Real.log (1 + a) := by
  have h : 0 ≤ min (a * Real.exp s) 1 / 2 :=
    div_nonneg (le_min (mul_nonneg ha.le (Real.exp_nonneg _)) zero_le_one) (by norm_num)
  exact div_nonneg (mul_nonneg (Real.exp_nonneg _) (h.trans hg)) (Real.log_pos (by linarith)).le

theorem scaled_window_kernel_lower (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    (g : ℝ → ℝ) {a θ x w d P : ℝ} (ha : 0 < a) (hd : 0 ≤ d)
    (hg : ∀ z, 0 ≤ z → min z 1 / 2 ≤ g z)
    (hP : P ≤ Real.sqrt (n : ℝ) * finiteSumEvent p Y n (Ico x (x + w)))
    (hLocal : ∀ s ∈ Ico x (x + w),
      d ≤ Real.exp (-(θ * s)) * g (a * Real.exp s) / Real.log (1 + a)) :
    d * P ≤ Real.sqrt (n : ℝ) *
      (FiniteMass.tensor (fun _ : Fin n => p)).expect (fun i =>
        Real.exp (-(θ * iidSum Y i)) * g (a * Real.exp (iidSum Y i)) / Real.log (1 + a)) := by
  let f (s : ℝ) := Real.exp (-(θ * s)) * g (a * Real.exp s) / Real.log (1 + a)
  have hF : ∀ s, 0 ≤ f s := fun s => normalized_tilted_gap_nonneg ha
    (hg _ (mul_nonneg ha.le (Real.exp_nonneg _)))
  have h := finite_sum_event_lower_expectation p Y n (Ico x (x + w)) f d hF hLocal
  calc
    _ ≤ d * (Real.sqrt (n : ℝ) * finiteSumEvent p Y n (Ico x (x + w))) :=
      mul_le_mul_of_nonneg_left hP hd
    _ = Real.sqrt (n : ℝ) * (d * finiteSumEvent p Y n (Ico x (x + w))) := by ring
    _ ≤ _ := mul_le_mul_of_nonneg_left h (Real.sqrt_nonneg _)

theorem log_nat_succ_tendsto : Tendsto (fun n : ℕ => Real.log ((n + 1 : ℕ) : ℝ)) atTop atTop := by
  have hS : Tendsto (fun n : ℕ => n + 1) atTop atTop := tendsto_atTop.2 fun m =>
    (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n))
  exact Real.tendsto_log_atTop.comp (tendsto_natCast_atTop_atTop.comp hS)

theorem eventually_exclude_small_priors (p : FiniteMass κ) (Y : κ → ℝ)
    (V : ℕ → ℝ → ℝ) (g : ℕ → ℝ → ℝ) {θ w C : ℝ} (hθ : θ < 1) (hw : 0 < w) (hC : 0 ≤ C)
    (hg : ∀ n z, 0 ≤ z → min z 1 / 2 ≤ g n z)
    (hLower : ∀ n a, 0 < a →
      Real.sqrt ((n + 1 : ℕ) : ℝ) * (FiniteMass.tensor (fun _ : Fin (n + 1) => p)).expect
        (fun i => Real.exp (-(θ * iidSum Y i)) * g n (a * Real.exp (iidSum Y i)) / Real.log (1 + a)) ≤ V n a)
    (hWindow : ∃ P > 0, ∀ᶠ n : ℕ in atTop, ∀ x : ℝ,
      |x| ≤ Real.log ((n + 1 : ℕ) : ℝ) + w →
      P ≤ Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent p Y (n + 1) (Ico x (x + w))) :
    ∃ l > 0, ∀ᶠ n in atTop, ∀ a, 0 < a → a ≤ l → C < V n a := by
  obtain ⟨P, hP, hWindow'⟩ := hWindow
  have hθ₀ : 0 < 1 - θ := sub_pos.mpr hθ
  let X := (2 * (C + 1) / P) / (1 - θ)
  have hX : 0 < X := div_pos (div_pos (by positivity) hP) hθ₀
  let T := X + w
  let l := Real.exp (-T)
  refine ⟨l, Real.exp_pos _, ?_⟩
  have hLog : ∀ᶠ n in atTop, T ≤ Real.log ((n + 1 : ℕ) : ℝ) :=
    log_nat_succ_tendsto.eventually (eventually_ge_atTop T)
  filter_upwards [hLog, hWindow'] with n hn hN
  intro a ha ha'
  have hT : T ≤ -Real.log a := by
    have hh := Real.log_le_log ha ha'
    change Real.log a ≤ Real.log (Real.exp (-T)) at hh
    rw [Real.log_exp] at hh
    linarith only [hh]
  let x := min (-Real.log a) (Real.log ((n + 1 : ℕ) : ℝ)) - w
  have hx : X ≤ x := by
    unfold x
    have h := le_min hT hn
    unfold T at h
    linarith only [h]
  have hxB : |x| ≤ Real.log ((n + 1 : ℕ) : ℝ) + w := by
    rw [abs_of_pos (hX.trans_le hx)]
    unfold x
    have h := min_le_right (-Real.log a) (Real.log ((n + 1 : ℕ) : ℝ))
    linarith only [h, hw]
  let d := Real.exp ((1 - θ) * x) / 2
  have hd : 0 ≤ d := div_nonneg (Real.exp_nonneg _) (by norm_num)
  have hStep : d * P ≤ V n a := by
    apply le_trans _ (hLower n a ha)
    apply scaled_window_kernel_lower p Y (n + 1) (g n) ha hd (hg n) (hN x hxB)
    intro s hs
    have hs' : s ≤ -Real.log a := by
      have hh : x + w ≤ -Real.log a := by
        unfold x
        rw [sub_add_cancel]
        exact min_le_left _ _
      exact hs.2.le.trans hh
    apply le_trans _ (small_prior_kernel_lower ha hs' (hg n _ (mul_nonneg ha.le (Real.exp_nonneg _))))
    exact div_le_div_of_nonneg_right
      (Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left hs.1 hθ₀.le)) (by norm_num)
  have hEq : P * ((1 - θ) * X) = 2 * (C + 1) := by
    unfold X
    rw [mul_div_cancel₀ _ hθ₀.ne', mul_div_cancel₀ _ hP.ne']
  have hExp := Real.add_one_le_exp ((1 - θ) * X)
  have hBd : (1 - θ) * X ≤ Real.exp ((1 - θ) * x) := by
    apply le_trans (le_add_of_nonneg_right zero_le_one)
    exact hExp.trans (Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left hx hθ₀.le))
  have hh := mul_le_mul_of_nonneg_left hBd hP.le
  have hFinal : C < d * P := by
    unfold d
    nlinarith only [hh, hEq]
  exact hFinal.trans_le hStep

end RenyiProductOrderPhase
