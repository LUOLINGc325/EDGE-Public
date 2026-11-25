import LatticeTestLimit
import KernelEnvelope

/-! Fixed and growing tilted kernel moments with a moving maximal-lattice phase. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} {Y : κ → ℝ}

theorem MaximalLattice.phase_test_series (L : MaximalLattice Y) (f : ℝ → ℝ) (n : ℕ)
    {c A : ℝ} (hc : 0 < c) (hA : 0 ≤ A) (hF : ∀ x, |f x| ≤ A * exponentialEnvelope c x) :
    Summable (fun j : ℤ => f (L.phasePoint n j)) ∧
      |∑' j : ℤ, f (L.phasePoint n j)| ≤
        (A * Real.exp (c * L.span)) * (∑' j : ℤ, exponentialGridWeight (c * L.span) j) := by
  let w (j : ℤ) := (A * Real.exp (c * L.span)) * exponentialGridWeight (c * L.span) j
  have hw : Summable w := (summable_exponential_grid (mul_pos hc L.span_pos)).mul_left _
  have hBound (j : ℤ) : |f (L.phasePoint n j)| ≤ w j := by
    apply (hF _).trans
    unfold w
    rw [mul_assoc]
    exact mul_le_mul_of_nonneg_left (L.exponential_phase_bound hc n j) hA
  have hAbs : Summable (fun j => |f (L.phasePoint n j)|) :=
    Summable.of_nonneg_of_le (fun _ => abs_nonneg _) hBound hw
  constructor
  · exact Summable.of_norm_bounded w hw (fun j => by simpa only [Real.norm_eq_abs] using hBound j)
  · have hn : Summable (fun j => ‖f (L.phasePoint n j)‖) := by
      simpa only [Real.norm_eq_abs] using hAbs
    have h1 : |∑' j, f (L.phasePoint n j)| ≤ ∑' j, |f (L.phasePoint n j)| := by
      simpa only [Real.norm_eq_abs] using norm_tsum_le_tsum_norm hn
    have h2 := hAbs.tsum_le_tsum hBound hw
    unfold w at h2
    rw [(summable_exponential_grid (mul_pos hc L.span_pos)).tsum_mul_left] at h2
    exact h1.trans h2

theorem MaximalLattice.growing_phase_series_replacement (L : MaximalLattice Y)
    (B : ℕ → ℝ) (hb : ∀ n, 1 ≤ B n) (hB : Tendsto B atTop atTop)
    {θ u ε : ℝ} (hθ : 0 < θ) (hθ' : θ < 1) (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ a ∈ Icc (0 : ℝ) u,
      |(∑' j : ℤ, growingTiltedKernel (B n) a θ (L.phasePoint (n + 1) j)) -
        (∑' j : ℤ, growingLimitKernel a θ (L.phasePoint (n + 1) j))| < ε := by
  let c := min θ (1 - θ)
  have hc : 0 < c := lt_min hθ (sub_pos.mpr hθ')
  let A := max 1 u
  have hA : 0 ≤ A := zero_le_one.trans (le_max_left _ _)
  let w (j : ℤ) := (A * Real.exp (c * L.span)) * exponentialGridWeight (c * L.span) j
  have hw : Summable w := (summable_exponential_grid (mul_pos hc L.span_pos)).mul_left _
  have hw₀ (j : ℤ) : 0 ≤ w j := mul_nonneg (mul_nonneg hA (Real.exp_nonneg _)) (Real.exp_nonneg _)
  let f (n : ℕ) (a : Icc (0 : ℝ) u) (j : ℤ) :=
    growingTiltedKernel (B n) (a : ℝ) θ (L.phasePoint (n + 1) j)
  let g (n : ℕ) (a : Icc (0 : ℝ) u) (j : ℤ) :=
    growingLimitKernel (a : ℝ) θ (L.phasePoint (n + 1) j)
  have hF (n : ℕ) (a : Icc (0 : ℝ) u) (s : ℝ) :
      |growingTiltedKernel (B n) (a : ℝ) θ s| ≤ A * exponentialEnvelope c s := by
    have h := growing_tilted_kernel_envelope a.property.1 a.property.2 (hb n) (θ := θ) s
    simpa only [c, A, exponentialEnvelope, neg_mul, abs_of_nonneg h.1] using h.2
  have hG (a : Icc (0 : ℝ) u) (s : ℝ) :
      |growingLimitKernel (a : ℝ) θ s| ≤ A * exponentialEnvelope c s := by
    have h := growing_limit_kernel_envelope a.property.1 a.property.2 (θ := θ) s
    simpa only [c, A, exponentialEnvelope, neg_mul, abs_of_nonneg h.1] using h.2
  have hFs (n : ℕ) (a : Icc (0 : ℝ) u) : Summable (f n a) :=
    (L.phase_test_series _ (n + 1) hc hA (hF n a)).1
  have hGs (n : ℕ) (a : Icc (0 : ℝ) u) : Summable (g n a) :=
    (L.phase_test_series _ (n + 1) hc hA (hG a)).1
  have hDom : ∃ N : ℕ, ∀ n ≥ N, ∀ a j, |f n a j - g n a j| ≤ w j := by
    refine ⟨0, ?_⟩
    intro n _ a j
    let x := L.phasePoint (n + 1) j
    have hDiff : 0 ≤ g n a j - f n a j := (growing_tilted_kernel_compact_error
      a.property.1 a.property.2 hθ.le (hb n) (le_refl |x|)).1
    have hFn : 0 ≤ f n a j :=
      (growing_tilted_kernel_envelope a.property.1 a.property.2 (hb n) (θ := θ) x).1
    have hGn : 0 ≤ g n a j :=
      (growing_limit_kernel_envelope a.property.1 a.property.2 (θ := θ) x).1
    rw [abs_sub_comm, abs_of_nonneg hDiff]
    apply (sub_le_self _ hFn).trans
    have hh := hG a x
    change |g n a j| ≤ _ at hh
    rw [abs_of_nonneg hGn] at hh
    apply hh.trans
    unfold w
    rw [mul_assoc]
    exact mul_le_mul_of_nonneg_left (L.exponential_phase_bound hc (n + 1) j) hA
  have hNear (j : ℤ) (η : ℝ) (hη : 0 < η) :
      ∃ N : ℕ, ∀ n ≥ N, ∀ a, |f n a j - g n a j| < η := by
    let K := L.span * (|(j : ℝ)| + 1)
    let D := Real.exp (θ * K) * (u * Real.exp K) ^ 2
    obtain ⟨N, hN⟩ := eventually_atTop.1
      (hB.eventually (eventually_ge_atTop ((D + 1) / η)))
    refine ⟨N, ?_⟩
    intro n hn a
    have hLim := growing_tilted_kernel_compact_error a.property.1 a.property.2 hθ.le (hb n)
      (L.phase_point_abs_bounds (n + 1) j).2
    change 0 ≤ g n a j - f n a j ∧ g n a j - f n a j ≤ D / B n at hLim
    rw [abs_sub_comm, abs_of_nonneg hLim.1]
    apply hLim.2.trans_lt
    have h := (div_le_iff₀ hη).1 (hN n hn)
    apply (div_lt_iff₀ (zero_lt_one.trans_le (hb n))).2
    exact (lt_add_of_pos_right D zero_lt_one).trans_le (h.trans_eq (mul_comm _ _))
  obtain ⟨N, hN⟩ := uniform_dominated_integer_sums f g w hw₀ hw hFs hGs hDom hNear hε
  exact ⟨N, fun n hn a ha => hN n hn ⟨a, ha⟩⟩

variable [Fintype κ]

theorem MaximalLattice.growing_tilted_phase_moment (L : MaximalLattice Y)
    (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (hm : p.expect Y = 0) (hv : 0 < p.expect (fun i => Y i ^ 2))
    (B : ℕ → ℝ) (hb : ∀ n, 1 ≤ B n) (hB : Tendsto B atTop atTop)
    {θ u ε : ℝ} (hθ : 0 < θ) (hθ' : θ < 1) (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ a ∈ Icc (0 : ℝ) u,
      |Real.sqrt ((n + 1 : ℕ) : ℝ) * (FiniteMass.tensor (fun _ : Fin (n + 1) => p)).expect
        (fun x => growingTiltedKernel (B n) a θ (iidSum Y x)) -
        (L.span * gaussianHeight (p.expect (fun i => Y i ^ 2))) *
        (∑' j : ℤ, growingLimitKernel a θ (L.phasePoint (n + 1) j))| < ε := by
  let H := L.span * gaussianHeight (p.expect (fun i => Y i ^ 2))
  have hH : 0 < H := mul_pos L.span_pos (gaussian_height_pos hv)
  let F (z : Ici (1 : ℝ) × Icc (0 : ℝ) u) (x : ℝ) :=
    growingTiltedKernel (z.1 : ℝ) (z.2 : ℝ) θ x
  let c := min θ (1 - θ)
  let A := max 1 u
  have hEnv (z : Ici (1 : ℝ) × Icc (0 : ℝ) u) (x : ℝ) :
      |F z x| ≤ A * exponentialEnvelope c x := by
    have h := growing_tilted_kernel_envelope z.2.property.1 z.2.property.2 z.1.property (θ := θ) x
    simpa only [F, A, c, exponentialEnvelope, neg_mul, abs_of_nonneg h.1] using h.2
  have hHalf : 0 < ε / 2 := div_pos hε (by norm_num)
  obtain ⟨N₁, h₁⟩ := L.uniform_lattice_test_limit p hp hm hv F (c := c) (A := A)
    (lt_min hθ (sub_pos.mpr hθ')) (zero_le_one.trans (le_max_left _ _)) hHalf hEnv
  obtain ⟨N₂, h₂⟩ := L.growing_phase_series_replacement B hb hB hθ hθ' (u := u)
    (div_pos hHalf hH)
  refine ⟨max N₁ N₂, ?_⟩
  intro n hn a ha
  let z : Ici (1 : ℝ) × Icc (0 : ℝ) u := (⟨B n, hb n⟩, ⟨a, ha⟩)
  have h := h₁ n ((le_max_left _ _).trans hn) z
  have he := h₂ n ((le_max_right _ _).trans hn) a ha
  have hMul (s t : ℝ) : |s - t| < (ε / 2) / H → |H * s - H * t| < ε / 2 := by
    intro h
    rw [← mul_sub, abs_mul, abs_of_pos hH]
    have he := mul_lt_mul_of_pos_left h hH
    rwa [mul_div_cancel₀ _ hH.ne'] at he
  have hErr := hMul _ _ he
  exact (abs_sub_le _ _ _).trans_lt (by linarith only [h, hErr])

end RenyiProductOrderPhase
