import PublishedFrontier
import FiveJobExample
import OfflineAndLinearProgram

/-! Ratio semantics, the attained real infima, and the published depth intervals. -/

open scoped BigOperators

namespace FiniteFrontier

variable {n : ℕ}

theorem positive_frozen_cost (hn : 0 < n) (x : PositiveSizes (Fin n)) :
    0 < frozenCost x.val := by
  let i : Fin n := ⟨0, hn⟩
  have hsum : (x.val i) ≤ ∑ j, x.val j :=
    Finset.single_le_sum (fun j _ => (x.property j).le) (Finset.mem_univ i)
  exact ((x.property i).trans_le hsum).trans_le
    (frozen_ge_size_sum x.val (fun j => (x.property j).le))

theorem robust_iff_ratios (hn : 0 < n) (A : Policy (Fin n)) (R : ℝ) :
    Robust A R ↔ ∀ x y, (A.run y x).cost / frozenCost x.val ≤ R := by
  constructor
  · exact fun h x y => (div_le_iff₀ (positive_frozen_cost hn x)).mpr (h x y)
  · exact fun h x y => (div_le_iff₀ (positive_frozen_cost hn x)).mp (h x y)

theorem consistent_iff_ratios (hn : 0 < n) (A : Policy (Fin n)) (C : ℝ) :
    Consistent A C ↔ ∀ y, (A.run y y).cost / frozenCost y.val ≤ C := by
  constructor
  · exact fun h y => (div_le_iff₀ (positive_frozen_cost hn y)).mpr (h y)
  · exact fun h y => (div_le_iff₀ (positive_frozen_cost hn y)).mp (h y)

theorem exact_consistency_infimum (hn : 0 < n) (R : ℝ)
    (hR : baselineRobustness (n : ℝ) ≤ R) :
    sInf (consistencyBounds n R) = unitFrontier n R :=
  (exact_finite_job_frontier hn R hR).csInf_eq

theorem exact_inverse_infimum (hn : 1 < n) (R C : ℝ)
    (hR : R ∈ Set.Icc (baselineRobustness (n : ℝ)) (n : ℝ))
    (hC : unitFrontier n R = C) :
    sInf (robustnessBounds n C) = R :=
  (inverse_attained hn R C hR hC).csInf_eq

/-- The branch conditions use exactly the robustness cutoffs in the source's
piecewise inverse. Depth one owns its upper endpoint and adjacent ties go to the
shallower branch. -/
theorem published_depth_cutoffs {a : ℕ} {R : ℝ} (d : PublishedDepth n R a) :
    ((n : ℝ) - a) / ((a : ℝ) + 1) ≤ R ∧
      R ≤ ((n : ℝ) + 1 - a) / (a : ℝ) ∧
      (a ≠ 1 → R < ((n : ℝ) + 1 - a) / (a : ℝ)) := by
  have ha : 0 < (a : ℝ) := by exact_mod_cast d.positive
  have hlo := d.branch.inactive
  have hhi := d.branch.active
  unfold unitGap at hlo hhi
  refine ⟨(div_le_iff₀ (by positivity)).mpr (by linarith only [hlo]),
    (le_div_iff₀ ha).mpr (by linarith only [hhi]), ?_⟩
  intro hne
  have h := d.endpoint_owner.resolve_left hne
  unfold unitGap at h
  exact (lt_div_iff₀ ha).mpr (by linarith only [h])

theorem baseline_excess_formula (n : ℕ) :
    baselineRobustness (n : ℝ) - 1 = ((n : ℝ) - 1) / ((n : ℝ) + 1) := by
  unfold baselineRobustness
  have hd : ((n : ℝ) + 1) ≠ 0 := by positivity
  calc
    _ = (2 * (n : ℝ) - ((n : ℝ) + 1)) / ((n : ℝ) + 1) := by rw [sub_div, div_self hd]
    _ = _ := by ring

/-- The published Order-a system chooses a unique robustness coordinate. -/
noncomputable def publishedPhi (n : ℕ) (hn : 1 < n) (excess : ℝ) (hexcess₀ : 0 ≤ excess)
    (hexcess₁ : excess < ((n : ℝ) - 1) / ((n : ℝ) + 1)) : ℝ :=
  Classical.choose (published_phi_attained hn excess hexcess₀ (by rwa [baseline_excess_formula]))

theorem published_phi_is_attained (n : ℕ) (hn : 1 < n) (excess : ℝ) (hexcess₀ : 0 ≤ excess)
    (hexcess₁ : excess < ((n : ℝ) - 1) / ((n : ℝ) + 1)) :
    IsLeast (robustnessBounds n (1 + excess)) (publishedPhi n hn excess hexcess₀ hexcess₁) :=
  (Classical.choose_spec (published_phi_attained hn excess hexcess₀ (by rwa [baseline_excess_formula]))).1

theorem exact_inverse_published_phi (n : ℕ) (hn : 1 < n) (excess : ℝ) (hexcess₀ : 0 ≤ excess)
    (hexcess₁ : excess < ((n : ℝ) - 1) / ((n : ℝ) + 1)) :
    sInf (robustnessBounds n (1 + excess)) = publishedPhi n hn excess hexcess₀ hexcess₁ :=
  (published_phi_is_attained n hn excess hexcess₀ hexcess₁).csInf_eq

theorem low_robustness_dimension_domain (R H : ℝ) (hR : R < 2) :
    0 ≤ (R - 2) * H + 2 ↔ H ≤ 2 / (2 - R) := by
  rw [le_div_iff₀ (sub_pos.mpr hR)]
  constructor <;> intro h <;> linarith only [h]

end FiniteFrontier
