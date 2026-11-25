import ChannelAsymptotics
import EndpointOptimizedLimits
import SuperEndpointLimit

/-! Normalized logarithmic rates and the opposite order-first limit. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

theorem block_log_bounded_prefactor_tendsto {f : ℕ → ℝ}
    {c C : ℝ} (hc : 0 < c)
    (hBounds : ∀ᶠ n in atTop, c ≤ f n ∧ f n ≤ C) :
    Tendsto (fun n => Real.log (f n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 0) := by
  have hLimit (x : ℝ) : Tendsto (fun n : ℕ => x / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 0) :=
    (tendsto_const_div_atTop_nhds_zero_nat x).comp
      (tendsto_atTop.2 fun m => (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n)))
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' (hLimit (Real.log c)) (hLimit (Real.log C))
  · filter_upwards [hBounds] with n hn
    exact div_le_div_of_nonneg_right (Real.log_le_log hc hn.1) (Nat.cast_nonneg _)
  · filter_upwards [hBounds] with n hn
    exact div_le_div_of_nonneg_right (Real.log_le_log (hc.trans_le hn.1) hn.2) (Nat.cast_nonneg _)

theorem normalized_deficit_rate_of_scale {d S : ℕ → ℝ} {r c C : ℝ}
    (hS : ∀ᶠ n in atTop, 0 < S n)
    (hRate : Tendsto (fun n => Real.log (S n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 r))
    (hc : 0 < c)
    (hBounds : ∀ᶠ n in atTop, c ≤ S n * d n ∧ S n * d n ≤ C) :
    Tendsto (fun n => -Real.log (d n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 r) := by
  have hB := block_log_bounded_prefactor_tendsto hc hBounds
  have h := hRate.sub hB
  rw [sub_zero] at h
  apply h.congr'
  filter_upwards [hS, hBounds] with n hn hBn
  have hd : 0 < d n := pos_of_mul_pos_right (hc.trans_le hBn.1) hn.le
  rw [Real.log_mul hn.ne' hd.ne', ← sub_div]
  congr 1
  ring

theorem normalized_deficit_rate_of_positive_limit {d S : ℕ → ℝ} {r A : ℝ}
    (hS : ∀ᶠ n in atTop, 0 < S n)
    (hRate : Tendsto (fun n => Real.log (S n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 r))
    (hA : 0 < A) (hLim : Tendsto (fun n => S n * d n) atTop (𝓝 A)) :
    Tendsto (fun n => -Real.log (d n) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 r) := by
  have hLow : 0 < A / 2 := div_pos hA (by norm_num)
  apply normalized_deficit_rate_of_scale hS hRate hLow (C := 2 * A)
  exact hLim.eventually (Icc_mem_nhds (by linarith only [hA]) (by linarith only [hA]))

theorem log_block_scale_rate (r : ℝ) :
    Tendsto (fun n : ℕ => Real.log (blockScale r (n + 1)) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 r) := by
  have h := successor_real_log_div_tendsto.const_mul (1 / 2 : ℝ)
  rw [mul_zero] at h
  have h' := h.add (show Tendsto (fun _ : ℕ => r) atTop (𝓝 r) from tendsto_const_nhds)
  rw [zero_add] at h'
  apply h'.congr
  intro n
  let N : ℝ := ((n + 1 : ℕ) : ℝ)
  have hN : 0 < N := by unfold N; exact_mod_cast Nat.succ_pos n
  change 1 / 2 * (Real.log N / N) + r = Real.log (Real.sqrt N * Real.exp (N * r)) / N
  rw [Real.log_mul (Real.sqrt_pos.2 hN).ne' (Real.exp_pos _).ne', Real.log_sqrt hN.le,
    Real.log_exp, add_div, mul_div_cancel_left₀ _ hN.ne']
  ring

theorem log_pure_order_rate (r : ℝ) :
    Tendsto (fun n : ℕ => Real.log (orderAtRate r (n + 1)) / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 r) := by
  apply (show Tendsto (fun _ : ℕ => r) atTop (𝓝 r) from tendsto_const_nhds).congr
  intro n
  have hN : 0 < ((n + 1 : ℕ) : ℝ) := by exact_mod_cast Nat.succ_pos n
  rw [orderAtRate, Real.log_exp, mul_div_cancel_left₀ _ hN.ne']

variable {κ : Type*} [Fintype κ]

theorem fixed_block_order_first_saturation (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q)
    (n : ℕ) (hn : 0 < n) {M : ℝ} (hM₀ : 0 ≤ M) (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hAtom : 0 < endpointAtomMass p q M) :
    Tendsto (fun b : ℝ => sInf (productDeficitValues p q n b)) atTop (𝓝 (endpointEpsilon M n)) := by
  let e := endpointEpsilon M n
  let D (b : ℝ) := sInf (productDeficitValues p q n b)
  have he : 0 < e := Real.exp_pos _
  have he₁ : e ≤ 1 := by
    unfold e endpointEpsilon
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr
      (mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (Nat.cast_nonneg n)) hM₀)
  apply Metric.tendsto_nhds.2
  intro δ hδ
  let a := δ / 2
  have ha : 0 < a := div_pos hδ (by norm_num)
  have hL : 0 < Real.log (1 + a) := Real.log_pos (lt_add_of_pos_right _ ha)
  let C := (n : ℝ) * endpointLogRate p q M / Real.log (1 + a)
  have hR : Real.log (1 + a * e) / Real.log (1 + a) ≤ e * (1 + a) := by
    have hAe : 0 ≤ a * e := mul_nonneg ha.le he.le
    have h := div_le_div_of_nonneg_right (log_one_add_bounds hAe).2 hL.le
    apply h.trans
    apply (div_le_iff₀ hL).2
    have hB := mul_le_mul_of_nonneg_left (log_one_add_bounds ha.le).1
      (mul_nonneg he.le (by positivity : 0 ≤ 1 + a))
    have hA : e * (1 + a) * (a / (1 + a)) = a * e := by
      field_simp [(by positivity : 0 < 1 + a).ne']
      ring
    rwa [hA] at hB
  have hInv : Tendsto (fun b : ℝ => C * b⁻¹) atTop (𝓝 0) := by
    have h : Tendsto (fun b : ℝ => b⁻¹) atTop (𝓝 0) := tendsto_inv_atTop_zero
    simpa only [mul_zero] using h.const_mul C
  filter_upwards [eventually_gt_atTop (0 : ℝ), hInv.eventually (gt_mem_nhds ha)] with b hb hm
  obtain ⟨aStar, haStar, hMin⟩ := product_deficit_attained p q hp hq hne hn b hb
  have hMinE := hMin.csInf_eq
  have hLow : e ≤ D b := by
    unfold D
    rw [hMinE]
    exact (product_deficit_endpoint_sandwich p q hp hq hM₀ hM hAtom haStar hb n).1
  have hDA : D b ≤ productScalarDeficit p q n b a := by
    unfold D
    rw [hMinE]
    exact hMin.2 ⟨a, ha, rfl⟩
  have hU := hDA.trans (product_deficit_endpoint_sandwich p q hp hq hM₀ hM hAtom ha hb n).2
  have hEq : (((n : ℝ) * endpointLogRate p q M + b * Real.log (1 + a * e)) /
      (b * Real.log (1 + a))) =
      C * b⁻¹ + Real.log (1 + a * e) / Real.log (1 + a) := by
    unfold C
    field_simp [hb.ne', hL.ne']
    ring
  change D b ≤ _ at hU
  rw [hEq] at hU
  have hAbs : |D b - e| = D b - e := abs_of_nonneg (sub_nonneg.mpr hLow)
  rw [Real.dist_eq, hAbs]
  have hA := mul_le_mul_of_nonneg_right he₁ ha.le
  change C * b⁻¹ < δ / 2 at hm
  have hR' : Real.log (1 + a * e) / Real.log (1 + a) ≤ e + δ / 2 := by
    have hA' : e * a ≤ δ / 2 := hA.trans_eq (one_mul _)
    nlinarith only [hR, hA']
  linarith only [hU, hR', hm]

end RenyiProductOrderPhase
