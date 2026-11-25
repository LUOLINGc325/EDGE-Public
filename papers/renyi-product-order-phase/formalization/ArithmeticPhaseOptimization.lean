import MovingPhaseOptimizer
import PriorAttainment
import LatticeWindow

/-! Optimizing the phase profile uniformly over every block phase. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem scaled_block_deficit_least (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (I : ℝ) (B : ℕ → ℝ) (hb : ∀ n, 0 < B n) (n : ℕ) :
    ∃ a > 0, IsLeast (positivePriorValues (scaledBlockObjective p q I B n))
      (scaledBlockObjective p q I B n a) ∧
      scaledBlockObjective p q I B n a =
        (B n * blockScale I (n + 1)) * sInf (productDeficitValues p q (n + 1) (B n)) := by
  obtain ⟨a, ha, hA⟩ := product_deficit_attained p q hp hq hne (Nat.succ_pos n) (B n) (hb n)
  have hScale : 0 ≤ B n * blockScale I (n + 1) :=
    mul_nonneg (hb n).le (mul_nonneg (Real.sqrt_nonneg _) (Real.exp_nonneg _))
  refine ⟨a, ha, ⟨⟨a, ha, rfl⟩, ?_⟩, ?_⟩
  · rintro z ⟨x, hx, rfl⟩
    exact mul_le_mul_of_nonneg_left (hA.2 ⟨x, hx, rfl⟩) hScale
  · rw [hA.csInf_eq]
    rfl

theorem arithmetic_optimized_limit_of_phase (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    {Y : κ → ℝ} (L : MaximalLattice Y) {I v θ c A : ℝ}
    (hv : 0 < v) (hθ : 0 < θ) (hθ' : θ < 1) (hc : 0 < c) (hA : 0 ≤ A)
    (B : ℕ → ℝ) (hb : ∀ n, 0 < B n) (g : ℝ → ℝ)
    (hEnv : ∀ s, |Real.exp (-(θ * s)) * g (Real.exp s)| ≤ A * exponentialEnvelope c s)
    (hCont : Continuous (fun s => Real.exp (-(θ * s)) * g (Real.exp s)))
    (hPos : ∀ s, 0 < Real.exp (-(θ * s)) * g (Real.exp s))
    (hConf : ∀ C ≥ (0 : ℝ), ∃ l > 0, ∃ u > 0, ∀ᶠ n in atTop, ∀ a, 0 < a →
      scaledBlockObjective p q I B n a ≤ C → a ∈ Icc l u)
    (hLim : ∀ l u : ℝ, 0 < l → l ≤ u → ∀ ε > 0,
      ∀ᶠ n in atTop, ∀ a ∈ Icc l u,
        |scaledBlockObjective p q I B n a -
          phaseMoment L v (fun a s => Real.exp (-(θ * s)) * g (a * Real.exp s)) n a /
            Real.log (1 + a)| < ε) :
    let H := periodicKernelProfile L.span (fun s => Real.exp (-(θ * s)) * g (Real.exp s))
    let G (n : ℕ) := movingPhaseCost θ (gaussianHeight v) H (L.span * L.phase (n + 1))
    Tendsto (fun n => (B n * blockScale I (n + 1)) *
      sInf (productDeficitValues p q (n + 1) (B n)) - sInf (positivePriorValues (G n))) atTop (𝓝 0) ∧
      MovingPhaseOptimizerLimits (scaledBlockObjective p q I B) θ (gaussianHeight v) H
        (fun n => L.span * L.phase (n + 1)) ∧
      ∃ c > 0, ∃ C > 0, ∀ n, c ≤ sInf (positivePriorValues (G n)) ∧ sInf (positivePriorValues (G n)) ≤ C := by
  let H := periodicKernelProfile L.span (fun s => Real.exp (-(θ * s)) * g (Real.exp s))
  let G (n : ℕ) := movingPhaseCost θ (gaussianHeight v) H (L.span * L.phase (n + 1))
  let V := scaledBlockObjective p q I B
  let α := gaussianHeight v
  have hα : 0 < α := gaussian_height_pos hv
  have hH : Continuous H := periodic_kernel_continuous L.span_pos hc hA hEnv hCont
  obtain ⟨m, hm, M, hM, hB⟩ := periodic_kernel_positive_and_bounded L.span_pos hc hA hEnv hCont hPos
  obtain ⟨l, hl, u, hu, _, _, hPhase⟩ := moving_phase_uniform_minimizers hθ hθ' hα hm H hH hB
  have hUni (l u : ℝ) (hl : 0 < l) (hlu : l ≤ u) (ε : ℝ) (hε : 0 < ε) :
      ∀ᶠ n in atTop, ∀ a ∈ Icc l u, |V n a - G n a| < ε := by
    filter_upwards [hLim l u hl hlu ε hε] with n hn
    intro a ha
    have h := hn a ha
    rw [phase_moment_periodic_factorization L v θ g n (hl.trans_le ha.1) hc hA hEnv] at h
    simpa only [V, G, H, movingPhaseCost, priorCost, div_eq_mul_inv, mul_assoc, mul_comm, mul_left_comm] using h
  let C := α * priorCost θ 1 * M + 1
  have hC : 0 ≤ C := (add_pos (mul_pos (mul_pos hα (prior_cost_positive zero_lt_one)) hM) zero_lt_one).le
  have hAnchor : ∀ᶠ n in atTop, V n 1 ≤ C := by
    filter_upwards [hUni 1 1 zero_lt_one le_rfl 1 zero_lt_one] with n hn
    have h := (abs_lt.mp (hn 1 ⟨le_rfl, le_rfl⟩)).2
    have hUpper : G n 1 ≤ α * priorCost θ 1 * M :=
      mul_le_mul_of_nonneg_left (hB _).2 (mul_pos hα (prior_cost_positive zero_lt_one)).le
    unfold C
    linarith only [h, hUpper]
  have hActual (n : ℕ) : ∃ a > 0, IsLeast (positivePriorValues (V n)) (V n a) := by
    obtain ⟨a, ha, hA, _⟩ := scaled_block_deficit_least p q hp hq hne I B hb n
    exact ⟨a, ha, hA⟩
  have hEq (n : ℕ) : sInf (positivePriorValues (V n)) =
      (B n * blockScale I (n + 1)) * sInf (productDeficitValues p q (n + 1) (B n)) := by
    obtain ⟨a, _, hA, h⟩ := scaled_block_deficit_least p q hp hq hne I B hb n
    exact hA.csInf_eq.trans h
  constructor
  · change Tendsto (fun n => _ - sInf (positivePriorValues (G n))) atTop (𝓝 0)
    apply Metric.tendsto_nhds.2
    intro ε hε
    filter_upwards [uniform_moving_minimum_comparison hActual
      ⟨l, hl, u, hu, fun n => hPhase (L.span * L.phase (n + 1))⟩
      hAnchor (hConf C hC) hUni hε] with n hn
    simpa only [hEq n, Real.dist_eq, sub_zero] using hn
  · refine ⟨moving_phase_optimizer_cluster hH (fun n => L.span * L.phase (n + 1))
      ⟨C, hC, hAnchor⟩ hConf hUni, ?_⟩
    obtain ⟨d, hd, D, hD, hB'⟩ := moving_phase_minimum_value_bounds hθ hθ' hα hm hM H hB
    exact ⟨d, hd, D, hD, fun n => hB' (L.span * L.phase (n + 1))⟩

end RenyiProductOrderPhase
