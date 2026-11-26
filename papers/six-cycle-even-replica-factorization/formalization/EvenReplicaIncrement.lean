import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Lean.Elab.Tactic.Omega

/-!
Section 6 of the manuscript: for `r ≥ 3` the coefficient polynomial
`128r^7 + 224r^6 - 736r^5 - 1000r^4 + 192r^3 + 640r^2 + 288r + 41`
is strictly positive.  This is the algebraic core of the strict increase
`S_{2r+1} > S_{2r}` (the denominator `8r^4(2r-1)(2r+1)^4` is positive).
We prove the positivity by the manuscript's pairing argument.
-/

namespace SixCycleEvenReplicaFactorization

/-- The numerator polynomial appearing in the adjacent difference
`S_{2r+1} - S_{2r}` (Section 6, displayed formula), regrouped exactly as in
the manuscript: `r^5(128r^2 - 736) + r^4(224r^2 - 1000) + (192r^3 + ... )`. -/
theorem num_pos (r : ℝ) (hr : 3 ≤ r) :
    0 < 128*r^7 + 224*r^6 - 736*r^5 - 1000*r^4
        + 192*r^3 + 640*r^2 + 288*r + 41 := by
  have h1 : (0 : ℝ) < r^5 * (128*r^2 - 736) := by
    have : (0:ℝ) < 128*r^2 - 736 := by nlinarith
    have : (0:ℝ) < r^5 := by positivity
    exact mul_pos this ‹0 < 128*r^2 - 736›
  have h2 : (0 : ℝ) < r^4 * (224*r^2 - 1000) := by
    have : (0:ℝ) < 224*r^2 - 1000 := by nlinarith
    have : (0:ℝ) < r^4 := by positivity
    exact mul_pos this ‹0 < 224*r^2 - 1000›
  have h3 : (0 : ℝ) < 192*r^3 + 640*r^2 + 288*r + 41 := by
    have h192 : (0:ℝ) ≤ 192*r^3 := by positivity
    have h640 : (0:ℝ) ≤ 640*r^2 := by positivity
    have h288 : (0:ℝ) ≤ 288*r := by positivity
    linarith
  have key : 128*r^7 + 224*r^6 - 736*r^5 - 1000*r^4
        + 192*r^3 + 640*r^2 + 288*r + 41
      = r^5 * (128*r^2 - 736) + r^4 * (224*r^2 - 1000)
        + (192*r^3 + 640*r^2 + 288*r + 41) := by ring
  rw [key]
  linarith

/-- The full adjacent-difference ratio is positive: numerator positive and
denominator `8 r^4 (2r-1)(2r+1)^4` positive for `r ≥ 3`.
This is the precise monotonicity statement `S_{2r+1} > S_{2r}`. -/
theorem difference_pos (r : ℝ) (hr : 3 ≤ r) :
    0 < (128*r^7 + 224*r^6 - 736*r^5 - 1000*r^4
        + 192*r^3 + 640*r^2 + 288*r + 41)
      / (8*r^4*(2*r - 1)*(2*r + 1)^4) := by
  have hnum := num_pos r hr
  have hrpos : (0:ℝ) < r := by linarith
  have hd1 : (0:ℝ) < 8*r^4 := by positivity
  have hd2 : (0:ℝ) < 2*r - 1 := by nlinarith
  have hd3 : (0:ℝ) < (2*r + 1)^4 := by positivity
  have hden : (0:ℝ) < 8*r^4*(2*r - 1)*(2*r + 1)^4 := by positivity
  exact div_pos hnum hden

end SixCycleEvenReplicaFactorization
