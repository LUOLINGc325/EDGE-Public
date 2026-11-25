import InfiniteRenyiSharpChannel

/-! Exact infinite-order saturation for a positive repeated symmetric channel. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem binary_rows_endpoint_comparison (w : BinarySymmetricChannel κ) {M : ℝ}
    (hM₀ : 0 ≤ M) (hM : ∀ z, -M ≤ logLikelihood (w.channel false) (w.channel true) z) :
    ∀ i j z, Real.exp (-M) * w.channel j z ≤ w.channel i z := by
  have hE : Real.exp (-M) ≤ 1 := by
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr (neg_nonpos.mpr hM₀)
  have hB (z : κ) : Real.exp (-M) * w.channel false z ≤ w.channel true z := by
    have h := Real.exp_le_exp.mpr (hM z)
    unfold logLikelihood at h
    rw [Real.exp_log (div_pos (w.positive true z) (w.positive false z))] at h
    exact (le_div_iff₀ (w.positive false z)).1 h
  intro i j z
  cases i <;> cases j
  · exact mul_le_of_le_one_left (w.positive false z).le hE
  · have h := hB (w.flip z)
    rw [← w.swaps z, ← w.swaps_reverse z] at h
    exact h
  · exact hB z
  · exact mul_le_of_le_one_left (w.positive true z).le hE

theorem endpoint_exp_power (M : ℝ) (n : ℕ) :
    Real.exp (-M) ^ n = endpointEpsilon M n := by
  unfold endpointEpsilon
  rw [← Real.rpow_natCast, ← Real.exp_mul, show -M * (n : ℝ) = -(n : ℝ) * M by ring]

theorem tensor_rows_endpoint_comparison (w : BinarySymmetricChannel κ) {M : ℝ}
    (hM₀ : 0 ≤ M) (hM : ∀ z, -M ≤ logLikelihood (w.channel false) (w.channel true) z) (n : ℕ) :
    ∀ i j z, endpointEpsilon M n * tensorChannel w.channel n j z ≤ tensorChannel w.channel n i z := by
  intro i j z
  have h := Finset.prod_le_prod (s := Finset.univ)
    (fun k _ => mul_nonneg (Real.exp_nonneg (-M)) (w.positive (j k) (z k)).le)
    (fun k _ => binary_rows_endpoint_comparison w hM₀ hM (i k) (j k) (z k))
  rw [Finset.prod_mul_distrib, Finset.prod_const, Finset.card_univ, Fintype.card_fin, endpoint_exp_power] at h
  exact h

theorem infinite_renyi_at_likelihood_minimum (p q : FiniteMass κ)
    (hp : ∀ z, 0 < p z) (hq : ∀ z, 0 < q z) {M : ℝ}
    (hM : ∀ z, -M ≤ logLikelihood p q z) (hAtom : ∃ z, logLikelihood p q z = -M) :
    infiniteRenyiDivergence p q = M := by
  have hBound (z : κ) : p z / q z ≤ Real.exp M := by
    have h := Real.exp_le_exp.mpr (hM z)
    unfold logLikelihood at h
    rw [Real.exp_log (div_pos (hq z) (hp z))] at h
    have h' := (inv_le_inv₀ (div_pos (hq z) (hp z)) (Real.exp_pos (-M))).2 h
    rwa [inv_div, ← Real.exp_neg, neg_neg] at h'
  obtain ⟨z, hz⟩ := hAtom
  have hEq : p z / q z = Real.exp M := by
    have h := congrArg Real.exp hz
    unfold logLikelihood at h
    rw [Real.exp_log (div_pos (hq z) (hp z))] at h
    have h' := congrArg Inv.inv h
    rwa [inv_div, ← Real.exp_neg, neg_neg] at h'
  have hMax : IsGreatest (range (fun z => p z / q z)) (Real.exp M) := by
    refine ⟨⟨z, hEq⟩, ?_⟩
    rintro v ⟨i, rfl⟩
    exact hBound i
  unfold infiniteRenyiDivergence infiniteRenyiRatio
  rw [hMax.csSup_eq, Real.log_exp]

theorem product_infinite_renyi_contraction_exact (w : BinarySymmetricChannel κ)
    {M : ℝ} (hM₀ : 0 ≤ M) (hM : ∀ z, -M ≤ logLikelihood (w.channel false) (w.channel true) z)
    (hAtom : ∃ z, logLikelihood (w.channel false) (w.channel true) z = -M)
    {n : ℕ} (hn : 0 < n) :
    1 - infiniteRenyiContractionCoefficient (tensorChannel w.channel n) = endpointEpsilon M n := by
  obtain ⟨z, hz⟩ := hAtom
  let i : Fin n → Bool := fun _ => false
  let j : Fin n → Bool := fun _ => true
  let y : Fin n → κ := fun _ => z
  have hIJ : i ≠ j := fun he => Bool.false_ne_true (congrFun he ⟨0, hn⟩)
  have hR : w.channel true z / w.channel false z = Real.exp (-M) := by
    have he := congrArg Real.exp hz
    unfold logLikelihood at he
    rwa [Real.exp_log (div_pos (w.positive true z) (w.positive false z))] at he
  have hZ : tensorChannel w.channel n j y = endpointEpsilon M n * tensorChannel w.channel n i y := by
    have hI := tensor_channel_pos w.channel w.positive i y
    apply (div_eq_iff hI.ne').1
    unfold tensorChannel
    rw [FiniteMass.tensor_ratio]
    simp only [i, j, y, hR, Finset.prod_const, Finset.card_univ, Fintype.card_fin, endpoint_exp_power]
  have he : 0 < endpointEpsilon M n := Real.exp_pos _
  have he₁ : endpointEpsilon M n ≤ 1 := by
    unfold endpointEpsilon
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr
      (mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (Nat.cast_nonneg n)) hM₀)
  rw [infinite_renyi_sharp_channel (tensorChannel w.channel n)
    (tensor_channel_pos w.channel w.positive) he he₁
    (tensor_rows_endpoint_comparison w hM₀ hM n) i j hIJ y hZ]
  ring

end RenyiProductOrderPhase
