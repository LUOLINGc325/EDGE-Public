import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum

namespace FixedAngleMbqcUnitaryDesignResearchProof1

theorem negative_rotation_root (p : ℝ) (hp : 2 ≤ p) : let c:=2*(p^2-1)/(2*p-1); let x:=c/(p+Real.sqrt (p^2-(p-2)*c)); 0 < x ∧ x < 1 ∧ (p-2)*x^2-2*p*x+c=0 := by
  intro c x
  have h₁ : 0 < 2*p-1 := by linarith
  have hp0 : 0 < p := by linarith
  have hc : 0 < c := by
    apply div_pos _ h₁
    nlinarith [sq_nonneg (p-2)]
  have hc' : c < p+2 := by
    apply (div_lt_iff₀ h₁).2
    linarith only [hp0, show (p+2)*(2*p-1)-2*(p^2-1)=3*p by ring]
  let D := p^2-(p-2)*c
  let s := Real.sqrt D
  have hd : (c-p)^2 < D := by
    have h := mul_pos hc (sub_pos.mpr hc')
    dsimp [D]
    nlinarith only [h]
  have hD : 0 ≤ D := (sq_nonneg (c-p)).trans hd.le
  have hdens : 0 < p+s := add_pos_of_pos_of_nonneg hp0 (Real.sqrt_nonneg _)
  have hs : s^2=D := Real.sq_sqrt hD
  have hcs : c-p < s := by
    by_contra! h
    have hsq := sq_le_sq' (by linarith [Real.sqrt_nonneg D] : -(c-p) ≤ s) h
    linarith only [hsq,hs,hd]
  change 0 < c/(p+s) ∧ c/(p+s) < 1 ∧ (p-2)*(c/(p+s))^2-2*p*(c/(p+s))+c=0
  refine ⟨div_pos hc hdens, (div_lt_one hdens).2 (by linarith), ?_⟩
  have hcancel : (p-2)*c-2*p*(p+s)+(p+s)^2=0 := by
    dsimp [D] at hs
    nlinarith only [hs]
  calc
    _ = c*((p-2)*c-2*p*(p+s)+(p+s)^2)/(p+s)^2 := by
      field_simp [hdens.ne']
      ring
    _ = 0 := by rw [hcancel, mul_zero, zero_div]

end FixedAngleMbqcUnitaryDesignResearchProof1
