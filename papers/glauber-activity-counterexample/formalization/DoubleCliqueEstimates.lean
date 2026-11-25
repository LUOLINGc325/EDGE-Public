import GlauberErrorBounds

open scoped BigOperators

namespace GlauberAnnealing
namespace DoubleClique

open BridgeCut (scale early middle late)

variable {d : ℕ}

structure ParameterRange (d : ℕ) (x : ℝ) : Prop where
  x_gt_two : 2 < x
  middle_small : (d : ℝ) / x ≤ 1 / 2
  scale_small : (d : ℝ) * scale x ≤ 1 / 2

theorem middle_scale_identity {x : ℝ} (hx : 0 < x) : middle x * scale x = 1 / x := by
  unfold middle scale
  field_simp [hx.ne']
  ring

theorem late_scale_identity {x : ℝ} (hx : 0 < x) : late x * scale x = x ^ 2 := by
  unfold late scale
  field_simp [hx.ne']
  ring

theorem scale_pos {x : ℝ} (hx : 0 < x) : 0 < scale x := by
  unfold scale
  positivity

theorem index_difference_abs_le (v w : Vertex d) : |(v.2.val : ℝ) - w.2.val| ≤ d := by
  have hv : (v.2.val : ℝ) ≤ d := by exact_mod_cast Nat.le_of_lt_succ v.2.isLt
  have hw : (w.2.val : ℝ) ≤ d := by exact_mod_cast Nat.le_of_lt_succ w.2.isLt
  exact abs_le.mpr ⟨by linarith [Nat.cast_nonneg (α := ℝ) v.2.val],
    by linarith [Nat.cast_nonneg (α := ℝ) w.2.val]⟩

theorem cross_difference_lower {x : ℝ} (h : ParameterRange d x) {v w : Vertex d}
    (vh : v.1 = true) (wl : w.1 = false) :
    1 / 2 ≤ energy (scale x) v - energy (scale x) w := by
  have hx : 0 < x := by linarith [h.x_gt_two]
  have hε := (scale_pos hx).le
  linarith [range_when_high (scale x) hε vh,
    range_when_low (scale x) hε wl, h.scale_small]

theorem middle_internal_error {x : ℝ} (h : ParameterRange d x) {v w : Vertex d}
    (hs : v.1 = w.1) :
    |centered (middle x * (energy (scale x) v - energy (scale x) w))| ≤ (d : ℝ) / x := by
  have hx : 0 < x := by linarith [h.x_gt_two]
  have he : middle x * (energy (scale x) v - energy (scale x) w) =
      (1 / x) * ((v.2.val : ℝ) - w.2.val) := by
    rw [same_side_diff _ hs, ← mul_assoc, middle_scale_identity hx]
  have ha : |(1 / x) * ((v.2.val : ℝ) - w.2.val)| ≤ (d : ℝ) / x := by
    rw [abs_mul, abs_of_nonneg (by positivity : 0 ≤ (1 : ℝ) / x)]
    calc
      _ ≤ (1 / x) * d := mul_le_mul_of_nonneg_left (index_difference_abs_le v w) (by positivity)
      _ = _ := by ring
  rw [he]
  exact (abs_centered_le_small _ (ha.trans h.middle_small)).trans ha

theorem middle_cross_error {x : ℝ} (h : ParameterRange d x) {v w : Vertex d}
    (hs : v.1 ≠ w.1) :
    |centered (middle x * (energy (scale x) v - energy (scale x) w)) - sign v.1| ≤
      16 * scale x := by
  have hx : 0 < x := by linarith [h.x_gt_two]
  have hbound {a b : Vertex d} (ha : a.1 = true) (hb : b.1 = false) :
      2 * Real.exp (-(middle x * (energy (scale x) a - energy (scale x) b))) ≤
        16 * scale x := by
    apply le_trans _ (show 2 * Real.exp (-(x / 2)) ≤ _ from ?_)
    · have he := mul_le_mul_of_nonneg_left (cross_difference_lower h ha hb) hx.le
      apply mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr _) (by norm_num)
      dsimp [middle]
      linarith
    · have ht := mul_le_mul_of_nonneg_left
        (exponential_tail_square (x / 2) (by positivity)) (show (0 : ℝ) ≤ 2 by norm_num)
      convert ht using 1
      unfold scale
      field_simp [hx.ne']
      ring
  have hw : w.1 = !v.1 := other_side_of_ne (Ne.symm hs)
  cases hv : v.1
  · have hw' : w.1 = true := by simpa [hv] using hw
    rw [show sign false = -1 by rfl,
      show middle x * (energy (scale x) v - energy (scale x) w) =
        -(middle x * (energy (scale x) w - energy (scale x) v)) by ring]
    exact (centered_tail_negative _).trans (hbound hw' hv)
  · have hw' : w.1 = false := by simpa [hv] using hw
    rw [show sign true = 1 by rfl]
    exact (centered_tail _).trans (hbound hv hw')

theorem late_cross_error {x : ℝ} (h : ParameterRange d x) {v w : Vertex d}
    (hs : v.1 ≠ w.1) :
    |centered (late x * (energy (scale x) v - energy (scale x) w)) - sign v.1| ≤
      2 * scale x := by
  have hx : 0 < x := by linarith [h.x_gt_two]
  have hsq : 2 ≤ x ^ 2 := by nlinarith [h.x_gt_two]
  have hbound {a b : Vertex d} (ha : a.1 = true) (hb : b.1 = false) :
      2 * Real.exp (-(late x * (energy (scale x) a - energy (scale x) b))) ≤
        2 * scale x := by
    apply le_trans _ (show 2 * Real.exp (-(x ^ 2)) ≤ _ from ?_)
    · apply mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr _) (by norm_num)
      have he := mul_le_mul_of_nonneg_left (cross_difference_lower h ha hb)
        (show 0 ≤ late x by unfold late; positivity)
      have hp := mul_le_mul_of_nonneg_left hsq (sq_nonneg x)
      unfold late at *
      nlinarith
    · have ht : Real.exp (-(x ^ 2)) ≤ scale x := by
        simpa only [scale, one_div] using exponential_tail_linear _ (sq_pos_of_pos hx)
      exact mul_le_mul_of_nonneg_left ht (by norm_num)
  have hw : w.1 = !v.1 := other_side_of_ne (Ne.symm hs)
  cases hv : v.1
  · have hw' : w.1 = true := by simpa [hv] using hw
    rw [show sign false = -1 by rfl,
      show late x * (energy (scale x) v - energy (scale x) w) =
        -(late x * (energy (scale x) w - energy (scale x) v)) by ring]
    exact (centered_tail_negative _).trans (hbound hw' hv)
  · have hw' : w.1 = false := by simpa [hv] using hw
    rw [show sign true = 1 by rfl]
    exact (centered_tail _).trans (hbound hv hw')

theorem late_internal_error (hd : 3 ≤ d) {x : ℝ} (h : ParameterRange d x)
    {v w : Vertex d} (he : Endpoint v) (hw : w ∈ neighbors (graph d) v)
    (hs : v.1 = w.1) :
    |centered (late x * (energy (scale x) v - energy (scale x) w)) - (-sign v.1)| ≤
      2 * scale x := by
  have hx : 0 < x := by linarith [h.x_gt_two]
  have horder := endpoint_internal_neighbor_order hd he hw hs
  have hdiff : late x * (energy (scale x) v - energy (scale x) w) =
      x ^ 2 * ((v.2.val : ℝ) - w.2.val) := by
    rw [same_side_diff _ hs, ← mul_assoc, late_scale_identity hx]
  have hbound {z : ℝ} (hz : x ^ 2 ≤ z) : 2 * Real.exp (-z) ≤ 2 * scale x := by
    have ht : Real.exp (-(x ^ 2)) ≤ scale x := by
      simpa only [scale, one_div] using exponential_tail_linear _ (sq_pos_of_pos hx)
    exact mul_le_mul_of_nonneg_left ((Real.exp_le_exp.mpr (neg_le_neg hz)).trans ht) (by norm_num)
  rw [hdiff]
  cases hv : v.1
  · have hnv : w.2.val + 1 ≤ v.2.val := by simpa [hv] using horder
    have hr : (w.2.val : ℝ) + 1 ≤ v.2.val := by exact_mod_cast hnv
    rw [show -sign false = 1 by norm_num [sign]]
    apply (centered_tail _).trans (hbound _)
    simpa using mul_le_mul_of_nonneg_left (show (1 : ℝ) ≤ v.2.val - w.2.val by linarith)
      (sq_nonneg x)
  · have hnv : v.2.val + 1 ≤ w.2.val := by simpa [hv] using horder
    have hr : (v.2.val : ℝ) + 1 ≤ w.2.val := by exact_mod_cast hnv
    rw [show -sign true = -1 by norm_num [sign],
      show x ^ 2 * ((v.2.val : ℝ) - w.2.val) = -(x ^ 2 * ((w.2.val : ℝ) - v.2.val)) by ring]
    apply (centered_tail_negative _).trans (hbound _)
    simpa using mul_le_mul_of_nonneg_left (show (1 : ℝ) ≤ w.2.val - v.2.val by linarith)
      (sq_nonneg x)

open Classical in
noncomputable def middleIdeal (v w : Vertex d) : ℝ :=
  if v.1 = w.1 then 0 else sign v.1

open Classical in
noncomputable def lateIdeal (v w : Vertex d) : ℝ :=
  if v.1 = w.1 then -sign v.1 else sign v.1

theorem middleIdeal_mean (hd : 3 ≤ d) (v : Vertex d) :
    (∑ w ∈ neighbors (graph d) v, middleIdeal v w) / d = middleBiasLimit v := by
  classical
  unfold middleBiasLimit
  by_cases h : Endpoint v
  · rw [if_pos h]
    have hr (w : Vertex d) (hw : w ∈ neighbors (graph d) v) :
        middleIdeal v w = if w = crossNeighbor v then sign v.1 else 0 := by
      by_cases hz : w = crossNeighbor v
      · subst w
        simp [middleIdeal, Ne.symm (not_side v.1)]
      · have hs : v.1 = w.1 := by by_contra hn; exact hz (crossNeighbor_unique hd hw hn)
        simp [middleIdeal, hs, hz]
    rw [Finset.sum_congr rfl hr]
    simp [crossNeighbor_mem v h]
  · rw [if_neg h]
    have hz : (∑ w ∈ neighbors (graph d) v, middleIdeal v w) = 0 := by
      apply Finset.sum_eq_zero
      intro w hw
      simp [middleIdeal, nonendpoint_neighbor_on_side h hw]
    simp [hz]

theorem lateIdeal_mean (hd : 3 ≤ d) {v : Vertex d} (hv : Endpoint v) :
    (∑ w ∈ neighbors (graph d) v, lateIdeal v w) / d = lateBiasLimit v := by
  classical
  have hr (w : Vertex d) (hw : w ∈ neighbors (graph d) v) :
      lateIdeal v w = -sign v.1 + if w = crossNeighbor v then 2 * sign v.1 else 0 := by
    by_cases hz : w = crossNeighbor v
    · subst w
      simp [lateIdeal, Ne.symm (not_side v.1)]
      ring
    · have hs : v.1 = w.1 := by by_contra hn; exact hz (crossNeighbor_unique hd hw hn)
      simp [lateIdeal, hs, hz]
  rw [Finset.sum_congr rfl hr, Finset.sum_add_distrib]
  simp [crossNeighbor_mem v hv, graph_regular hd, lateBiasLimit, nsmul_eq_mul]
  ring

private theorem average_difference_le (hd : 3 ≤ d) (v : Vertex d) (f g : Vertex d → ℝ)
    (B : ℝ) (h : ∀ w ∈ neighbors (graph d) v, |f w - g w| ≤ B) :
    |(∑ w ∈ neighbors (graph d) v, f w) / d -
      (∑ w ∈ neighbors (graph d) v, g w) / d| ≤ B := by
  rw [← sub_div, ← Finset.sum_sub_distrib, abs_div]
  have hd' : (0 : ℝ) < d := by exact_mod_cast (show 0 < d by omega)
  rw [abs_of_pos hd']
  apply (div_le_iff₀ hd').2
  calc
    _ ≤ ∑ w ∈ neighbors (graph d) v, |f w - g w| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ _ ∈ neighbors (graph d) v, B := Finset.sum_le_sum h
    _ = _ := by simp [Finset.sum_const, graph_regular hd, nsmul_eq_mul, mul_comm]

theorem middle_bias_error (hd : 3 ≤ d) {x : ℝ} (h : ParameterRange d x) (v : Vertex d) :
    |(model d hd).bias (energy (scale x)) (middle x) v - middleBiasLimit v| ≤
      (d : ℝ) / x + 16 * scale x := by
  rw [(model d hd).bias_sum_neighbors, ← middleIdeal_mean hd v]
  change |(∑ w ∈ neighbors (graph d) v,
      centered (middle x * (energy (scale x) v - energy (scale x) w))) / d -
    (∑ w ∈ neighbors (graph d) v, middleIdeal v w) / d| ≤ _
  apply average_difference_le hd
  intro w _
  have hx : 0 < x := by linarith [h.x_gt_two]
  by_cases hs : v.1 = w.1
  · simpa [middleIdeal, hs] using (middle_internal_error h hs).trans
      (le_add_of_nonneg_right (mul_nonneg (by norm_num) (scale_pos hx).le))
  · simpa [middleIdeal, hs] using (middle_cross_error h hs).trans
      (le_add_of_nonneg_left (by positivity : 0 ≤ (d : ℝ) / x))

theorem late_bias_error (hd : 3 ≤ d) {x : ℝ} (h : ParameterRange d x) {v : Vertex d}
    (hv : Endpoint v) :
    |(model d hd).bias (energy (scale x)) (late x) v - lateBiasLimit v| ≤ 2 * scale x := by
  rw [(model d hd).bias_sum_neighbors, ← lateIdeal_mean hd hv]
  change |(∑ w ∈ neighbors (graph d) v,
      centered (late x * (energy (scale x) v - energy (scale x) w))) / d -
    (∑ w ∈ neighbors (graph d) v, lateIdeal v w) / d| ≤ _
  apply average_difference_le hd
  intro w hw
  by_cases hs : v.1 = w.1
  · simpa [lateIdeal, hs] using late_internal_error hd h hv hw hs
  · simpa [lateIdeal, hs] using late_cross_error h hs

end DoubleClique
end GlauberAnnealing
