import CumulantTilt
import ProductCoefficient

/-! Exact tilted product deficits and uniform real-order kernel bounds. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

noncomputable def kernelGap (b z : ℝ) : ℝ := 1 - (1 + z) ^ (-b)

noncomputable def normalizedGap (b z : ℝ) : ℝ := kernelGap b (z / b)

theorem log_one_add_bounds {z : ℝ} (hz : 0 ≤ z) :
    z / (1 + z) ≤ Real.log (1 + z) ∧ Real.log (1 + z) ≤ z := by
  have hd : 0 < 1 + z := by linarith
  have he : 1 - (1 + z)⁻¹ = z / (1 + z) := by
    field_simp [hd.ne']
  constructor
  · rw [← he]
    exact Real.one_sub_inv_le_log_of_pos hd
  · simpa only [add_sub_cancel_left] using Real.log_le_sub_one_of_pos hd

theorem kernel_gap_bounds {b z : ℝ} (hb : 1 ≤ b) (hz : 0 ≤ z) :
    z / (1 + z) ≤ kernelGap b z ∧ kernelGap b z ≤ b * z ∧ kernelGap b z < 1 := by
  have hd : 0 < 1 + z := by linarith
  have hp : 0 < (1 + z) ^ (-b) := Real.rpow_pos_of_pos hd _
  have he : 1 - (1 + z)⁻¹ = z / (1 + z) := by
    field_simp [hd.ne']
  have hdown : (1 + z) ^ (-b) ≤ (1 + z)⁻¹ := by
    rw [← Real.rpow_neg_one]
    exact Real.rpow_le_rpow_of_exponent_le (by linarith) (by linarith)
  have hle : z / (1 + z) ≤ z := (div_le_iff₀ hd).2 (by nlinarith [sq_nonneg z])
  have hbase : 1 + -(z / (1 + z)) = (1 + z)⁻¹ := by
    rw [← sub_eq_add_neg, ← he]
    ring
  have hpre : -1 ≤ -(z / (1 + z)) := by
    have h : z / (1 + z) ≤ 1 := (div_le_iff₀ hd).2 (by linarith)
    linarith
  have ht := one_add_mul_self_le_rpow_one_add hpre hb
  rw [hbase, Real.inv_rpow hd.le, ← Real.rpow_neg hd.le] at ht
  have hbz := mul_le_mul_of_nonneg_left hle (by linarith : 0 ≤ b)
  unfold kernelGap
  refine ⟨?_, ?_, by linarith⟩
  · linarith only [hdown, he]
  · linarith only [ht, hbz]

theorem normalized_gap_bounds {b z : ℝ} (hb : 1 ≤ b) (hz : 0 ≤ z) :
    z / (1 + z) ≤ normalizedGap b z ∧ normalizedGap b z ≤ min z 1 := by
  have hb' : 0 < b := by linarith
  have hw := div_nonneg hz hb'.le
  have hpos : 0 < 1 + z := by linarith
  have hpos' : 0 < 1 + z / b := by linarith
  have hmul : b * (z / b) = z := mul_div_cancel₀ z hb'.ne'
  have hg := kernel_gap_bounds hb hw
  have hBern := one_add_mul_self_le_rpow_one_add
    (show -1 ≤ z / b by linarith) hb
  rw [hmul] at hBern
  have hPow : 0 < (1 + z / b) ^ b := Real.rpow_pos_of_pos hpos' _
  have hInv := (inv_le_inv₀ hPow hpos).2 hBern
  rw [← Real.rpow_neg hpos'.le] at hInv
  have he : 1 - (1 + z)⁻¹ = z / (1 + z) := by
    field_simp [hpos.ne']
  refine ⟨?_, le_min ?_ hg.2.2.le⟩
  · unfold normalizedGap kernelGap
    linarith only [hInv, he]
  · simpa only [normalizedGap, hmul] using hg.2.1

theorem half_min_le_ratio {z : ℝ} (hz : 0 ≤ z) : min z 1 / 2 ≤ z / (1 + z) := by
  apply (le_div_iff₀ (by linarith : 0 < 1 + z)).2
  rcases le_or_gt z 1 with h | h
  · rw [min_eq_left h]
    nlinarith only [mul_nonneg hz (sub_nonneg.mpr h)]
  · rw [min_eq_right h.le]
    linarith

theorem normalized_gap_half_min {b z : ℝ} (hb : 1 ≤ b) (hz : 0 ≤ z) :
    min z 1 / 2 ≤ normalizedGap b z :=
  (half_min_le_ratio hz).trans (normalized_gap_bounds hb hz).1

theorem normalized_gap_exp_error {b z : ℝ} (hb : 1 ≤ b) (hz : 0 ≤ z) :
    0 ≤ (1 - Real.exp (-z)) - normalizedGap b z ∧
      (1 - Real.exp (-z)) - normalizedGap b z ≤ z ^ 2 / b := by
  have hb' : 0 < b := by linarith
  have hw := div_nonneg hz hb'.le
  have hd : 0 < 1 + z / b := by linarith
  let L := b * Real.log (1 + z / b)
  have hm : b * (z / b) = z := mul_div_cancel₀ z hb'.ne'
  have hL₁ : z / (1 + z / b) ≤ L := by
    have h := mul_le_mul_of_nonneg_left (log_one_add_bounds hw).1 hb'.le
    rwa [← mul_div_assoc, hm] at h
  have hL₀ : 0 ≤ L := (div_nonneg hz hd.le).trans hL₁
  have hLu : L ≤ z := by
    have h := mul_le_mul_of_nonneg_left (log_one_add_bounds hw).2 hb'.le
    rwa [hm] at h
  have hdiff : z - L ≤ z ^ 2 / b := by
    have hEq : z - z / (1 + z / b) = (z ^ 2 / b) / (1 + z / b) := by
      field_simp [hb'.ne', hd.ne']
      ring
    apply (sub_le_sub_left hL₁ z).trans
    rw [hEq]
    exact (div_le_iff₀ hd).2 (le_mul_of_one_le_right
      (div_nonneg (sq_nonneg z) hb'.le) (by linarith))
  have hA : Real.exp (-L) ≤ 1 := by
    simpa only [Real.exp_zero] using Real.exp_le_exp.2 (neg_nonpos.mpr hL₀)
  have hB : 1 - Real.exp (L - z) ≤ z - L := by
    linarith only [Real.add_one_le_exp (L - z)]
  have hgap : (1 - Real.exp (-z)) - normalizedGap b z = Real.exp (-L) - Real.exp (-z) := by
    unfold normalizedGap kernelGap L
    rw [Real.rpow_def_of_pos hd]
    ring_nf
  rw [hgap]
  refine ⟨sub_nonneg.mpr (Real.exp_le_exp.2 (neg_le_neg hLu)), ?_⟩
  apply le_trans _ hdiff
  have hEq : Real.exp (-L) - Real.exp (-z) = Real.exp (-L) * (1 - Real.exp (L - z)) := by
    rw [mul_sub, mul_one, ← Real.exp_add]
    congr 2
    ring
  rw [hEq]
  exact (mul_le_mul_of_nonneg_left hB (Real.exp_nonneg _)).trans
    (mul_le_of_le_one_left (sub_nonneg.mpr hLu) hA)

theorem neg_log_one_sub_bounds {u : ℝ} (h₁ : u < 1) :
    u ≤ -Real.log (1 - u) ∧ -Real.log (1 - u) ≤ u / (1 - u) := by
  have h := sub_pos.mpr h₁
  have hEq : (1 - u)⁻¹ - 1 = u / (1 - u) := by
    field_simp [h.ne']
  constructor
  · linarith only [Real.log_le_sub_one_of_pos h]
  · linarith only [Real.one_sub_inv_le_log_of_pos h, hEq]

variable {κ : Type*} [Fintype κ]

noncomputable def productMissing (p q : FiniteMass κ) (n : ℕ) (b a : ℝ) : ℝ :=
  1 - productScalarMoment p q n b a

noncomputable def tiltedKernel (b a θ s : ℝ) : ℝ :=
  Real.exp (-(θ * s)) * kernelGap b (a * Real.exp s)

noncomputable def growingTiltedKernel (b a θ s : ℝ) : ℝ :=
  Real.exp (-(θ * s)) * normalizedGap b (a * Real.exp s)

theorem product_missing_tilt (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) (n : ℕ) (b a θ : ℝ) :
    productMissing p q n b a = (tiltNormalizer p q θ) ^ n *
      (FiniteMass.tensor (fun _ : Fin n => tiltedMass p q θ)).expect
        (fun x => tiltedKernel b a θ (likelihoodSum p q x)) := by
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  have h : productMissing p q n b a = P.expect
      (fun x => kernelGap b (a * Real.exp (likelihoodSum p q x))) := by
    unfold productMissing productScalarMoment kernelGap
    simp_rw [exp_likelihood_sum p q hp hq]
    change 1 - P.expect (fun x => (1 + a * likelihoodProduct p q x) ^ (-b)) =
      P.expect (fun x => 1 - (1 + a * likelihoodProduct p q x) ^ (-b))
    have hOne := P.expect_const 1
    unfold FiniteMass.expect at hOne ⊢
    simp only [mul_sub, Finset.sum_sub_distrib]
    rw [hOne]
  rw [h, tensor_expect_remove_tilt]
  rfl

theorem product_missing_centered_tilt (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) (n : ℕ) (a θ r : ℝ) :
    productMissing p q n (Real.exp ((n : ℝ) * r)) a =
      Real.exp ((n : ℝ) * (logCumulant p q θ + θ * r)) *
        (FiniteMass.tensor (fun _ : Fin n => tiltedMass p q θ)).expect
          (fun x => growingTiltedKernel (Real.exp ((n : ℝ) * r)) a θ
            (likelihoodSum p q x + (n : ℝ) * r)) := by
  let Q := FiniteMass.tensor (fun _ : Fin n => tiltedMass p q θ)
  let B := Real.exp ((n : ℝ) * r)
  let k := (n : ℝ) * (θ * r)
  let g (x : Fin n → κ) := tiltedKernel B a θ (likelihoodSum p q x)
  have hA : (tiltNormalizer p q θ) ^ n =
      Real.exp ((n : ℝ) * logCumulant p q θ) := by
    rw [Real.exp_nat_mul, logCumulant, Real.exp_log (tilt_normalizer_pos p q θ)]
  have hFactor (x : Fin n → κ) : g x = Real.exp k *
      growingTiltedKernel B a θ (likelihoodSum p q x + (n : ℝ) * r) := by
    unfold g tiltedKernel growingTiltedKernel normalizedGap
    rw [Real.exp_add]
    have he : a * (Real.exp (likelihoodSum p q x) * Real.exp ((n : ℝ) * r)) / B =
        a * Real.exp (likelihoodSum p q x) := by
      unfold B
      rw [← mul_assoc, mul_div_cancel_right₀ _ (Real.exp_pos _).ne']
    rw [he, ← mul_assoc, ← Real.exp_add]
    congr 2
    unfold k
    ring
  rw [product_missing_tilt p q hp hq, hA]
  change Real.exp ((n : ℝ) * logCumulant p q θ) * Q.expect g = _
  rw [congrArg Q.expect (funext hFactor)]
  have hPull (f : (Fin n → κ) → ℝ) : Q.expect (fun x => Real.exp k * f x) =
      Real.exp k * Q.expect f := by
    unfold FiniteMass.expect
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl (fun x _ => by ring)
  rw [hPull, ← mul_assoc, ← Real.exp_add]
  congr 2
  unfold k
  ring

end RenyiProductOrderPhase
