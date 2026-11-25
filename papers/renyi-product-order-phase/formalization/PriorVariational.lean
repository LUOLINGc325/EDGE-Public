import TiltedKernels
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.SpecialFunctions.Pow.Deriv
import Mathlib.Topology.Order.IntermediateValue

/-! The unique scalar prior in the nonarithmetic fixed- and growing-order limits. -/

open Set

namespace RenyiProductOrderPhase

noncomputable def priorStationarity (θ t : ℝ) : ℝ :=
  θ * t - (1 - Real.exp (-t))

noncomputable def priorCostTime (θ t : ℝ) : ℝ :=
  (Real.exp t - 1) ^ θ / t

noncomputable def priorCost (θ a : ℝ) : ℝ :=
  a ^ θ / Real.log (1 + a)

theorem prior_stationarity_derivative (θ t : ℝ) :
    HasDerivAt (priorStationarity θ) (θ - Real.exp (-t)) t := by
  have he : HasDerivAt (fun x : ℝ => Real.exp (-x)) (-Real.exp (-t)) t := by
    simpa only [mul_neg, mul_one] using
      (Real.hasDerivAt_exp (-t)).comp t ((hasDerivAt_id t).neg)
  unfold priorStationarity
  simpa only [id_eq, mul_one, zero_sub, neg_neg] using
    (((hasDerivAt_id t).const_mul θ).sub ((hasDerivAt_const t (1 : ℝ)).sub he))

theorem prior_stationarity_unique_root {θ : ℝ} (hθ : 0 < θ) (hθ' : θ < 1) :
    ∃ t > 0, priorStationarity θ t = 0 ∧
      (∀ u, 0 < u → u < t → priorStationarity θ u < 0) ∧
      (∀ u, t < u → 0 < priorStationarity θ u) := by
  let s := -Real.log θ
  have hs : 0 < s := neg_pos.mpr (Real.log_neg hθ hθ')
  have he : Real.exp (-s) = θ := by unfold s; rw [neg_neg, Real.exp_log hθ]
  have hCont : Continuous (priorStationarity θ) :=
    continuous_iff_continuousAt.mpr (fun t => (prior_stationarity_derivative θ t).continuousAt)
  have hAnti : StrictAntiOn (priorStationarity θ) (Icc 0 s) := by
    apply strictAntiOn_of_deriv_neg (convex_Icc 0 s) hCont.continuousOn
    intro u hu
    rw [interior_Icc] at hu
    rw [(prior_stationarity_derivative θ u).deriv]
    exact sub_neg.mpr (he ▸ Real.exp_lt_exp.mpr (neg_lt_neg hu.2))
  have hMono : StrictMonoOn (priorStationarity θ) (Ici s) := by
    apply strictMonoOn_of_deriv_pos (convex_Ici s) hCont.continuousOn
    intro u hu
    rw [interior_Ici] at hu
    rw [(prior_stationarity_derivative θ u).deriv]
    exact sub_pos.mpr (he ▸ Real.exp_lt_exp.mpr (neg_lt_neg hu))
  have hZero : priorStationarity θ 0 = 0 := by simp [priorStationarity]
  have hS : priorStationarity θ s < 0 := by
    rw [← hZero]
    exact hAnti ⟨le_rfl, hs.le⟩ ⟨hs.le, le_rfl⟩ hs
  let A := s + 1 / θ
  have hSA : s < A := lt_add_of_pos_right _ (one_div_pos.mpr hθ)
  have hA : 0 < priorStationarity θ A := by
    have hVal : θ * A = θ * s + 1 := by
      unfold A
      rw [mul_add, mul_div_cancel₀ _ hθ.ne']
    unfold priorStationarity
    rw [hVal]
    linarith only [mul_pos hθ hs, Real.exp_pos (-A)]
  obtain ⟨t, ht, hRoot⟩ := intermediate_value_Icc hSA.le hCont.continuousOn
    (show (0 : ℝ) ∈ Icc (priorStationarity θ s) (priorStationarity θ A) from ⟨hS.le, hA.le⟩)
  refine ⟨t, hs.trans_le ht.1, hRoot, ?_, ?_⟩
  · intro u hu hut
    rcases le_or_gt u s with huv | hsu
    · rw [← hZero]
      exact hAnti ⟨le_rfl, hs.le⟩ ⟨hu.le, huv⟩ hu
    · rw [← hRoot]
      exact hMono hsu.le ht.1 hut
  · intro u htu
    rw [← hRoot]
    exact hMono ht.1 (ht.1.trans htu.le) htu

theorem prior_cost_time_derivative (θ : ℝ) {t : ℝ} (ht : 0 < t) :
    HasDerivAt (priorCostTime θ)
      ((Real.exp t - 1) ^ (θ - 1) * Real.exp t / t ^ 2 * priorStationarity θ t) t := by
  have hPos : 0 < Real.exp t - 1 := sub_pos.mpr (by
    simpa only [Real.exp_zero] using Real.exp_lt_exp.mpr ht)
  have hExp : HasDerivAt (fun x : ℝ => Real.exp x - 1) (Real.exp t) t := by
    simpa only [sub_zero] using ((Real.hasDerivAt_exp t).sub_const 1)
  have hPow : HasDerivAt (fun x : ℝ => (Real.exp x - 1) ^ θ)
      (θ * (Real.exp t - 1) ^ (θ - 1) * Real.exp t) t := by
    convert hExp.rpow_const (p := θ) (Or.inl hPos.ne') using 1
    ring
  have h := hPow.div (hasDerivAt_id t) ht.ne'
  unfold priorCostTime
  convert h using 1
  change _ = (θ * (Real.exp t - 1) ^ (θ - 1) * Real.exp t * t -
    (Real.exp t - 1) ^ θ * 1) / t ^ 2
  have hPowStep : (Real.exp t - 1) ^ θ = (Real.exp t - 1) ^ (θ - 1) * (Real.exp t - 1) := by
    nth_rewrite 1 [show θ = (θ - 1) + 1 by ring]
    rw [Real.rpow_add hPos, Real.rpow_one]
  have hRecip : Real.exp t * Real.exp (-t) = 1 := by
    rw [← Real.exp_add, add_neg_cancel, Real.exp_zero]
  rw [hPowStep]
  unfold priorStationarity
  have hFactor : Real.exp t * (θ * t - (1 - Real.exp (-t))) =
    θ * Real.exp t * t - (Real.exp t - 1) := by
    calc
      _ = θ * Real.exp t * t - (Real.exp t - Real.exp t * Real.exp (-t)) := by ring
      _ = _ := by rw [hRecip]
  rw [div_mul_eq_mul_div, mul_assoc, hFactor]
  ring

theorem prior_cost_time_unique_minimum {θ : ℝ} (hθ : 0 < θ) (hθ' : θ < 1) :
    ∃ t > 0, priorStationarity θ t = 0 ∧
      (∀ u > 0, priorStationarity θ u = 0 → u = t) ∧
      ∀ u > 0, u ≠ t → priorCostTime θ t < priorCostTime θ u := by
  obtain ⟨t, ht, hz, hLower, hUpper⟩ := prior_stationarity_unique_root hθ hθ'
  have hC : ContinuousOn (priorCostTime θ) (Ioi 0) := by
    intro u hu
    exact (prior_cost_time_derivative θ hu).continuousAt.continuousWithinAt
  have hPos (u : ℝ) (hu : 0 < u) :
      0 < (Real.exp u - 1) ^ (θ - 1) * Real.exp u / u ^ 2 := by
    have he : 1 < Real.exp u := by simpa only [Real.exp_zero] using Real.exp_lt_exp.mpr hu
    exact div_pos (mul_pos (Real.rpow_pos_of_pos (sub_pos.mpr he) _) (Real.exp_pos _)) (by positivity)
  have hAnti : StrictAntiOn (priorCostTime θ) (Ioc 0 t) := by
    apply strictAntiOn_of_deriv_neg (convex_Ioc 0 t) (hC.mono (fun _ hx => hx.1))
    intro u hu
    have hs : Ioc (0 : ℝ) t ⊆ Icc 0 t := fun _ hx => ⟨hx.1.le, hx.2⟩
    have hu' : u ∈ interior (Icc (0 : ℝ) t) := interior_mono hs hu
    rw [interior_Icc] at hu'
    rw [(prior_cost_time_derivative θ hu'.1).deriv]
    exact mul_neg_of_pos_of_neg (hPos u hu'.1) (hLower u hu'.1 hu'.2)
  have hMono : StrictMonoOn (priorCostTime θ) (Ici t) := by
    apply strictMonoOn_of_deriv_pos (convex_Ici t) (hC.mono (fun _ hu => ht.trans_le hu))
    intro u hu
    rw [interior_Ici] at hu
    have hu' : 0 < u := ht.trans hu
    rw [(prior_cost_time_derivative θ hu').deriv]
    exact mul_pos (hPos u hu') (hUpper u hu)
  refine ⟨t, ht, hz, ?_, ?_⟩
  · intro u hu hzu
    rcases lt_trichotomy u t with h | h | h
    · exact ((ne_of_lt (hLower u hu h)) hzu).elim
    · exact h
    · exact ((ne_of_gt (hUpper u h)) hzu).elim
  · intro u hu hne
    rcases lt_or_gt_of_ne hne with h | h
    · exact hAnti ⟨hu, h.le⟩ ⟨ht, le_rfl⟩ h
    · exact hMono (mem_Ici.mpr (le_refl t)) (mem_Ici.mpr h.le) h

theorem prior_stationarity_in_prior (θ : ℝ) {a : ℝ} (ha : 0 < a) :
    priorStationarity θ (Real.log (1 + a)) = 0 ↔
      θ * (1 + a) * Real.log (1 + a) = a := by
  have hp : 0 < 1 + a := by linarith
  unfold priorStationarity
  rw [Real.exp_neg, Real.exp_log hp]
  constructor
  · intro h
    have h' : θ * Real.log (1 + a) = 1 - (1 + a)⁻¹ := sub_eq_zero.mp h
    calc
      _ = (1 + a) * (θ * Real.log (1 + a)) := by ring
      _ = (1 + a) * (1 - (1 + a)⁻¹) := by rw [h']
      _ = _ := by rw [mul_sub, mul_one, mul_inv_cancel₀ hp.ne']; ring
  · intro h
    have he : (1 + a) * (1 - (1 + a)⁻¹) = a := by
      rw [mul_sub, mul_one, mul_inv_cancel₀ hp.ne']
      ring
    apply sub_eq_zero.mpr
    apply mul_left_cancel₀ hp.ne'
    calc
      _ = θ * (1 + a) * Real.log (1 + a) := by ring
      _ = a := h
      _ = _ := he.symm

theorem prior_cost_unique_minimum {θ : ℝ} (hθ : 0 < θ) (hθ' : θ < 1) :
    ∃ a > 0, θ * (1 + a) * Real.log (1 + a) = a ∧
      (∀ x > 0, θ * (1 + x) * Real.log (1 + x) = x → x = a) ∧
      ∀ x > 0, x ≠ a → priorCost θ a < priorCost θ x := by
  obtain ⟨t, ht, hz, hRoot, hCost⟩ := prior_cost_time_unique_minimum hθ hθ'
  let a := Real.exp t - 1
  have he : 1 < Real.exp t := by simpa only [Real.exp_zero] using Real.exp_lt_exp.mpr ht
  have ha : 0 < a := sub_pos.mpr he
  have hTime : Real.log (1 + a) = t := by
    unfold a
    rw [show 1 + (Real.exp t - 1) = Real.exp t by ring, Real.log_exp]
  have hBack (x : ℝ) (hx : 0 < x) : Real.exp (Real.log (1 + x)) - 1 = x := by
    rw [Real.exp_log (by linarith : 0 < 1 + x)]
    ring
  have hEq (x : ℝ) (hx : 0 < x) : priorCostTime θ (Real.log (1 + x)) = priorCost θ x := by
    unfold priorCostTime priorCost
    rw [hBack x hx]
  refine ⟨a, ha, (prior_stationarity_in_prior θ ha).1 (hTime.symm ▸ hz), ?_, ?_⟩
  · intro x hx hEqn
    have hT := hRoot (Real.log (1 + x)) (Real.log_pos (by linarith))
      ((prior_stationarity_in_prior θ hx).2 hEqn)
    rw [← hBack x hx, hT]
  · intro x hx hne
    have hT : Real.log (1 + x) ≠ t := by
      intro h
      apply hne
      rw [← hBack x hx, h]
    have h := hCost (Real.log (1 + x)) (Real.log_pos (by linarith)) hT
    rw [hEq x hx, ← hTime, hEq a ha] at h
    exact h

end RenyiProductOrderPhase
