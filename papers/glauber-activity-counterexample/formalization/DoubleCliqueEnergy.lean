import DoubleCliqueGraph
import GlauberLimits

open Filter Topology
open scoped BigOperators

namespace GlauberAnnealing
namespace DoubleClique

variable {d : ℕ}

noncomputable def base (b : Bool) : ℝ := if b then 1 else 0

noncomputable def sign (b : Bool) : ℝ := if b then 1 else -1

noncomputable def energy (ε : ℝ) (v : Vertex d) : ℝ :=
  base v.1 + ε * (v.2.val : ℝ)

def Endpoint (v : Vertex d) : Prop :=
  v.2 = first d v.1 ∨ v.2 = second d v.1

noncomputable def crossNeighbor (v : Vertex d) : Vertex d :=
  (!v.1, if v.2 = first d v.1 then first d (!v.1) else second d (!v.1))

@[simp] theorem crossNeighbor_other_side (v : Vertex d) :
    (crossNeighbor v).1 = !v.1 := rfl

theorem crossNeighbor_mem (v : Vertex d) (hv : Endpoint v) :
    crossNeighbor v ∈ neighbors (graph d) v := by
  rw [mem_neighbors]
  have hside : v.1 ≠ (crossNeighbor v).1 := Ne.symm (not_side _)
  change adjacent v (crossNeighbor v)
  rw [adjacent, if_neg hside]
  rcases hv with h₁ | h₂
  · simp [crossNeighbor, matching, h₁]
  · by_cases h₁ : v.2 = first d v.1
    · simp [crossNeighbor, matching, h₁]
    · right
      refine ⟨h₂, ?_⟩
      change (if v.2 = first d v.1 then first d (!v.1) else second d (!v.1)) = _
      rw [if_neg h₁, crossNeighbor_other_side]

theorem crossNeighbor_unique (hd : 3 ≤ d) {v w : Vertex d}
    (hw : w ∈ neighbors (graph d) v) (hs : v.1 ≠ w.1) :
    w = crossNeighbor v := by
  have hr : adjacent v w := mem_neighbors.mp hw
  rw [adjacent, if_neg hs] at hr
  have hb : w.1 = !v.1 := other_side_of_ne (Ne.symm hs)
  apply Prod.ext hb
  rcases hr with ⟨h₁, h⟩ | ⟨h₂, h⟩
  · simpa [crossNeighbor, h₁, hb] using h
  · have h₁ : v.2 ≠ first d v.1 := fun hh => endpoints_ne hd _ (hh.symm.trans h₂)
    simpa [crossNeighbor, h₁, hb] using h

theorem nonendpoint_neighbor_on_side {v w : Vertex d} (hv : ¬ Endpoint v)
    (hw : w ∈ neighbors (graph d) v) : v.1 = w.1 := by
  by_contra hs
  have hr : adjacent v w := mem_neighbors.mp hw
  rw [adjacent, if_neg hs] at hr
  exact hv (hr.elim (fun h => Or.inl h.1) (fun h => Or.inr h.1))

theorem same_side_diff (ε : ℝ) {v w : Vertex d} (h : v.1 = w.1) :
    energy ε v - energy ε w = ε * ((v.2.val : ℝ) - w.2.val) := by
  simp only [energy, h]
  ring

theorem energy_nonneg (ε : ℝ) (hε : 0 ≤ ε) (v : Vertex d) :
    0 ≤ energy ε v := by
  cases h : v.1 <;> simp [energy, base, h] <;> positivity

theorem energy_range (ε : ℝ) (hε : 0 ≤ ε) (v : Vertex d) :
    energy ε v ≤ 1 + (d : ℝ) * ε := by
  have hv : (v.2.val : ℝ) ≤ d := by exact_mod_cast Nat.le_of_lt_succ v.2.isLt
  have hb : base v.1 ≤ 1 := by cases h : v.1 <;> simp [base, h]
  unfold energy
  linarith [mul_le_mul_of_nonneg_left hv hε]

theorem range_when_low (ε : ℝ) (hε : 0 ≤ ε) {v : Vertex d} (hv : v.1 = false) :
    energy ε v ≤ d * ε := by
  have hb : (v.2.val : ℝ) ≤ d := by exact_mod_cast Nat.le_of_lt_succ v.2.isLt
  simpa [energy, base, hv, mul_comm] using mul_le_mul_of_nonneg_left hb hε

theorem range_when_high (ε : ℝ) (hε : 0 ≤ ε) {v : Vertex d} (hv : v.1 = true) :
    1 ≤ energy ε v := by
  simp [energy, base, hv, mul_nonneg hε]

private theorem side_cases (b : Bool) : b = false ∨ b = true := by
  cases b <;> simp

theorem distinct_energy {ε : ℝ} (hε : 0 < ε) (hmax : (d : ℝ) * ε < 1) :
    Function.Injective (energy (d := d) ε) := by
  intro v w he
  by_cases hs : v.1 = w.1
  · apply Prod.ext hs
    apply Fin.ext
    have hm : ε * ((v.2.val : ℝ) - w.2.val) = 0 :=
      (same_side_diff ε hs).symm.trans (sub_eq_zero.mpr he)
    have hEq := sub_eq_zero.mp ((mul_eq_zero.mp hm).resolve_left hε.ne')
    exact_mod_cast hEq
  rcases side_cases v.1 with lv | hv
  · have hw : w.1 = true := other_side_of_ne (Ne.symm hs) |>.trans (by simp [lv])
    linarith [range_when_low ε hε.le lv, range_when_high ε hε.le hw]
  · have lw : w.1 = false := other_side_of_ne (Ne.symm hs) |>.trans (by simp [hv])
    linarith [range_when_low ε hε.le lw, range_when_high ε hε.le hv]

theorem endpoint_internal_neighbor_order (hd : 3 ≤ d) {v w : Vertex d}
    (he : Endpoint v) (hw : w ∈ neighbors (graph d) v) (hs : v.1 = w.1) :
    if v.1 then v.2.val < w.2.val else w.2.val < v.2.val := by
  obtain ⟨b, i⟩ := v
  obtain ⟨c, j⟩ := w
  change b = c at hs
  subst c
  have ha : i ≠ j ∧ ¬removed b i j := by
    have h : adjacent (b, i) (b, j) := mem_neighbors.mp hw
    simpa only [adjacent, if_pos rfl] using h
  rcases ha with ⟨hne, hr⟩
  have hvw : i.val ≠ j.val := fun h => hne (Fin.ext h)
  have hwmax : j.val ≤ d := Nat.le_of_lt_succ j.isLt
  have hmin : min 1 d = 1 := Nat.min_eq_left (by omega)
  change i = first d b ∨ i = second d b at he
  change if b then i.val < j.val else j.val < i.val
  rcases he with h₁ | h₂
  · have hneq : j.val ≠ (second d b).val := fun hh => hr (Or.inl ⟨h₁, Fin.ext hh⟩)
    have hvval : i.val = (first d b).val := congrArg Fin.val h₁
    cases b
    · change i.val = d - 1 at hvval
      change j.val ≠ d at hneq
      change j.val < i.val
      omega
    · change i.val = 0 at hvval
      change j.val ≠ min 1 d at hneq
      change i.val < j.val
      omega
  · have hneq : j.val ≠ (first d b).val := fun hh => hr (Or.inr ⟨h₂, Fin.ext hh⟩)
    have hvval : i.val = (second d b).val := congrArg Fin.val h₂
    cases b
    · change i.val = d at hvval
      change j.val ≠ d - 1 at hneq
      change j.val < i.val
      omega
    · change i.val = min 1 d at hvval
      change j.val ≠ 0 at hneq
      change i.val < j.val
      omega

open BridgeCut (scale early middle late)

theorem energy_limit (v : Vertex d) :
    Tendsto (fun x => energy (scale x) v) atTop (𝓝 (base v.1)) := by
  simpa [energy] using (tendsto_const_nhds (x := base v.1)).add
    (BridgeCut.scale_tendsto.mul_const (v.2.val : ℝ))

theorem middle_internal_limit {v w : Vertex d} (hs : v.1 = w.1) :
    Tendsto (fun x => centered (middle x * (energy (scale x) v - energy (scale x) w)))
      atTop (𝓝 0) := by
  have h : Tendsto (fun x => middle x * scale x * ((v.2.val : ℝ) - w.2.val))
      atTop (𝓝 0) := by simpa only [zero_mul] using
        BridgeCut.middle_small.mul_const ((v.2.val : ℝ) - w.2.val)
  have ht := (continuous_centered.continuousAt.tendsto.comp h)
  rw [centered_zero] at ht
  apply ht.congr
  intro x
  simp only [Function.comp_apply, same_side_diff (scale x) hs]
  congr 1
  ring

theorem cross_edge_limit (β : ℝ → ℝ) (hβ : Tendsto β atTop atTop)
    {v w : Vertex d} (h : v.1 ≠ w.1) :
    Tendsto (fun x => centered (β x * (energy (scale x) v - energy (scale x) w)))
      atTop (𝓝 (sign v.1)) := by
  have hdiff := (energy_limit v).sub (energy_limit w)
  rcases side_cases v.1 with hl | hh
  · have hw : w.1 = true := other_side_of_ne (Ne.symm h) |>.trans (by simp [hl])
    have hn : Tendsto (fun x => energy (scale x) v - energy (scale x) w) atTop (𝓝 (-1)) := by
      simpa [base, hl, hw] using hdiff
    simpa [sign, hl, Function.comp_def] using centered_atBot.comp
      (hβ.atTop_mul_neg (by norm_num : (-1 : ℝ) < 0) hn)
  · have hw : w.1 = false := other_side_of_ne (Ne.symm h) |>.trans (by simp [hh])
    have hp : Tendsto (fun x => energy (scale x) v - energy (scale x) w) atTop (𝓝 1) := by
      simpa [base, hh, hw] using hdiff
    simpa [sign, hh, Function.comp_def] using centered_atTop.comp
      (hβ.atTop_mul_pos zero_lt_one hp)

theorem late_internal_limit (hd : 3 ≤ d) {v w : Vertex d}
    (he : Endpoint v) (hw : w ∈ neighbors (graph d) v) (hs : v.1 = w.1) :
    Tendsto (fun x => centered (late x * (energy (scale x) v - energy (scale x) w)))
      atTop (𝓝 (-sign v.1)) := by
  have hvw := endpoint_internal_neighbor_order hd he hw hs
  let c : ℝ := (v.2.val : ℝ) - w.2.val
  have hfun (x : ℝ) : late x * (energy (scale x) v - energy (scale x) w) =
      late x * scale x * c := by
    rw [same_side_diff (scale x) hs, mul_assoc]
  simp_rw [hfun]
  rcases side_cases v.1 with h | h
  · simp [h] at hvw
    have hc : 0 < c := sub_pos.mpr (by exact_mod_cast hvw)
    simpa [sign, h, Function.comp_def] using centered_atTop.comp
      (BridgeCut.late_small.atTop_mul_pos hc tendsto_const_nhds)
  · simp [h] at hvw
    have hc : c < 0 := sub_neg.mpr (by exact_mod_cast hvw)
    simpa [sign, h, Function.comp_def] using centered_atBot.comp
      (BridgeCut.late_small.atTop_mul_neg hc tendsto_const_nhds)

noncomputable def middleBiasLimit (v : Vertex d) : ℝ := by
  classical exact if Endpoint v then sign v.1 / d else 0

noncomputable def lateBiasLimit (v : Vertex d) : ℝ :=
  -sign v.1 * ((d : ℝ) - 2) / d

open Classical in
theorem bias_from_single_cross (hd : 3 ≤ d) {v : Vertex d} (he : Endpoint v)
    (β : ℝ → ℝ) (hi : ℝ)
    (hc : Tendsto (fun x => centered (β x *
      (energy (scale x) v - energy (scale x) (crossNeighbor v)))) atTop (𝓝 (sign v.1)))
    (hinternal : ∀ w ∈ neighbors (graph d) v, v.1 = w.1 →
      Tendsto (fun x => centered (β x * (energy (scale x) v - energy (scale x) w))) atTop (𝓝 hi)) :
    Tendsto (fun x => (model d hd).bias (energy (scale x)) (β x) v) atTop
      (𝓝 (((d : ℝ) * hi + (sign v.1 - hi)) / d)) := by
  have hsum : Tendsto (fun x => ∑ w ∈ neighbors (graph d) v,
      centered (β x * (energy (scale x) v - energy (scale x) w))) atTop
      (𝓝 (∑ w ∈ neighbors (graph d) v, if w = crossNeighbor v then sign v.1 else hi)) := by
    refine tendsto_finset_sum _ fun w hw => ?_
    by_cases h : w = crossNeighbor v
    · simpa [h] using hc
    · have hs : v.1 = w.1 := by
        by_contra hnot
        exact h (crossNeighbor_unique hd hw hnot)
      simpa [h] using hinternal w hw hs
  have hexception : (∑ w ∈ neighbors (graph d) v, if w = crossNeighbor v then sign v.1 else hi) =
      ((neighbors (graph d) v).card : ℝ) * hi + (sign v.1 - hi) := by
    calc
      _ = ∑ w ∈ neighbors (graph d) v,
          @ite ℝ (w = crossNeighbor v) (Classical.propDecidable _) (sign v.1) hi := by
        apply Finset.sum_congr rfl
        intro w _
        by_cases hw : w = crossNeighbor v <;> simp [hw]
      _ = _ := BridgeCut.sum_with_exception _ (crossNeighbor_mem v he) _ _
  rw [hexception, graph_regular hd] at hsum
  simpa [RegularGraph.bias_sum_neighbors, model] using hsum.div_const (d : ℝ)

theorem middle_bias_limit (hd : 3 ≤ d) (v : Vertex d) :
    Tendsto (fun x => (model d hd).bias (energy (scale x)) (middle x) v) atTop
      (𝓝 (middleBiasLimit v)) := by
  classical
  by_cases h : Endpoint v
  · have hc := cross_edge_limit middle tendsto_id
        (show v.1 ≠ (crossNeighbor v).1 from Ne.symm (not_side _))
    simpa [middleBiasLimit, h] using bias_from_single_cross hd h middle 0 hc
      (fun w hw hs => middle_internal_limit (v := v) (w := w) hs)
  · have hsum : Tendsto (fun x => ∑ w ∈ neighbors (graph d) v,
        centered (middle x * (energy (scale x) v - energy (scale x) w))) atTop (𝓝 0) := by
      simpa using tendsto_finset_sum (neighbors (graph d) v) fun w hw =>
        middle_internal_limit (nonendpoint_neighbor_on_side h hw)
    simpa [RegularGraph.bias_sum_neighbors, model, middleBiasLimit, h] using hsum.div_const (d : ℝ)

theorem late_bias_limit (hd : 3 ≤ d) {v : Vertex d} (h : Endpoint v) :
    Tendsto (fun x => (model d hd).bias (energy (scale x)) (late x) v) atTop
      (𝓝 (lateBiasLimit v)) := by
  have hc := cross_edge_limit late (tendsto_pow_atTop (by decide))
    (show v.1 ≠ (crossNeighbor v).1 from Ne.symm (not_side _))
  have hl := bias_from_single_cross hd h late (-sign v.1) hc
    (fun w hw hs => late_internal_limit hd h hw hs)
  convert hl using 2
  unfold lateBiasLimit
  ring

end DoubleClique
end GlauberAnnealing
