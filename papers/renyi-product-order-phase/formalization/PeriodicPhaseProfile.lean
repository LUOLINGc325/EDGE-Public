import LatticeKernelLimits
import Mathlib.Analysis.NormedSpace.FunctionSeries

/-! Continuous positive periodic profiles from exponential lattice sums. -/

open scoped Topology
open Set

namespace RenyiProductOrderPhase

noncomputable def periodicKernelProfile (h : ℝ) (J : ℝ → ℝ) (v : ℝ) : ℝ :=
  h * ∑' j : ℤ, J (v + h * (j : ℝ))

theorem periodic_kernel_point_bound {h c A K : ℝ} (hh : 0 < h) (hc : 0 < c) (hA : 0 ≤ A)
    {J : ℝ → ℝ} (hJ : ∀ s, |J s| ≤ A * exponentialEnvelope c s)
    {v : ℝ} (hv : |v| ≤ K) (j : ℤ) :
    |J (v + h * (j : ℝ))| ≤ (A * Real.exp (c * K)) * exponentialGridWeight (c * h) j := by
  have he : |h * (j : ℝ)| = h * |(j : ℝ)| := by rw [abs_mul, abs_of_pos hh]
  have hRv : h * |(j : ℝ)| ≤ |v + h * (j : ℝ)| + K := by
    rw [← he]
    have hTriangle : |h * (j : ℝ)| ≤ |v + h * (j : ℝ)| + |v| := by
      calc
        _ = |(v + h * (j : ℝ)) + -v| := by ring_nf
        _ ≤ |v + h * (j : ℝ)| + |-v| := abs_add_le _ _
        _ = _ := by rw [abs_neg]
    exact hTriangle.trans (add_le_add_left hv _)
  apply (hJ _).trans
  rw [mul_assoc]
  apply mul_le_mul_of_nonneg_left _ hA
  unfold exponentialEnvelope exponentialGridWeight
  rw [← Real.exp_add, Real.exp_le_exp]
  nlinarith only [mul_le_mul_of_nonneg_left hRv hc.le]

theorem periodic_kernel_series {h c A : ℝ} (hh : 0 < h) (hc : 0 < c) (hA : 0 ≤ A)
    {J : ℝ → ℝ} (hJ : ∀ s, |J s| ≤ A * exponentialEnvelope c s) (v : ℝ) :
    Summable (fun j : ℤ => J (v + h * (j : ℝ))) := by
  apply Summable.of_norm_bounded
    (fun j => (A * Real.exp (c * |v|)) * exponentialGridWeight (c * h) j)
    ((summable_exponential_grid (mul_pos hc hh)).mul_left _)
  intro j
  rw [Real.norm_eq_abs]
  exact periodic_kernel_point_bound hh hc hA hJ le_rfl j

theorem periodic_kernel_continuous {h c A : ℝ} (hh : 0 < h) (hc : 0 < c) (hA : 0 ≤ A)
    {J : ℝ → ℝ} (hJ : ∀ s, |J s| ≤ A * exponentialEnvelope c s) (hCont : Continuous J) :
    Continuous (periodicKernelProfile h J) := by
  apply continuous_iff_continuousAt.2
  intro v
  let K := |v| + 1
  let S := Icc (-K) K
  have hS : S ∈ 𝓝 v := Icc_mem_nhds
    (by unfold K; linarith only [neg_le_abs v])
    (by unfold K; linarith only [le_abs_self v])
  have hC : ContinuousOn (fun v : ℝ => ∑' j : ℤ, J (v + h * (j : ℝ))) S := by
    apply continuousOn_tsum (u := fun j => (A * Real.exp (c * K)) * exponentialGridWeight (c * h) j)
    · intro j
      exact (hCont.comp (continuous_id.add continuous_const)).continuousOn
    · exact (summable_exponential_grid (mul_pos hc hh)).mul_left _
    · intro j x hx
      rw [Real.norm_eq_abs]
      exact periodic_kernel_point_bound hh hc hA hJ (abs_le.mpr hx) j
  exact (continuousOn_const.mul hC).continuousAt hS

theorem periodic_kernel_integer_shift (h : ℝ) (J : ℝ → ℝ) (v : ℝ) (m : ℤ) :
    periodicKernelProfile h J (v + h * (m : ℝ)) = periodicKernelProfile h J v := by
  unfold periodicKernelProfile
  congr 1
  have hEq (j : ℤ) : v + h * (m : ℝ) + h * (j : ℝ) = v + h * ((j + m : ℤ) : ℝ) := by
    push_cast
    ring
  simp only [hEq]
  exact (Equiv.addRight m).tsum_eq (fun j : ℤ => J (v + h * (j : ℝ)))

theorem periodic_kernel_positive_and_bounded {h c A : ℝ} (hh : 0 < h) (hc : 0 < c) (hA : 0 ≤ A)
    {J : ℝ → ℝ} (hJ : ∀ s, |J s| ≤ A * exponentialEnvelope c s)
    (hCont : Continuous J) (hPos : ∀ s, 0 < J s) :
    ∃ m > 0, ∃ M > 0, ∀ v, m ≤ periodicKernelProfile h J v ∧ periodicKernelProfile h J v ≤ M := by
  have hP (v : ℝ) : 0 < periodicKernelProfile h J v := by
    have hs := periodic_kernel_series hh hc hA hJ v
    have h0 : J (v + h * ((0 : ℤ) : ℝ)) ≤ ∑' j : ℤ, J (v + h * (j : ℝ)) :=
      hs.le_tsum 0 (fun j _ => (hPos _).le)
    exact mul_pos hh ((hPos _).trans_le h0)
  let H := periodicKernelProfile h J
  have hH : Continuous H := periodic_kernel_continuous hh hc hA hJ hCont
  have hNon : (Icc (0 : ℝ) h).Nonempty := ⟨0, le_rfl, hh.le⟩
  obtain ⟨s, hs, hMin⟩ := isCompact_Icc.exists_isMinOn hNon hH.continuousOn
  obtain ⟨t, ht, hMax⟩ := isCompact_Icc.exists_isMaxOn hNon hH.continuousOn
  refine ⟨H s, hP s, H t, hP t, ?_⟩
  intro v
  let m := ⌊v / h⌋
  let g := h * Int.fract (v / h)
  have gv : v = g + h * (m : ℝ) := by
    unfold g m
    rw [← mul_add, Int.fract_add_floor, mul_div_cancel₀ _ hh.ne']
  have hg : g ∈ Icc (0 : ℝ) h := by
    unfold g
    exact ⟨mul_nonneg hh.le (Int.fract_nonneg _),
      mul_le_of_le_one_right hh.le (Int.fract_lt_one _).le⟩
  have he : H v = H g := by
    rw [gv]
    exact periodic_kernel_integer_shift h J g m
  change H s ≤ H v ∧ H v ≤ H t
  rw [he]
  exact ⟨hMin hg, hMax hg⟩

end RenyiProductOrderPhase
