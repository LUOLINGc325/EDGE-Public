import FourierSmoothedUniform
import Desmoothing

/-! The location-uniform interval local limit theorem for a finite nonarithmetic law. -/

open Set

namespace RenyiProductOrderPhase

theorem exists_small_smoothing_tail {d ε : ℝ} (hd : 0 < d) (hε : 0 < ε) :
    ∃ T > 0, smoothingTail T d ≤ ε := by
  let A := Real.pi ^ 2 * d * ε
  have hA : 0 < A := mul_pos (mul_pos (pow_pos Real.pi_pos 2) hd) hε
  let T := 2 / A
  have hT : 0 < T := div_pos (by norm_num) hA
  refine ⟨T, hT, (smoothing_tail_bound hT hd).2.trans_eq ?_⟩
  have hProd : Real.pi ^ 2 * T * d * ε = 2 := by
    calc
      _ = A * (2 / A) := by unfold T A; ring
      _ = _ := mul_div_cancel₀ _ hA.ne'
  apply (div_eq_iff (mul_pos (mul_pos (pow_pos Real.pi_pos 2) hT) hd).ne').2
  nlinarith only [hProd]

variable {κ : Type*} [Fintype κ]

theorem finite_closed_interval_concentration (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (Y : κ → ℝ) (hNon : ¬ ArithmeticSupport Y) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) {h : ℝ} (hh : 0 < h) :
    ∃ C > 0, ∃ N : ℕ, ∀ n ≥ N, ∀ x : ℝ,
      Real.sqrt ((n + 1 : ℕ) : ℝ) *
        finiteSumEvent p Y (n + 1) (Icc x (x + h)) ≤ C := by
  let d := h / 4
  let v := p.expect (fun i => Y i ^ 2)
  let G := Real.sqrt (Real.pi / (2 * Real.pi ^ 2 * v))
  have hd : 0 < d := div_pos hh (by norm_num)
  have hG : 0 ≤ G := Real.sqrt_nonneg _
  obtain ⟨T, hT, hTail⟩ := exists_small_smoothing_tail hd (by norm_num : (0 : ℝ) < 1 / 2)
  obtain ⟨N, hN⟩ := smoothed_uniform_gaussian p hp Y hNon hm hv
    (T := T) (a := -d) (b := h + d) hT (by linarith only [hh, hd]) zero_lt_one
  let C := 2 * ((h + 2 * d) * G + 1)
  have hC : 0 < C := by
    unfold C
    positivity
  refine ⟨C, hC, N, ?_⟩
  intro n hn x
  let r := Real.sqrt ((n + 1 : ℕ) : ℝ)
  let q := finiteSumEvent p Y (n + 1) (Icc x (x + h))
  let g := gaussianProfile v (n + 1) x
  let S := smoothedIntervalMass p Y (n + 1) T x (-d) (h + d)
  have hr : 0 ≤ r := Real.sqrt_nonneg _
  have hq : 0 ≤ q := finite_sum_event_nonneg p Y (n + 1) _
  have hS : r * ((1 - smoothingTail T d) * q) ≤ r * S :=
    mul_le_mul_of_nonneg_left (closed_event_below_smoothed p Y (n + 1) hT hd hh x) hr
  have hQ : (1 / 2) * (r * q) ≤ (1 - smoothingTail T d) * (r * q) :=
    mul_le_mul_of_nonneg_right (by linarith only [hTail]) (mul_nonneg hr hq)
  have hApprox : r * S - ((h + d) - (-d)) * g < 1 :=
    (abs_lt.mp (hN n hn x)).2
  have hGbound : (h + 2 * d) * g ≤ (h + 2 * d) * G :=
    mul_le_mul_of_nonneg_left (gaussian_profile_le_constant v hv (n + 1) x)
      (by linarith only [hh, hd])
  change r * q ≤ C
  unfold C
  nlinarith only [hS, hQ, hApprox, hGbound]

theorem finite_nonarithmetic_interval_local_limit (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (Y : κ → ℝ) (hNon : ¬ ArithmeticSupport Y) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2))
    {h ε : ℝ} (hh : 0 < h) (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ x : ℝ,
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent p Y (n + 1) (Ico x (x + h)) -
        h * gaussianProfile (p.expect (fun i => Y i ^ 2)) (n + 1) x| < ε := by
  obtain ⟨C, hC, N₀, hConc⟩ := finite_closed_interval_concentration p hp Y hNon hm hv hh
  let v := p.expect (fun i => Y i ^ 2)
  let G := Real.sqrt (Real.pi / (2 * Real.pi ^ 2 * v))
  have hG : 0 ≤ G := Real.sqrt_nonneg _
  have hDenG : 0 < 8 * (G + 1) := by linarith only [hG]
  have hDenC : 0 < 4 * (C + 1) := by linarith only [hC]
  let d := min (h / 4) (ε / (8 * (G + 1)))
  have hd : 0 < d := lt_min (div_pos hh (by norm_num)) (div_pos hε hDenG)
  have hEdge : 2 * d < h := by
    have he : d ≤ h / 4 := min_le_left _ _
    linarith only [he, hh]
  have hdG : 2 * d * G ≤ ε / 4 := by
    have he : d * (8 * (G + 1)) ≤ ε := (le_div_iff₀ hDenG).1 (min_le_right _ _)
    nlinarith only [he, hd]
  obtain ⟨T, hT, hsmall⟩ := exists_small_smoothing_tail hd (div_pos hε hDenC)
  let η := smoothingTail T d
  have hη : 0 ≤ η := (smoothing_tail_bound hT hd).1
  have hBudget : η * C ≤ ε / 4 := by
    have he : η * (4 * (C + 1)) ≤ ε := (le_div_iff₀ hDenC).1 hsmall
    nlinarith only [he, hη]
  obtain ⟨N₁, hUp⟩ := smoothed_uniform_gaussian p hp Y hNon hm hv
    (a := -d) (b := h + d) hT (by linarith only [hh, hd]) (show 0 < ε / 4 by linarith)
  obtain ⟨N₂, hDown⟩ := smoothed_uniform_gaussian p hp Y hNon hm hv
    (a := d) (b := h - d) hT (by linarith only [hEdge]) (show 0 < ε / 4 by linarith)
  refine ⟨max N₀ (max N₁ N₂), ?_⟩
  intro n hn x
  have hn₀ : N₀ ≤ n := (le_max_left _ _).trans hn
  have hn₁ : N₁ ≤ n := ((le_max_left _ _).trans (le_max_right _ _)).trans hn
  have hn₂ : N₂ ≤ n := ((le_max_right _ _).trans (le_max_right _ _)).trans hn
  let r := Real.sqrt ((n + 1 : ℕ) : ℝ)
  let g := gaussianProfile v (n + 1) x
  let u := finiteSumEvent p Y (n + 1) (Icc x (x + h))
  let q := finiteSumEvent p Y (n + 1) (Ico x (x + h))
  let s₁ := smoothedIntervalMass p Y (n + 1) T x (-d) (h + d)
  let s₂ := smoothedIntervalMass p Y (n + 1) T x d (h - d)
  have hr : 0 < r := Real.sqrt_pos.2 (by positivity)
  have hg : g ≤ G := gaussian_profile_le_constant v hv (n + 1) x
  have hShift : 2 * d * g ≤ ε / 4 :=
    (mul_le_mul_of_nonneg_left hg (by positivity)).trans hdG
  have hScaleConc (y : ℝ) :
      finiteSumEvent p Y (n + 1) (Icc y (y + h)) ≤ C / r := by
    apply (le_div_iff₀ hr).2
    rw [mul_comm]
    exact hConc n hn₀ y
  have hqu : r * q ≤ r * u := mul_le_mul_of_nonneg_left
    (finite_sum_event_mono p Y _ Ico_subset_Icc_self) hr.le
  have hEdgeUp : r * ((1 - η) * u) ≤ r * s₁ := mul_le_mul_of_nonneg_left
    (closed_event_below_smoothed p Y (n + 1) hT hd hh x) hr.le
  have hTailClosed : η * (r * u) ≤ η * C :=
    mul_le_mul_of_nonneg_left (hConc n hn₀ x) hη
  have hEdgeDown : r * s₂ ≤ r * (q + (C / r) * η) := mul_le_mul_of_nonneg_left
    (smoothed_inner_below_event p Y (n + 1) hT hd hEdge.le hScaleConc x) hr.le
  have hCancel : r * (q + (C / r) * η) = r * q + C * η := by
    calc
      _ = r * q + (r * (C / r)) * η := by ring
      _ = _ := by rw [mul_div_cancel₀ _ hr.ne']
  rw [hCancel] at hEdgeDown
  have hApprox₁ : r * s₁ - ((h + d) - (-d)) * g < ε / 4 :=
    (abs_lt.mp (hUp n hn₁ x)).2
  have hApprox₂ : -(ε / 4) < r * s₂ - ((h - d) - d) * g :=
    (abs_lt.mp (hDown n hn₂ x)).1
  change |r * q - h * g| < ε
  apply abs_lt.mpr
  constructor
  · nlinarith only [hApprox₂, hEdgeDown, hShift, hBudget, hε]
  · nlinarith only [hApprox₁, hqu, hEdgeUp, hTailClosed, hShift, hBudget, hε]

end RenyiProductOrderPhase
