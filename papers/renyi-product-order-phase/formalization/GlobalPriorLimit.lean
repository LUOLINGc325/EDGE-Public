import PriorConfinement
import CompactPriorLimit
import PriorVariational

/-! Convergence of all globally approximate minimizers under the exact prior confinement. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

theorem prior_cost_continuousOn (θ : ℝ) : ContinuousOn (priorCost θ) (Ioi (0 : ℝ)) := by
  have hPow : ContinuousOn (fun a : ℝ => a ^ θ) (Ioi 0) :=
    continuous_id.continuousOn.rpow_const (fun _ ha => Or.inl (mem_Ioi.mp ha).ne')
  have hLog : ContinuousOn (fun a : ℝ => Real.log (1 + a)) (Ioi 0) :=
    (continuous_const.add continuous_id).continuousOn.log
      (fun a ha => (show 0 < 1 + a by linarith only [mem_Ioi.mp ha]).ne')
  exact hPow.div hLog (fun a ha => (Real.log_pos (show 1 < 1 + a by
    linarith only [mem_Ioi.mp ha])).ne')

theorem global_compact_prior_minimizers {V : ℕ → ℝ → ℝ} {G : ℝ → ℝ}
    {aStar : ℝ} (hStar : 0 < aStar) (hCont : ContinuousOn G (Ioi 0))
    (hStrict : ∀ a, 0 < a → a ≠ aStar → G aStar < G a)
    (hConfine : ∀ C ≥ (0 : ℝ), ∃ l > 0, ∃ u > 0, ∀ᶠ n in atTop, ∀ a, 0 < a →
      V n a ≤ C → a ∈ Icc l u)
    (hUniform : ∀ l u : ℝ, 0 < l → l ≤ u → ∀ ε > 0,
      ∀ᶠ n in atTop, ∀ a ∈ Icc l u, |V n a - G a| < ε)
    (a e : ℕ → ℝ) (hA : ∀ᶠ n in atTop, 0 < a n)
    (hErr : Tendsto e atTop (𝓝 0))
    (hOpt : ∀ᶠ n in atTop, ∀ x > 0, V n (a n) ≤ V n x + e n) :
    Tendsto a atTop (𝓝 aStar) ∧ Tendsto (fun n => V n (a n)) atTop (𝓝 (G aStar)) := by
  let C := |G aStar| + 2
  have hC : 0 ≤ C := add_nonneg (abs_nonneg _) (by norm_num)
  obtain ⟨l₀, hl₀, u₀, _, hK⟩ := hConfine C hC
  let l := min l₀ aStar
  let u := max u₀ aStar
  have hl : 0 < l := lt_min hl₀ hStar
  have hStarK : aStar ∈ Icc l u := ⟨min_le_right _ _, le_max_right _ _⟩
  have hOptStar : ∀ᶠ n in atTop, V n (a n) ≤ V n aStar + e n :=
    hOpt.mono (fun _ h => h aStar hStar)
  have hBound : ∀ᶠ n in atTop, V n (a n) ≤ C := by
    have hAnchor := hUniform aStar aStar hStar le_rfl 1 zero_lt_one
    filter_upwards [hOptStar, hAnchor, hErr.eventually (Iio_mem_nhds zero_lt_one)] with n hn hNear hE
    have hN := (abs_lt.mp (hNear aStar ⟨le_rfl, le_rfl⟩)).2
    have he : e n < 1 := hE
    have hAbs := le_abs_self (G aStar)
    unfold C
    linarith only [hn, hN, he, hAbs]
  have hInside : ∀ᶠ n in atTop, a n ∈ Icc l u := by
    filter_upwards [hK, hA, hBound] with n hn hp hB
    have h := hn (a n) hp hB
    exact ⟨(min_le_left _ _).trans h.1, h.2.trans (le_max_left _ _)⟩
  have hPos : Icc l u ⊆ Ioi (0 : ℝ) := fun _ h => hl.trans_le h.1
  exact compact_uniform_prior_minimizers hStarK (hCont.mono hPos)
    (fun x hx => hStrict x (hPos hx)) hInside hOptStar hErr
    (hUniform l u hl (hStarK.1.trans hStarK.2))

end RenyiProductOrderPhase
