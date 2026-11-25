import GlauberBias
import GlauberBridge
import Mathlib.Topology.Algebra.Order.Field

open Filter Topology
open scoped BigOperators

namespace GlauberAnnealing

noncomputable def centered (x : ℝ) : ℝ := 1 - 2 * acceptance x

@[simp] theorem centered_zero : centered 0 = 0 := by
  norm_num [centered, acceptance]

theorem centered_neg (x : ℝ) : centered (-x) = -centered x := by
  unfold centered
  linarith [acceptance_add_neg x]

theorem centered_eq_tanh (x : ℝ) : centered x = Real.tanh (x / 2) := by
  rw [Real.tanh_eq_sinh_div_cosh, Real.sinh_eq, Real.cosh_eq]
  have hp := Real.exp_pos (x / 2)
  have hx : Real.exp x = Real.exp (x / 2) * Real.exp (x / 2) := by
    rw [← Real.exp_add]
    congr 1
    ring
  unfold centered acceptance
  rw [hx, Real.exp_neg]
  have hcosh : 0 < Real.exp (x / 2) + (Real.exp (x / 2))⁻¹ := by positivity
  have hden : 0 < 1 + Real.exp (x / 2) * Real.exp (x / 2) := by positivity
  field_simp [ne_of_gt hp, ne_of_gt hcosh, ne_of_gt hden]
  ring

theorem continuous_centered : Continuous centered := by
  unfold centered acceptance
  exact continuous_const.sub (continuous_const.mul
    (continuous_const.div (continuous_const.add Real.continuous_exp) fun x => by positivity))

theorem centered_atTop : Tendsto centered atTop (𝓝 1) := by
  have hden : Tendsto (fun x : ℝ => 1 + Real.exp x) atTop atTop :=
    tendsto_const_nhds.add_atTop Real.tendsto_exp_atTop
  have h : Tendsto acceptance atTop (𝓝 0) := by
    change Tendsto (fun x => 1 / (1 + Real.exp x)) atTop (𝓝 0)
    simpa only [one_div, Function.comp_def] using tendsto_inv_atTop_zero.comp hden
  change Tendsto (fun x => 1 - 2 * acceptance x) atTop (𝓝 1)
  convert (tendsto_const_nhds (x := (1 : ℝ))).sub (h.const_mul (2 : ℝ)) using 2
  norm_num

theorem centered_atBot : Tendsto centered atBot (𝓝 (-1)) := by
  have hden : Tendsto (fun x : ℝ => 1 + Real.exp x) atBot (𝓝 1) := by
    simpa using (tendsto_const_nhds (x := (1 : ℝ))).add Real.tendsto_exp_atBot
  have h : Tendsto acceptance atBot (𝓝 1) := by
    simpa [acceptance] using (tendsto_const_nhds (x := (1 : ℝ))).div hden one_ne_zero
  change Tendsto (fun x => 1 - 2 * acceptance x) atBot (𝓝 (-1))
  convert (tendsto_const_nhds (x := (1 : ℝ))).sub (h.const_mul (2 : ℝ)) using 2
  norm_num

variable {V : Type*} [Fintype V] {M : RegularGraph V}

theorem RegularGraph.bias_sum_neighbors (M : RegularGraph V) (E : V → ℝ) (β : ℝ) (i : V) :
    M.bias E β i = (∑ j ∈ neighbors M.graph i, centered (β * (E i - E j))) / M.degree := by
  classical
  have hrate (j : V) : M.edgeRate E β j i =
      if j ∈ neighbors M.graph i then acceptance (β * (E j - E i)) / M.degree else 0 := by
    by_cases hj : M.graph.Adj i j
    · rw [M.edgeRate_of_adj E β hj.symm, if_pos (mem_neighbors.mpr hj)]
    · rw [M.edgeRate_of_not_adj E β (fun h => hj h.symm), if_neg (fun h => hj (mem_neighbors.mp h))]
  have hexit : M.exitRate E β i =
      (∑ j ∈ neighbors M.graph i, acceptance (β * (E j - E i))) / M.degree := by
    unfold RegularGraph.exitRate
    simp_rw [hrate]
    rw [Finset.sum_ite_mem, Finset.univ_inter, ← Finset.sum_div]
  have hc (j : V) : centered (β * (E i - E j)) = 2 * acceptance (β * (E j - E i)) - 1 := by
    rw [show β * (E j - E i) = -(β * (E i - E j)) by ring]
    unfold centered
    linarith [acceptance_add_neg (β * (E i - E j))]
  unfold RegularGraph.bias
  rw [hexit]
  simp_rw [hc]
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum, Finset.sum_const, M.card_neighbors]
  simp only [nsmul_eq_mul, mul_one]
  have hd := ne_of_gt M.real_degree_pos
  field_simp [hd]

theorem RegularGraph.bias_abs_le_one (M : RegularGraph V) (E : V → ℝ) (β : ℝ) (i : V) :
    |M.bias E β i| ≤ 1 := by
  unfold RegularGraph.bias
  exact abs_le.mpr ⟨by linarith [M.exit_nonneg E β i], by linarith [M.exit_lt_one E β i]⟩

namespace BridgeCut

variable (C : BridgeCut M)

theorem scale_tendsto : Tendsto scale atTop (𝓝 0) :=
  (tendsto_pow_atTop (α := ℝ) (n := 2) (by decide)).inv_tendsto_atTop

theorem middle_small : Tendsto (fun x => middle x * scale x) atTop (𝓝 0) := by
  apply (tendsto_inv_atTop_zero (𝕜 := ℝ)).congr'
  filter_upwards [eventually_gt_atTop (0 : ℝ)] with x hx
  unfold middle scale
  field_simp [ne_of_gt hx]
  ring

theorem late_small : Tendsto (fun x => late x * scale x) atTop atTop := by
  apply (tendsto_pow_atTop (α := ℝ) (n := 2) (by decide)).congr'
  filter_upwards [eventually_gt_atTop (0 : ℝ)] with x hx
  unfold late scale
  field_simp [ne_of_gt hx]
  ring

theorem resolve_crossing (β : ℝ → ℝ) (hβ : Tendsto β atTop atTop) :
    Tendsto (fun x => β x * (1 - 2 * scale x)) atTop atTop := by
  have hc : Tendsto (fun x => 1 - 2 * scale x) atTop (𝓝 1) := by
    simpa using (tendsto_const_nhds (x := (1 : ℝ))).sub (scale_tendsto.const_mul 2)
  exact hβ.atTop_mul_pos zero_lt_one hc

theorem reverse_crossing (β : ℝ → ℝ) (hβ : Tendsto β atTop atTop) :
    Tendsto (fun x => β x * (2 * scale x - 1)) atTop atBot := by
  have hf := tendsto_neg_atTop_atBot.comp (resolve_crossing β hβ)
  apply hf.congr
  intro x
  simp only [Function.comp_apply]
  ring

theorem centered_same_side_middle {i j : V} (h : C.low i ↔ C.low j) :
    Tendsto (fun x => centered (middle x * (C.energy (scale x) i - C.energy (scale x) j)))
      atTop (𝓝 0) := by
  have hg : Tendsto (fun x => middle x * (C.energy (scale x) i - C.energy (scale x) j))
      atTop (𝓝 0) := by
    have hlim : Tendsto (fun x => middle x * scale x * (C.slope i - C.slope j))
        atTop (𝓝 0) := by
      simpa only [zero_mul] using middle_small.mul_const (C.slope i - C.slope j)
    apply hlim.congr
    intro x
    rw [C.same_side_difference (scale x) h]
    ring
  simpa using (continuous_centered.continuousAt.tendsto.comp hg)

theorem middle_bias_away {i : V} (his : i ≠ C.source) (hit : i ≠ C.target) :
    Tendsto (fun x => M.bias (C.energy (scale x)) (middle x) i) atTop (𝓝 0) := by
  have hs : Tendsto
      (fun x => ∑ j ∈ neighbors M.graph i, centered (middle x * (C.energy (scale x) i -
        C.energy (scale x) j))) atTop (𝓝 0) := by
    simpa using tendsto_finset_sum (neighbors M.graph i) fun j hj =>
      C.centered_same_side_middle (C.same_side_of_nonendpoint his hit (mem_neighbors.mp hj))
  simpa [M.bias_sum_neighbors] using hs.div_const (M.degree : ℝ)

open Classical in
omit [Fintype V] in
lemma sum_with_exception (S : Finset V) {j : V} (hj : j ∈ S) (a b : ℝ) :
    (∑ i ∈ S, if i = j then a else b) = (S.card : ℝ) * b + (a - b) := by
  have h (i : V) : (if i = j then a else b) = b + if i = j then a - b else 0 := by
    split_ifs <;> ring
  simp_rw [h]
  simp [Finset.sum_add_distrib, hj, nsmul_eq_mul]

open Classical in
theorem endpoint_bias_limit (β : ℝ → ℝ) {i j : V} (hj : j ∈ neighbors M.graph i)
    (crossing internal : ℝ → ℝ) (crossLimit internalLimit : ℝ)
    (hd : ∀ v ∈ neighbors M.graph i, ∀ x,
      C.energy (scale x) i - C.energy (scale x) v = if v = j then crossing x else internal x)
    (hc : Tendsto (fun x => centered (β x * crossing x)) atTop (𝓝 crossLimit))
    (hi : Tendsto (fun x => centered (β x * internal x)) atTop (𝓝 internalLimit)) :
    Tendsto (fun x => M.bias (C.energy (scale x)) (β x) i) atTop
      (𝓝 (((M.degree : ℝ) * internalLimit + (crossLimit - internalLimit)) / M.degree)) := by
  have hs : Tendsto (fun x => ∑ v ∈ neighbors M.graph i,
      centered (β x * (C.energy (scale x) i - C.energy (scale x) v))) atTop
      (𝓝 (∑ v ∈ neighbors M.graph i, if v = j then crossLimit else internalLimit)) := by
    refine tendsto_finset_sum _ fun v hv => ?_
    by_cases h : v = j
    · simpa only [hd v hv, if_pos h] using hc
    · simpa only [hd v hv, if_neg h] using hi
  rw [sum_with_exception _ hj, M.card_neighbors] at hs
  simpa [M.bias_sum_neighbors] using hs.div_const (M.degree : ℝ)

theorem middle_bias_source :
    Tendsto (fun x => M.bias (C.energy (scale x)) (middle x) C.source) atTop
      (𝓝 (-1 / (M.degree : ℝ))) := by
  have hcross := centered_atBot.comp (reverse_crossing middle tendsto_id)
  have hsmall := (continuous_centered.continuousAt.tendsto.comp middle_small)
  simpa [Function.comp_def] using C.endpoint_bias_limit middle C.endpoint_mem_neighbors
    (fun x => 2 * scale x - 1) scale (-1) 0
    (fun _ hv x => C.source_neighbor_difference (scale x) (mem_neighbors.mp hv))
    hcross (by simpa using hsmall)

theorem middle_bias_target :
    Tendsto (fun x => M.bias (C.energy (scale x)) (middle x) C.target) atTop
      (𝓝 (1 / (M.degree : ℝ))) := by
  have hcross := centered_atTop.comp (resolve_crossing middle tendsto_id)
  have hn : Tendsto (fun x => middle x * -scale x) atTop (𝓝 0) := by
    simpa only [mul_neg, neg_zero] using middle_small.neg
  have hs := (continuous_centered.continuousAt.tendsto.comp hn)
  simpa [Function.comp_def] using C.endpoint_bias_limit middle C.source_mem_neighbors
    (fun x => 1 - 2 * scale x) (fun x => -scale x) 1 0
    (fun _ hv x => C.target_neighbor_difference (scale x) (mem_neighbors.mp hv))
    hcross (by simpa using hs)

theorem late_bias_source :
    Tendsto (fun x => M.bias (C.energy (scale x)) (late x) C.source) atTop
      (𝓝 (((M.degree : ℝ) - 2) / M.degree)) := by
  have hlate : Tendsto late atTop atTop := tendsto_pow_atTop (by decide)
  have hc := centered_atBot.comp (reverse_crossing late hlate)
  have hi := centered_atTop.comp late_small
  have hb := C.endpoint_bias_limit
    late C.endpoint_mem_neighbors (fun x => 2 * scale x - 1) scale (-1) 1
    (fun _ hv x => C.source_neighbor_difference (scale x) (mem_neighbors.mp hv)) hc hi
  convert hb using 2
  ring

theorem late_bias_target :
    Tendsto (fun x => M.bias (C.energy (scale x)) (late x) C.target) atTop
      (𝓝 (-(((M.degree : ℝ) - 2) / M.degree))) := by
  have hlate : Tendsto late atTop atTop := tendsto_pow_atTop (by decide)
  have hc := centered_atTop.comp (resolve_crossing late hlate)
  have hn : Tendsto (fun x => late x * -scale x) atTop atBot := by
    simpa only [Function.comp_def, mul_neg] using tendsto_neg_atTop_atBot.comp late_small
  have hi := centered_atBot.comp hn
  have hb := C.endpoint_bias_limit late C.source_mem_neighbors (fun x => 1 - 2 * scale x)
    (fun x => -scale x) 1 (-1)
    (fun _ hv x => C.target_neighbor_difference (scale x) (mem_neighbors.mp hv)) hc hi
  convert hb using 2
  ring

end BridgeCut
end GlauberAnnealing
