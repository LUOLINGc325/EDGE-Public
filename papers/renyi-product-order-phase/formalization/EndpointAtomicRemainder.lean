import EndpointSupportGap
import SoftThresholdBounds
import NegativeLogPriorShape

/-! A uniform atom-dominance estimate for the maximum-likelihood endpoint. -/

open scoped BigOperators Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem endpoint_relative_moment_upper (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) {M d a : ℝ}
    (hM : ∀ i, -M ≤ logLikelihood p q i)
    (hGap : ∀ i, logLikelihood p q i = -M ∨ d ≤ logLikelihood p q i + M)
    (n : ℕ) (ha : 0 < a) (haB : a ≤ Real.exp ((n : ℝ) * M)) :
    let b := Real.exp ((n : ℝ) * M)
    let m := endpointAtomMass p q M
    productScalarMoment p q n b a ≤
      (1 + a / b) ^ (-b) * ((m + (1 - m) * Real.exp (-(a / 4) * d)) ^ n +
        Real.exp (-(b * Real.log 2))) := by
  let b := Real.exp ((n : ℝ) * M)
  let m := endpointAtomMass p q M
  let W (i : κ) := logLikelihood p q i + M
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let A (z : Fin n → κ) := iidSum W z
  let F (z : Fin n → κ) := (1 + a * likelihoodProduct p q z) ^ (-b)
  let c := (1 + a / b) ^ (-b)
  let f (z : Fin n → κ) := Real.exp (-(a / 4) * A z)
  let E := Real.exp (-(b * Real.log 2))
  have hb : 0 < b := Real.exp_pos _
  have hba : 0 < b + a := add_pos hb ha
  have hC : 0 < 1 + a / b := add_pos_of_pos_of_nonneg zero_lt_one (div_nonneg ha.le hb.le)
  have hA (z : Fin n → κ) : 0 ≤ A z := by
    unfold A iidSum W
    exact Finset.sum_nonneg (fun j _ => by linarith only [hM (z j)])
  have hK (z : Fin n → κ) : F z ≤ c * (f z + E) := by
    let Z := b * a * (Real.exp (A z) - 1) / (b + a)
    have hE : 0 ≤ Real.exp (A z) - 1 := by
      have h := Real.exp_le_exp.mpr (hA z)
      rwa [Real.exp_zero, ← sub_nonneg] at h
    have hZ₀ : 0 ≤ Z := div_nonneg (mul_nonneg (mul_nonneg hb.le ha.le) hE) hba.le
    have hZ : a / 2 * A z ≤ Z := by
      have hh : b + a ≤ 2 * b := by
        have h := haB
        change a ≤ b at h
        linarith only [h]
      have hExp : A z ≤ Real.exp (A z) - 1 := by linarith only [Real.add_one_le_exp (A z)]
      have hZ₂ : a / 2 * A z * (b + a) ≤ b * a * (Real.exp (A z) - 1) := by
        calc
          _ ≤ a / 2 * A z * (2 * b) :=
            mul_le_mul_of_nonneg_left hh (mul_nonneg (div_nonneg ha.le (by norm_num)) (hA z))
          _ = b * a * A z := by ring
          _ ≤ _ := mul_le_mul_of_nonneg_left hExp (mul_nonneg hb.le ha.le)
      exact (le_div_iff₀ hba).2 hZ₂
    have hAB : Real.exp (A z) = b * likelihoodProduct p q z := by
      unfold A W b
      rw [iid_sum_shift]
      change Real.exp (likelihoodSum p q z + (n : ℝ) * M) = _
      rw [Real.exp_add, exp_likelihood_sum p q hp hq, mul_comm]
    have hMul : 1 + a * likelihoodProduct p q z = (1 + a / b) * (1 + Z / b) := by
      unfold Z
      rw [hAB]
      field_simp [hb.ne', hba.ne']
      ring
    have hZ₁ : 0 ≤ 1 + Z / b :=
      add_nonneg zero_le_one (div_nonneg hZ₀ hb.le)
    unfold F
    rw [hMul, Real.mul_rpow hC.le hZ₁]
    apply mul_le_mul_of_nonneg_left _ (Real.rpow_nonneg hC.le _)
    apply (soft_threshold_large_input hb hZ₀).trans
    have hHalf : (a / 4) * A z ≤ Z / 2 := by linarith only [hZ]
    rcases le_or_gt (Z / 2) (b * Real.log 2) with h | h
    · rw [min_eq_left h]
      exact (Real.exp_le_exp.mpr (by linarith only [hHalf])).trans
        (le_add_of_nonneg_right (Real.exp_nonneg _))
    · rw [min_eq_right h.le]
      exact le_add_of_nonneg_left (Real.exp_nonneg _)
  have h := P.expect_mono hK
  rw [FiniteMass.expect_scale_function, FiniteMass.expect_add_functions, FiniteMass.expect_const] at h
  change productScalarMoment p q n b a ≤ c * (P.expect f + E) at h
  have hF : P.expect f = (p.expect (fun i => Real.exp (-(a / 4) * W i))) ^ n := by
    have he : f = fun z => ∏ j, Real.exp (-(a / 4) * W (z j)) := by
      funext z
      unfold f A iidSum
      rw [Finset.mul_sum, Real.exp_sum]
    rw [he]
    unfold P
    rw [FiniteMass.expect_tensor_product (fun _ : Fin n => p)
      (fun _ i => Real.exp (-(a / 4) * W i))]
    simp only [Finset.prod_const, Finset.card_univ, Fintype.card_fin]
  rw [hF] at h
  have hOne : 0 ≤ p.expect (fun i => Real.exp (-(a / 4) * W i)) :=
    p.expect_nonneg (fun _ => Real.exp_nonneg _)
  have hpw := pow_le_pow_left₀ hOne
    (minimum_shifted_exponential_upper p q hGap (div_nonneg ha.le (by norm_num : (0 : ℝ) ≤ 4))) n
  exact h.trans (mul_le_mul_of_nonneg_left (add_le_add_right hpw E) (Real.rpow_nonneg hC.le _))

end RenyiProductOrderPhase
