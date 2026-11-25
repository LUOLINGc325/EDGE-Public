import GlauberLimits

open Filter Topology
open scoped BigOperators

namespace GlauberAnnealing
namespace BridgeCut

variable {V : Type*} [Fintype V] [Nonempty V] {M : RegularGraph V} (C : BridgeCut M)

theorem gibbs_initial_tendsto_uniform (i : V) :
    Tendsto (fun x => RegularGraph.gibbs (C.energy (scale x)) (early x) i)
      atTop (𝓝 (RegularGraph.uniform V i)) := by
  have he (i : V) : Tendsto (fun x => C.energy (scale x) i) atTop (𝓝 (C.base i)) := by
    simpa [energy] using (tendsto_const_nhds (x := C.base i)).add
      (scale_tendsto.mul_const (C.slope i))
  have hw (i : V) :
      Tendsto (fun x => RegularGraph.weight (C.energy (scale x)) (early x) i) atTop (𝓝 1) := by
    have hx := (scale_tendsto.neg.mul (he i)).rexp
    simpa [RegularGraph.weight, early] using hx
  have hs : Tendsto (fun x => ∑ j, RegularGraph.weight (C.energy (scale x)) (early x) j)
      atTop (𝓝 (Fintype.card V : ℝ)) := by
    simpa using tendsto_finset_sum Finset.univ (fun j _ => hw j)
  exact (hw i).div hs (ne_of_gt (RegularGraph.card_pos_real (V := V)))

omit [Nonempty V] in
theorem bias_product_limit :
    Tendsto (fun x => ∑ j, M.bias (C.energy (scale x)) (late x) j *
      M.bias (C.energy (scale x)) (middle x) j) atTop
      (𝓝 (-2 * ((M.degree : ℝ) - 2) / (M.degree : ℝ)^2)) := by
  classical
  let d : ℝ := M.degree
  let q : ℝ := (d - 2) / d
  let L : V → ℝ := fun j =>
    (if j = C.source then q * (-1 / d) else 0) +
    (if j = C.target then -q * (1 / d) else 0)
  have he (j : V) : Tendsto (fun x => M.bias (C.energy (scale x)) (late x) j *
      M.bias (C.energy (scale x)) (middle x) j) atTop (𝓝 (L j)) := by
    by_cases hs : j = C.source
    · subst j
      simpa [L, q, d, C.endpoints_ne] using C.late_bias_source.mul C.middle_bias_source
    by_cases ht : j = C.target
    · subst j
      simpa [L, q, d, Ne.symm C.endpoints_ne] using C.late_bias_target.mul C.middle_bias_target
    simp only [L, if_neg hs, if_neg ht, add_zero]
    rw [tendsto_zero_iff_abs_tendsto_zero]
    have hz : Tendsto (fun x => |M.bias (C.energy (scale x)) (middle x) j|)
        atTop (𝓝 0) := by simpa only [abs_zero] using (C.middle_bias_away hs ht).abs
    apply squeeze_zero (fun _ => abs_nonneg _) _ hz
    intro x
    rw [abs_mul]
    exact mul_le_of_le_one_left (abs_nonneg _) (M.bias_abs_le_one _ _ _)
  have ht := tendsto_finset_sum Finset.univ (fun j _ => he j)
  have hcoeff : (∑ j, L j) = -2 * (d - 2) / d^2 := by
    simp [L, Finset.sum_add_distrib, q]
    have hd : d ≠ 0 := ne_of_gt M.real_degree_pos
    field_simp [hd]
    ring
  rw [hcoeff] at ht
  exact ht

theorem uniform_second_limit :
    Tendsto (fun x => M.activity (C.energy (scale x)) (late x)
      (M.update (C.energy (scale x)) (middle x) (RegularGraph.uniform V))) atTop
      (𝓝 (1 / 2 + ((M.degree : ℝ) - 2) / (Fintype.card V * (M.degree : ℝ)^2))) := by
  have ht := (tendsto_const_nhds (x := (1 / 2 : ℝ))).sub
    (C.bias_product_limit.div_const (2 * Fintype.card V : ℝ))
  have he : (1 / 2 : ℝ) - (-2 * ((M.degree : ℝ) - 2) / (M.degree : ℝ)^2) /
        (2 * Fintype.card V : ℝ) = 1 / 2 + ((M.degree : ℝ) - 2) /
        (Fintype.card V * (M.degree : ℝ)^2) := by
    have hd := ne_of_gt M.real_degree_pos
    have hn := ne_of_gt (RegularGraph.card_pos_real (V := V))
    field_simp [hd, hn]
    ring
  rw [he] at ht
  simpa only [M.uniform_second_activity] using ht

theorem initial_total_variation_tendsto :
    Tendsto (fun x => (∑ j, |RegularGraph.gibbs (C.energy (scale x)) (early x) j -
      RegularGraph.uniform V j|) / 2) atTop (𝓝 0) := by
  have ht' (j : V) : Tendsto (fun x =>
      |RegularGraph.gibbs (C.energy (scale x)) (early x) j - RegularGraph.uniform V j|)
      atTop (𝓝 0) := by
    simpa using ((C.gibbs_initial_tendsto_uniform j).sub
      (tendsto_const_nhds (x := RegularGraph.uniform V j))).abs
  simpa using (tendsto_finset_sum Finset.univ (fun j _ => ht' j)).div_const 2

omit [Nonempty V] in
lemma tendsto_of_activity_difference {f g : ℝ → ℝ} {c : ℝ}
    (hg : Tendsto g atTop (𝓝 c))
    (hgap : Tendsto (fun x => |f x - g x|) atTop (𝓝 0)) :
    Tendsto f atTop (𝓝 c) := by
  have hd : Tendsto (fun x => f x - g x) atTop (𝓝 0) := by
    rw [tendsto_zero_iff_abs_tendsto_zero]
    exact hgap
  simpa using (hd.add hg).congr (fun x => sub_add_cancel (f x) (g x))

theorem first_activity_limit :
    Tendsto (fun x => M.firstActivity (C.energy (scale x)) (early x) (middle x))
      atTop (𝓝 (1 / 2)) := by
  apply tendsto_of_activity_difference (g := fun _ => 1 / 2) tendsto_const_nhds
  apply squeeze_zero (fun _ => abs_nonneg _) _ C.initial_total_variation_tendsto
  intro x
  have h := M.activity_total_variation (C.energy (scale x)) (middle x)
    (RegularGraph.gibbs (C.energy (scale x)) (early x)) (RegularGraph.uniform V)
    (by rw [RegularGraph.gibbs_sum, RegularGraph.uniform_sum])
  simpa [M.uniform_activity, RegularGraph.firstActivity] using h

theorem second_activity_limit :
    Tendsto (fun x => M.secondActivity (C.energy (scale x)) (early x) (middle x) (late x)) atTop
      (𝓝 (1 / 2 + ((M.degree : ℝ) - 2) / (Fintype.card V * (M.degree : ℝ)^2))) := by
  apply tendsto_of_activity_difference C.uniform_second_limit
  apply squeeze_zero (fun _ => abs_nonneg _) _ C.initial_total_variation_tendsto
  intro x
  let E := C.energy (scale x)
  let p := RegularGraph.gibbs E (early x)
  let u := RegularGraph.uniform V
  have hmass : ∑ j, M.update E (middle x) p j = ∑ j, M.update E (middle x) u j := by
    rw [M.update_sum, M.update_sum, RegularGraph.gibbs_sum, RegularGraph.uniform_sum]
  exact (M.activity_total_variation E (late x) _ _ hmass).trans
    (div_le_div_of_nonneg_right (M.update_total_variation E (middle x) p u) (by norm_num))

theorem average_activity_limit :
    Tendsto (fun x => M.averageActivity (C.energy (scale x)) (early x) (middle x) (late x))
      atTop (𝓝 (1 / 2 + ((M.degree : ℝ) - 2) / (2 * Fintype.card V * (M.degree : ℝ)^2))) := by
  have ht := (C.first_activity_limit.add C.second_activity_limit).div_const 2
  have he : ((1 / 2 : ℝ) + (1 / 2 + ((M.degree : ℝ) - 2) /
      (Fintype.card V * (M.degree : ℝ)^2))) / 2 = 1 / 2 + ((M.degree : ℝ) - 2) /
      (2 * Fintype.card V * (M.degree : ℝ)^2) := by ring
  rwa [he] at ht

theorem eventually_violates (hdegree : 3 ≤ M.degree) : ∀ᶠ x : ℝ in atTop,
    (0 < early x ∧ early x < middle x ∧ middle x < late x) ∧
      1 / 2 < M.secondActivity (C.energy (scale x)) (early x) (middle x) (late x) ∧
      1 / 2 < M.averageActivity (C.energy (scale x)) (early x) (middle x) (late x) := by
  have hd : (3 : ℝ) ≤ M.degree := by exact_mod_cast hdegree
  have hnum : 0 < (M.degree : ℝ) - 2 := by linarith
  have hN := RegularGraph.card_pos_real (V := V)
  have hd' := M.real_degree_pos
  have h2 : (1 / 2 : ℝ) < 1 / 2 + ((M.degree : ℝ) - 2) /
      (Fintype.card V * (M.degree : ℝ)^2) := lt_add_of_pos_right _ (by positivity)
  have ha : (1 / 2 : ℝ) < 1 / 2 + ((M.degree : ℝ) - 2) /
      (2 * Fintype.card V * (M.degree : ℝ)^2) := lt_add_of_pos_right _ (by positivity)
  filter_upwards [eventually_gt_atTop (2 : ℝ),
    C.second_activity_limit.eventually (lt_mem_nhds h2),
    C.average_activity_limit.eventually (lt_mem_nhds ha)] with x hx h2x hax
  exact ⟨inverse_temperature_order hx, h2x, hax⟩

include C in
theorem exists_violating_run (hdegree : 3 ≤ M.degree) :
    ∃ (E : V → ℝ) (β₀ β₁ β₂ : ℝ), 0 < β₀ ∧ β₀ < β₁ ∧ β₁ < β₂ ∧
      1 / 2 < M.secondActivity E β₀ β₁ β₂ ∧ 1 / 2 < M.averageActivity E β₀ β₁ β₂ := by
  obtain ⟨x, ⟨h0, h01, h12⟩, h2, ha⟩ := (C.eventually_violates hdegree).exists
  exact ⟨C.energy (scale x), early x, middle x, late x, h0, h01, h12, h2, ha⟩

end BridgeCut
end GlauberAnnealing
