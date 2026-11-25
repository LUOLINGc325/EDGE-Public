import BinaryUpperOrder

/-! The least-order argument in the interval strictly between one and two. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

namespace FiniteMass

variable {ι : Type*} [Fintype ι]

theorem expect_div (p : FiniteMass ι) (f : ι → ℝ) (C : ℝ) :
    p.expect (fun i => f i / C) = p.expect f / C := by
  unfold expect
  simp only [← mul_div_assoc, Finset.sum_div]

end FiniteMass

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

theorem input_power_div (q : FiniteMass ι) (f : ι → ℝ) (hf : ∀ i, 0 ≤ f i)
    {C : ℝ} (hC : 0 ≤ C) (a : ℝ) :
    inputPower q (fun i => f i / C) a = inputPower q f a / C ^ a := by
  have h (i : ι) : (f i / C) ^ a = f i ^ a / C ^ a := Real.div_rpow (hf i) hC a
  unfold inputPower
  simp only [h, FiniteMass.expect_div]

theorem output_power_div (q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (f : ι → ℝ) (hf : ∀ i, 0 ≤ f i)
    {C : ℝ} (hC : 0 ≤ C) (a : ℝ) :
    outputPower q w hw (fun i => f i / C) a = outputPower q w hw f a / C ^ a := by
  have he (y : κ) :
      q.conditionalMean w hw (fun i => f i / C) y = q.conditionalMean w hw f y / C :=
    (q.posterior w hw y).expect_div f C
  have h (y : κ) : (q.conditionalMean w hw f y / C) ^ a =
      (q.conditionalMean w hw f y) ^ a / C ^ a :=
    Real.div_rpow (conditional_mean_nonneg q w hw f hf y) hC a
  unfold outputPower
  simp only [he, h, FiniteMass.expect_div]

theorem scaled_holder_product {E C Z b d c : ℝ} (hE : 0 < E) (hC : 0 < C)
    (hZ : 0 < Z) (hbd : b.HolderConjugate d) :
    (E * C ^ (b * (1 - c)) * Z) ^ (1 / b) * (E * Z) ^ (1 / d) =
      E * C ^ (1 - c) * Z := by
  let u := 1 / b
  let v := 1 / d
  have hs : u + v = 1 := by simpa only [u, v, one_div] using hbd.inv_add_inv_eq_one
  have hCu : (b * (1 - c)) * u = 1 - c := by
    calc
      _ = b * u * (1 - c) := by ring
      _ = _ := by rw [show b * u = 1 from mul_div_cancel₀ _ hbd.ne_zero, one_mul]
  have hpow := (Real.rpow_pos_of_pos hC (b * (1 - c))).le
  change (E * C ^ (b * (1 - c)) * Z) ^ u * (E * Z) ^ v = _
  calc
    _ = (E ^ u * E ^ v) * ((C ^ (b * (1 - c))) ^ u) * (Z ^ u * Z ^ v) := by
      rw [Real.mul_rpow (mul_nonneg hE.le hpow) hZ.le,
        Real.mul_rpow hE.le hpow, Real.mul_rpow hE.le hZ.le]
      ring
    _ = _ := by
      rw [← Real.rpow_add hE, ← Real.rpow_add hZ, hs, Real.rpow_one, Real.rpow_one,
        ← Real.rpow_mul hC.le, hCu]

theorem lower_order_maximum_impossible (q : FiniteMass Bool) (hq : ∀ i, 0 < q i)
    (w : Bool → FiniteMass κ) (hw : ∀ i y, 0 < w i y) (c r Q : ℝ)
    (hc : c ∈ Icc (0 : ℝ) 1) (hr : r ∈ Ioo (1 : ℝ) 2) (hQ : 2 ≤ Q)
    (f : Bool → ℝ) (hf : ∀ i, 0 < f i) (hfm : q.expect f = 1)
    (hmax : ∀ (a : ℝ), a ∈ Icc (1 : ℝ) Q → ∀ (g : Bool → ℝ), (∀ i, 0 ≤ g i) →
      q.expect g = 1 →
        logPowerGap q w hw c a g ≤ logPowerGap q w hw c r f ∧
          (a < r → logPowerGap q w hw c a g < logPowerGap q w hw c r f)) : False := by
  let t := r - 1
  let s := 1 - t + t ^ 2
  let a := s + t
  let b := a / s
  let d := a / t
  have ht₀ : 0 < t := sub_pos.mpr hr.1
  have ht₁ : t < 1 := by dsimp [t]; linarith only [hr.2]
  have hs₀ : 0 < s := by dsimp only [s]; nlinarith only [sq_nonneg t, ht₁]
  have hs₁ : s < 1 := by
    have h := mul_pos ht₀ (sub_pos.mpr ht₁)
    dsimp only [s]
    nlinarith only [h]
  have ha₁ : 1 < a := by dsimp only [a, s]; nlinarith only [pow_pos ht₀ 2]
  have haR : a < r := by
    change s + (r - 1) < r
    linarith only [hs₁]
  have ha₀ : 0 < a := zero_lt_one.trans ha₁
  have hb₁ : 1 < b := by
    apply (lt_div_iff₀ hs₀).2
    dsimp only [a]
    linarith only [ht₀]
  have hb₂ : b ≤ 2 := by
    apply (div_le_iff₀ hs₀).2
    dsimp only [a, s]
    nlinarith only [sq_nonneg (1 - t)]
  have hbd : b.HolderConjugate d := by
    apply Real.holderConjugate_iff.2
    refine ⟨hb₁, ?_⟩
    dsimp only [b, d]
    rw [inv_div, inv_div, ← add_div]
    exact div_self ha₀.ne'
  have hsb : s * b = a := mul_div_cancel₀ _ hs₀.ne'
  have htd : t * d = a := mul_div_cancel₀ _ ht₀.ne'
  let M := logPowerGap q w hw c r f
  let u (i : Bool) := f i ^ s
  let C := q.expect u
  let g := q.conditionalMean w hw f
  let k := q.conditionalMean w hw u
  let ρ := q.push w
  let X := inputPower q f a / inputPower q f r
  let E := Real.exp M
  let Z := inputPower q f a ^ c
  have hE : 0 < E := Real.exp_pos _
  have hA (e : ℝ) (he : 1 ≤ e) : 0 < inputPower q f e :=
    zero_lt_one.trans_le (input_power_ge_one q f (fun i => (hf i).le) hfm he)
  have hB (e : ℝ) (he : 1 ≤ e) : 0 < outputPower q w hw f e :=
    zero_lt_one.trans_le (output_power_ge_one q w hw f (fun i => (hf i).le) hfm he)
  have hZ : 0 < Z := Real.rpow_pos_of_pos (hA a ha₁.le) c
  have hX : 0 < X := div_pos (hA a ha₁.le) (hA r hr.1.le)
  have hu (i : Bool) : 0 < u i := Real.rpow_pos_of_pos (hf i) s
  have hg (y : κ) : 0 < g y :=
    conditional_mean_pos q hq w hw f (fun i => (hf i).le) hfm y
  have hk (y : κ) : 0 ≤ k y := conditional_mean_nonneg q w hw u (fun i => (hu i).le) y
  have hC : 0 < C := q.expect_pos (fun i => (hu i).le) (hq false) (hu false)
  let uN (i : Bool) := u i / C
  have huN (i : Bool) : 0 ≤ uN i := (div_pos (hu i) hC).le
  have huMean : q.expect uN = 1 := by
    change q.expect (fun i => u i / C) = 1
    rw [FiniteMass.expect_div]
    exact div_self hC.ne'
  have haM : a ∈ Icc (1 : ℝ) Q := ⟨ha₁.le, haR.le.trans (hr.2.le.trans hQ)⟩
  have hbM : b ∈ Icc (1 : ℝ) Q := ⟨hb₁.le, hb₂.trans hQ⟩
  have hSmall := (log_power_gap_lt_iff q w hw f a c M
    (hA a ha₁.le) (hB a ha₁.le)).mp
      ((hmax a haM f (fun i => (hf i).le) hfm).2 haR)
  have hWeak := (log_power_gap_le_iff q w hw uN b c M
    (zero_lt_one.trans_le (input_power_ge_one q uN huN huMean hb₁.le))
    (zero_lt_one.trans_le (output_power_ge_one q w hw uN huN huMean hb₁.le))).mp
      (hmax b hbM uN huN huMean).1
  have hUb : inputPower q u b = inputPower q f a := by
    have huPow (i : Bool) : u i ^ b = f i ^ a := by
      unfold u
      rw [← Real.rpow_mul (hf i).le, hsb]
    simp only [inputPower, huPow]
  have hUbBound : outputPower q w hw u b ≤ E * C ^ (b * (1 - c)) * Z := by
    change outputPower q w hw (fun i => u i / C) b ≤
      E * inputPower q (fun i => u i / C) b ^ c at hWeak
    rw [output_power_div q w hw u (fun i => (hu i).le) hC.le,
      input_power_div q u (fun i => (hu i).le) hC.le, hUb,
      Real.div_rpow (hA a ha₁.le).le (Real.rpow_pos_of_pos hC b).le] at hWeak
    have hShift := (div_le_iff₀ (Real.rpow_pos_of_pos hC b)).1 hWeak
    have hScale : C ^ b / (C ^ b) ^ c = C ^ (b * (1 - c)) := by
      rw [← Real.rpow_mul hC.le, ← Real.rpow_sub hC,
        show b - b * c = b * (1 - c) by ring]
    refine hShift.trans_eq ?_
    change E * (Z / (C ^ b) ^ c) * C ^ b = _
    calc
      _ = E * (C ^ b / (C ^ b) ^ c) * Z := by ring
      _ = _ := by rw [hScale]
  have hVpow (y : κ) : (g y ^ t) ^ d = g y ^ a := by
    rw [← Real.rpow_mul (hg y).le, htd]
  have hHolder :
      ρ.expect (fun y => k y * g y ^ t) ≤
        outputPower q w hw u b ^ (1 / b) * outputPower q w hw f a ^ (1 / d) := by
    have h := ρ.expect_holder hbd k (fun y => g y ^ t) hk
      (fun y => (Real.rpow_pos_of_pos (hg y) t).le)
    simp only [hVpow] at h
    exact h
  have hStrict : ρ.expect (fun y => k y * g y ^ t) < E * C ^ (1 - c) * Z := by
    have hU₀ : 0 ≤ outputPower q w hw u b :=
      ρ.expect_nonneg (fun y => Real.rpow_nonneg (hk y) b)
    have hUbPow := Real.rpow_le_rpow hU₀ hUbBound hbd.one_div_pos.le
    have hVBpow := Real.rpow_lt_rpow (hB a ha₁.le).le hSmall hbd.symm.one_div_pos
    have hComb := (mul_le_mul_of_nonneg_right hUbPow
      (Real.rpow_pos_of_pos (hB a ha₁.le) (1 / d)).le).trans_lt
        (mul_lt_mul_of_pos_left hVBpow
          (Real.rpow_pos_of_pos (mul_pos (mul_pos hE (Real.rpow_pos_of_pos hC _)) hZ) _))
    exact (hHolder.trans_lt hComb).trans_eq (scaled_holder_product hE hC hZ hbd)
  have hEq := output_power_eq_exp_gap q w hw f r c (hA r hr.1.le) (hB r hr.1.le)
  have hRatio : ρ.expect (fun y => k y * g y ^ t) / outputPower q w hw f r <
      C ^ (1 - c) * X ^ c := by
    calc
      _ < (E * C ^ (1 - c) * Z) / outputPower q w hw f r :=
        (div_lt_div_iff_of_pos_right (hB r hr.1.le)).2 hStrict
      _ = _ := by
        have he : outputPower q w hw f r = E * inputPower q f r ^ c := hEq
        unfold X
        rw [he, mul_assoc E, mul_div_mul_left _ _ hE.ne', mul_div_assoc,
          Real.div_rpow (hA a ha₁.le).le (hA r hr.1.le).le]
  have hAM : C ^ (1 - c) * X ^ c ≤ (1 - c) * C + c * X :=
    Real.geom_mean_le_arith_mean2_weighted (sub_nonneg.mpr hc.2) hc.1 hC.le hX.le (by ring)
  have hInput : q.expect (fun i => u i * f i ^ (r - 1)) = inputPower q f a := by
    have hp (i : Bool) : u i * f i ^ (r - 1) = f i ^ a := by
      change f i ^ s * f i ^ t = f i ^ a
      rw [← Real.rpow_add (hf i)]
    simp only [inputPower, hp]
  have hstat := binary_stationarity q hq w hw c r hr.1.le f hf hfm
    (fun z hz hm => (hmax r ⟨hr.1.le, hr.2.le.trans hQ⟩ z hz hm).1) u
  rw [hInput] at hstat
  change ρ.expect (fun y => k y * g y ^ t) / outputPower q w hw f r =
    (1 - c) * C + c * X at hstat
  exact (not_lt_of_ge hstat.ge) (hRatio.trans_le hAM)

end RenyiProductOrderPhase
