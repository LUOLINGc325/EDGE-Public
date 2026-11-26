import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

namespace RecordConstrainedProphetGapResearchProof3

/-- Final ratio comparison for the atomless perturbation (source lines 147–154).

From `Vnew ≤ V + eta`, `M ≤ Mnew`, `M > 0` and the admissible range
`eta < (18/25)*M - V`, the perturbed ratio is strictly below `18/25`. -/
theorem perturbation_strict_ratio (V M Vnew Mnew eta : ℝ)
    (_heta : 0 < eta) (hM : 0 < M) (hroom : eta < (18 : ℝ)/25*M-V)
    (hVnew : Vnew ≤ V+eta) (hMnew : M ≤ Mnew) : Vnew/Mnew < 18/25 := by
  have hc : (0 : ℝ) < 18/25 := by norm_num
  have hMnew_pos : 0 < Mnew := lt_of_lt_of_le hM hMnew
  have hVnew_bound : Vnew < (18 : ℝ)/25*M := by linarith
  rw [div_lt_iff₀ hMnew_pos]
  have hle : (18 : ℝ)/25*M ≤ (18 : ℝ)/25*Mnew :=
    mul_le_mul_of_nonneg_left hMnew (le_of_lt hc)
  linarith

end RecordConstrainedProphetGapResearchProof3
