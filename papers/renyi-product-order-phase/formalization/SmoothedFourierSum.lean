import SmoothedFourierInterval

/-! A finite product law convolved with the smoothing density. -/

open scoped BigOperators
open Set MeasureTheory

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def finiteSumEvent (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ) (S : Set ℝ) : ℝ :=
  (FiniteMass.tensor (fun _ : Fin n => p)).expect (fun x =>
    Set.indicator S (fun _ => (1 : ℝ)) (iidSum Y x))

theorem finite_sum_event_nonneg (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ) (S : Set ℝ) :
    0 ≤ finiteSumEvent p Y n S := by
  unfold finiteSumEvent
  apply FiniteMass.expect_nonneg
  classical
  intro x
  by_cases hx : iidSum Y x ∈ S <;> simp [hx]

theorem finite_sum_event_le_one (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ) (S : Set ℝ) :
    finiteSumEvent p Y n S ≤ 1 := by
  unfold finiteSumEvent
  have h := (FiniteMass.tensor (fun _ : Fin n => p)).expect_mono
    (f := fun x => Set.indicator S (fun _ => (1 : ℝ)) (iidSum Y x))
    (g := fun _ => (1 : ℝ)) (by
      classical
      intro x
      by_cases hx : iidSum Y x ∈ S
      · simp [hx]
      · simp [hx])
  simpa only [FiniteMass.expect_const] using h

theorem finite_sum_event_mono (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ) {S U : Set ℝ}
    (hSU : S ⊆ U) : finiteSumEvent p Y n S ≤ finiteSumEvent p Y n U := by
  unfold finiteSumEvent
  apply FiniteMass.expect_mono
  classical
  intro x
  by_cases h : iidSum Y x ∈ S
  · simp [h, hSU h]
  · by_cases h' : iidSum Y x ∈ U <;> simp [h, h']

noncomputable def smoothedIntervalMass (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    (T x a b : ℝ) : ℝ :=
  (FiniteMass.tensor (fun _ : Fin n => p)).expect (fun z =>
    ∫ v in a..b, smoothingKernel T (x + v - iidSum Y z))

theorem smoothed_interval_fourier_power (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ)
    {T a b : ℝ} (hT : 0 < T) (hab : a ≤ b) (x : ℝ) :
    (smoothedIntervalMass p Y n T x a b : ℂ) =
      ∫ t, (fourierPhase (t * x) * intervalFourierFactor T a b t) *
        characteristic p Y (-t) ^ n := by
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let A := intervalFourierFactor T a b
  have hA := interval_fourier_factor_continuous T hab
  have hInt (z : Fin n → κ) :
      Integrable (fun t => (P z : ℂ) *
        ((fourierPhase (t * x) * A t) * fourierPhase (-t * iidSum Y z))) := by
    apply continuous_cutoff_integrable (T := T)
    · exact continuous_const.mul
        (((fourier_phase_continuous.comp (continuous_id.mul continuous_const)).mul hA).mul
          (fourier_phase_continuous.comp (continuous_neg.mul continuous_const)))
    · intro t ht
      have hbnd : T < |t| := lt_of_not_ge (fun he => ht (abs_le.mp he))
      simp [A, interval_fourier_factor_zero hT hbnd.le a b]
  unfold smoothedIntervalMass
  rw [← FiniteMass.complex_expect_coe]
  simp_rw [smoothing_interval_fourier hT hab]
  change P.complexExpect (fun z => ∫ t, (fourierPhase (t * x) * A t) *
    fourierPhase (-t * iidSum Y z)) = _
  unfold FiniteMass.complexExpect
  simp only [← integral_const_mul]
  rw [← integral_finset_sum Finset.univ (fun z _ => hInt z)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun t => ?_)
  change (∑ z : Fin n → κ, (P z : ℂ) * ((fourierPhase (t * x) * A t) *
    fourierPhase (-t * iidSum Y z))) = (fourierPhase (t * x) * A t) * characteristic p Y (-t) ^ n
  rw [← characteristic_independent_sum p Y n (-t), characteristic, FiniteMass.complexExpect,
    Finset.mul_sum]
  refine Finset.sum_congr rfl fun z _ => ?_
  ring

end RenyiProductOrderPhase
