import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace GaffkeDeltaSharpBoundResearchProof1

-- Child lemma isolated from §3 of the manuscript: the natural-power inference
-- from D ≤ A·p and p^r ≤ A, with p = (1+λ)⁻¹. This is the algebra that precedes
-- taking the positive r-th root; no root/extraction step is included here.
theorem deletion_power_comparison (A D p : ℝ) (r : ℕ)
    (hD : 0 ≤ D) (hp : 0 ≤ p) (hfirst : D ≤ A*p) (hprod : p^r ≤ A) :
    D^r ≤ A^(r+1) := by
  have hAp : 0 ≤ A * p := by
    exact mul_nonneg (le_trans (pow_nonneg hp r) hprod) hp
  have hDr : D ^ r ≤ (A * p) ^ r := pow_le_pow_left₀ hD hfirst r
  have hA0 : 0 ≤ A := le_trans (pow_nonneg hp r) hprod
  have hsplit : (A * p) ^ r = A ^ r * p ^ r := by ring
  have hmul : A ^ r * p ^ r ≤ A ^ r * A :=
    mul_le_mul_of_nonneg_left hprod (pow_nonneg hA0 r)
  have hpow : A ^ r * A = A ^ (r + 1) := by ring
  calc D ^ r ≤ (A * p) ^ r := hDr
    _ = A ^ r * p ^ r := hsplit
    _ ≤ A ^ r * A := hmul
    _ = A ^ (r + 1) := hpow

end GaffkeDeltaSharpBoundResearchProof1
