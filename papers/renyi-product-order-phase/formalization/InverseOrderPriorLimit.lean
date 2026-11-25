import InverseOrderMinimum
import Mathlib.Analysis.Calculus.Deriv.Slope

/-! The slope at the inverse Rényi root determines every optimizing prior. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem inverse_order_secants_near_root (p q : FiniteMass κ) {r β ε : ℝ}
    (hβ : 0 < β) (hRoot : logCumulant p q (-β) = r * β) (hε : 0 < ε) :
    let F := inverseOrderObjective p q r
    let u := inverseOrderSlope p q r β
    ∃ a ∈ Ioo 0 β, ∃ b ∈ Ioi β,
      |F a / (a - β) - u| < ε ∧ |F b / (b - β) - u| < ε := by
  let F := inverseOrderObjective p q r
  let u := inverseOrderSlope p q r β
  have hZero : F β = 0 := sub_eq_zero.mpr hRoot
  have hD : HasDerivAt F u β := inverse_order_derivative p q r β
  have hEv := (hasDerivAt_iff_tendsto_slope.mp hD).eventually (Metric.ball_mem_nhds u hε)
  obtain ⟨δ, hδ, hBall⟩ := Metric.mem_nhdsWithin_iff.mp hEv
  let d := (min β δ) / 2
  have hd : 0 < d := div_pos (lt_min hβ hδ) (by norm_num)
  have hdβ : d < β := by
    unfold d
    have h := min_le_left β δ
    linarith only [h, hβ]
  have hdδ : d < δ := by
    unfold d
    have h := min_le_right β δ
    linarith only [h, hδ]
  have hSec (t : ℝ) (ht : t ≠ β) (hDist : |t - β| < δ) :
      |F t / (t - β) - u| < ε := by
    have h := hBall (show t ∈ Metric.ball β δ ∩ {β}ᶜ from
      ⟨by simpa only [Metric.mem_ball, Real.dist_eq] using hDist,
        by simpa only [mem_compl_iff, mem_singleton_iff] using ht⟩)
    change slope F β t ∈ Metric.ball u ε at h
    simpa [Metric.mem_ball, Real.dist_eq, slope_def_field, hZero] using h
  refine ⟨β - d, ⟨sub_pos.mpr hdβ, sub_lt_self _ hd⟩,
    β + d, lt_add_of_pos_right _ hd, ?_, ?_⟩
  · exact hSec _ (sub_lt_self β hd).ne (by
      rw [show β - d - β = -d by ring, abs_neg, abs_of_pos hd]
      exact hdδ)
  · exact hSec _ (lt_add_of_pos_right β hd).ne' (by
      rw [add_sub_cancel_left, abs_of_pos hd]
      exact hdδ)

theorem inverse_order_normalized_time_limit (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) {r β : ℝ}
    (hr : 0 < r) (hβ : 0 < β) (hRoot : logCumulant p q (-β) = r * β)
    (U : ℕ → ℝ) (hU : Tendsto U atTop atTop)
    (hV : Tendsto (fun n => exponentialPriorCost p q r (n + 1) (U n)) atTop (𝓝 β)) :
    Tendsto (fun n => U n / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 (inverseOrderSlope p q r β)) := by
  let F := inverseOrderObjective p q r
  let u := inverseOrderSlope p q r β
  let V (n : ℕ) := exponentialPriorCost p q r (n + 1) (U n)
  let N (n : ℕ) : ℝ := ((n + 1 : ℕ) : ℝ)
  let T (n : ℕ) := U n / N n
  have hN (n : ℕ) : 0 < N n := by unfold N; exact_mod_cast Nat.succ_pos n
  let C (t : ℝ) := t * (Real.log 2 + Real.log t)
  let R (t : ℝ) (n : ℕ) := (F t + C t / N n) / (t - V n)
  have hR (t : ℝ) (ht : t ≠ β) : Tendsto (R t) atTop (𝓝 (F t / (t - β))) := by
    have hDiv : Tendsto (fun n => C t / N n) atTop (𝓝 0) :=
      (tendsto_const_div_atTop_nhds_zero_nat (C t)).comp
        (tendsto_atTop.2 fun m => (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n)))
    have hNum : Tendsto (fun n => F t + C t / N n) atTop (𝓝 (F t)) := by
      simpa only [add_zero] using tendsto_const_nhds.add hDiv
    exact hNum.div (tendsto_const_nhds.sub hV) (sub_ne_zero.mpr ht)
  have hPower (t : ℝ) (ht : 0 < t) :
      ∀ᶠ n in atTop, (t - V n) * T n ≤ F t + C t / N n := by
    filter_upwards [hU.eventually (eventually_ge_atTop (Real.log 2)),
      (order_at_rate_tendsto hr).eventually (eventually_ge_atTop t)] with n hn hb
    have hn₀ : 0 < U n := (Real.log_pos (by norm_num : (1 : ℝ) < 2)).trans_le hn
    have hP := inverse_order_prior_linear_bound p q hp hq r (n + 1) hn ht hb
    have hV' : V n * U n =
        negativeLogProductMoment p q (n + 1) (orderAtRate r (n + 1)) (priorFromTime (U n)) := by
      unfold V exponentialPriorCost
      rw [div_mul_cancel₀ _ hn₀.ne']
    rw [← hV'] at hP
    unfold T
    rw [← mul_div_assoc]
    apply (div_le_iff₀ (hN n)).2
    rw [add_mul, div_mul_cancel₀ _ (hN n).ne']
    change _ ≤ F t * N n + C t
    change t * U n - N n * F t - C t ≤ V n * U n at hP
    linarith only [hP]
  apply Metric.tendsto_nhds.2
  intro ε hε
  have hHalf : 0 < ε / 2 := div_pos hε (by norm_num)
  obtain ⟨a, ha, b, hb, hSa, hSb⟩ := inverse_order_secants_near_root p q hβ hRoot hHalf
  have hVa := hV.eventually (lt_mem_nhds ha.2)
  have hVb := hV.eventually (gt_mem_nhds (mem_Ioi.mp hb))
  have hRa := (Metric.tendsto_nhds.1 (hR a ha.2.ne)) (ε / 2) hHalf
  have hRb := (Metric.tendsto_nhds.1 (hR b (mem_Ioi.mp hb).ne')) (ε / 2) hHalf
  filter_upwards [hPower a ha.1, hPower b (hβ.trans (mem_Ioi.mp hb)), hVa, hVb, hRa, hRb]
    with n hnA hnB hnVa hnVb hnRa hnRb
  have hLo : R a n ≤ T n := by
    unfold R
    apply (div_le_iff_of_neg (sub_neg.mpr hnVa)).2
    simpa only [mul_comm] using hnA
  have hUp : T n ≤ R b n := by
    unfold R
    apply (le_div_iff₀ (sub_pos.mpr hnVb)).2
    simpa only [mul_comm] using hnB
  rw [Real.dist_eq] at hnRa hnRb ⊢
  exact abs_lt.mpr ⟨by linarith only [hLo, (abs_lt.mp hnRa).1, (abs_lt.mp hSa).1],
    by linarith only [hUp, (abs_lt.mp hnRb).2, (abs_lt.mp hSb).2]⟩

end RenyiProductOrderPhase
