import MovingPhaseMinimum

/-! Limit points of optimizers along convergent phases. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

theorem moving_phase_cost_tendsto {α : Type*} {l : Filter α}
    {θ A : ℝ} {H : ℝ → ℝ} (hH : Continuous H)
    {v a : ℝ} {phase prior : α → ℝ} (ha : 0 < a)
    (hv : Tendsto phase l (𝓝 v)) (hPrior : Tendsto prior l (𝓝 a)) :
    Tendsto (fun n => movingPhaseCost θ A H (phase n) (prior n)) l
      (𝓝 (movingPhaseCost θ A H v a)) := by
  have hC : ContinuousAt (priorCost θ) a :=
    (prior_cost_continuousOn θ a (mem_Ioi.mpr ha)).continuousAt (Ioi_mem_nhds ha)
  have hLog := (Real.continuousAt_log ha.ne').tendsto.comp hPrior
  have hP := (hC.tendsto.comp hPrior).const_mul A
  have hPhase : Tendsto (fun n => H (phase n + Real.log (prior n))) l (𝓝 (H (v + Real.log a))) :=
    (hH.tendsto _).comp (hv.add hLog)
  exact hP.mul hPhase

theorem moving_phase_optimizer_cluster {V : ℕ → ℝ → ℝ} {θ A : ℝ}
    {H : ℝ → ℝ} (hH : Continuous H) (phase : ℕ → ℝ)
    (hAnchor : ∃ C ≥ (0 : ℝ), ∀ᶠ n in atTop, V n 1 ≤ C)
    (hConf : ∀ C ≥ (0 : ℝ), ∃ l > 0, ∃ u > 0, ∀ᶠ n in atTop, ∀ a, 0 < a →
      V n a ≤ C → a ∈ Icc l u)
    (hUni : ∀ l u : ℝ, 0 < l → l ≤ u → ∀ ε > 0,
      ∀ᶠ n in atTop, ∀ a ∈ Icc l u,
        |V n a - movingPhaseCost θ A H (phase n) a| < ε)
    (index : ℕ → ℕ) (hIndex : Tendsto index atTop atTop)
    (a e : ℕ → ℝ) {v z : ℝ} (hPhase : Tendsto (phase ∘ index) atTop (𝓝 v))
    (hA : Tendsto a atTop (𝓝 z)) (he : Tendsto e atTop (𝓝 0))
    (ha : ∀ᶠ j in atTop, 0 < a j)
    (hOpt : ∀ᶠ j in atTop, ∀ x > 0, V (index j) (a j) ≤ V (index j) x + e j) :
    0 < z ∧ IsLeast (positivePriorValues (movingPhaseCost θ A H v)) (movingPhaseCost θ A H v z) := by
  obtain ⟨C, hC, hB⟩ := hAnchor
  obtain ⟨l, hl, u, _, hJ⟩ := hConf (C + 1) (add_nonneg hC zero_le_one)
  have hIn : ∀ᶠ j in atTop, a j ∈ Icc l u := by
    filter_upwards [hIndex.eventually hB, hIndex.eventually hJ, ha, hOpt,
      he.eventually (gt_mem_nhds zero_lt_one)] with j hB' hJ' haj ho he'
    exact hJ' (a j) haj (by have h := ho 1 zero_lt_one; linarith only [h, hB', he'])
  have hz : z ∈ Icc l u := isClosed_Icc.mem_of_tendsto hA hIn
  have hz₀ := hl.trans_le hz.1
  refine ⟨hz₀, ⟨⟨z, hz₀, rfl⟩, ?_⟩⟩
  rintro y ⟨x, hx₀, rfl⟩
  let l' := min l x
  let u' := max u x
  have hl' : 0 < l' := lt_min hl hx₀
  have hx : x ∈ Icc l' u' := ⟨min_le_right _ _, le_max_right _ _⟩
  have hIn' : ∀ᶠ j in atTop, a j ∈ Icc l' u' := hIn.mono (fun j h =>
    ⟨(min_le_left _ _).trans h.1, h.2.trans (le_max_left _ _)⟩)
  have hErr (p : ℕ → ℝ) (hp : ∀ᶠ j in atTop, p j ∈ Icc l' u') :
      Tendsto (fun j => V (index j) (p j) - movingPhaseCost θ A H (phase (index j)) (p j)) atTop (𝓝 0) := by
    apply Metric.tendsto_nhds.2
    intro ε hε
    filter_upwards [hIndex.eventually (hUni l' u' hl' (hx.1.trans hx.2) ε hε), hp] with j hn hj
    simpa only [Real.dist_eq, sub_zero] using hn (p j) hj
  have hTA : Tendsto (fun j => V (index j) (a j)) atTop (𝓝 (movingPhaseCost θ A H v z)) := by
    have h := (hErr a hIn').add (moving_phase_cost_tendsto (θ := θ) (A := A) hH hz₀ hPhase hA)
    simpa only [Function.comp_apply, zero_add, sub_add_cancel] using h
  have hTX : Tendsto (fun j => V (index j) x) atTop (𝓝 (movingPhaseCost θ A H v x)) := by
    have h := (hErr (fun _ => x) (Filter.Eventually.of_forall fun _ => hx)).add
      (moving_phase_cost_tendsto (θ := θ) (A := A) hH hx₀ hPhase
        (show Tendsto (fun _ : ℕ => x) atTop (𝓝 x) from tendsto_const_nhds))
    simpa only [Function.comp_apply, zero_add, sub_add_cancel] using h
  apply le_of_tendsto_of_tendsto hTA (by simpa only [add_zero] using hTX.add he)
  exact hOpt.mono (fun j hj => hj x hx₀)

def MovingPhaseOptimizerLimits (V : ℕ → ℝ → ℝ) (θ A : ℝ) (H : ℝ → ℝ) (phase : ℕ → ℝ) : Prop :=
  ∀ (index : ℕ → ℕ), Tendsto index atTop atTop →
    ∀ (a e : ℕ → ℝ) {v z : ℝ}, Tendsto (phase ∘ index) atTop (𝓝 v) →
      Tendsto a atTop (𝓝 z) → Tendsto e atTop (𝓝 0) → (∀ᶠ j in atTop, 0 < a j) →
      (∀ᶠ j in atTop, ∀ x > 0, V (index j) (a j) ≤ V (index j) x + e j) →
      0 < z ∧ IsLeast (positivePriorValues (movingPhaseCost θ A H v)) (movingPhaseCost θ A H v z)

end RenyiProductOrderPhase
