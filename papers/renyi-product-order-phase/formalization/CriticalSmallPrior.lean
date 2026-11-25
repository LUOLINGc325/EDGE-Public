import CriticalMomentGrowth
import CriticalSoftThreshold

/-! A uniform lower bound near the zero-prior end of the critical KL window. -/

open Set

namespace RenyiProductOrderPhase

namespace FiniteMass

variable {ι : Type*} [Fintype ι]

theorem expect_sub_functions (p : FiniteMass ι) (f g : ι → ℝ) :
    p.expect (fun x => f x - g x) = p.expect f - p.expect g := by
  unfold expect
  simp only [mul_sub, Finset.sum_sub_distrib]

end FiniteMass

theorem one_sub_exp_neg_ge_ratio {U : ℝ} (hU : 0 ≤ U) :
    U / (1 + U) ≤ 1 - Real.exp (-U) := by
  have hDen : 0 < 1 + U := by linarith
  have h := (inv_le_inv₀ (Real.exp_pos U) hDen).2 (by simpa only [add_comm] using Real.add_one_le_exp U)
  rw [← Real.exp_neg] at h
  have he : 1 - (1 + U)⁻¹ = U / (1 + U) := by field_simp [hDen.ne']
  rw [← he]
  exact sub_le_sub_left h 1

variable {κ : Type*} [Fintype κ]

theorem critical_small_prior_uniform_lower (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i)
    (ζ : ℝ) (n : ℕ) {t : ℝ} (hs : 0 < criticalScale p q n) (ht : 0 < t)
    (hb : 1 ≤ criticalOrder p q ζ n) :
    let Y (i : κ) := standardizedLogLikelihood p q i / Real.sqrt (n : ℝ)
    finiteSumEvent p Y n (Iic ζ) / (t + (criticalScale p q n)⁻¹) ≤
      criticalObjective p q ζ n t := by
  let s := criticalScale p q n
  let U := t * s
  let b := criticalOrder p q ζ n
  let a := criticalPrior p q n t
  let Y (i : κ) := standardizedLogLikelihood p q i / Real.sqrt (n : ℝ)
  let X (z : Fin n → κ) := iidSum Y z
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let D := finiteSumEvent p Y n (Iic ζ)
  let f (z : Fin n → κ) := (1 + a * likelihoodProduct p q z) ^ (-b)
  let g (z : Fin n → κ) := (Iic ζ).indicator (fun _ => (1 : ℝ)) (X z)
  have hU : 0 < U := mul_pos ht hs
  have hb₀ : 0 < b := zero_lt_one.trans_le hb
  have ha : 0 < a := critical_prior_positive p q hs ht
  have hA (z : Fin n → κ) : f z ≤ 1 / (1 + a * Real.exp (s * (ζ - X z))) := by
    let Z := a * Real.exp (s * (ζ - X z))
    have hZ : 0 ≤ Z := mul_nonneg ha.le (Real.exp_nonneg _)
    have hArg := critical_argument_plain p q ζ n t hs z
    change b * a * Real.exp (likelihoodSum p q z) = Z at hArg
    have hDiv : Z / b = a * likelihoodProduct p q z := by
      rw [← hArg, mul_assoc, mul_div_cancel_left₀ _ hb₀.ne', exp_likelihood_sum p q hp hq]
    have h := soft_threshold_reciprocal_upper hb hZ
    rw [hDiv] at h
    exact h
  have hPoint (z : Fin n → κ) : f z ≤ 1 - (1 - Real.exp (-U)) * g z := by
    by_cases hz : X z ∈ Iic ζ
    · unfold g
      rw [indicator_of_mem hz, mul_one, sub_sub_cancel]
      apply (hA z).trans
      have hx : 0 ≤ ζ - X z := sub_nonneg.mpr (mem_Iic.mp hz)
      have hE : 1 ≤ Real.exp (s * (ζ - X z)) := by
        simpa only [Real.exp_zero] using Real.exp_le_exp.mpr (mul_nonneg hs.le hx)
      have he : (1 + a) ≤ 1 + a * Real.exp (s * (ζ - X z)) :=
        add_le_add_left (le_mul_of_one_le_right ha.le hE) _
      have h := div_le_div_of_nonneg_left zero_le_one (by linarith : 0 < 1 + a) he
      have hA₁ : 1 + a = Real.exp U := by unfold a criticalPrior U; ring
      simpa only [hA₁, one_div, Real.exp_neg] using h
    · unfold g
      rw [indicator_of_not_mem hz, mul_zero, sub_zero]
      apply (hA z).trans
      have hp₀ : 0 ≤ a * Real.exp (s * (ζ - X z)) := mul_nonneg ha.le (Real.exp_nonneg _)
      exact (div_le_iff₀ (by linarith only [hp₀])).2 (by linarith only [hp₀])
  have hW := P.expect_mono hPoint
  rw [FiniteMass.expect_sub_functions, FiniteMass.expect_scale_function, P.expect_const 1] at hW
  change productScalarMoment p q n b a ≤ 1 - (1 - Real.exp (-U)) * D at hW
  have hPos : 0 < productScalarMoment p q n b a :=
    product_moment_pos_nonnegative_prior p q hp hq n b ha.le
  have hLog := Real.log_le_sub_one_of_pos hPos
  have hLower : (1 - Real.exp (-U)) * D ≤ negativeLogProductMoment p q n b a := by
    unfold negativeLogProductMoment
    linarith only [hW, hLog]
  have hD : 0 ≤ D := finite_sum_event_nonneg p Y n _
  have hNumer := mul_le_mul_of_nonneg_right (one_sub_exp_neg_ge_ratio hU.le) hD
  have hDen : 0 < t + s⁻¹ := add_pos ht (inv_pos.mpr hs)
  have hEq : D / (t + s⁻¹) = ((U / (1 + U)) * D) / t := by
    have he : t + s⁻¹ = (1 + U) / s := by
      apply (eq_div_iff hs.ne').2
      rw [add_mul, inv_mul_cancel₀ hs.ne']
      unfold U
      ring
    rw [he]
    field_simp [hs.ne', ht.ne', (by positivity : 0 < 1 + U).ne']
    unfold U
    ring
  change D / (t + s⁻¹) ≤ negativeLogProductMoment p q n b a / t
  rw [hEq]
  exact div_le_div_of_nonneg_right (hNumer.trans hLower) ht.le

end RenyiProductOrderPhase
