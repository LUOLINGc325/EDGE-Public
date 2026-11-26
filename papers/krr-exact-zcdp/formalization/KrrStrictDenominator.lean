import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace KrrExactZcdpResearchProof1

/-- The curvature denominator `B(t) = t * cosh t - sinh t` is positive for `t > 0`.

This is the denominator part of Lemma 1 of the manuscript. Write `B = f - g` with
`f(t) = t * cosh t` and `g(t) = sinh t`. Then `B(0) = 0` and, by the mean value
theorem, `B(t) = B(t) - B(0) = B'(ξ) * t` for some `ξ ∈ (0, t)`. Since
`B'(ξ) = ξ * sinh ξ > 0` for `ξ > 0`, and `t > 0`, we get `B(t) > 0`. -/
theorem positive_curvature_denominator (t : ℝ) (ht : 0 < t) : 0 < t*Real.cosh t-Real.sinh t := by
  -- Define B(t) = t * cosh t - sinh t.
  set B : ℝ → ℝ := fun s => s * Real.cosh s - Real.sinh s with hB
  -- Derivatives: (s * cosh s)' = cosh s + s * sinh s, and (sinh s)' = cosh s.
  have hderiv : ∀ s : ℝ, HasDerivAt B (s * Real.sinh s) s := by
    intro s
    have h1 : HasDerivAt (fun s : ℝ => s * Real.cosh s)
        (Real.cosh s + s * Real.sinh s) s := by
      have := (hasDerivAt_id s).mul (Real.hasDerivAt_cosh s)
      simpa [one_mul, mul_comm, mul_left_comm, mul_assoc] using this
    have h2 : HasDerivAt Real.sinh (Real.cosh s) s := Real.hasDerivAt_sinh s
    have := h1.sub h2
    convert this using 1
    ring
  -- B(0) = 0.
  have hB0 : B 0 = 0 := by simp [hB]
  have hcont : ContinuousOn B (Set.Icc 0 t) :=
    fun x _ => (hderiv x).continuousAt.continuousWithinAt
  obtain ⟨ξ, hξ, hξeq⟩ :=
    exists_hasDerivAt_eq_slope B (fun x => x*Real.sinh x) ht hcont (fun x _ => hderiv x)
  have hpos : 0 < ξ*Real.sinh ξ := mul_pos hξ.1 (Real.sinh_pos_iff.mpr hξ.1)
  rw [hB0, sub_zero, sub_zero] at hξeq
  rw [hξeq] at hpos
  exact (div_pos_iff.mp hpos).elim And.left (fun hn => False.elim ((not_lt_of_ge ht.le) hn.2))

end KrrExactZcdpResearchProof1
