import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.NormNum

namespace CommutingEffectThresholdResearchProof1

theorem coarse_score_threshold (s : ℝ) (_h₁ : 1/4 ≤ s) (h₂ : s ≤ 1) : let fine := (1-s^2)*Real.sqrt 5/10; let coarse := max fine ((1-s)*(3+8*s)/20); fine < coarse ↔ (5*Real.sqrt 5-2)/22 < s ∧ s < 1 := by
  dsimp only
  rw [lt_max_iff]
  simp only [lt_self_iff_false, false_or]
  let r := Real.sqrt 5
  let k := (5*r-2)/22
  have hsq : r^2=5 := Real.sq_sqrt (by norm_num)
  have hr : 0 ≤ r := Real.sqrt_nonneg _
  have hpos : 0 < 8-2*r := by
    by_contra! hn
    have h := sq_le_sq' (by linarith : -r ≤ (4:ℝ)) (show 4 ≤ r by linarith)
    norm_num at h
    linarith
  have hk : (8-2*r)*k=2*r-3 := by
    dsimp [k]
    nlinarith only [hsq]
  have he : (1-s)*(3+8*s)/20-(1-s^2)*r/10 =
      ((1-s)*(8-2*r)/20)*(s-k) := by
    calc
      _ = (1-s)*((8-2*r)*s-(2*r-3))/20 := by ring
      _ = _ := by rw [← hk]; ring
  change (1-s^2)*r/10 < (1-s)*(3+8*s)/20 ↔ k<s ∧ s<1
  rw [← sub_pos, he]
  rcases lt_or_eq_of_le h₂ with hs | rfl
  · have hd : 0 < (1-s)*(8-2*r)/20 := div_pos (mul_pos (sub_pos.mpr hs) hpos) (by norm_num)
    rw [mul_pos_iff_of_pos_left hd, sub_pos]
    simp [hs]
  · simp

end CommutingEffectThresholdResearchProof1
