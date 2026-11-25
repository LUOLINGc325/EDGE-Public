import SmoothedFourierSum

/-! The convolution formula in the original finite probability model. -/

open scoped BigOperators
open Set MeasureTheory

namespace RenyiProductOrderPhase

theorem shifted_window_indicator (T x a b s z : ℝ) :
    (Ioc (x + a - s) (x + b - s)).indicator (smoothingKernel T) z =
      smoothingKernel T z *
        (Ioc (x + a - z) (x + b - z)).indicator (fun _ => (1 : ℝ)) s := by
  classical
  have h : z ∈ Ioc (x + a - s) (x + b - s) ↔ s ∈ Ioc (x + a - z) (x + b - z) := by
    change (x + a - s < z ∧ z ≤ x + b - s) ↔ (x + a - z < s ∧ s ≤ x + b - z)
    constructor <;> intro ht <;> constructor <;> linarith only [ht.1, ht.2]
  by_cases hz : z ∈ Ioc (x + a - s) (x + b - s)
  · rw [indicator_of_mem hz, indicator_of_mem (h.mp hz), mul_one]
  · rw [indicator_of_not_mem hz, indicator_of_not_mem (fun hs => hz (h.mpr hs)), mul_zero]

theorem smoothed_shift_integrable {T : ℝ} (hT : 0 < T) (x a b s : ℝ) :
    Integrable (fun z => smoothingKernel T z *
      (Ioc (x + a - z) (x + b - z)).indicator (fun _ => (1 : ℝ)) s) :=
  ((smoothing_kernel_integrable hT).indicator measurableSet_Ioc).congr
    (Filter.Eventually.of_forall (shifted_window_indicator T x a b s))

theorem smoothed_shift_integral (T x : ℝ) {a b : ℝ} (hab : a ≤ b) (s : ℝ) :
    (∫ v in a..b, smoothingKernel T (x + v - s)) =
      ∫ z, smoothingKernel T z *
        (Ioc (x + a - z) (x + b - z)).indicator (fun _ => (1 : ℝ)) s := by
  calc
    _ = ∫ z in (x + a - s)..(x + b - s), smoothingKernel T z := by
      simp_rw [show ∀ v : ℝ, x + v - s = (x - s) + v from fun v => by ring]
      rw [intervalIntegral.integral_comp_add_left,
        show (x - s) + a = x + a - s by ring, show (x - s) + b = x + b - s by ring]
    _ = ∫ z, (Ioc (x + a - s) (x + b - s)).indicator (smoothingKernel T) z := by
      rw [integral_indicator measurableSet_Ioc,
        intervalIntegral.integral_of_le (by linarith only [hab])]
    _ = _ := integral_congr_ae (Filter.Eventually.of_forall (shifted_window_indicator T x a b s))

variable {κ : Type*} [Fintype κ]

theorem kernel_times_event_sum (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    (T x a b z : ℝ) :
    smoothingKernel T z * finiteSumEvent p Y n (Ioc (x + a - z) (x + b - z)) =
      ∑ q : Fin n → κ, FiniteMass.tensor (fun _ : Fin n => p) q *
        (smoothingKernel T z *
          (Ioc (x + a - z) (x + b - z)).indicator (fun _ => (1 : ℝ)) (iidSum Y q)) := by
  unfold finiteSumEvent FiniteMass.expect
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun q _ => ?_
  ring

theorem kernel_times_event_integrable (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    {T : ℝ} (hT : 0 < T) (x a b : ℝ) :
    Integrable (fun z => smoothingKernel T z *
      finiteSumEvent p Y n (Ioc (x + a - z) (x + b - z))) := by
  simp_rw [kernel_times_event_sum p Y n T x a b]
  exact integrable_finset_sum Finset.univ (fun q _ =>
    (smoothed_shift_integrable hT x a b (iidSum Y q)).const_mul _)

theorem smoothed_finite_convolution (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    {T a b : ℝ} (hT : 0 < T) (hab : a ≤ b) (x : ℝ) :
    smoothedIntervalMass p Y n T x a b =
      ∫ z, smoothingKernel T z * finiteSumEvent p Y n (Ioc (x + a - z) (x + b - z)) := by
  unfold smoothedIntervalMass FiniteMass.expect
  simp_rw [smoothed_shift_integral T x hab, ← integral_const_mul,
    kernel_times_event_sum p Y n T x a b]
  exact (integral_finset_sum Finset.univ (fun q _ =>
    (smoothed_shift_integrable hT x a b (iidSum Y q)).const_mul _)).symm

end RenyiProductOrderPhase
