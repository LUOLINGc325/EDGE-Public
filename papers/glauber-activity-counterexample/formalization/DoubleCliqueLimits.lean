import DoubleCliqueEnergy
import GlauberStructural

open Filter Topology
open scoped BigOperators

namespace GlauberAnnealing
namespace DoubleClique

open BridgeCut (scale early middle late)

variable {d : ℕ}

noncomputable def marked (d : ℕ) : Finset (Vertex d) :=
  {(false, first d false), (false, second d false), (true, first d true), (true, second d true)}

@[simp] theorem mem_marked (v : Vertex d) : v ∈ marked d ↔ Endpoint v := by
  obtain ⟨b, i⟩ := v
  cases b <;> simp [marked, Endpoint]

theorem marked_card (hd : 3 ≤ d) : (marked d).card = 4 := by
  simp [marked, Finset.card_insert_of_not_mem, endpoints_ne hd, Ne.symm (endpoints_ne hd _)]

noncomputable def gap (d : ℕ) : ℝ := ((d : ℝ) - 2) / ((d : ℝ) ^ 2 * (d + 1))

theorem truncated_product (v : Vertex d) (h : Endpoint v) :
    lateBiasLimit v * middleBiasLimit v = -((d : ℝ) - 2) / (d : ℝ)^2 := by
  have he : sign v.1 ^ 2 = 1 := by
    cases h : v.1 <;> norm_num [sign, h]
  rw [middleBiasLimit, if_pos h]
  unfold lateBiasLimit
  calc
    _ = (sign v.1 ^ 2) * (-((d : ℝ) - 2) / (d : ℝ) ^ 2) := by ring
    _ = _ := by rw [he, one_mul]

theorem middle_late_product_limit (hd : 3 ≤ d) :
    Tendsto (fun x => ∑ v, (model d hd).bias (energy (scale x)) (late x) v *
      (model d hd).bias (energy (scale x)) (middle x) v) atTop
      (𝓝 (-4 * ((d : ℝ) - 2) / (d : ℝ)^2)) := by
  classical
  let rhs : Vertex d → ℝ := fun v => if v ∈ marked d then -((d : ℝ) - 2) / (d : ℝ)^2 else 0
  have hr (v : Vertex d) :
      Tendsto (fun x => (model d hd).bias (energy (scale x)) (late x) v *
        (model d hd).bias (energy (scale x)) (middle x) v) atTop (𝓝 (rhs v)) := by
    by_cases he : Endpoint v
    · have hp := (late_bias_limit hd he).mul (middle_bias_limit hd v)
      simpa [rhs, he, truncated_product v he] using hp
    · simp only [rhs, mem_marked, if_neg he]
      rw [tendsto_zero_iff_abs_tendsto_zero]
      have hz := (middle_bias_limit hd v).abs
      have hm : Tendsto (fun x => |(model d hd).bias (energy (scale x)) (middle x) v|)
          atTop (𝓝 0) := by simpa [middleBiasLimit, he] using hz
      apply squeeze_zero (fun _ => abs_nonneg _) _ hm
      intro x
      rw [abs_mul]
      exact mul_le_of_le_one_left (abs_nonneg _) ((model d hd).bias_abs_le_one _ _ _)
  have hsum : (∑ v, rhs v) = -4 * ((d : ℝ) - 2) / (d : ℝ)^2 := by
    unfold rhs
    rw [Finset.sum_ite_mem, Finset.univ_inter, Finset.sum_const, marked_card hd]
    simp only [nsmul_eq_mul, Nat.cast_ofNat]
    ring
  rw [← hsum]
  exact tendsto_finset_sum _ fun v _ => hr v

theorem initial_limit (v : Vertex d) :
    Tendsto (fun x => RegularGraph.gibbs (energy (scale x)) (early x) v)
      atTop (𝓝 (RegularGraph.uniform (Vertex d) v)) := by
  have hw (w : Vertex d) :
      Tendsto (fun x => RegularGraph.weight (energy (scale x)) (early x) w) atTop (𝓝 1) := by
    simpa [RegularGraph.weight, early] using (BridgeCut.scale_tendsto.neg.mul (energy_limit w)).rexp
  have hsum : Tendsto (fun x => ∑ w : Vertex d, RegularGraph.weight (energy (scale x)) (early x) w)
      atTop (𝓝 (Fintype.card (Vertex d) : ℝ)) := by
    simpa using tendsto_finset_sum Finset.univ (fun w _ => hw w)
  exact (hw v).div hsum (ne_of_gt (RegularGraph.card_pos_real (V := Vertex d)))

theorem initial_error_limit : Tendsto (fun x => (∑ v : Vertex d,
    |RegularGraph.gibbs (energy (scale x)) (early x) v - RegularGraph.uniform (Vertex d) v|) / 2)
    atTop (𝓝 0) := by
  have h (v : Vertex d) : Tendsto (fun x =>
      |RegularGraph.gibbs (energy (scale x)) (early x) v - RegularGraph.uniform (Vertex d) v|)
      atTop (𝓝 0) := by
    simpa using ((initial_limit v).sub (tendsto_const_nhds (x := RegularGraph.uniform (Vertex d) v))).abs
  simpa using (tendsto_finset_sum Finset.univ (fun v _ => h v)).div_const 2

theorem uniform_second_limit (hd : 3 ≤ d) :
    Tendsto (fun x => (model d hd).activity (energy (scale x)) (late x)
      ((model d hd).update (energy (scale x)) (middle x) (RegularGraph.uniform (Vertex d))))
      atTop (𝓝 (1 / 2 + gap d)) := by
  have h := (tendsto_const_nhds (x := (1 / 2 : ℝ))).sub
    ((middle_late_product_limit hd).div_const (2 * Fintype.card (Vertex d) : ℝ))
  have he : (1 / 2 : ℝ) - (-4 * ((d : ℝ) - 2) / (d : ℝ)^2) /
      (2 * Fintype.card (Vertex d) : ℝ) = 1 / 2 + gap d := by
    unfold gap
    rw [vertex_count]
    push_cast
    have hpos : (0 : ℝ) < d := by exact_mod_cast (show 0 < d by omega)
    have hsum : (0 : ℝ) < d + 1 := by positivity
    field_simp [ne_of_gt hpos, ne_of_gt hsum]
    ring
  rw [he] at h
  simpa [(model d hd).uniform_second_activity] using h

theorem first_activity_limit (hd : 3 ≤ d) :
    Tendsto (fun x => (model d hd).firstActivity (energy (scale x)) (early x) (middle x))
      atTop (𝓝 (1 / 2)) := by
  apply BridgeCut.tendsto_of_activity_difference (g := fun _ => 1 / 2) tendsto_const_nhds
  apply squeeze_zero (fun _ => abs_nonneg _) _ (initial_error_limit (d := d))
  intro x
  have h := (model d hd).activity_total_variation (energy (scale x)) (middle x)
    (RegularGraph.gibbs (energy (scale x)) (early x)) (RegularGraph.uniform (Vertex d))
    (by rw [RegularGraph.gibbs_sum, RegularGraph.uniform_sum])
  simpa [(model d hd).uniform_activity, RegularGraph.firstActivity] using h

theorem second_activity_limit (hd : 3 ≤ d) :
    Tendsto (fun x => (model d hd).secondActivity (energy (scale x)) (early x) (middle x) (late x))
      atTop (𝓝 (1 / 2 + gap d)) := by
  let M := model d hd
  apply BridgeCut.tendsto_of_activity_difference (uniform_second_limit hd)
  apply squeeze_zero (fun _ => abs_nonneg _) _ (initial_error_limit (d := d))
  intro x
  let E := energy (d := d) (scale x)
  let p := RegularGraph.gibbs E (early x)
  let u := RegularGraph.uniform (Vertex d)
  have hmass : ∑ j, M.update E (middle x) p j = ∑ j, M.update E (middle x) u j := by
    rw [M.update_sum, M.update_sum, RegularGraph.gibbs_sum, RegularGraph.uniform_sum]
  exact (M.activity_total_variation E (late x) _ _ hmass).trans
    (div_le_div_of_nonneg_right (M.update_total_variation E (middle x) p u) (by norm_num))

theorem average_activity_limit (hd : 3 ≤ d) :
    Tendsto (fun x => (model d hd).averageActivity (energy (scale x)) (early x) (middle x) (late x))
      atTop (𝓝 (1 / 2 + gap d / 2)) := by
  have ht := ((first_activity_limit hd).add (second_activity_limit hd)).div_const 2
  convert ht using 2
  ring

theorem updated_vector_limit (hd : 3 ≤ d) (v : Vertex d) :
    Tendsto (fun x => (model d hd).update (energy (scale x)) (middle x)
      (RegularGraph.gibbs (energy (scale x)) (early x)) v) atTop
      (𝓝 ((1 - middleBiasLimit v) / Fintype.card (Vertex d))) := by
  let M := model d hd
  let u := RegularGraph.uniform (Vertex d)
  have hu : Tendsto (fun x => M.update (energy (scale x)) (middle x) u v) atTop
      (𝓝 ((1 - middleBiasLimit v) / Fintype.card (Vertex d))) := by
    change Tendsto (fun x => M.update (energy (scale x)) (middle x)
      (RegularGraph.uniform (Vertex d)) v) atTop _
    simp_rw [M.uniform_update]
    exact ((tendsto_const_nhds (x := (1 : ℝ))).sub (middle_bias_limit hd v)).div_const
      (Fintype.card (Vertex d) : ℝ)
  apply BridgeCut.tendsto_of_activity_difference hu
  have hz : Tendsto (fun x => ∑ v : Vertex d,
      |RegularGraph.gibbs (energy (scale x)) (early x) v - u v|) atTop (𝓝 0) := by
    have ht := (initial_error_limit (d := d)).const_mul 2
    simpa [u, mul_div_cancel₀] using ht
  apply squeeze_zero (fun _ => abs_nonneg _) _ hz
  intro x
  refine (Finset.single_le_sum (fun w _ => abs_nonneg
    (M.update (energy (scale x)) (middle x) (RegularGraph.gibbs (energy (scale x)) (early x)) w -
      M.update (energy (scale x)) (middle x) u w)) (Finset.mem_univ v)).trans ?_
  exact M.update_total_variation (energy (scale x)) (middle x) _ _

theorem eight_vertex_limits : 1 / 2 + gap 3 = (19 / 36 : ℝ) ∧
    1 / 2 + gap 3 / 2 = (37 / 72 : ℝ) := by
  norm_num [gap]

end DoubleClique
end GlauberAnnealing
