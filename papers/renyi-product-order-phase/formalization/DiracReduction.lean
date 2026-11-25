import BinaryLowerOrder
import TwoPointReduction

/-! From the finite binary endpoint theorem to the unrestricted moment bound. -/

open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem binary_endpoint_domination (q : FiniteMass Bool) (hq : ∀ i, 0 < q i)
    (w : Bool → FiniteMass κ) (hw : ∀ i y, 0 < w i y) (c Q : ℝ)
    (hc : c ∈ Icc (0 : ℝ) 1) (hQ : 2 ≤ Q)
    (hEnds : ∀ i : Bool, outputPower q w hw (binaryDensity q (if i then 0 else 1)) Q ≤
      inputPower q (binaryDensity q (if i then 0 else 1)) Q ^ c)
    (f : Bool → ℝ) (hf : ∀ i, 0 ≤ f i) (hfm : q.expect f = 1) :
    outputPower q w hw f Q ≤ inputPower q f Q ^ c := by
  have hQ' : 1 < Q := by linarith
  have hA := zero_lt_one.trans_le (input_power_ge_one q f hf hfm hQ'.le)
  have hB := zero_lt_one.trans_le (output_power_ge_one q w hw f hf hfm hQ'.le)
  have he := log_power_gap_le_iff q w hw f Q c 0 hA hB
  rw [Real.exp_zero, one_mul] at he
  apply he.mp
  by_contra! hbad
  obtain ⟨v, hv, hvf⟩ := every_binary_density q hq f hf hfm
  have hBad : ∃ z ∈ Icc (0 : ℝ) 1, 0 < logPowerGap q w hw c Q (binaryDensity q z) :=
    ⟨v, hv, hvf ▸ hbad⟩
  obtain ⟨r, hr, z, hz, _, H⟩ := binary_positive_maximum q hq w hw c Q hQ' hEnds hBad
  let g := binaryDensity q z
  have hg := binary_density_positive q hq hz
  have hgm := binary_density_mean q hq z
  rcases le_or_gt 2 r with h₂ | h₂
  · exact higher_order_maximum_impossible q hq w hw c r hc h₂ g hg hgm
      (fun u hu hm => (H r ⟨hr.1.le, hr.2⟩ u hu hm).1)
      ((H (r - 1) ⟨by linarith only [h₂], by linarith only [hr.2]⟩ g
        (fun i => (hg i).le) hgm).2 (by linarith))
  · exact lower_order_maximum_impossible q hq w hw c r Q hc ⟨hr.1, h₂⟩ hQ g hg hgm H

variable {ι : Type*} [Fintype ι]

theorem pushed_moment_of_density (p q : FiniteMass ι) (f : ι → ℝ)
    (hf : ∀ i, p i = q i * f i) (b : ℝ) (hb : 0 < b)
    (w : ι → FiniteMass κ) (hw : ∀ i y, 0 < w i y) :
    renyiMoment b (p.push w) (q.push w) = outputPower q w hw f (b + 1) := by
  rw [renyi_moment_reference b hb _ _
    (FiniteMass.absolutelyContinuous_of_pos _ _ (q.push_pos w hw))]
  unfold outputPower
  simp only [FiniteMass.conditional_mean_shared_density p q w hw f hf]

theorem two_point_moment_formula (b : ℝ) {i j : ι} (hij : i ≠ j)
    (s t : ℝ) (hs : s ∈ Icc (0 : ℝ) 1) (ht : t ∈ Icc (0 : ℝ) 1) :
    renyiMoment b (FiniteMass.mix (FiniteMass.dirac i) (FiniteMass.dirac j) s hs)
      (FiniteMass.mix (FiniteMass.dirac i) (FiniteMass.dirac j) t ht) =
        s * (s / t) ^ b + (1 - s) * ((1 - s) / (1 - t)) ^ b := by
  unfold renyiMoment
  rw [FiniteMass.mix_expect, FiniteMass.dirac_expect, FiniteMass.dirac_expect]
  simp [hij, Ne.symm hij]

namespace FiniteMass

theorem reverse_mixture (p q : FiniteMass ι) (t : ℝ) (ht : t ∈ Icc (0 : ℝ) 1)
    (ht' : 1 - t ∈ Icc (0 : ℝ) 1) : mix q p (1 - t) ht' = mix p q t ht := by
  ext i
  simp only [mix_apply]
  ring

theorem mix_zero (p q : FiniteMass ι) (h : 0 ∈ Icc (0 : ℝ) 1) : mix p q 0 h = q := by
  ext i
  simp

theorem mix_one (p q : FiniteMass ι) (h : 1 ∈ Icc (0 : ℝ) 1) : mix p q 1 h = p := by
  ext i
  simp

end FiniteMass

noncomputable def binaryMass (s : ℝ) (hs : s ∈ Icc (0 : ℝ) 1) : FiniteMass Bool :=
  FiniteMass.mix (FiniteMass.dirac false) (FiniteMass.dirac true) s hs

@[simp] theorem binary_mass_false (s : ℝ) (hs : s ∈ Icc (0 : ℝ) 1) : binaryMass s hs false = s := by
  simp [binaryMass]

@[simp] theorem binary_mass_true (s : ℝ) (hs : s ∈ Icc (0 : ℝ) 1) :
    binaryMass s hs true = 1 - s := by
  simp [binaryMass]

theorem binary_mass_density (s t : ℝ) (hs : s ∈ Icc (0 : ℝ) 1) (ht : t ∈ Icc (0 : ℝ) 1)
    (h₀ : 0 < t) (h₁ : t < 1) (i : Bool) :
    binaryMass s hs i = binaryMass t ht i * binaryDensity (binaryMass t ht) s i := by
  cases i
  · simpa [binaryDensity] using (mul_div_cancel₀ s h₀.ne').symm
  · simpa [binaryDensity] using (mul_div_cancel₀ (1 - s) (sub_pos.mpr h₁).ne').symm

def DiracMomentBound (w : ι → FiniteMass κ) (b c : ℝ) : Prop :=
  ∀ i j : ι, i ≠ j → ∀ (t : ℝ) (ht : t ∈ Icc (0 : ℝ) 1), 0 < t → t < 1 →
    let p := FiniteMass.dirac i
    let q := FiniteMass.mix p (FiniteMass.dirac j) t ht
    renyiMoment b (p.push w) (q.push w) ≤ renyiMoment b p q ^ c

theorem two_point_bound_from_dirac (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (b c : ℝ) (hb : 1 ≤ b)
    (hc : c ∈ Icc (0 : ℝ) 1) (hD : DiracMomentBound w b c) :
    TwoPointMomentBound w b c := by
  intro i j hij s t hs ht ht₀ ht₁
  let p (z : ℝ) (hz : z ∈ Icc (0 : ℝ) 1) := FiniteMass.mix
    (FiniteMass.dirac i) (FiniteMass.dirac j) z hz
  let W (a : Bool) := if a then w j else w i
  let q := binaryMass t ht
  have hb₀ : 0 < b := zero_lt_one.trans_le hb
  have hQ : 2 ≤ b + 1 := by linarith
  have hq (a : Bool) : 0 < q a := by
    cases a
    · exact ht₀.trans_eq (binary_mass_false t ht).symm
    · exact (sub_pos.mpr ht₁).trans_eq (binary_mass_true t ht).symm
  have hW (a : Bool) (y : κ) : 0 < W a y := by
    cases a
    · exact hw i y
    · exact hw j y
  have hPush (z : ℝ) (hz : z ∈ Icc (0 : ℝ) 1) :
      (binaryMass z hz).push W = (p z hz).push w := by
    unfold binaryMass p
    rw [FiniteMass.push_mix, FiniteMass.push_mix, FiniteMass.push_dirac,
      FiniteMass.push_dirac, FiniteMass.push_dirac, FiniteMass.push_dirac]
    rfl
  have hIn (z : ℝ) (hz : z ∈ Icc (0 : ℝ) 1) :
      inputPower q (binaryDensity q z) (b + 1) = renyiMoment b (p z hz) (p t ht) := by
    calc
      _ = renyiMoment b (binaryMass z hz) q :=
        (renyi_moment_shared_density b hb₀ _ _ _ (binary_mass_density z t hz ht ht₀ ht₁)).symm
      _ = _ := by
        dsimp only [q, p, binaryMass]
        rw [two_point_moment_formula b (by decide : false ≠ true), two_point_moment_formula b hij]
  have hOut (z : ℝ) (hz : z ∈ Icc (0 : ℝ) 1) :
      outputPower q W hW (binaryDensity q z) (b + 1) =
        renyiMoment b ((p z hz).push w) ((p t ht).push w) := by
    rw [← pushed_moment_of_density (binaryMass z hz) q _ (binary_mass_density z t hz ht ht₀ ht₁)
      b hb₀ W hW, hPush z hz]
    change renyiMoment b ((p z hz).push w) ((binaryMass t ht).push W) = _
    rw [hPush t ht]
  have hEnd (a : Bool) :
      outputPower q W hW (binaryDensity q (if a then 0 else 1)) (b + 1) ≤
        inputPower q (binaryDensity q (if a then 0 else 1)) (b + 1) ^ c := by
    cases a
    · change outputPower q W hW (binaryDensity q 1) (b + 1) ≤
        inputPower q (binaryDensity q 1) (b + 1) ^ c
      have ht' : (1 : ℝ) ∈ Icc (0 : ℝ) 1 := ⟨zero_le_one, le_rfl⟩
      rw [hOut 1 ht', hIn 1 ht']
      have hp : p 1 ht' = FiniteMass.dirac i := FiniteMass.mix_one _ _ ht'
      rw [hp]
      exact hD i j hij t ht ht₀ ht₁
    · change outputPower q W hW (binaryDensity q 0) (b + 1) ≤
        inputPower q (binaryDensity q 0) (b + 1) ^ c
      have h₀ : (0 : ℝ) ∈ Icc (0 : ℝ) 1 := ⟨le_rfl, zero_le_one⟩
      rw [hOut 0 h₀, hIn 0 h₀]
      have ht' : 1 - t ∈ Icc (0 : ℝ) 1 :=
        ⟨sub_nonneg.mpr ht.2, by linarith only [ht.1]⟩
      have hp : p 0 h₀ = FiniteMass.dirac j := FiniteMass.mix_zero _ _ h₀
      have hq' : FiniteMass.mix (FiniteMass.dirac j) (FiniteMass.dirac i) (1 - t) ht' = p t ht :=
        FiniteMass.reverse_mixture _ _ _ ht ht'
      rw [hp, ← hq']
      exact hD j i hij.symm (1 - t) ht' (sub_pos.mpr ht₁) (by linarith only [ht₀])
  have he := binary_endpoint_domination q hq W hW c (b + 1) hc hQ hEnd
    (binaryDensity q s) (binary_density_nonneg q hs) (binary_density_mean q hq s)
  rw [hOut s hs, hIn s hs] at he
  exact he

theorem moment_bound_from_dirac (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (b c : ℝ) (hb : 1 ≤ b)
    (hc : c ∈ Icc (0 : ℝ) 1) (hD : DiracMomentBound w b c)
    (p q : FiniteMass ι) (hac : p.AbsolutelyContinuous q) :
    renyiMoment b (p.push w) (q.push w) ≤ renyiMoment b p q ^ c :=
  moment_bound_from_two_points w hw b (zero_lt_one.trans_le hb) c hc
    (two_point_bound_from_dirac w hw b c hb hc hD) p q hac

end RenyiProductOrderPhase
