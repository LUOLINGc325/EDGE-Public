import CriticalGlobalLimit
import PriorAttainment

/-! The critical-window limit for the attained coefficient and every attaining prior. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem critical_parametrization_inverse (p q : FiniteMass κ) {n : ℕ}
    (hs : 0 < criticalScale p q n) {a : ℝ} (ha : 0 < a) :
    let t := Real.log (1 + a) / criticalScale p q n
    0 < t ∧ criticalPrior p q n t = a := by
  have hL : 1 < 1 + a := lt_add_of_pos_right _ ha
  refine ⟨div_pos (Real.log_pos hL) hs, ?_⟩
  unfold criticalPrior
  rw [div_mul_cancel₀ _ hs.ne', Real.exp_log (zero_lt_one.trans hL), add_sub_cancel_left]

theorem critical_exact_coefficient_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) (ζ : ℝ) :
    ∃ tStar > 0, (∀ t > 0, criticalGaussianCost ζ tStar ≤ criticalGaussianCost ζ t) ∧
      Tendsto (fun n : ℕ => criticalOrder p q ζ (n + 1) * criticalScale p q (n + 1) *
        sInf (productDeficitValues p q (n + 1) (criticalOrder p q ζ (n + 1)))) atTop
          (𝓝 (criticalGaussianCost ζ tStar)) ∧
      ∀ a : ℕ → ℝ, (∀ᶠ n in atTop, 0 < a n ∧
        IsLeast (productDeficitValues p q (n + 1) (criticalOrder p q ζ (n + 1)))
          (productScalarDeficit p q (n + 1) (criticalOrder p q ζ (n + 1)) (a n))) →
        Tendsto (fun n => Real.log (1 + a n) / criticalScale p q (n + 1)) atTop (𝓝 tStar) := by
  let b (n : ℕ) := criticalOrder p q ζ (n + 1)
  let s (n : ℕ) := criticalScale p q (n + 1)
  have hb (n : ℕ) : 0 < b n := Real.exp_pos _
  have hs (n : ℕ) : 0 < s n := critical_scale_pos p q hp hq hne (Nat.succ_pos n)
  obtain ⟨tStar, htStar, hMin, hLimit⟩ := critical_window_all_optimizer_limits p q hp hq hne ζ
  have hAux (a : ℕ → ℝ) (ha : ∀ᶠ n in atTop, 0 < a n ∧
      IsLeast (productDeficitValues p q (n + 1) (b n)) (productScalarDeficit p q (n + 1) (b n) (a n))) :
      let t (n : ℕ) := Real.log (1 + a n) / s n
      Tendsto t atTop (𝓝 tStar) ∧
        Tendsto (fun n => b n * s n * sInf (productDeficitValues p q (n + 1) (b n))) atTop
          (𝓝 (criticalGaussianCost ζ tStar)) := by
    let t (n : ℕ) := Real.log (1 + a n) / s n
    have ht : ∀ᶠ n in atTop, 0 < t n := ha.mono (fun n hn => (critical_parametrization_inverse p q (hs n) hn.1).1)
    have hOpt : ∀ᶠ n in atTop, ∀ x > 0, criticalObjective p q ζ (n + 1) (t n) ≤
        criticalObjective p q ζ (n + 1) x + (fun _ : ℕ => (0 : ℝ)) n := by
      filter_upwards [ha] with n hn
      intro x hx
      have hInv := critical_parametrization_inverse p q (hs n) hn.1
      rw [add_zero, critical_objective_exact_scale p q ζ (n + 1) (hs n) hInv.1,
        critical_objective_exact_scale p q ζ (n + 1) (hs n) hx, hInv.2]
      exact mul_le_mul_of_nonneg_left (hn.2.2 ⟨_, critical_prior_positive p q (hs n) hx, rfl⟩)
        (mul_pos (hb n) (hs n)).le
    obtain ⟨hT, hV⟩ := hLimit t (fun _ => 0) ht tendsto_const_nhds hOpt
    refine ⟨hT, hV.congr' ?_⟩
    filter_upwards [ha] with n hn
    have hInv := critical_parametrization_inverse p q (hs n) hn.1
    rw [critical_objective_exact_scale p q ζ (n + 1) (hs n) hInv.1, hInv.2, hn.2.csInf_eq]
  refine ⟨tStar, htStar, hMin, ?_, ?_⟩
  · classical
    choose a ha hA using fun n : ℕ => product_deficit_attained p q hp hq hne (Nat.succ_pos n) (b n) (hb n)
    exact (hAux a (Filter.Eventually.of_forall fun n => ⟨ha n, hA n⟩)).2
  · intro a ha
    exact (hAux a ha).1

end RenyiProductOrderPhase
