import NonarithmeticOptimizedLimit
import ArithmeticPhaseOptimization

/-! Taking the exact nonarithmetic coefficient minimum and recovering the mixture weight. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem scaled_block_minimum_from_optimizer_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (I : ℝ) (B : ℕ → ℝ) (hb : ∀ n, 0 < B n) (z : ℝ)
    (hLim : ∀ a : ℕ → ℝ, (∀ n, 0 < a n) →
      (∀ n, IsLeast (positivePriorValues (scaledBlockObjective p q I B n))
        (scaledBlockObjective p q I B n (a n))) →
      Tendsto (fun n => scaledBlockObjective p q I B n (a n)) atTop (𝓝 z)) :
    Tendsto (fun n => (B n * blockScale I (n + 1)) *
      sInf (productDeficitValues p q (n + 1) (B n))) atTop (𝓝 z) := by
  classical
  choose a ha hMin hEq using scaled_block_deficit_least p q hp hq hne I B hb
  exact (hLim a ha hMin).congr hEq

theorem nonarithmetic_fixed_exact_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (hNon : ¬ ArithmeticSupport (logLikelihood p q)) {b θ : ℝ}
    (hb : 1 ≤ b) (hθ : 0 < θ) (hθ' : θ < 1) (hm : tiltedMean p q θ = 0) :
    let I := -logCumulant p q θ
    let c := fixedTiltConstant (tiltedVariance p q θ) b θ
    ∃ aStar > 0, θ * (1 + aStar) * Real.log (1 + aStar) = aStar ∧
      Tendsto (fun n : ℕ => (b * blockScale I (n + 1)) * sInf (productDeficitValues p q (n + 1) b))
        atTop (𝓝 (c * priorCost θ aStar)) := by
  let I := -logCumulant p q θ
  let c := fixedTiltConstant (tiltedVariance p q θ) b θ
  obtain ⟨aStar, ha, hEq, _, hOpt⟩ := nonarithmetic_fixed_optimized_limit p q hp hq hne hNon hb hθ hθ' hm
  refine ⟨aStar, ha, hEq, ?_⟩
  apply scaled_block_minimum_from_optimizer_limit p q hp hq hne I (fun _ => b)
    (fun _ => zero_lt_one.trans_le hb) (c * priorCost θ aStar)
  intro a ha hMin
  have hA := hOpt a (fun _ => 0) (Filter.Eventually.of_forall ha) tendsto_const_nhds
    (Filter.Eventually.of_forall fun n x hx => by simpa only [add_zero] using (hMin n).2 ⟨x, hx, rfl⟩)
  exact hA.2

theorem nonarithmetic_growing_exact_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (hNon : ¬ ArithmeticSupport (logLikelihood p q)) {r θ : ℝ}
    (hr : 0 < r) (hθ : 0 < θ) (hθ' : θ < 1) (hm : tiltedMean p q θ = -r) :
    let B (n : ℕ) := Real.exp (((n + 1 : ℕ) : ℝ) * r)
    let I := -(logCumulant p q θ + θ * r)
    let c := growingTiltConstant (tiltedVariance p q θ) θ
    ∃ aStar > 0, θ * (1 + aStar) * Real.log (1 + aStar) = aStar ∧
      Tendsto (fun n : ℕ => (B n * blockScale I (n + 1)) * sInf (productDeficitValues p q (n + 1) (B n)))
        atTop (𝓝 (c * priorCost θ aStar)) := by
  let B (n : ℕ) := Real.exp (((n + 1 : ℕ) : ℝ) * r)
  let I := -(logCumulant p q θ + θ * r)
  let c := growingTiltConstant (tiltedVariance p q θ) θ
  obtain ⟨aStar, ha, hEq, _, hOpt⟩ := nonarithmetic_growing_optimized_limit p q hp hq hne hNon hr hθ hθ' hm
  refine ⟨aStar, ha, hEq, ?_⟩
  apply scaled_block_minimum_from_optimizer_limit p q hp hq hne I B (fun _ => Real.exp_pos _)
    (c * priorCost θ aStar)
  intro a ha hMin
  have hA := hOpt a (fun _ => 0) (Filter.Eventually.of_forall ha) tendsto_const_nhds
    (Filter.Eventually.of_forall fun n x hx => by simpa only [add_zero] using (hMin n).2 ⟨x, hx, rfl⟩)
  exact hA.2

theorem prior_weight_stationarity {θ a : ℝ} (ha : 0 < a) :
    θ * (1 + a) * Real.log (1 + a) = a ↔ -θ * Real.log (priorWeight a) = 1 - priorWeight a := by
  let x := 1 + a
  have hx : 0 < x := by unfold x; linarith
  unfold priorWeight
  rw [Real.log_inv, neg_mul, mul_neg, neg_neg]
  constructor
  · intro h
    apply mul_right_cancel₀ hx.ne'
    change θ * Real.log x * x = (1 - x⁻¹) * x
    rw [sub_mul, one_mul, inv_mul_cancel₀ hx.ne']
    unfold x
    linarith only [show θ * Real.log (1 + a) * (1 + a) = a from by rw [mul_right_comm]; exact h]
  · intro h
    change θ * x * Real.log x = a
    calc
      _ = (θ * Real.log x) * x := by ring
      _ = (1 - x⁻¹) * x := by rw [h]
      _ = _ := by rw [sub_mul, one_mul, inv_mul_cancel₀ hx.ne']; unfold x; ring

end RenyiProductOrderPhase
