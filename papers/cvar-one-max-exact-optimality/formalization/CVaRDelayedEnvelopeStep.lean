import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

universe u
namespace CvarOneMaxExactOptimalityResearchProof1

theorem delayed_envelope_step (a h delta : ℝ) (k : ℕ) (q phi : ℝ → ℝ)
         (ha : 0 ≤ a) (hh : 0 < h) (hd : 0 < delta)
         (iq : ∀ b : ℝ, IntervalIntegrable (fun s => q s-1) MeasureTheory.volume 0 b)
         (iphi : ∀ b : ℝ, IntervalIntegrable (fun s => phi s-1) MeasureTheory.volume 0 b)
         (previous : ∀ t : ℝ, 0 < t → t ≤ min 1 ((k:ℝ)*delta) → q t ≤ phi t)
         (qrec : ∀ t : ℝ, 0 < t → t ≤ 1 → q t ≤ a*(1+(∫ s in (0:ℝ)..max 0 (t-delta), q s-1)/h))
         (phirec : ∀ t : ℝ, 0 < t → t ≤ 1 → phi t = a*(1+(∫ s in (0:ℝ)..max 0 (t-delta), phi s-1)/h)) :
         ∀ t : ℝ, 0 < t → t ≤ min 1 (((k:ℝ)+1)*delta) → q t ≤ phi t := by
  intro t ht htk
  have ht1 := htk.trans (min_le_left _ _)
  have htk' := htk.trans (min_le_right _ _)
  have hkd : 0 ≤ (k:ℝ)*delta := mul_nonneg (Nat.cast_nonneg _) hd.le
  have htop : max 0 (t-delta) ≤ min 1 ((k:ℝ)*delta) := by
    apply le_min
    · exact max_le zero_le_one (by linarith only [ht1,hd])
    · exact max_le hkd (by linarith only [htk'])
  have hi : (∫ s in (0:ℝ)..max 0 (t-delta), q s-1) ≤
      (∫ s in (0:ℝ)..max 0 (t-delta), phi s-1) := by
    apply intervalIntegral.integral_mono_on_of_le_Ioo (le_max_left (0:ℝ) _)
      (iq _) (iphi _)
    intro s hs
    exact sub_le_sub_right (previous s hs.1 (hs.2.le.trans htop)) 1
  calc
    q t ≤ a*(1+(∫ s in (0:ℝ)..max 0 (t-delta), q s-1)/h) := qrec t ht ht1
    _ ≤ a*(1+(∫ s in (0:ℝ)..max 0 (t-delta), phi s-1)/h) :=
      mul_le_mul_of_nonneg_left (add_le_add_left (div_le_div_of_nonneg_right hi hh.le) 1) ha
    _ = phi t := (phirec t ht ht1).symm

end CvarOneMaxExactOptimalityResearchProof1
