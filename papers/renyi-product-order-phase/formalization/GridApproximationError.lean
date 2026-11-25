import GridApproximation
import ExponentialEnvelopeMeasure

/-! The common finite-law and Lebesgue error bound for compact grid approximations. -/

open scoped BigOperators
open Set MeasureTheory

namespace RenyiProductOrderPhase

namespace FiniteMass

variable {ι : Type*} [Fintype ι]

theorem expect_add_functions (p : FiniteMass ι) (f g : ι → ℝ) :
    p.expect (fun x => f x + g x) = p.expect f + p.expect g := by
  unfold expect
  simp only [mul_add, Finset.sum_add_distrib]

theorem expect_scale_function (p : FiniteMass ι) (f : ι → ℝ) (c : ℝ) :
    p.expect (fun x => c * f x) = c * p.expect f := by
  unfold expect
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun x _ => ?_
  ring

theorem abs_expect_sub_le (p : FiniteMass ι) (f g : ι → ℝ) :
    |p.expect f - p.expect g| ≤ p.expect (fun x => |f x - g x|) := by
  unfold expect
  rw [← Finset.sum_sub_distrib]
  apply (Finset.abs_sum_le_sum_abs _ _).trans_eq
  refine Finset.sum_congr rfl fun x _ => ?_
  rw [← mul_sub, abs_mul, abs_of_nonneg (p.weight_nonneg x)]

end FiniteMass

variable {κ : Type*} [Fintype κ]

theorem simultaneous_grid_error_bounds (p : FiniteMass κ) (Y : κ → ℝ)
    (n : ℕ) {c A η K L C D E : ℝ} (hc : 0 < c) (hA : 0 ≤ A) (hη : 0 ≤ η)
    (hK : 0 < K) (hKL : K ≤ L)
    (hC : Real.sqrt (n : ℝ) * finiteSumEvent p Y n (Ico (-L) L) ≤ C)
    (hD : Real.sqrt (n : ℝ) * (FiniteMass.tensor (fun _ : Fin n => p)).expect
      (fun x => if K ≤ |iidSum Y x| then exponentialEnvelope c (iidSum Y x) else 0) ≤ D)
    (hE : (∫ x in {s : ℝ | K ≤ |s|}, exponentialEnvelope c x) ≤ E)
    {f g : ℝ → ℝ} (hf : Measurable f) (hg : Integrable g)
    (hEnv : ∀ x, |f x| ≤ A * exponentialEnvelope c x)
    (hNear : ∀ x ∈ Ico (-L) L, |f x - g x| ≤ η)
    (hFar : ∀ x ∉ Ico (-L) L, g x = 0) :
    Real.sqrt (n : ℝ) * |(FiniteMass.tensor (fun _ : Fin n => p)).expect (fun x => f (iidSum Y x)) -
        (FiniteMass.tensor (fun _ : Fin n => p)).expect (fun x => g (iidSum Y x))| ≤ η * C + A * D ∧
      |(∫ x, f x) - ∫ x, g x| ≤ η * (2 * L) + A * E := by
  classical
  let r := Real.sqrt (n : ℝ)
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let S := Ico (-L) L
  let T := {s : ℝ | K ≤ |s|}
  let U (x : ℝ) := S.indicator (fun _ => (1 : ℝ)) x
  let V (x : ℝ) := T.indicator (exponentialEnvelope c) x
  have hS : MeasurableSet S := measurableSet_Ico
  have hT : MeasurableSet T := (isClosed_le continuous_const continuous_abs).measurableSet
  have hV₀ (x : ℝ) : 0 ≤ V x := by
    by_cases hx : x ∈ T
    · unfold V exponentialEnvelope
      rw [indicator_of_mem hx]
      exact Real.exp_nonneg _
    · unfold V
      rw [indicator_of_not_mem hx]
  have hBound (x : ℝ) : |f x - g x| ≤ η * U x + A * V x := by
    by_cases hx : x ∈ S
    · unfold U
      rw [indicator_of_mem hx, mul_one]
      exact (hNear x hx).trans (le_add_of_nonneg_right (mul_nonneg hA (hV₀ x)))
    · have hxAbs : K ≤ |x| := by
        apply le_of_not_gt
        intro hh
        have h := abs_lt.mp hh
        exact hx ⟨by linarith only [h.1, hKL], h.2.trans_le hKL⟩
      unfold U V
      rw [hFar x hx, sub_zero, indicator_of_not_mem hx, mul_zero, zero_add,
        indicator_of_mem (show x ∈ T from hxAbs)]
      exact hEnv x
  have hI : Integrable (exponentialEnvelope c) := exponential_envelope_integrable hc
  have hVI : Integrable V := hI.indicator hT
  have hVolume : volume S = ENNReal.ofReal (2 * L) := by
    unfold S
    rw [Real.volume_Ico, show L - -L = 2 * L by ring]
  have hUI : Integrable U := by
    unfold U
    rw [integrable_indicator_iff hS]
    apply integrableOn_const.2
    right
    rw [hVolume]
    exact ENNReal.ofReal_lt_top
  have hF : Integrable f :=
    (hI.const_mul A).mono' hf.aestronglyMeasurable
      (Filter.Eventually.of_forall (fun x => by simpa only [Real.norm_eq_abs] using hEnv x))
  constructor
  · have hVIndicator : (fun x : Fin n → κ => V (iidSum Y x)) =
        fun x => if K ≤ |iidSum Y x| then exponentialEnvelope c (iidSum Y x) else 0 := by
      funext x
      change V (iidSum Y x) = _
      by_cases hx : K ≤ |iidSum Y x|
      · unfold V T
        rw [indicator_of_mem (show iidSum Y x ∈ {s : ℝ | K ≤ |s|} from hx), if_pos hx]
      · unfold V T
        rw [indicator_of_not_mem (show iidSum Y x ∉ {s : ℝ | K ≤ |s|} from hx), if_neg hx]
    have hVP : r * P.expect (fun x => V (iidSum Y x)) ≤ D := by
      rw [hVIndicator]
      exact hD
    calc
      _ ≤ r * P.expect (fun x => |f (iidSum Y x) - g (iidSum Y x)|) :=
        mul_le_mul_of_nonneg_left (P.abs_expect_sub_le _ _) (Real.sqrt_nonneg _)
      _ ≤ r * P.expect (fun x => η * U (iidSum Y x) + A * V (iidSum Y x)) :=
        mul_le_mul_of_nonneg_left (P.expect_mono (fun x => hBound (iidSum Y x))) (Real.sqrt_nonneg _)
      _ = η * (r * finiteSumEvent p Y n S) + A * (r * P.expect (fun x => V (iidSum Y x))) := by
        rw [FiniteMass.expect_add_functions, FiniteMass.expect_scale_function, FiniteMass.expect_scale_function]
        change r * (η * finiteSumEvent p Y n S + A * P.expect (fun x => V (iidSum Y x))) = _
        ring
      _ ≤ _ := add_le_add (mul_le_mul_of_nonneg_left hC hη) (mul_le_mul_of_nonneg_left hVP hA)
  · have hUVal : (∫ x, U x) = 2 * L := by
      unfold U
      rw [integral_indicator_const 1 hS]
      change (volume S).toReal * 1 = _
      rw [hVolume, ENNReal.toReal_ofReal (by linarith only [hK, hKL]), mul_one]
    have hVVal : (∫ x, V x) ≤ E := by
      unfold V
      rw [integral_indicator hT]
      exact hE
    calc
      _ = ‖∫ x, f x - g x‖ := by rw [integral_sub hF hg, Real.norm_eq_abs]
      _ ≤ ∫ x, |f x - g x| := by
        simpa only [Real.norm_eq_abs] using norm_integral_le_integral_norm (fun x => f x - g x)
      _ ≤ ∫ x, η * U x + A * V x := integral_mono (hF.sub hg).abs
        ((hUI.const_mul η).add (hVI.const_mul A)) hBound
      _ = η * (2 * L) + A * ∫ x, V x := by
        rw [integral_add (hUI.const_mul η) (hVI.const_mul A), integral_const_mul,
          integral_const_mul, hUVal]
      _ ≤ _ := add_le_add_left (mul_le_mul_of_nonneg_left hVVal hA) _

end RenyiProductOrderPhase
