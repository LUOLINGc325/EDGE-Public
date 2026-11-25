import LikelihoodLegendre
import LatticeExistence
import LatticeWindow
import SoftThresholdBounds
import NegativeLogPriorShape

/-! A subexponential local-window cost under a negative exponential tilt. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem centered_tilt_has_window_mass (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) (s : ℝ) :
    let x := tiltedMean p q s
    let R := tiltedMass p q s
    let Y (i : κ) := logLikelihood p q i + -x
    ∃ w > 0, ∃ c > 0, ∀ᶠ n : ℕ in atTop,
      c ≤ Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent R Y (n + 1) (Ico (-w) 0) := by
  let x := tiltedMean p q s
  let R := tiltedMass p q s
  let Y (i : κ) := logLikelihood p q i + -x
  have hR : ∀ i, 0 < R i := tilted_mass_pos p q hp s
  have hX : tiltedMean p q s = -(-x) := by simp only [neg_neg, x]
  have hm : R.expect Y = 0 := (tilted_shifted_mean p q s (-x)).trans (add_neg_cancel x)
  have hv : 0 < R.expect (fun i => Y i ^ 2) := by
    rw [show R.expect (fun i => Y i ^ 2) = tiltedVariance p q s from tilted_shifted_second_moment p q s (-x) hX]
    exact tilted_variance_pos p q hp hq hne s
  classical
  by_cases hA : ArithmeticSupport Y
  · have hDiff : ∃ i j, Y i ≠ Y j := by
      obtain ⟨i, j, hij⟩ := ratio_nonconstant p q hp hne
      refine ⟨i, j, fun he => hij ?_⟩
      have hL : logLikelihood p q i = logLikelihood p q j := add_right_cancel he
      have h := congrArg Real.exp hL
      unfold logLikelihood at h
      rwa [Real.exp_log (div_pos (hq i) (hp i)), Real.exp_log (div_pos (hq j) (hp j))] at h
    obtain ⟨L⟩ := maximal_lattice_exists hDiff hA
    let w := 2 * L.span
    have hw : 0 < w := mul_pos (by norm_num) L.span_pos
    obtain ⟨c, hc, N, hN⟩ := L.logarithmic_interval_lower R hR hm hv 0 w
    refine ⟨w, hw, c, hc, eventually_atTop.2 ⟨N, ?_⟩⟩
    intro n hn
    have h := hN n hn (-w) (by rw [zero_mul, zero_add, abs_neg, abs_of_pos hw])
    change c ≤ _ * finiteSumEvent R Y (n + 1) (Ico (-w) (-w + w)) at h
    simpa only [neg_add_cancel] using h
  · obtain ⟨c, hc, N, hN⟩ := finite_nonarithmetic_central_window R hR Y hA hm hv
      (w := 1) zero_lt_one 0 1
    refine ⟨1, zero_lt_one, c, hc, eventually_atTop.2 ⟨N, ?_⟩⟩
    intro n hn
    simpa only [neg_add_cancel] using hN n hn (-1) (by simp only [zero_mul, zero_add, abs_neg, abs_one, le_refl])

theorem product_moment_at_tilt_scale_lower (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {r s : ℝ} (hs : s < 0) (hu : 0 < -tiltedMean p q s - r) :
    let x := tiltedMean p q s
    let u := -x - r
    let I := s * x - logCumulant p q s
    ∃ C > 0, ∀ᶠ n : ℕ in atTop,
      C * Real.exp (-(((n + 1 : ℕ) : ℝ) * I)) / Real.sqrt ((n + 1 : ℕ) : ℝ) ≤
        productScalarMoment p q (n + 1) (Real.exp (((n + 1 : ℕ) : ℝ) * r))
          (Real.exp (((n + 1 : ℕ) : ℝ) * u) - 1) := by
  let R := tiltedMass p q s
  let x := tiltedMean p q s
  let Y (i : κ) := logLikelihood p q i + -x
  let u := -x - r
  let I := s * x - logCumulant p q s
  obtain ⟨w, hw, c, hc, hWindow⟩ := centered_tilt_has_window_mass p q hp hq hne s
  let C := c * (Real.exp (-1) * Real.exp (s * w))
  refine ⟨C, mul_pos hc (mul_pos (Real.exp_pos _) (Real.exp_pos _)), ?_⟩
  filter_upwards [hWindow] with n hn
  let m : ℝ := ((n + 1 : ℕ) : ℝ)
  let b := Real.exp (m * r)
  let a := Real.exp (m * u) - 1
  let P := FiniteMass.tensor (fun _ : Fin (n + 1) => p)
  let Q := FiniteMass.tensor (fun _ : Fin (n + 1) => R)
  let H (z : Fin (n + 1) → κ) := likelihoodSum p q z
  let k (z : Fin (n + 1) → κ) := (1 + a * likelihoodProduct p q z) ^ (-b)
  let E := Real.exp (-1) * Real.exp (-(s * (m * x - w)))
  have hm : 0 < m := by unfold m; exact_mod_cast Nat.succ_pos n
  have hb : 0 < b := Real.exp_pos _
  have ha : 0 < a := sub_pos.mpr (by
    rw [← Real.exp_zero, Real.exp_lt_exp]
    exact mul_pos hm hu)
  have hPnt (z : Fin (n + 1) → κ) :
      E * (Ico (-w) 0).indicator (fun _ => (1 : ℝ)) (iidSum Y z) ≤
        Real.exp (-(s * H z)) * k z := by
    by_cases hz : iidSum Y z ∈ Ico (-w) 0
    · rw [indicator_of_mem hz, mul_one]
      have hY : iidSum Y z = H z - m * x := by
        unfold Y
        rw [iid_sum_shift]
        change H z + m * -x = _
        ring
      rw [hY] at hz
      have hLo : m * x - w ≤ H z := by
        have hh := hz.1
        linarith only [hh]
      have hHi : H z ≤ m * x := by
        have hh := hz.2
        linarith only [hh]
      have hE : Real.exp (-(s * (m * x - w))) ≤ Real.exp (-(s * H z)) := by
        exact Real.exp_le_exp.mpr (neg_le_neg (mul_le_mul_of_nonpos_left hLo hs.le))
      have hB : b * (a * Real.exp (H z)) ≤ 1 := by
        calc
          _ ≤ Real.exp (m * r) * (Real.exp (m * u) * Real.exp (m * x)) :=
            mul_le_mul_of_nonneg_left (mul_le_mul (sub_le_self _ zero_le_one)
              (Real.exp_le_exp.mpr hHi) (Real.exp_nonneg _) (Real.exp_nonneg _)) hb.le
          _ = _ := by
            rw [← Real.exp_add, ← Real.exp_add, ← Real.exp_zero]
            congr 1
            unfold u
            ring
      have hLog := (log_one_add_bounds (mul_nonneg ha.le (Real.exp_nonneg (H z)))).2
      have hK : Real.exp (-1) ≤ k z := by
        unfold k
        rw [← exp_likelihood_sum p q hp hq, Real.rpow_def_of_pos (by positivity)]
        change Real.exp (-1) ≤ Real.exp (Real.log (1 + a * Real.exp (H z)) * -b)
        apply Real.exp_le_exp.mpr
        nlinarith only [hB, mul_le_mul_of_nonneg_left hLog hb.le]
      unfold E
      rw [mul_comm (Real.exp (-1))]
      exact mul_le_mul hE hK (Real.exp_nonneg _) (Real.exp_nonneg _)
    · rw [indicator_of_not_mem hz, mul_zero]
      unfold k
      exact mul_nonneg (Real.exp_nonneg _) (Real.rpow_nonneg
        (add_nonneg zero_le_one (mul_nonneg ha.le (likelihood_product_pos p q hp hq z).le)) _)
  have h := Q.expect_mono hPnt
  rw [FiniteMass.expect_scale_function] at h
  change E * finiteSumEvent R Y (n + 1) (Ico (-w) 0) ≤
    Q.expect (fun z => Real.exp (-(s * H z)) * k z) at h
  have hPos : 0 < Real.sqrt m := Real.sqrt_pos.mpr hm
  have hSize : c / Real.sqrt m ≤ finiteSumEvent R Y (n + 1) (Ico (-w) 0) :=
    (div_le_iff₀ hPos).2 (by simpa only [mul_comm] using hn)
  have hEA : E * (c / Real.sqrt m) ≤
      Q.expect (fun z => Real.exp (-(s * H z)) * k z) :=
    (mul_le_mul_of_nonneg_left hSize (mul_nonneg (Real.exp_nonneg _) (Real.exp_nonneg _))).trans h
  have hA := mul_le_mul_of_nonneg_left hEA (pow_nonneg (tilt_normalizer_pos p q s).le (n + 1))
  have hEq : tiltNormalizer p q s ^ (n + 1) * (E * (c / Real.sqrt m)) =
      C * Real.exp (-(m * I)) / Real.sqrt m := by
    have hZ : tiltNormalizer p q s ^ (n + 1) = Real.exp (m * logCumulant p q s) := by
      unfold logCumulant
      rw [mul_comm, Real.exp_mul, Real.exp_log (tilt_normalizer_pos p q s), Real.rpow_natCast]
    rw [hZ]
    unfold E C
    have hExp : Real.exp (m * logCumulant p q s) * Real.exp (-(s * (m * x - w))) =
        Real.exp (s * w) * Real.exp (-(m * I)) := by
      rw [← Real.exp_add, ← Real.exp_add]
      congr 1
      unfold I
      ring
    calc
      _ = c * Real.exp (-1) *
          (Real.exp (m * logCumulant p q s) * Real.exp (-(s * (m * x - w)))) / Real.sqrt m := by ring
      _ = _ := by rw [hExp]; ring
  rw [hEq] at hA
  change _ ≤ P.expect k
  rw [tensor_expect_remove_tilt p q s]
  exact hA

end RenyiProductOrderPhase
