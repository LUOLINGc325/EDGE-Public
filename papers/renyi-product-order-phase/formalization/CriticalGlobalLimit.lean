import CriticalSmallPrior
import CriticalLargePrior
import CriticalCompactLimit
import GlobalPriorLimit

/-! The global critical-window optimum, including all approximate optimizing prior sequences. -/

open scoped BigOperators Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem critical_priors_confined (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (ζ : ℝ) {C : ℝ} (hC : 0 ≤ C) :
    ∃ l > 0, ∃ u > 0, ∀ᶠ n : ℕ in atTop, ∀ t, 0 < t →
      criticalObjective p q ζ (n + 1) t ≤ C → t ∈ Icc l u := by
  let k := gaussianCDF 1 ζ
  have hk : 0 < k := (standard_normal_probability_positive ζ).1
  let L := C + 1
  have hL : 0 < L := by unfold L; positivity
  let l := k / (4 * L)
  have hl : 0 < l := div_pos hk (mul_pos (by norm_num) hL)
  let B := ∑ i, |klCenteredLikelihood p q i|
  have hB : 0 ≤ B := Finset.sum_nonneg (fun _ _ => abs_nonneg _)
  have hBB (i : κ) : |klCenteredLikelihood p q i| ≤ B :=
    Finset.single_le_sum (f := fun j : κ => |klCenteredLikelihood p q j|)
      (fun _ _ => abs_nonneg _) (Finset.mem_univ i)
  let E := Real.exp 1 * L ^ 2 + L * |ζ| + Real.log 2
  let u := max 1 E
  refine ⟨l, hl, u, zero_lt_one.trans_le (le_max_left _ _), ?_⟩
  have hS := critical_scale_tendsto p q hp hq hne
  have hS₁ := hS.eventually (eventually_ge_atTop (1 / l))
  have hS₂ := hS.eventually (eventually_ge_atTop (L * (B + 1)))
  have hS₃ := hS.eventually (eventually_ge_atTop (Real.log 2))
  have hHb := (critical_order_tendsto p q hp hq hne ζ).eventually (eventually_ge_atTop 1)
  have hCDF := kl_uniform_central_limit p q hp hq hne (div_pos hk (by norm_num : (0 : ℝ) < 2))
  filter_upwards [hS₁, hS₂, hS₃, hHb, hCDF] with n hn₁ hn₂ hn₃ hb hCL
  intro t ht htV
  let s := criticalScale p q (n + 1)
  have hs : 0 < s := critical_scale_pos p q hp hq hne (Nat.succ_pos n)
  let Y (i : κ) := standardizedLogLikelihood p q i / Real.sqrt ((n + 1 : ℕ) : ℝ)
  let d := finiteSumEvent p Y (n + 1) (Iic ζ)
  constructor
  · apply le_of_not_ge
    intro htl
    have hs' : s⁻¹ ≤ l := by
      have h := (div_le_iff₀ hl).1 hn₁
      rw [← one_div]
      exact (div_le_iff₀ hs).2 (by simpa only [mul_comm l s] using h)
    have hP : k / 2 ≤ d := by
      have h := (abs_lt.mp (hCL ζ)).1
      change -(k / 2) < d - k at h
      linarith only [h]
    have hNum : L * (t + s⁻¹) ≤ d := by
      calc
        _ ≤ L * (2 * l) := mul_le_mul_of_nonneg_left (by linarith only [htl, hs']) hL.le
        _ = k / 2 := by
          unfold l
          rw [← mul_div_assoc]
          field_simp [hL.ne']
          ring
        _ ≤ _ := hP
    have hV : L ≤ criticalObjective p q ζ (n + 1) t :=
      ((le_div_iff₀ (add_pos ht (inv_pos.mpr hs))).2 hNum).trans
        (critical_small_prior_uniform_lower p q hp hq ζ (n + 1) hs ht hb)
    unfold L at hV
    linarith only [hV, htV]
  · by_cases hU : Real.log 2 ≤ t * s
    · let θ := L / s
      have hθ : 0 ≤ θ := (div_pos hL hs).le
      have hLim : θ * (B + 1) ≤ 1 := by
        unfold θ
        rw [div_mul_eq_mul_div]
        exact (div_le_iff₀ hs).2 (by simpa only [one_mul] using hn₂)
      have hθ₁ : θ ≤ 1 :=
        (le_mul_of_one_le_right hθ (le_add_of_nonneg_left hB)).trans hLim
      have hSmall (i : κ) : |θ * klCenteredLikelihood p q i| ≤ 1 := by
        rw [abs_mul, abs_of_nonneg hθ]
        exact (mul_le_mul_of_nonneg_left ((hBB i).trans (le_add_of_nonneg_right zero_le_one)) hθ).trans hLim
      have hRaw := critical_large_prior_linear_bound p q hp hq hne ζ (Nat.succ_pos n)
        hL ht hb hSmall hθ₁ hU
      change negativeLogProductMoment p q (n + 1) (criticalOrder p q ζ (n + 1))
        (criticalPrior p q (n + 1) t) / t ≤ C at htV
      have hK := (div_le_iff₀ ht).1 htV
      change L * t - E ≤ _ at hRaw
      have hE : t ≤ E := by unfold L at hRaw; nlinarith only [hRaw, hK]
      exact hE.trans (le_max_right _ _)
    · have he : t * s < Real.log 2 := lt_of_not_ge hU
      have hS' : Real.log 2 ≤ s := hn₃
      have ht' : t ≤ (1 : ℝ) := by
        apply le_of_mul_le_mul_right _ hs
        simpa only [one_mul] using he.le.trans hS'
      exact ht'.trans (le_max_left _ _)

theorem critical_window_all_optimizer_limits (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) (ζ : ℝ) :
    ∃ tStar > 0, (∀ t > 0, criticalGaussianCost ζ tStar ≤ criticalGaussianCost ζ t) ∧
      ∀ a e : ℕ → ℝ, (∀ᶠ n in atTop, 0 < a n) → Tendsto e atTop (𝓝 0) →
        (∀ᶠ n in atTop, ∀ t > 0, criticalObjective p q ζ (n + 1) (a n) ≤
          criticalObjective p q ζ (n + 1) t + e n) →
        Tendsto a atTop (𝓝 tStar) ∧
          Tendsto (fun n => criticalObjective p q ζ (n + 1) (a n)) atTop
            (𝓝 (criticalGaussianCost ζ tStar)) := by
  obtain ⟨t, ht, hMin, hStrict⟩ := critical_gaussian_unique_minimum ζ
  refine ⟨t, ht, hMin, ?_⟩
  intro a e ha he hOpt
  apply global_compact_prior_minimizers ht
    (fun x hx => (critical_gaussian_cost_derivative ζ (mem_Ioi.mp hx)).continuousAt.continuousWithinAt)
    hStrict (fun C hC => critical_priors_confined p q hp hq hne ζ hC)
    (fun l u hl _ ε hε => critical_objective_compact_uniform p q hp hq hne ζ (u := u) hl hε)
    a e ha he hOpt

end RenyiProductOrderPhase
