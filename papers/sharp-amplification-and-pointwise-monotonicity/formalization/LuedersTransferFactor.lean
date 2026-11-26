import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace SharpAmplificationAndPointwiseMonotonicityResearchProof1

/-- Final scalar step of Theorem 1, equation (4).

`E` is the fine total `∑ η_i`, `Ep` the coarse total `∑ η_G'`,
`F` the fine score `T_ρ(A,B)`, `C` the coarse score `T_ρ(\bar A,B)`,
and `S` the column absolute-sum `∑_j |v_j|`.

From the two column bounds of the proof,
* `(E/2) * S ≤ F`  (column triangle inequality for the fine score),
* `C ≤ F + ((E - Ep)/2) * S`  (aggregation plus subadditivity plus (3)),

we obtain `C ≤ (2 - Ep/E) * F ≤ 2 * F`. -/
theorem transfer_factor (E Ep F C S : ℝ) (hE : 0 < E) (hEp : 0 ≤ Ep) (hle : Ep ≤ E)
    (hS : 0 ≤ S) (hF : E/2*S ≤ F) (hC : C ≤ F+(E-Ep)/2*S) :
    C ≤ (2-Ep/E)*F ∧ (2-Ep/E)*F ≤ 2*F := by
  have hcoef : 0 ≤ (E - Ep) / E := div_nonneg (sub_nonneg.mpr hle) hE.le
  have hF0 : 0 ≤ F := (mul_nonneg (div_nonneg hE.le (by norm_num)) hS).trans hF
  have hterm := mul_le_mul_of_nonneg_left hF hcoef
  have hleft : (E-Ep)/E*(E/2*S) = (E-Ep)/2*S := by
    field_simp
    ring
  rw [hleft] at hterm
  have hright : F+(E-Ep)/E*F = (2-Ep/E)*F := by field_simp; ring
  constructor
  · rw [← hright]
    linarith
  · apply mul_le_mul_of_nonneg_right _ hF0
    linarith [div_nonneg hEp hE.le]

end SharpAmplificationAndPointwiseMonotonicityResearchProof1
