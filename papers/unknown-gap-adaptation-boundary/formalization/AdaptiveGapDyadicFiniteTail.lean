import Mathlib.Algebra.GeomSum
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Analysis.SpecialFunctions.Exp

namespace UnknownGapAdaptationBoundaryResearchProof2

/-- Finite geometric tail estimate after (20).

If `a 0 ≤ 1/e`, each term is at most `(2/e)` times the previous term, and
`2 < e`, then every finite partial sum `∑_{k<N} a k` (including `N = 0`) is
bounded by `1/(e - 2) = (1/e)/(1 - 2/e)`.

The nonnegativity of the terms is derived from `hstep`: since `2/e ≥ 0`, the
inequality `a (k+1) ≤ (2/e) * a k` forces `a k ≥ 0` once `a 0 ≥ 0`, and
`a 0 ≥ 0` follows from `hinit` because `1/e ≥ 0`. -/
theorem dyadic_finite_tail_bound (a : ℕ → ℝ)
    (hinit : a 0 ≤ (Real.exp 1)⁻¹)
    (hstep : ∀ k : ℕ, a (k+1) ≤ (2/Real.exp 1)*a k)
    (he : 2 < Real.exp 1) :
    ∀ N : ℕ, (∑ k ∈ Finset.range N, a k) ≤ (Real.exp 1-2)⁻¹ := by
  let e := Real.exp 1
  let q := 2/e
  have he0 : 0 < e := by dsimp [e]; positivity
  have hq0 : 0 ≤ q := by dsimp [q]; positivity
  have hq1 : q < 1 := (div_lt_one he0).mpr he
  have hmajor : ∀ k : ℕ, a k ≤ e⁻¹*q^k := by
    intro k
    induction k with
    | zero => simpa using hinit
    | succ k ih =>
      calc
        a (k+1) ≤ q*a k := hstep k
        _ ≤ q*(e⁻¹*q^k) := mul_le_mul_of_nonneg_left ih hq0
        _ = e⁻¹*q^(k+1) := by rw [pow_succ]; ring
  intro N
  have hsum : (∑ k ∈ Finset.range N, a k) ≤
      e⁻¹*(∑ k ∈ Finset.range N, q^k) := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun k _ => hmajor k
  have hgeom := geom_sum_mul_neg q N
  have hmul : (∑ k ∈ Finset.range N, q^k)*(1-q) ≤ 1 := by
    rw [hgeom]
    exact sub_le_self _ (pow_nonneg hq0 N)
  have hden : 0 < 1-q := sub_pos.mpr hq1
  have hbound : (∑ k ∈ Finset.range N, q^k) ≤ 1/(1-q) :=
    (le_div_iff₀ hden).mpr hmul
  calc
    (∑ k ∈ Finset.range N, a k) ≤ e⁻¹*(∑ k ∈ Finset.range N, q^k) := hsum
    _ ≤ e⁻¹*(1/(1-q)) := mul_le_mul_of_nonneg_left hbound (inv_nonneg.mpr he0.le)
    _ = (Real.exp 1-2)⁻¹ := by
      have he2 : e - 2 ≠ 0 := ne_of_gt (sub_pos.mpr he)
      have he' : e ≠ 0 := he0.ne'
      change e⁻¹*(1/(1-2/e)) = (e-2)⁻¹
      field_simp

end UnknownGapAdaptationBoundaryResearchProof2
