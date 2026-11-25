import NormalMillsRatio
import Mathlib.Analysis.Calculus.LocalExtr.Basic

/-! Existence and uniqueness of the critical KL Gaussian variational optimum. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

noncomputable def normalLogTail (x : ℝ) := -Real.log (standardNormalTail x)
noncomputable def normalHazard (x : ℝ) := gaussianProfile 1 1 x / standardNormalTail x
noncomputable def criticalGaussianCost (ζ t : ℝ) := normalLogTail (ζ + t) / t

theorem normal_log_tail_pos (x : ℝ) : 0 < normalLogTail x :=
  neg_pos.mpr (Real.log_neg (standard_normal_tail_bounds x).1 (standard_normal_tail_bounds x).2)

theorem normal_log_tail_derivative (x : ℝ) : HasDerivAt normalLogTail (normalHazard x) x := by
  have h := (standard_normal_tail_derivative x).log (standard_normal_tail_bounds x).1.ne'
  simpa only [normalLogTail, normalHazard, neg_div, neg_neg] using h.neg

theorem normal_hazard_strict_mono : StrictMono normalHazard := by
  have h (x : ℝ) : normalHazard x = (normalMillsRatio x)⁻¹ := by
    unfold normalHazard normalMillsRatio
    rw [inv_div]
  intro x y hxy
  rw [h, h]
  exact (inv_lt_inv₀ (normal_mills_positive x) (normal_mills_positive y)).2
    (normal_mills_strict_antitone hxy)

theorem normal_log_tail_strict_mono : StrictMono normalLogTail := by
  apply strictMono_of_deriv_pos
  intro x
  rw [(normal_log_tail_derivative x).deriv]
  exact div_pos (standard_normal_density_positive x) (standard_normal_tail_bounds x).1

theorem normal_tail_quadratic_bound {x : ℝ} (hx : 0 ≤ x) :
    x ^ 2 / 2 ≤ normalLogTail x := by
  let f := gaussianProfile 1 1
  have hF (s : ℝ) : 0 < f s := standard_normal_density_positive s
  have hM := normal_mills_strict_antitone.antitone hx
  have hQ (s : ℝ) : f s * normalMillsRatio s = standardNormalTail s := by
    unfold normalMillsRatio
    exact mul_div_cancel₀ _ (hF s).ne'
  have hs : f x = f 0 * Real.exp (-(x ^ 2 / 2)) := by
    simpa only [f, add_zero, millsIntegrand, neg_zero, zero_mul, zero_sub] using normal_density_shift 0 x
  have h := calc
    standardNormalTail x = f x * normalMillsRatio x := (hQ x).symm
    _ ≤ f x * normalMillsRatio 0 := mul_le_mul_of_nonneg_left hM (hF x).le
    _ = standardNormalTail 0 * Real.exp (-(x ^ 2 / 2)) := by
      rw [hs, mul_right_comm, hQ]
    _ ≤ Real.exp (-(x ^ 2 / 2)) :=
      mul_le_of_le_one_left (Real.exp_nonneg _) (standard_normal_tail_bounds 0).2.le
  have hL := Real.log_le_log (standard_normal_tail_bounds x).1 h
  rw [Real.log_exp] at hL
  simpa only [neg_neg] using neg_le_neg hL

theorem critical_gaussian_cost_derivative (ζ : ℝ) {t : ℝ} (ht : 0 < t) :
    HasDerivAt (criticalGaussianCost ζ)
      ((t * normalHazard (ζ + t) - normalLogTail (ζ + t)) / t ^ 2) t := by
  have hT : HasDerivAt (fun u : ℝ => ζ + u) 1 t := by
    simpa only [id_eq, zero_add] using (hasDerivAt_id t).const_add ζ
  have hH : HasDerivAt (fun u : ℝ => normalLogTail (ζ + u)) (normalHazard (ζ + t)) t := by
    simpa only [Function.comp_apply, mul_one] using (normal_log_tail_derivative (ζ + t)).comp t hT
  unfold criticalGaussianCost
  convert hH.div (hasDerivAt_id t) ht.ne' using 1
  simp only [id_eq, mul_one, mul_comm (normalHazard (ζ + t))]

theorem critical_gaussian_cost_boundary (ζ : ℝ) {t : ℝ} (ht : 0 < t) :
    normalLogTail ζ / t ≤ criticalGaussianCost ζ t ∧
      (2 * |ζ| ≤ t → t / 8 ≤ criticalGaussianCost ζ t) := by
  constructor
  · exact div_le_div_of_nonneg_right (normal_log_tail_strict_mono (lt_add_of_pos_right _ ht)).le ht.le
  · intro h
    apply (le_div_iff₀ ht).2
    have hX : t / 2 ≤ ζ + t := by linarith only [h, neg_le_abs ζ]
    have hP := pow_le_pow_left₀ (div_nonneg ht.le (by norm_num)) hX 2
    have hS := normal_tail_quadratic_bound ((div_nonneg ht.le (by norm_num)).trans hX)
    nlinarith only [hP, hS]

theorem critical_gaussian_unique_minimum (ζ : ℝ) :
    ∃ t > 0, (∀ u > 0, criticalGaussianCost ζ t ≤ criticalGaussianCost ζ u) ∧
      ∀ u > 0, u ≠ t → criticalGaussianCost ζ t < criticalGaussianCost ζ u := by
  let F := criticalGaussianCost ζ
  let C := F 1
  have hC : 0 < C := by
    unfold C F criticalGaussianCost
    exact div_pos (normal_log_tail_pos _) zero_lt_one
  let l := min 1 (normalLogTail ζ / (C + 1))
  let u := max 1 (max (2 * |ζ|) (8 * (C + 1)))
  have hl : 0 < l := lt_min zero_lt_one (div_pos (normal_log_tail_pos ζ) (by linarith))
  have hOne : (1 : ℝ) ∈ Icc l u := ⟨min_le_left _ _, le_max_left _ _⟩
  have hC' : ContinuousOn F (Icc l u) :=
    fun t ht => (critical_gaussian_cost_derivative ζ (hl.trans_le ht.1)).continuousAt.continuousWithinAt
  obtain ⟨t, ht, hMin⟩ := isCompact_Icc.exists_isMinOn ⟨1, hOne⟩ hC'
  have ht : 0 < t := hl.trans_le ht.1
  have hG (x : ℝ) (hx : 0 < x) : F t ≤ F x := by
    have hC₁ : F t ≤ C := hMin hOne
    rcases le_or_gt l x with h | h
    · rcases le_or_gt x u with h' | h'
      · exact hMin ⟨h, h'⟩
      · have hX : 2 * |ζ| ≤ x := ((le_max_left _ _).trans (le_max_right _ _)).trans h'.le
        have hVal : 8 * (C + 1) ≤ x := ((le_max_right _ _).trans (le_max_right _ _)).trans h'.le
        have hBound := (critical_gaussian_cost_boundary ζ hx).2 hX
        linarith only [hBound, hVal, hC₁]
    · have hX : x ≤ normalLogTail ζ / (C + 1) := h.le.trans (min_le_right _ _)
      have hMul := (le_div_iff₀ (by positivity : 0 < C + 1)).1 hX
      have hB : C + 1 ≤ normalLogTail ζ / x := (le_div_iff₀ hx).2
        (by simpa only [mul_comm (C + 1)] using hMul)
      exact hC₁.trans ((le_add_of_nonneg_right zero_le_one).trans
        (hB.trans (critical_gaussian_cost_boundary ζ hx).1))
  have hStationary (x : ℝ) (hx : 0 < x) (hm : ∀ y, 0 < y → F x ≤ F y) :
      normalHazard (ζ + x) = F x := by
    have hPos : ∀ᶠ y in 𝓝 x, y ∈ Ioi (0 : ℝ) := Ioi_mem_nhds hx
    have hLoc : IsLocalMin F x := hPos.mono (fun y hy => hm y (mem_Ioi.mp hy))
    have hZ := hLoc.hasDerivAt_eq_zero (critical_gaussian_cost_derivative ζ hx)
    have hV := (div_eq_iff (pow_ne_zero 2 hx.ne')).1 hZ
    rw [zero_mul] at hV
    symm
    apply (div_eq_iff hx.ne').2
    nlinarith only [hV]
  refine ⟨t, ht, hG, ?_⟩
  intro x hx hne
  apply lt_of_le_of_ne (hG x hx)
  intro h
  have hMinX : ∀ y, 0 < y → F x ≤ F y := by
    intro y hy
    rw [← h]
    exact hG y hy
  have hEz : ζ + t = ζ + x := normal_hazard_strict_mono.injective
    ((hStationary t ht hG).trans (h.trans (hStationary x hx hMinX).symm))
  exact hne (by linarith only [hEz])

end RenyiProductOrderPhase
