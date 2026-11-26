import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace ConjugateResettingGlobalOptimalityResearchProof1

theorem positive_ratio_equality (fx fy gx gy K : ℝ) (hx : 0 < fx) (hy : 0 < fy) (hgx : 0 < gx) (hgy : 0 < gy) (hK : 0 < K) : K*(gx*fy-gy*fx)^2/(fx*fy) = 0 ↔ fx/gx=fy/gy := by
  have hden : fx*fy ≠ 0 := mul_ne_zero hx.ne' hy.ne'
  constructor
  · intro h
    have hnum : K*(gx*fy-gy*fx)^2 = 0 := by
      simpa using (div_eq_iff hden).mp h
    have hsq : (gx*fy-gy*fx)^2 = 0 := (mul_eq_zero.mp hnum).resolve_left hK.ne'
    have hlin : gx*fy-gy*fx = 0 := by
      rw [pow_two] at hsq
      exact (mul_eq_zero.mp hsq).elim id id
    rw [div_eq_div_iff hgx.ne' hgy.ne']
    nlinarith only [hlin]
  · intro h
    have hcross := (div_eq_div_iff hgx.ne' hgy.ne').mp h
    have he : gx*fy-gy*fx=0 := by nlinarith only [hcross]
    simp [he]

end ConjugateResettingGlobalOptimalityResearchProof1
