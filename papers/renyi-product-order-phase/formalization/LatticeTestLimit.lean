import LatticePhaseLaw
import UniformIntegerSum
import CentralWindows
import ExponentialEnvelopeMeasure

/-! The location-uniform lattice law integrated against exponentially decaying test families. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} {Y : κ → ℝ}

theorem MaximalLattice.phase_point_abs_bounds (L : MaximalLattice Y) (n : ℕ) (j : ℤ) :
    L.span * (|(j : ℝ)| - 1) ≤ |L.phasePoint n j| ∧
      |L.phasePoint n j| ≤ L.span * (|(j : ℝ)| + 1) := by
  let u : ℝ := j
  let φ := L.phase n
  have hφ : |φ| ≤ 1 := by
    rw [abs_of_nonneg (L.phase_bounds n).1]
    exact (L.phase_bounds n).2.le
  have hL : |u| ≤ |u + φ| + 1 := by
    calc
      |u| = |(u + φ) + -φ| := by ring_nf
      _ ≤ |u + φ| + |-φ| := abs_add_le _ _
      _ ≤ _ := by rw [abs_neg]; exact add_le_add_left hφ _
  have hR : |u + φ| ≤ |u| + 1 :=
    (abs_add_le _ _).trans (add_le_add_left hφ _)
  unfold MaximalLattice.phasePoint
  rw [abs_mul, abs_of_pos L.span_pos]
  exact ⟨mul_le_mul_of_nonneg_left (by linarith only [hL]) L.span_pos.le,
    mul_le_mul_of_nonneg_left hR L.span_pos.le⟩

theorem MaximalLattice.exponential_phase_bound (L : MaximalLattice Y) {c : ℝ}
    (hc : 0 < c) (n : ℕ) (j : ℤ) :
    exponentialEnvelope c (L.phasePoint n j) ≤
      Real.exp (c * L.span) * exponentialGridWeight (c * L.span) j := by
  unfold exponentialEnvelope exponentialGridWeight
  rw [← Real.exp_add, Real.exp_le_exp]
  nlinarith only [mul_le_mul_of_nonneg_left (L.phase_point_abs_bounds n j).1 hc.le]

variable [Fintype κ]

theorem MaximalLattice.phase_point_mass_limit (L : MaximalLattice Y)
    (p : FiniteMass κ) (hp : ∀ i, 0 < p i) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) (j : ℤ) {ε : ℝ} (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N,
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent p Y (n + 1) {L.phasePoint (n + 1) j} -
        L.span * gaussianHeight (p.expect (fun i => Y i ^ 2))| < ε := by
  let v := p.expect (fun i => Y i ^ 2)
  let E := L.span * (|(j : ℝ)| + 1)
  obtain ⟨N₁, h₁⟩ := finite_lattice_local_limit L p hp hm hv
    (div_pos hε (by norm_num : (0 : ℝ) < 2))
  have hε' : 0 < ε / (2 * L.span) := div_pos hε (by exact mul_pos (by norm_num) L.span_pos)
  obtain ⟨N₂, h₂⟩ := gaussian_profile_log_window v 0 E hε'
  refine ⟨max N₁ N₂, ?_⟩
  intro n hn
  let x := L.phasePoint (n + 1) j
  have hx : ∃ z : ℤ, x = ((n + 1 : ℕ) : ℝ) * L.offset + L.span * (z : ℝ) :=
    ⟨_, L.phase_point_eq (n + 1) j⟩
  have hA := h₁ n ((le_max_left _ _).trans hn) x hx
  have hB := h₂ n ((le_max_right _ _).trans hn) x (by
    simpa only [zero_mul, zero_add] using (L.phase_point_abs_bounds (n + 1) j).2)
  have hMul : L.span * (ε / (2 * L.span)) = ε / 2 := by
    rw [← div_div, mul_div_cancel₀ _ L.span_pos.ne']
  have hErr : |L.span * gaussianProfile v (n + 1) x - L.span * gaussianHeight v| < ε / 2 := by
    rw [← mul_sub, abs_mul, abs_of_pos L.span_pos, ← hMul]
    exact mul_lt_mul_of_pos_left hB L.span_pos
  exact (abs_sub_le _ _ _).trans_lt (by linarith only [hA, hErr])

theorem MaximalLattice.phase_point_mass_uniform_bound (L : MaximalLattice Y)
    (p : FiniteMass κ) (hp : ∀ i, 0 < p i) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ j : ℤ,
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent p Y (n + 1) {L.phasePoint (n + 1) j} -
        L.span * gaussianHeight (p.expect (fun i => Y i ^ 2))| ≤
          L.span * gaussianHeight (p.expect (fun i => Y i ^ 2)) + 1 := by
  obtain ⟨N, hN⟩ := finite_lattice_local_limit L p hp hm hv zero_lt_one
  refine ⟨N, ?_⟩
  intro n hn j
  let v := p.expect (fun i => Y i ^ 2)
  let x := L.phasePoint (n + 1) j
  let r := Real.sqrt ((n + 1 : ℕ) : ℝ)
  let M := r * finiteSumEvent p Y (n + 1) {x}
  have hM : 0 ≤ M := mul_nonneg (Real.sqrt_nonneg _) (finite_sum_event_nonneg p Y (n + 1) {x})
  have h := abs_lt.mp (hN n hn x ⟨_, L.phase_point_eq (n + 1) j⟩)
  have hP := mul_le_mul_of_nonneg_left (gaussian_profile_le_constant v hv (n + 1) x) L.span_pos.le
  have hG : 0 ≤ gaussianHeight v := (gaussian_height_pos hv).le
  change L.span * gaussianProfile v (n + 1) x ≤ L.span * gaussianHeight v at hP
  change |M - L.span * gaussianHeight v| ≤ L.span * gaussianHeight v + 1
  rw [abs_le]
  constructor
  · linarith only [hM]
  · have hU : M - L.span * gaussianProfile v (n + 1) x < 1 := h.2
    exact (sub_le_sub_left hP M).trans
      (hU.le.trans (le_add_of_nonneg_left (mul_nonneg L.span_pos.le hG)))

theorem MaximalLattice.uniform_lattice_test_limit (L : MaximalLattice Y)
    (p : FiniteMass κ) (hp : ∀ i, 0 < p i) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) {α : Type*} (F : α → ℝ → ℝ)
    {c A ε : ℝ} (hc : 0 < c) (hA : 0 ≤ A) (hε : 0 < ε)
    (hEnv : ∀ a x, |F a x| ≤ A * exponentialEnvelope c x) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ a : α,
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * (FiniteMass.tensor (fun _ : Fin (n + 1) => p)).expect
        (fun x => F a (iidSum Y x)) -
        (L.span * gaussianHeight (p.expect (fun i => Y i ^ 2))) *
          (∑' j : ℤ, F a (L.phasePoint (n + 1) j))| < ε := by
  let H := L.span * gaussianHeight (p.expect (fun i => Y i ^ 2))
  have hH : 0 < H := mul_pos L.span_pos (gaussian_height_pos hv)
  let X (n : ℕ) (j : ℤ) := L.phasePoint (n + 1) j
  let P (n : ℕ) (j : ℤ) := finiteSumEvent p Y (n + 1) {X n j}
  let R (n : ℕ) := Real.sqrt ((n + 1 : ℕ) : ℝ)
  let W (j : ℤ) := (A * Real.exp (c * L.span)) * exponentialGridWeight (c * L.span) j
  let f (n : ℕ) (a : α) (j : ℤ) := F a (X n j) * (R n * P n j)
  let g (n : ℕ) (a : α) (j : ℤ) := F a (X n j) * H
  have hW (j : ℤ) : 0 ≤ W j := mul_nonneg (mul_nonneg hA (Real.exp_nonneg _)) (Real.exp_nonneg _)
  have hS : Summable W := (summable_exponential_grid (mul_pos hc L.span_pos)).mul_left _
  have hFE (n : ℕ) (a : α) (j : ℤ) : |F a (X n j)| ≤ W j := by
    apply (hEnv a _).trans
    unfold W
    rw [mul_assoc]
    exact mul_le_mul_of_nonneg_left (L.exponential_phase_bound hc (n + 1) j) hA
  have hMass (n : ℕ) (j : ℤ) : 0 ≤ P n j ∧ P n j ≤ 1 :=
    ⟨finite_sum_event_nonneg _ _ _ _, finite_sum_event_le_one _ _ _ _⟩
  have hBase (n : ℕ) (a : α) :
      Summable (fun j : ℤ => F a (X n j) * P n j) := by
    apply Summable.of_norm_bounded W hS
    intro j
    rw [Real.norm_eq_abs, abs_mul, abs_of_nonneg (hMass n j).1]
    exact (mul_le_of_le_one_right (abs_nonneg _) (hMass n j).2).trans (hFE n a j)
  have hF (n : ℕ) (a : α) : Summable (f n a) := by
    have hEq : f n a = fun j => R n * (F a (X n j) * P n j) := by
      funext j
      unfold f
      ring
    rw [hEq]
    exact (hBase n a).mul_left (R n)
  have hFOnly (n : ℕ) (a : α) : Summable (fun j : ℤ => F a (X n j)) :=
    Summable.of_norm_bounded W hS (fun j => by simpa only [Real.norm_eq_abs] using hFE n a j)
  have hG (n : ℕ) (a : α) : Summable (g n a) := (hFOnly n a).mul_right H
  have hDiff (n : ℕ) (a : α) (j : ℤ) :
      |f n a j - g n a j| = |F a (X n j)| * |R n * P n j - H| := by
    unfold f g
    rw [← mul_sub, abs_mul]
  obtain ⟨N₀, hGlobal⟩ := L.phase_point_mass_uniform_bound p hp hm hv
  have hDom : ∃ N : ℕ, ∀ n ≥ N, ∀ a j, |f n a j - g n a j| ≤ W j * (H + 1) := by
    refine ⟨N₀, ?_⟩
    intro n hn a j
    rw [hDiff]
    exact mul_le_mul (hFE n a j) (hGlobal n hn j) (abs_nonneg _) (hW j)
  have hNear (j : ℤ) (η : ℝ) (hη : 0 < η) :
      ∃ N : ℕ, ∀ n ≥ N, ∀ a, |f n a j - g n a j| < η := by
    have hPos : 0 < A + 1 := by positivity
    obtain ⟨N, hN⟩ := L.phase_point_mass_limit p hp hm hv j (div_pos hη hPos)
    refine ⟨N, ?_⟩
    intro n hn a
    have hExp : exponentialEnvelope c (X n j) ≤ 1 := by
      unfold exponentialEnvelope
      simpa only [Real.exp_zero] using Real.exp_le_exp.mpr
        (mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr hc.le) (abs_nonneg (X n j)))
    have hLe : |F a (X n j)| ≤ A + 1 :=
      ((hEnv a _).trans (mul_le_of_le_one_right hA hExp)).trans (le_add_of_nonneg_right zero_le_one)
    rw [hDiff]
    calc
      _ ≤ (A + 1) * |R n * P n j - H| := mul_le_mul_of_nonneg_right hLe (abs_nonneg _)
      _ < (A + 1) * (η / (A + 1)) := mul_lt_mul_of_pos_left (hN n hn) hPos
      _ = _ := mul_div_cancel₀ _ hPos.ne'
  obtain ⟨N, hN⟩ := uniform_dominated_integer_sums f g (fun j => W j * (H + 1))
    (fun j => mul_nonneg (hW j) (by positivity)) (hS.mul_right (H + 1)) hF hG hDom hNear hε
  refine ⟨N, ?_⟩
  intro n hn a
  have hFsum : (∑' j, f n a j) =
      R n * (FiniteMass.tensor (fun _ : Fin (n + 1) => p)).expect (fun x => F a (iidSum Y x)) := by
    rw [L.phase_sum_expectation]
    have hEq : f n a = fun j => R n * (F a (X n j) * P n j) := by
      funext j
      unfold f
      ring
    rw [hEq, (hBase n a).tsum_mul_left]
  have hGsum : (∑' j, g n a j) = H * ∑' j, F a (X n j) := by
    unfold g
    rw [(hFOnly n a).tsum_mul_right, mul_comm]
  have h := hN n hn a
  rw [hFsum, hGsum] at h
  exact h

end RenyiProductOrderPhase
