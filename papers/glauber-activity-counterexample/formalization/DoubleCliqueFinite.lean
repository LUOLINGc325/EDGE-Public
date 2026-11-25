import DoubleCliqueEstimates
import Mathlib.Analysis.SpecialFunctions.Pow.Real

open Filter Topology
open scoped BigOperators

namespace GlauberAnnealing
namespace DoubleClique

open BridgeCut (scale early middle late)

variable {d : ℕ}

theorem initial_l1_le (hd : 3 ≤ d) {x : ℝ} (h : ParameterRange d x) :
    (∑ v : Vertex d, |RegularGraph.gibbs (energy (scale x)) (early x) v -
      RegularGraph.uniform (Vertex d) v|) ≤ 3 * scale x := by
  have hx : 0 < x := by linarith [h.x_gt_two]
  have hε := (scale_pos hx).le
  have hε' : scale x ≤ 1 / 4 := by
    unfold scale
    rw [← one_div]
    exact one_div_le_one_div_of_le (by norm_num) (by nlinarith [h.x_gt_two] : 4 ≤ x^2)
  let U : ℝ := 1 + (d : ℝ) * scale x
  have hU : 0 ≤ U := by dsimp [U]; positivity
  have hEU (v : Vertex d) : 0 ≤ energy (scale x) v ∧ energy (scale x) v ≤ U :=
    ⟨energy_nonneg _ hε v, energy_range _ hε v⟩
  have hm : scale x * U ≤ 3 * scale x / 2 := by
    have hu : U ≤ 3 / 2 := by dsimp [U]; linarith [h.scale_small]
    linarith [mul_le_mul_of_nonneg_left hu hε]
  have hr := RegularGraph.gibbs_distance_bound (energy (d := d) (scale x)) (early x) U
    hε hU hEU (show early x * U ≤ 1 / 2 by change scale x * U ≤ _; linarith)
  change _ ≤ 2 * (scale x * U) at hr
  calc
    _ ≤ 2 * (scale x * U) := hr
    _ ≤ 2 * (3 * scale x / 2) := mul_le_mul_of_nonneg_left hm (by norm_num)
    _ = _ := by ring

theorem middleBiasLimit_abs_le_one (hd : 3 ≤ d) (v : Vertex d) :
    |middleBiasLimit v| ≤ 1 := by
  unfold middleBiasLimit
  by_cases h : Endpoint v
  · have hdabs : |(d : ℝ)| = d := abs_of_nonneg (Nat.cast_nonneg d)
    rw [if_pos h, abs_div, hdabs]
    have hs : |sign v.1| = 1 := by cases h : v.1 <;> simp [sign, h]
    rw [hs]
    have hd0 : (0 : ℝ) < d := by exact_mod_cast (show 0 < d by omega)
    exact (div_le_iff₀ hd0).2 (by simp; exact_mod_cast (show 1 ≤ d by omega))
  · simp [h]

theorem bias_point_product_error (hd : 3 ≤ d) {x : ℝ} (h : ParameterRange d x) (v : Vertex d) :
    |(model d hd).bias (energy (scale x)) (late x) v *
       (model d hd).bias (energy (scale x)) (middle x) v -
       lateBiasLimit v * middleBiasLimit v| ≤ (d : ℝ) / x + 18 * scale x := by
  let a := (model d hd).bias (energy (scale x)) (late x) v
  let b := (model d hd).bias (energy (scale x)) (middle x) v
  let a₀ := lateBiasLimit v
  let b₀ := middleBiasLimit v
  have hstep₁ : |a * (b - b₀)| ≤ (d : ℝ) / x + 16 * scale x := by
    rw [abs_mul]
    exact (mul_le_of_le_one_left (abs_nonneg _) ((model d hd).bias_abs_le_one _ _ _)).trans
      (middle_bias_error hd h v)
  have hstep₂ : |(a - a₀) * b₀| ≤ 2 * scale x := by
    by_cases hv : Endpoint v
    · rw [abs_mul, mul_comm]
      exact (mul_le_of_le_one_left (abs_nonneg _) (middleBiasLimit_abs_le_one hd v)).trans
        (late_bias_error hd h hv)
    have hz : b₀ = 0 := by simp [b₀, middleBiasLimit, hv]
    rw [hz, mul_zero, abs_zero]
    have hx : 0 < x := by linarith [h.x_gt_two]
    exact mul_nonneg (by norm_num) (scale_pos hx).le
  change |a * b - a₀ * b₀| ≤ _
  rw [show a * b - a₀ * b₀ = a * (b - b₀) + (a - a₀) * b₀ by ring]
  linarith [abs_add_le (a * (b - b₀)) ((a - a₀) * b₀)]

theorem ideal_bias_products (hd : 3 ≤ d) :
    (∑ v : Vertex d, lateBiasLimit v * middleBiasLimit v) =
      -4 * ((d : ℝ) - 2) / (d : ℝ)^2 := by
  classical
  have h (v : Vertex d) : lateBiasLimit v * middleBiasLimit v =
      if v ∈ marked d then -((d : ℝ) - 2) / (d : ℝ)^2 else 0 := by
    by_cases he : Endpoint v
    · simp [he, truncated_product v he]
    · simp [he, middleBiasLimit]
  simp_rw [h]
  rw [Finset.sum_ite_mem, Finset.univ_inter, Finset.sum_const, marked_card hd]
  simp only [nsmul_eq_mul, Nat.cast_ofNat]
  ring

theorem uniform_second_error (hd : 3 ≤ d) {x : ℝ} (h : ParameterRange d x) :
    |(model d hd).activity (energy (scale x)) (late x)
      ((model d hd).update (energy (scale x)) (middle x) (RegularGraph.uniform (Vertex d))) -
        (1 / 2 + gap d)| ≤ ((d : ℝ) / x + 18 * scale x) / 2 := by
  let n : ℝ := Fintype.card (Vertex d)
  have hn : 0 < n := RegularGraph.card_pos_real
  let f : Vertex d → ℝ := fun v => (model d hd).bias (energy (scale x)) (late x) v *
    (model d hd).bias (energy (scale x)) (middle x) v
  let g : Vertex d → ℝ := fun v => lateBiasLimit v * middleBiasLimit v
  have hnorm : |∑ v, (f v - g v)| ≤ n * ((d : ℝ) / x + 18 * scale x) := by
    calc
      _ ≤ ∑ v, |f v - g v| := Finset.abs_sum_le_sum_abs _ _
      _ ≤ ∑ _ : Vertex d, ((d : ℝ) / x + 18 * scale x) :=
        Finset.sum_le_sum fun v _ => bias_point_product_error hd h v
      _ = _ := by simp [n, nsmul_eq_mul]; ring
  have hgap : gap d = -(∑ v, g v) / (2 * n) := by
    change gap d = -(∑ v : Vertex d, lateBiasLimit v * middleBiasLimit v) / (2 * n)
    rw [ideal_bias_products hd]
    unfold gap n
    rw [vertex_count]
    push_cast
    have hd0 : (0 : ℝ) < d := by exact_mod_cast (show 0 < d by omega)
    have hds : (0 : ℝ) < d + 1 := by positivity
    field_simp [hd0.ne', hds.ne']
    ring
  rw [(model d hd).uniform_second_activity, hgap]
  change |(1 / 2 - (∑ v, f v) / (2 * n)) -
    (1 / 2 + -(∑ v, g v) / (2 * n))| ≤ _
  rw [show (1 / 2 - (∑ v, f v) / (2 * n)) - (1 / 2 + -(∑ v, g v) / (2 * n)) =
      -((∑ v, (f v - g v)) / (2 * n)) by rw [Finset.sum_sub_distrib]; ring,
    abs_neg, abs_div, abs_of_pos (by positivity : 0 < 2 * n)]
  apply (div_le_iff₀ (by positivity : 0 < 2 * n)).2
  linarith [hnorm]

theorem first_activity_error (hd : 3 ≤ d) {x : ℝ} (h : ParameterRange d x) :
    |(model d hd).firstActivity (energy (scale x)) (early x) (middle x) - 1 / 2| ≤
      3 * scale x := by
  have htv := (model d hd).activity_total_variation (energy (scale x)) (middle x)
    (RegularGraph.gibbs (energy (scale x)) (early x)) (RegularGraph.uniform (Vertex d))
    (by rw [RegularGraph.gibbs_sum, RegularGraph.uniform_sum])
  rw [(model d hd).uniform_activity] at htv
  have hx : 0 < x := by linarith [h.x_gt_two]
  unfold RegularGraph.firstActivity
  linarith [initial_l1_le hd h, (scale_pos hx).le]

theorem second_activity_error (hd : 3 ≤ d) {x : ℝ} (h : ParameterRange d x) :
    |(model d hd).secondActivity (energy (scale x)) (early x) (middle x) (late x) -
      (1 / 2 + gap d)| ≤ (d : ℝ) / x / 2 + 20 * scale x := by
  let M := model d hd
  let E := energy (d := d) (scale x)
  let p := RegularGraph.gibbs E (early x)
  let u := RegularGraph.uniform (Vertex d)
  let b := M.activity E (late x) (M.update E (middle x) u)
  have hmass : ∑ j, M.update E (middle x) p j = ∑ j, M.update E (middle x) u j := by
    rw [M.update_sum, M.update_sum, RegularGraph.gibbs_sum, RegularGraph.uniform_sum]
  have ha := (M.activity_total_variation E (late x) _ _ hmass).trans
    (div_le_div_of_nonneg_right (M.update_total_variation E (middle x) p u) (by norm_num))
  have hu : |b - (1 / 2 + gap d)| ≤ ((d : ℝ) / x + 18 * scale x) / 2 :=
    uniform_second_error hd h
  have hx : 0 < x := by linarith [h.x_gt_two]
  unfold RegularGraph.secondActivity
  change |M.activity E (late x) (M.update E (middle x) p) - (1 / 2 + gap d)| ≤ _
  have htri := abs_sub_le (M.activity E (late x) (M.update E (middle x) p)) b
    (1 / 2 + gap d)
  change |M.activity E (late x) (M.update E (middle x) p) - b| ≤
    (∑ v, |p v - u v|) / 2 at ha
  have hinit : (∑ v, |p v - u v|) ≤ 3 * scale x := initial_l1_le hd h
  linarith [htri, hinit, ha, hu, (scale_pos hx).le]

theorem average_activity_error (hd : 3 ≤ d) {x : ℝ} (h : ParameterRange d x) :
    |(model d hd).averageActivity (energy (scale x)) (early x) (middle x) (late x) -
      (1 / 2 + gap d / 2)| ≤ (d : ℝ) / x / 4 + 23 * scale x / 2 := by
  let a := (model d hd).firstActivity (energy (scale x)) (early x) (middle x)
  let b := (model d hd).secondActivity (energy (scale x)) (early x) (middle x) (late x)
  change |(a + b) / 2 - (1 / 2 + gap d / 2)| ≤ _
  rw [show (a + b) / 2 - (1 / 2 + gap d / 2) =
    ((a - 1 / 2) + (b - (1 / 2 + gap d))) / 2 by ring, abs_div, abs_of_nonneg (by norm_num : 0 ≤ (2 : ℝ))]
  linarith [abs_add_le (a - 1 / 2) (b - (1 / 2 + gap d)),
    first_activity_error hd h, second_activity_error hd h]

theorem gap_lower_bound (hd : 3 ≤ d) : 1 / (4 * (d : ℝ)^2) ≤ gap d := by
  have hd' : (3 : ℝ) ≤ d := by exact_mod_cast hd
  have h : (1 / 4 : ℝ) ≤ ((d : ℝ) - 2) / (d + 1) :=
    (le_div_iff₀ (by positivity)).2 (by linarith)
  unfold gap
  rw [show (4 * (d : ℝ)^2) = 4 * ((d : ℝ)^2) by rfl, ← div_div, mul_comm ((d : ℝ)^2),
    ← div_div]
  exact div_le_div_of_nonneg_right h (sq_nonneg (d : ℝ))

theorem large_parameter_range (hd : 3 ≤ d) {x : ℝ} (hx : 16 * (d : ℝ)^3 ≤ x) :
    ParameterRange d x := by
  have hd' : (1 : ℝ) ≤ d := by exact_mod_cast (show 1 ≤ d by omega)
  have hp : (d : ℝ) ≤ (d : ℝ)^3 := le_self_pow₀ hd' (by decide)
  have hpos : 2 < x := by linarith
  have hx0 : 0 < x := by linarith
  have hsmall : (d : ℝ) / x ≤ 1 / 2 := (div_le_iff₀ hx0).2 (by linarith)
  refine ⟨hpos, hsmall, ?_⟩
  have hε : scale x ≤ 1 / x := by
    unfold scale
    rw [← one_div]
    exact one_div_le_one_div_of_le hx0 (by nlinarith : x ≤ x^2)
  calc
    _ ≤ (d : ℝ) * (1 / x) := mul_le_mul_of_nonneg_left hε (Nat.cast_nonneg d)
    _ = (d : ℝ) / x := by ring
    _ ≤ _ := hsmall

theorem finite_parameter_activities (hd : 3 ≤ d) {x : ℝ} (hx : 16 * (d : ℝ)^3 ≤ x) :
    1 / 2 < (model d hd).secondActivity (energy (scale x)) (early x) (middle x) (late x) ∧
    1 / 2 < (model d hd).averageActivity (energy (scale x)) (early x) (middle x) (late x) := by
  have hd0 : (0 : ℝ) < d := by exact_mod_cast (show 0 < d by omega)
  have hd1 : (1 : ℝ) ≤ d := by exact_mod_cast (show 1 ≤ d by omega)
  have hr := large_parameter_range hd hx
  have hd3 : 1 ≤ (d : ℝ)^3 := one_le_pow₀ hd1
  have hsmall : (d : ℝ) / x ≤ 1 / (16 * (d : ℝ)^2) := by
    have hpos : 0 < x := by linarith [hr.x_gt_two]
    exact (div_le_div_of_nonneg_left hd0.le (by positivity) hx).trans_eq
      (by field_simp [hd0.ne']; ring)
  have hscale : scale x ≤ 1 / (256 * (d : ℝ)^2) := by
    have hprod : 16 * (d : ℝ) ≤ x := by
      linarith [le_self_pow₀ hd1 (by decide : (3 : ℕ) ≠ 0)]
    have hsq : 256 * (d : ℝ)^2 ≤ x^2 := by
      have hs := mul_le_mul_of_nonneg_left hprod (show 0 ≤ x + 16 * (d : ℝ) by linarith [hr.x_gt_two])
      nlinarith
    unfold scale
    rw [← one_div]
    exact one_div_le_one_div_of_le (by positivity) hsq
  have hgap := gap_lower_bound hd
  have hpos : 0 < 1 / (256 * (d : ℝ)^2) := by positivity
  have hmiddle : 1 / (16 * (d : ℝ)^2) = 16 * (1 / (256 * (d : ℝ)^2)) := by
    field_simp [hd0.ne']
    ring
  have hbase : 1 / (4 * (d : ℝ)^2) = 64 * (1 / (256 * (d : ℝ)^2)) := by
    field_simp [hd0.ne']
    ring
  rw [hmiddle] at hsmall
  rw [hbase] at hgap
  have hs := (abs_le.mp (second_activity_error hd hr)).1
  have ha := (abs_le.mp (average_activity_error hd hr)).1
  constructor <;> linarith

theorem scale_inverse_sqrt {ε : ℝ} (hε : 0 ≤ ε) : scale (Real.sqrt ε)⁻¹ = ε := by
  unfold scale
  rw [inv_pow, inv_inv, Real.sq_sqrt hε]

theorem late_inverse_sqrt {ε : ℝ} (hε : 0 ≤ ε) : late (Real.sqrt ε)⁻¹ = (ε ^ 2)⁻¹ := by
  unfold late
  rw [inv_pow, show (Real.sqrt ε)^4 = ((Real.sqrt ε)^2)^2 by ring, Real.sq_sqrt hε]

theorem finite_epsilon_activities (hd : 3 ≤ d) {ε : ℝ} (hε : 0 < ε)
    (hbound : ε ≤ 1 / (256 * (d : ℝ)^6)) :
    let x := (Real.sqrt ε)⁻¹
    Function.Injective (energy (d := d) ε) ∧
    (0 < early x ∧ early x < middle x ∧ middle x < late x) ∧
    early x = ε ∧ late x = (ε ^ 2)⁻¹ ∧
    1 / 2 < (model d hd).secondActivity (energy ε) (early x) (middle x) (late x) ∧
    1 / 2 < (model d hd).averageActivity (energy ε) (early x) (middle x) (late x) := by
  let x := (Real.sqrt ε)⁻¹
  have hd0 : (0 : ℝ) < d := by exact_mod_cast (show 0 < d by omega)
  have hroot : 0 < Real.sqrt ε := Real.sqrt_pos.mpr hε
  have hp : 0 < 16 * (d : ℝ)^3 := by positivity
  have hsq : (Real.sqrt ε)^2 ≤ (1 / (16 * (d : ℝ)^3))^2 := by
    rw [Real.sq_sqrt hε.le]
    convert hbound using 1
    field_simp [hd0.ne']
    ring
  have hrs : Real.sqrt ε ≤ 1 / (16 * (d : ℝ)^3) :=
    (sq_le_sq₀ hroot.le (by positivity)).1 hsq
  have hx : 16 * (d : ℝ)^3 ≤ x := by
    change _ ≤ (Real.sqrt ε)⁻¹
    rw [← one_div]
    apply (le_div_iff₀ hroot).2
    rw [mul_comm]
    exact (le_div_iff₀ hp).1 hrs
  have hscale : scale x = ε := scale_inverse_sqrt hε.le
  have hlate : late x = (ε ^ 2)⁻¹ := late_inverse_sqrt hε.le
  have hr := large_parameter_range hd hx
  have ha := finite_parameter_activities hd hx
  rw [hscale] at ha
  have hparameters : (d : ℝ) * ε < 1 := by
    have ht := hr.scale_small
    rw [hscale] at ht
    linarith
  exact ⟨distinct_energy hε hparameters, BridgeCut.inverse_temperature_order hr.x_gt_two,
    hscale, hlate, ha⟩

private theorem inverse_sqrt_at_zero : Tendsto (fun ε : ℝ => (Real.sqrt ε)⁻¹) (𝓝[>] 0) atTop := by
  have hs : Tendsto Real.sqrt (𝓝[>] (0 : ℝ)) (𝓝[>] (0 : ℝ)) := by
    apply tendsto_inf.2
    constructor
    · have h := Real.continuous_sqrt.continuousAt (x := (0 : ℝ))
      rw [ContinuousAt, Real.sqrt_zero] at h
      exact h.mono_left nhdsWithin_le_nhds
    · exact tendsto_principal.2 (eventually_mem_nhdsWithin.mono fun _ h => Real.sqrt_pos.mpr h)
  exact hs.inv_tendsto_nhdsGT_zero

/-- The three limits with the original parameter and all three original inverse temperatures. -/
theorem original_parameter_limits (hd : 3 ≤ d) :
    Tendsto (fun ε : ℝ => (model d hd).firstActivity (energy ε) ε (Real.sqrt ε)⁻¹)
      (𝓝[>] 0) (𝓝 (1 / 2)) ∧
    Tendsto (fun ε : ℝ => (model d hd).secondActivity (energy ε) ε (Real.sqrt ε)⁻¹ (ε^2)⁻¹)
      (𝓝[>] 0) (𝓝 (1 / 2 + gap d)) ∧
    Tendsto (fun ε : ℝ => (model d hd).averageActivity (energy ε) ε (Real.sqrt ε)⁻¹ (ε^2)⁻¹)
      (𝓝[>] 0) (𝓝 (1 / 2 + gap d / 2)) := by
  refine ⟨((first_activity_limit hd).comp inverse_sqrt_at_zero).congr' ?_,
    ((second_activity_limit hd).comp inverse_sqrt_at_zero).congr' ?_,
    ((average_activity_limit hd).comp inverse_sqrt_at_zero).congr' ?_⟩
  all_goals
    filter_upwards [eventually_mem_nhdsWithin (a := (0 : ℝ)) (s := Set.Ioi 0)] with ε hε
    have hn : 0 ≤ ε := le_of_lt hε
    simp only [Function.comp_apply, early, middle, scale_inverse_sqrt hn, late_inverse_sqrt hn]

end DoubleClique
end GlauberAnnealing
