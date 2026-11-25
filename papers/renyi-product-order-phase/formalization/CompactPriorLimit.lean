import PriorAttainment

/-! Limits of minimum values and all approximate minimizers on a confined prior interval. -/

open scoped Topology
open Set Filter

namespace RenyiProductOrderPhase

theorem compact_uniform_prior_minimizers {F : ℕ → ℝ → ℝ} {G : ℝ → ℝ}
    {a : ℕ → ℝ} {e : ℕ → ℝ} {l u aStar : ℝ}
    (hStar : aStar ∈ Icc l u)
    (hCont : ContinuousOn G (Icc l u))
    (hUnique : ∀ x ∈ Icc l u, x ≠ aStar → G aStar < G x)
    (hInside : ∀ᶠ n in atTop, a n ∈ Icc l u)
    (hOptimal : ∀ᶠ n in atTop, F n (a n) ≤ F n aStar + e n)
    (hErr : Tendsto e atTop (𝓝 0))
    (hUniform : ∀ ε > 0, ∀ᶠ n in atTop, ∀ x ∈ Icc l u, |F n x - G x| < ε) :
    Tendsto a atTop (𝓝 aStar) ∧ Tendsto (fun n => F n (a n)) atTop (𝓝 (G aStar)) := by
  have hMin (x : ℝ) (hx : x ∈ Icc l u) : G aStar ≤ G x := by
    rcases eq_or_ne x aStar with h | h
    · rw [h]
    · exact (hUnique x hx h).le
  have hGV : Tendsto (fun n => G (a n)) atTop (𝓝 (G aStar)) := by
    apply Metric.tendsto_nhds.2
    intro ε hε
    have hD : 0 < ε / 4 := div_pos hε (by norm_num)
    filter_upwards [hInside, hOptimal, hErr.eventually (Iio_mem_nhds hD), hUniform (ε / 4) hD]
      with n hn hOpt hE hU
    have hA := abs_lt.mp (hU (a n) hn)
    have hS := abs_lt.mp (hU aStar hStar)
    have hE' : e n < ε / 4 := hE
    rw [Real.dist_eq, abs_of_nonneg (sub_nonneg.mpr (hMin (a n) hn))]
    linarith only [hA.1, hS.2, hOpt, hE', hε]
  constructor
  · apply Metric.tendsto_nhds.2
    intro ε hε
    let K : Set ℝ := Icc l u ∩ {x | ε ≤ |x - aStar|}
    have hClosed : IsClosed {x : ℝ | ε ≤ |x - aStar|} :=
      isClosed_le continuous_const (continuous_id.sub continuous_const).abs
    have hK : IsCompact K := isCompact_Icc.inter_right hClosed
    by_cases hNon : K.Nonempty
    · obtain ⟨b, hb, hB⟩ := hK.exists_isMinOn hNon (hCont.mono (fun _ hx => hx.1))
      have hne : b ≠ aStar := by
        intro h
        have hb' : ε ≤ |b - aStar| := hb.2
        rw [h, sub_self, abs_zero] at hb'
        exact (not_le_of_gt hε) hb'
      have hGap : G aStar < G b := hUnique b hb.1 hne
      filter_upwards [hInside, hGV.eventually (Iio_mem_nhds hGap)] with n hn hUnder
      rw [Real.dist_eq]
      exact lt_of_not_ge (fun h => (not_lt_of_ge (hB ⟨hn, h⟩)) hUnder)
    · filter_upwards [hInside] with n hn
      rw [Real.dist_eq]
      exact lt_of_not_ge (fun h => hNon ⟨a n, hn, h⟩)
  · apply Metric.tendsto_nhds.2
    intro ε hε
    have hD : 0 < ε / 2 := div_pos hε (by norm_num)
    filter_upwards [hInside, hUniform (ε / 2) hD, Metric.tendsto_nhds.1 hGV (ε / 2) hD]
      with n hn hU hCon
    exact (dist_triangle (F n (a n)) (G (a n)) (G aStar)).trans_lt
      (by simp only [Real.dist_eq] at hCon ⊢; linarith only [hU (a n) hn, hCon])

end RenyiProductOrderPhase
