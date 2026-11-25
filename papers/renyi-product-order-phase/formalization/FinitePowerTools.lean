import ConditionalPower
import NormalizedBlocks
import Mathlib.Analysis.MeanInequalities

/-! Weighted Hölder and power interpolation for finite probability masses. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

namespace FiniteMass

variable {ι : Type*} [Fintype ι]

theorem expect_nonneg (p : FiniteMass ι) {f : ι → ℝ} (hf : ∀ i, 0 ≤ f i) :
    0 ≤ p.expect f :=
  Finset.sum_nonneg (fun i _ => mul_nonneg (p.weight_nonneg i) (hf i))

theorem expect_holder (p : FiniteMass ι) {a b : ℝ} (hab : a.HolderConjugate b)
    (f g : ι → ℝ) (hf : ∀ i, 0 ≤ f i) (hg : ∀ i, 0 ≤ g i) :
    p.expect (fun i => f i * g i) ≤
      (p.expect (fun i => f i ^ a)) ^ (1 / a) * (p.expect (fun i => g i ^ b)) ^ (1 / b) := by
  let u (i : ι) := (p i) ^ (1 / a) * f i
  let v (i : ι) := (p i) ^ (1 / b) * g i
  have hu (i : ι) : 0 ≤ u i := mul_nonneg (Real.rpow_nonneg (p.weight_nonneg i) _) (hf i)
  have hv (i : ι) : 0 ≤ v i := mul_nonneg (Real.rpow_nonneg (p.weight_nonneg i) _) (hg i)
  have h := Real.inner_le_Lp_mul_Lq_of_nonneg (s := Finset.univ) (f := u) (g := v) hab
    (fun i _ => hu i) (fun i _ => hv i)
  have hs : 1 / a + 1 / b = 1 := by simpa only [one_div] using hab.inv_add_inv_eq_one
  have huv (i : ι) : u i * v i = p i * (f i * g i) := by
    calc
      u i * v i = ((p i) ^ (1 / a) * (p i) ^ (1 / b)) * (f i * g i) := by
        unfold u v
        ring
      _ = p i * (f i * g i) := by
        rw [← Real.rpow_add_of_nonneg (p.weight_nonneg i) hab.one_div_pos.le
          hab.symm.one_div_pos.le, hs, Real.rpow_one]
  have hUa (i : ι) : u i ^ a = p i * f i ^ a := by
    unfold u
    rw [Real.mul_rpow (Real.rpow_nonneg (p.weight_nonneg i) _) (hf i),
      ← Real.rpow_mul (p.weight_nonneg i), one_div, inv_mul_cancel₀ hab.ne_zero,
      Real.rpow_one]
  have hVb (i : ι) : v i ^ b = p i * g i ^ b := by
    unfold v
    rw [Real.mul_rpow (Real.rpow_nonneg (p.weight_nonneg i) _) (hg i),
      ← Real.rpow_mul (p.weight_nonneg i), one_div, inv_mul_cancel₀ hab.symm.ne_zero,
      Real.rpow_one]
  simpa only [huv, hUa, hVb, expect] using h

theorem expect_power_ge_one (p : FiniteMass ι) (f : ι → ℝ) (hf : ∀ i, 0 ≤ f i)
    (hm : p.expect f = 1) {a : ℝ} (ha : 1 ≤ a) :
    1 ≤ p.expect (fun i => f i ^ a) := by
  have h := p.expect_rpow_le hf ha
  rwa [hm, Real.one_rpow] at h

theorem tilted_power (p : FiniteMass ι) (f : ι → ℝ) (hf : ∀ i, 0 < f i)
    (hm : p.expect f = 1) (a : ℝ) :
    (p.densityChange f (fun i => (hf i).le) hm).expect (fun i => f i ^ (a - 1)) =
      p.expect (fun i => f i ^ a) := by
  unfold expect
  refine Finset.sum_congr rfl fun i _ => ?_
  change p i * f i * f i ^ (a - 1) = p i * f i ^ a
  calc
    _ = p i * (f i ^ (1 : ℝ) * f i ^ (a - 1)) := by rw [Real.rpow_one, mul_assoc]
    _ = _ := by rw [← Real.rpow_add (hf i), show 1 + (a - 1) = a by ring]

/-- Logarithmic interpolation around the first moment, which is normalized to one. -/
theorem expect_power_interpolation (p : FiniteMass ι) (f : ι → ℝ) (hf : ∀ i, 0 < f i)
    (hm : p.expect f = 1) {a b : ℝ} (ha : 1 ≤ a) (hab : a ≤ b) (hb : 1 < b) :
    p.expect (fun i => f i ^ a) ≤
      (p.expect (fun i => f i ^ b)) ^ ((a - 1) / (b - 1)) := by
  let q := p.densityChange f (fun i => (hf i).le) hm
  let t := (a - 1) / (b - 1)
  have hb' : 0 < b - 1 := sub_pos.mpr hb
  have ht₀ : 0 ≤ t := div_nonneg (sub_nonneg.mpr ha) hb'.le
  have ht₁ : t ≤ 1 := (div_le_one hb').mpr (sub_le_sub_right hab 1)
  have h := moment_power_jensen q ht₀ ht₁ (fun i => f i ^ (b - 1))
    (fun i => (Real.rpow_pos_of_pos (hf i) _).le)
  have hpow (i : ι) : (f i ^ (b - 1)) ^ t = f i ^ (a - 1) := by
    rw [← Real.rpow_mul (hf i).le]
    have he : (b - 1) * t = a - 1 := mul_div_cancel₀ _ hb'.ne'
    rw [he]
  change q.expect (fun i => (f i ^ (b - 1)) ^ t) ≤
    (q.expect (fun i => f i ^ (b - 1))) ^ t at h
  simp only [hpow] at h
  rw [show q.expect (fun i => f i ^ (a - 1)) = p.expect (fun i => f i ^ a) from
    p.tilted_power f hf hm a,
    show q.expect (fun i => f i ^ (b - 1)) = p.expect (fun i => f i ^ b) from
      p.tilted_power f hf hm b] at h
  exact h

end FiniteMass

end RenyiProductOrderPhase
