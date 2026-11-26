import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace SwapRoundingMinimalFailures

/-- The first-branch contribution to inclusion of label 1 in the U(2,5) example. -/
noncomputable def U25LabelOne (a b : ℝ) : ℝ :=
  (a/(a+b))*(a+b)

/-- The second-branch contribution to failure of F = X₂ ∨ X₅. -/
noncomputable def U25Failure (a b c : ℝ) : ℝ :=
  (b/(a+b))*c*(a+b)

theorem U25_marginals {a b : ℝ} (ha : 0 < a) (hb : 0 < b) (c : ℝ) :
    U25LabelOne a b = a ∧ U25Failure a b c = b*c := by
  have hd : a+b ≠ 0 := (add_pos ha hb).ne'
  constructor
  · unfold U25LabelOne
    field_simp [hd]
  · unfold U25Failure
    field_simp [hd]

/-- If label 1 occurs, F occurs. The joint mass equals the label-one mass,
so subtracting the product of marginals gives the exact covariance. -/
theorem U25_covariance {a b c : ℝ} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
    U25LabelOne a b - U25LabelOne a b * (1-U25Failure a b c) = a*b*c ∧
    0 < U25LabelOne a b - U25LabelOne a b * (1-U25Failure a b c) := by
  rcases U25_marginals ha hb c with ⟨h₁,h₂⟩
  rw [h₁,h₂]
  have heq : a-a*(1-b*c)=a*b*c := by ring
  exact ⟨heq, heq ▸ mul_pos (mul_pos ha hb) hc⟩

end SwapRoundingMinimalFailures
