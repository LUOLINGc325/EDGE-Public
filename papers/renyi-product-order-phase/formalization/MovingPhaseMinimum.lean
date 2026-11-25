import PhaseCostFactorization

/-! Global minima of the arithmetic phase objectives and their approximation by finite blocks. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

def positivePriorValues (f : ℝ → ℝ) : Set ℝ := {z | ∃ a > 0, z = f a}

noncomputable def movingPhaseCost (θ α : ℝ) (H : ℝ → ℝ) (v a : ℝ) : ℝ :=
  α * priorCost θ a * H (v + Real.log a)

theorem prior_cost_positive {θ a : ℝ} (ha : 0 < a) : 0 < priorCost θ a :=
  div_pos (Real.rpow_pos_of_pos ha _) (Real.log_pos (by linarith))

theorem moving_phase_uniform_minimizers {θ α m M : ℝ}
    (hθ : 0 < θ) (hθ' : θ < 1) (hα : 0 < α) (hm : 0 < m)
    (H : ℝ → ℝ) (hH : Continuous H) (hB : ∀ v, m ≤ H v ∧ H v ≤ M) :
    ∃ l > 0, ∃ u > 0, l ≤ 1 ∧ 1 ≤ u ∧ ∀ v,
      ∃ a ∈ Icc l u, IsLeast (positivePriorValues (movingPhaseCost θ α H v))
        (movingPhaseCost θ α H v a) := by
  let C := α * priorCost θ 1 * M
  obtain ⟨l₀, hl₀, u₀, hu₀, hSub⟩ := compact_prior_cost_sublevel (C := C / (α * m)) hθ hθ'
  let l := min l₀ 1
  let u := max u₀ 1
  have hl : 0 < l := lt_min hl₀ zero_lt_one
  have hu : 0 < u := zero_lt_one.trans_le (le_max_right _ _)
  have hOne : (1 : ℝ) ∈ Icc l u := ⟨min_le_right _ _, le_max_right _ _⟩
  refine ⟨l, hl, u, hu, hOne.1, hOne.2, ?_⟩
  intro v
  let F := movingPhaseCost θ α H v
  have hAnchor : F 1 ≤ C := mul_le_mul_of_nonneg_left (hB _).2
    (mul_pos hα (prior_cost_positive zero_lt_one)).le
  have hBounds (a : ℝ) (ha : 0 < a) (hF : F a ≤ C) : a ∈ Icc l u := by
    have hLow : priorCost θ a * (α * m) ≤ F a := by
      unfold F movingPhaseCost
      calc
        _ = α * priorCost θ a * m := by ring
        _ ≤ _ := mul_le_mul_of_nonneg_left (hB _).1 (mul_pos hα (prior_cost_positive ha)).le
    have h := hSub a ha ((le_div_iff₀ (mul_pos hα hm)).2 (hLow.trans hF))
    exact ⟨(min_le_left _ _).trans h.1, h.2.trans (le_max_left _ _)⟩
  have hCont : ContinuousOn F (Icc l u) := by
    have hPos : Icc l u ⊆ Ioi (0 : ℝ) := fun _ h => hl.trans_le h.1
    have hLog : ContinuousOn (fun a : ℝ => Real.log a) (Icc l u) :=
      continuous_id.continuousOn.log (fun a ha => (show 0 < a from hPos ha).ne')
    have hShift : ContinuousOn (fun a : ℝ => v + Real.log a) (Icc l u) :=
      continuousOn_const.add hLog
    have hH' : ContinuousOn (fun a : ℝ => H (v + Real.log a)) (Icc l u) :=
      hH.continuousOn.comp hShift (fun s _ => mem_univ (v + Real.log s))
    exact (continuousOn_const.mul ((prior_cost_continuousOn θ).mono hPos)).mul hH'
  obtain ⟨a, ha, hmA⟩ := isCompact_Icc.exists_isMinOn ⟨1, hOne⟩ hCont
  refine ⟨a, ha, ⟨a, hl.trans_le ha.1, rfl⟩, ?_⟩
  rintro z ⟨x, hx, rfl⟩
  by_contra! h
  have hx' : x ∈ Icc l u := hBounds x hx (h.le.trans ((hmA hOne).trans hAnchor))
  exact (not_lt_of_ge (hmA hx')) h

theorem uniform_moving_minimum_comparison {V G : ℕ → ℝ → ℝ}
    (hActual : ∀ n, ∃ a > 0, IsLeast (positivePriorValues (V n)) (V n a))
    (hPhase : ∃ l > 0, ∃ u > 0, ∀ n, ∃ a ∈ Icc l u, IsLeast (positivePriorValues (G n)) (G n a))
    {C : ℝ} (hAnchor : ∀ᶠ n in atTop, V n 1 ≤ C)
    (hConfine : ∃ l > 0, ∃ u > 0, ∀ᶠ n in atTop, ∀ a, 0 < a →
      V n a ≤ C → a ∈ Icc l u)
    (hUniform : ∀ l u : ℝ, 0 < l → l ≤ u → ∀ ε > 0,
      ∀ᶠ n in atTop, ∀ a ∈ Icc l u, |V n a - G n a| < ε)
    {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop,
      |sInf (positivePriorValues (V n)) - sInf (positivePriorValues (G n))| < ε := by
  obtain ⟨l₁, hl₁, u₁, _, h₁⟩ := hPhase
  obtain ⟨l₂, hl₂, u₂, _, h₂⟩ := hConfine
  let l := min (min l₁ l₂) 1
  let u := max (max u₁ u₂) 1
  have hl : 0 < l := lt_min (lt_min hl₁ hl₂) zero_lt_one
  have hOne : (1 : ℝ) ∈ Icc l u := ⟨min_le_right _ _, le_max_right _ _⟩
  filter_upwards [hAnchor, h₂, hUniform l u hl (hOne.1.trans hOne.2) ε hε]
    with n hn hN hE
  obtain ⟨a, ha, hA⟩ := hActual n
  obtain ⟨b, hb, hB⟩ := h₁ n
  have hb₀ : 0 < b := hl₁.trans_le hb.1
  have hC' : V n a ≤ C := (hA.2 ⟨1, zero_lt_one, rfl⟩).trans hn
  have ha' := hN a ha hC'
  have hLeft : a ∈ Icc l u := ⟨((min_le_left _ _).trans (min_le_right _ _)).trans ha'.1,
    ha'.2.trans ((le_max_right _ _).trans (le_max_left _ _))⟩
  have hRight : b ∈ Icc l u := ⟨((min_le_left _ _).trans (min_le_left _ _)).trans hb.1,
    hb.2.trans ((le_max_left _ _).trans (le_max_left _ _))⟩
  have hVa : V n a ≤ V n b := hA.2 ⟨b, hb₀, rfl⟩
  have hGb : G n b ≤ G n a := hB.2 ⟨a, ha, rfl⟩
  have hAV := abs_lt.mp (hE a hLeft)
  have hBV := abs_lt.mp (hE b hRight)
  rw [hA.csInf_eq, hB.csInf_eq, abs_lt]
  exact ⟨by linarith only [hAV.1, hGb], by linarith only [hBV.2, hVa]⟩

theorem moving_phase_minimum_value_bounds {θ α m M : ℝ}
    (hθ : 0 < θ) (hθ' : θ < 1) (hα : 0 < α) (hm : 0 < m) (hM : 0 < M)
    (H : ℝ → ℝ) (hB : ∀ v, m ≤ H v ∧ H v ≤ M) :
    ∃ c > 0, ∃ C > 0, ∀ v,
      c ≤ sInf (positivePriorValues (movingPhaseCost θ α H v)) ∧
        sInf (positivePriorValues (movingPhaseCost θ α H v)) ≤ C := by
  obtain ⟨a, ha, _, _, hMin⟩ := prior_cost_unique_minimum hθ hθ'
  let c := α * priorCost θ a * m
  let C := α * priorCost θ 1 * M
  have hc : 0 < c := mul_pos (mul_pos hα (prior_cost_positive ha)) hm
  have hC : 0 < C := mul_pos (mul_pos hα (prior_cost_positive zero_lt_one)) hM
  refine ⟨c, hc, C, hC, fun v => ?_⟩
  let f := movingPhaseCost θ α H v
  have hAnchor : f 1 ∈ positivePriorValues f := ⟨1, zero_lt_one, rfl⟩
  have hLower : ∀ z ∈ positivePriorValues f, c ≤ z := by
    rintro z ⟨x, hx, rfl⟩
    have hAx : priorCost θ a ≤ priorCost θ x := by
      by_cases he : x = a
      · rw [he]
      · exact (hMin x hx he).le
    calc
      _ ≤ α * priorCost θ x * m :=
        mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hAx hα.le) hm.le
      _ ≤ _ := mul_le_mul_of_nonneg_left (hB _).1 (mul_pos hα (prior_cost_positive hx)).le
  have hUp : f 1 ≤ C := mul_le_mul_of_nonneg_left (hB _).2
    (mul_pos hα (prior_cost_positive zero_lt_one)).le
  exact ⟨le_csInf ⟨_, hAnchor⟩ hLower, (csInf_le ⟨c, hLower⟩ hAnchor).trans hUp⟩

end RenyiProductOrderPhase
