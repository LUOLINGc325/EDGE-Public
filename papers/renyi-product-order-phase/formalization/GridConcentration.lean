import FiniteNonarithmeticLLT
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Topology.Algebra.InfiniteSum.NatInt
import Mathlib.Topology.Algebra.InfiniteSum.Order

/-! Countable grid estimates for exponentially decaying local-limit test functions. -/

open scoped BigOperators Topology
open Set Filter

namespace RenyiProductOrderPhase

noncomputable def gridIndex (h x : ℝ) : ℤ := ⌊x / h⌋

def gridCell (h : ℝ) (j : ℤ) : Set ℝ := Ico (h * (j : ℝ)) (h * (j + 1 : ℝ))

theorem grid_index_eq_iff {h : ℝ} (hh : 0 < h) (x : ℝ) (j : ℤ) :
    gridIndex h x = j ↔ x ∈ gridCell h j := by
  unfold gridIndex gridCell
  rw [Int.floor_eq_iff]
  exact and_congr
    (by rw [le_div_iff₀ hh, mul_comm h (j : ℝ)])
    (by rw [div_lt_iff₀ hh, mul_comm h ((j : ℝ) + 1)])

theorem unit_grid_distance (x : ℝ) : |x - (gridIndex 1 x : ℝ)| < 1 := by
  have h := (grid_index_eq_iff zero_lt_one x (gridIndex 1 x)).1 rfl
  change 1 * (gridIndex 1 x : ℝ) ≤ x ∧ x < 1 * ((gridIndex 1 x : ℝ) + 1) at h
  simp only [one_mul] at h
  rw [abs_of_nonneg (sub_nonneg.mpr h.1)]
  linarith only [h.2]

theorem unit_grid_abs_le (x : ℝ) :
    |(gridIndex 1 x : ℝ)| ≤ |x| + 1 ∧ |x| ≤ |(gridIndex 1 x : ℝ)| + 1 := by
  let j : ℝ := gridIndex 1 x
  have h : |x - j| ≤ 1 := (unit_grid_distance x).le
  have hr : |j - x| ≤ 1 := by rw [abs_sub_comm]; exact h
  constructor
  · calc
      |j| = |x + (j - x)| := by ring_nf
      _ ≤ |x| + |j - x| := abs_add_le _ _
      _ ≤ _ := add_le_add_left hr _
  · calc
      |x| = |j + (x - j)| := by ring_nf
      _ ≤ |j| + |x - j| := abs_add_le _ _
      _ ≤ _ := add_le_add_left h _

noncomputable def exponentialGridWeight (c : ℝ) (j : ℤ) : ℝ :=
  Real.exp (-c * |(j : ℝ)|)

theorem summable_exponential_grid {c : ℝ} (hc : 0 < c) :
    Summable (exponentialGridWeight c) := by
  have h : Summable (fun n : ℕ => Real.exp ((n : ℝ) * (-c))) :=
    Real.summable_exp_nat_mul_iff.2 (neg_lt_zero.mpr hc)
  apply Summable.of_nat_of_neg_add_one
  · refine h.congr (fun n => ?_)
    unfold exponentialGridWeight
    rw [Int.cast_natCast, abs_of_nonneg (show 0 ≤ (n : ℝ) from Nat.cast_nonneg n),
      mul_comm (n : ℝ) (-c)]
  · have hShift : Summable (fun n : ℕ => Real.exp (((n + 1 : ℕ) : ℝ) * (-c))) :=
      h.comp_injective Nat.succ_injective
    refine hShift.congr (fun n => ?_)
    unfold exponentialGridWeight
    push_cast
    rw [abs_neg, abs_of_nonneg (show 0 ≤ (n : ℝ) + 1 by positivity),
      mul_comm ((n : ℝ) + 1) (-c)]

theorem exponential_from_unit_grid {c : ℝ} (hc : 0 < c) (x : ℝ) :
    Real.exp (-c * |x|) ≤ Real.exp c * exponentialGridWeight c (gridIndex 1 x) := by
  unfold exponentialGridWeight
  rw [← Real.exp_add, Real.exp_le_exp]
  nlinarith only [mul_le_mul_of_nonneg_left (unit_grid_abs_le x).1 hc.le]

variable {κ : Type*} [Fintype κ]

theorem finite_expectation_by_cells (p : FiniteMass κ) (cell : κ → ℤ) (w : ℤ → ℝ) :
    p.expect (fun x => w (cell x)) =
      ∑ j ∈ (Finset.univ.image cell), w j * p.expect (fun x => if cell x = j then 1 else 0) := by
  classical
  let J := Finset.univ.image cell
  have hPoint (x : κ) : w (cell x) = ∑ j ∈ J, w j * (if cell x = j then 1 else 0) := by
    have hx : cell x ∈ J := Finset.mem_image_of_mem cell (Finset.mem_univ x)
    rw [Finset.sum_eq_single (cell x)]
    · simp only [if_pos rfl, if_true, mul_one]
    · intro j _ hne
      simp only [if_neg (Ne.symm hne), mul_zero]
    · exact fun h => (h hx).elim
  unfold FiniteMass.expect
  calc
    (∑ x, p x * w (cell x)) =
        ∑ x, ∑ j ∈ J, p x * (w j * (if cell x = j then 1 else 0)) := by
      refine Finset.sum_congr rfl fun x _ => ?_
      rw [hPoint, Finset.mul_sum]
    _ = ∑ j ∈ J, ∑ x, p x * (w j * (if cell x = j then 1 else 0)) := Finset.sum_comm
    _ = _ := by
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl (fun x _ => by ring)

theorem finite_weighted_grid_bound (p : FiniteMass κ) (cell : κ → ℤ) (w : ℤ → ℝ)
    (hw : ∀ j, 0 ≤ w j) (hs : Summable w) {R C : ℝ} (hR : 0 ≤ R) (hC : 0 ≤ C)
    (hCell : ∀ j, R * p.expect (fun x => if cell x = j then 1 else 0) ≤ C)
    {f : κ → ℝ} (hf : ∀ x, f x ≤ w (cell x)) :
    R * p.expect f ≤ C * ∑' j, w j := by
  classical
  let J := Finset.univ.image cell
  calc
    _ ≤ R * p.expect (fun x => w (cell x)) := mul_le_mul_of_nonneg_left (p.expect_mono hf) hR
    _ = ∑ j ∈ J, w j * (R * p.expect (fun x => if cell x = j then 1 else 0)) := by
      rw [finite_expectation_by_cells, Finset.mul_sum]
      exact Finset.sum_congr rfl (fun j _ => by ring)
    _ ≤ ∑ j ∈ J, w j * C := Finset.sum_le_sum (fun j _ => mul_le_mul_of_nonneg_left (hCell j) (hw j))
    _ = C * ∑ j ∈ J, w j := by rw [Finset.mul_sum]; exact Finset.sum_congr rfl (fun j _ => mul_comm _ _)
    _ ≤ _ := mul_le_mul_of_nonneg_left (hs.sum_le_tsum J (fun j _ => hw j)) hC

theorem finite_sum_grid_cell (p : FiniteMass κ) (Y : κ → ℝ) (n : ℕ) {h : ℝ} (hh : 0 < h)
    (j : ℤ) :
    (FiniteMass.tensor (fun _ : Fin n => p)).expect
      (fun x => if gridIndex h (iidSum Y x) = j then 1 else 0) =
        finiteSumEvent p Y n (gridCell h j) := by
  classical
  unfold finiteSumEvent FiniteMass.expect
  refine Finset.sum_congr rfl fun x _ => ?_
  change _ * (if gridIndex h (iidSum Y x) = j then (1 : ℝ) else 0) =
    _ * (gridCell h j).indicator (fun _ => (1 : ℝ)) (iidSum Y x)
  by_cases hx : iidSum Y x ∈ gridCell h j
  · rw [if_pos ((grid_index_eq_iff hh _ _).2 hx), indicator_of_mem hx]
  · rw [if_neg (fun he => hx ((grid_index_eq_iff hh _ _).1 he)), indicator_of_not_mem hx]

theorem exponential_scaled_expectation_bound (p : FiniteMass κ) (Y : κ → ℝ) {n : ℕ}
    {c C : ℝ} (hc : 0 < c) (hC : 0 ≤ C)
    (hCell : ∀ x : ℝ, Real.sqrt (n : ℝ) * finiteSumEvent p Y n (Ico x (x + 1)) ≤ C) :
    Real.sqrt (n : ℝ) * (FiniteMass.tensor (fun _ : Fin n => p)).expect
        (fun x => Real.exp (-c * |iidSum Y x|)) ≤
      C * (Real.exp c * ∑' j, exponentialGridWeight c j) := by
  classical
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let cell (x : Fin n → κ) := gridIndex 1 (iidSum Y x)
  let w (j : ℤ) := Real.exp c * exponentialGridWeight c j
  have hw : ∀ j, 0 ≤ w j := fun _ => mul_nonneg (Real.exp_nonneg _) (Real.exp_nonneg _)
  have hS : Summable w := (summable_exponential_grid hc).mul_left (Real.exp c)
  have hMass (j : ℤ) :
      Real.sqrt (n : ℝ) * P.expect (fun x => if cell x = j then 1 else 0) ≤ C := by
    unfold P cell
    rw [finite_sum_grid_cell p Y n zero_lt_one]
    simpa only [gridCell, one_mul] using hCell (j : ℝ)
  have h := finite_weighted_grid_bound P cell w hw hS (Real.sqrt_nonneg _) hC hMass
    (fun x => exponential_from_unit_grid hc (iidSum Y x))
  unfold w at h
  simpa only [(summable_exponential_grid hc).tsum_mul_left] using h

theorem summable_masked_tail_small (w : ℤ → ℝ) (h : Summable w) {δ : ℝ} (hδ : 0 < δ) :
    ∃ J : Finset ℤ, (∑' j, if j ∈ J then 0 else w j) < δ := by
  classical
  let W := ∑' j, w j
  have hT : Tendsto (fun J : Finset ℤ => ∑ j ∈ J, w j) atTop (𝓝 W) := h.hasSum
  obtain ⟨J, hJ⟩ := (hT.eventually
    (Ioi_mem_nhds (show W - δ < W by linarith))).exists
  let f (j : ℤ) := if j ∈ J then w j else 0
  let g (j : ℤ) := if j ∈ J then 0 else w j
  have hf : Summable f := summable_of_ne_finset_zero (s := J) (fun j hj => if_neg hj)
  have hg : Summable g := (h.sub hf).congr (fun j => by
    by_cases hj : j ∈ J <;> simp [f, g, hj])
  have hfg : (fun j => f j + g j) = w := by
    funext j
    by_cases hj : j ∈ J <;> simp [f, g, hj]
  have hSum := hf.tsum_add hg
  rw [hfg] at hSum
  have hFinite : (∑' j, f j) = ∑ j ∈ J, w j := by
    rw [tsum_eq_sum (s := J) (fun j hj => if_neg hj)]
    exact Finset.sum_congr rfl (fun j hj => if_pos hj)
  rw [hFinite] at hSum
  have hJ' : W - δ < ∑ j ∈ J, w j := hJ
  refine ⟨J, ?_⟩
  change (∑' j, g j) < δ
  change W = _ at hSum
  linarith only [hSum, hJ']

theorem exponential_scaled_expectation_tails (p : FiniteMass κ) (Y : κ → ℝ)
    {c C ε : ℝ} (hc : 0 < c) (hC : 0 ≤ C) (hε : 0 < ε) :
    ∃ K > 0, ∀ n : ℕ,
      (∀ x : ℝ, Real.sqrt (n : ℝ) * finiteSumEvent p Y n (Ico x (x + 1)) ≤ C) →
      Real.sqrt (n : ℝ) * (FiniteMass.tensor (fun _ : Fin n => p)).expect
        (fun x => if K ≤ |iidSum Y x| then Real.exp (-c * |iidSum Y x|) else 0) < ε := by
  classical
  let δ := ε / (C * Real.exp c + 1)
  have hPos : 0 < C * Real.exp c + 1 := by positivity
  have hδ : 0 < δ := div_pos hε hPos
  obtain ⟨J, hJ⟩ := summable_masked_tail_small _ (summable_exponential_grid hc) hδ
  let K := (∑ j ∈ J, |(j : ℝ)|) + 2
  have hK : 0 < K := add_pos_of_nonneg_of_pos (Finset.sum_nonneg (fun _ _ => abs_nonneg _)) (by norm_num)
  let g (j : ℤ) := if j ∈ J then 0 else exponentialGridWeight c j
  have hg₀ (j : ℤ) : 0 ≤ g j := by by_cases hj : j ∈ J <;> simp [g, hj, exponentialGridWeight, Real.exp_nonneg]
  have hg₁ (j : ℤ) : g j ≤ exponentialGridWeight c j := by
    by_cases hj : j ∈ J <;> simp [g, hj, exponentialGridWeight, Real.exp_nonneg]
  have hg : Summable g := Summable.of_nonneg_of_le hg₀ hg₁ (summable_exponential_grid hc)
  refine ⟨K, hK, ?_⟩
  intro n hCell
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let cell (x : Fin n → κ) := gridIndex 1 (iidSum Y x)
  let w (j : ℤ) := Real.exp c * g j
  have hw (j : ℤ) : 0 ≤ w j := mul_nonneg (Real.exp_nonneg _) (hg₀ j)
  have hMass (j : ℤ) :
      Real.sqrt (n : ℝ) * P.expect (fun x => if cell x = j then 1 else 0) ≤ C := by
    unfold P cell
    rw [finite_sum_grid_cell p Y n zero_lt_one]
    simpa only [gridCell, one_mul] using hCell (j : ℝ)
  have hPoint (x : Fin n → κ) :
      (if K ≤ |iidSum Y x| then Real.exp (-c * |iidSum Y x|) else 0) ≤ w (cell x) := by
    by_cases hx : K ≤ |iidSum Y x|
    · have hj : cell x ∉ J := by
        intro hj
        have h := Finset.single_le_sum (f := fun j : ℤ => |(j : ℝ)|)
          (fun j _ => abs_nonneg (j : ℝ)) hj
        have hx' := (unit_grid_abs_le (iidSum Y x)).2
        change |iidSum Y x| ≤ |(cell x : ℝ)| + 1 at hx'
        unfold K at hx
        linarith only [h, hx, hx']
      simp only [if_pos hx, w, g, if_neg hj]
      exact exponential_from_unit_grid hc (iidSum Y x)
    · rw [if_neg hx]
      exact hw _
  have hBound := finite_weighted_grid_bound P cell w hw (hg.mul_left (Real.exp c))
    (Real.sqrt_nonneg _) hC hMass hPoint
  unfold w at hBound
  rw [hg.tsum_mul_left] at hBound
  have hLimit : C * (Real.exp c * δ) < ε := by
    have hEq : (C * Real.exp c + 1) * δ = ε := mul_div_cancel₀ _ hPos.ne'
    nlinarith only [hEq, hδ]
  have hComp : C * (Real.exp c * ∑' j, g j) ≤ C * (Real.exp c * δ) :=
    mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left hJ.le (Real.exp_nonneg _)) hC
  exact hBound.trans_lt (hComp.trans_lt hLimit)

end RenyiProductOrderPhase
