import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

universe u
namespace CiScoreQuadraticRigidityResearchProof1

theorem negative_harmonic_threshold (a H : ℝ) (ha : 0 < a) (hH : 0 < H) :
         (∃ ell : ℝ, ∀ t : ℝ, ell ≤ -a*t^2+H*(1-t)^2) ↔ a < H := by
  constructor
  · rintro ⟨ell, hell⟩
    by_contra hlt
    let t : ℝ := (H-ell+1)/(2*H)
    have ht : 2*H*t = H-ell+1 := by
      dsimp [t]
      field_simp [ne_of_gt hH]
    have htail := mul_nonpos_of_nonpos_of_nonneg
      (sub_nonpos.mpr (le_of_not_gt hlt)) (sq_nonneg t)
    nlinarith only [hell t, ht, htail]
  · intro hlt
    have hHp : 0 < H := lt_trans ha hlt
    have hdiff : 0 < H-a := sub_pos.mpr hlt
    refine ⟨-(H^2/(H-a)), ?_⟩
    intro t
    have hsplit :
        -a*t^2+H*(1-t)^2 = (H-a)*(t-H/(H-a))^2+H-H^2/(H-a) := by
      field_simp [ne_of_gt hdiff]
      ring
    rw [hsplit]
    linarith only [mul_nonneg hdiff.le (sq_nonneg (t-H/(H-a))), hHp, hH]

end CiScoreQuadraticRigidityResearchProof1
